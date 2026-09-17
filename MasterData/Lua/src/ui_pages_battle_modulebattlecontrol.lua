local this = class("moduleBattleControl", G_UIModuleBase)
local _worldCityTpl = L_GameTpl:getWorldCityTpl()
local constAttackBtnStatus = {init = 1, boostDo = 2}
local constEvadeBtnStatus = {
  idle = 0,
  fill = 1,
  cd = 2
}
local enumJointStrikeSkillBtnStatus = {
  idle = 0,
  animPlaying = 1,
  releaseSkill = 2
}

function this.bind()
  return {
    img_ultimateSkill = "",
    fill_skillUltimate = 0,
    txt_skillCdUltimate = "0",
    fill_maskSkillUltimate = 0,
    go_skillUltimateCd = false,
    img_petBreakSkill = "",
    txt_skillCdPet = "0",
    fill_maskSkillPet = 0,
    go_skillPetCd = false,
    toggle_isPetPuzzle = false,
    go_pet = false,
    img_pet = "",
    fillAmount_longPress = 0,
    go_petDead = false,
    go_petBreak = false,
    go_disableCatch = true,
    fill_cdEvade = 0,
    fill_evade = 0,
    txt_evade = "",
    go_txtEvade = false,
    anim_break_playAnimation = "anim_battle_petlink_ready",
    go_DodgeSkillCanUseEft = false,
    go_PetSkillCanUseEft = false,
    fill_maskCatchPet = 0,
    moduleHeroESkill = {
      moduleName = "pages/battle/moduleBattleHeroSkillBtn"
    },
    moduleCountermeasuresSkill = {
      moduleName = "pages/battle/skillBtn/moduleBattleCountermeasuresSkillBtn"
    },
    goContent = true,
    collectionToolActive = false,
    collectionToolAdd = true,
    collectionToolSwitch = false,
    collectionContent = false,
    collectionEndurance = 0,
    collectionEnduranceTxt = 0,
    collectionToolIcon = "",
    collectionToolIconActive = false,
    moduleUIChargingSkill = {
      moduleName = "pages/battle/moduleUIChargingSkill"
    }
  }
end

