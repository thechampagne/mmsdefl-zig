// Copyright 2023 XXIV
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
pub const SDEFL_MAX_OFF = @as(c_int, 1) << @as(c_int, 15);
pub const SDEFL_WIN_SIZ = SDEFL_MAX_OFF;
pub const SDEFL_WIN_MSK = SDEFL_WIN_SIZ - @as(c_int, 1);
pub const SDEFL_HASH_BITS = @as(c_int, 15);
pub const SDEFL_HASH_SIZ = @as(c_int, 1) << SDEFL_HASH_BITS;
pub const SDEFL_HASH_MSK = SDEFL_HASH_SIZ - @as(c_int, 1);
pub const SDEFL_MIN_MATCH = @as(c_int, 4);
pub const SDEFL_BLK_MAX = @as(c_int, 256) * @as(c_int, 1024);
pub const SDEFL_SEQ_SIZ = (SDEFL_BLK_MAX + SDEFL_MIN_MATCH) / SDEFL_MIN_MATCH;
pub const SDEFL_SYM_MAX = @as(c_int, 288);
pub const SDEFL_OFF_MAX = @as(c_int, 32);
pub const SDEFL_PRE_MAX = @as(c_int, 19);
pub const SDEFL_LVL_MIN = @as(c_int, 0);
pub const SDEFL_LVL_DEF = @as(c_int, 5);
pub const SDEFL_LVL_MAX = @as(c_int, 8);

pub const sdefl_freq = extern struct {
    lit: [SDEFL_SYM_MAX]c_uint,
    off: [SDEFL_OFF_MAX]c_uint,
};

pub const sdefl_code_words = extern struct {
    lit: [SDEFL_SYM_MAX]c_uint,
    off: [SDEFL_OFF_MAX]c_uint,
};

pub const sdefl_lens = extern struct {
    lit: [SDEFL_SYM_MAX]u8,
    off: [SDEFL_OFF_MAX]u8,
};

pub const sdefl_codes = extern struct {
    word: sdefl_code_words,
    len: sdefl_lens,
};

pub const sdefl_seqt = extern struct {
    off: c_int,
    len: c_int,
};

pub const sdefl = extern struct {
    bits: c_int,
    bitcnt: c_int,
    tbl: [SDEFL_HASH_SIZ]c_int,
    prv: [SDEFL_WIN_SIZ]c_int,
    seq_cnt: c_int,
    seq: [SDEFL_SEQ_SIZ]sdefl_seqt,
    freq: sdefl_freq,
    cod: sdefl_codes,
};

pub extern "C" fn sdefl_bound(in_len: c_int) c_int;
pub extern "C" fn sdeflate(s: [*c]sdefl, o: ?*anyopaque, i: ?*const anyopaque, n: c_int, lvl: c_int) c_int;
pub extern "C" fn zsdeflate(s: [*c]sdefl, o: ?*anyopaque, i: ?*const anyopaque, n: c_int, lvl: c_int) c_int;
