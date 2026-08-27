local __rt_1 = {
  2,
  0.5,
  6,
  4
}
local __rt_2 = {4, 7}
local __rt_3 = {
  0,
  0.5,
  5,
  4
}
local warchess_level_cam = {
  [5000] = {cam_deviation = __rt_1},
  [5001] = {cam_deviation = __rt_1, wc_level_id = 5001},
  [5002] = {cam_deviation = __rt_1, wc_level_id = 5002},
  [5003] = {wc_level_id = 5003},
  [5004] = {wc_level_id = 5004},
  [7007] = {wc_level_id = 7007},
  [7008] = {wc_level_id = 7008}
}
local __default_values = {
  cam_angle = 50,
  cam_deviation = __rt_3,
  cam_height = __rt_2,
  wc_level_id = 5000
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_level_cam) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_level_cam, {__index = __rawdata})
return warchess_level_cam
