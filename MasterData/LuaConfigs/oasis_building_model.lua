local __rt_1 = {
  -13,
  20,
  -4
}
local __rt_2 = {
  0,
  40,
  0
}
local __rt_3 = {
  0,
  5,
  0
}
local __rt_4 = {
  0,
  30,
  0
}
local __rt_5 = {
  -13,
  8,
  0
}
local __rt_6 = {
  4,
  20,
  0
}
local __rt_7 = {
  -13,
  13,
  0
}
local __rt_8 = {
  4,
  33,
  0
}
local __rt_9 = {
  -13,
  20,
  0
}
local __rt_10 = {
  4,
  50,
  0
}
local oasis_building_model = {
  {
    model = "controlTower1",
    name_pos = __rt_1
  },
  {
    id = 2,
    model = "controlTower2",
    name_pos = {
      -13,
      30,
      -4
    },
    res_pos = {
      0,
      65,
      0
    }
  },
  {
    id = 3,
    model = "controlTower3",
    name_pos = {
      -13,
      40,
      -4
    },
    res_pos = {
      0,
      80,
      0
    }
  },
  {
    id = 4,
    model = "retrievalTerminal1",
    name_pos = {
      -11,
      8,
      0
    },
    res_pos = {
      0,
      25,
      0
    }
  },
  {
    id = 5,
    model = "retrievalTerminal2",
    name_pos = {
      -11,
      13,
      0
    },
    res_pos = __rt_4
  },
  {
    id = 6,
    model = "retrievalTerminal3",
    name_pos = {
      -11,
      20,
      0
    }
  },
  {
    id = 7,
    model = "engineerBureau1",
    name_pos = __rt_5,
    res_pos = __rt_6
  },
  {
    id = 8,
    model = "engineerBureau2",
    name_pos = __rt_7,
    res_pos = __rt_8
  },
  {
    id = 9,
    model = "engineerBureau3",
    res_pos = __rt_10
  },
  {
    id = 10,
    name_pos = __rt_5,
    res_pos = __rt_6
  },
  {
    id = 11,
    model = "bank2",
    name_pos = __rt_7,
    res_pos = __rt_8
  },
  {
    id = 12,
    model = "bank3",
    res_pos = __rt_10
  },
  {
    id = 13,
    model = "storage1",
    name_pos = __rt_5,
    res_pos = {
      0,
      15,
      0
    }
  },
  {
    id = 14,
    model = "storage2",
    name_pos = {
      -17,
      13,
      0
    },
    res_pos = __rt_4
  },
  {
    id = 15,
    model = "storage3",
    res_pos = {
      0,
      35,
      0
    }
  },
  {
    id = 16,
    model = "factory1",
    name_pos = {
      -10,
      8,
      0
    },
    res_pos = {
      12,
      20,
      0
    }
  },
  {
    id = 17,
    model = "factory2",
    name_pos = {
      -10,
      13,
      0
    },
    res_pos = {
      12,
      40,
      0
    }
  },
  {
    id = 18,
    model = "factory3",
    name_pos = {
      -16,
      20,
      -7.5
    },
    res_pos = {
      12,
      35,
      0
    }
  },
  {
    id = 19,
    model = "turboTower1",
    name_pos = __rt_1
  },
  {
    id = 20,
    model = "turboTower2",
    name_pos = __rt_1
  },
  {
    id = 21,
    model = "turboTower3",
    name_pos = __rt_1
  },
  {
    id = 22,
    model = "weatherController1"
  },
  {
    id = 23,
    model = "weatherController2"
  }
}
local __default_values = {
  id = 1,
  model = "bank1",
  name_pos = __rt_9,
  res_pos = __rt_2,
  select_pos = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(oasis_building_model) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(oasis_building_model, {__index = __rawdata})
return oasis_building_model
