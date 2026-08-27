local __rt_1 = {}
local __rt_2 = {level_id = 2}
local __rt_3 = {level_id = 3, pre_level_id = 3}
local __rt_4 = {level_id = 4, pre_level_id = 4}
local performance_gpu = {
  ["adreno (tm) 306"] = __rt_1,
  ["adreno (tm) 308"] = __rt_1,
  ["adreno (tm) 320"] = __rt_1,
  ["adreno (tm) 330"] = __rt_1,
  ["adreno (tm) 405"] = __rt_1,
  ["adreno (tm) 418"] = __rt_1,
  ["adreno (tm) 420"] = __rt_1,
  ["adreno (tm) 430"] = __rt_2,
  ["adreno (tm) 504"] = __rt_1,
  ["adreno (tm) 505"] = __rt_1,
  ["adreno (tm) 506"] = __rt_1,
  ["adreno (tm) 508"] = __rt_1,
  ["adreno (tm) 509"] = __rt_2,
  ["adreno (tm) 510"] = __rt_2,
  ["adreno (tm) 512"] = __rt_2,
  ["adreno (tm) 530"] = __rt_3,
  ["adreno (tm) 540"] = __rt_3,
  ["adreno (tm) 610"] = __rt_2,
  ["adreno (tm) 612"] = __rt_3,
  ["adreno (tm) 615"] = __rt_3,
  ["adreno (tm) 616"] = __rt_3,
  ["adreno (tm) 618"] = __rt_3,
  ["adreno (tm) 619l"] = __rt_3,
  ["adreno (tm) 620"] = __rt_4,
  ["adreno (tm) 630"] = __rt_4,
  ["adreno (tm) 640"] = __rt_4,
  ["adreno (tm) 650"] = __rt_4,
  ["adreno (tm) 660"] = __rt_4,
  ["adreno (tm) 670"] = __rt_4,
  ["mali g52"] = __rt_3,
  ["mali g71"] = __rt_3,
  ["mali g72"] = __rt_3,
  ["mali g76"] = __rt_4,
  ["mali g77"] = __rt_4,
  ["mali g78"] = __rt_4,
  ["mali g79"] = __rt_4,
  ["mali-450"] = __rt_1,
  ["mali-g51"] = __rt_2,
  ["mali-g52"] = __rt_3,
  ["mali-g57"] = __rt_4,
  ["mali-g71"] = __rt_3,
  ["mali-g72"] = __rt_3,
  ["mali-g76"] = __rt_4,
  ["mali-g77"] = __rt_4,
  ["mali-g78"] = __rt_4,
  ["mali-g79"] = __rt_4,
  ["mali-t604"] = __rt_1,
  ["mali-t628"] = __rt_1,
  ["mali-t720"] = __rt_1,
  ["mali-t760"] = __rt_1,
  ["mali-t830"] = __rt_1,
  ["mali-t860"] = __rt_2,
  ["mali-t880"] = __rt_1
}
local __default_values = {level_id = 1, pre_level_id = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(performance_gpu) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(performance_gpu, {__index = __rawdata})
return performance_gpu
