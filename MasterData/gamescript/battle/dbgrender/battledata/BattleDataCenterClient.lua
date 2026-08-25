local BattleCamp = bc.BattleCamp
local MOCK_PLAYER_ID = 1
local BattleDataCenterClient = System.NewClass("BattleDataCenterClient")

function BattleDataCenterClient:ctor()
  self.isRecover = nil
  self.suppressEnterUIAnim = false
  self.isInit = false
end

function BattleDataCenterClient:ShouldSkipEnterUIAnim()
  return self.suppressEnterUIAnim == true
end

function BattleDataCenterClient:EndRecoverEnterUIAnim()
  self.suppressEnterUIAnim = false
end

function BattleDataCenterClient:OnBind(binder)
  binder:onDestroy(function()
    self:OnUnbind()
  end)
  self.binder = binder
  self.boutData = self.binder:createModel(BattleBoutDataModel)
  self.stateData = self.binder:createModel(BattleStateDataModel)
  self.playerDataModel = nil
  self.enemyDataModel = nil
  self.roleDataModelMap = {}
  self.lockerUidToLockedUid = {}
  self.myCamp = Vue.ref(bc.BattleCamp.Camp1)
  self.cardDimensionStep = Vue.ref(0)
  self.opMode = Vue.ref(rc.OpMode.Play)
  self.highlightList = {}
  self.history = Vue.ref({})
  self.recoverBoutLeftTime = nil
  self.monsterDamage = Vue.ref(0)
  self.damageOrder = {}
  self.statsDataModelMap = {}
  self._dropingCardNum = 0
  self._realEnergy = Vue.ref(0)
  self._realCamp = Vue.ref(bc.BattleCamp.Camp1)
  self._isMyBoutEnd = Vue.ref(false)
end

function BattleDataCenterClient:OnUnbind()
  self.binder = nil
end

function BattleDataCenterClient:SetBattleTid(battleTid)
  self.battleTid = battleTid
end

function BattleDataCenterClient:InitData(initData, isRecover)
  initData = table.deepclone(initData)
  self.isInit = true
  self.isRecover = isRecover
  self.suppressEnterUIAnim = true == isRecover
  self.gender = initData.gender
  self.playerName = initData.playerName
  self.draftRelicTid = initData.draftRelicTid
  self.initCamp = initData.initCamp
  if isRecover then
    self.monsterDamage = Vue.ref(initData.monsterDamage.totalDamage)
    self.damageOrder = Vue.ref(initData.monsterDamage.damageOrder)
  else
    self.monsterDamage = Vue.ref(initData.monsterDamage)
  end
  self.boutData:InitData(initData)
  self.stateData:InitData(initData.stateList or {})
  self.highlightList = table.clone(initData.highlightList or {})
  self.recoverRecords = initData.lastRecordList
  local playerRoleData = initData.roleDataList[1]
  local model = playerRoleData.oceanModel or "OceanModel1"
  self.oceanModel = Vue.ref(model)
  self.schoolMap = playerRoleData.schoolMap or {}
  self.boutBloodRecoverTimes = Vue.ref(playerRoleData.boutBloodRecoverTimes)
  for _, roleData in ipairs(initData.roleDataList) do
    self:CreateRoleModel(roleData)
  end
  for _, roleData in ipairs(initData.monsterDataList or {}) do
    self:CreateRoleModel(roleData)
  end
  self:InitMyCamp()
  self.playerDataModel:SetMoney(initData.money)
  self:SetRealEnergy(self.playerDataModel:GetProperty(bc.RoleProperty.energy))
  local statsData = initData.statsData or {}
  for _, camp in pairs({
    bc.BattleCamp.Camp1,
    bc.BattleCamp.Camp2
  }) do
    local data = statsData[camp] or {}
    local battleStatsDataModel = self.binder:createModel(BattleStatsDataModel)
    battleStatsDataModel:InitData(data)
    self.statsDataModelMap[camp] = battleStatsDataModel
  end
  if bg.isRestart then
    pcall(BattleCameraDataUtils.SaveCamera, "")
  end
  EventMgr.Instance.BattleData:Dispatch()
end

