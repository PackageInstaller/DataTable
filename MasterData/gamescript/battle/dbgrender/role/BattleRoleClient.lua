local Vector3 = CS.UnityEngine.Vector3
local BP = bc.BattleProperty
local PositionShift = CS.Z1Client.PositionShift
local ApiTypeAudio = {
  [bc.BattleEffectType.BELaunchSwallow] = {
    audioEvent = "SFX_REALM_B_EMBRYO_CONSUME",
    campAssign = bc.BattleCamp.Camp1
  }
}
local PropertyChangeAudio = {
  [BP.battle_tentacle_count] = {
    AddValue = "SFX_REALM_O_TENTACLE_GEN"
  },
  [BP.scarlet_blood_count] = {
    AddValue = "SFX_REALM_B_BLOOD_FILL"
  }
}
local BattleRoleClient, Super = System.NewClass("BattleRoleClient", BattleEntity)

function BattleRoleClient:ctor(config, spawnPoints)
  Super.ctor(self)
  self.respawnEvent = Event()
  self.roleDataModel = bg.battleDataCenter:GetRoleDataModel(config.uid)
  self.config = table.deepclone(config)
  self.uid = self.config.uid
  self.tid = self.config.tid
  self.camp = self.config.camp
  self.level = self.config.level
  self.dead = Vue.ref(false)
  self.bubbleInfo = Vue.ref({})
  self:AddBattleComponent(BattleRoleFsmComp)
  self.battleFieldPos = config.battleFieldPos
  self.roleType = config.roleType
  self.configData = self:GetConfigData()
  self.abortController = AbortController()
  self.binder = bg.battleScene:GetChildBinder()
  self.passTime = 0
  self.idleState = 1
  self.playingSfxList = {}
  self.effectSfxList = {}
  self.sfxList = {}
  self.spawnPoints = spawnPoints
  self.lastActingAwakerUid = nil
  if not self.config.awakerDataList and self.roleType ~= bc.RoleType.Player then
    self.config.awakerDataList = {
      table.clone(config)
    }
    self:Preload()
    self:InitAwakers(self.config.awakerDataList, spawnPoints)
  else
    self.awakerList = {}
  end
  self:InitTentacles()
  self:RegisterEvents()
  self.awakerEffectSfxList = {}
  self.delayBlockChangeFuncs = {}
  self.delayHpChangeFuncs = {}
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleRoleClient:Dispose()
  self.binder:teardown()
  if self.keeperTimelinePlayer then
    self.keeperTimelinePlayer:Dispose()
    self.keeperTimelinePlayer = nil
  end
  self:UnregisterEvents()
  for _, awaker in ipairs(self.awakerList) do
    awaker:Dispose()
  end
  for _, v in ipairs(self.tentacleList) do
    v:Dispose()
  end
  self.abortController:Abort()
  Super.Dispose(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleRoleClient:Preload()
  for _, awakerData in ipairs(self.config.awakerDataList) do
    if awakerData.roleType ~= bc.RoleType.Player then
      BattleAwakerClient.Preload(self, awakerData.tid, awakerData.roleType, bg.battleScene.factoryLayer)
    end
  end
end

function BattleRoleClient:GetConfigData()
  if self.roleType == bc.RoleType.Awaker then
    return bg.DT.AwakerConfig[self.tid]
  elseif self.roleType == bc.RoleType.Monster then
    return bg.DT.MonsterConfig[self.tid]
  end
end

function BattleRoleClient:Tick(deltaTime)
  self.passTime = self.passTime + deltaTime
  Super.Tick(self, deltaTime)
  for _, awaker in ipairs(self.awakerList) do
    awaker:Tick(deltaTime)
  end
  self:TickUI(deltaTime)
  self:TickBlock(deltaTime)
  self:TickHp(deltaTime)
  self:TickImmueSound()
  self:TickPlayEffectSfx(deltaTime)
  self:TickPlayAwakerEffectSfx(deltaTime)
end

function BattleRoleClient:RegisterEvents()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.BeHit, self.OnBeHit, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.PropertyChanged, self.OnPropertyChanged, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.MoneyChange, self.OnMoneyChange, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SwapAwaker, self.OnSwapAwaker, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.Respawn, self.OnRespawn, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.MonsterBubble, self.OnMonsterBubble, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.DoEffect, self.OnDoEffect, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.UseKeeperSkill, self.OnKeeperSkill, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.UseSilverKeyAwake, self.OnUseSilverKeyAwake, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeMonsterAnim, self.OnChangeMonsterAnim, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.NotAwakerTimeline, self.OnNotAwakerTimeline, self)
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.MonsterHpNumChange, self.OnMonsterHpNumChange, self)
  EventMgr.Instance.PVPAwakerSelect:RegisterEvent(System.fn(self, self.OnPVPAwakerSelect))
  if bg.isPVP then
    bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.SkillArgsChange, self.OnUpdateSkillArgs, self)
  end
end

function BattleRoleClient:UnregisterEvents()
  local allComponents = self:GetAllComponents()
  for _, comp in ipairs(allComponents) do
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(comp)
  end
  bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  EventMgr.Instance.PVPAwakerSelect:RemoveEvent(System.fn(self, self.OnPVPAwakerSelect))
end

function BattleRoleClient:OnUpdateSkillArgs(argInfo)
  if argInfo.roleUid ~= self.uid then
    return
  end
  self.roleDataModel:UpdateSkillArgs(argInfo.args, argInfo.descArgs)
  if self.roleDataModel:IsRoleType(bc.RoleType.Player) then
    self.roleDataModel:SetPlayerKeeperSkillArgs(argInfo.descArgs)
  end
end

