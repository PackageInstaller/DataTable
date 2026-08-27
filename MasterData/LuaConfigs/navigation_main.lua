local navigation_main = {
  {},
  {
    id = 2,
    img = "SHADE_operation",
    name = 270423,
    name_en = "OPERATION SYSTEM",
    sub_id = {
      11,
      12,
      13,
      14,
      15,
      16
    }
  },
  {
    id = 3,
    img = "SHADE_sub",
    name = 247556,
    name_en = "SUB SYSTEM",
    sub_id = {
      22,
      23,
      24
    }
  }
}
local __default_values = {
  id = 1,
  img = "SHADE_main",
  name = 13443,
  name_en = "MAIN SYSTEM",
  sub_id = {
    1,
    2,
    3,
    4
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(navigation_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(navigation_main, {__index = __rawdata})
return navigation_main
