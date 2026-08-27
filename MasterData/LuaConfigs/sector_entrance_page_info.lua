local sector_entrance_page_info = {
  {name = 409445},
  {
    icon = "Page_Icon_2",
    id = 2,
    name = 384122
  },
  {
    icon = "Page_Icon_3",
    id = 3,
    name = 84185
  },
  {
    icon = "Page_Icon_4",
    id = 4
  }
}
local __default_values = {
  icon = "Page_Icon_1",
  id = 1,
  name = 191123
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_entrance_page_info) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_entrance_page_info, {__index = __rawdata})
return sector_entrance_page_info
