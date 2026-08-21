local key = {
  ID = 1,
  icon = 2,
  attrIcon = 3,
  attColor = 4
}
local common = {
  "bing",
  "0,143,255|0,143,255",
  "bing_bing",
  "bing_huo",
  "bing_sen",
  "bing_lei",
  "huo",
  "222,8,5|222,8,5",
  "huo_bing",
  "huo_huo",
  "huo_sen",
  "huo_lei",
  "sen",
  "170,208,16|170,208,16",
  "sen_bing",
  "sen_huo",
  "sen_sen",
  "sen_lei",
  "lei",
  "255,184,7|255,184,7",
  "lei_bing",
  "lei_huo",
  "lei_sen",
  "lei_lei"
}
local config = {
  ["1_0"] = {
    "1_0",
    common[1],
    common[1],
    common[2]
  },
  ["1_1"] = {
    "1_1",
    common[3],
    common[3],
    common[2]
  },
  ["1_2"] = {
    "1_2",
    common[4],
    common[4],
    common[2]
  },
  ["1_3"] = {
    "1_3",
    common[5],
    common[5],
    common[2]
  },
  ["1_4"] = {
    "1_4",
    common[6],
    common[6],
    common[2]
  },
  ["2_0"] = {
    "2_0",
    common[7],
    common[7],
    common[8]
  },
  ["2_1"] = {
    "2_1",
    common[9],
    common[9],
    common[8]
  },
  ["2_2"] = {
    "2_2",
    common[10],
    common[10],
    common[8]
  },
  ["2_3"] = {
    "2_3",
    common[11],
    common[11],
    common[8]
  },
  ["2_4"] = {
    "2_4",
    common[12],
    common[12],
    common[8]
  },
  ["3_0"] = {
    "3_0",
    common[13],
    common[13],
    common[14]
  },
  ["3_1"] = {
    "3_1",
    common[15],
    common[15],
    common[14]
  },
  ["3_2"] = {
    "3_2",
    common[16],
    common[16],
    common[14]
  },
  ["3_3"] = {
    "3_3",
    common[17],
    common[17],
    common[14]
  },
  ["3_4"] = {
    "3_4",
    common[18],
    common[18],
    common[14]
  },
  ["4_0"] = {
    "4_0",
    common[19],
    common[19],
    common[20]
  },
  ["4_1"] = {
    "4_1",
    common[21],
    common[21],
    common[20]
  },
  ["4_2"] = {
    "4_2",
    common[22],
    common[22],
    common[20]
  },
  ["4_3"] = {
    "4_3",
    common[23],
    common[23],
    common[20]
  },
  ["4_4"] = {
    "4_4",
    common[24],
    common[24],
    common[20]
  }
}
return config, "ID", key
