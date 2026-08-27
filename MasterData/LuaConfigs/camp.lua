local camp = {
  {
    bond_icon = "bond_1",
    camp_audio = 4004,
    camp_info = 254327,
    camp_info_audio = 4051,
    camp_video_path = "energy",
    editor_filter_name = 387183,
    name = 387183
  },
  {
    bond_icon = "bond_2",
    camp_audio = 4000,
    camp_info = 64248,
    camp_info_audio = 4052,
    editor_filter_name = "42LAB",
    icon = "2_camp",
    id = 2
  },
  {
    bond_icon = "bond_3",
    camp_audio = 4001,
    camp_info = 466113,
    camp_info_audio = 4053,
    camp_video_path = "dna",
    editor_filter_name = 23549,
    icon = "3_camp",
    id = 3,
    name = 28609
  },
  {
    bond_icon = "bond_4",
    camp_audio = 4003,
    camp_info_audio = 4054,
    camp_video_path = "cyber",
    editor_filter_name = 11829,
    icon = "4_camp",
    id = 4,
    name = 11829
  },
  {
    bond_icon = "bond_5",
    camp_audio = 4002,
    camp_info = 425373,
    camp_info_audio = 4055,
    camp_video_path = "global",
    editor_filter_name = 14040,
    icon = "5_camp",
    id = 5,
    name = 444397
  },
  {
    camp_audio = 4005,
    camp_info = 147413,
    camp_info_audio = 4056,
    camp_video_path = "purifier",
    icon = "6_camp",
    id = 6,
    name = 256780,
    sort = 1
  },
  {
    camp_info = 19645,
    camp_video_path = "entropy",
    icon = "7_camp",
    id = 7,
    name = 508398,
    sort = 1
  },
  {
    camp_audio = 4006,
    camp_info = 83253,
    camp_info_audio = 4057,
    camp_video_path = "alternatives",
    icon = "8_camp",
    id = 8,
    name = 399983,
    sort = 1
  }
}
local __default_values = {
  bond_icon = "bond_6",
  camp_audio = 1290,
  camp_info = 110254,
  camp_info_audio = 1295,
  camp_video_path = "42lab",
  editor_filter_name = 431933,
  exclude = 0,
  icon = "1_camp",
  id = 1,
  name = "42LAB",
  sort = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(camp) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  camp2HeroListDic = {
    {
      1004,
      1005,
      1007,
      1010,
      1024,
      1027,
      1032,
      1034,
      1041,
      1043,
      1047,
      1049,
      1056,
      1058,
      1067,
      1072,
      1073,
      1079,
      1083,
      1087,
      1091
    },
    {
      1001,
      1002,
      1003,
      1006,
      1009,
      1011,
      1012,
      1019,
      1020,
      1037,
      1042,
      1045,
      1055,
      1057,
      1071,
      1093
    },
    {
      1015,
      1018,
      1023,
      1028,
      1031,
      1033,
      1052,
      1065,
      1084,
      1085,
      1089
    },
    {
      1016,
      1021,
      1025,
      1026,
      1029,
      1044,
      1046,
      1048,
      1050,
      1051,
      1053,
      1054,
      1061,
      1062,
      1063,
      1082
    },
    {
      1008,
      1013,
      1014,
      1017,
      1022,
      1030,
      1035,
      1036,
      1038,
      1039,
      1040,
      1059,
      1060,
      1064,
      1066,
      1069,
      1070,
      1075,
      1080,
      1081,
      1086,
      1092
    },
    {1068, 1088},
    {1074, 1090},
    {
      1076,
      1077,
      1078
    }
  },
  camp2HeroNumDic = {
    21,
    16,
    11,
    16,
    22,
    2,
    2,
    3
  }
}
setmetatable(camp, {__index = __rawdata})
return camp
