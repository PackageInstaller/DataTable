local LbPreLoadHelper = {}

function LbPreLoadHelper.__GetActData()
  local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
  if not carnival23Ctrl then
    return
  end
  return carnival23Ctrl:GetCarnival23Data()
end

function LbPreLoadHelper.GetCmderResIdFunc()
  local carnival23Data = LbPreLoadHelper.__GetActData()
  local eggCfgList = ConfigData.activity_carnival23_surprise[carnival23Data:GetActFrameId()]
  local isPass = PlayerDataCenter.sectorStage:IsStageComplete(eggCfgList[3].surprise_param[1])
  if isPass then
    return eggCfgList[3].surprise_param[2]
  end
  return nil
end

return LbPreLoadHelper