function this.methods()
  return {
    onCLick_PetCatch = function(self)
      if not L_PetManager:judgeCanCatchPet() then
        return
      end
      L_PlayerManager:firePetCatch()
    end,
    onClick_jump = function(self)
      L_PlayerManager:fireJump()
    end,
    onClick_evade = function(self)
      L_PlayerManager:fireEvade()
    end,
    onDown_attack = function(self)
      L_PlayerManager:fireAttackDown()
    end,
    onUp_attack = function(self)
      L_PlayerManager:fireAttackUp()
    end,
    onClick_ultimateSkill = function(self)
      self:onClick_ultimateSkill()
    end,
    onClick_petSkill = function(self)
      L_PlayerManager:firePetSkill()
    end,
    onClick_petBreakSkill = function(self)
      if enumJointStrikeSkillBtnStatus.idle == self.data.jointStrikeSkillBtnStatus then
        self.data.jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.releaseSkill
        L_PlayerManager:firePetBreakSkill()
      end
    end,
    anim_break_end = function(self, stateName)
      if stateName == "anim_battle_petlink_cost_N" then
        self.data.jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.idle
        self.bind.go_petBreak = false
      end
    end,
    onClick_addCollectionTool = function(self)
    end,
    onClick_changeCollectionTool = function(self)
    end,
    onClick_switchCollectionTool = function(self)
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open(...)
  this.super.open(self, ...)
  self.petCatchNum = 0
  self.isCollecting = false
  self.data = {
    evadeStatus = constEvadeBtnStatus.idle,
    attackBtnState = constAttackBtnStatus.init,
    oldEvadeCount = 3,
    jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.idle
  }
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleBattleControl.update")
  L_PlayerManager:addListener(L_PlayerManager.event.petEntityLoadFinish, self.refreshSkillIcon, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshAttackStatus, self.onEvent_refreshAttackStatus, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.onCastSkill, self.onEvent_onCastSkill, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.jointStrikeSkill, self.onEvent_onJointStrikeSkill, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.petCatchNotice, self.onEvent_onPetNotice, self)
  
  function self._onEventTriggerCollectHandle(_, varList)
    self:onEvent_triggerCollect(varList:GetBool(0), varList:GetInt(1))
  end
  
  function self._onEventCollectStatusChangeHandle(_, varList)
    self:refreshCollectionStatus(varList:GetBool(0))
  end
  
  function self._onEventCollectTriggerBtnChangeHandle(_, varList)
    self:collectTriggerBtnChange(varList:GetBool(0), varList:GetInt(1))
  end
  
  function self._onEventRefreshCollectionToolHandle()
    self:refreshCollectionTool()
  end
  
  C_CollectionToolStoreEvent.instance:Listen(C_ECollectionToolStoreEvent.TriggerCollect, self._onEventTriggerCollectHandle)
  C_CollectionToolStoreEvent.instance:Listen(C_ECollectionToolStoreEvent.DataUpdate, self._onEventRefreshCollectionToolHandle)
  C_CollectionToolStoreEvent.instance:Listen(C_ECollectionToolStoreEvent.CollectStatusChange, self._onEventCollectStatusChangeHandle)
  C_CollectionToolStoreEvent.instance:Listen(C_ECollectionToolStoreEvent.CollectTriggerBtnChange, self._onEventCollectTriggerBtnChangeHandle)
  L_BattleDataManager:addListener(L_BattleDataManager.event.playerFightStateChange, self.onEvent_fightStateChange, self)
  L_ShortCutManager:addListener(L_ShortCutConst.event.LongPressPetSkill, self.onEvent_longPress, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshPlayerStatus, self.onEvent_refreshPlayerStatus, self)
  self._puzzleStateChangeEventHandler = handler(self, self.refreshSkillIcon)
  C_WorldEvent.instance:Listen(C_EWorldEvent.EHaveCanTriggerPuzzleStateChange, self._puzzleStateChangeEventHandler)
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshSkillIcon, self.switchSkill, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshPetSkill, self.switchSkill, self)
  self:refreshSkillIcon()
  self:initSystem()
  self:refreshPetCatchStatus()
  self.dodgeContentList = {}
  for i = 0, self.bindComponents.cdEnergyRoot.transform.childCount - 1 do
    local item = {}
    item.go = self.bindComponents.cdEnergyRoot.transform:GetChild(i).gameObject
    item.anim = item.go:GetComponent(typeof(C_Animation))
    table.insert(self.dodgeContentList, item)
  end
  self.collectionToolInteract = {}
  self.cdNum = C_EntityManager.MainPlayer.data.catchCoolDown
  
  function self.onEvent_CsEntityStateChange()
    self.bind.goContent = not AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
  end
  
  L_PlayerManager:addListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:addListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_MountManager:addListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange, self)
  self.bind.goContent = not C_PlayerHelper.GetPlayerIsRidingMount() and AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true) ~= nil
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.petCatch, L_Const.AnchorType.Bottom, self.bindComponents.rect_cellPetCatch, L_Vector3.new(0, 18))
end

function this:onPlayerOnMount()
  self.bind.goContent = false
end

function this:onPlayerOutMount()
  self.bind.goContent = true
  self:resetEffect()
end

function this:onEvent_fightStateChange()
  self:refreshSkillIcon()
end

function this:show()
  self:resetEffect()
  self:showModules()
  self:refreshSkillIcon()
end

function this:resetEffect()
  self:initSkillStatus()
  self:closeDOTween()
  self.data.attackBtnState = constAttackBtnStatus.init
  self.data.oldEvadeCount = 3
  self.data.jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.idle
  if self.data.evadeStatus == constEvadeBtnStatus.fill then
    self.data.evadeStatus = constEvadeBtnStatus.idle
  elseif self.data.evadeStatus == constEvadeBtnStatus.cd then
    self.data.evadeStatus = constEvadeBtnStatus.fill
    self.playAnim(self.bindComponents.dodgeAnim, "anim_battle_dodge_useout")
  else
    self.data.evadeStatus = constEvadeBtnStatus.idle
  end
end

