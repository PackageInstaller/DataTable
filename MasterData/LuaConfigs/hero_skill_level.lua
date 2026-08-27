local __rt_1 = {1003, 1501}
local __rt_2 = {}
local __rt_3 = {
  countList = {2000, 200}
}
local __rt_4 = {
  countList = {3000, 360}
}
local __rt_5 = {
  countList = {4000, 560},
  level_limit = 50
}
local __rt_6 = {
  countList = {5000, 880},
  level_limit = 50
}
local __rt_7 = {
  countList = {6000, 1320},
  level_limit = 50
}
local __rt_8 = {
  1003,
  1501,
  1502
}
local __rt_9 = {
  countList = {
    7000,
    1920,
    4
  },
  itemIdList = __rt_8,
  level_limit = 60
}
local __rt_10 = {
  countList = {
    8000,
    2680,
    8
  },
  itemIdList = __rt_8,
  level_limit = 60
}
local __rt_11 = {
  countList = {
    10000,
    3600,
    12
  },
  itemIdList = __rt_8,
  level_limit = 60
}
local __rt_12 = {}
local __rt_13 = {
  countList = __rt_12,
  itemIdList = __rt_12,
  level_limit = 0
}
local hero_skill_level = {
  {
    __rt_2,
    __rt_3,
    __rt_4,
    __rt_5,
    __rt_6,
    __rt_7,
    __rt_9,
    __rt_10,
    __rt_11,
    __rt_13
  },
  {
    __rt_2,
    __rt_3,
    __rt_4,
    __rt_5,
    __rt_6,
    {
      countList = {6000, 1320},
      level_limit = 50
    },
    {
      countList = {
        7000,
        1920,
        4
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {
        8000,
        2680,
        8
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {
        10000,
        3600,
        12
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {},
      itemIdList = {},
      level_limit = 0
    }
  },
  {
    __rt_2,
    __rt_3,
    __rt_4,
    __rt_5,
    __rt_6,
    {
      countList = {6000, 1320},
      level_limit = 50
    },
    {
      countList = {
        7000,
        1920,
        4
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {
        8000,
        2680,
        8
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {
        10000,
        3600,
        12
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {},
      itemIdList = {},
      level_limit = 0
    }
  },
  {
    __rt_2,
    __rt_3,
    __rt_4,
    __rt_5,
    __rt_6,
    {
      countList = {6000, 1320},
      level_limit = 50
    },
    {
      countList = {
        7000,
        1920,
        4
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {
        8000,
        2680,
        8
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {
        10000,
        3600,
        12
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {},
      itemIdList = {},
      level_limit = 0
    }
  },
  {
    __rt_2,
    __rt_3,
    __rt_4,
    __rt_5,
    __rt_6,
    {
      countList = {6000, 1320},
      level_limit = 50
    },
    {
      countList = {
        7000,
        1920,
        4
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {
        8000,
        2680,
        8
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {
        10000,
        3600,
        12
      },
      itemIdList = {
        1003,
        1501,
        1502
      },
      level_limit = 60
    },
    {
      countList = {},
      itemIdList = {},
      level_limit = 0
    }
  }
}
local __default_values = {
  countList = {1000, 100},
  itemIdList = __rt_1,
  level_limit = 40
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(hero_skill_level) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  allSkillUpItemIdList = {
    1003,
    1501,
    1502
  }
}
setmetatable(hero_skill_level, {__index = __rawdata})
return hero_skill_level