function BattleRoleClient:OnKeeperSkill(msgData)
  if msgData.roleUid ~= self.uid then
    return
  end
  local keeperSkill = msgData.skillId or self.roleDataModel.keeperSkill
  local skillFile = KeeperSkillUtils.GetSkillTimelinePath(keeperSkill)
  if not skillFile then
    return
  end
  local skillName = KeeperSkillUtils.GetSkillName(keeperSkill)
  local gender = bg.battleDataCenter:GetPlayerGender()
  local sounds = {
    [CommonDefine.GenderID.Boy] = "Play_VOC_Player_Skill_Me_Male_1",
    [CommonDefine.GenderID.Girl] = "Play_VOC_Player_Skill_Me_Female_1"
  }
  local sound = sounds[gender]
  if sound then
    AudioManager.Instance:PostSoundEvent(sound)
  end
  self:PlayKeeperSkillTimeline(skillFile, skillName, nil, true)
end

function BattleRoleClient:OnUseSilverKeyAwake(msgData)
  if msgData.roleUid ~= self.uid then
    return
  end
end

function BattleRoleClient:OnNotAwakerTimeline(msgData)
  if msgData.roleUid ~= self.uid then
    return
  end
  local skillCfg = DT.Skill[msgData.skillId]
  local PerformList = skillCfg.Perform or {}
  local Perform = PerformList[1]
  local timelineEventData = bg.DT.TimelineEventData[skillCfg.NotAwakerCardPerform[1]] or {}
  local timelineData = timelineEventData[Perform]
  if not timelineData then
    return
  end
  if not timelineData.file then
    return
  end
  local skillFile = timelineData.file
  local skillName = LT.Text(skillCfg.Name)
  self:PlayKeeperSkillTimeline(skillFile, skillName, nil, false)
end

function BattleRoleClient:OnChangeMonsterAnim(data)
  for _, awaker in ipairs(self.awakerList) do
    awaker:OnChangeAnimIdx(data.animIdx)
  end
end

function BattleRoleClient:GetHitSfxBlister(srcRole, skillConfigId)
  if not (srcRole and table.next(srcRole.awakerList)) or not skillConfigId then
    return
  end
  if srcRole.roleType == bc.RoleType.Player then
    return
  end
  local perform
  local awaker = srcRole.lastAttackAwaker or srcRole.awakerList[1]
  if awaker then
    perform = awaker.skillPerform
  end
  if not perform then
    local skillCfg = DT.Skill[skillConfigId]
    perform = skillCfg.Perform and skillCfg.Perform[1] or nil
  end
  if perform and awaker and awaker.animationConfig then
    return awaker.animationConfig[perform .. "hitSfxBlister"]
  end
end

function BattleRoleClient:OnPropertyChanged(data)
  if data.uid ~= self.uid then
    return
  end
  local propertyType = data.propertyType
  local oldValue = self.roleDataModel:GetProperty(propertyType)
  if propertyType == BP.hp then
    self:OnHpChanged(data.changedValue, oldValue, data.value, data.reason, data)
  elseif propertyType == BP.block then
    self:OnBlockChanged(data.changedValue, oldValue, data.value, data.reason, data)
  elseif propertyType == BP.monster_hide then
    for _, awaker in ipairs(self.awakerList) do
      awaker:SetHidingState(1 == data.value)
    end
  end
  self:AudioProcessWhenPropertyChange(data.changedValue, oldValue, data.value, data.reason, data)
  if propertyType == BP.awaked and 1 == data.value then
    for _, awaker in ipairs(self.awakerList) do
      awaker:OnAwaked()
    end
  end
end

function BattleRoleClient:IsHidden()
  if self.roleDataModel then
    local isHideVal = self.roleDataModel:GetProperty("monster_hide")
    return isHideVal and isHideVal > 0
  end
  return false
end

function BattleRoleClient:OnMoneyChange(data)
  self.roleDataModel:SetMoney(data.totalValue)
  if self.camp == bc.BattleCamp.Camp1 then
    if 1 == data.floatText then
      local text, floatType
      if data.value > 0 then
        text = LT.Text("PhiloStone") .. " +" .. data.value
        floatType = bc.FloatingTextType.PositiveTextAndIcon
      else
        text = LT.Text("PhiloStone") .. " " .. data.value
        floatType = bc.FloatingTextType.NegativeTextAndIcon
      end
      self:PushFloatingText(floatType, text)
    end
    CopiesDataUtils.CheckBackpackItem({
      {
        tid = 100,
        changeNum = data.value,
        num = data.totalValue
      }
    })
  end
end

function BattleRoleClient:OnSwapAwaker(data)
  if data.roleUid ~= self.uid then
    return
  end
  local awaker1 = self:GetAwakerByUid(data.awakerUid1)
  local awaker2 = self:GetAwakerByUid(data.awakerUid2)
  if awaker1 and awaker2 then
    local acotr1Pos = awaker1.battleFieldPos
    local awaker2Pos = awaker2.battleFieldPos
    awaker1:MoveToPos(awaker2Pos, self.spawnPoints[awaker2Pos])
    awaker2:MoveToPos(acotr1Pos, self.spawnPoints[acotr1Pos])
  end
end

function BattleRoleClient:OnRespawn(data)
  if data.roleUid ~= self.uid then
    return
  end
  if self.camp == bc.BattleCamp.Camp1 then
    self.respawnEvent:Dispatch(data.deadTimes or 0)
  end
end

function BattleRoleClient:OnMonsterChangePos(battleFieldPos)
  self.battleFieldPos = battleFieldPos
  local camp = bc.BattleCamp.Camp2
  if bg.isPVP_TRAIN then
    camp = self.camp
  end
  local monsterSpawnPoints = bg.battleScene.spawnPointMap[camp]
  local spawnPoint = monsterSpawnPoints[battleFieldPos]
  for i, awakerClient in ipairs(self.awakerList) do
    awakerClient.spawnPoint = spawnPoint
    awakerClient.rootNode.transform:DOMove(awakerClient:GetSpawnPosition(), 0.3)
  end