function this:close(...)
  this.super.close(self, ...)
  self.collectionToolInteract = {}
  if self.petLinkTimer then
    Timer.remove(self.petLinkTimer)
    self.petLinkTimer = nil
  end
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  self:closeDOTween()
  self:closeLongPressTween()
  self:resetUltimateSkill()
  self:destroyAllLocker()
  C_CollectionToolStoreEvent.instance:Cancel(C_ECollectionToolStoreEvent.CollectTriggerBtnChange, self._onEventCollectTriggerBtnChangeHandle)
  C_CollectionToolStoreEvent.instance:Cancel(C_ECollectionToolStoreEvent.CollectStatusChange, self._onEventCollectStatusChangeHandle)
  C_CollectionToolStoreEvent.instance:Cancel(C_ECollectionToolStoreEvent.TriggerCollect, self._onEventTriggerCollectHandle)
  C_CollectionToolStoreEvent.instance:Cancel(C_ECollectionToolStoreEvent.DataUpdate, self._onEventRefreshCollectionToolHandle)
  self._onEventCollectTriggerBtnChangeHandle = nil
  self._onEventCollectStatusChangeHandle = nil
  self._onEventTriggerCollectHandle = nil
  self._onEventRefreshCollectionToolHandle = nil
  L_PlayerManager:removeListener(L_PlayerManager.event.petEntityLoadFinish, self.refreshSkillIcon, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshAttackStatus, self.onEvent_refreshAttackStatus, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.onCastSkill, self.onEvent_onCastSkill, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.jointStrikeSkill, self.onEvent_onJointStrikeSkill, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.petCatchNotice, self.onEvent_onPetNotice, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_MountManager:removeListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshPlayerStatus, self.onEvent_refreshPlayerStatus, self)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.EHaveCanTriggerPuzzleStateChange, self._puzzleStateChangeEventHandler)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.playerFightStateChange, self.onEvent_fightStateChange)
  L_ShortCutManager:removeListener(L_ShortCutConst.event.LongPressPetSkill, self.onEvent_longPress, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshSkillIcon, self.switchSkill, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshPetSkill, self.switchSkill, self)
  L_ShortCutManager:clearShortKeyFlag(self)
end

function this:onEvent_longPress(isPress)
  if isPress then
    self:playLongPressAni()
  else
    self:closeLongPressTween()
  end
end

function this:playLongPressAni()
  local function getter()
    return 0
  end
  
  local function setter(r)
    self.bind.fillAmount_longPress = r
  end
  
  self._longPressTween = DOTween.To(getter, setter, 1, 0.3)
  
  function self._longPressTween.onComplete()
    L_UI:open("pagePetDecryptRoulette")
    self.bind.fillAmount_longPress = 0
  end
  
  self._longPressTween:SetEase(Tweening.Ease.Linear)
end

function this:closeLongPressTween()
  if L_CommonUtil.isValid(self._longPressTween) then
    self._longPressTween:Kill()
    self._longPressTween = nil
  end
  self.bind.fillAmount_longPress = 0
end

function this:onEvent_onCastSkill(args)
  local skillId = args.intArg
  local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if mainHero == nil then
    return
  end
  local skill = mainHero.data.skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.EvadeBoostAttack)
  if skill and skill.id == skillId then
    self.playAnim(self.bindComponents.attackAnim, "anim_battle_attack_fightback_cost")
    self.data.attackBtnState = constAttackBtnStatus.boostDo
  end
end

function this:onEvent_onJointStrikeSkill(args)
  local skillId = args.skillId
  local succeed = args.succeed
  if not succeed and self.data.jointStrikeSkillBtnStatus ~= enumJointStrikeSkillBtnStatus.animPlaying then
    self.data.jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.idle
    return
  end
  local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if mainHero == nil then
    return
  end
  local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  if not petCsEntity then
    return
  end
  local jointStrikeSkill = petCsEntity.data.skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.JointStrikeSkill)
  if jointStrikeSkill and jointStrikeSkill.id == skillId then
    if self.petLinkTimer then
      Timer.remove(self.petLinkTimer)
      self.petLinkTimer = nil
    end
    self.bind.anim_break_playAnimation = "anim_battle_petlink_cost"
    self.data.jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.animPlaying
    self.petLinkTimer = Timer.once(2.1, function()
      self.data.jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.idle
      self.bind.go_petBreak = false
      self.petLinkTimer = nil
    end, self)
  end
end

function this:onEvent_onPetNotice(args)
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.catchPet) and args.noticeType == "noticeCatchMonsterCount" then
    if args.catchCount > 0 and args.catchCount > self.petCatchNum then
      local coolDown = C_EntityManager.MainPlayer.data.catchCoolDown
      if coolDown <= 0 then
        self.bindComponents.petCatchAnimation:SetTrigger("Ready")
      end
    end
    self.petCatchNum = args.catchCount
  end
end

