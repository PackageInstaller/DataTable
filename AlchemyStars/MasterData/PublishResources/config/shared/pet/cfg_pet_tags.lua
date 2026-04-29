local key = {
  ID = 1,
  tagType = 2,
  Name = 3,
  OwnFriendGroup = 4,
  AloneGroup = 5,
  Icon = 6,
  BgFull = 7,
  BgHalf = 8,
  Desc = 9,
  BookType = 10,
  GroupPhoto = 11,
  BookZhuangshi = 12,
  BookBg = 13,
  SpriteIcon = 14,
  RelationSpriteIcon = 15,
  RelationTiaoSpriteIcon = 16
}
local common = {
  "tongyong_quanjing",
  "tongyong_banjing"
}
local empty = {}
local config = {
  [1001] = {
    1001,
    1,
    "str_pet_tag_faction_name_1",
    {
      3005,
      3004,
      3006,
      3007,
      3022,
      3039,
      3055,
      3056,
      3057
    },
    {
      4025,
      4026,
      4057,
      4065,
      4068,
      4075,
      4080
    },
    "1001_force_logo",
    "shangcheng_quanjing",
    "shangcheng_banjing",
    "str_book_tag_faction_des_1",
    1,
    nil,
    "tujian_xiaozu_tiao1",
    "tujian_xiaozu_bg1",
    "tujian_force_logo1",
    "tujian_xiaozu_icon1",
    "tujian_xiaozu_diban1"
  },
  [1002] = {
    1002,
    1,
    "str_pet_tag_faction_name_2",
    {
      3008,
      3009,
      3029,
      3030,
      3038,
      3062
    },
    {
      4035,
      4040,
      4042,
      4052,
      4053,
      4054,
      4060,
      4066,
      4076,
      40015,
      40016,
      40023,
      40024,
      40025,
      40030
    },
    "1002_force_logo",
    "xiacheng_quanjing",
    "xiacheng_banjing",
    "str_book_tag_faction_des_2",
    1,
    nil,
    "tujian_xiaozu_tiao2",
    "tujian_xiaozu_bg2",
    "tujian_force_logo2",
    "tujian_xiaozu_icon2",
    "tujian_xiaozu_diban2"
  },
  [1003] = {
    1003,
    1,
    "str_pet_tag_faction_name_3",
    {
      3001,
      3002,
      3003,
      3027,
      3040,
      3060,
      3065
    },
    {
      4024,
      4037,
      4038,
      4039,
      4044,
      4056,
      4067,
      4069,
      4079,
      40026,
      40029
    },
    "1003_force_logo",
    "qiguang_quanjing",
    "qiguang_banjing",
    "str_book_tag_faction_des_3",
    1,
    nil,
    "tujian_xiaozu_tiao5",
    "tujian_xiaozu_bg5",
    "tujian_force_logo6",
    "tujian_xiaozu_icon5",
    "tujian_xiaozu_diban5"
  },
  [1004] = {
    1004,
    1,
    "str_pet_tag_faction_name_4",
    {3010, 3031},
    {
      4022,
      4023,
      4074,
      40009,
      40010
    },
    "1004_force_logo",
    "beijing_quanjing",
    "beijing_banjing",
    "str_book_tag_faction_des_4",
    1,
    nil,
    "tujian_xiaozu_tiao3",
    "tujian_xiaozu_bg3",
    "tujian_force_logo3",
    "tujian_xiaozu_icon3",
    "tujian_xiaozu_diban3"
  },
  [1005] = {
    1005,
    1,
    "str_pet_tag_faction_name_5",
    {
      3012,
      3013,
      3014,
      3032,
      3047
    },
    {
      4008,
      4034,
      4078
    },
    "1005_force_logo",
    "hongyou_quanjing",
    "hongyou_banjing",
    "str_book_tag_faction_des_5",
    1,
    nil,
    "tujian_xiaozu_tiao4",
    "tujian_xiaozu_bg4",
    "tujian_force_logo5",
    "tujian_xiaozu_icon4",
    "tujian_xiaozu_diban4"
  },
  [1006] = {
    1006,
    1,
    "str_pet_tag_faction_name_6",
    {
      3011,
      3035,
      3048
    },
    {
      4015,
      4046,
      40031,
      40032,
      40033,
      4083
    },
    "1006_force_logo",
    "taiyang_quanjing",
    "taiyang_banjing",
    "str_book_tag_faction_des_6",
    1,
    nil,
    "tujian_xiaozu_tiao7",
    "tujian_xiaozu_bg7",
    "tujian_force_logo7",
    "tujian_xiaozu_icon7",
    "tujian_xiaozu_diban7"
  },
  [1007] = {
    1007,
    1,
    "str_pet_tag_faction_name_7",
    {
      3015,
      3028,
      3033,
      3041,
      3043,
      3044,
      3045,
      3046,
      3049,
      3054,
      3058,
      3061,
      3066
    },
    {
      4001,
      4011,
      4036,
      4041,
      4045,
      4047,
      4048,
      4049,
      4051,
      4055,
      4058,
      4059,
      4061,
      4062,
      4063,
      4064,
      4070,
      4077,
      4082,
      40011,
      40012,
      40014,
      40017,
      40018,
      40028,
      40039,
      4081,
      40056
    },
    nil,
    common[1],
    common[2],
    "str_book_tag_faction_des_7",
    1,
    nil,
    "tujian_xiaozu_tiao8",
    "tujian_xiaozu_bg8",
    "tujian_force_logo8",
    "tujian_xiaozu_icon8",
    "tujian_xiaozu_diban8"
  },
  [1008] = {
    1008,
    1,
    "str_pet_tag_faction_name_8",
    {
      3016,
      3017,
      3018,
      3023,
      3021,
      3026,
      3019,
      3020,
      3025,
      3024,
      3036,
      3037,
      3051,
      3052,
      3059
    },
    {40013, 40044},
    nil,
    common[1],
    common[2],
    "str_book_tag_faction_des_8",
    2,
    nil,
    "tujian_xiaozu_tiao6",
    "tujian_xiaozu_bg6",
    "tujian_force_logo4",
    "tujian_xiaozu_icon6",
    "tujian_xiaozu_diban6"
  },
  [1009] = {
    1009,
    1,
    "str_book_force_long_name",
    {
      3063,
      3064,
      3067
    },
    {
      40022,
      40020,
      40027
    },
    "1009_force_logo",
    "longzhou_quanjing",
    "longzhou_banjing",
    "str_book_force_long_desc",
    1,
    nil,
    "tujian_xiaozu_tiao9",
    "tujian_xiaozu_bg9",
    "tujian_force_logo9",
    "tujian_xiaozu_icon9",
    "tujian_xiaozu_diban9"
  },
  [2001] = {
    2001,
    2,
    "str_pet_tag_job_name_color_change",
    empty,
    empty
  },
  [2002] = {
    2002,
    2,
    "str_pet_tag_job_name_return_blood",
    empty,
    empty
  },
  [2003] = {
    2003,
    2,
    "str_pet_tag_job_name_attack",
    empty,
    empty
  },
  [2004] = {
    2004,
    2,
    "str_pet_tag_job_name_function",
    empty,
    empty
  },
  [3001] = {
    3001,
    3,
    "str_book_pet_tag_friend_1",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_1",
    nil,
    "tujian_heying_0501_bg"
  },
  [3002] = {
    3002,
    3,
    "str_book_pet_tag_friend_2",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_2",
    nil,
    "tujian_heying_0502_bg"
  },
  [3003] = {
    3003,
    3,
    "str_book_pet_tag_friend_3",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_3",
    nil,
    "tujian_heying_0503_bg"
  },
  [3004] = {
    3004,
    3,
    "str_book_pet_tag_friend_4",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_4",
    nil,
    "tujian_heying_0101_bg"
  },
  [3005] = {
    3005,
    3,
    "str_book_pet_tag_friend_5",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_5",
    nil,
    "tujian_heying_0102_bg"
  },
  [3006] = {
    3006,
    3,
    "str_book_pet_tag_friend_6",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_6",
    nil,
    "tujian_heying_0103_bg"
  },
  [3007] = {
    3007,
    3,
    "str_book_pet_tag_friend_7",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_7",
    nil,
    "tujian_heying_0104_bg"
  },
  [3008] = {
    3008,
    3,
    "str_book_pet_tag_friend_8",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_8",
    nil,
    "tujian_heying_0201_bg"
  },
  [3009] = {
    3009,
    3,
    "str_book_pet_tag_friend_9",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_9",
    nil,
    "tujian_heying_0202_bg"
  },
  [3010] = {
    3010,
    3,
    "str_book_pet_tag_friend_10",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_10",
    nil,
    "tujian_heying_0301_bg"
  },
  [3011] = {
    3011,
    3,
    "str_book_pet_tag_friend_11",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_11",
    nil,
    "tujian_heying_0701_bg"
  },
  [3012] = {
    3012,
    3,
    "str_book_pet_tag_friend_12",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_12",
    nil,
    "tujian_heying_0401_bg"
  },
  [3013] = {
    3013,
    3,
    "str_book_pet_tag_friend_13",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_13",
    nil,
    "tujian_heying_0402_bg"
  },
  [3014] = {
    3014,
    3,
    "str_book_pet_tag_friend_14",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_14",
    nil,
    "tujian_heying_0403_bg"
  },
  [3015] = {
    3015,
    3,
    "str_book_pet_tag_friend_15",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_15",
    nil,
    "tujian_heying_0801_bg"
  },
  [3016] = {
    3016,
    3,
    "str_book_pet_tag_friend_16",
    empty,
    empty
  },
  [3017] = {
    3017,
    3,
    "str_book_pet_tag_friend_17",
    empty,
    empty
  },
  [3018] = {
    3018,
    3,
    "str_book_pet_tag_friend_18",
    empty,
    empty
  },
  [3019] = {
    3019,
    3,
    "str_book_pet_tag_friend_19",
    empty,
    empty
  },
  [3020] = {
    3020,
    3,
    "str_book_pet_tag_friend_20",
    empty,
    empty
  },
  [3021] = {
    3021,
    3,
    "str_book_pet_tag_friend_21",
    empty,
    empty
  },
  [3022] = {
    3022,
    3,
    "str_book_pet_tag_friend_22",
    empty,
    empty
  },
  [3023] = {
    3023,
    3,
    "str_book_pet_tag_friend_23",
    empty,
    empty
  },
  [3024] = {
    3024,
    3,
    "str_book_pet_tag_friend_24",
    empty,
    empty
  },
  [3025] = {
    3025,
    3,
    "str_book_pet_tag_friend_25",
    empty,
    empty
  },
  [3026] = {
    3026,
    3,
    "str_book_pet_tag_friend_26",
    empty,
    empty
  },
  [3027] = {
    3027,
    3,
    "str_book_pet_tag_friend_27",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_27",
    nil,
    "tujian_heying_0504_bg"
  },
  [3028] = {
    3028,
    3,
    "str_book_pet_tag_friend_28",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_28",
    nil,
    "tujian_heying_0802_bg"
  },
  [3029] = {
    3029,
    3,
    "str_book_pet_tag_friend_29",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_29",
    nil,
    "tujian_heying_0204_bg"
  },
  [3030] = {
    3030,
    3,
    "str_book_pet_tag_friend_30",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_30",
    nil,
    "tujian_heying_0203_bg"
  },
  [3031] = {
    3031,
    3,
    "str_book_pet_tag_friend_31",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_31",
    nil,
    "tujian_heying_0302_bg"
  },
  [3032] = {
    3032,
    3,
    "str_book_pet_tag_friend_32",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_32",
    nil,
    "tujian_heying_0404_bg"
  },
  [3033] = {
    3033,
    3,
    "str_book_pet_tag_friend_33",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_33",
    nil,
    "tujian_heying_0803_bg"
  },
  [3034] = {
    3034,
    3,
    "str_book_pet_tag_friend_34",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_34"
  },
  [3035] = {
    3035,
    3,
    "str_book_pet_tag_friend_35",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_35",
    nil,
    "tujian_heying_0702_bg"
  },
  [3036] = {
    3036,
    3,
    "str_book_pet_tag_friend_36",
    empty,
    empty
  },
  [3037] = {
    3037,
    3,
    "str_book_pet_tag_friend_37",
    empty,
    empty
  },
  [3038] = {
    3038,
    3,
    "str_book_pet_tag_friend_38",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_36",
    nil,
    "tujian_heying_0205_bg"
  },
  [3039] = {
    3039,
    3,
    "str_book_pet_tag_friend_39",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_37",
    nil,
    "tujian_heying_0105_bg"
  },
  [3040] = {
    3040,
    3,
    "str_book_pet_tag_friend_40",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_38",
    nil,
    "tujian_heying_0505_bg"
  },
  [3041] = {
    3041,
    3,
    "str_book_pet_tag_friend_41",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_39",
    nil,
    "tujian_heying_0804_bg"
  },
  [3042] = {
    3042,
    3,
    "str_book_pet_tag_friend_42",
    empty,
    empty
  },
  [3043] = {
    3043,
    3,
    "str_book_pet_tag_friend_43",
    empty,
    empty
  },
  [3044] = {
    3044,
    3,
    "str_book_pet_tag_friend_44",
    empty,
    empty
  },
  [3045] = {
    3045,
    3,
    "str_book_pet_tag_friend_45",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_40",
    nil,
    "tujian_heying_0805_bg"
  },
  [3046] = {
    3046,
    3,
    "str_book_pet_tag_friend_46",
    empty,
    empty
  },
  [3047] = {
    3047,
    3,
    "str_book_pet_tag_friend_47",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_41",
    nil,
    "tujian_heying_0405_bg"
  },
  [3048] = {
    3048,
    3,
    "str_book_pet_tag_friend_48",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_42",
    nil,
    "tujian_heying_0703_bg"
  },
  [3049] = {
    3049,
    3,
    "str_book_pet_tag_friend_49",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_43",
    nil,
    "tujian_heying_0806_bg"
  },
  [3050] = {
    3050,
    3,
    "str_book_pet_tag_friend_50",
    empty,
    empty
  },
  [3051] = {
    3051,
    3,
    "str_book_pet_tag_friend_51",
    empty,
    empty
  },
  [3052] = {
    3052,
    3,
    "str_book_pet_tag_friend_52",
    empty,
    empty
  },
  [3053] = {
    3053,
    3,
    "str_book_pet_tag_friend_53",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_44",
    nil,
    "tujian_heying_0807_bg"
  },
  [3054] = {
    3054,
    3,
    "str_book_pet_tag_friend_54",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_45",
    nil,
    "tujian_heying_0808_bg"
  },
  [3055] = {
    3055,
    3,
    "str_book_pet_tag_friend_55",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_46",
    nil,
    "tujian_heying_0106_bg"
  },
  [3056] = {
    3056,
    3,
    "str_book_pet_tag_friend_56",
    empty,
    empty
  },
  [3057] = {
    3057,
    3,
    "str_book_pet_tag_friend_57",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_47",
    nil,
    "tujian_heying_0107_bg"
  },
  [3058] = {
    3058,
    3,
    "str_book_pet_tag_friend_58",
    empty,
    empty
  },
  [3059] = {
    3059,
    3,
    "str_book_pet_tag_friend_59",
    empty,
    empty
  },
  [3060] = {
    3060,
    3,
    "str_book_pet_tag_friend_60",
    empty,
    empty
  },
  [3063] = {
    3063,
    3,
    "str_book_force_sgroup_name1",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_force_sgroup_desc1",
    nil,
    "tujian_heying_0901_bg"
  },
  [3064] = {
    3064,
    3,
    "str_book_force_sgroup_name2",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_force_sgroup_desc2",
    nil,
    "tujian_heying_0902_bg"
  },
  [3066] = {
    3066,
    3,
    "str_book_pet_tag_friend_66",
    empty,
    empty,
    nil,
    nil,
    nil,
    "str_book_tag_friend_des_66",
    nil,
    "tujian_heying_0809_bg"
  },
  [3067] = {
    3067,
    3,
    "str_book_pet_tag_friend_40032",
    empty,
    empty
  },
  [3061] = {
    3061,
    3,
    "str_book_pet_tag_friend_61",
    empty,
    empty
  },
  [3062] = {
    3062,
    3,
    "str_book_pet_tag_friend_62",
    empty,
    empty
  },
  [4001] = {
    4001,
    3,
    "",
    empty,
    empty
  },
  [4002] = {
    4002,
    3,
    "",
    empty,
    empty
  },
  [4003] = {
    4003,
    3,
    "",
    empty,
    empty
  },
  [4004] = {
    4004,
    3,
    "",
    empty,
    empty
  },
  [4005] = {
    4005,
    3,
    "",
    empty,
    empty
  },
  [4006] = {
    4006,
    3,
    "",
    empty,
    empty
  },
  [4007] = {
    4007,
    3,
    "",
    empty,
    empty
  },
  [4008] = {
    4008,
    3,
    "",
    empty,
    empty
  },
  [4009] = {
    4009,
    3,
    "",
    empty,
    empty
  },
  [4010] = {
    4010,
    3,
    "",
    empty,
    empty
  },
  [4011] = {
    4011,
    3,
    "",
    empty,
    empty
  },
  [4012] = {
    4012,
    3,
    "",
    empty,
    empty
  },
  [4013] = {
    4013,
    3,
    "",
    empty,
    empty
  },
  [4014] = {
    4014,
    3,
    "",
    empty,
    empty
  },
  [4015] = {
    4015,
    3,
    "",
    empty,
    empty
  },
  [4016] = {
    4016,
    3,
    "",
    empty,
    empty
  },
  [4017] = {
    4017,
    3,
    "",
    empty,
    empty
  },
  [4018] = {
    4018,
    3,
    "",
    empty,
    empty
  },
  [4019] = {
    4019,
    3,
    "",
    empty,
    empty
  },
  [4020] = {
    4020,
    3,
    "",
    empty,
    empty
  },
  [4021] = {
    4021,
    3,
    "",
    empty,
    empty
  },
  [4022] = {
    4022,
    3,
    "",
    empty,
    empty
  },
  [4023] = {
    4023,
    3,
    "",
    empty,
    empty
  },
  [4024] = {
    4024,
    3,
    "",
    empty,
    empty
  },
  [4025] = {
    4025,
    3,
    "",
    empty,
    empty
  },
  [4026] = {
    4026,
    3,
    "",
    empty,
    empty
  },
  [4027] = {
    4027,
    3,
    "",
    empty,
    empty
  },
  [4028] = {
    4028,
    3,
    "",
    empty,
    empty
  },
  [4029] = {
    4029,
    3,
    "",
    empty,
    empty
  },
  [4030] = {
    4030,
    3,
    "",
    empty,
    empty
  },
  [4031] = {
    4031,
    3,
    "",
    empty,
    empty
  },
  [4032] = {
    4032,
    3,
    "",
    empty,
    empty
  },
  [4033] = {
    4033,
    3,
    "",
    empty,
    empty
  },
  [4034] = {
    4034,
    3,
    "",
    empty,
    empty
  },
  [4035] = {
    4035,
    3,
    "",
    empty,
    empty
  },
  [4036] = {
    4036,
    3,
    "",
    empty,
    empty
  },
  [4037] = {
    4037,
    3,
    "",
    empty,
    empty
  },
  [4038] = {
    4038,
    3,
    "",
    empty,
    empty
  },
  [4039] = {
    4039,
    3,
    "",
    empty,
    empty
  },
  [4040] = {
    4040,
    3,
    "",
    empty,
    empty
  },
  [4041] = {
    4041,
    3,
    "",
    empty,
    empty
  },
  [4042] = {
    4042,
    3,
    "",
    empty,
    empty
  },
  [4043] = {
    4043,
    3,
    "",
    empty,
    empty
  },
  [4044] = {
    4044,
    3,
    "",
    empty,
    empty
  },
  [4045] = {
    4045,
    3,
    "",
    empty,
    empty
  },
  [4046] = {
    4046,
    3,
    "",
    empty,
    empty
  },
  [4047] = {
    4047,
    3,
    "",
    empty,
    empty
  },
  [4048] = {
    4048,
    3,
    "",
    empty,
    empty
  },
  [4049] = {
    4049,
    3,
    "",
    empty,
    empty
  },
  [4050] = {
    4050,
    3,
    "",
    empty,
    empty
  },
  [4051] = {
    4051,
    3,
    "",
    empty,
    empty
  },
  [4052] = {
    4052,
    3,
    "",
    empty,
    empty
  },
  [4053] = {
    4053,
    3,
    "",
    empty,
    empty
  },
  [4054] = {
    4054,
    3,
    "",
    empty,
    empty
  },
  [4055] = {
    4055,
    3,
    "",
    empty,
    empty
  },
  [4056] = {
    4056,
    3,
    "",
    empty,
    empty
  },
  [4057] = {
    4057,
    3,
    "",
    empty,
    empty
  },
  [4058] = {
    4058,
    3,
    "",
    empty,
    empty
  },
  [4059] = {
    4059,
    3,
    "",
    empty,
    empty
  },
  [4060] = {
    4060,
    3,
    "",
    empty,
    empty
  },
  [4061] = {
    4061,
    3,
    "",
    empty,
    empty
  },
  [4062] = {
    4062,
    3,
    "",
    empty,
    empty
  },
  [4063] = {
    4063,
    3,
    "",
    empty,
    empty
  },
  [4064] = {
    4064,
    3,
    "",
    empty,
    empty
  },
  [4065] = {
    4065,
    3,
    "",
    empty,
    empty
  },
  [4066] = {
    4066,
    3,
    "",
    empty,
    empty
  },
  [4067] = {
    4067,
    3,
    "",
    empty,
    empty
  },
  [4068] = {
    4068,
    3,
    "",
    empty,
    empty
  },
  [4069] = {
    4069,
    3,
    "",
    empty,
    empty
  },
  [4070] = {
    4070,
    3,
    "",
    empty,
    empty
  },
  [4071] = {
    4071,
    3,
    "",
    empty,
    empty
  },
  [4072] = {
    4072,
    3,
    "",
    empty,
    empty
  },
  [4073] = {
    4073,
    3,
    "",
    empty,
    empty
  },
  [4074] = {
    4074,
    3,
    "",
    empty,
    empty
  },
  [4075] = {
    4075,
    3,
    "",
    empty,
    empty
  },
  [4076] = {
    4076,
    3,
    "",
    empty,
    empty
  },
  [4077] = {
    4077,
    3,
    "",
    empty,
    empty
  },
  [4078] = {
    4078,
    3,
    "",
    empty,
    empty
  },
  [4079] = {
    4079,
    3,
    "",
    empty,
    empty
  },
  [4080] = {
    4080,
    3,
    "",
    empty,
    empty
  },
  [4081] = {
    4081,
    3,
    "",
    empty,
    empty
  },
  [4082] = {
    4082,
    3,
    "",
    empty,
    empty
  },
  [4083] = {
    4083,
    3,
    "",
    empty,
    empty
  },
  [40001] = {
    40001,
    3,
    "",
    empty,
    empty
  },
  [40002] = {
    40002,
    3,
    "",
    empty,
    empty
  },
  [40009] = {
    40009,
    3,
    "",
    empty,
    empty
  },
  [40010] = {
    40010,
    3,
    "",
    empty,
    empty
  },
  [40011] = {
    40011,
    3,
    "",
    empty,
    empty
  },
  [40012] = {
    40012,
    3,
    "",
    empty,
    empty
  },
  [40013] = {
    40013,
    3,
    "",
    empty,
    empty
  },
  [40014] = {
    40014,
    3,
    "",
    empty,
    empty
  },
  [40015] = {
    40015,
    3,
    "",
    empty,
    empty
  },
  [40016] = {
    40016,
    3,
    "",
    empty,
    empty
  },
  [40017] = {
    40017,
    3,
    "",
    empty,
    empty
  },
  [40018] = {
    40018,
    3,
    "",
    empty,
    empty
  },
  [40019] = {
    40019,
    3,
    "",
    empty,
    empty
  },
  [40020] = {
    40020,
    3,
    "",
    empty,
    empty
  },
  [40022] = {
    40022,
    3,
    "",
    empty,
    empty
  },
  [40023] = {
    40023,
    3,
    "",
    empty,
    empty
  },
  [40024] = {
    40024,
    3,
    "",
    empty,
    empty
  },
  [40025] = {
    40025,
    3,
    "",
    empty,
    empty
  },
  [40026] = {
    40026,
    3,
    "",
    empty,
    empty
  },
  [3065] = {
    3065,
    3,
    "str_book_pet_tag_friend_65",
    empty,
    empty
  },
  [40027] = {
    40027,
    3,
    "",
    empty,
    empty
  },
  [40028] = {
    40028,
    3,
    "",
    empty,
    empty
  },
  [40029] = {
    40029,
    3,
    "",
    empty,
    empty
  },
  [40044] = {
    40044,
    3,
    "",
    empty,
    empty
  },
  [40039] = {
    40039,
    3,
    "",
    empty,
    empty
  },
  [40030] = {
    40030,
    3,
    "",
    empty,
    empty
  },
  [40031] = {
    40031,
    3,
    "",
    empty,
    empty
  },
  [40032] = {
    40032,
    3,
    "",
    empty,
    empty
  },
  [40033] = {
    40033,
    3,
    "",
    empty,
    empty
  },
  [40056] = {
    40056,
    3,
    "",
    empty,
    empty
  }
}
return config, "ID", key
