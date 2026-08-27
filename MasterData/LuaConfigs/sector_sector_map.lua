local sector_sector_map = {
  {name = 58103},
  {
    id = 2,
    name = 36806,
    order_id = 2,
    serial = "02",
    src_name = "002_Sector_003"
  },
  {
    id = 3,
    order_id = 3,
    serial = "03",
    src_name = "002_Sector_004"
  }
}
local __default_values = {
  id = 1,
  name = 348364,
  order_id = 1,
  serial = "01",
  src_name = "002_Sector_001"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_sector_map) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_sector_map, {__index = __rawdata})
return sector_sector_map