end

function BattleRoleClient:OnHpChanged(changedValue, oldValue, value, reason, data)
  self.realTimeHp = value
  for _, awaker in ipairs(self.awakerList) do
    if awaker:InHidingState() then
      return
    end
  end
  local extraData = data.extraData or {}
  if not extraData.skipText and self.floatTextUI then
    self.floatTextUI:ShowHpChangeText(changedValue, reason, data.isRestrain, data.extraData)
  end
  table.insert(self.delayHpChangeFuncs, function()
    self.roleDataModel:SetProperty(bc.RoleProperty.hp, value)
    if changedValue > 0 then
      local audioEvent
      if self.camp == bg.battleDataCenter:GetMyCamp() then
        audioEvent = "SFX_FT_HEALING_PLAYER"
      elseif self.camp == bg.battleDataCenter:GetEnemyCamp() then
        audioEvent = "SFX_FT_HEALING_EN"
      end
      local isIgnoreAudio = extraData.skipText
      if isIgnoreAudio then
        audioEvent = nil
      end
      if nil ~= audioEvent then
        AudioManager.Instance:PostSoundEvent(audioEvent)
      end
    end
    if self.dead.value and value > 0 then
      self:Revive()
    end
  end)
end

function BattleRoleClient:Revive()
  if not self:IsLogicAlive() then
    return
  end
  self.dead.value = false
  if self.awakerList and self.awakerList[1] then
    self.awakerList[1]:Revive()
  end
  self:RestoreStatusUIAfterRevive()
end

function BattleRoleClient:RestoreStatusUIAfterRevive()
  if not bg.isPVE or not self.statusUI then
    return
  end
  if self.statusUI.uiRoot == nil or IsNil(self.statusUI.uiRoot) then
    self:RecreateRoleUINode()
    return
  end
  local bloodUI = self.statusUI.bloodUI
  if bloodUI and bloodUI.PlayBloodReviveAnim then
    bloodUI:PlayBloodReviveAnim()
  end
end

function BattleRoleClient:PlayKeeperSkillTimeline(skillFile, skillName, onComplete, showSkillName)
  if not self.keeperTimelinePlayer then
    self.keeperTimelinePlayer = KeeperSkillTimelinePlayer(self)
  end
  if self.keeperTimelinePlayer.SetSkillName then
    self.keeperTimelinePlayer:SetSkillName(skillName)
  end
  print("PlayKeeperSkillTimeline", skillFile)
  local awaiter = Awaiter.Dispatch("KeeperSkill" .. (skillFile or skillName or ""), 10)
  self.keeperTimelinePlayer:PlayTimeline(skillFile, bg.battleRender.gameSpeed or 1, 0, function()
    awaiter:SetCompleted()
    if onComplete then
      onComplete()
    end
  end)
  if showSkillName then
    if skillFile ~= CommonDefine.Player_Respawn_Timeline then
      KeeperSkillNamePanel.Play(skillName or "")
    else
      local DT = bg.DT
      bg.battleRender:PerformWithDelay(DT.GetConstant("ReviveTextShowDelay") or 0, function()
        KeeperSkillNamePanel.Play(skillName or "")
      end, self)
    end
  end
end

function BattleRoleClient:AudioProcessWhenPropertyChange(changedValue, oldValue, nowBlock, reason, data)
  local audioEvent = PropertyChangeAudio[data.propertyType]
  if nil ~= audioEvent then
    local eventName = changedValue > 0 and audioEvent.AddValue or audioEvent.SubValue
    if nil ~= eventName then
      AudioManager.Instance:PostSoundEvent(eventName)
    end
  end
end

function BattleRoleClient:OnBlockChanged(changedValue, oldValue, nowBlock, reason, extraData)
  if changedValue > 0 then
    local text = string.format("%s<space=0.2em>%s", bc.NumberToK(changedValue), LT.Text("BlockText"))
    self:PushFloatingText(bc.FloatingTextType.Block, text)
  end
  
  local function stopIdleBlockSfx()
    if self.idleBlockSfxList then
      for _, sfx in ipairs(self.idleBlockSfxList) do
        sfx:Abort()
      end
      self.idleBlockSfxList = nil
    end
  end
  
  local DT = bg.DT
  
  local function blockChangeFunc()
    self.roleDataModel:SetProperty(bc.RoleProperty.block, nowBlock)
    local buildSfxCConfigId, idleSfxConfigId, hitSfxConfigId, brokenSfxConfigId, disappearSfxConfigId, scale
    local defaultBlockIndex = 1
    if self.camp == bc.BattleCamp.Camp1 and bg.isPVE then
      buildSfxCConfigId = DT.ShieldConfig[defaultBlockIndex].BuildSfx
      idleSfxConfigId = DT.ShieldConfig[defaultBlockIndex].IdleSfx
      hitSfxConfigId = DT.ShieldConfig[defaultBlockIndex].HitSfx
      brokenSfxConfigId = DT.ShieldConfig[defaultBlockIndex].BrokenSfx
      disappearSfxConfigId = DT.ShieldConfig[defaultBlockIndex].DisappearSfx
    end
    if bg.isPVP or self.camp == bc.BattleCamp.Camp2 then
      local animConfig = self.awakerList[1].animationConfig
      local shiledConfig = DT.ShieldConfig[animConfig.ShieldSfx or defaultBlockIndex]
      buildSfxCConfigId = shiledConfig.BuildSfx
      idleSfxConfigId = shiledConfig.IdleSfx
      hitSfxConfigId = shiledConfig.HitSfx
      brokenSfxConfigId = shiledConfig.BrokenSfx
      disappearSfxConfigId = shiledConfig.DisappearSfx
      scale = shiledConfig.Size
    end
    if reason == bc.PropertyChangeReason.BlockReset then
      if self.blockVisible then
        if bg.isPVE then
          self:PlayMultiSfx(disappearSfxConfigId, scale)
        end
        stopIdleBlockSfx()
        self.blockVisible = false
      end
    elseif reason == bc.PropertyChangeReason.BlockLose then
      if 0 == nowBlock then
        if bg.isPVE then
          self:PlayMultiSfx(brokenSfxConfigId, scale)
        elseif bg.isPVP then
          self:PlayMultiSfx({
            DT.GetConstant("PVPShieldBreak")
          }, scale * -1)
        end
        stopIdleBlockSfx()
        self.blockVisible = false
      elseif bg.isPVE then
        self:PlayMultiSfx(hitSfxConfigId, scale)
      elseif bg.isPVP then
        self:PlayMultiSfx({
          DT.GetConstant("PVPShieldHit")
        }, scale * -1)
      end
    elseif reason == bc.PropertyChangeReason.BlockGain then
      if 0 == nowBlock then
        if self.blockVisible then
          stopIdleBlockSfx()
          self.blockVisible = false
        end
      elseif 0 == oldValue then
        self.idleBlockSfxList = self:PlayMultiSfx(idleSfxConfigId, scale)
        self:PlayMultiSfx(buildSfxCConfigId, scale)
        self.blockVisible = true
      else
        self:PlayMultiSfx(buildSfxCConfigId, scale)
        self.blockVisible = true
      end
    end
  end
  
  self.delayBlockChangeFuncs = self.delayBlockChangeFuncs or {}
  if 0 ~= changedValue then
    table.insert(self.delayBlockChangeFuncs, blockChangeFunc)
  end
