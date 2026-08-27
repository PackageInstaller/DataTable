local CheckerActivity = {}

function CheckerActivity.LengthCheck(param)
  return 2 <= #param
end

function CheckerActivity.ParamsCheck(param)
  local activityFrameId = param[2]
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local activityData = activityFrameCtrl:GetActivityFrameData(activityFrameId)
  return activityData ~= nil and activityData:IsActivityOpen()
end

function CheckerActivity.GetUnlockInfo(param)
  local activityFrameId = param[2]
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local activityData = activityFrameCtrl:GetActivityFrameData(activityFrameId)
  if activityData ~= nil then
    return string.format(ConfigData:GetTipContent(7401), activityData.name)
  end
  return ""
end

return CheckerActivity
