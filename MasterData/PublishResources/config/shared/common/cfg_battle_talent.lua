local key = {
  ID = 1,
  Name = 2,
  MaxLevel = 3,
  Type = 4,
  Param = 5,
  Icon = 6,
  Desc = 7
}
local common = {
  "str_season_talent_tree_skill_name_101",
  "icon_talent_tree_small_01",
  "str_season_talent_tree_skill_desc_101",
  "str_season_talent_tree_skill_name_201",
  "icon_talent_tree_small_02",
  "str_season_talent_tree_skill_desc_201",
  "str_season_talent_tree_skill_name_301",
  "icon_talent_tree_small_03",
  "str_season_talent_tree_skill_desc_301",
  "str_season_talent_tree_skill_name_401",
  "icon_talent_tree_small_04",
  "str_season_talent_tree_skill_desc_401",
  "str_season_talent_tree_skill_name_501",
  "icon_talent_tree_small_05",
  "str_season_talent_tree_skill_desc_501",
  "str_season_talent_tree_skill_name_100",
  "icon_talent_tree_big_01",
  "str_season_talent_tree_skill_desc_1001",
  "str_season_talent_tree_skill_desc_1002",
  "str_season_talent_tree_skill_desc_1003",
  "str_season_talent_tree_skill_desc_1004",
  "str_season_talent_tree_skill_desc_1005",
  "str_season_talent_tree_skill_desc_1006",
  "str_season_talent_tree_skill_name_200",
  "icon_talent_tree_big_02",
  "str_season_talent_tree_skill_desc_2001",
  "str_season_talent_tree_skill_desc_2002",
  "str_season_talent_tree_skill_desc_2003",
  "str_season_talent_tree_skill_desc_2004",
  "str_season_talent_tree_skill_desc_2005",
  "str_season_talent_tree_skill_desc_2006",
  "str_season_talent_tree_skill_name_300",
  "icon_talent_tree_big_03",
  "str_season_talent_tree_skill_desc_3001",
  "str_season_talent_tree_skill_desc_3002",
  "str_season_talent_tree_skill_desc_3003",
  "str_season_talent_tree_skill_desc_3004",
  "str_season_talent_tree_skill_desc_3005",
  "str_season_talent_tree_skill_desc_3006",
  "str_season_talent_tree_skill_name_400",
  "icon_talent_tree_big_04",
  "str_season_talent_tree_skill_desc_4001",
  "str_season_talent_tree_skill_desc_4002",
  "str_season_talent_tree_skill_desc_4003",
  "str_season_talent_tree_skill_desc_4004",
  "str_season_talent_tree_skill_desc_4005",
  "str_season_talent_tree_skill_desc_4006",
  "str_season_talent_tree_skill_name_500",
  "icon_talent_tree_big_05",
  "str_season_talent_tree_skill_desc_5001",
  "str_season_talent_tree_skill_desc_5002",
  "str_season_talent_tree_skill_desc_5003",
  "str_season_talent_tree_skill_desc_5004",
  "str_season_talent_tree_skill_desc_5005",
  "str_season_talent_tree_skill_desc_5006",
  "str_season_talent_tree_skill_name_102",
  "icon_talent_tree_small_06",
  "str_season_talent_tree_skill_desc_1021",
  "str_season_talent_tree_skill_desc_1022",
  "str_season_talent_tree_skill_name_103",
  "icon_talent_tree_small_07",
  "str_season_talent_tree_skill_desc_1031",
  "str_season_talent_tree_skill_desc_1032",
  "str_season_talent_tree_skill_name_202",
  "icon_talent_tree_small_08",
  "str_season_talent_tree_skill_desc_2021",
  "str_season_talent_tree_skill_desc_2022",
  "str_season_talent_tree_skill_name_203",
  "icon_talent_tree_small_09",
  "str_season_talent_tree_skill_desc_2031",
  "str_season_talent_tree_skill_desc_2032",
  "str_season_talent_tree_skill_name_302",
  "icon_talent_tree_small_012",
  "str_season_talent_tree_skill_desc_3021",
  "str_season_talent_tree_skill_desc_3022",
  "str_season_talent_tree_skill_name_303",
  "icon_talent_tree_small_011",
  "str_season_talent_tree_skill_desc_3031",
  "str_season_talent_tree_skill_desc_3032",
  "str_season_talent_tree_skill_name_402",
  "icon_talent_tree_small_010",
  "str_season_talent_tree_skill_desc_4021",
  "str_season_talent_tree_skill_desc_4022",
  "str_season_talent_tree_skill_name_403",
  "icon_talent_tree_small_013",
  "str_season_talent_tree_skill_desc_4031",
  "str_season_talent_tree_skill_desc_4032",
  "str_season_talent_tree_skill_name_502",
  "icon_talent_tree_small_015",
  "str_season_talent_tree_skill_desc_5021",
  "str_season_talent_tree_skill_desc_5022",
  "str_season_talent_tree_skill_name_503",
  "icon_talent_tree_small_014",
  "str_season_talent_tree_skill_desc_5031",
  "str_season_talent_tree_skill_desc_5032",
  "str_cn20_n49_talent_tree_skill_name_100",
  "str_cn20_n49_talent_tree_skill_name_200",
  "str_cn20_n49_talent_tree_skill_name_300",
  "str_cn20_n49_talent_tree_skill_name_400",
  "str_cn20_n49_talent_tree_skill_name_500",
  {
    feature = {
      [20001] = {SkillID = 802401}
    }
  },
  {
    feature = {
      [20002] = {SkillID = 802402}
    }
  },
  {
    feature = {
      [20003] = {SkillID = 802403}
    }
  },
  {
    feature = {
      [20004] = {SkillID = 802404}
    }
  },
  {
    feature = {
      [20005] = {SkillID = 802405}
    }
  },
  {
    BuffIDList = {80240101},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240102},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240103},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240104},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240105},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240106},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240201},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240202},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240203},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240204},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240205},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240206},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240301},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240302},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240303},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240304},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240305},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240306},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240401},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240402},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240403},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240404},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240405},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240406},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240501},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240502},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240503},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240504},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240505},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240506},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240111},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240121},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240211},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240221},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240311},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240321},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240411},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240421},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240711},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240721},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240611},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240621},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240511},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240521},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240811},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240821},
    BuffTargetType = 8
  },
  {
    BuffIDList = {80240911},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80240921},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80241011},
    BuffTargetType = 9
  },
  {
    BuffIDList = {80241021},
    BuffTargetType = 9
  }
}
local config = {
  [101001] = {
    101001,
    common[1],
    1,
    2,
    common[101],
    common[2],
    common[3]
  },
  [201001] = {
    201001,
    common[4],
    1,
    2,
    common[102],
    common[5],
    common[6]
  },
  [301001] = {
    301001,
    common[7],
    1,
    2,
    common[103],
    common[8],
    common[9]
  },
  [401001] = {
    401001,
    common[10],
    1,
    2,
    common[104],
    common[11],
    common[12]
  },
  [501001] = {
    501001,
    common[13],
    1,
    2,
    common[105],
    common[14],
    common[15]
  },
  [100001] = {
    100001,
    common[16],
    6,
    1,
    common[106],
    common[17],
    common[18]
  },
  [100002] = {
    100002,
    common[16],
    6,
    1,
    common[107],
    common[17],
    common[19]
  },
  [100003] = {
    100003,
    common[16],
    6,
    1,
    common[108],
    common[17],
    common[20]
  },
  [100004] = {
    100004,
    common[16],
    6,
    1,
    common[109],
    common[17],
    common[21]
  },
  [100005] = {
    100005,
    common[16],
    6,
    1,
    common[110],
    common[17],
    common[22]
  },
  [100006] = {
    100006,
    common[16],
    6,
    1,
    common[111],
    common[17],
    common[23]
  },
  [200001] = {
    200001,
    common[24],
    6,
    1,
    common[112],
    common[25],
    common[26]
  },
  [200002] = {
    200002,
    common[24],
    6,
    1,
    common[113],
    common[25],
    common[27]
  },
  [200003] = {
    200003,
    common[24],
    6,
    1,
    common[114],
    common[25],
    common[28]
  },
  [200004] = {
    200004,
    common[24],
    6,
    1,
    common[115],
    common[25],
    common[29]
  },
  [200005] = {
    200005,
    common[24],
    6,
    1,
    common[116],
    common[25],
    common[30]
  },
  [200006] = {
    200006,
    common[24],
    6,
    1,
    common[117],
    common[25],
    common[31]
  },
  [300001] = {
    300001,
    common[32],
    6,
    1,
    common[118],
    common[33],
    common[34]
  },
  [300002] = {
    300002,
    common[32],
    6,
    1,
    common[119],
    common[33],
    common[35]
  },
  [300003] = {
    300003,
    common[32],
    6,
    1,
    common[120],
    common[33],
    common[36]
  },
  [300004] = {
    300004,
    common[32],
    6,
    1,
    common[121],
    common[33],
    common[37]
  },
  [300005] = {
    300005,
    common[32],
    6,
    1,
    common[122],
    common[33],
    common[38]
  },
  [300006] = {
    300006,
    common[32],
    6,
    1,
    common[123],
    common[33],
    common[39]
  },
  [400001] = {
    400001,
    common[40],
    6,
    1,
    common[124],
    common[41],
    common[42]
  },
  [400002] = {
    400002,
    common[40],
    6,
    1,
    common[125],
    common[41],
    common[43]
  },
  [400003] = {
    400003,
    common[40],
    6,
    1,
    common[126],
    common[41],
    common[44]
  },
  [400004] = {
    400004,
    common[40],
    6,
    1,
    common[127],
    common[41],
    common[45]
  },
  [400005] = {
    400005,
    common[40],
    6,
    1,
    common[128],
    common[41],
    common[46]
  },
  [400006] = {
    400006,
    common[40],
    6,
    1,
    common[129],
    common[41],
    common[47]
  },
  [500001] = {
    500001,
    common[48],
    6,
    1,
    common[130],
    common[49],
    common[50]
  },
  [500002] = {
    500002,
    common[48],
    6,
    1,
    common[131],
    common[49],
    common[51]
  },
  [500003] = {
    500003,
    common[48],
    6,
    1,
    common[132],
    common[49],
    common[52]
  },
  [500004] = {
    500004,
    common[48],
    6,
    1,
    common[133],
    common[49],
    common[53]
  },
  [500005] = {
    500005,
    common[48],
    6,
    1,
    common[134],
    common[49],
    common[54]
  },
  [500006] = {
    500006,
    common[48],
    6,
    1,
    common[135],
    common[49],
    common[55]
  },
  [102001] = {
    102001,
    common[56],
    2,
    1,
    common[136],
    common[57],
    common[58]
  },
  [102002] = {
    102002,
    common[56],
    2,
    1,
    common[137],
    common[57],
    common[59]
  },
  [103001] = {
    103001,
    common[60],
    2,
    1,
    common[138],
    common[61],
    common[62]
  },
  [103002] = {
    103002,
    common[60],
    2,
    1,
    common[139],
    common[61],
    common[63]
  },
  [202001] = {
    202001,
    common[64],
    2,
    1,
    common[140],
    common[65],
    common[66]
  },
  [202002] = {
    202002,
    common[64],
    2,
    1,
    common[141],
    common[65],
    common[67]
  },
  [203001] = {
    203001,
    common[68],
    2,
    1,
    common[142],
    common[69],
    common[70]
  },
  [203002] = {
    203002,
    common[68],
    2,
    1,
    common[143],
    common[69],
    common[71]
  },
  [302001] = {
    302001,
    common[72],
    2,
    1,
    common[144],
    common[73],
    common[74]
  },
  [302002] = {
    302002,
    common[72],
    2,
    1,
    common[145],
    common[73],
    common[75]
  },
  [303001] = {
    303001,
    common[76],
    2,
    1,
    common[146],
    common[77],
    common[78]
  },
  [303002] = {
    303002,
    common[76],
    2,
    1,
    common[147],
    common[77],
    common[79]
  },
  [402001] = {
    402001,
    common[80],
    2,
    1,
    common[148],
    common[81],
    common[82]
  },
  [402002] = {
    402002,
    common[80],
    2,
    1,
    common[149],
    common[81],
    common[83]
  },
  [403001] = {
    403001,
    common[84],
    2,
    1,
    common[150],
    common[85],
    common[86]
  },
  [403002] = {
    403002,
    common[84],
    2,
    1,
    common[151],
    common[85],
    common[87]
  },
  [502001] = {
    502001,
    common[88],
    2,
    1,
    common[152],
    common[89],
    common[90]
  },
  [502002] = {
    502002,
    common[88],
    2,
    1,
    common[153],
    common[89],
    common[91]
  },
  [503001] = {
    503001,
    common[92],
    2,
    1,
    common[154],
    common[93],
    common[94]
  },
  [503002] = {
    503002,
    common[92],
    2,
    1,
    common[155],
    common[93],
    common[95]
  },
  [111001] = {
    111001,
    common[1],
    1,
    2,
    common[101],
    common[2],
    common[3]
  },
  [211001] = {
    211001,
    common[4],
    1,
    2,
    common[102],
    common[5],
    common[6]
  },
  [311001] = {
    311001,
    common[7],
    1,
    2,
    common[103],
    common[8],
    common[9]
  },
  [411001] = {
    411001,
    common[10],
    1,
    2,
    common[104],
    common[11],
    common[12]
  },
  [511001] = {
    511001,
    common[13],
    1,
    2,
    common[105],
    common[14],
    common[15]
  },
  [110001] = {
    110001,
    common[96],
    6,
    1,
    common[106],
    common[17],
    common[18]
  },
  [110002] = {
    110002,
    common[96],
    6,
    1,
    common[107],
    common[17],
    common[19]
  },
  [110003] = {
    110003,
    common[96],
    6,
    1,
    common[108],
    common[17],
    common[20]
  },
  [110004] = {
    110004,
    common[96],
    6,
    1,
    common[109],
    common[17],
    common[21]
  },
  [110005] = {
    110005,
    common[96],
    6,
    1,
    common[110],
    common[17],
    common[22]
  },
  [110006] = {
    110006,
    common[96],
    6,
    1,
    common[111],
    common[17],
    common[23]
  },
  [210001] = {
    210001,
    common[97],
    6,
    1,
    common[112],
    common[25],
    common[26]
  },
  [210002] = {
    210002,
    common[97],
    6,
    1,
    common[113],
    common[25],
    common[27]
  },
  [210003] = {
    210003,
    common[97],
    6,
    1,
    common[114],
    common[25],
    common[28]
  },
  [210004] = {
    210004,
    common[97],
    6,
    1,
    common[115],
    common[25],
    common[29]
  },
  [210005] = {
    210005,
    common[97],
    6,
    1,
    common[116],
    common[25],
    common[30]
  },
  [210006] = {
    210006,
    common[97],
    6,
    1,
    common[117],
    common[25],
    common[31]
  },
  [310001] = {
    310001,
    common[98],
    6,
    1,
    common[118],
    common[33],
    common[34]
  },
  [310002] = {
    310002,
    common[98],
    6,
    1,
    common[119],
    common[33],
    common[35]
  },
  [310003] = {
    310003,
    common[98],
    6,
    1,
    common[120],
    common[33],
    common[36]
  },
  [310004] = {
    310004,
    common[98],
    6,
    1,
    common[121],
    common[33],
    common[37]
  },
  [310005] = {
    310005,
    common[98],
    6,
    1,
    common[122],
    common[33],
    common[38]
  },
  [310006] = {
    310006,
    common[98],
    6,
    1,
    common[123],
    common[33],
    common[39]
  },
  [410001] = {
    410001,
    common[99],
    6,
    1,
    common[124],
    common[41],
    common[42]
  },
  [410002] = {
    410002,
    common[99],
    6,
    1,
    common[125],
    common[41],
    common[43]
  },
  [410003] = {
    410003,
    common[99],
    6,
    1,
    common[126],
    common[41],
    common[44]
  },
  [410004] = {
    410004,
    common[99],
    6,
    1,
    common[127],
    common[41],
    common[45]
  },
  [410005] = {
    410005,
    common[99],
    6,
    1,
    common[128],
    common[41],
    common[46]
  },
  [410006] = {
    410006,
    common[99],
    6,
    1,
    common[129],
    common[41],
    common[47]
  },
  [510001] = {
    510001,
    common[100],
    6,
    1,
    common[130],
    common[49],
    common[50]
  },
  [510002] = {
    510002,
    common[100],
    6,
    1,
    common[131],
    common[49],
    common[51]
  },
  [510003] = {
    510003,
    common[100],
    6,
    1,
    common[132],
    common[49],
    common[52]
  },
  [510004] = {
    510004,
    common[100],
    6,
    1,
    common[133],
    common[49],
    common[53]
  },
  [510005] = {
    510005,
    common[100],
    6,
    1,
    common[134],
    common[49],
    common[54]
  },
  [510006] = {
    510006,
    common[100],
    6,
    1,
    common[135],
    common[49],
    common[55]
  },
  [112001] = {
    112001,
    common[56],
    2,
    1,
    common[136],
    common[57],
    common[58]
  },
  [112002] = {
    112002,
    common[56],
    2,
    1,
    common[137],
    common[57],
    common[59]
  },
  [113001] = {
    113001,
    common[60],
    2,
    1,
    common[138],
    common[61],
    common[62]
  },
  [113002] = {
    113002,
    common[60],
    2,
    1,
    common[139],
    common[61],
    common[63]
  },
  [212001] = {
    212001,
    common[64],
    2,
    1,
    common[140],
    common[65],
    common[66]
  },
  [212002] = {
    212002,
    common[64],
    2,
    1,
    common[141],
    common[65],
    common[67]
  },
  [213001] = {
    213001,
    common[68],
    2,
    1,
    common[142],
    common[69],
    common[70]
  },
  [213002] = {
    213002,
    common[68],
    2,
    1,
    common[143],
    common[69],
    common[71]
  },
  [312001] = {
    312001,
    common[72],
    2,
    1,
    common[144],
    common[73],
    common[74]
  },
  [312002] = {
    312002,
    common[72],
    2,
    1,
    common[145],
    common[73],
    common[75]
  },
  [313001] = {
    313001,
    common[76],
    2,
    1,
    common[146],
    common[77],
    common[78]
  },
  [313002] = {
    313002,
    common[76],
    2,
    1,
    common[147],
    common[77],
    common[79]
  },
  [412001] = {
    412001,
    common[80],
    2,
    1,
    common[148],
    common[81],
    common[82]
  },
  [412002] = {
    412002,
    common[80],
    2,
    1,
    common[149],
    common[81],
    common[83]
  },
  [413001] = {
    413001,
    common[84],
    2,
    1,
    common[150],
    common[85],
    common[86]
  },
  [413002] = {
    413002,
    common[84],
    2,
    1,
    common[151],
    common[85],
    common[87]
  },
  [512001] = {
    512001,
    common[88],
    2,
    1,
    common[152],
    common[89],
    common[90]
  },
  [512002] = {
    512002,
    common[88],
    2,
    1,
    common[153],
    common[89],
    common[91]
  },
  [513001] = {
    513001,
    common[92],
    2,
    1,
    common[154],
    common[93],
    common[94]
  },
  [513002] = {
    513002,
    common[92],
    2,
    1,
    common[155],
    common[93],
    common[95]
  }
}
return config, "ID", key