end

function BattleRoleClient:OnAwakerDead(awaker)
  local roleDead = true
  BattleVoiceController.Instance:OnPvpVoiceAwakerDied(self.tid, self.camp)
  for _, v in ipairs(self.awakerList) do
    if v.dead == false then
      roleDead = false
      break
    end
  end
  if roleDead then
    self.dead.value = true
  end
end

function BattleRoleClient:GetRealHp()
  return self.realTimeHp or self.roleDataModel:GetProperty(BP.hp)
end

function BattleRoleClient:GetLogicHp()
  local recordMgr = bg.battleRender and bg.battleRender.recordMgr
  local logicHp = recordMgr and recordMgr:GetRealPropertyOrNil(self.uid, bc.RoleProperty.hp)
  if nil ~= logicHp then
    return logicHp
  end
  return self:GetRealHp() or 0
end

function BattleRoleClient:IsLogicAlive()
  return self:GetLogicHp() > 0
end

function BattleRoleClient:CheckIsRealDead()
  return self.dead.value == true or 0 == self:GetRealHp()
end

function BattleRoleClient:OnPVPAwakerSelect(uidMap)
  if self.roleType ~= bc.RoleType.Awaker then
    return
  end
  local layerName = "Actor"
  if uidMap and uidMap[self.uid] then
    layerName = "Monster"
  end
  local awaker = self.awakerList[1]
  UIRootMgr.SetLayerRecursively(awaker and awaker.rootNode, layerName)
  if self.statusUI and not IsNil(self.statusUI.uiNode) then
    UIRootMgr.SetLayerRecursively(self.statusUI.uiNode, layerName)
  end
end

function BattleRoleClient:Destroy()
  bg.battleScene:RemoveRole(self.uid)
end

function BattleRoleClient:OnBeHit(data)
  if data.uid ~= self.uid then
    return
  end
  self.roleDataModel:SetProperty(BP.max_hp, data.beHitConfig.curMaxHp)
  if data.beHitConfig and data.beHitConfig.immueDamage then
    self.immueSounds = self.immueSounds or {}
    table.insert(self.immueSounds, {
      Sound = "Play_SFX_Ft_Immunity_Hurt",
      Time = 0
    })
  end
end

function BattleRoleClient:ShowDamageText(floatingTextType, data)
  self:ShowDamageText(floatingTextType, data)
end

function BattleRoleClient:OnAfterUseCard()
end

function BattleRoleClient:PushFloatingText(floatingTextType, text, icon, data)
  if self.floatTextUI then
    self.floatTextUI:PushFloatingText(floatingTextType, text, icon, data)
  end
end

function BattleRoleClient:InitAwakers(awakerDataList, spawnPoints)
  self.awakerList = {}
  self.awakerNum = #awakerDataList
  table.sort(awakerDataList, function(a, b)
    return a.battleFieldPos < b.battleFieldPos
  end)
  for i, awakerData in ipairs(awakerDataList) do
    awakerData.spawnPoint = spawnPoints[awakerData.battleFieldPos or i] or spawnPoints[1]
    local awaker = BattleAwakerClient(self, awakerData)
    awaker.index = i
    table.insert(self.awakerList, awaker)
  end
end

function BattleRoleClient:CreateRoleUINode()
  local uiLayer = bg.battleScene:GetUILayer()
  if bg.isPVE then
    if self.roleType ~= bc.RoleType.Awaker then
      self.statusUI = self.binder:BindComponent(BattleRoleRootUINode(uiLayer, self))
      self.floatTextUI = self.statusUI:CreateFloadTextUI()
    end
  elseif self.roleType == bc.RoleType.Awaker then
    self.statusUI = self.binder:BindComponent(PVPBattleRoleRootUINode(uiLayer, self))
    self.floatTextUI = self.statusUI:CreateFloadTextUI()
  end
end

