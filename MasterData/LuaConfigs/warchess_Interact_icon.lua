local warchess_Interact_icon = {
  {},
  {
    icon_name = "ICON_Interactive_02",
    id = 2
  },
  {
    icon_name = "ICON_Interactive_03",
    id = 3
  },
  {
    icon_name = "ICON_Interactive_04",
    id = 4
  },
  {
    icon_name = "ICON_Interactive_05",
    id = 5
  },
  {
    icon_name = "ICON_Interactive_06",
    id = 6
  },
  {
    icon_name = "ICON_Interactive_07",
    id = 7
  },
  {
    icon_name = "ICON_Interactive_08",
    id = 8
  },
  {
    icon_name = "ICON_Interactive_09",
    id = 9
  },
  {
    icon_name = "ICON_Interactive_10",
    id = 10
  }
}
local __default_values = {
  icon_name = "ICON_Interactive_01",
  id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_Interact_icon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_Interact_icon, {__index = __rawdata})
return warchess_Interact_icon
