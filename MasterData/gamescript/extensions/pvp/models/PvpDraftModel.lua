local PvpDraftModel = NewClass("PvpDraftModel", BaseModel)

function PvpDraftModel:OnInit()
  self:ClearData()
end

function PvpDraftModel:OnReset()
  self:OnInit()
end

function PvpDraftModel:ClearData()
  self._gameData = nil
  self._myPlayerData = nil
  self._enemyPlayerData = nil
  self:ClearViewData()
end

function PvpDraftModel:ClearViewData()
  self._playerSelectCollectionTid = nil
  self._enemySelectCollectionTid = nil
  self._adjustCollectionTid = nil
  self._choosingUid = nil
  self._lastChoosingUid = nil
end

function PvpDraftModel:UpdateBySvrData(svrData)
  PvpDraftModel.Instance:SetPlayerSelectCollectionTid(nil)
  self._gameData = svrData.gameData
  self._myPlayerData = svrData.myPlayerData
  self._enemyPlayerData = svrData.enemyPlayerData
  self:SetChoosingUid(self._gameData.choosingUid)
  self:SetEnemySelectCollectionTid(self._enemyPlayerData.collectTidTemp)
  PvpController.Instance:OnPvpDraftDataUpdate()
  EventMgr.Instance.PvpDraftDataUpdate:Dispatch()
end

function PvpDraftModel:SetPlayerSelectCollectionTid(tid)
  if not tid then
    return
  end
  self._playerSelectCollectionTid = tid
  EventMgr.Instance.PvpDraftPlayerSelectChanged:Dispatch()
end

function PvpDraftModel:SetEnemySelectCollectionTid(tid)
  if not tid then
    return
  end
  self._enemySelectCollectionTid = tid
  EventMgr.Instance.PvpDraftEnemySelectChanged:Dispatch()
end

function PvpDraftModel:SetAdjustCollectionTid(tid)
  self._adjustCollectionTid = tid
  EventMgr.Instance.PvpAdjustCollectionChanged:Dispatch()
end

function PvpDraftModel:GetAdjustCollectionTid()
  return self._adjustCollectionTid
end

function PvpDraftModel:GetMyPlayerData()
  return self._myPlayerData
end

function PvpDraftModel:GetEnemyPlayerData()
  return self._enemyPlayerData
end

function PvpDraftModel:GetPlayerTeamData()
  return self._myPlayerData.teamData
end

function PvpDraftModel:GetPlayerSelectCollectionTid()
  return self._playerSelectCollectionTid
end

function PvpDraftModel:GetEnemySelectCollectionTid()
  return self._enemySelectCollectionTid
end

function PvpDraftModel:GetDraftRelicTid()
  return self._gameData.relicTid
end

function PvpDraftModel:GetDraftStartAnimationTime()
  do return DT.GetConstant end
  return DT.GetConstant, "RotationModeAnimationTime"
end

function PvpDraftModel:GetDraftRotationPickTime()
  do return DT.GetConstant end
  return DT.GetConstant, "RotationModeDecisionTime"
end

function PvpDraftModel:GetDraftChangePositionTime()
  do return DT.GetConstant end
  return DT.GetConstant, "RotationModeChangePositionTime"
end

function PvpDraftModel:GetDraftPhaseBeginTime()
  return self._gameData.phaseBeginTime
end

function PvpDraftModel:GetDraftStartAnimationEndTs()
  return self:GetDraftPhaseBeginTime() + self:GetDraftStartAnimationTime()
end

function PvpDraftModel:GetDraftRotationEndTs()
  return self:GetDraftPhaseBeginTime() + self:GetDraftRotationPickTime()
end

function PvpDraftModel:GetDraftChangePositionEndTs()
  return self:GetDraftPhaseBeginTime() + self:GetDraftChangePositionTime()
end

function PvpDraftModel:GetDraftStartAnimationCountDown()
  local passedTime = TimeUtils.GetServerTime() - self:GetDraftPhaseBeginTime()
  return self:GetDraftStartAnimationTime() - passedTime
end

function PvpDraftModel:GetDraftRotationCountDown()
  local passedTime = TimeUtils.GetServerTime() - self:GetDraftPhaseBeginTime()
  return self:GetDraftRotationPickTime() - passedTime
end

function PvpDraftModel:GetDraftChangePositionCountDown()
  local passedTime = TimeUtils.GetServerTime() - self:GetDraftPhaseBeginTime()
  return self:GetDraftChangePositionTime() - passedTime
end

