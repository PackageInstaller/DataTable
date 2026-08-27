local __rt_1 = {}
local __rt_2 = {6}
local __rt_3 = {0}
local __rt_4 = {29}
local __rt_5 = {301806}
local __rt_6 = {301806003}
local __rt_7 = {301806006}
local __rt_8 = {301808}
local __rt_9 = {302606}
local __rt_10 = {303708}
local __rt_11 = {304607}
local __rt_12 = {305804}
local __rt_13 = {305805}
local __rt_14 = {306103}
local __rt_15 = {307104}
local __rt_16 = {307202}
local __rt_17 = {307203}
local audio_voice = {
  {
    describe = 379491,
    exclusive_hero = 0,
    is_show = 1,
    name = "MORNING",
    pre_condition = __rt_1
  },
  {
    describe = 350428,
    exclusive_hero = 0,
    id = 2,
    is_show = 2,
    name = "AFTERNOON",
    pre_condition = __rt_1
  },
  {
    describe = 474134,
    exclusive_hero = 0,
    id = 3,
    is_show = 3,
    name = "EVENING",
    pre_condition = __rt_1
  },
  {
    describe = 423077,
    exclusive_hero = 0,
    id = 4,
    is_show = 4,
    name = "MIDNIGHT",
    pre_condition = __rt_1
  },
  {
    describe = 307943,
    exclusive_hero = 0,
    id = 5,
    is_show = 5,
    name = "DIALOGUE1",
    pre_condition = __rt_1
  },
  {
    describe = 113172,
    exclusive_hero = 0,
    id = 6,
    is_show = 6,
    name = "DIALOGUE2",
    pre_condition = __rt_1
  },
  {
    describe = "DIALOGUE3",
    exclusive_hero = 0,
    id = 7,
    name = "DIALOGUE3",
    pre_condition = __rt_1
  },
  {
    describe = 442689,
    exclusive_hero = 0,
    id = 8,
    is_show = 7,
    name = "DIALOGUE4",
    pre_condition = __rt_1
  },
  {
    describe = "DIALOGUE5",
    exclusive_hero = 0,
    id = 9,
    name = "DIALOGUE5",
    pre_condition = __rt_1
  },
  {
    describe = 427119,
    exclusive_hero = 0,
    id = 10,
    is_show = 8,
    name = "INTERACT1",
    pre_condition = __rt_1
  },
  {
    describe = 232348,
    exclusive_hero = 0,
    id = 11,
    is_show = 9,
    name = "INTERACT2",
    pre_condition = __rt_1
  },
  {
    describe = 37577,
    exclusive_hero = 0,
    id = 12,
    is_show = 10,
    name = "INTERACT3",
    pre_condition = __rt_1
  },
  {
    describe = 246159,
    exclusive_hero = 0,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 13,
    is_show = 142,
    name = "NEWYEAR",
    pre_condition = __rt_1
  },
  {
    describe = 392395,
    exclusive_hero = 0,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 14,
    is_show = 143,
    name = "VALENTINE",
    pre_condition = __rt_1
  },
  {
    describe = 267178,
    exclusive_hero = 0,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 15,
    is_show = 144,
    name = "TANABATA",
    pre_condition = __rt_1
  },
  {
    describe = 174486,
    exclusive_hero = 0,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 16,
    is_show = 145,
    name = "ALLHALLOWS",
    pre_condition = __rt_1
  },
  {
    describe = 259212,
    exclusive_hero = 0,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 17,
    is_show = 146,
    name = "CHRISTMAS",
    pre_condition = __rt_1
  },
  {
    describe = 410875,
    exclusive_hero = 0,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 18,
    is_show = 147,
    name = "PLAYERBIRTHDAY",
    pre_condition = __rt_1
  },
  {
    describe = 367094,
    exclusive_hero = 0,
    id = 19,
    name = "INTERACT4",
    pre_condition = __rt_1
  },
  [101] = {
    exclusive_hero = 0,
    id = 101,
    is_show = 11,
    name = "GAIN",
    pre_condition = __rt_1
  },
  [102] = {
    describe = 62926,
    exclusive_hero = 0,
    id = 102,
    is_show = 12,
    name = "LEVELUP",
    pre_condition = __rt_1
  },
  [103] = {
    describe = 432664,
    exclusive_hero = 0,
    id = 103,
    is_show = 13,
    name = "RANKUP",
    pre_condition = __rt_1
  },
  [104] = {
    describe = "RANKMAX",
    exclusive_hero = 0,
    id = 104,
    name = "RANKMAX",
    pre_condition = __rt_1
  },
  [105] = {
    describe = 343117,
    exclusive_hero = 0,
    id = 105,
    is_show = 14,
    name = "FORMATION",
    pre_condition = __rt_1
  },
  [106] = {
    describe = 382310,
    exclusive_hero = 0,
    id = 106,
    is_show = 15,
    name = "BATTLE",
    pre_condition = __rt_1
  },
  [107] = {
    describe = 53739,
    exclusive_hero = 0,
    id = 107,
    is_show = 16,
    name = "SKILL",
    pre_condition = __rt_1
  },
  [108] = {
    describe = "MVP1",
    exclusive_hero = 0,
    id = 108,
    is_show = 17,
    name = "MVP1",
    pre_condition = __rt_1
  },
  [109] = {
    describe = "MVP2",
    exclusive_hero = 0,
    id = 109,
    is_show = 18,
    name = "MVP2",
    pre_condition = __rt_1
  },
  [110] = {
    describe = "DUTY",
    exclusive_hero = 0,
    id = 110,
    name = "DUTY",
    pre_condition = __rt_1
  },
  [111] = {
    describe = 214099,
    exclusive_hero = 0,
    id = 111,
    is_show = 19,
    name = "RETREAT",
    pre_condition = __rt_1
  },
  [112] = {
    describe = 54720,
    exclusive_hero = 0,
    id = 112,
    name = "RELATIONSHIP1",
    pre_condition = __rt_2,
    pre_para1 = __rt_3,
    pre_para2 = __rt_2
  },
  [113] = {
    describe = 384237,
    exclusive_hero = 0,
    id = 113,
    name = "RELATIONSHIP2",
    pre_condition = __rt_2,
    pre_para1 = __rt_3,
    pre_para2 = {7}
  },
  [114] = {
    describe = 189466,
    exclusive_hero = 0,
    id = 114,
    name = "RELATIONSHIP3",
    pre_condition = __rt_2,
    pre_para1 = __rt_3,
    pre_para2 = {8}
  },
  [115] = {
    describe = 518983,
    exclusive_hero = 0,
    id = 115,
    name = "RELATIONSHIP4",
    pre_condition = __rt_2,
    pre_para1 = __rt_3,
    pre_para2 = {9}
  },
  [116] = {
    describe = 324212,
    exclusive_hero = 0,
    id = 116,
    name = "RELATIONSHIP5",
    pre_condition = __rt_2,
    pre_para1 = __rt_3,
    pre_para2 = {10}
  },
  [117] = {
    describe = 188681,
    exclusive_hero = 0,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 117,
    is_show = 148,
    name = "OATH",
    pre_condition = __rt_1
  },
  [118] = {
    describe = 120297,
    exclusive_hero = 0,
    id = 118,
    is_show = 20,
    name = "TITLE",
    pre_condition = __rt_1
  },
  [140] = {
    describe = 319339,
    exclusive_hero = 0,
    id = 140,
    name = "ACCEPT",
    pre_condition = __rt_1
  },
  [141] = {
    describe = 450835,
    exclusive_hero = 0,
    id = 141,
    name = "AGREE",
    pre_condition = __rt_1
  },
  [142] = {
    describe = 308809,
    exclusive_hero = 0,
    id = 142,
    name = "APPRECIATE",
    pre_condition = __rt_1
  },
  [143] = {
    describe = 443615,
    exclusive_hero = 0,
    id = 143,
    name = "FEELING",
    pre_condition = __rt_1
  },
  [144] = {
    describe = 448691,
    exclusive_hero = 0,
    id = 144,
    name = "LOWMOOD",
    pre_condition = __rt_1
  },
  [145] = {
    describe = 461636,
    exclusive_hero = 0,
    id = 145,
    name = "MOOD1",
    pre_condition = __rt_1
  },
  [146] = {
    describe = 108415,
    exclusive_hero = 0,
    id = 146,
    name = "MOOD2",
    pre_condition = __rt_1
  },
  [147] = {
    describe = 296045,
    exclusive_hero = 0,
    id = 147,
    name = "MOOD3",
    pre_condition = __rt_1
  },
  [148] = {
    describe = 101274,
    exclusive_hero = 0,
    id = 148,
    name = "MOOD4",
    pre_condition = __rt_1
  },
  [149] = {
    describe = 430791,
    exclusive_hero = 0,
    id = 149,
    name = "MOOD5",
    pre_condition = __rt_1
  },
  [201] = {
    describe = "Live2D",
    exclusive_hero = 0,
    id = 201,
    pre_condition = __rt_1
  },
  [202] = {
    describe = "Live2D1",
    exclusive_hero = 0,
    id = 202,
    name = "L2D1",
    pre_condition = __rt_1
  },
  [203] = {
    describe = "Live2D2",
    exclusive_hero = 0,
    id = 203,
    name = "L2D2",
    pre_condition = __rt_1
  },
  [204] = {
    describe = "Live2D3",
    exclusive_hero = 0,
    id = 204,
    name = "L2D3",
    pre_condition = __rt_1
  },
  [205] = {
    describe = "Live2D4",
    exclusive_hero = 0,
    id = 205,
    name = "L2D4",
    pre_condition = __rt_1
  },
  [206] = {
    describe = "Live2D5",
    exclusive_hero = 0,
    id = 206,
    name = "L2D5",
    pre_condition = __rt_1
  },
  [1059001] = {
    describe = 92045,
    exclusive_hero = 1059,
    id = 1059001,
    is_show = 21,
    name = "MORNING_2",
    pre_condition = __rt_1
  },
  [1059002] = {
    describe = 361744,
    exclusive_hero = 1059,
    id = 1059002,
    is_show = 22,
    name = "AFTERNOON_2",
    pre_condition = __rt_1
  },
  [1059003] = {
    describe = 343982,
    exclusive_hero = 1059,
    id = 1059003,
    is_show = 23,
    name = "EVENING_2",
    pre_condition = __rt_1
  },
  [1059004] = {
    describe = 148995,
    exclusive_hero = 1059,
    id = 1059004,
    is_show = 24,
    name = "MIDNIGHT_2",
    pre_condition = __rt_1
  },
  [1059005] = {
    describe = 49273,
    exclusive_hero = 1059,
    id = 1059005,
    is_show = 25,
    name = "DIALOGUE1_2",
    pre_condition = __rt_1
  },
  [1059006] = {
    describe = 446456,
    exclusive_hero = 1059,
    id = 1059006,
    is_show = 26,
    name = "DIALOGUE2_2",
    pre_condition = __rt_1
  },
  [1059007] = {
    describe = 295949,
    exclusive_hero = 1059,
    id = 1059007,
    name = "DIALOGUE3_2",
    pre_condition = __rt_1
  },
  [1059008] = {
    describe = 319351,
    exclusive_hero = 1059,
    id = 1059008,
    is_show = 27,
    name = "DIALOGUE4_2",
    pre_condition = __rt_1
  },
  [1059009] = {
    describe = 41739,
    exclusive_hero = 1059,
    id = 1059009,
    name = "DIALOGUE5_2",
    pre_condition = __rt_1
  },
  [1059010] = {
    describe = 122833,
    exclusive_hero = 1059,
    id = 1059010,
    is_show = 28,
    name = "INTERACT1_2",
    pre_condition = __rt_1
  },
  [1059011] = {
    describe = 520016,
    exclusive_hero = 1059,
    id = 1059011,
    is_show = 29,
    name = "INTERACT2_2",
    pre_condition = __rt_1
  },
  [1059012] = {
    describe = 392911,
    exclusive_hero = 1059,
    id = 1059012,
    is_show = 30,
    name = "INTERACT3_2",
    pre_condition = __rt_1
  },
  [1059013] = {
    describe = 305713,
    exclusive_hero = 1059,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 1059013,
    is_show = 172,
    name = "NEWYEAR_2",
    pre_condition = __rt_1
  },
  [1059014] = {
    describe = 517765,
    exclusive_hero = 1059,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 1059014,
    is_show = 173,
    name = "VALENTINE_2",
    pre_condition = __rt_1
  },
  [1059015] = {
    describe = 383818,
    exclusive_hero = 1059,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 1059015,
    is_show = 174,
    name = "TANABATA_2",
    pre_condition = __rt_1
  },
  [1059016] = {
    describe = 388142,
    exclusive_hero = 1059,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 1059016,
    is_show = 175,
    name = "ALLHALLOWS_2",
    pre_condition = __rt_1
  },
  [1059017] = {
    describe = 259232,
    exclusive_hero = 1059,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 1059017,
    is_show = 176,
    name = "CHRISTMAS_2",
    pre_condition = __rt_1
  },
  [1059018] = {
    describe = 190357,
    exclusive_hero = 1059,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 1059018,
    is_show = 177,
    name = "PLAYERBIRTHDAY_2",
    pre_condition = __rt_1
  },
  [1059102] = {
    describe = 475158,
    exclusive_hero = 1059,
    id = 1059102,
    is_show = 32,
    name = "LEVELUP_2",
    pre_condition = __rt_1
  },
  [1059103] = {
    describe = 189284,
    exclusive_hero = 1059,
    id = 1059103,
    is_show = 33,
    name = "RANKUP_2",
    pre_condition = __rt_1
  },
  [1059104] = {
    describe = 69904,
    exclusive_hero = 1059,
    id = 1059104,
    name = "RANKMAX_2",
    pre_condition = __rt_1
  },
  [1059105] = {
    describe = 357051,
    exclusive_hero = 1059,
    id = 1059105,
    is_show = 34,
    name = "FORMATION_2",
    pre_condition = __rt_1
  },
  [1059106] = {
    describe = 461379,
    exclusive_hero = 1059,
    id = 1059106,
    is_show = 35,
    name = "BATTLE_2",
    pre_condition = __rt_1
  },
  [1059107] = {
    describe = 243941,
    exclusive_hero = 1059,
    id = 1059107,
    is_show = 36,
    name = "SKILL_2",
    pre_condition = __rt_1
  },
  [1059108] = {
    describe = 201350,
    exclusive_hero = 1059,
    id = 1059108,
    is_show = 37,
    name = "MVP1_2",
    pre_condition = __rt_1
  },
  [1059109] = {
    describe = 74245,
    exclusive_hero = 1059,
    id = 1059109,
    is_show = 38,
    name = "MVP2_2",
    pre_condition = __rt_1
  },
  [1059110] = {
    describe = 462014,
    exclusive_hero = 1059,
    id = 1059110,
    name = "DUTY_2",
    pre_condition = __rt_1
  },
  [1059118] = {
    describe = 125743,
    exclusive_hero = 1059,
    id = 1059118,
    is_show = 40,
    name = "TITLE_2",
    pre_condition = __rt_1
  },
  [1059140] = {
    describe = 345445,
    exclusive_hero = 1059,
    id = 1059140,
    name = "ACCEPT_2",
    pre_condition = __rt_1
  },
  [1059141] = {
    describe = 200733,
    exclusive_hero = 1059,
    id = 1059141,
    name = "AGREE_2",
    pre_condition = __rt_1
  },
  [1059142] = {
    describe = 154959,
    exclusive_hero = 1059,
    id = 1059142,
    name = "APPRECIATE_2",
    pre_condition = __rt_1
  },
  [1059143] = {
    describe = 343969,
    exclusive_hero = 1059,
    id = 1059143,
    name = "FEELING_2",
    pre_condition = __rt_1
  },
  [1059144] = {
    describe = 91645,
    exclusive_hero = 1059,
    id = 1059144,
    name = "LOWMOOD_2",
    pre_condition = __rt_1
  },
  [1059145] = {
    describe = 295944,
    exclusive_hero = 1059,
    id = 1059145,
    name = "MOOD1_2",
    pre_condition = __rt_1
  },
  [1059146] = {
    describe = 433793,
    exclusive_hero = 1059,
    id = 1059146,
    name = "MOOD2_2",
    pre_condition = __rt_1
  },
  [301806001] = {
    describe = 379491,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806001,
    is_show = 54,
    name = "NEWYEAR_MORNING",
    pre_para1 = __rt_5,
    pre_para2 = __rt_6
  },
  [301806003] = {
    describe = 474134,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806003,
    is_show = 55,
    name = "NEWYEAR_EVENING",
    pre_para1 = __rt_5,
    pre_para2 = __rt_6
  },
  [301806004] = {
    describe = 423077,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806004,
    is_show = 56,
    name = "NEWYEAR_MIDNIGHT",
    pre_para1 = __rt_5,
    pre_para2 = __rt_6
  },
  [301806005] = {
    describe = 307943,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806005,
    is_show = 57,
    name = "NEWYEAR_DIALOGUE1",
    pre_para1 = __rt_5,
    pre_para2 = {301806005}
  },
  [301806006] = {
    describe = 113172,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806006,
    is_show = 58,
    name = "NEWYEAR_DIALOGUE2",
    pre_para1 = __rt_5,
    pre_para2 = __rt_7
  },
  [301806008] = {
    describe = 442689,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806008,
    is_show = 59,
    name = "NEWYEAR_DIALOGUE4",
    pre_para1 = __rt_5,
    pre_para2 = __rt_7
  },
  [301806010] = {
    describe = 427119,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806010,
    is_show = 60,
    name = "NEWYEAR_INTERACT1",
    pre_para1 = __rt_5,
    pre_para2 = {301806010}
  },
  [301806011] = {
    describe = 232348,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806011,
    is_show = 61,
    name = "NEWYEAR_INTERACT2",
    pre_para1 = __rt_5,
    pre_para2 = {301806011}
  },
  [301806012] = {
    describe = 37577,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806012,
    is_show = 62,
    name = "NEWYEAR_INTERACT3",
    pre_para1 = __rt_5,
    pre_para2 = {301806012}
  },
  [301806101] = {
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806101,
    is_show = 63,
    name = "NEWYEAR_GAIN",
    pre_para1 = __rt_5,
    pre_para2 = {301806101}
  },
  [301806105] = {
    describe = 343117,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806105,
    is_show = 64,
    name = "NEWYEAR_FORMATION",
    pre_para1 = __rt_5,
    pre_para2 = {301806105}
  },
  [301806106] = {
    describe = 382310,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806106,
    is_show = 65,
    name = "NEWYEAR_BATTLE",
    pre_para1 = __rt_5,
    pre_para2 = {301806106}
  },
  [301806107] = {
    describe = 53739,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806107,
    is_show = 66,
    name = "NEWYEAR_SKILL",
    pre_para1 = __rt_5,
    pre_para2 = {301806107}
  },
  [301806108] = {
    describe = "MVP1",
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806108,
    is_show = 67,
    name = "NEWYEAR_MVP1",
    pre_para1 = __rt_5,
    pre_para2 = {301806108}
  },
  [301806111] = {
    describe = 214099,
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806111,
    is_show = 68,
    name = "NEWYEAR_RETREAT",
    pre_para1 = __rt_5,
    pre_para2 = {301806111}
  },
  [301806201] = {
    describe = "Live2D",
    exclusive_hero = 1018,
    exclusive_skin = 301806,
    id = 301806201,
    pre_para1 = __rt_5,
    pre_para2 = {301806201}
  },
  [301808001] = {
    describe = 379491,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808001,
    is_show = 178,
    name = "CHRISTMAS_MORNING",
    pre_para1 = __rt_8,
    pre_para2 = {301808001}
  },
  [301808002] = {
    describe = 350428,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808002,
    is_show = 179,
    name = "CHRISTMAS_AFTERNOON",
    pre_para1 = __rt_8,
    pre_para2 = {301808002}
  },
  [301808003] = {
    describe = 474134,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808003,
    is_show = 180,
    name = "CHRISTMAS_EVENING",
    pre_para1 = __rt_8,
    pre_para2 = {301808003}
  },
  [301808004] = {
    describe = 423077,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808004,
    is_show = 181,
    name = "CHRISTMAS_MIDNIGHT",
    pre_para1 = __rt_8,
    pre_para2 = {301808004}
  },
  [301808005] = {
    describe = 307943,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808005,
    is_show = 182,
    name = "CHRISTMAS_DIALOGUE1",
    pre_para1 = __rt_8,
    pre_para2 = {301808005}
  },
  [301808006] = {
    describe = 113172,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808006,
    is_show = 183,
    name = "CHRISTMAS_DIALOGUE2",
    pre_para1 = __rt_8,
    pre_para2 = {301808006}
  },
  [301808008] = {
    describe = 442689,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808008,
    name = "CHRISTMAS_DIALOGUE4",
    pre_para1 = __rt_8,
    pre_para2 = {301808008}
  },
  [301808009] = {
    describe = 247918,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808009,
    name = "CHRISTMAS_DIALOGUE5",
    pre_para1 = __rt_8,
    pre_para2 = {301808009}
  },
  [301808010] = {
    describe = 427119,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808010,
    is_show = 184,
    name = "CHRISTMAS_INTERACT1",
    pre_para1 = __rt_8,
    pre_para2 = {301808010}
  },
  [301808011] = {
    describe = 232348,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808011,
    is_show = 185,
    name = "CHRISTMAS_INTERACT2",
    pre_para1 = __rt_8,
    pre_para2 = {301808011}
  },
  [301808012] = {
    describe = 37577,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808012,
    is_show = 186,
    name = "CHRISTMAS_INTERACT3",
    pre_para1 = __rt_8,
    pre_para2 = {301808012}
  },
  [301808101] = {
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808101,
    is_show = 187,
    name = "CHRISTMAS_GAIN",
    pre_para1 = __rt_8,
    pre_para2 = {301808101}
  },
  [301808105] = {
    describe = 343117,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808105,
    is_show = 188,
    name = "CHRISTMAS_FORMATION",
    pre_para1 = __rt_8,
    pre_para2 = {301808105}
  },
  [301808106] = {
    describe = 382310,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808106,
    is_show = 189,
    name = "CHRISTMAS_BATTLE",
    pre_para1 = __rt_8,
    pre_para2 = {301808106}
  },
  [301808107] = {
    describe = 53739,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808107,
    is_show = 190,
    name = "CHRISTMAS_SKILL",
    pre_para1 = __rt_8,
    pre_para2 = {301808107}
  },
  [301808108] = {
    describe = "MVP1",
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808108,
    is_show = 191,
    name = "CHRISTMAS_MVP1",
    pre_para1 = __rt_8,
    pre_para2 = {301808108}
  },
  [301808109] = {
    describe = "MVP2",
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808109,
    is_show = 192,
    name = "CHRISTMAS_MVP2",
    pre_para1 = __rt_8,
    pre_para2 = {301808109}
  },
  [301808110] = {
    describe = "DUTY",
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808110,
    name = "DRESS_DUTY",
    pre_para1 = __rt_8,
    pre_para2 = {301808110}
  },
  [301808111] = {
    describe = 214099,
    exclusive_hero = 1018,
    exclusive_skin = 301808,
    id = 301808111,
    is_show = 193,
    name = "CHRISTMAS_RETREAT",
    pre_para1 = __rt_8,
    pre_para2 = {301808111}
  },
  [302606001] = {
    describe = 379491,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606001,
    is_show = 109,
    name = "SWIMSUIT_MORNING",
    pre_para1 = __rt_9,
    pre_para2 = {302606001}
  },
  [302606002] = {
    describe = 350428,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606002,
    is_show = 110,
    name = "SWIMSUIT_AFTERNOON",
    pre_para1 = __rt_9,
    pre_para2 = {302606002}
  },
  [302606003] = {
    describe = 474134,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606003,
    is_show = 111,
    name = "SWIMSUIT_EVENING",
    pre_para1 = __rt_9,
    pre_para2 = {302606003}
  },
  [302606006] = {
    describe = 113172,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606006,
    is_show = 112,
    name = "SWIMSUIT_DIALOGUE2",
    pre_para1 = __rt_9,
    pre_para2 = {302606006}
  },
  [302606008] = {
    describe = 442689,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606008,
    is_show = 113,
    name = "SWIMSUIT_DIALOGUE4",
    pre_para1 = __rt_9,
    pre_para2 = {302606008}
  },
  [302606009] = {
    describe = "DIALOGUE5",
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606009,
    name = "SWIMSUIT_DIALOGUE5",
    pre_para1 = __rt_9,
    pre_para2 = {302606009}
  },
  [302606010] = {
    describe = 427119,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606010,
    is_show = 114,
    name = "SWIMSUIT_INTERACT1",
    pre_para1 = __rt_9,
    pre_para2 = {302606010}
  },
  [302606012] = {
    describe = 37577,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606012,
    is_show = 115,
    name = "SWIMSUIT_INTERACT3",
    pre_para1 = __rt_9,
    pre_para2 = {302606012}
  },
  [302606101] = {
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606101,
    is_show = 116,
    name = "SWIMSUIT_GAIN",
    pre_para1 = __rt_9,
    pre_para2 = {302606101}
  },
  [302606105] = {
    describe = 343117,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606105,
    is_show = 117,
    name = "SWIMSUIT_FORMATION",
    pre_para1 = __rt_9,
    pre_para2 = {302606105}
  },
  [302606106] = {
    describe = 382310,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606106,
    is_show = 118,
    name = "SWIMSUIT_BATTLE",
    pre_para1 = __rt_9,
    pre_para2 = {302606106}
  },
  [302606107] = {
    describe = 53739,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606107,
    is_show = 119,
    name = "SWIMSUIT_SKILL",
    pre_para1 = __rt_9,
    pre_para2 = {302606107}
  },
  [302606109] = {
    describe = "MVP2",
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606109,
    is_show = 120,
    name = "SWIMSUIT_MVP2",
    pre_para1 = __rt_9,
    pre_para2 = {302606109}
  },
  [302606111] = {
    describe = 214099,
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606111,
    is_show = 121,
    name = "SWIMSUIT_RETREAT",
    pre_para1 = __rt_9,
    pre_para2 = {302606111}
  },
  [302606201] = {
    describe = "Live2D",
    exclusive_hero = 1026,
    exclusive_skin = 302606,
    id = 302606201,
    pre_para1 = __rt_9,
    pre_para2 = {302606201}
  },
  [303708001] = {
    describe = 379491,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708001,
    is_show = 149,
    name = "DRESS_MORNING",
    pre_para1 = __rt_10,
    pre_para2 = {303708001}
  },
  [303708002] = {
    describe = 350428,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708002,
    is_show = 150,
    name = "DRESS_AFTERNOON",
    pre_para1 = __rt_10,
    pre_para2 = {303708002}
  },
  [303708003] = {
    describe = 474134,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708003,
    is_show = 151,
    name = "DRESS_EVENING",
    pre_para1 = __rt_10,
    pre_para2 = {303708003}
  },
  [303708004] = {
    describe = 423077,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708004,
    is_show = 152,
    name = "DRESS_MIDNIGHT",
    pre_para1 = __rt_10,
    pre_para2 = {303708004}
  },
  [303708005] = {
    describe = 307943,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708005,
    is_show = 153,
    name = "DRESS_DIALOGUE1",
    pre_para1 = __rt_10,
    pre_para2 = {303708005}
  },
  [303708006] = {
    describe = 113172,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708006,
    is_show = 154,
    name = "DRESS_DIALOGUE2",
    pre_para1 = __rt_10,
    pre_para2 = {303708006}
  },
  [303708008] = {
    describe = 442689,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708008,
    name = "DRESS_DIALOGUE4",
    pre_para1 = __rt_10,
    pre_para2 = {303708008}
  },
  [303708009] = {
    describe = "DIALOGUE5",
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708009,
    name = "DRESS_DIALOGUE5",
    pre_para1 = __rt_10,
    pre_para2 = {303708009}
  },
  [303708010] = {
    describe = 427119,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708010,
    is_show = 155,
    name = "DRESS_INTERACT1",
    pre_para1 = __rt_10,
    pre_para2 = {303708010}
  },
  [303708011] = {
    describe = 232348,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708011,
    is_show = 156,
    name = "DRESS_INTERACT2",
    pre_para1 = __rt_10,
    pre_para2 = {303708011}
  },
  [303708012] = {
    describe = 37577,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708012,
    is_show = 157,
    name = "DRESS_INTERACT3",
    pre_para1 = __rt_10,
    pre_para2 = {303708012}
  },
  [303708101] = {
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708101,
    is_show = 158,
    name = "DRESS_GAIN",
    pre_para1 = __rt_10,
    pre_para2 = {303708101}
  },
  [303708105] = {
    describe = 343117,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708105,
    is_show = 159,
    name = "DRESS_FORMATION",
    pre_para1 = __rt_10,
    pre_para2 = {303708105}
  },
  [303708106] = {
    describe = 382310,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708106,
    is_show = 160,
    name = "DRESS_BATTLE",
    pre_para1 = __rt_10,
    pre_para2 = {303708106}
  },
  [303708107] = {
    describe = 53739,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708107,
    is_show = 161,
    name = "DRESS_SKILL",
    pre_para1 = __rt_10,
    pre_para2 = {303708107}
  },
  [303708108] = {
    describe = "MVP1",
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708108,
    is_show = 162,
    name = "DRESS_MVP1",
    pre_para1 = __rt_10,
    pre_para2 = {303708108}
  },
  [303708109] = {
    describe = "MVP2",
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708109,
    is_show = 163,
    name = "DRESS_MVP2",
    pre_para1 = __rt_10,
    pre_para2 = {303708109}
  },
  [303708110] = {
    describe = "DUTY",
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708110,
    name = "DRESS_DUTY",
    pre_para1 = __rt_10,
    pre_para2 = {303708110}
  },
  [303708111] = {
    describe = 214099,
    exclusive_hero = 1037,
    exclusive_skin = 303708,
    id = 303708111,
    is_show = 164,
    name = "DRESS_RETREAT",
    pre_para1 = __rt_10,
    pre_para2 = {303708111}
  },
  [304607002] = {
    describe = 350428,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607002,
    is_show = 69,
    name = "WUXIA_AFTERNOON",
    pre_para1 = __rt_11,
    pre_para2 = {304607002}
  },
  [304607003] = {
    describe = 474134,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607003,
    is_show = 70,
    name = "WUXIA_EVENING",
    pre_para1 = __rt_11,
    pre_para2 = {304607003}
  },
  [304607004] = {
    describe = 423077,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607004,
    is_show = 71,
    name = "WUXIA_MIDNIGHT",
    pre_para1 = __rt_11,
    pre_para2 = {304607004}
  },
  [304607006] = {
    describe = 113172,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607006,
    is_show = 72,
    name = "WUXIA_DIALOGUE2",
    pre_para1 = __rt_11,
    pre_para2 = {304607006}
  },
  [304607007] = {
    describe = "DIALOGUE3",
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607007,
    name = "WUXIA_DIALOGUE3",
    pre_para1 = __rt_11,
    pre_para2 = {304607007}
  },
  [304607008] = {
    describe = 442689,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607008,
    is_show = 73,
    name = "WUXIA_DIALOGUE4",
    pre_para1 = __rt_11,
    pre_para2 = {304607008}
  },
  [304607009] = {
    describe = "DIALOGUE5",
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607009,
    name = "WUXIA_DIALOGUE5",
    pre_para1 = __rt_11,
    pre_para2 = {304607009}
  },
  [304607010] = {
    describe = 427119,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607010,
    is_show = 74,
    name = "WUXIA_INTERACT1",
    pre_para1 = __rt_11,
    pre_para2 = {304607010}
  },
  [304607012] = {
    describe = 37577,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607012,
    is_show = 75,
    name = "WUXIA_INTERACT3",
    pre_para1 = __rt_11,
    pre_para2 = {304607012}
  },
  [304607101] = {
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607101,
    is_show = 76,
    name = "WUXIA_GAIN",
    pre_para1 = __rt_11,
    pre_para2 = {304607101}
  },
  [304607105] = {
    describe = 343117,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607105,
    is_show = 77,
    name = "WUXIA_FORMATION",
    pre_para1 = __rt_11,
    pre_para2 = {304607105}
  },
  [304607106] = {
    describe = 382310,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607106,
    is_show = 78,
    name = "WUXIA_BATTLE",
    pre_para1 = __rt_11,
    pre_para2 = {304607106}
  },
  [304607107] = {
    describe = 53739,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607107,
    is_show = 79,
    name = "WUXIA_SKILL",
    pre_para1 = __rt_11,
    pre_para2 = {304607107}
  },
  [304607108] = {
    describe = "MVP1",
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607108,
    is_show = 80,
    name = "WUXIA_MVP1",
    pre_para1 = __rt_11,
    pre_para2 = {304607108}
  },
  [304607111] = {
    describe = 214099,
    exclusive_hero = 1046,
    exclusive_skin = 304607,
    id = 304607111,
    is_show = 81,
    name = "WUXIA_RETREAT",
    pre_para1 = __rt_11,
    pre_para2 = {304607111}
  },
  [305804001] = {
    describe = 379491,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804001,
    is_show = 82,
    name = "IDOL_MORNING",
    pre_para1 = __rt_12,
    pre_para2 = {305804001}
  },
  [305804003] = {
    describe = 474134,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804003,
    is_show = 83,
    name = "IDOL_EVENING",
    pre_para1 = __rt_12,
    pre_para2 = {305804003}
  },
  [305804004] = {
    describe = 423077,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804004,
    is_show = 84,
    name = "IDOL_MIDNIGHT",
    pre_para1 = __rt_12,
    pre_para2 = {305804004}
  },
  [305804005] = {
    describe = 307943,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804005,
    is_show = 85,
    name = "IDOL_DIALOGUE1",
    pre_para1 = __rt_12,
    pre_para2 = {305804005}
  },
  [305804008] = {
    describe = 442689,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804008,
    is_show = 86,
    name = "IDOL_DIALOGUE4",
    pre_para1 = __rt_12,
    pre_para2 = {305804008}
  },
  [305804009] = {
    describe = "DIALOGUE5",
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804009,
    name = "IDOL_DIALOGUE5",
    pre_para1 = __rt_12,
    pre_para2 = {305804009}
  },
  [305804010] = {
    describe = 427119,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804010,
    is_show = 87,
    name = "IDOL_INTERACT1",
    pre_para1 = __rt_12,
    pre_para2 = {305804010}
  },
  [305804011] = {
    describe = 232348,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804011,
    is_show = 88,
    name = "IDOL_INTERACT2",
    pre_para1 = __rt_12,
    pre_para2 = {305804011}
  },
  [305804101] = {
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804101,
    is_show = 89,
    name = "IDOL_GAIN",
    pre_para1 = __rt_12,
    pre_para2 = {305804101}
  },
  [305804105] = {
    describe = 343117,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804105,
    is_show = 90,
    name = "IDOL_FORMATION",
    pre_para1 = __rt_12,
    pre_para2 = {305804105}
  },
  [305804106] = {
    describe = 382310,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804106,
    is_show = 91,
    name = "IDOL_BATTLE",
    pre_para1 = __rt_12,
    pre_para2 = {305804106}
  },
  [305804107] = {
    describe = 53739,
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804107,
    is_show = 92,
    name = "IDOL_SKILL",
    pre_para1 = __rt_12,
    pre_para2 = {305804107}
  },
  [305804108] = {
    describe = "MVP1",
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804108,
    is_show = 93,
    name = "IDOL_MVP1",
    pre_para1 = __rt_12,
    pre_para2 = {305804108}
  },
  [305804109] = {
    describe = "MVP2",
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804109,
    is_show = 94,
    name = "IDOL_MVP2",
    pre_para1 = __rt_12,
    pre_para2 = {305804109}
  },
  [305804110] = {
    describe = "DUTY",
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804110,
    name = "IDOL_DUTY",
    pre_para1 = __rt_12,
    pre_para2 = {305804110}
  },
  [305804202] = {
    describe = "Live2D1",
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804202,
    name = "L2D1",
    pre_para1 = __rt_12,
    pre_para2 = {305804202}
  },
  [305804203] = {
    describe = "Live2D2",
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804203,
    name = "L2D2",
    pre_para1 = __rt_12,
    pre_para2 = {305804203}
  },
  [305804204] = {
    describe = "Live2D3",
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804204,
    name = "L2D3",
    pre_para1 = __rt_12,
    pre_para2 = {305804204}
  },
  [305804205] = {
    describe = "Live2D4",
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804205,
    name = "L2D4",
    pre_para1 = __rt_12,
    pre_para2 = {305804205}
  },
  [305804206] = {
    describe = "Live2D5",
    exclusive_hero = 1058,
    exclusive_skin = 305804,
    id = 305804206,
    name = "L2D5",
    pre_para1 = __rt_12,
    pre_para2 = {305804206}
  },
  [305805001] = {
    describe = 379491,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805001,
    is_show = 95,
    name = "SWIMSUIT_MORNING",
    pre_para1 = __rt_13,
    pre_para2 = {305805001}
  },
  [305805002] = {
    describe = 350428,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805002,
    is_show = 96,
    name = "SWIMSUIT_AFTERNOON",
    pre_para1 = __rt_13,
    pre_para2 = {305805002}
  },
  [305805004] = {
    describe = 423077,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805004,
    is_show = 97,
    name = "SWIMSUIT_MIDNIGHT",
    pre_para1 = __rt_13,
    pre_para2 = {305805004}
  },
  [305805005] = {
    describe = 307943,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805005,
    is_show = 98,
    name = "SWIMSUIT_DIALOGUE1",
    pre_para1 = __rt_13,
    pre_para2 = {305805005}
  },
  [305805008] = {
    describe = 442689,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805008,
    is_show = 99,
    name = "SWIMSUIT_DIALOGUE4",
    pre_para1 = __rt_13,
    pre_para2 = {305805008}
  },
  [305805009] = {
    describe = "DIALOGUE5",
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805009,
    name = "SWIMSUIT_DIALOGUE5",
    pre_para1 = __rt_13,
    pre_para2 = {305805009}
  },
  [305805010] = {
    describe = 427119,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805010,
    is_show = 100,
    name = "SWIMSUIT_INTERACT1",
    pre_para1 = __rt_13,
    pre_para2 = {305805010}
  },
  [305805011] = {
    describe = 232348,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805011,
    is_show = 101,
    name = "SWIMSUIT_INTERACT2",
    pre_para1 = __rt_13,
    pre_para2 = {305805011}
  },
  [305805012] = {
    describe = 37577,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805012,
    is_show = 102,
    name = "SWIMSUIT_INTERACT3",
    pre_para1 = __rt_13,
    pre_para2 = {305805012}
  },
  [305805101] = {
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805101,
    is_show = 103,
    name = "SWIMSUIT_GAIN",
    pre_para1 = __rt_13,
    pre_para2 = {305805101}
  },
  [305805105] = {
    describe = 343117,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805105,
    is_show = 104,
    name = "SWIMSUIT_FORMATION",
    pre_para1 = __rt_13,
    pre_para2 = {305805105}
  },
  [305805106] = {
    describe = 382310,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805106,
    is_show = 105,
    name = "SWIMSUIT_BATTLE",
    pre_para1 = __rt_13,
    pre_para2 = {305805106}
  },
  [305805107] = {
    describe = 53739,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805107,
    is_show = 106,
    name = "SWIMSUIT_SKILL",
    pre_para1 = __rt_13,
    pre_para2 = {305805107}
  },
  [305805109] = {
    describe = "MVP2",
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805109,
    is_show = 107,
    name = "SWIMSUIT_MVP2",
    pre_para1 = __rt_13,
    pre_para2 = {305805109}
  },
  [305805111] = {
    describe = 214099,
    exclusive_hero = 1058,
    exclusive_skin = 305805,
    id = 305805111,
    is_show = 108,
    name = "SWIMSUIT_RETREAT",
    pre_para1 = __rt_13,
    pre_para2 = {305805111}
  },
  [306103003] = {
    describe = 474134,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103003,
    is_show = 41,
    name = "CHRISTMAS_EVENING",
    pre_para1 = __rt_14,
    pre_para2 = {306103003}
  },
  [306103005] = {
    describe = 307943,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103005,
    is_show = 42,
    name = "CHRISTMAS_DIALOGUE1",
    pre_para1 = __rt_14,
    pre_para2 = {306103005}
  },
  [306103006] = {
    describe = 113172,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103006,
    is_show = 43,
    name = "CHRISTMAS_DIALOGUE2",
    pre_para1 = __rt_14,
    pre_para2 = {306103006}
  },
  [306103009] = {
    describe = "DIALOGUE5",
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103009,
    name = "CHRISTMAS_DIALOGUE5",
    pre_para1 = __rt_14,
    pre_para2 = {306103009}
  },
  [306103010] = {
    describe = 427119,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103010,
    is_show = 44,
    name = "CHRISTMAS_INTERACT1",
    pre_para1 = __rt_14,
    pre_para2 = {306103010}
  },
  [306103011] = {
    describe = 232348,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103011,
    is_show = 45,
    name = "CHRISTMAS_INTERACT2",
    pre_para1 = __rt_14,
    pre_para2 = {306103011}
  },
  [306103012] = {
    describe = 37577,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103012,
    is_show = 46,
    name = "CHRISTMAS_INTERACT3",
    pre_para1 = __rt_14,
    pre_para2 = {306103012}
  },
  [306103101] = {
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103101,
    is_show = 47,
    name = "CHRISTMAS_GAIN",
    pre_para1 = __rt_14,
    pre_para2 = {306103101}
  },
  [306103105] = {
    describe = 343117,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103105,
    is_show = 48,
    name = "CHRISTMAS_FORMATION",
    pre_para1 = __rt_14,
    pre_para2 = {306103105}
  },
  [306103106] = {
    describe = 382310,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103106,
    is_show = 49,
    name = "CHRISTMAS_BATTLE",
    pre_para1 = __rt_14,
    pre_para2 = {306103106}
  },
  [306103107] = {
    describe = 53739,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103107,
    is_show = 50,
    name = "CHRISTMAS_SKILL",
    pre_para1 = __rt_14,
    pre_para2 = {306103107}
  },
  [306103108] = {
    describe = "MVP1",
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103108,
    is_show = 51,
    name = "CHRISTMAS_MVP1",
    pre_para1 = __rt_14,
    pre_para2 = {306103108}
  },
  [306103109] = {
    describe = "MVP2",
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103109,
    is_show = 52,
    name = "CHRISTMAS_MVP2",
    pre_para1 = __rt_14,
    pre_para2 = {306103109}
  },
  [306103110] = {
    describe = "DUTY",
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103110,
    name = "CHRISTMAS_DUTY",
    pre_para1 = __rt_14,
    pre_para2 = {306103110}
  },
  [306103111] = {
    describe = 214099,
    exclusive_hero = 1061,
    exclusive_skin = 306103,
    id = 306103111,
    is_show = 53,
    name = "CHRISTMAS_RETREAT",
    pre_para1 = __rt_14,
    pre_para2 = {306103111}
  },
  [307104001] = {
    describe = 379491,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104001,
    is_show = 208,
    name = "NEWYEAR_MORNING",
    pre_para1 = __rt_15,
    pre_para2 = {307104001}
  },
  [307104002] = {
    describe = 350428,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104002,
    is_show = 209,
    name = "NEWYEAR_AFTERNOON",
    pre_para1 = __rt_15,
    pre_para2 = {307104002}
  },
  [307104003] = {
    describe = 474134,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104003,
    is_show = 210,
    name = "NEWYEAR_EVENING",
    pre_para1 = __rt_15,
    pre_para2 = {307104003}
  },
  [307104004] = {
    describe = 423077,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104004,
    is_show = 211,
    name = "NEWYEAR_MIDNIGHT",
    pre_para1 = __rt_15,
    pre_para2 = {307104004}
  },
  [307104005] = {
    describe = 307943,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104005,
    is_show = 212,
    name = "NEWYEAR_DIALOGUE1",
    pre_para1 = __rt_15,
    pre_para2 = {307104005}
  },
  [307104006] = {
    describe = 113172,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104006,
    is_show = 213,
    name = "NEWYEAR_DIALOGUE2",
    pre_para1 = __rt_15,
    pre_para2 = {307104006}
  },
  [307104007] = {
    describe = 442689,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104007,
    name = "NEWYEAR_DIALOGUE3",
    pre_para1 = __rt_15,
    pre_para2 = {307104007}
  },
  [307104008] = {
    describe = 247918,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104008,
    name = "NEWYEAR_DIALOGUE4",
    pre_para1 = __rt_15,
    pre_para2 = {307104008}
  },
  [307104009] = {
    describe = "DIALOGUE5",
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104009,
    name = "NEWYEAR_DIALOGUE5",
    pre_para1 = __rt_15,
    pre_para2 = {307104009}
  },
  [307104010] = {
    describe = 427119,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104010,
    is_show = 214,
    name = "NEWYEAR_INTERACT1",
    pre_para1 = __rt_15,
    pre_para2 = {307104010}
  },
  [307104011] = {
    describe = 232348,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104011,
    is_show = 215,
    name = "NEWYEAR_INTERACT2",
    pre_para1 = __rt_15,
    pre_para2 = {307104011}
  },
  [307104012] = {
    describe = 37577,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104012,
    is_show = 216,
    name = "NEWYEAR_INTERACT3",
    pre_para1 = __rt_15,
    pre_para2 = {307104012}
  },
  [307104019] = {
    describe = 367094,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104019,
    name = "NEWYEAR_INTERACT4",
    pre_para1 = __rt_15,
    pre_para2 = {307104019}
  },
  [307104101] = {
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104101,
    is_show = 217,
    name = "NEWYEAR_GAIN",
    pre_para1 = __rt_15,
    pre_para2 = {307104101}
  },
  [307104105] = {
    describe = 343117,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104105,
    is_show = 218,
    name = "NEWYEAR_FORMATION",
    pre_para1 = __rt_15,
    pre_para2 = {307104105}
  },
  [307104106] = {
    describe = 382310,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104106,
    is_show = 219,
    name = "NEWYEAR_BATTLE",
    pre_para1 = __rt_15,
    pre_para2 = {307104106}
  },
  [307104107] = {
    describe = 53739,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104107,
    is_show = 220,
    name = "NEWYEAR_SKILL",
    pre_para1 = __rt_15,
    pre_para2 = {307104107}
  },
  [307104108] = {
    describe = "MVP1",
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104108,
    is_show = 221,
    name = "NEWYEAR_MVP1",
    pre_para1 = __rt_15,
    pre_para2 = {307104108}
  },
  [307104109] = {
    describe = "MVP2",
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104109,
    is_show = 222,
    name = "NEWYEAR_MVP2",
    pre_para1 = __rt_15,
    pre_para2 = {307104109}
  },
  [307104110] = {
    describe = "DUTY",
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104110,
    name = "NEWYEAR_DUTY",
    pre_para1 = __rt_15,
    pre_para2 = {307104110}
  },
  [307104111] = {
    describe = 214099,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104111,
    is_show = 223,
    name = "NEWYEAR_RETREAT",
    pre_para1 = __rt_15,
    pre_para2 = {307104111}
  },
  [307104147] = {
    describe = 296045,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104147,
    name = "NEWYEAR_MOOD3",
    pre_para1 = __rt_15,
    pre_para2 = {307104147}
  },
  [307104148] = {
    describe = 101274,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104148,
    name = "NEWYEAR_MOOD4",
    pre_para1 = __rt_15,
    pre_para2 = {307104148}
  },
  [307104149] = {
    describe = 430791,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104149,
    name = "NEWYEAR_MOOD5",
    pre_para1 = __rt_15,
    pre_para2 = {307104149}
  },
  [307104150] = {
    describe = 236020,
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104150,
    name = "NEWYEAR_MOOD6",
    pre_para1 = __rt_15,
    pre_para2 = {307104150}
  },
  [307104201] = {
    describe = "Live2D",
    exclusive_hero = 1071,
    exclusive_skin = 307104,
    id = 307104201,
    name = "NEWYEAR_L2D",
    pre_para1 = __rt_15,
    pre_para2 = {307104201}
  },
  [307202001] = {
    describe = 379491,
    exclusive_skin = 307202,
    id = 307202001,
    is_show = 122,
    name = "P3_MORNING",
    pre_para1 = __rt_16,
    pre_para2 = {307202001}
  },
  [307202002] = {
    describe = 350428,
    exclusive_skin = 307202,
    id = 307202002,
    is_show = 123,
    name = "P3_AFTERNOON",
    pre_para1 = __rt_16,
    pre_para2 = {307202002}
  },
  [307202003] = {
    describe = 474134,
    exclusive_skin = 307202,
    id = 307202003,
    is_show = 124,
    name = "P3_EVENING",
    pre_para1 = __rt_16,
    pre_para2 = {307202003}
  },
  [307202004] = {
    describe = 423077,
    exclusive_skin = 307202,
    id = 307202004,
    is_show = 125,
    name = "P3_MIDNIGHT",
    pre_para1 = __rt_16,
    pre_para2 = {307202004}
  },
  [307202005] = {
    describe = 307943,
    exclusive_skin = 307202,
    id = 307202005,
    is_show = 126,
    name = "P3_DIALOGUE1",
    pre_para1 = __rt_16,
    pre_para2 = {307202005}
  },
  [307202006] = {
    describe = 113172,
    exclusive_skin = 307202,
    id = 307202006,
    is_show = 127,
    name = "P3_DIALOGUE2",
    pre_para1 = __rt_16,
    pre_para2 = {307202006}
  },
  [307202007] = {
    describe = 442689,
    exclusive_skin = 307202,
    id = 307202007,
    is_show = 128,
    name = "P3_DIALOGUE3",
    pre_para1 = __rt_16,
    pre_para2 = {307202007}
  },
  [307202008] = {
    describe = 442689,
    exclusive_skin = 307202,
    id = 307202008,
    name = "P3_DIALOGUE4",
    pre_para1 = __rt_16,
    pre_para2 = {307202008}
  },
  [307202009] = {
    describe = "DIALOGUE5",
    exclusive_skin = 307202,
    id = 307202009,
    name = "P3_DIALOGUE5",
    pre_para1 = __rt_16,
    pre_para2 = {307202009}
  },
  [307202010] = {
    describe = 427119,
    exclusive_skin = 307202,
    id = 307202010,
    is_show = 129,
    name = "P3_INTERACT1",
    pre_para1 = __rt_16,
    pre_para2 = {307202010}
  },
  [307202011] = {
    describe = 232348,
    exclusive_skin = 307202,
    id = 307202011,
    is_show = 130,
    name = "P3_INTERACT2",
    pre_para1 = __rt_16,
    pre_para2 = {307202011}
  },
  [307202012] = {
    describe = 37577,
    exclusive_skin = 307202,
    id = 307202012,
    is_show = 131,
    name = "P3_INTERACT3",
    pre_para1 = __rt_16,
    pre_para2 = {307202012}
  },
  [307202013] = {
    describe = 246159,
    exclusive_skin = 307202,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 307202013,
    is_show = 165,
    name = "P3_NEWYEAR",
    pre_para1 = __rt_16,
    pre_para2 = {307202013}
  },
  [307202014] = {
    describe = 392395,
    exclusive_skin = 307202,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 307202014,
    is_show = 166,
    name = "P3_VALENTINE",
    pre_para1 = __rt_16,
    pre_para2 = {307202014}
  },
  [307202015] = {
    describe = 267178,
    exclusive_skin = 307202,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 307202015,
    is_show = 167,
    name = "P3_TANABATA",
    pre_para1 = __rt_16,
    pre_para2 = {307202015}
  },
  [307202016] = {
    describe = 174486,
    exclusive_skin = 307202,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 307202016,
    is_show = 168,
    name = "P3_ALLHALLOWS",
    pre_para1 = __rt_16,
    pre_para2 = {307202016}
  },
  [307202017] = {
    describe = 259212,
    exclusive_skin = 307202,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 307202017,
    is_show = 169,
    name = "P3_CHRISTMAS",
    pre_para1 = __rt_16,
    pre_para2 = {307202017}
  },
  [307202018] = {
    describe = 410875,
    exclusive_skin = 307202,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 307202018,
    is_show = 170,
    name = "P3_PLAYERBIRTHDAY",
    pre_para1 = __rt_16,
    pre_para2 = {307202018}
  },
  [307202101] = {
    exclusive_skin = 307202,
    id = 307202101,
    is_show = 132,
    name = "P3_GAIN",
    pre_para1 = __rt_16,
    pre_para2 = {307202101}
  },
  [307202102] = {
    describe = 62926,
    exclusive_skin = 307202,
    id = 307202102,
    is_show = 133,
    name = "P3_LEVELUP",
    pre_para1 = __rt_16,
    pre_para2 = {307202102}
  },
  [307202103] = {
    describe = 432664,
    exclusive_skin = 307202,
    id = 307202103,
    is_show = 134,
    name = "P3_RANKUP",
    pre_para1 = __rt_16,
    pre_para2 = {307202103}
  },
  [307202104] = {
    describe = "RANKMAX",
    exclusive_skin = 307202,
    id = 307202104,
    name = "P3_RANKMAX",
    pre_para1 = __rt_16,
    pre_para2 = {307202104}
  },
  [307202105] = {
    describe = 343117,
    exclusive_skin = 307202,
    id = 307202105,
    is_show = 135,
    name = "P3_FORMATION",
    pre_para1 = __rt_16,
    pre_para2 = {307202105}
  },
  [307202106] = {
    describe = 382310,
    exclusive_skin = 307202,
    id = 307202106,
    is_show = 136,
    name = "P3_BATTLE",
    pre_para1 = __rt_16,
    pre_para2 = {307202106}
  },
  [307202107] = {
    describe = 53739,
    exclusive_skin = 307202,
    id = 307202107,
    is_show = 137,
    name = "P3_SKILL",
    pre_para1 = __rt_16,
    pre_para2 = {307202107}
  },
  [307202108] = {
    describe = "MVP1",
    exclusive_skin = 307202,
    id = 307202108,
    is_show = 138,
    name = "P3_MVP1",
    pre_para1 = __rt_16,
    pre_para2 = {307202108}
  },
  [307202109] = {
    describe = "MVP2",
    exclusive_skin = 307202,
    id = 307202109,
    is_show = 139,
    name = "P3_MVP2",
    pre_para1 = __rt_16,
    pre_para2 = {307202109}
  },
  [307202110] = {
    describe = "DUTY",
    exclusive_skin = 307202,
    id = 307202110,
    name = "P3_DUTY",
    pre_para1 = __rt_16,
    pre_para2 = {307202110}
  },
  [307202111] = {
    describe = 214099,
    exclusive_skin = 307202,
    id = 307202111,
    is_show = 140,
    name = "P3_RETREAT",
    pre_para1 = __rt_16,
    pre_para2 = {307202111}
  },
  [307202112] = {
    describe = 54720,
    exclusive_skin = 307202,
    id = 307202112,
    name = "P3_RELATIONSHIP1",
    pre_condition = __rt_2,
    pre_para1 = __rt_16,
    pre_para2 = {307202112}
  },
  [307202113] = {
    describe = 384237,
    exclusive_skin = 307202,
    id = 307202113,
    name = "P3_RELATIONSHIP2",
    pre_condition = __rt_2,
    pre_para1 = __rt_16,
    pre_para2 = {307202113}
  },
  [307202114] = {
    describe = 189466,
    exclusive_skin = 307202,
    id = 307202114,
    name = "P3_RELATIONSHIP3",
    pre_condition = __rt_2,
    pre_para1 = __rt_16,
    pre_para2 = {307202114}
  },
  [307202115] = {
    describe = 518983,
    exclusive_skin = 307202,
    id = 307202115,
    name = "P3_RELATIONSHIP4",
    pre_condition = __rt_2,
    pre_para1 = __rt_16,
    pre_para2 = {307202115}
  },
  [307202116] = {
    describe = 324212,
    exclusive_skin = 307202,
    id = 307202116,
    name = "P3_RELATIONSHIP5",
    pre_condition = __rt_2,
    pre_para1 = __rt_16,
    pre_para2 = {307202116}
  },
  [307202117] = {
    describe = 188681,
    exclusive_skin = 307202,
    extra_condition = 1,
    extra_lock_tip = 23008,
    id = 307202117,
    is_show = 171,
    name = "P3_OATH",
    pre_para1 = __rt_16,
    pre_para2 = {307202117}
  },
  [307202118] = {
    describe = 120297,
    exclusive_skin = 307202,
    id = 307202118,
    is_show = 141,
    name = "P3_TITLE",
    pre_para1 = __rt_16,
    pre_para2 = {307202118}
  },
  [307202141] = {
    describe = 450835,
    exclusive_skin = 307202,
    id = 307202141,
    name = "P3_AGREE",
    pre_para1 = __rt_16,
    pre_para2 = {307202141}
  },
  [307202146] = {
    describe = 108415,
    exclusive_skin = 307202,
    id = 307202146,
    name = "P3_MOOD2",
    pre_para1 = __rt_16,
    pre_para2 = {307202146}
  },
  [307202201] = {
    describe = "Live2D",
    exclusive_skin = 307202,
    id = 307202201,
    pre_para1 = __rt_16,
    pre_para2 = {307202201}
  },
  [307203001] = {
    describe = 379491,
    exclusive_skin = 307203,
    id = 307203001,
    is_show = 194,
    name = "NEWYEAR_MORNING",
    pre_para1 = __rt_17,
    pre_para2 = {307203001}
  },
  [307203002] = {
    describe = 350428,
    exclusive_skin = 307203,
    id = 307203002,
    is_show = 195,
    name = "NEWYEAR_AFTERNOON",
    pre_para1 = __rt_17,
    pre_para2 = {307203002}
  },
  [307203004] = {
    describe = 423077,
    exclusive_skin = 307203,
    id = 307203004,
    is_show = 196,
    name = "NEWYEAR_MIDNIGHT",
    pre_para1 = __rt_17,
    pre_para2 = {307203004}
  },
  [307203005] = {
    describe = 307943,
    exclusive_skin = 307203,
    id = 307203005,
    is_show = 197,
    name = "NEWYEAR_DIALOGUE1",
    pre_para1 = __rt_17,
    pre_para2 = {307203005}
  },
  [307203006] = {
    describe = 113172,
    exclusive_skin = 307203,
    id = 307203006,
    is_show = 198,
    name = "NEWYEAR_DIALOGUE2",
    pre_para1 = __rt_17,
    pre_para2 = {307203006}
  },
  [307203009] = {
    describe = 247918,
    exclusive_skin = 307203,
    id = 307203009,
    name = "NEWYEAR_DIALOGUE5",
    pre_para1 = __rt_17,
    pre_para2 = {307203009}
  },
  [307203010] = {
    describe = 427119,
    exclusive_skin = 307203,
    id = 307203010,
    is_show = 199,
    name = "NEWYEAR_INTERACT1",
    pre_para1 = __rt_17,
    pre_para2 = {307203010}
  },
  [307203011] = {
    describe = 232348,
    exclusive_skin = 307203,
    id = 307203011,
    is_show = 200,
    name = "NEWYEAR_INTERACT2",
    pre_para1 = __rt_17,
    pre_para2 = {307203011}
  },
  [307203012] = {
    describe = 37577,
    exclusive_skin = 307203,
    id = 307203012,
    is_show = 201,
    name = "NEWYEAR_INTERACT3",
    pre_para1 = __rt_17,
    pre_para2 = {307203012}
  },
  [307203101] = {
    exclusive_skin = 307203,
    id = 307203101,
    is_show = 202,
    name = "NEWYEAR_GAIN",
    pre_para1 = __rt_17,
    pre_para2 = {307203101}
  },
  [307203105] = {
    describe = 343117,
    exclusive_skin = 307203,
    id = 307203105,
    is_show = 203,
    name = "NEWYEAR_FORMATION",
    pre_para1 = __rt_17,
    pre_para2 = {307203105}
  },
  [307203106] = {
    describe = 382310,
    exclusive_skin = 307203,
    id = 307203106,
    is_show = 204,
    name = "NEWYEAR_BATTLE",
    pre_para1 = __rt_17,
    pre_para2 = {307203106}
  },
  [307203107] = {
    describe = 53739,
    exclusive_skin = 307203,
    id = 307203107,
    is_show = 205,
    name = "NEWYEAR_SKILL",
    pre_para1 = __rt_17,
    pre_para2 = {307203107}
  },
  [307203108] = {
    describe = "MVP1",
    exclusive_skin = 307203,
    id = 307203108,
    is_show = 206,
    name = "NEWYEAR_MVP1",
    pre_para1 = __rt_17,
    pre_para2 = {307203108}
  },
  [307203111] = {
    describe = 214099,
    exclusive_skin = 307203,
    id = 307203111,
    is_show = 207,
    name = "NEWYEAR_RETREAT",
    pre_para1 = __rt_17,
    pre_para2 = {307203111}
  },
  [307203117] = {
    describe = 188681,
    exclusive_skin = 307203,
    id = 307203117,
    name = "NEWYEAR_OATH",
    pre_para1 = __rt_17,
    pre_para2 = {307203117}
  },
  [307203141] = {
    describe = 450835,
    exclusive_skin = 307203,
    id = 307203141,
    name = "NEWYEAR_AGREE",
    pre_para1 = __rt_17,
    pre_para2 = {307203141}
  },
  [307203144] = {
    describe = 448691,
    exclusive_skin = 307203,
    id = 307203144,
    name = "NEWYEAR_LOWMOOD",
    pre_para1 = __rt_17,
    pre_para2 = {307203144}
  },
  [307203145] = {
    describe = 461636,
    exclusive_skin = 307203,
    id = 307203145,
    name = "NEWYEAR_MOOD1",
    pre_para1 = __rt_17,
    pre_para2 = {307203145}
  },
  [307203201] = {
    describe = "Live2D",
    exclusive_skin = 307203,
    id = 307203201,
    name = "NEWYEAR_L2D",
    pre_para1 = __rt_17,
    pre_para2 = {307203201}
  },
  [307203203] = {
    describe = "Live2D",
    exclusive_skin = 307203,
    id = 307203203,
    name = "NEWYEAR_L2D2",
    pre_para1 = __rt_17,
    pre_para2 = {307203203}
  }
}
local __default_values = {
  describe = 208045,
  exclusive_hero = 1072,
  exclusive_skin = 0,
  extra_condition = 0,
  extra_lock_tip = 0,
  id = 1,
  is_show = 0,
  name = "L2D",
  pre_condition = __rt_4,
  pre_para1 = __rt_1,
  pre_para2 = __rt_1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(audio_voice) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  heroVoiceSkinIdList = {
    [1018] = {
      1018,
      301806,
      301808
    },
    [1026] = {1026, 302606},
    [1037] = {1037, 303708},
    [1046] = {1046, 304607},
    [1058] = {
      1058,
      305804,
      305805
    },
    [1061] = {1061, 306103},
    [1071] = {1071, 307104},
    [1072] = {
      1072,
      307202,
      307203
    }
  },
  skinVoice = {
    [301806] = {
      301806101,
      301806105,
      301806106,
      301806107,
      301806108,
      301806111,
      301806001,
      301806003,
      301806004,
      301806005,
      301806006,
      301806008,
      301806010,
      301806011,
      301806012
    },
    [301808] = {
      301808001,
      301808002,
      301808003,
      301808004,
      301808005,
      301808006,
      301808010,
      301808011,
      301808012,
      301808101,
      301808105,
      301808106,
      301808107,
      301808108,
      301808109,
      301808111
    },
    [302606] = {
      302606001,
      302606002,
      302606003,
      302606006,
      302606008,
      302606101,
      302606105,
      302606106,
      302606107,
      302606109,
      302606111,
      302606012,
      302606010
    },
    [303708] = {
      303708001,
      303708002,
      303708003,
      303708004,
      303708005,
      303708006,
      303708010,
      303708011,
      303708012,
      303708101,
      303708105,
      303708106,
      303708107,
      303708108,
      303708109,
      303708111
    },
    [304607] = {
      304607004,
      304607101,
      304607111,
      304607108,
      304607107,
      304607106,
      304607105,
      304607012,
      304607010,
      304607008,
      304607006,
      304607003,
      304607002
    },
    [305804] = {
      305804001,
      305804003,
      305804004,
      305804005,
      305804008,
      305804010,
      305804011,
      305804107,
      305804108,
      305804109,
      305804106,
      305804105,
      305804101
    },
    [305805] = {
      305805008,
      305805010,
      305805011,
      305805012,
      305805101,
      305805105,
      305805106,
      305805107,
      305805109,
      305805111,
      305805001,
      305805002,
      305805004,
      305805005
    },
    [306103] = {
      306103003,
      306103005,
      306103006,
      306103010,
      306103101,
      306103105,
      306103106,
      306103107,
      306103111,
      306103012,
      306103011,
      306103108,
      306103109
    },
    [307104] = {
      307104001,
      307104002,
      307104003,
      307104004,
      307104005,
      307104006,
      307104010,
      307104011,
      307104012,
      307104109,
      307104111,
      307104105,
      307104101,
      307104106,
      307104107,
      307104108
    },
    [307202] = {
      307202101,
      307202102,
      307202103,
      307202105,
      307202106,
      307202107,
      307202108,
      307202109,
      307202111,
      307202117,
      307202118,
      307202001,
      307202002,
      307202003,
      307202004,
      307202005,
      307202006,
      307202007,
      307202010,
      307202011,
      307202012,
      307202013,
      307202014,
      307202015,
      307202016,
      307202017,
      307202018
    },
    [307203] = {
      307203101,
      307203105,
      307203106,
      307203107,
      307203108,
      307203111,
      307203004,
      307203002,
      307203001,
      307203005,
      307203006,
      307203010,
      307203011,
      307203012
    }
  }
}
setmetatable(audio_voice, {__index = __rawdata})
return audio_voice
