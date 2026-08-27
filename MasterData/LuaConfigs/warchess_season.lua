local __rt_1 = {}
local warchess_season = {
  {guide_id = 33, warchess_item = 1},
  {
    env_id = {
      1,
      2,
      3
    },
    guide_id = 43,
    id = 2,
    towers = {
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13
    },
    warchess_item = 2
  },
  {
    env_id = {4, 5},
    id = 3,
    towers = {
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21
    }
  },
  {
    env_id = {
      6,
      7,
      8
    },
    id = 4,
    towers = {
      22,
      23,
      24,
      25,
      26,
      27,
      28,
      29,
      30,
      31,
      32,
      33
    }
  },
  {
    env_id = {9},
    id = 5,
    pre_condition = {12},
    pre_para1 = {1707379199},
    pre_para2 = {1709193599},
    towers = {
      34,
      35,
      36,
      37
    }
  },
  {
    env_id = {10, 11},
    id = 6,
    towers = {
      38,
      39,
      40,
      41,
      42,
      43,
      44,
      45
    }
  }
}
local __default_values = {
  env_id = {0},
  guide_id = 30,
  id = 1,
  max_save = 3,
  pre_condition = __rt_1,
  pre_para1 = __rt_1,
  pre_para2 = __rt_1,
  towers = {
    1,
    2,
    3,
    4
  },
  warchess_item = 3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_season) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_season, {__index = __rawdata})
return warchess_season
