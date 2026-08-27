local AllActivitySectorIData = class("AllActivitySectorIData")
local ActivitySectorIData = require("Game.ActivitySectorI.ActivitySectorIData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function AllActivitySectorIData:ctor()
  self._dataDic = {}
end

function AllActivitySectorIData:UpdateSectorIMsg(datamsg)
  if datamsg == nil or #datamsg == 0 then
    return
  end
  for _, singleData in pairs(datamsg) do
    local id = singleData.actId
    local data = self._dataDic[id]
    if data == nil then
      data = ActivitySectorIData.New()
      self._dataDic[id] = data
      data:InitDataByMsg(singleData)
    else
      data:UpdateDataByMsg(singleData)
    end
  end
end

function AllActivitySectorIData:GetSectorIData(actId)
  local data = self._dataDic[actId]
  if data == nil or not data:IsActivityOpen() then
    return nil
  end
  return data
end

function AllActivitySectorIData:GetDataBySectorId(sectorId)
  local actId = ConfigData.activity_time_limit.sectorMapping[sectorId]
  if actId == nil then
    return nil, nil, false
  end
  local data = self:GetSectorIData(actId)
  if data == nil then
    return actId, nil, false
  end
  return actId, data, data:IsActivityOpen()
end

function AllActivitySectorIData:GetDataBySectorIdRunning(sectorId)
  local actId = ConfigData.activity_time_limit.sectorMapping[sectorId]
  if actId == nil then
    return nil, nil, false
  end
  local data = self:GetSectorIData(actId)
  if data == nil then
    return actId, nil, false
  end
  return actId, data, data:IsActivityRunning()
end

function AllActivitySectorIData:GetOpenSectorActivity()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_LargeActivity)
  if not isUnlock then
    return nil
  end
  for actId, data in pairs(self._dataDic) do
    if data:IsActivityOpen() then
      return data
    end
  end
  return nil
end

function AllActivitySectorIData:GetRunningSectorActivity()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_LargeActivity)
  if not isUnlock then
    return nil
  end
  for actId, data in pairs(self._dataDic) do
    if data:IsActivityRunning() then
      return data
    end
  end
  return nil
end

function AllActivitySectorIData:IsOpenSectorIEntrance()
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_LargeActivity)
end

function AllActivitySectorIData:IsSecorIRechallengeStage(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil then
    return nil, false, false
  end
  return self:IsSecorIRechallengeSector(stageCfg.sector, stageId)
end

function AllActivitySectorIData:IsSecorIRechallengeSector(sectorId, stageId)
  local actId, data, inTime = self:GetDataBySectorIdRunning(sectorId)
  if actId == nil then
    return nil, false, false
  end
  local isChallenge = sectorId == ConfigData.activity_time_limit[actId].rechallenge_stage
  if not self:IsOpenSectorIEntrance() then
    return actId, isChallenge, false
  end
  local canFight = true
  if isChallenge then
    local countEnough = data:GetSectorIBattleCount()
    local isSectorFinsh = PlayerDataCenter.sectorStage:IsStageComplete(stageId)
    canFight = inTime and (countEnough or not isSectorFinsh)
  end
  return actId, isChallenge, canFight
end

function AllActivitySectorIData:IsUnfinishSectorI(sectorId)
  local actId, data, inTime = self:GetDataBySectorId(sectorId)
  if actId == nil then
    return false
  end
  if inTime then
    return true
  end
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameId = actCtrl:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.SectorI, actId)
  if frameId == nil then
    return false
  end
  local frameData = actCtrl:GetActivityFrameData(frameId)
  return not frameData:GetIsActivityFinished()
end

return AllActivitySectorIData