function this:onEvent_refreshAttackStatus(args)
  if args.intArg == L_Const.C_ESkillSlotType.EvadeBoostAttack then
    self.playAnim(self.bindComponents.attackAnim, "anim_battle_attack_fightback_ready")
  elseif self.data.attackBtnState == constAttackBtnStatus.init then
    self.playAnim(self.bindComponents.attackAnim, "anim_battle_attack_fightback_fade")
  else
    self.data.attackBtnState = constAttackBtnStatus.init
  end
end

function this:setMainControl()
  self:refreshSkillIcon()
  self.bInit = false
end

function this:playAnim(anim, animName)
  if not anim.gameObject.activeSelf then
    return
  end
  anim:Play(animName, 1)
end

function this:canShowCollectionToolUi()
  local store = C_CollectionToolStore.GetStore()
  return store ~= nil and store:CanUseCollectionTool()
end

function this:onEvent_triggerCollect(isIn, toolType)
  self.btnTypeStatus = self.btnTypeStatus or {}
  local canShowCollect = isIn or self.isCollecting
  self.inRange = isIn
  self.bind.collectionToolActive = canShowCollect and self:canShowCollectionToolUi()
  if not self.isCollecting then
    self.toolType = toolType
  end
  if math.isEmpty(self.toolType) then
    return
  end
  if canShowCollect and self:canShowCollectionToolUi() then
    self:refreshCollectionTool()
  else
    self.bind.collectionToolAdd = false
    self.bind.collectionToolIconActive = false
    self.bind.collectionToolSwitch = false
  end
end

function this:refreshCollectionTool()
  if math.isEmpty(self.toolType) then
    return
  end
  local store = C_CollectionToolStore.GetStore()
  if not store:CanUseCollectionTool() then
    self.bind.collectionToolAdd = false
    self.bind.collectionToolSwitch = false
    self.bind.collectionToolIconActive = false
    return
  end
  local configId = store:GetBestToolConfigId(self.toolType)
  if math.isEmpty(configId) then
    self.bind.collectionToolAdd = true
    self.bind.collectionToolSwitch = false
    self.bind.collectionToolIconActive = false
    return
  end
  self.bind.collectionToolAdd = false
  self.bind.collectionToolSwitch = false
  self.bind.collectionToolIconActive = true
  local configTable = CS.Azur.Gameplay.Table.TDCollectionToolTable.GetData(configId)
  local conf = L_ItemTplManager:getItemConfig(L_Const.resType.collectionTool, configId)
  if conf == nil then
    self.bind.collectionToolAdd = false
    self.bind.collectionToolSwitch = false
    self.bind.collectionToolIconActive = false
    return
  end
  self.bind.collectionEndurance = 0
  self.bind.collectionEnduranceTxt = 0
  self.bind.collectionToolIcon = conf.icon
end

function this:collectTriggerBtnChange(isIn, toolType)
  self.btnTypeStatus = self.btnTypeStatus or {}
  self.btnTypeStatus[toolType] = self.btnTypeStatus[toolType] or {}
  if isIn then
    table.insert(self.btnTypeStatus[toolType], 1)
  elseif not table.isEmpty(self.btnTypeStatus[toolType]) then
    table.remove(self.btnTypeStatus[toolType], 1)
    if self.toolType == toolType and table.isEmpty(self.btnTypeStatus[toolType]) then
      self:onEvent_triggerCollect(isIn, toolType)
    end
  end
end

function this:refreshCollectionStatus(isBegin)
  self.isCollecting = isBegin
  if not self.inRange then
    self.bind.collectionToolActive = false
  end
  self.bind.collectionContent = isBegin
end