function BattleDataCenterClient:CreateRoleModel(roleData)
  local roleDataModel = self.roleDataModelMap[roleData.uid] or self.binder:createModel(BattleRoleDataModel)
  roleDataModel:InitData(roleData)
  self.roleDataModelMap[roleDataModel.uid] = roleDataModel
  return roleDataModel
end

function BattleDataCenterClient:InitMyCamp()
  local gamePlayerId = PlayerDataUtils.GetPlayerUid()
  local myPlayerId = 0 ~= gamePlayerId and gamePlayerId or MOCK_PLAYER_ID
  if bg.battleData and bg.battleData.watchPlayerUid then
    myPlayerId = bg.battleData.watchPlayerUid
  end
  for _, roleDataModel in pairs(self.roleDataModelMap) do
    if roleDataModel.playerId == myPlayerId then
      self:SetMyCamp(roleDataModel.camp)
      self.playerDataModel = roleDataModel
      break
    end
  end
  if not self.playerDataModel then
    for _, roleDataModel in pairs(self.roleDataModelMap) do
      if roleDataModel.roleType == bc.RoleType.Player and roleDataModel.camp == BattleCamp.Camp1 then
        self:SetMyCamp(roleDataModel.camp)
        self.playerDataModel = roleDataModel
        break
      end
    end
  end
end

function BattleDataCenterClient:SetMyCamp(camp)
  self.myCamp.value = camp
end

function BattleDataCenterClient:GetMyCamp()
  return self.myCamp.value
end

function BattleDataCenterClient:IsMyCamp(camp)
  return self.myCamp.value == camp
end

function BattleDataCenterClient:IsMyActionCamp()
  local myCamp = self.myCamp.value
  local phase = self.boutData.phase
  return myCamp == self.boutData.camp and phase == bc.BoutPhase.Action
end

function BattleDataCenterClient:GetEnemyCamp(myCamp)
  myCamp = myCamp or self.myCamp.value
  return myCamp == BattleCamp.Camp1 and BattleCamp.Camp2 or BattleCamp.Camp1
end

function BattleDataCenterClient:GetCurBout()
  return self.boutData.boutNumber
end

function BattleDataCenterClient:ReplaceSfxPath(path, ownerUid)
  if not path or not ownerUid then
    return path
  end
  local roleDataModel = self.roleDataModelMap[ownerUid]
  if roleDataModel then
    local skinId = roleDataModel:GetSkinId()
    if AwakerSkinUtils.IsReplaceBattleEffect(skinId) then
      do return self.ReplaceSkinPath, self, path end
      return self.ReplaceSkinPath, self, path, ownerUid
    end
  end
  return path
end

function BattleDataCenterClient:ReplaceSkinPath(path, ownerUid)
  if not path or not ownerUid then
    return path
  end
  local roleDataModel = self.roleDataModelMap[ownerUid]
  if roleDataModel then
    local skinId = roleDataModel:GetSkinId()
    if skinId and skinId ~= cd.DefaultSkinTid then
      local awakerConfig = bg.DT.AwakerConfig[roleDataModel.tid]
      local awakerResNum = awakerConfig.AwakerResNum
      local skinResNum = AwakerSkinUtils.GetSkinResNum(skinId)
      if awakerResNum and skinResNum and path:contains(awakerResNum) then
        path = path:gsub(awakerResNum, skinResNum)
        return path
      end
    end
  end
  return path
end

function BattleDataCenterClient:GetRoleSkin(roleUid)
  local roleDataModel = self.roleDataModelMap[roleUid]
  if roleDataModel then
    do return roleDataModel.GetSkinId end
    return roleDataModel.GetSkinId, roleDataModel
  end
  return nil
end

function BattleDataCenterClient:GetAwakerResNum(tid)
  local awakerConfig = bg.DT.AwakerConfig[tid]
  local roleDataList = self.roleDataModelMap
  for _, roleDataModel in pairs(roleDataList) do
    if tid == roleDataModel.tid then
      local skinId = roleDataModel:GetSkinId()
      if skinId and skinId ~= cd.DefaultSkinTid then
        local skinResNum = AwakerSkinUtils.GetSkinResNum(skinId)
        return skinResNum
      end
    end
  end
  return awakerConfig.AwakerResNum
end

function BattleDataCenterClient:GetPlayerGender()
  return self.gender
end

function BattleDataCenterClient:GetPlayerName()
  return self.playerName
