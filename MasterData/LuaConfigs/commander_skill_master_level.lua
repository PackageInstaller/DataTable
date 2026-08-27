local __rt_1 = {
  5,
  5,
  5
}
local commander_skill_master_level = {
  {
    master_point = {
      1,
      1,
      1
    }
  },
  {
    exp = 200,
    maste_level = 2,
    master_point = {
      2,
      1,
      1
    }
  },
  {
    exp = 300,
    maste_level = 3,
    master_point = {
      2,
      2,
      1
    }
  },
  {
    exp = 400,
    maste_level = 4,
    master_point = {
      2,
      2,
      2
    }
  },
  {
    exp = 500,
    maste_level = 5,
    master_point = {
      3,
      2,
      2
    }
  },
  {
    exp = 600,
    maste_level = 6,
    master_point = {
      3,
      3,
      2
    }
  },
  {
    exp = 700,
    maste_level = 7,
    master_point = {
      3,
      3,
      3
    }
  },
  {
    exp = 800,
    maste_level = 8,
    master_point = {
      4,
      3,
      3
    }
  },
  {
    exp = 900,
    maste_level = 9,
    master_point = {
      4,
      4,
      3
    }
  },
  {
    exp = 1000,
    maste_level = 10,
    master_point = {
      4,
      4,
      4
    }
  },
  {
    exp = 1100,
    maste_level = 11,
    master_point = {
      5,
      4,
      4
    }
  },
  {
    exp = 1200,
    maste_level = 12,
    master_point = {
      5,
      5,
      4
    }
  },
  {exp = 1300, maste_level = 13},
  {exp = 1400, maste_level = 14},
  {exp = 1500, maste_level = 15},
  {exp = 1600, maste_level = 16},
  {exp = 1700, maste_level = 17},
  {exp = 1800, maste_level = 18},
  {exp = 1900, maste_level = 19},
  {exp = 2000, maste_level = 20},
  {exp = 2100, maste_level = 21},
  {exp = 2200, maste_level = 22},
  {exp = 2300, maste_level = 23},
  {exp = 2400, maste_level = 24}
}
local __default_values = {
  exp = 100,
  maste_level = 1,
  master_point = __rt_1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(commander_skill_master_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(commander_skill_master_level, {__index = __rawdata})
return commander_skill_master_level
