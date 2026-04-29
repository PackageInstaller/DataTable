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
  "icon_talent_4",
  "icon_talent_5",
  "icon_talent_6",
  "icon_talent_14"
}
local config = {
  [1101] = {
    1101,
    "str_n25_talent_name_1101",
    1,
    2,
    {
      feature = {
        [7] = {SkillID = 5220012}
      }
    },
    "icon_talent_1",
    "str_n25_talent_desc_1101"
  },
  [1201] = {
    1201,
    "str_n25_talent_name_1201",
    5,
    1,
    {
      BuffIDList = {
        5259001,
        5259002,
        5259003,
        5259004,
        5259005
      },
      BuffTargetType = 8,
      BuffTargetTypeParam = {}
    },
    common[1],
    "str_n25_talent_desc_1201"
  },
  [1202] = {
    1202,
    "str_n25_talent_name_1202",
    5,
    1,
    {
      BuffIDList = {
        5259031,
        5259032,
        5259033,
        5259034,
        5259035
      },
      BuffTargetType = 8,
      BuffTargetTypeParam = {}
    },
    common[2],
    "str_n25_talent_desc_1202"
  },
  [1301] = {
    1301,
    "str_n25_talent_name_1301",
    1,
    2,
    {
      feature = {
        [5] = {SkillID = 5220011}
      }
    },
    "icon_talent_3",
    "str_n25_talent_desc_1301"
  },
  [1401] = {
    1401,
    "str_n25_talent_name_1401",
    5,
    1,
    {
      BuffIDList = {
        5259086,
        5259087,
        5259088,
        5259089,
        5259090
      },
      BuffTargetType = 8
    },
    "icon_talent_7",
    "str_n25_talent_desc_1401"
  },
  [1402] = {
    1402,
    "str_n25_talent_name_1402",
    5,
    1,
    {
      BuffIDList = {
        5259101,
        5259102,
        5259103,
        5259104,
        5259105
      },
      BuffTargetType = 8
    },
    "icon_talent_8",
    "str_n25_talent_desc_1402"
  },
  [1501] = {
    1501,
    "str_n25_talent_name_1501",
    1,
    2,
    {
      feature = {
        [8] = {SkillID = 5220013}
      }
    },
    "icon_talent_2",
    "str_n25_talent_desc_1501"
  },
  [1601] = {
    1601,
    "str_n25_talent_name_1601",
    3,
    1,
    {
      BuffIDList = {
        5259061,
        5259062,
        5259063
      },
      BuffTargetType = 8
    },
    common[3],
    "str_n25_talent_desc_1601"
  },
  [1701] = {
    1701,
    "str_n25_talent_name_1701",
    5,
    1,
    {
      BuffIDList = {
        5259011,
        5259012,
        5259013,
        5259014,
        5259015
      },
      BuffTargetType = 8
    },
    common[1],
    "str_n25_talent_desc_1701"
  },
  [1702] = {
    1702,
    "str_n25_talent_name_1702",
    5,
    1,
    {
      BuffIDList = {
        5259041,
        5259042,
        5259043,
        5259044,
        5259045
      },
      BuffTargetType = 8
    },
    common[2],
    "str_n25_talent_desc_1702"
  },
  [1801] = {
    1801,
    "str_n25_talent_name_1801",
    1,
    4,
    {AddCount = 3},
    "icon_talent_9",
    "str_n25_talent_desc_1801"
  },
  [1901] = {
    1901,
    "str_n25_talent_name_1901",
    5,
    1,
    {
      BuffIDList = {
        5259131,
        5259132,
        5259133,
        5259134,
        5259135
      },
      BuffTargetType = 8
    },
    "icon_talent_12",
    "str_n25_talent_desc_1901"
  },
  [2001] = {
    2001,
    "str_n25_talent_name_2001",
    5,
    1,
    {
      BuffIDList = {
        5259111,
        5259112,
        5259113,
        5259114,
        5259115
      },
      BuffTargetType = 8
    },
    "icon_talent_10",
    "str_n25_talent_desc_2001"
  },
  [2002] = {
    2002,
    "str_n25_talent_name_2002",
    5,
    1,
    {
      BuffIDList = {
        5259121,
        5259122,
        5259123,
        5259124,
        5259125
      },
      BuffTargetType = 8
    },
    "icon_talent_11",
    "str_n25_talent_desc_2002"
  },
  [2101] = {
    2101,
    "str_n25_talent_name_2101",
    1,
    5,
    {relicGroupID = 2, randomCount = 3},
    common[4],
    "str_n25_talent_desc_2101"
  },
  [2201] = {
    2201,
    "str_n25_talent_name_2201",
    3,
    1,
    {
      BuffIDList = {
        5259071,
        5259072,
        5259073
      },
      BuffTargetType = 8
    },
    common[3],
    "str_n25_talent_desc_2201"
  },
  [2301] = {
    2301,
    "str_n25_talent_name_2301",
    5,
    1,
    {
      BuffIDList = {
        5259021,
        5259022,
        5259023,
        5259024,
        5259025
      },
      BuffTargetType = 8
    },
    common[1],
    "str_n25_talent_desc_2301"
  },
  [2302] = {
    2302,
    "str_n25_talent_name_2302",
    5,
    1,
    {
      BuffIDList = {
        5259051,
        5259052,
        5259053,
        5259054,
        5259055
      },
      BuffTargetType = 8
    },
    common[2],
    "str_n25_talent_desc_2302"
  },
  [2401] = {
    2401,
    "str_n25_talent_name_2401",
    5,
    3,
    {
      LevelIDList = {
        5259001,
        5259002,
        5259003,
        5259004,
        5259005,
        5259006
      },
      AddCount = 2
    },
    "icon_talent_13",
    "str_n25_talent_desc_2401"
  },
  [2501] = {
    2501,
    "str_n25_talent_name_2501",
    5,
    1,
    {
      BuffIDList = {
        5259081,
        5259082,
        5259083,
        5259084,
        5259085
      },
      BuffTargetType = 8
    },
    common[3],
    "str_n25_talent_desc_2501"
  },
  [2601] = {
    2601,
    "str_n25_talent_name_2601",
    1,
    5,
    {relicGroupID = 3, randomCount = 3},
    common[4],
    "str_n25_talent_desc_2601"
  }
}
return config, "ID", key
