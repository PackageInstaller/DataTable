local this = class("moduleBattleDodgeSkillBtn", G_UIModuleBase)
local constEvadeBtnStatus = {
  idle = 0,
  fill = 1,
  cd = 2
}

function this.bind()
  return {
    fill_cdEvade = 0,
    fill_evade = 0,
    txt_evade = "",
    go_txtEvade = false,
    go_DodgeSkillCanUseEft = false,
    go_charge = false,
    img_slot = ""
  }
end

function this.methods()
  return {
    onDown_evade = function(self)
      L_PlayerManager:fireEvade()
    end,
    onUp_evade = function(self)
    end
  }
end

function this:open()
  self.data = {
    evadeStatus = constEvadeBtnStatus.idle,
    oldEvadeCount = 3
  }
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleBattleControl.moduleBattleDodgeSkillBtn.update")
  self.dodgeContentList = {}
  for i = 0, self.bindComponents.cdEnergyRoot.transform.childCount - 1 do
    local item = {}
    item.go = self.bindComponents.cdEnergyRoot.transform:GetChild(i).gameObject
    item.anim = item.go:GetComponent(typeof(C_Animation))
    table.insert(self.dodgeContentList, item)
  end
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
end

function this:show(options)
  self:resetEffect()
end

function this:resetEffect()
  self:closeDOTween()
  self.data.oldEvadeCount = 3
  if self.data.evadeStatus == constEvadeBtnStatus.fill then
    self.data.evadeStatus = constEvadeBtnStatus.idle
  elseif self.data.evadeStatus == constEvadeBtnStatus.cd then
    self.data.evadeStatus = constEvadeBtnStatus.fill
    self.bindComponents.dodgeAnim:Play("anim_battle_dodge_useout", 1)
  else
    self.data.evadeStatus = constEvadeBtnStatus.idle
  end
end

function this:update()
  local mainHeroCsEntity = AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  if not mainHeroCsEntity then
    return
  end
  local heroData = mainHeroCsEntity.data
  local skillProperty = heroData.skillProperty
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
      self.dodgeContentList[3 - evadeCoolDown.currentChargeCount].anim:Play("anim_battle_dodge_charge_use")
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
      v.anim:Play("anim_battle_dodge_charge_init")
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

function this:setMainControl()
  self.bInit = false
end

function this:closeDOTween()
  if self.tween then
    self.tween:Kill()
    self.tween = nil
  end
end

function this:close()
  self:closeDOTween()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
end

function this:hide(options)
  self.bind.go_DodgeSkillCanUseEft = false
end

return this
