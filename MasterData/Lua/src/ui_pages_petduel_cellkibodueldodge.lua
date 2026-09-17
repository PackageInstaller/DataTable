local this = class("cellKiBoDuelDodge", G_UIModuleBase)
local timeManager = C_TimeManager
local floatUtility = C_MyFloatUtility
local constEvadeBtnStatus = {
  idle = 0,
  fill = 1,
  cd = 2
}

function this.bind()
  return {
    fill_cdEvade = 0,
    fill_evade = 0,
    txt_evade = ""
  }
end

function this.methods()
  return {}
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "cellKiBoDuelDodge.update")
  self.data = {
    evadeStatus = constEvadeBtnStatus.idle,
    oldEvadeCount = 3
  }
  self.dodgeContentList = {}
  for i = 0, self.bindComponents.cdEnergyRoot.transform.childCount - 1 do
    local item = {}
    item.go = self.bindComponents.cdEnergyRoot.transform:GetChild(i).gameObject
    item.anim = item.go:GetComponent(typeof(C_Animation))
    table.insert(self.dodgeContentList, item)
  end
end

function this:show()
  self:resetEffect()
end

function this:resetEffect()
  self.data.evadeStatus = constEvadeBtnStatus.idle
  self.data.oldEvadeCount = 3
end

function this:close()
  self.coolDown = nil
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  if self.tween then
    self.tween:Kill()
  end
end

function this:update()
  if self.hero == nil then
    self.hero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
    if not self.hero then
      return
    end
  end
  if self.evadeSkill == nil then
    local skillProperty = self.hero.data.skillProperty
    self.evadeSkill = skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.Evade)
    if not self.evadeSkill then
      return
    end
    self.evadeCoolDown = self.evadeSkill.coolDown
    if not self.evadeSkill then
      return
    end
  end
  local evadeCoolDown = self.evadeCoolDown
  local nowCdTime = timeManager.globalTime - evadeCoolDown.lastCastTime
  local coolDownHintTime = evadeCoolDown.coolDownHintTime
  local coolTime = floatUtility.GetFloat(evadeCoolDown.coolTime)
  if not self.coolDown then
    self.coolDown = floatUtility.GetFloat(evadeCoolDown.coolDown)
  end
  local coolDown = self.coolDown
  local currentChargeCount = evadeCoolDown.currentChargeCount
  if self.lastCoolTime == coolTime and self.lastNowCdTime == nowCdTime and self.lastCurrentChargeCount == currentChargeCount then
    return
  end
  if coolTime <= 0 and nowCdTime >= coolDownHintTime then
    self:refreshEvadeStatus(constEvadeBtnStatus.idle)
    self.data.oldEvadeCount = 3
  else
    if currentChargeCount < self.data.oldEvadeCount then
      self.dodgeContentList[3 - currentChargeCount].anim:Play("anim_battle_dodge_charge_use")
    end
    self.data.oldEvadeCount = currentChargeCount
    if currentChargeCount == 0 then
      self.bind.fill_evade = 0
      self:refreshEvadeStatus(constEvadeBtnStatus.cd, coolTime / coolDown)
    elseif nowCdTime < coolDownHintTime then
      self:refreshEvadeStatus(constEvadeBtnStatus.fill, 1 - nowCdTime / coolDownHintTime, currentChargeCount)
    end
  end
  self.lastCoolTime = coolTime
  self.lastNowCdTime = nowCdTime
  self.lastCurrentChargeCount = currentChargeCount
end

function this:refreshEvadeStatus(evadeStatus, fill, count)
  if evadeStatus == constEvadeBtnStatus.idle then
    if evadeStatus == self.data.evadeStatus then
    else
      self.bind.fill_evade = 0
      self.bind.fill_cdEvade = 0
      self.data.evadeStatus = constEvadeBtnStatus.idle
      self.bindComponents.dodgeAnim:SetBool("active", false)
      self.bindComponents.dodgeAnim:SetBool("cd", false)
      for i, v in ipairs(self.dodgeContentList) do
        v.go:ActiveTrans(true)
        v.anim:Play("anim_battle_dodge_charge_init")
      end
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
    self.bind.fill_evade = fill
  elseif evadeStatus == constEvadeBtnStatus.cd then
    if self.data.evadeStatus == constEvadeBtnStatus.fill then
      self.bind.fill_evade = 0
      self.bind.fill_cdEvade = 1
      self.bindComponents.dodgeAnim:SetBool("active", false)
      self.bindComponents.dodgeAnim:SetBool("cd", true)
    end
    self.data.evadeStatus = evadeStatus
    self.bind.fill_cdEvade = fill
  end
end

return this
