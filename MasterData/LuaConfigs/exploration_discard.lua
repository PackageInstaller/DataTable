local __rt_1 = {
  500,
  500,
  500,
  500
}
local __rt_2 = {
  1,
  20,
  -1
}
local __rt_3 = {
  1,
  2,
  3,
  -1
}
local __rt_4 = {
  50,
  200,
  200
}
local exploration_discard = {
  {
    discard_level = {
      1,
      5,
      10,
      -1
    },
    upgrade_scaleValues = {
      50,
      100,
      200
    }
  },
  {
    discard_scaleValues = {
      1000,
      500,
      334,
      334
    },
    id = 2
  },
  {
    discard_scaleValues = {
      1000,
      1000,
      1000,
      1000
    },
    id = 3
  },
  {
    id = 4,
    upgrade_scaleValues = {
      20,
      50,
      100
    }
  },
  {
    id = 5,
    upgrade_scaleValues = {
      40,
      80,
      150
    }
  }
}
local __default_values = {
  discard_level = __rt_3,
  discard_scaleId = 1,
  discard_scaleValues = __rt_1,
  id = 1,
  upgrade_level = __rt_2,
  upgrade_scaleId = 1,
  upgrade_scaleValues = __rt_4
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(exploration_discard) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_discard, {__index = __rawdata})
return exploration_discard