end

function BattleDataCenterClient:SetPlayerKeeperSkill(keeperSkillId)
  self.playerDataModel:SetKeeperSkill(keeperSkillId)
end

function BattleDataCenterClient:GetPlayerKeeperSkill()
  return self.playerDataModel.keeperSkill
end

function BattleDataCenterClient:GetPlayerUid()
  return self.playerDataModel.uid
end

function BattleDataCenterClient:GetPlayerUidByCamp(camp)
  local PLAYER = bc.RoleType.Player
  for _, roleDataModel in pairs(self.roleDataModelMap) do
    if roleDataModel.roleType == PLAYER and roleDataModel.camp == camp then
      return roleDataModel.uid
    end
  end
end

function BattleDataCenterClient:GetPlayerKeeperSkillArgs()
  return self.playerDataModel.keeperSkillArgs
end

function BattleDataCenterClient:GetPlayerSilverKeyAwakeDescArgs()
  return self.playerDataModel.silverKeyAwakeDescArgs
end

function BattleDataCenterClient:SetPlayerKeeperSkillArgs(skillArgs)
  self.playerDataModel:SetPlayerKeeperSkillArgs(skillArgs)
end

function BattleDataCenterClient:GetPlayerRoleProperty(propertyName)
  do return self.playerDataModel.GetProperty, self.playerDataModel end
  return self.playerDataModel.GetProperty, self.playerDataModel, propertyName
end

function BattleDataCenterClient:GetBoutSkillTimes(uid)
  local awaker = self.roleDataModelMap[uid]
  if not awaker then
    return 0
  end
  return awaker.boutSkillTimes or 0
end

function BattleDataCenterClient:GetBoutSilverKeyAwakeTimes(uid)
  local awaker = self.roleDataModelMap[uid]
  if not awaker then
    return 0
  end
  return awaker.silverKeyAwakeTimes or 0
end

function BattleDataCenterClient:GetBoutChaosType2SkillTimes(uid)
  local roleDataModel = self.roleDataModelMap[uid]
  if not roleDataModel then
    return 0
  end
  return roleDataModel.chaosType2SkillTimes or 0
end

function BattleDataCenterClient:GetBoutChaosType2Skill2Times(uid)
  local roleDataModel = self.roleDataModelMap[uid]
  if not roleDataModel then
    return 0
  end
  return roleDataModel.chaosType2Skill2Times or 0
end

function BattleDataCenterClient:GetPlayerRoleDataModel(camp)
  local myCamp = camp or self.myCamp.value
  local PLAYER = bc.RoleType.Player
  for _, roleDataModel in pairs(self.roleDataModelMap) do
    if roleDataModel.camp == myCamp and roleDataModel.roleType == PLAYER then
      return roleDataModel
    end
  end
end

function BattleDataCenterClient:GetCardDimensionStep()
  return self.cardDimensionStep.value
end

function BattleDataCenterClient:UpdateCardDimensionStep()
  self.cardDimensionStep.value = self.cardDimensionStep.value + 1
end

function BattleDataCenterClient:SetRealCamp(camp)
  self._realCamp.value = camp
end

function BattleDataCenterClient:GetRealCamp()
  return self._realCamp.value
end

function BattleDataCenterClient:SetIsMyBoutEnd(boolVal)
  self._isMyBoutEnd.value = boolVal
end

function BattleDataCenterClient:GetIsMyBoutEnd()
  return self._isMyBoutEnd.value
end

function BattleDataCenterClient:SetRealEnergy(energy)
  self._realEnergy.value = energy
end

function BattleDataCenterClient:GetRealEnergy()
  return self._realEnergy.value
end

function BattleDataCenterClient:GetRoleCamp(uid)
  local roleDataModel = self.roleDataModelMap[uid]
  return roleDataModel and roleDataModel.camp
end

function BattleDataCenterClient:GetRoleDataModel(uid)
  return self.roleDataModelMap[uid]
end

function BattleDataCenterClient:SetLockerUidToLockedUid(lockerUidToLockedUid)
  self.lockerUidToLockedUid = lockerUidToLockedUid or {}
end

function BattleDataCenterClient:GetLockedEnemyUid(uid)
  if not uid then
    return nil
  end
  return self.lockerUidToLockedUid[uid]
