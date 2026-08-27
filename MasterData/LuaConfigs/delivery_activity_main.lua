local delivery_activity_main = {
  {}
}
local __default_values = {
  bgm_id = 3108,
  bp_item = 1268,
  first_avg = 5800101,
  guide_id = 70,
  id = 1,
  image_path = "UI_DeliverySimulatorEntranceLogo",
  role_group = 1,
  scene_path = "Delivery_Show_02",
  story_sector = 580011
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(delivery_activity_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(delivery_activity_main, {__index = __rawdata})
return delivery_activity_main
