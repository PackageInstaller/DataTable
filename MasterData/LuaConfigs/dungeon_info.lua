local dungeon_info = {
  {info_text = 262461},
  {info_text = 230305, ui_type = 2},
  {ui_type = 3}
}
local __default_values = {info_text = 135896, ui_type = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dungeon_info) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dungeon_info, {__index = __rawdata})
return dungeon_info
