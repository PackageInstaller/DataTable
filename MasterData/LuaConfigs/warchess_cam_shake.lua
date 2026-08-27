local warchess_cam_shake = {
  {},
  {
    amplitude_gain = 3,
    id = 2,
    sustain_time = 2
  },
  {
    amplitude_gain = 4,
    decay = 2,
    id = 3,
    sustain_time = 3
  }
}
local __default_values = {
  amplitude_gain = 2,
  decay = 1,
  frequency_gain = 10,
  id = 1,
  sustain_time = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_cam_shake) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_cam_shake, {__index = __rawdata})
return warchess_cam_shake
