local this = class("moduleBattleCountermeasuresSkillBtn", G_UIModuleBase)
local constCountermeasuresStatus = {
  idle = 0,
  fill = 1,
  cd = 2
}

function this.bind()
  return {
    fill_cdCountermeasures = 0,
    fill_Countermeasures = 0,
    txt_cdTime = "",
    go_cdTime = false,
    img_EvadeSkillIcon1 = "",
    img_EvadeSkillIcon2 = "",
    go_skillCanUseEft = false,
    go_charge = false,
    img_slot = ""
  }
end

function this.methods()
  return {
    onDown_Countermeasures = function(self)
      L_PlayerManager:fireCountermeasuresSkill()
    end,
    onUp_Countermeasures = function(self)
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleBattleControl.moduleBattleCountermeasuresSkillBtn.update")
  self.data = {
    countermeasuresCount = 3,
    countermeasuresState = constCountermeasuresStatus.idle
  }
  self.dodgeContentList = {}
  for i = 0, self.bindComponents.cdEnergyRoot.transform.childCount - 1 do
    local item = {}
    item.go = self.bindComponents.cdEnergyRoot.transform:GetChild(i).gameObject
    item.anim = item.go:GetComponent(typeof(C_Animation))
    table.insert(self.dodgeContentList, item)
  end
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  self:refreshSkillIcon()
end

function this:show(options)
  if self.data.countermeasuresState == constCountermeasuresStatus.fill then
    self.data.countermeasuresState = constCountermeasuresStatus.idle
  elseif self.data.countermeasuresState == constCountermeasuresStatus.cd then
    self.data.countermeasuresState = constCountermeasuresStatus.fill
    self.bindComponents.dodgeAnim:Play("anim_battle_dodge_useout", 1)
  else
    self.data.countermeasuresState = constCountermeasuresStatus.idle
  end
end

function this:update()
  self:updateCountermeasuresSkill()
end

function this:setMainControl()
  self:refreshSkillIcon()
  self.bInit = false
end

function this:refreshSkillIcon()
  local hero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if not hero then
    return
  end
  local skillProperty = hero.data.skillProperty
  local evadeSkill = skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.Countermeasures)
  if not evadeSkill then
    return
  end
  local skillId = evadeSkill.id
  local tpl = L_GameTpl:getSkillTpl():getTplById(skillId)
  local icon = L_GameTpl:getSkillTpl():getIcon(tpl)
  self.bind.img_EvadeSkillIcon1 = icon
  self.bind.img_EvadeSkillIcon2 = icon
end

function this:close()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
end

function this:updateCountermeasuresSkill()
  local hero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if not hero then
    return
  end
  local skillProperty = hero.data.skillProperty
  local evadeSkill = skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.Countermeasures)
  if not evadeSkill then
    return
  end
  local evadeCoolDown = evadeSkill.coolDown
  local nowCdTime = C_TimeManager.globalTime - evadeCoolDown.lastCastTime
  local coolDownHintTime = evadeCoolDown.coolDownHintTime
  local coolTime = C_MyFloatUtility.GetFloat(evadeCoolDown.coolTime)
  local coolDown = C_MyFloatUtility.GetFloat(evadeCoolDown.coolDown)
  if coolTime <= 0 and nowCdTime >= coolDownHintTime then
    self:refreshCountermeasuresStatus(constCountermeasuresStatus.idle)
    self.data.countermeasuresCount = 3
  else
    if self.data.countermeasuresCount > evadeCoolDown.currentChargeCount then
      self.dodgeContentList[3 - evadeCoolDown.currentChargeCount].anim:Play("anim_battle_dodge_charge_use")
    end
    self.data.countermeasuresCount = evadeCoolDown.currentChargeCount
    if evadeCoolDown.currentChargeCount == 0 then
      self.bind.fill_Countermeasures = 0
      self:refreshCountermeasuresStatus(constCountermeasuresStatus.cd, coolTime / coolDown, coolTime)
    elseif nowCdTime < coolDownHintTime then
      self:refreshCountermeasuresStatus(constCountermeasuresStatus.fill, 1 - nowCdTime / coolDownHintTime)
    end
  end
  self.bInit = true
end

function this:refreshCountermeasuresStatus(countermeasuresState, fill, leftTime)
  if countermeasuresState == constCountermeasuresStatus.idle then
    if countermeasuresState == self.data.countermeasuresState then
      return
    end
    self.bind.fill_Countermeasures = 0
    self.bind.fill_cdCountermeasures = 0
    self.data.countermeasuresState = countermeasuresState
    self.bindComponents.dodgeAnim:SetBool("active", false)
    self.bindComponents.dodgeAnim:SetBool("cd", false)
    for i, v in ipairs(self.dodgeContentList) do
      v.go:ActiveTrans(true)
      v.anim:Play("anim_battle_dodge_charge_init")
    end
    if self.bInit then
      self.bind.go_skillCanUseEft = false
      self.bind.go_skillCanUseEft = true
    end
    if self.bind.go_cdTime then
      self.bind.go_cdTime = false
    end
    return
  end
  if countermeasuresState == constCountermeasuresStatus.fill then
    if self.data.countermeasuresState == constCountermeasuresStatus.idle then
      self.bind.fill_Countermeasures = 1
      self.bind.fill_cdCountermeasures = 0
      self.bindComponents.dodgeAnim:SetBool("active", true)
    end
    self.data.countermeasuresState = countermeasuresState
    if L_CommonUtil.isValid(self.tween) then
      self.tween:Kill()
      self.tween = nil
    end
    
    local function getter()
      return self.bind.fill_Countermeasures
    end
    
    local function setter(r)
      self.bind.fill_Countermeasures = r
    end
    
    self.tween = DOTween.To(getter, setter, fill, 0.1):SetEase(Tweening.Ease.Linear)
    if self.bind.go_cdTime then
      self.bind.go_cdTime = false
    end
    return
  end
  if countermeasuresState == constCountermeasuresStatus.cd then
    if self.data.countermeasuresState == constCountermeasuresStatus.fill then
      self.bind.fill_Countermeasures = 0
      self.bind.fill_cdCountermeasures = 1
      self.bindComponents.dodgeAnim:SetBool("active", false)
      self.bindComponents.dodgeAnim:SetBool("cd", true)
    end
    self.data.countermeasuresState = countermeasuresState
    if L_CommonUtil.isValid(self.tween) then
      self.tween:Kill()
      self.tween = nil
    end
    
    local function getter()
      return self.bind.fill_cdCountermeasures
    end
    
    local function setter(r)
      self.bind.fill_cdCountermeasures = r
    end
    
    self.tween = DOTween.To(getter, setter, fill, 0.1):SetEase(Tweening.Ease.Linear)
    if not self.bind.go_cdTime then
      self.bind.go_cdTime = true
    end
    self.bind.txt_cdTime = tostring(math.round(leftTime))
    return
  end
end

function this:hide(options)
  self.bind.go_skillCanUseEft = false
end

return this