function this:refreshSkillIcon()
  local mainControlType = AzurWorld.playerMgr.myPlayerData.mainControlType
  self.bind.goContent = mainControlType == C_EPlayerMainControlType.Formation and AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex) ~= nil
  local heroCsEntity = AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  if not heroCsEntity then
    return
  end
  local skillUltimate = heroCsEntity.data.skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.UltraSkill)
  if skillUltimate and not math.isEmpty(skillUltimate.id) then
    local skillUltimateId = skillUltimate.id
    local tpl = L_GameTpl:getSkillTpl():getTplById(skillUltimateId)
    local icon = L_GameTpl:getSkillTpl():getIcon(tpl)
    self.bind.img_ultimateSkill = icon
    self.bind.img_ultimateSkill2 = icon
  end
  local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  if petCsEntity and petCsEntity.data then
    local skillBreak = petCsEntity.data.skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.JointStrikeSkill)
    if skillBreak then
      local skillBreakId = skillBreak.id
      local tpl = L_GameTpl:getSkillTpl():getTplById(skillBreakId)
      local icon = L_GameTpl:getSkillTpl():getBattleSkillIcon(tpl)
      self.bind.img_petBreakSkill = icon
    end
    local petUltraSkill = petCsEntity.data.skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.PetUltra)
    if petUltraSkill then
      local petUltraSkillId = petUltraSkill.id
      local tpl = L_GameTpl:getSkillTpl():getTplById(petUltraSkillId)
      local icon = L_GameTpl:getSkillTpl():getBattleSkillIcon(tpl)
      self.bind.go_pet = true
      self.bind.img_pet = icon
      self.bind.toggle_isPetPuzzle = C_PuzzleManager.HaveCanTriggerPuzzle()
      self:closeLongPressTween()
    else
      local bShow = self:checkGoPetSkillShow()
      self.bind.go_pet = bShow
      if bShow then
        self.bind.img_pet = "UI/Atlas/SkillIcon/tex_petpuzzle_icon_untie.png"
      else
        self:closeLongPressTween()
      end
    end
  else
    local bShow = self:checkGoPetSkillShow()
    self.bind.go_pet = bShow
    if bShow then
      self.bind.img_pet = "UI/Atlas/SkillIcon/tex_petpuzzle_icon_untie.png"
    else
      self:closeLongPressTween()
    end
  end
end

function this:checkGoPetSkillShow()
  local result = C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.petPuzzleRoulette)
  return result and not L_BattleDataManager:checkPlayerBattle()
end

function this:initSkillStatus()
  self.skillUltimate = false
end