function BattleRoleClient:RecreateRoleUINode()
  if self.statusUI then
    self.statusUI.binder:teardown()
    self:CreateRoleUINode()
    if self.statusUI and bg.battlePanel then
      self.statusUI:SetActive(bg.battlePanel:GetUIVisible())
      local isPlayReBoneHpEffect = true
      self.statusUI.binder:BindToRaw(function(_, isVisible)
        if isVisible and isPlayReBoneHpEffect then
          isPlayReBoneHpEffect = false
          if self.statusUI then
            self.statusUI:PlayReboneHpEffect()
          end
        end
      end, function()
        do return bg.battlePanel.GetUIVisible end
        return bg.battlePanel.GetUIVisible, bg.battlePanel
      end, true)
    end
  end
end

function BattleRoleClient:OnEnterBattle()
  self:InitPlayerAwaker()
  self:CreateRoleUINode()
  self:OnRoleShowUp()
end

function BattleRoleClient:OnRoleShowUp()
  if bg.isPVE and self.camp == bc.BattleCamp.Camp1 then
    return
  end
  if self.roleType == bc.RoleType.Player then
    return
  end
  if 0 == self.roleDataModel:GetHp() then
    self.dead.value = true
    for _, awaker in ipairs(self.awakerList) do
      awaker:SetToDeadState()
    end
    return
  end
  local showupList = {}
  for _, awaker in ipairs(self.awakerList) do
    if awaker:IsHaveAnim(bc.BattleSpineAnimEnum.Showup) then
      awaker.spineComp:GetSpineNode():SetActive(false)
      table.insert(showupList, awaker)
    end
  end
  if next(showupList) then
    local enterCameraTime = 1.5
    bg.battleRender:PerformWithDelay(enterCameraTime, function()
      for _, awaker in ipairs(showupList) do
        awaker.spineComp:GetSpineNode():SetActive(true)
        awaker:PlayShowUpAnim()
      end
    end, self)
  end
end

function BattleRoleClient:InitPlayerAwaker()
  if self.roleType == bc.RoleType.Player then
    local allRole = bg.battleScene:GetRoleListByCamp(self.camp)
    local awakerList = {}
    for _, role in ipairs(allRole) do
      for _, awaker in ipairs(role.awakerList) do
        table.insert(awakerList, awaker)
      end
    end
    self.awakerList = awakerList
  end
  for _, awaker in ipairs(self.awakerList) do
    if 1 == self:GetAwakerProperty(awaker.uid, bc.BattleProperty.awaked) then
      awaker:OnAwaked()
    end
  end
end

function BattleRoleClient:GetAwakerByUid(awakerUid)
  for _, awaker in ipairs(self.awakerList) do
    if awaker.uid == awakerUid then
      return awaker
    end
  end
end

function BattleRoleClient:GetAwakerByConfigId(tid)
  for _, awaker in ipairs(self.awakerList) do
    if awaker.tid == tid then
      return awaker
    end
  end
end

function BattleRoleClient:GetAwakerList()
  return self.awakerList
end