end

function BattleDataCenterClient:GetLockingAwakenerUids(uid)
  local result = {}
  if not uid then
    return result
  end
  for lockerUid, lockedUid in pairs(self.lockerUidToLockedUid) do
    if lockedUid == uid then
      table.insert(result, lockerUid)
    end
  end
  return result
end

function BattleDataCenterClient:GetRoleDataModelByTid(tid, camp)
  local matchCamp = camp or self:GetMyCamp()
  for _, roleDataModel in pairs(self.roleDataModelMap) do
    if roleDataModel.tid == tid and roleDataModel.camp == matchCamp then
      return roleDataModel
    end
  end
end

function BattleDataCenterClient:GetPlayerIdByCamp(camp)
  for _, roleDataModel in pairs(self.roleDataModelMap) do
    if roleDataModel.camp == camp and roleDataModel.roleType == bc.RoleType.Player then
      return roleDataModel.playerId
    end
  end
end

function BattleDataCenterClient:GetMyPlayerId()
  do return self.GetPlayerIdByCamp, self, self:GetMyCamp() end
  return self.GetPlayerIdByCamp, self, self:GetMyCamp()
end

function BattleDataCenterClient:GetAwakerDataModel(uid)
  return self.roleDataModelMap[uid]
end

function BattleDataCenterClient:GetAwakerDataModelByCfgId(cfgId)
  for uid, awakerdataModel in pairs(self.roleDataModelMap) do
    if awakerdataModel.tid == cfgId then
      return awakerdataModel
    end
  end
  return nil
end

function BattleDataCenterClient:GetPlayerStateById(stateId)
  local playerUid = self.playerDataModel.uid
  do return self.stateData.GetRoleState, self.stateData, playerUid end
  return self.stateData.GetRoleState, self.stateData, playerUid, stateId
end

function BattleDataCenterClient:GetCardStateList(cardUid)
  local list = {}
  local cardStateList = self.stateData:GetCardStateList(cardUid)
  if cardStateList then
    for _, state in ipairs(cardStateList) do
      if state.configData and state.configData.ShowType ~= bc.StateShowType.Hide then
        table.insert(list, state)
      end
    end
  end
  return list
end

function BattleDataCenterClient:GetStateDescByTid(stateTid)
  do return self.stateData.GetStateDescByTid, self.stateData end
  return self.stateData.GetStateDescByTid, self.stateData, stateTid
end

function BattleDataCenterClient:GetRoleName(uid, withLevel)
  local roleDataModel = self:GetRoleDataModel(uid)
  do return roleDataModel.GetRoleName, roleDataModel end
  return roleDataModel.GetRoleName, roleDataModel, withLevel
end

function BattleDataCenterClient:GetRoleLevel(uid)
  local roleDataModel = self:GetRoleDataModel(uid)
  do return roleDataModel.GetTeamAverageLevel end
  return roleDataModel.GetTeamAverageLevel, roleDataModel
end

function BattleDataCenterClient:GetAffixStr(affixIds)
  local affixStr = ""
  local affixConnectStr = LT.Text("AffixConnect")
  local DT = bg.DT
  for _, affixId in ipairs(affixIds) do
    local stateCfg = DT.State[affixId]
    if stateCfg and stateCfg.Name then
      affixStr = affixStr .. LT.Text(stateCfg.Name) .. affixConnectStr
    end
  end
  return affixStr
end

function BattleDataCenterClient:CheckEnemyDead(winCamp)
  local isAllDead = true
  for _, roleDataModel in pairs(self.roleDataModelMap) do
    if roleDataModel.camp ~= winCamp and roleDataModel.dead then
      isAllDead = false
      break
    end
  end
  return isAllDead
end

function BattleDataCenterClient:GetRoleModelList(camp)
  local roleModeList = {}
  for _, roleDataModel in pairs(self.roleDataModelMap) do
    if roleDataModel.camp == camp and roleDataModel:GetHp() > 0 then
      table.insert(roleModeList, roleDataModel)
    end
  end
  return roleModeList
end

function BattleDataCenterClient:GetAwakerListByCamp(camp)
  local roleModeList = {}
  for _, roleDataModel in pairs(self.roleDataModelMap) do
    if roleDataModel.camp == camp and roleDataModel.roleType == bc.RoleType.Awaker then
      table.insert(roleModeList, roleDataModel)
    end
  end
  return roleModeList
