local chip_intro = {
  [101] = {
    [0] = {id = 101, intro = 77168}
  },
  [102] = {
    [0] = {id = 102, intro = 416331}
  },
  [103] = {
    [0] = {id = 103, intro = 73113}
  },
  [104] = {
    {arg = 1, intro = 377650},
    {arg = 2, intro = 182211}
  },
  [105] = {
    [0] = {id = 105, intro = 153746}
  },
  [601] = {
    [0] = {id = 601, intro = 431950}
  },
  [602] = {
    [0] = {id = 602, intro = 139481}
  },
  [603] = {
    [0] = {id = 603, intro = 320551}
  },
  [604] = {
    {
      arg = 1,
      id = 604,
      intro = 208144
    },
    {arg = 2, id = 604}
  },
  [605] = {
    [0] = {id = 605, intro = 408448}
  }
}
local __default_values = {
  arg = 0,
  id = 104,
  intro = 12705
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(chip_intro) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  influence_type = {
    [101] = 0,
    [102] = 1,
    [103] = 2,
    [104] = 0,
    [105] = 3,
    [601] = 0,
    [602] = 1,
    [603] = 2,
    [604] = 0,
    [605] = 3
  }
}
setmetatable(chip_intro, {__index = __rawdata})
return chip_intro
