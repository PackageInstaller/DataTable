local activity_spring_level_detail = {
  [240001] = {level_des = 426048},
  [240002] = {id = 240002, level_des = 387719},
  [240003] = {id = 240003},
  [240004] = {id = 240004, level_des = 426048},
  [240005] = {id = 240005, level_des = 387719},
  [240006] = {id = 240006},
  [240031] = {id = 240031, level_des = 503505},
  [240032] = {id = 240032, level_des = 4355},
  [240033] = {id = 240033, level_des = 440746}
}
local __default_values = {id = 240001, level_des = 321815}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_spring_level_detail) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_spring_level_detail, {__index = __rawdata})
return activity_spring_level_detail