end

function BattleDataCenterClient:IsSchool(schoolCnId)
  for id in pairs(self.schoolMap or {}) do
    local schoolCfg = DT.SchoolConfig[id]
    if schoolCfg and schoolCfg.CnID == schoolCnId then
      return true
    end
  end
end

function BattleDataCenterClient:IsPureSchool(schoolId)
  return self.schoolMap[schoolId] and not self:IsMixSchool()
end

function BattleDataCenterClient:IsNewChaosSchool()
  local isChaosType2 = self:GetPlayerRoleProperty("is_chaos_type2")
  return isChaosType2 and isChaosType2 > 0
end

function BattleDataCenterClient:IsMixSchool()
  local count = 0
  for _ in pairs(self.schoolMap or {}) do
    count = count + 1
    if count > 1 then
      return true
    end
  end
end

function BattleDataCenterClient:IsMixSchoolExChoas()
  if self:IsSchool(bc.SchoolCnID.CHAOS) then
    return
  end
  do return self.IsMixSchool end
  return self.IsMixSchool, self, bc.SchoolCnID.CHAOS
end

function BattleDataCenterClient:IsNewExtraBoutState()
  local DimensionTurnCtl = 1 == DT.GetConstant("DimensionTurnCtl", 1)
  if not DimensionTurnCtl then
    return true
  end
  local extraBoutStateId = DT.GetConstant("TranscendentCtl")
  if extraBoutStateId then
    local state = self:GetPlayerStateById(extraBoutStateId)
    return state and state.layer > 0
  end
end

function BattleDataCenterClient:GetOpMode()
  return self.opMode.value
end

function BattleDataCenterClient:SetOpMode(opMode, revertPlayTime)
  self.opMode.value = opMode
  if self._revertPlayTimer then
    bg.battleRender:UnperformWithDelay(self._revertPlayTimer)
  end
  if opMode ~= rc.OpMode.Play then
    self._revertPlayTimer = bg.battleRender:PerformWithDelay(revertPlayTime or 10, function()
      self.opMode.value = rc.OpMode.Play
      self._revertPlayTimer = nil
    end)
  end
end

function BattleDataCenterClient:IsOpModePlay()
  return self.opMode.value == rc.OpMode.Play
end

function BattleDataCenterClient:IsOpModeInspect()
  return self.opMode.value == rc.OpMode.Inspect
end

function BattleDataCenterClient:GetCastingName()
  local myCamp = bg.battleDataCenter:GetMyCamp()
  local cardMgr = bg.battleRender.cardMgr:GetCardMgrByCamp(myCamp)
  local usingCardDeck = cardMgr:GetCardListByDeck(bc.CardDeck.UsingDeck)
  local usingCard = usingCardDeck[1]
  if usingCard then
    do return LT.Text end
    return LT.Text, usingCard.configData.Name
  end
  if bg.ultiSkillAwakerTid then
    do return AwakerDataUtils.GetUltiSkillName end
    return AwakerDataUtils.GetUltiSkillName, bg.ultiSkillAwakerTid
  end
end

function BattleDataCenterClient:GetCastingDesc()
  local myCamp = bg.battleDataCenter:GetMyCamp()
  local cardMgr = bg.battleRender.cardMgr:GetCardMgrByCamp(myCamp)
  local usingCardDeck = cardMgr:GetCardListByDeck(bc.CardDeck.UsingDeck)
  local usingCard = usingCardDeck[1]
  if usingCard then
    do return LT.Text, usingCard:GetCardDescription() end
    return LT.Text, usingCard:GetCardDescription()
  end
  if bg.ultiSkillAwakerTid then
    do return self.GetUltiSkillDesc, self end
    return self.GetUltiSkillDesc, self, bg.ultiSkillAwakerTid
  end
end