function this:update()
  local mainHeroCsEntity = AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  if not mainHeroCsEntity then
    return
  end
  local heroData = mainHeroCsEntity.data
  local skillProperty = heroData.skillProperty
  local playerData = C_EntityManager.MainPlayer.data
  local coolDown = playerData.catchCoolDown
  local cd = playerData.catchCd
  if self.cdNum > 0.01 and coolDown == 0 then
    self.bindComponents.petCatchAnimation:SetTrigger("Ready")
  end
  self.cdNum = coolDown
  local fill_maskCatchPet = (cd - coolDown) / cd
  if 0.01 < math.abs(self.bind.fill_maskCatchPet - fill_maskCatchPet) then
    self.bind.fill_maskCatchPet = fill_maskCatchPet
  end
  local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  local petBreakActive = false
  if petCsEntity and petCsEntity.data then
    if petCsEntity.data.aliveState == C_EEntityAliveState.Reborn then
      if not self.bind.go_petDead then
        self.bind.go_petDead = true
      end
      if self.bind.go_skillPetCd then
        self.bind.go_skillPetCd = false
      end
      if self.bind.go_petBreak then
        self.bind.go_petBreak = false
      end
    else
      if self.bind.go_petDead then
        self.bind.go_petDead = false
      end
      local cdTime, totalTime = petCsEntity.entity:PetUltimateCdTime()
      if cdTime <= 0 or C_PuzzleManager.HaveCanTriggerPuzzle() then
        if self.bind.go_skillPetCd then
          self.bind.go_skillPetCd = false
          if self.bInit then
            self.bind.go_PetSkillCanUseEft = false
            self.bind.go_PetSkillCanUseEft = true
          end
        end
      else
        if not self.bind.go_skillPetCd then
          self.bind.go_skillPetCd = true
        end
        local timeStr = tostring(math.round(cdTime))
        if self.bind.txt_skillCdPet ~= timeStr then
          self.bind.txt_skillCdPet = timeStr
        end
        local value = cdTime / totalTime
        if math.abs(self.bind.fill_maskSkillPet - value) > 0.001 then
          self.bind.fill_maskSkillPet = value
        end
      end
      petBreakActive = petCsEntity.data.existPetBreakTarget and L_BattleDataManager:checkPlayerBattle()
    end
  end
  if not self.bind.go_petBreak and petBreakActive then
    self.bind.go_petBreak = petBreakActive
    self.bind.anim_break_playAnimation = "anim_battle_petlink_ready"
    if self.petLinkTimer then
      Timer.remove(self.petLinkTimer)
      self.petLinkTimer = nil
    end
  elseif self.bind.go_petBreak and not petBreakActive and self.data.jointStrikeSkillBtnStatus == enumJointStrikeSkillBtnStatus.idle then
    C_SkillUtility.PetBreakReadyFx()
    self.bind.anim_break_playAnimation = "anim_battle_petlink_cost_N"
    self.data.jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.animPlaying
    if self.petLinkTimer then
      Timer.remove(self.petLinkTimer)
      self.petLinkTimer = nil
    end
  end
  local skillUltimate = skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.UltraSkill)
  local showUltimateCd = false
  if skillUltimate then
    local spCost = skillUltimate.config.spCost
    local playerSp = heroData.aliveProperty.luaSp
    local value = playerSp / spCost
    if 0.001 < math.abs(self.bind.fill_skillUltimate - value) then
      self.bind.fill_skillUltimate = value
    end
    local coolDown = skillUltimate.coolDown
    local ready = coolDown:Ready()
    if ready then
      self:setSkillCdUltimate("")
      if spCost <= playerSp then
        showUltimateCd = false
        self:doEffect_skillUltimate(true)
      else
        showUltimateCd = true
        self:doEffect_skillUltimate(false)
      end
    else
      self:doEffect_skillUltimate(false)
      showUltimateCd = true
      local coolTime = C_MyFloatUtility.GetFloat(coolDown.coolTime)
      local coolDown = C_MyFloatUtility.GetFloat(coolDown.coolDown)
      self:setSkillCdUltimate(tostring(math.round(coolTime)))
      self.bind.fill_maskSkillUltimate = coolTime / coolDown
    end
  end
  if showUltimateCd ~= self.bind.go_skillUltimateCd then
    self.bind.go_skillUltimateCd = showUltimateCd
  end
  local evadeSkill = skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.Evade)
  if evadeSkill == nil then
    return
  end
  local evadeCoolDown = evadeSkill.coolDown
  local nowCdTime = C_TimeManager.globalTime - evadeCoolDown.lastCastTime
  local coolDownHintTime = evadeCoolDown.coolDownHintTime
  local coolTime = C_MyFloatUtility.GetFloat(evadeCoolDown.coolTime)
  local coolDown = C_MyFloatUtility.GetFloat(evadeCoolDown.coolDown)
  if coolTime <= 0 and nowCdTime >= coolDownHintTime then
    self:refreshEvadeStatus(constEvadeBtnStatus.idle)
    self.data.oldEvadeCount = 3
  else
    if self.data.oldEvadeCount > evadeCoolDown.currentChargeCount then
      self.playAnim(self.dodgeContentList[3 - evadeCoolDown.currentChargeCount].anim, "anim_battle_dodge_charge_use")
    end
    self.data.oldEvadeCount = evadeCoolDown.currentChargeCount
    if evadeCoolDown.currentChargeCount == 0 then
      self.bind.fill_evade = 0
      self:refreshEvadeStatus(constEvadeBtnStatus.cd, coolTime / coolDown, coolTime)
    elseif nowCdTime < coolDownHintTime then
      self:refreshEvadeStatus(constEvadeBtnStatus.fill, 1 - nowCdTime / coolDownHintTime, evadeCoolDown.currentChargeCount)
    end
  end
  self.bInit = true
end

function this:setSkillCdUltimate(cd)
  if self.bind.txt_skillCdUltimate ~= cd then
    self.bind.txt_skillCdUltimate = cd
  end
end

