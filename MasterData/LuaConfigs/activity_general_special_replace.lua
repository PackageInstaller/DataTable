local activity_general_special_replace = {
  [59001] = {}
}
local __default_values = {
  id = 59001,
  new_entrance_logo = "Activity/Anniversary24/UI_Anniversary24SectorEntranceLogo_2.png",
  new_image_entrance = "Anniversary24/UI_Anniversary24LoginInEntrance_2",
  new_login_popup = 69,
  new_logo_position = {699, 75},
  new_logo_size = {236, 244},
  new_name = 348364,
  pre_condition = {3},
  pre_para1 = {590012141},
  pre_para2 = {}
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_general_special_replace) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_general_special_replace, {__index = __rawdata})
return activity_general_special_replace
