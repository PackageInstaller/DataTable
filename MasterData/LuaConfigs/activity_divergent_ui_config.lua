local activity_divergent_ui_config = {
  [1071] = {}
}
local __default_values = {
  background_skin = 307101,
  hero_id = 1071,
  hero_name = "Persicaria - Shining Edge",
  model_pic = "UI_AnotherHeroPersicaria",
  skin_type = 2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_divergent_ui_config) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_divergent_ui_config, {__index = __rawdata})
return activity_divergent_ui_config
