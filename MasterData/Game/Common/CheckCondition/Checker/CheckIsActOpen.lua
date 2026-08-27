local CheckIsActOpen = {}

function CheckIsActOpen.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckIsActOpen.IsPassDungeon(actFrameId)
  if actFrameId == nil then
    return false
  end
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if actFrameCtrl == nil then
    return false
  end
  local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
  if actFrameData == nil then
    return false
  end
  return actFrameData:IsInRuningState()
end

function CheckIsActOpen.ParamsCheck(param)
  local ok = CheckIsActOpen.IsPassDungeon(param[2])
  return ok
end

function CheckIsActOpen.GetUnlockInfo(param)
  return string.format(ConfigData:GetTipContent(7915))
end

return CheckIsActOpen
