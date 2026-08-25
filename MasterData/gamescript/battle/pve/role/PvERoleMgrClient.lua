local PvERoleMgrClient, _ = System.NewClass("PvERoleMgrClient")

function PvERoleMgrClient:ctor()
  self.effectPlayQueue = BattleEffextPlayQueueCom()
end

function PvERoleMgrClient:Awake()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.MonsterIntention, self.OnMonsterIntention, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.MonsterChangePos, self.OnMonsterChangePos, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.IdleStateChanged, self.OnRoleIdleStateChanged, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.RemoveRole, self.OnRemoveRole, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SpawnMonster, self.OnSpawnMonster, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.BeHit, self.OnBeHit, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.DeathResist, self.OnDeathResist, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.TentacleAttack, self.OnTentacleAttack, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.PlayEffectSfx, self.OnPlayEffectSfx, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SkillTimesChange, self.OnSkillTimesChange, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SilverKeyAwakeTimesChange, self.OnSilverKeyAwakeTimesChange, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChaosType2SkillTimesChange, self.OnChaosType2SkillTimesChange, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChaosType2Skill2TimesChange, self.OnChaosType2Skill2TimesChange, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.FloatingText, self.OnFloatingText, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AfterAction, self.OnAfterAction, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.PropertyChanged, self.OnPropertyChanged, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SilverKeyAwakeArgsChange, self.OnSilverKeyAwakeArgsChange, self)
end

function PvERoleMgrClient:Dispose()
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
end

function PvERoleMgrClient:InitAllRole(msgData)
  local roleDataList = msgData.roleDataList
  self:InitRoleDataList(roleDataList)
  bg.battleRender.ultiSkillMgr:InitAllUltiSkills(roleDataList)
  self:InitAllMonster(msgData.monsterDataList)
end

function PvERoleMgrClient:InitRoleDataList(roleDataList)
  local playerSpawnPoints = bg.battleScene:GetSpawnPointsMap(bc.BattleCamp.Camp1)
  if nil == playerSpawnPoints then
    Logger.Error("No SpawnPoints for player ")
    return
  end
  for _, roleData in ipairs(roleDataList) do
    bg.battleScene:CreaterRole(roleData, playerSpawnPoints)
  end
  bg.battleScene:UpdateAwakerPositionShift()
end

function PvERoleMgrClient:InitAllMonster(monsterDataList)
  local monsterSpawnPoints = bg.battleScene:GetSpawnPointsMap(bc.BattleCamp.Camp2)
  if nil == monsterSpawnPoints then
    Logger.Error("No SpawnPoints for monster")
    return
  end
  for _, monsterData in ipairs(monsterDataList) do
    local monsterDataModel = bg.battleDataCenter:GetRoleDataModel(monsterData.uid)
    if monsterDataModel:GetHp() > 0 then
      bg.battleScene:CreaterRole(monsterData, monsterSpawnPoints)
    end
  end
end

function PvERoleMgrClient:IsHaveAvailAwakerSkill()
  local allRole = bg.battleScene:GetRoleListByCamp(bc.BattleCamp.Camp1)
  for _, awaker in ipairs(allRole) do
    local awakerDataModel = bg.battleDataCenter:GetAwakerDataModel(awaker.uid)
    local timesLimit = awakerDataModel:GetProperty(bc.BattleProperty.bout_ulti_times)
    local curTimes = awakerDataModel.boutSkillTimes or 0
    if timesLimit > curTimes then
      local proName = bc.BattleProperty.ulti_energy
      local ultiEnergy = awakerDataModel:GetProperty(proName)
      if ultiEnergy >= bc.UltiEnergyPerSkill then
        return true
      end
    end
  end
end

function PvERoleMgrClient:HaveAvailKeeperSkill()
  local uid = bg.battleDataCenter:GetPlayerUid()
  local curEnergy = bg.battleRender.recordMgr:GetRealProperty(uid, bc.RoleProperty.keeper_energy)
  curEnergy = curEnergy or bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.keeper_energy)
  local costEnergy = KeeperSkillUtils.GetCost()
  local energyEnough = curEnergy >= costEnergy
  local keeperSkillInCd
  if bg.battleDataCenter:IsNewChaosSchool() then
    keeperSkillInCd = bg.battleDataCenter:CheckChaosType2Skill2InCD()
  else
    keeperSkillInCd = bg.battleDataCenter:CheckKeeperSkillInCD()
  end
  local keeperEnergyOk = bg.battleDataCenter:IsNewChaosSchool() or energyEnough
  if not keeperSkillInCd and keeperEnergyOk then
    return true
  end
  if not bg.battleDataCenter:CheckKeeperAwakeInCD() and energyEnough then
    return true
  end
  if bg.battleDataCenter:IsNewChaosSchool() and not bg.battleDataCenter:CheckChaosType2SkillInCD() and energyEnough then
    return true
  end
  return false
