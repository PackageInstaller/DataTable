local key = {
  ID = 1,
  desc = 2,
  EnterType = 3,
  EnterName = 4,
  BG = 5,
  RecommendGrade = 6,
  RecommendLv = 7,
  ShowItemWidth = 8
}
local common = {
  "1500331_cg",
  "str_lost_land_name_7001",
  "str_lost_land_name_7002",
  "str_lost_land_name_7003",
  {500, 300}
}
local config = {
  [9900101] = {
    9900101,
    "第1期-普通",
    1,
    common[2],
    common[1],
    1,
    1,
    common[5]
  },
  [9900102] = {
    9900102,
    "第1期-困难",
    2,
    common[3],
    common[1],
    1,
    2,
    common[5]
  },
  [9900103] = {
    9900103,
    "第1期-噩梦",
    3,
    common[4],
    common[1],
    1,
    3,
    common[5]
  },
  [9900201] = {
    9900201,
    "第2期-普通",
    1,
    common[2],
    common[1],
    1,
    1,
    common[5]
  },
  [9900202] = {
    9900202,
    "第2期-困难",
    2,
    common[3],
    common[1],
    1,
    2,
    common[5]
  },
  [9900203] = {
    9900203,
    "第2期-噩梦",
    3,
    common[4],
    common[1],
    1,
    3,
    common[5]
  },
  [9900301] = {
    9900301,
    "第3期-普通",
    1,
    common[2],
    common[1],
    1,
    1,
    common[5]
  },
  [9900302] = {
    9900302,
    "第3期-困难",
    2,
    common[3],
    common[1],
    1,
    2,
    common[5]
  },
  [9900303] = {
    9900303,
    "第3期-噩梦",
    3,
    common[4],
    common[1],
    1,
    3,
    common[5]
  },
  [9900401] = {
    9900401,
    "第4期-普通",
    1,
    common[2],
    common[1],
    1,
    1,
    common[5]
  },
  [9900402] = {
    9900402,
    "第4期-困难",
    2,
    common[3],
    common[1],
    1,
    2,
    common[5]
  },
  [9900403] = {
    9900403,
    "第4期-噩梦",
    3,
    common[4],
    common[1],
    1,
    3,
    common[5]
  },
  [9900501] = {
    9900501,
    "第5期-普通",
    1,
    common[2],
    common[1],
    1,
    1,
    common[5]
  },
  [9900502] = {
    9900502,
    "第5期-困难",
    2,
    common[3],
    common[1],
    1,
    2,
    common[5]
  },
  [9900503] = {
    9900503,
    "第5期-噩梦",
    3,
    common[4],
    common[1],
    1,
    3,
    common[5]
  },
  [9900601] = {
    9900601,
    "第6期-普通",
    1,
    common[2],
    common[1],
    1,
    1,
    common[5]
  },
  [9900602] = {
    9900602,
    "第6期-困难",
    2,
    common[3],
    common[1],
    1,
    2,
    common[5]
  },
  [9900603] = {
    9900603,
    "第6期-噩梦",
    3,
    common[4],
    common[1],
    1,
    3,
    common[5]
  },
  [9900701] = {
    9900701,
    "第7期-普通",
    1,
    common[2],
    common[1],
    1,
    1,
    common[5]
  },
  [9900702] = {
    9900702,
    "第7期-困难",
    2,
    common[3],
    common[1],
    1,
    2,
    common[5]
  },
  [9900703] = {
    9900703,
    "第7期-噩梦",
    3,
    common[4],
    common[1],
    1,
    3,
    common[5]
  },
  [9900801] = {
    9900801,
    "第8期-普通",
    1,
    common[2],
    common[1],
    1,
    1,
    common[5]
  },
  [9900802] = {
    9900802,
    "第8期-困难",
    2,
    common[3],
    common[1],
    1,
    2,
    common[5]
  },
  [9900803] = {
    9900803,
    "第8期-噩梦",
    3,
    common[4],
    common[1],
    1,
    3,
    common[5]
  }
}
return config, "ID", key
