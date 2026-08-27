local event_partfusion = {
  {}
}
local __default_values = {
  exit_index = 7,
  id = 1,
  part1_all = {901023, 901024},
  part2_all = {
    901025,
    901026,
    901027
  },
  part_event = {
    1,
    2,
    3,
    4,
    5,
    6
  },
  part_product = {
    901028,
    901029,
    901030,
    901031,
    901032,
    901033
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(event_partfusion) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(event_partfusion, {__index = __rawdata})
return event_partfusion
