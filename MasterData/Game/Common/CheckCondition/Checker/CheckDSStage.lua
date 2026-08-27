local CheckDSStage = {}

function CheckDSStage.LengthCheck(param)
  if 3 <= #param then
    return true
  end
  return false
end

function CheckDSStage.ParamsCheck(param)
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
  if actCtrl == nil then
    return false
  end
  local actId = param[2] // 1000
  local actData = actCtrl:GetActDataByActId(actId)
  local stageId = param[2] % 1000
  local needNum = param[3]
  local nowNum = actData:GetHighestScore(stageId)
  return needNum < nowNum
end

function CheckDSStage.GetUnlockInfo(param)
  local stageId = param[2] % 1000
  local needNum = param[3]
  return string.format(ConfigData:GetTipContent(58004), tostring(stageId), tostring(needNum))
end

return CheckDSStage