end

function PvERoleMgrClient:OnPropertyChanged(data)
  local property = data.propertyType
  local battleRoleHandleType = {
    [bc.RoleProperty.hp] = true,
    [bc.RoleProperty.block] = true
  }
  if battleRoleHandleType[property] then
    return
  end
  local roleDataModel = bg.battleDataCenter:GetRoleDataModel(data.uid)
  if roleDataModel then
    roleDataModel:SetProperty(data.propertyType, data.value)
  end
end

function PvERoleMgrClient:OnMonsterIntention(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  if not role then
    return
  end
  role:SetIntention(data.intention, data.damageInfo, data.descArgs)
end

function PvERoleMgrClient:OnMonsterChangePos(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  role:OnMonsterChangePos(data.battleFieldPos)
end

function PvERoleMgrClient:OnRoleIdleStateChanged(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  role:SetIdleState(data.idleState)
end

function PvERoleMgrClient:OnDeathResist(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  if role then
    role:PushFloatingText(bc.FloatingTextType.Text, LT.Text("Battle_Str_DeathResist", true))
  end
end

function PvERoleMgrClient:OnRemoveRole(data)
  local roleUid = data.roleUid
  bg.battleScene:RemoveRole(roleUid)
end

function PvERoleMgrClient:OnSpawnWaveMonster(data)
  local roleDataList = data.roleDataList
  local monsterSpawnPoints = bg.battleScene.spawnPointMap[bc.BattleCamp.Camp2]
  if nil == monsterSpawnPoints then
    Logger.Error("No SpawnPoints for monster")
    return
  end
  for _, roleData in ipairs(roleDataList) do
    local awakerPoints = {}
    table.insert(awakerPoints, monsterSpawnPoints[roleData.battleFieldPos])
    bg.battleScene:CreaterRole(roleData, awakerPoints)
  end
end

function PvERoleMgrClient:OnSpawnMonster(data)
  bg.battleDataCenter:CreateRoleModel(data.roleData)
  local monsterSpawnPoints = bg.battleScene.spawnPointMap[bc.BattleCamp.Camp2]
  if nil == monsterSpawnPoints then
    Logger.Error("No SpawnPoints for monster")
    return
  end
  local role = bg.battleScene:CreaterRole(data.roleData, monsterSpawnPoints)
  role:OnEnterBattle()
  for _, awaker in ipairs(role.awakerList) do
    if awaker.isMonster then
      awaker:PlaySummon()
    end
  end
end

function PvERoleMgrClient:OnBeHit(data)
  local playerRole = bg.battleScene:GetPlayerRole()
  local beHitConfig = data.beHitConfig
  if playerRole.uid == beHitConfig.destRoleUid then
    return
  end
  local value = beHitConfig.originVal
  if beHitConfig.hpChangeReason == bc.PropertyChangeReason.AttrModify then
    value = math.abs(value)
  end
  bg.battleRender.boutMgr:AddBoutDamage(value)
end

function PvERoleMgrClient:OnTentacleAttack(data)
  local role = bg.battleScene:GetRoleByUid(data.roleUid)
  role:OnTentacleAttack(data)
end

function PvERoleMgrClient:Tick(deltaTime)
  self.effectPlayQueue:Tick(deltaTime)
end

function PvERoleMgrClient:OnAfterAction(data)
  local actionType = data.actionType
  if actionType == bc.ActionType.MonsterAction then
    self.effectPlayQueue:Clear()
  end
end

function PvERoleMgrClient:IsHaveUnplayedEffectSfx(roleUid)
  local role = bg.battleScene:GetRole(roleUid)
  if not role then
    return
  end
  local isHaveInQue = self.effectPlayQueue:IsHaveUnplayedEffectSfx(roleUid)
  local isHaveInRole = role:IsHaveUnplayedEffectSfx()
  return isHaveInQue or isHaveInRole
end

function PvERoleMgrClient:OnPlayEffectSfx(data)
  local targetType = data.targetType
  local targetUids = data.targetUids
  local sfxConfigId = data.sfxConfigId
  local cmdId = data.cmdId
  local tImmediateSfxId, tSfxConfigIds = self:SplitImmediateAndQueSfxList(sfxConfigId, targetType)
  if #tImmediateSfxId > 0 then
    self:PlaySfxImmediately(tImmediateSfxId)
  end
  if 0 == #tSfxConfigIds then
    return
  end
  if targetType == bc.PerformTargetType.Awaker then
    if 1 == #targetUids then
      self.effectPlayQueue:OnPlay_SingleTarget_EffectSfx(cmdId, targetUids[1], tSfxConfigIds, data.castRoleUid)
    else
      self.effectPlayQueue:OnPlay_MultiTarget_EffectSfx(cmdId, targetUids, tSfxConfigIds, data.castRoleUid)
    end
  elseif targetType == bc.PerformTargetType.Role then
    self.effectPlayQueue:OnPlay_Role_EffectSfx(cmdId, targetUids, tSfxConfigIds, data.castRoleUid)
  elseif targetType == bc.PerformTargetType.Card then
    local oneSfxId = tSfxConfigIds[1]
    for _, targetUid in ipairs(targetUids) do
      local cardItem = bg.battlePanel:GetCardItemByUid(targetUid)
      if cardItem then
        cardItem:PlaySfx(oneSfxId)
      end
    end
  elseif targetType == bc.PerformTargetType.Camp1FieldCenter then
    local attachment = bg.battleScene:GetSfxAttachmentPoint(bc.BattleCamp.Camp1)
    local oneSfxId = tSfxConfigIds[1]
    bg.battleScene:PlaySfx(oneSfxId, attachment, bc.BattleCamp.Camp1, data.castRoleUid)
  elseif targetType == bc.PerformTargetType.Camp2FieldCenter then
    local attachment = bg.battleScene:GetSfxAttachmentPoint(bc.BattleCamp.Camp2)
    local oneSfxId = tSfxConfigIds[1]
    bg.battleScene:PlaySfx(oneSfxId, attachment, bc.BattleCamp.Camp2, data.castRoleUid)
  end
end

function PvERoleMgrClient:SplitImmediateAndQueSfxList(tSfxConfigIds, targetType)
  local tImmediateSfxId = {}
  if targetType == bc.PerformTargetType.Awaker or targetType == bc.PerformTargetType.Role then
    for i = #tSfxConfigIds, 1, -1 do
      local sfxConfigId = tonumber(tSfxConfigIds[i])
      local sfxConfig = bg.DT.BattleSfxConfig[sfxConfigId]
      if 0 ~= (sfxConfig.PlayNow or 0) then
        table.remove(tSfxConfigIds, i)
        table.insert(tImmediateSfxId, sfxConfigId)
      end
    end
  end
  return tImmediateSfxId, tSfxConfigIds
end

function PvERoleMgrClient:PlaySfxImmediately(targetUids, sfxConfigId)
  for _, targetUid in ipairs(targetUids) do
    local role = bg.battleScene:GetRoleByUid(targetUid)
    local awaker = role.awakerList[1]
    awaker:PlaySfx(sfxConfigId)
  end
end

function PvERoleMgrClient:OnSkillTimesChange(data)
  local roleDataModel = bg.battleDataCenter:GetRoleDataModel(data.roleUid)
  if data.isClear then
    roleDataModel:ClearUtlitSkillTimes()
  else
    roleDataModel:SetSkillTimes(data.roleUid, data.times)
  end
end

function PvERoleMgrClient:OnSilverKeyAwakeTimesChange(data)
  local roleDataModel = bg.battleDataCenter:GetRoleDataModel(data.roleUid)
  if roleDataModel then
    roleDataModel:SetSilverKeyAwakeTimes(data.roleUid, data.times)
  end
end

function PvERoleMgrClient:OnChaosType2SkillTimesChange(data)
  local roleDataModel = bg.battleDataCenter:GetRoleDataModel(data.roleUid)
  if roleDataModel then
    roleDataModel:SetChaosType2SkillTimes(data.roleUid, data.times)
  end
end

function PvERoleMgrClient:OnChaosType2Skill2TimesChange(data)
  local roleDataModel = bg.battleDataCenter:GetRoleDataModel(data.roleUid)
  if roleDataModel then
    roleDataModel:SetChaosType2Skill2Times(data.roleUid, data.times)
  end
end

function PvERoleMgrClient:OnFloatingText(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  if role then
    local text = LT.Text(data.text, true)
    if data.text == "Battle_Tips_Immune" then
      local stateId = data.args.stateId
      if stateId then
        text = text .. LT.Text(DT.State[stateId].Name)
      end
    end
    role:PushFloatingText(data.textType, text)
  end
end

function PvERoleMgrClient:OnSilverKeyAwakeArgsChange(data)
  local roleDataModel = bg.battleDataCenter:GetRoleDataModel(data.roleUid)
  if roleDataModel then
    roleDataModel:SetSilverKeyAwakeDescArgs(data.descArgs)
  end
end

return PvERoleMgrClient
