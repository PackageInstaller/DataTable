local spec_weapon_points = {
  {pos_x = -725.6, pos_y = 284.9},
  {
    id = 2,
    pos_x = -660.4,
    pos_y = 218.3
  },
  {
    id = 3,
    pos_x = -543.9,
    pos_y = 158.6
  },
  {
    id = 4,
    pos_x = -600.7,
    pos_y = 101.2
  },
  {id = 5, pos_x = -714.3},
  {id = 6, pos_x = -839},
  {
    id = 7,
    pos_x = -601.3,
    pos_y = -101.1
  },
  {
    id = 8,
    pos_x = -543.3,
    pos_y = -157.9
  },
  {
    id = 9,
    pos_x = -658.9,
    pos_y = -219.2
  },
  {
    id = 10,
    pos_x = -726.4,
    pos_y = -285.6
  },
  {
    id = 11,
    pos_x = 725.1,
    pos_y = 286.7
  },
  {
    id = 12,
    pos_x = 660.1,
    pos_y = 217
  },
  {
    id = 13,
    pos_x = 544.9,
    pos_y = 157.4
  },
  {
    id = 14,
    pos_x = 601.6,
    pos_y = 100.7
  },
  {
    id = 15,
    pos_x = 601.3,
    pos_y = -102.3
  },
  {
    id = 16,
    pos_x = 544.5,
    pos_y = -157.7
  },
  {
    id = 17,
    pos_x = 658.6,
    pos_y = -217.3
  },
  {
    id = 18,
    pos_x = 726.5,
    pos_y = -287.3
  },
  {id = 19, pos_x = 714.2},
  {id = 20, pos_x = 842.4},
  {
    id = 21,
    pos_x = -368,
    pos_y = 352.6
  },
  {
    id = 22,
    pos_x = -300.3,
    pos_y = 284.9
  },
  {id = 23, pos_y = 352.6},
  {
    id = 24,
    pos_x = 232.6,
    pos_y = 352.6
  },
  {
    id = 25,
    pos_x = 301.5,
    pos_y = 284.6
  },
  {
    id = 26,
    pos_x = 369.5,
    pos_y = 350.1
  },
  {
    id = 27,
    pos_x = -299,
    pos_y = -285
  },
  {
    id = 28,
    pos_x = -367.9,
    pos_y = -350.9
  },
  {
    id = 29,
    pos_x = 301.6,
    pos_y = -283.3
  },
  {
    id = 30,
    pos_x = 369.7,
    pos_y = -351.4
  }
}
local __default_values = {
  id = 1,
  pos_x = -233.5,
  pos_y = 1.5
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(spec_weapon_points) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(spec_weapon_points, {__index = __rawdata})
return spec_weapon_points