function PvpDraftModel:GetAwakerPoolList()
  local awakerCollectTidList = {}
  for _, tid in ipairs(self._gameData.choices) do
    local collectType = PvpCollectCfgUtils.GetCollectionType(tid)
    if collectType == CommonDefine.PVPCollectionType.Awaker then
      table.insert(awakerCollectTidList, tid)
    end
  end
  table.sort(awakerCollectTidList, function(a, b)
    local aPos = PvpCollectCfgUtils.GetCollectAwakerPosition(a)
    local bPos = PvpCollectCfgUtils.GetCollectAwakerPosition(b)
    local aPosSort = PVPPositionCfgUtils.GetCfgField("Sort", aPos)
    local bPosSort = PVPPositionCfgUtils.GetCfgField("Sort", bPos)
    return aPosSort > bPosSort
  end)
  return awakerCollectTidList
end

function PvpDraftModel:GetWeaponPoolList()
  local weaponCollectTidList = {}
  for _, tid in ipairs(self._gameData.choices) do
    local collectType = PvpCollectCfgUtils.GetCollectionType(tid)
    if collectType == CommonDefine.PVPCollectionType.Weapon then
      table.insert(weaponCollectTidList, tid)
    end
  end
  return weaponCollectTidList
end

function PvpDraftModel:GetKeeperSkillPoolList()
  local keeperSkillCollectTidList = {}
  for _, tid in ipairs(self._gameData.choices) do
    local collectType = PvpCollectCfgUtils.GetCollectionType(tid)
    if collectType == CommonDefine.PVPCollectionType.KeeperSkill then
      table.insert(keeperSkillCollectTidList, tid)
    end
  end
  return keeperSkillCollectTidList
end

function PvpDraftModel:SetChoosingUid(numVal)
  local lastChoosingUid = self._choosingUid
  self._lastChoosingUid = lastChoosingUid
  self._choosingUid = numVal
end

function PvpDraftModel:GetChoosingUid()
  return self._choosingUid
end

function PvpDraftModel:GetLastChoosingUid()
  return self._lastChoosingUid
end

function PvpDraftModel:GetPlayerAdjustReady()
  return self._myPlayerData.adjustReady
end

function PvpDraftModel:GetPlayerUid()
  return self._myPlayerData.uid
end

function PvpDraftModel:GetEnemyAdjustReady()
  return self._enemyPlayerData.adjustReady
end

function PvpDraftModel:GetEnemyUid()
  return self._enemyPlayerData.uid
end

function PvpDraftModel:GetDraftPvpPhase()
  return self._gameData.phase
end

function PvpDraftModel:GetChoosingUid()
  return self._gameData.choosingUid
end

function PvpDraftModel:GetPlayerDataCollectSkin(playerData, collectionTid)
  if playerData.collectParam and playerData.collectParam[collectionTid] then
    return playerData.collectParam[collectionTid].curSkin
  end
  return nil
end

function PvpDraftModel:GetCollectionMaxSelectNum(collectionType)
  if collectionType == CommonDefine.PVPCollectionType.Awaker then
    return 4
  elseif collectionType == CommonDefine.PVPCollectionType.Weapon then
    return 4
  elseif collectionType == CommonDefine.PVPCollectionType.KeeperSkill then
    return 2
  end
end

function PvpDraftModel:IsCollectionPicked(tid)
  return table.contains(self._myPlayerData.collectList, tid) or table.contains(self._enemyPlayerData.collectList, tid)
end

function PvpDraftModel:IsCollectionSelected(tid)
  return tid == self._playerSelectCollectionTid or tid == self._enemySelectCollectionTid
end

function PvpDraftModel:IsAwakerCanNotSelect(targetTid)
  local targetPvpPos = PvpCollectCfgUtils.GetCollectAwakerPosition(targetTid)
  for _, tid in ipairs(self._myPlayerData.collectList) do
    local pvpPos = PvpCollectCfgUtils.GetCollectAwakerPosition(tid)
    if pvpPos == targetPvpPos then
      return true
    end
  end
  return false
end

function PvpDraftModel:IsPlayerSelectingPhase()
  if self:GetDraftPvpPhase() ~= PvpDefine.PvpDraftPhase.Draft then
    return false
  end
  return self:GetChoosingUid() == self:GetPlayerUid()
end

function PvpDraftModel:IsEnemySelectingPhase()
  if self:GetDraftPvpPhase() ~= PvpDefine.PvpDraftPhase.Draft then
    return false
  end
  return self:GetChoosingUid() == self:GetEnemyUid()
end

function PvpDraftModel:IsInDraftPvp()
  return self._gameData ~= nil
end

function PvpDraftModel:IsPlayerCollectionTypeFully(targetTid)
  local targetType = PvpCollectCfgUtils.GetCollectionType(targetTid)
  local selectTypeNum = 0
  for _, tid in ipairs(self._myPlayerData.collectList) do
    local collectType = PvpCollectCfgUtils.GetCollectionType(tid)
    if collectType == targetType then
      selectTypeNum = selectTypeNum + 1
    end
  end
  return selectTypeNum >= self:GetCollectionMaxSelectNum(targetType)
end

function PvpDraftModel:IsPlayerFirstHand(uid)
  return uid == self._gameData.camp1Uid
end

return PvpDraftModel