function BattleDataCenterClient:GetUltiSkillDesc(ultiSkillAwakerTid, ownerAwaker)
  local awakerConfig = bg.DT.AwakerConfig[ultiSkillAwakerTid]
  local ultiSkillId = awakerConfig.PVPSkillList[1]
  local roleDataModel = self:GetRoleDataModel(ownerAwaker.uid)
  roleDataModel = roleDataModel or self:GetRoleDataModelByTid(ultiSkillAwakerTid)
  do return BattleSkillUtils.GetCardDesc, ultiSkillId, ownerAwaker, 1 end
  return BattleSkillUtils.GetCardDesc, ultiSkillId, ownerAwaker, 1, roleDataModel.descArgs
end

function BattleDataCenterClient:InsertHistory(data)
  if #self.history.value >= self:GetShowHistoryNum() then
    table.remove(self.history.value, 1)
  end
  data.isDisplay = true
  table.insert(self.history.value, data)
end

function BattleDataCenterClient:IsInPvpDraft()
  return bg.battleDataCenter.draftRelicTid ~= nil
end

function BattleDataCenterClient:GetShowHistoryNum()
  if self:IsInPvpDraft() then
    return 5
  end
  return 6
end

function BattleDataCenterClient:GetHistory()
  return self.history.value
end

function BattleDataCenterClient:SetOceanModel(model)
  self.oceanModel.value = model
end

function BattleDataCenterClient:GetOceanModel()
  return self.oceanModel.value or BattleConst.OceanModel.OceanModel1
end

function BattleDataCenterClient:CheckKeeperSkillAwakeEnable()
  local stateVal = self:GetPlayerStateById(DT.GetConstant("SilverKeyAwakeState"))
  if not stateVal or 0 == stateVal then
    return false
  end
  if self:CheckAllAwakerAwakedOrHasAwakeCard() then
    return false
  end
  return true
end

function BattleDataCenterClient:CheckAllAwakerAwakedOrHasAwakeCard()
  local cardMgr = bg.battleRender and bg.battleRender.cardMgr
  if not cardMgr then
    return false
  end
  local awakerList = self:GetAwakerListByCamp(self:GetMyCamp())
  if 0 == #awakerList then
    return false
  end
  for _, awaker in ipairs(awakerList) do
    if not awaker.awaked then
      local awakerConfig = awaker.configData or DT.AwakerConfig[awaker.tid]
      local skillList = awakerConfig and awakerConfig.SkillList
      local awakeSkillId = skillList and skillList[bc.SlotOrder.Slot_Awake]
      local card = cardMgr:GetCardByConfigId(awakeSkillId)
      if not (awakeSkillId and card) or card.deck == bc.CardDeck.NoneDeck then
        return false
      end
    end
  end
  return true
end

function BattleDataCenterClient:CheckKeeperSkillAwakeInCD()
  local keeperSkillLocked
  local keeperAwakeLocked = self:CheckKeeperAwakeInCD()
  local chaosType2Locked = true
  if self:IsNewChaosSchool() then
    keeperSkillLocked = self:CheckChaosType2Skill2InCD()
    chaosType2Locked = self:CheckChaosType2SkillInCD()
  else
    keeperSkillLocked = self:CheckKeeperSkillInCD()
  end
  return keeperSkillLocked and keeperAwakeLocked and chaosType2Locked
end

function BattleDataCenterClient:CheckKeeperAwakeInCD()
  if not self:CheckKeeperSkillAwakeEnable() then
    return true
  end
  local uid = self:GetPlayerUid()
  local times = self:GetBoutSilverKeyAwakeTimes(uid)
  return times >= self:GetPlayerRoleProperty(bc.RoleProperty.bout_skill_times)
end

function BattleDataCenterClient:CheckChaosType2SkillInCD()
  local uid = self:GetPlayerUid()
  local times = self:GetBoutChaosType2SkillTimes(uid)
  return times >= self:GetPlayerRoleProperty(bc.RoleProperty.bout_skill_times)
end

function BattleDataCenterClient:CheckChaosType2Skill2InCD()
  local uid = self:GetPlayerUid()
  local times = self:GetBoutChaosType2Skill2Times(uid)
  return times >= self:GetPlayerRoleProperty(bc.RoleProperty.bout_skill_times)
end

function BattleDataCenterClient:CheckKeeperSkillInCD()
  local uid = self:GetPlayerUid()
  local times = self:GetBoutSkillTimes(uid)
  return times >= self:GetPlayerRoleProperty(bc.RoleProperty.bout_skill_times)
end

return BattleDataCenterClient
