local chip_mark = {
  {name = 247321},
  {
    icon = "Corner_1",
    id = 2,
    name = 231848
  },
  {
    icon = "Corner_2",
    id = 3,
    name = 66324
  },
  {
    icon = "Corner_3",
    id = 4,
    name = 359819
  },
  {
    icon = "Corner_4",
    id = 5,
    name = 326679
  },
  {
    icon = "Corner_5",
    id = 6,
    name = 83178
  },
  {
    icon = "Corner_6",
    id = 7,
    name = 388173
  },
  {
    icon = "Corner_7",
    id = 8,
    name = 387183
  },
  {icon = "Corner_8", id = 9},
  {
    icon = "Corner_9",
    id = 10,
    name = 195139
  },
  {
    icon = "Corner_10",
    id = 11,
    name = 11829
  },
  {
    icon = "Corner_11",
    id = 12,
    name = 478567
  },
  {
    icon = "Corner_12",
    id = 13,
    name = 140754
  },
  {
    icon = "Corner_13",
    id = 14,
    name = 456006
  },
  {
    icon = "Corner_14",
    id = 15,
    name = 465810
  }
}
local __default_values = {
  icon = "Corner_0",
  id = 1,
  name = "42Lab"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(chip_mark) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(chip_mark, {__index = __rawdata})
return chip_mark
