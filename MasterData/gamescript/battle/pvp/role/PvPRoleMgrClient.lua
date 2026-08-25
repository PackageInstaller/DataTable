local PvPRoleMgrClient, _ = System.NewClass("PvPRoleMgrClient")

function PvPRoleMgrClient:ctor()
  self.effectPlayQueue = BattleEffextPlayQueueCom()
end

function PvPRoleMgrClient:Awake()
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
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.FloatingText, self.OnFloatingText, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.AfterAction, self.OnAfterAction, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.PropertyChanged, self.OnPropertyChanged, self)
end

function PvPRoleMgrClient:Dispose()
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
end

function PvPRoleMgrClient:InitAllRole(msgData)
  self:InitRoleList(msgData.roleDataList, msgData.roleDataList[1].camp)
  self:InitRoleList(msgData.monsterDataList, msgData.monsterDataList[1].camp)
end

function PvPRoleMgrClient:InitRoleList(roleDataList, camp)
  local playerSpawnPoints = bg.battleScene:GetSpawnPointsMap(camp)
  if nil == playerSpawnPoints then
    Logger.Error("No SpawnPoints for monster")
    return
  end
  local awakerPoints = {}
  for _, awakerData in ipairs(roleDataList) do
    if awakerData.roleType == bc.RoleType.Awaker then
      if awakerData.battleFieldPos then
        awakerPoints[awakerData.battleFieldPos] = playerSpawnPoints[awakerData.battleFieldPos]
      else
        table.insert(awakerPoints, playerSpawnPoints[awakerData.battleFieldPos])
      end
    end
  end
  for _, roleData in ipairs(roleDataList) do
    bg.battleScene:CreaterRole(roleData, awakerPoints)
  end
end

function PvPRoleMgrClient:IsHaveAvailAwakerSkill()
  return false
end

function PvPRoleMgrClient:OnPropertyChanged(data)
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
  local role = bg.battleScene:GetRoleByUid(data.uid)
  if role and data.propertyType == bc.BattleProperty.ulti_energy then
    local showText = data.extraData and data.extraData.showText
    role.floatTextUI:OnPVPUltiEnergyChange(data.changedValue, showText)
  end
end

function PvPRoleMgrClient:OnMonsterIntention(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  if not role then
    return
  end
  role:SetIntention(data.intention, data.damageInfo, data.descArgs)
end

function PvPRoleMgrClient:OnMonsterChangePos(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  role:OnMonsterChangePos(data.battleFieldPos)
end

function PvPRoleMgrClient:OnRoleIdleStateChanged(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  role:SetIdleState(data.idleState)
end

function PvPRoleMgrClient:OnDeathResist(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  if role then
    role:PushFloatingText(bc.FloatingTextType.Text, LT.Text("Battle_Str_DeathResist", true))
  end
end

function PvPRoleMgrClient:OnRemoveRole(data)
  local roleUid = data.roleUid
  bg.battleScene:RemoveRole(roleUid)
end

function PvPRoleMgrClient:OnSpawnWaveMonster(data)
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

function PvPRoleMgrClient:OnSpawnMonster(data)
  bg.battleDataCenter:CreateRoleModel(data.roleData)
  local monsterSpawnPoints = bg.battleScene.spawnPointMap[bc.BattleCamp.Camp2]
  if nil == monsterSpawnPoints then
    Logger.Error("No SpawnPoints for monster")
    return
  end
  local awakerPoints = {}
  table.insert(awakerPoints, monsterSpawnPoints[data.roleData.battleFieldPos])
  local role = bg.battleScene:CreaterRole(data.roleData, awakerPoints)
  for _, awaker in ipairs(role.awakerList) do
    if awaker.isMonster then
      awaker:PlaySummon()
    end
  end
end

function PvPRoleMgrClient:OnBeHit(data)
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

function PvPRoleMgrClient:OnTentacleAttack(data)
  local role = bg.battleScene:GetRoleByUid(data.roleUid)
  role:OnTentacleAttack(data)
end

function PvPRoleMgrClient:Tick(deltaTime)
  self.effectPlayQueue:Tick(deltaTime)
end

function PvPRoleMgrClient:OnAfterAction(data)
  local actionType = data.actionType
  if actionType == bc.ActionType.MonsterAction then
    self.effectPlayQueue:Clear()
  end
end

function PvPRoleMgrClient:IsHaveUnplayedEffectSfx(roleUid)
  local role = bg.battleScene:GetRole(roleUid)
  if not role then
    return
  end
  local isHaveInQue = self.effectPlayQueue:IsHaveUnplayedEffectSfx(roleUid)
  local isHaveInRole = role:IsHaveUnplayedEffectSfx()
  return isHaveInQue or isHaveInRole
end

function PvPRoleMgrClient:OnPlayEffectSfx(data)
  local targetType = data.targetType
  local targetUids = data.targetUids
  local tSfxConfigIds = data.sfxConfigId
  local cmdId = data.cmdId
  if targetType == bc.PerformTargetType.Awaker then
    if 1 == #targetUids then
      self.effectPlayQueue:OnPlay_SingleTarget_EffectSfx(cmdId, targetUids[1], tSfxConfigIds, data.castRoleUid)
    else
      self.effectPlayQueue:OnPlay_MultiTarget_EffectSfx(cmdId, targetUids, tSfxConfigIds, data.castRoleUid)
    end
  elseif targetType == bc.PerformTargetType.Role then
    self.effectPlayQueue:OnPlay_Role_EffectSfx(cmdId, targetUids, tSfxConfigIds, data.castRoleUid)
  elseif targetType == bc.PerformTargetType.Card then
    for _, targetUid in ipairs(targetUids) do
      local cardItem = bg.battlePanel:GetCardItemByUid(targetUid)
      if cardItem then
        local sfxConfigId = tSfxConfigIds[1]
        cardItem:PlaySfx(sfxConfigId)
      end
    end
  elseif targetType == bc.PerformTargetType.Camp1FieldCenter then
    local attachment = bg.battleScene:GetSfxAttachmentPoint(bc.BattleCamp.Camp1)
    local sfxConfigId = tSfxConfigIds[1]
    bg.battleScene:PlaySfx(sfxConfigId, attachment, bc.BattleCamp.Camp1, data.castRoleUid)
  elseif targetType == bc.PerformTargetType.Camp2FieldCenter then
    local attachment = bg.battleScene:GetSfxAttachmentPoint(bc.BattleCamp.Camp2)
    local sfxConfigId = tSfxConfigIds[1]
    bg.battleScene:PlaySfx(sfxConfigId, attachment, bc.BattleCamp.Camp2, data.castRoleUid)
  end
end

function PvPRoleMgrClient:OnSkillTimesChange(data)
end

function PvPRoleMgrClient:OnFloatingText(data)
  local roleUid = data.roleUid
  local role = bg.battleScene:GetRoleByUid(roleUid)
  if role then
    local textCfg = DT.LanguageConfig[data.text]
    local text = LT.Text(textCfg and textCfg.CN or data.text, true)
    if data.text == "Battle_Tips_Immune" then
      local stateId = data.args.stateId
      if stateId then
        text = text .. LT.Text(DT.State[stateId].Name)
      end
    end
    role:PushFloatingText(data.textType, text, nil, {
      outlineColor = data.color
    })
  end
end

return PvPRoleMgrClient
