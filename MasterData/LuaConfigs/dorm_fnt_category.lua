local dorm_fnt_category = {
  {line = 2},
  {
    icon = "Icon_2",
    id = 2,
    limit = 8,
    limit_1 = 24,
    line = 11,
    name = 19152
  },
  {
    icon = "Icon_3",
    id = 3,
    line = 4,
    name = 93686
  },
  {
    icon = "Icon_4",
    id = 4,
    line = 3,
    name = 226507
  },
  {
    icon = "Icon_5",
    id = 5,
    limit = 4,
    limit_1 = 10,
    line = 12,
    name = 402339
  },
  {
    icon = "Icon_6",
    id = 6,
    limit = 2,
    limit_1 = 4,
    line = 5,
    name = 241441
  },
  {
    icon = "Icon_7",
    id = 7,
    limit = 4,
    limit_1 = 10,
    line = 7,
    name = 349177
  },
  {
    icon = "Icon_8",
    id = 8,
    limit = 2,
    limit_1 = 4,
    line = 6,
    name = 222154
  },
  {
    icon = "Icon_9",
    id = 9,
    limit = 2,
    limit_1 = 4,
    line = 8,
    name = 82047
  },
  {
    icon = "Icon_10",
    id = 10,
    limit = 8,
    limit_1 = 18,
    line = 9,
    name = 441936
  },
  {
    icon = "Icon_11",
    id = 11,
    limit = 8,
    limit_1 = 18,
    line = 10,
    name = 215042
  },
  {
    icon = "Icon_12",
    id = 12,
    name = 181654
  }
}
local __default_values = {
  icon = "Icon_1",
  id = 1,
  limit = 0,
  limit_1 = 0,
  line = 1,
  name = 180239
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dorm_fnt_category) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  dmFntCategoryIdList = {
    12,
    1,
    4,
    3,
    6,
    8,
    7,
    9,
    10,
    11,
    2,
    5
  }
}
setmetatable(dorm_fnt_category, {__index = __rawdata})
return dorm_fnt_category
