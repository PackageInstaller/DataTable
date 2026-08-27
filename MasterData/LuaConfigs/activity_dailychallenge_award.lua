local __rt_1 = {5, 300}
local __rt_2 = {200, 2}
local __rt_3 = {1018, 5008}
local __rt_4 = {1, 5}
local __rt_5 = {10, 200}
local __rt_6 = {1, 2}
local __rt_7 = {10, 300}
local __rt_8 = {1504, 1920}
local activity_dailychallenge_award = {
  {
    {
      id = 1,
      itemCounts = {5, 5},
      itemIds = {8206, 1502},
      need_point = 200
    },
    {
      id = 1,
      itemCounts = __rt_1,
      itemIds = {6003, 1008},
      need_point = 400,
      phase = 2
    },
    {
      id = 1,
      itemCounts = __rt_2,
      need_point = 600,
      phase = 3
    },
    {
      id = 1,
      itemCounts = {5, 2000},
      itemIds = {8129, 1501},
      need_point = 800,
      phase = 4
    },
    {
      id = 1,
      itemCounts = __rt_4,
      itemIds = {3001, 5007},
      phase = 5
    },
    {
      id = 1,
      itemCounts = __rt_4,
      itemIds = {8221, 1502},
      need_point = 1200,
      phase = 6
    },
    {
      id = 1,
      itemCounts = {1, 1},
      itemIds = {8221, 5010},
      need_point = 1400,
      phase = 7
    }
  },
  {
    {itemCounts = __rt_2, need_point = 2000},
    {
      itemCounts = __rt_5,
      itemIds = {1504, 1503},
      need_point = 4000,
      phase = 2
    },
    {
      itemCounts = __rt_1,
      itemIds = {6003, 1920},
      need_point = 6000,
      phase = 3
    },
    {
      itemCounts = __rt_6,
      itemIds = {3001, 5008},
      need_point = 8000,
      phase = 4
    },
    {
      itemCounts = {1000, 200},
      itemIds = {1920, 1503},
      need_point = 10000,
      phase = 5
    },
    {
      itemIds = __rt_8,
      need_point = 12000,
      phase = 6
    },
    {
      itemCounts = {10, 5},
      itemIds = {3002, 1504},
      need_point = 15000,
      phase = 7
    },
    {
      itemCounts = {500, 300},
      itemIds = {1503, 1920},
      need_point = 18000,
      phase = 8
    },
    {
      itemCounts = {10, 2},
      itemIds = {1504, 8247},
      need_point = 21000,
      phase = 9
    },
    {
      itemCounts = {5, 200},
      itemIds = {6003, 1503},
      need_point = 24000,
      phase = 10
    },
    {
      itemIds = {3002, 1920},
      need_point = 27000,
      phase = 11
    },
    {
      itemCounts = {1000, 1},
      itemIds = {1920, 400083},
      need_point = 30000,
      phase = 12
    },
    {
      itemCounts = __rt_6,
      itemIds = {3001, 8247},
      need_point = 35000,
      phase = 13
    },
    {
      itemCounts = __rt_5,
      itemIds = {3002, 1503},
      need_point = 40000,
      phase = 14
    },
    {
      itemIds = __rt_8,
      need_point = 45000,
      phase = 15
    }
  }
}
local __default_values = {
  id = 2,
  itemCounts = __rt_7,
  itemIds = __rt_3,
  need_point = 1000,
  phase = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_dailychallenge_award) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  cyclePhaseDic = {
    {
      id = 1,
      itemCounts = {1},
      itemIds = {8221},
      need_point = 200,
      phase = 999
    },
    {
      id = 2,
      itemCounts = {1},
      itemIds = {8247},
      need_point = 5000,
      phase = 999
    }
  }
}
setmetatable(activity_dailychallenge_award, {__index = __rawdata})
return activity_dailychallenge_award