function this:refreshEvadeStatus(evadeStatus, fill, leftTime)
  if evadeStatus == constEvadeBtnStatus.idle then
    if self.data.evadeStatus == evadeStatus then
      return
    end
    self.bind.fill_evade = 0
    self.bind.fill_cdEvade = 0
    self.data.evadeStatus = constEvadeBtnStatus.idle
    self.bindComponents.dodgeAnim:SetBool("active", false)
    self.bindComponents.dodgeAnim:SetBool("cd", false)
    for i, v in ipairs(self.dodgeContentList) do
      v.go:ActiveTrans(true)
      self.playAnim(v.anim, "anim_battle_dodge_charge_init")
    end
    if self.bInit then
      self.bind.go_DodgeSkillCanUseEft = false
      self.bind.go_DodgeSkillCanUseEft = true
    end
    if self.bind.go_txtEvade then
      self.bind.go_txtEvade = false
    end
    return
  end
  if evadeStatus == constEvadeBtnStatus.fill then
    if self.data.evadeStatus == constEvadeBtnStatus.idle then
      self.bind.fill_evade = 1
      self.bind.fill_cdEvade = 0
      self.bindComponents.dodgeAnim:SetBool("active", true)
    end
    self.data.evadeStatus = evadeStatus
    if L_CommonUtil.isValid(self.tween) then
      self.tween:Kill()
      self.tween = nil
    end
    
    local function getter()
      return self.bind.fill_evade
    end
    
    local function setter(r)
      self.bind.fill_evade = r
    end
    
    self.tween = DOTween.To(getter, setter, fill, 0.1):SetEase(Tweening.Ease.Linear)
    if self.bind.go_txtEvade then
      self.bind.go_txtEvade = false
    end
    return
  end
  if evadeStatus == constEvadeBtnStatus.cd then
    if self.data.evadeStatus == constEvadeBtnStatus.fill then
      self.bind.fill_evade = 0
      self.bind.fill_cdEvade = 1
      self.bindComponents.dodgeAnim:SetBool("active", false)
      self.bindComponents.dodgeAnim:SetBool("cd", true)
    end
    self.data.evadeStatus = evadeStatus
    if L_CommonUtil.isValid(self.tween) then
      self.tween:Kill()
      self.tween = nil
    end
    
    local function getter()
      return self.bind.fill_cdEvade
    end
    
    local function setter(r)
      self.bind.fill_cdEvade = r
    end
    
    self.tween = DOTween.To(getter, setter, fill, 0.1):SetEase(Tweening.Ease.Linear)
    if not self.bind.go_txtEvade then
      self.bind.go_txtEvade = true
    end
    self.bind.txt_evade = tostring(math.round(leftTime))
  end
end

function this:closeDOTween()
  if self.tween then
    self.tween:Kill()
    self.tween = nil
  end
end

function this:doEffect_skillUltimate(flag)
  if self.skillUltimate == flag then
    return
  end
  self.skillUltimate = flag
  if self.skillUltimateTimer ~= nil then
    return
  end
  if flag then
    self.playAnim(self.bindComponents.ultimateSkillAnim, "anim_battle_ultSkill_ready")
  else
    self.playAnim(self.bindComponents.ultimateSkillAnim, "anim_battle_ultSkill_init")
  end
end

function this:onClick_ultimateSkill()
  if self.skillUltimate then
    self:resetUltimateSkill()
    self.playAnim(self.bindComponents.ultimateSkillAnim, "anim_battle_ultSkill_cost")
    self.ultimateCostTimer = Timer.once(1.12, function()
      if self.skillUltimate then
        self.playAnim(self.bindComponents.ultimateSkillAnim, "anim_battle_ultSkill_ready")
      else
        self.playAnim(self.bindComponents.ultimateSkillAnim, "anim_battle_ultSkill_init")
      end
    end, self)
    L_PlayerManager:fireUltimateSkill()
  end
end

function this:resetUltimateSkill()
  if self.ultimateCostTimer then
    Timer.remove(self.ultimateCostTimer)
    self.ultimateCostTimer = nil
  end
end

function this:onEvent_refreshPlayerStatus()
  self:refreshPetCatchStatus()
end

function this:refreshPetCatchStatus()
  local playerInMount = L_PlayerStore:playerInMountStatus()
  local sceneId = AzurWorldInstance.CurWorldId
  local tpl = _worldCityTpl:getTplById(sceneId)
  local isCatchPetDisable = _worldCityTpl:getIsSystemDisable(tpl, L_SystemConst.enum.catchPet)
  self.bind.go_disableCatch = isCatchPetDisable or playerInMount
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.ultimateSkill] = {
      self.bindComponents.ultimateSkill
    },
    [L_SystemConst.enum.catchPet] = {
      self.bindComponents.rect_cellPetCatch
    }
  }
  for systemId, v in pairs(self.systemToTrans) do
    v.locker = C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
    if v.locker then
      self:refreshSystem(systemId, false)
      v.locker:setCallback(self.refreshSystem, self, self.gameObject)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans[systemId]
  local locker = node.locker
  for _, v in ipairs(node) do
    locker:tryShowOrHide(v, isUnlock)
  end
end

function this:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
    end
  end
end

function this:hide()
  self.bind.go_DodgeSkillCanUseEft = false
  self.bind.go_PetSkillCanUseEft = false
  self:hideModules()
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

function this:switchSkill(arg)
  self:refreshSkillIcon()
end

return this
