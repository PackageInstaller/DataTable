local key = {
  ID = 1,
  Name = 2,
  IsActive = 3,
  IsActivePos = 4,
  Tags = 5,
  Pos = 6,
  MapIcon = 7,
  ForceIcon = 8,
  CenterPos = 9
}
local common = {
  "str_pet_tag_faction_name_7",
  "n9_rsqb_sl08",
  "str_pet_tag_faction_name_6",
  "n9_rsqb_sl03"
}
local config = {
  {
    1,
    "str_book_force_bigpoint_name2",
    1,
    1,
    1001,
    {-52100, -9300},
    "n9_rsqb01_item01",
    "n9_rsqb_sl01",
    {-117600, -106100}
  },
  {
    2,
    "str_book_force_bigpoint_name1",
    1,
    1,
    1002,
    {-23000, 6500},
    "n9_rsqb01_item06",
    "n9_rsqb_sl06",
    {-67100, -82400}
  },
  {
    3,
    "str_book_force_bigpoint_name3",
    1,
    1,
    1003,
    {-80600, 12800},
    "n9_rsqb01_item07",
    "n9_rsqb_sl07",
    {-357300, -16100}
  },
  {
    4,
    "str_book_force_bigpoint_name5",
    1,
    1,
    1004,
    {-1400, 38500},
    "n9_rsqb01_item05",
    "n9_rsqb_sl05",
    {-54600, 129100}
  },
  {
    5,
    "str_book_force_bigpoint_name4",
    1,
    1,
    1005,
    {-81000, -22100},
    "n9_rsqb01_item02",
    "n9_rsqb_sl02",
    {-498000, -143300}
  },
  [7] = {
    7,
    common[1],
    0,
    0,
    1007,
    {21300, -12600},
    "n9_rsqb01_item08",
    common[2]
  },
  [8] = {
    8,
    common[1],
    1,
    1,
    1007,
    nil,
    nil,
    common[2],
    {183600, 90900}
  },
  [9] = {
    9,
    common[3],
    1,
    0,
    1006,
    nil,
    nil,
    common[4]
  },
  [10] = {
    10,
    "str_book_force_bigpoint_name6",
    1,
    1,
    1009,
    {84300, -11200},
    "n9_rsqb01_item09",
    "n9_rsqb_sl09",
    {398000, -14800}
  },
  [11] = {
    11,
    "str_pet_tag_faction_name_8",
    1,
    0,
    1008,
    nil,
    nil,
    "n9_rsqb_sl04"
  },
  [13] = {
    13,
    common[3],
    0,
    0,
    1006,
    {-51500, 19100},
    "n9_rsqb01_item10",
    common[4]
  }
}
return config, "ID", key
