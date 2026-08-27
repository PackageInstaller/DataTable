local CheckerCarnival24UnLockStage = {}

function CheckerCarnival24UnLockStage.LengthCheck(param)
  return 2 <= #param
end

function CheckerCarnival24UnLockStage.ParamsCheck(param)
  local stageId = param[2]
  local actId = stageId // 1000
  local carnival24Controller = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
  if carnival24Controller ~= nil then
    local carnival24Data = carnival24Controller:GetActDataByActId(actId)
    if carnival24Data ~= nil then
      return carnival24Data:IsUnLockMemoryFragMent(stageId)
    end
  end
  local hisData = PlayerDataCenter.actHisSpecialData
  if hisData:IsHaveCarnival24Data(actId) then
    return hisData:IsUnLockMemoryFragMent(actId, stageId)
  end
  return false
end

function CheckerCarnival24UnLockStage.GetUnlockInfo(param)
  local stageId = param[2]
  local memoryStageCfg = ConfigData.activity_carnival24_memory_stage
  if memoryStageCfg == nil then
    return
  end
  if memoryStageCfg[stageId] ~= nil then
    return string.format(ConfigData:GetTipContent(56003), LanguageUtil.GetLocaleText(memoryStageCfg[stageId].name))
  end
  return ""
end

return CheckerCarnival24UnLockStage
