local this = class("moduleBattlePetSkill", G_UIModuleBase)
local enumJointStrikeSkillBtnStatus = {
  idle = 0,
  animPlaying = 1,
  releaseSkill = 2
}

function this.bind()
  return {
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
    anim_break_playAnimation = "anim_battle_petlink_ready",
    go_PetSkillCanUseEft = false,
    fill_skillUltimate = 0
  }
end

function this.methods()
  return {
    onDown_petSkill = function(self)
      L_PlayerManager:firePetSkill()
    end,
    onUp_petSkill = function(self)
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
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open(...)
  this.super.open(self, ...)
  self.data = {
    jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.idle
  }
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleBattleControl.moduleBattlePetSkill.update")
  L_PlayerManager:addListener(L_PlayerManager.event.petEntityLoadFinish, self.refreshSkillIcon, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.jointStrikeSkill, self.onEvent_onJointStrikeSkill, self)
  L_BattleDataManager:addListener(L_BattleDataManager.event.playerFightStateChange, self.onEvent_fightStateChange, self)
  L_ShortCutManager:addListener(L_ShortCutConst.event.LongPressPetSkill, self.onEvent_longPress, self)
  self._puzzleStateChangeEventHandler = handler(self, self.refreshSkillIcon)
  C_WorldEvent.instance:Listen(C_EWorldEvent.EHaveCanTriggerPuzzleStateChange, self._puzzleStateChangeEventHandler)
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshPetSkill, self.switchSkill, self)
  self:refreshSkillIcon()
end

function this:show()
  self:resetEffect()
  self:refreshSkillIcon()
end

function this:update()
  local mainHeroCsEntity = AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  if not mainHeroCsEntity then
    return
  end
  local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
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
  self.bInit = true
end

function this:resetEffect()
  self.data.jointStrikeSkillBtnStatus = enumJointStrikeSkillBtnStatus.idle
end

function this:onEvent_fightStateChange()
  self:refreshSkillIcon()
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

function this:setMainControl()
  self:refreshSkillIcon()
  self.bInit = false
end

function this:refreshSkillIcon()
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
      return
    end
  end
  local bShow = self:checkGoPetSkillShow()
  self.bind.go_pet = bShow
  if bShow then
    if self.bind.go_skillPetCd then
      self.bind.go_skillPetCd = false
    end
    self.bind.toggle_isPetPuzzle = true
  else
    self:closeLongPressTween()
  end
end

function this:switchSkill()
  self:refreshSkillIcon()
end

function this:checkGoPetSkillShow()
  local result = C_IntegrateMgr.SystemUnlockModule:Check(L_SystemConst.enum.petPuzzleRoulette)
  return result and not L_BattleDataManager:checkPlayerBattle()
end

function this:hide()
  self.bind.go_PetSkillCanUseEft = false
end

function this:close(...)
  this.super.close(self, ...)
  if self.petLinkTimer then
    Timer.remove(self.petLinkTimer)
    self.petLinkTimer = nil
  end
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  self:closeLongPressTween()
  L_PlayerManager:removeListener(L_PlayerManager.event.petEntityLoadFinish, self.refreshSkillIcon, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.jointStrikeSkill, self.onEvent_onJointStrikeSkill, self)
  C_WorldEvent.instance:Cancel(C_EWorldEvent.EHaveCanTriggerPuzzleStateChange, self._puzzleStateChangeEventHandler)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.playerFightStateChange, self.onEvent_fightStateChange)
  L_ShortCutManager:removeListener(L_ShortCutConst.event.LongPressPetSkill, self.onEvent_longPress, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshPetSkill, self.switchSkill, self)
end

return this
