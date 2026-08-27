local CheckerActivitySlider = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function CheckerActivitySlider.LengthCheck(param)
  return 2 < #param
end

function CheckerActivitySlider.ParamsCheck(param)
  local sliderId = param[2]
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleActivityStoryBP, sliderId)
  local alNum = counterElem and counterElem.times or 0
  local num = param[3]
  if alNum >= num then
    return true
  end
  return false
end

function CheckerActivitySlider.GetUnlockInfo(param)
  local sliderId = param[2]
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleActivityStoryBP, sliderId)
  local alNum = counterElem and counterElem.times or 0
  local num = param[3]
  return string.format(ConfigData:GetTipContent(21101), num, alNum)
end

return CheckerActivitySlider
