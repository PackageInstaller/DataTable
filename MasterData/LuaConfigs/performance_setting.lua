local performance_setting = {
  {
    dyn_shadow = 0,
    guide_graph = "Guide/Performance/mode_1",
    post_effect = 0,
    resolution = 3,
    texture_limit = 2
  },
  {
    dyn_shadow = 0,
    id = 2,
    post_effect = 1,
    texture_limit = 1
  },
  {
    effect_quality = 1,
    guide_graph = "Guide/Performance/mode_3",
    id = 3,
    model_quality = 1,
    post_effect = 2,
    texture_limit = 1
  },
  {
    effect_quality = 2,
    frame_rate = 1,
    guide_graph = "Guide/Performance/mode_4",
    id = 4,
    model_quality = 2,
    open_little_man = 1,
    open_weather = 1,
    resolution = 1
  },
  {
    anti_aliasing = 1,
    effect_quality = 2,
    frame_rate = 1,
    id = 5,
    model_quality = 2,
    open_little_man = 1,
    open_weather = 1,
    outline = 1,
    resolution = 0
  }
}
local __default_values = {
  anti_aliasing = 0,
  dyn_shadow = 1,
  effect_quality = 0,
  frame_rate = 0,
  guide_graph = "",
  id = 1,
  model_quality = 0,
  open_little_man = 0,
  open_weather = 0,
  outline = 0,
  post_effect = 3,
  resolution = 2,
  texture_limit = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(performance_setting) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(performance_setting, {__index = __rawdata})
return performance_setting