function BattleRoleClient:GetRandomAwaker(awaker)
  local awakerList = self.awakerList
  local index = math.random(1, #awakerList)
  return awakerList[index]
end

function BattleRoleClient:GetBodyPos()
  local centerPos = CS.UnityEngine.Vector3(0, 0, 0)
  for _, awaker in ipairs(self.awakerList) do
    centerPos = centerPos + awaker:GetBodyPos()
  end
  centerPos = centerPos / #self.awakerList
  return centerPos
end

function BattleRoleClient:GetFloatTextPos()
  local footPos = self:GetFootPos()
  local bodyPos = self:GetBodyPos()
  local pos = Vector3.Lerp(footPos, bodyPos, 0.5)
  return pos
end

function BattleRoleClient:GetTentacleHitPos()
  local centerPos = Vector3(0, 0, 0)
  for _, awaker in ipairs(self.awakerList or {}) do
    centerPos = centerPos + awaker:GetTentacleHitPos()
  end
  return centerPos / #self.awakerList
end

function BattleRoleClient:GetFootPos()
  local centerPos = Vector3(0, 0, 0)
  for _, awaker in ipairs(self.awakerList or {}) do
    centerPos = centerPos + awaker:GetFootPos()
  end
  return centerPos / #self.awakerList
end

function BattleRoleClient:GetRootNode()
  do return bg.battleScene.GetSfxAttachmentPoint, bg.battleScene end
  return bg.battleScene.GetSfxAttachmentPoint, bg.battleScene, self.camp
end

function BattleRoleClient:GetEnergy()
  return self.roleDataModel:GetProperty(BP.energy) or 0
end

function BattleRoleClient:SetIntention(intention, damageInfo, descArgs)
  self.roleDataModel:SetIntention(intention, damageInfo, descArgs)
end

function BattleRoleClient:SetIdleState(idleState)
  if self.idleState == idleState then
    return
  end
  self.idleState = idleState
  for _, awaker in ipairs(self.awakerList) do
    awaker:SetIdleState(idleState)
  end
end

function BattleRoleClient:ChangePhase(oldPhase, newPhase)
  for _, awaker in ipairs(self.awakerList) do
    awaker:ChangePhase(oldPhase, newPhase)
  end
  bg.battleScene.cameraComp:SetBossPhase(newPhase)
end

function BattleRoleClient:PlayEffectSfx(sfxConfigId, castRoleUid)
  if BattlePerformanceLevel.IsHitEffectDedupEnabled() then
    local sfxConfig = bg.DT.BattleSfxConfig[sfxConfigId]
    if not (sfxConfig and sfxConfig.DisplayPriority) or sfxConfig.DisplayPriority < 2 then
      self._lastEffectSfxTime = self._lastEffectSfxTime or {}
      local lastTime = self._lastEffectSfxTime[sfxConfigId]
      if lastTime and self.passTime - lastTime < BattlePerformanceLevel.GetHitEffectDedupWindow() then
        return
      end
      self._lastEffectSfxTime[sfxConfigId] = self.passTime
    end
  end
  table.insert(self.effectSfxList, {sfxConfigId = sfxConfigId, castRoleUid = castRoleUid})
end

function BattleRoleClient:TickPlayEffectSfx()
  if self.passTime - (self.lastPlayEffectSfxTime or 0) >= bc.DamageFloatInterval then
    local sfxInfo = table.remove(self.effectSfxList, 1)
    if sfxInfo then
      local sfxConfigId = sfxInfo.sfxConfigId
      local castRoleUid = sfxInfo.castRoleUid
      self.lastPlayEffectSfxTime = self.passTime
      if self.camp == bc.BattleCamp.Camp1 then
        local sfxAttachmentPoint = bg.battleScene:GetSfxAttachmentPoint(self.camp)
        self:PlaySfx(sfxConfigId, sfxAttachmentPoint, false, nil, castRoleUid)
      elseif not self.awakerList[1]:IsDieState() then
        self.awakerList[1]:PlaySfx(sfxConfigId, nil, nil, nil, castRoleUid)
      end
    end
  end
end

function BattleRoleClient:PlayAwakerEffectSfx(awakerUid, sfxConfigId, checkKey, castRoleUid)
  if not self:IsPlayingSfx(awakerUid, checkKey) then
    self:DoPlayAwakerEffectSfx(awakerUid, sfxConfigId, checkKey, castRoleUid)
  else
    self.awakerEffectSfxList = self.awakerEffectSfxList or {}
    table.insert(self.awakerEffectSfxList, {
      awakerUid = awakerUid,
      sfxConfigId = sfxConfigId,
      checkKey = checkKey,
      castRoleUid = castRoleUid
    })
  end
end

function BattleRoleClient:IsHaveUnplayedEffectSfx()
  return #(self.awakerEffectSfxList or {}) > 0 or #self.effectSfxList > 0
end

function BattleRoleClient:TickPlayAwakerEffectSfx()
  if #self.awakerEffectSfxList <= 0 then
    return
  end
  if self.passTime - (self.lastPlayAwakerEffectTime or 0) >= bc.DamageFloatInterval then
    local sfxConfigInfo = table.remove(self.awakerEffectSfxList, 1) or {}
    local awakerUid = sfxConfigInfo.awakerUid
    local sfxConfigId = sfxConfigInfo.sfxConfigId
    local checkKey = sfxConfigInfo.checkKey
    local castRoleUid = sfxConfigInfo.castRoleUid
    self:DoPlayAwakerEffectSfx(awakerUid, sfxConfigId, checkKey, castRoleUid)
  end
end

function BattleRoleClient:DoPlayAwakerEffectSfx(awakerUid, sfxConfigId, checkKey, castRoleUid)
  local awaker = awakerUid and self:GetAwakerByUid(awakerUid)
  if nil == awaker then
    return
  end
  if awaker:IsDieState() then
    return
  end
  local key = self:GetKey(awakerUid, checkKey)
  self.playingSfxList[key] = true
  self.lastPlayAwakerEffectTime = self.passTime
  awaker:PlaySfx(sfxConfigId, nil, nil, nil, nil, castRoleUid)
  bg.battleRender:PerformWithDelay(bc.DamageFloatInterval, function()
    self.playingSfxList[key] = nil
  end, self)
end

function BattleRoleClient:IsPlayingSfx(awakerUid, checkKey)
  local key = self:GetKey(awakerUid, checkKey)
  return self.playingSfxList[key]
end

function BattleRoleClient:GetKey(awakerUid, checkKey)
  local key = awakerUid * checkKey
  return key
end

function BattleRoleClient:TickUI(deltaTime)
  if self.floatTextUI then
    self.floatTextUI:Tick(deltaTime)
  end
end

function BattleRoleClient:TickBlock(deltaTime)
  if #(self.delayBlockChangeFuncs or {}) > 0 and self.passTime - (self.lastBlockChangeTime or 0) >= bc.DamageFloatInterval then
    self.lastBlockChangeTime = self.passTime
    local func = table.remove(self.delayBlockChangeFuncs, 1)
    if func then
      func()
    end
  end
end

function BattleRoleClient:TickHp(deltaTime)
  if #(self.delayHpChangeFuncs or {}) > 0 and self.passTime - (self.lastHpChangeTime or 0) >= bc.DamageFloatInterval then
    self.lastHpChangeTime = self.passTime
    local func = table.remove(self.delayHpChangeFuncs, 1)
    if func then
      func()
    end
  end
end

function BattleRoleClient:TickImmueSound()
  if #(self.immueSounds or {}) > 0 then
    local immueSound = self.immueSounds[1]
    if self.passTime > immueSound.Time then
      table.remove(self.immueSounds, 1)
      if self.immueSounds[1] then
        self.immueSounds[1].Time = self.passTime + bc.DamageFloatInterval
      end
      AudioManager.Instance:PostSoundEvent(immueSound.Sound)
    end
  end
end

function BattleRoleClient:PlayArtAction()
  self.awakerList[1]:PlayArtAction()
end

function BattleRoleClient:PlaySfxWithDyanmicAttachment(sfxId)
end

function BattleRoleClient:PlayMultiSfx(sfxIds, scale)
  if nil == sfxIds then
    return
  end
  local sfxList = {}
  for _, sfxId in ipairs(sfxIds) do
    local sfx = self:PlaySfx(sfxId, nil, nil, scale)
    if sfx then
      table.insert(sfxList, sfx)
    end
  end
  return sfxList
end

function BattleRoleClient:PlayMaterialEffect(effectlist)
  for _, awaker in ipairs(self.awakerList) do
    awaker:PlayMaterialEffect(effectlist)
  end
end

function BattleRoleClient:ClearMaterialEffect(effectlist)
  for _, awaker in ipairs(self.awakerList) do
    awaker:ClearMaterialEffect(effectlist)
  end
end

function BattleRoleClient:PlaySfx(sfxId, attachment, follow, scale, castRoleUid)
  if nil == sfxId then
    return
  end
  for _, awaker in ipairs(self.awakerList) do
    if awaker:InHidingState() then
      return
    end
  end
  BattleAudioUtil.PlaySfxAudio(sfxId, self.camp, bg.battleScene.sceneLayer.gameObject)
  local sfx
  local sfxMgr = bg.battleRender.sfxMgr
  local seceneEffect = false
  local DT = bg.DT
  local sfxConfig = DT.BattleSfxConfig[sfxId]
  local position, parent
  if attachment then
    if follow then
      position = CS.UnityEngine.Vector3(0, 0, 0)
      parent = attachment
    else
      position = attachment.position
      parent = bg.battleScene:GetSfxAttachmentPoint(self.camp)
    end
  end
  if attachment then
    sfx = sfxMgr:CreateSfx(sfxId, parent, position, false, nil, self.abortController.signal, castRoleUid)
    if nil ~= scale then
      sfx.rootNode.transform.localScale = CS.UnityEngine.Vector3.New(scale, math.abs(scale), 1)
    end
    return sfx
  end
  if nil ~= sfxConfig.SceneMount then
    local sfxAttachmentPoint = bg.battleScene:GetSfxAttachmentPointByName(sfxConfig.SceneMount, self.camp)
    sfx = sfxMgr:CreateSfx(sfxId, bg.battleScene.sceneLayer, sfxAttachmentPoint.position, false, nil, self.abortController.signal, castRoleUid)
    if nil ~= scale and sfx.rootNode then
      sfx.rootNode.transform.localScale = CS.UnityEngine.Vector3(scale, math.abs(scale), 1)
    end
    self.sfxList[sfx] = true
    seceneEffect = true
  end
  if not seceneEffect then
    for _, awaker in ipairs(self.awakerList) do
      if not awaker:IsDieState() then
        sfx = awaker:PlaySfx(sfxId, scale, nil, nil, nil, castRoleUid)
      end
    end
  end
  return sfx
end

function BattleRoleClient:PlayStateSfx(sfxId)
  if nil == sfxId then
    return
  end
  BattleAudioUtil.PlaySfxAudio(sfxId, self.camp, bg.battleScene.sceneLayer.gameObject)
  local list = {}
  for _, awaker in ipairs(self.awakerList) do
    local sfx = awaker:PlaySfx(sfxId)
    table.insert(list, sfx)
  end
  return list
end

function BattleRoleClient:InitTentacles()
  self.tentacleList = {}
  if self.roleType ~= bc.RoleType.Player then
    return
  end
  local tentaclePrefab = self.binder:LoadAsset(bc.TentacleFrontPrefab)
  local sceneLayer = bg.battleScene.sceneLayer
  self.tentacleFront = self.binder:Instantiate(tentaclePrefab, sceneLayer)
  self.tentacleFront:SetActive(false)
end

function BattleRoleClient:OnTentacleAttack(data)
  if not table.next(data.targetUids or {}) then
    return
  end
  if BattlePerformanceLevel.IsTentacleDedupEnabled() then
    local sortedUids = table.clone(data.targetUids)
    table.sort(sortedUids)
    local dedupKey = table.concat(sortedUids, "_")
    self._lastTentaclePlayTime = self._lastTentaclePlayTime or {}
    local lastTime = self._lastTentaclePlayTime[dedupKey]
    if lastTime and self.passTime - lastTime < BattlePerformanceLevel.GetTentacleDedupWindow() then
      return
    end
    self._lastTentaclePlayTime[dedupKey] = self.passTime
  end
  local tentacleTf = self.tentacleFront.transform
  local tentacleCount = data.tentacleCount
  local targetUids = data.targetUids
  local timelineLocalPos, timelineWorldPos, timelineFile
  local rootScale = 1
  if #targetUids > 1 then
    timelineFile = bc.TentacleTimelineAoe
    local middlePosIndex = 5
    if bg.isPVP then
      middlePosIndex = 2
    end
    local enemyCamp = bg.battleDataCenter:GetEnemyCamp(self.camp)
    local middelTrans = bg.battleScene:GetSpawnPoint(enemyCamp, middlePosIndex)
    timelineWorldPos = middelTrans.position
  else
    timelineFile = tentacleCount < 3 and bc.TentacleTimelineLittle or bc.TentacleTimelineMass
    local targetUid = targetUids[1]
    local targetRole = bg.battleScene:GetRoleByUid(targetUid)
    if not targetRole then
      return
    end
    timelineWorldPos = targetRole:GetTentacleHitPos()
    local positionShift = self.tentacleFront:GetComponent(typeof(PositionShift))
    if positionShift then
      timelineWorldPos.x = timelineWorldPos.x + positionShift.shiftX
      timelineWorldPos.y = timelineWorldPos.y + positionShift.shiftY
      timelineWorldPos.z = timelineWorldPos.z + positionShift.shiftZ
    end
    if targetRole.awakerList[1] then
      rootScale = targetRole.awakerList[1]:GetSfxScale()
    end
  end
  self.tentacleFront:SetActive(true)
  if timelineLocalPos then
    tentacleTf.localPosition = timelineLocalPos
  elseif timelineWorldPos then
    tentacleTf.position = timelineWorldPos
  end
  local awaiter = Awaiter.Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(awaiter, "OnTentacleAttack")
  local saveAndReload = self.tentacleFront:GetComponent(typeof(CS.Z1Client.SaveAndReload))
  saveAndReload:Save()
  if self.tentacleTL then
    self.tentacleTL:Stop()
    self.tentacleTL = nil
    self.tentacleFront:SetActive(true)
  end
  self.tentacleTL = BattleTimeline.Get(timelineFile)
  
  local function callback()
    self.tentacleTL = nil
    awaiter:SetCompleted()
    saveAndReload:Reload()
    self.tentacleFront:SetActive(false)
  end
  
  self.tentacleTL:SetParent(bg.battleScene.sceneLayer):SetTarget(tentacleTf, bg.battleScene:GetSfxAttachmentPoint(self.camp)):SetSpeed(bg.battleRender.gameSpeed or 1):Play(self.tentacleFront, self.awakerList[1]:GetTimelineDir(), 0, callback, nil, nil)
  bg.battleRender:PerformWithDelay(0, function()
    tentacleTf.localScale = Vector3(rootScale * self.awakerList[1]:GetFace(), rootScale, 1)
  end, self)
end

function BattleRoleClient:GetProperty(propertyType)
  do return self.roleDataModel.GetProperty, self.roleDataModel end
  return self.roleDataModel.GetProperty, self.roleDataModel, propertyType
end

function BattleRoleClient:GetAwakerProperty(awakerUid, propertyType)
  local awakerDataModel = bg.battleDataCenter:GetAwakerDataModel(awakerUid)
  return awakerDataModel and awakerDataModel:GetProperty(propertyType) or 0
end

function BattleRoleClient:GetAwakerLevel(awakerTid)
  do return self.roleDataModel.GetAwakerLevel, self.roleDataModel end
  return self.roleDataModel.GetAwakerLevel, self.roleDataModel, awakerTid
end

function BattleRoleClient:GetTeamLevel()
  return self.roleDataModel.teamAveragyLevel
end

function BattleRoleClient:HasAnyAwakerUltiReady()
  for _, awaker in ipairs(self.awakerList) do
    local awakerDataModel = bg.battleDataCenter:GetAwakerDataModel(awaker.uid)
    local timesLimit = awakerDataModel:GetProperty(bc.BattleProperty.bout_ulti_times)
    local ultiEnery = awakerDataModel:GetProperty(bc.BattleProperty.ulti_energy)
    local curTimes = awakerDataModel.boutSkillTimes or 0
    if ultiEnery >= bc.UltiEnergyPerSkill and (0 == timesLimit or timesLimit > curTimes) then
      return true
    end
  end
end

function BattleRoleClient:OnMonsterBubble(data)
  if self.roleType ~= bc.RoleType.Monster then
    return
  end
  if data.monsterUid ~= self.uid then
    self.bubbleInfo.value = nil
    return
  end
  self.bubbleInfo.value = data
end

function BattleRoleClient:OnDoEffect(data)
  local audio = ApiTypeAudio[data.effectType]
  if nil ~= audio then
    local eventName = audio.audioEvent
    local campAssign = audio.campAssign
    if nil == campAssign or self.camp == campAssign then
      AudioManager.Instance:PostSoundEvent(eventName)
    end
  end
end

function BattleRoleClient:GetBubbleInfo()
  return self.bubbleInfo.value
end

function BattleRoleClient:UpdateSchoolArgs(schoolArgs)
  self.roleDataModel:SetSchoolArgs(schoolArgs)
end

function BattleRoleClient:GetSchoolConfigId()
  return self.roleDataModel.schoolConfigId
end

function BattleRoleClient:GetSchoolName()
  local school = self.roleDataModel.schoolConfigId
  local schoolCfg = bg.DT.SchoolConfig[school]
  do return LT.Text end
  return LT.Text, schoolCfg.Name
end

function BattleRoleClient:GetSchoolTips(schoolId)
  local schoolArgs = self.roleDataModel.schoolArgs[schoolId] or {}
  do return AwakerDataUtils.GetSchoolTips, schoolId, bg.isPVE end
  return AwakerDataUtils.GetSchoolTips, schoolId, bg.isPVE, schoolArgs
end

function BattleRoleClient:GetSchoolTipsIcon(schoolId)
  local schoolCfg = bg.DT.SchoolConfig[schoolId]
  return schoolCfg and schoolCfg.SchoolBattleTipIcon
end

function BattleRoleClient:GetSchoolEn(schoolId)
  local schoolCfg = bg.DT.SchoolConfig[schoolId]
  return schoolCfg and schoolCfg.NameEn
end

function BattleRoleClient:OnChangeState(data)
  local changeLayer = data.changedLayer or data.layer
  if data.newLayer and data.oldLayer then
    changeLayer = data.newLayer - data.oldLayer
  end
  if self:IsChangeBodySizeState(data.stateId) then
    self:RecreateRoleUINode()
    return
  end
  if self.floatTextUI and changeLayer > 0 then
    self.floatTextUI:OnStateChanged(data, changeLayer)
  end
end

function BattleRoleClient:IsChangeBodySizeState(stateId)
  if not stateId then
    return false
  end
  return stateId == DT.GetConstant("MonsterSizeMiniState") or stateId == DT.GetConstant("MonsterSizeMiddleState") or stateId == DT.GetConstant("MonsterSizeBigState") or stateId == DT.GetConstant("MonsterSizeHugeState")
end

function BattleRoleClient:OnMonsterHpNumChange(data)
  if data.uid ~= self.uid then
    return
  end
  self.roleDataModel:UpdateHpNum(data.hpNum)
end

function BattleRoleClient:ShowPvpVoice(pvpVoiceTid, duration)
  if self.statusUI then
    self.statusUI:ShowPvpVoice(pvpVoiceTid, duration)
  end
end

function BattleRoleClient:GetPlayingPvpVoiceTid()
  if self.statusUI then
    do return self.statusUI.GetPlayingPvpVoiceTid end
    return self.statusUI.GetPlayingPvpVoiceTid, self.statusUI
  end
end

function BattleRoleClient:HidePvpVoice()
  if self.statusUI then
    self.statusUI:HidePvpVoice()
  end
end

return BattleRoleClient
