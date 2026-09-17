local this = class("moduleBattleHeroUltimateSkillBtn", G_UIModuleBase)

function this.bind()
  return {
    img_ultimateSkill = "",
    fill_skillUltimate = 0,
    txt_skillCdUltimate = "0",
    fill_maskSkillUltimate = 0,
    go_skillUltimateCd = false,
    go_tuning = false,
    go_tuningloop = false
  }
end

function this.methods()
  return {
    onDown_ultimateSkill = function(self)
      self:onClick_ultimateSkill()
    end,
    onUp_ultimateSkill = function(self)
    end
  }
end

function this:open()
  self:initSystem()
  L_BattleDataManager:addListener(L_BattleDataManager.event.refreshSkillIcon, self.switchSkill, self)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_PlayerManager:addListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  self.updateHandle = handler(self, self.update)
  C_UpdateSource.AddUpdateEventHandler(self.updateHandle, "moduleBattleControl.moduleBattleHeroUltimateSkillBtn.update")
  self:refreshSkillIcon()
end

function this:show()
  self:resetEffect()
end

function this:refreshSkillIcon()
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
  end
end

function this:update()
  local mainHeroCsEntity = AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex)
  if not mainHeroCsEntity then
    return
  end
  local heroData = mainHeroCsEntity.data
  local skillProperty = heroData.skillProperty
  local skillUltimate = skillProperty:GetSkillBySlot(L_Const.C_ESkillSlotType.UltraSkill)
  local showUltimateCd = false
  if skillUltimate then
    local spCost = skillUltimate.config.spCost
    local playerSp = heroData.aliveProperty.luaSp
    local value = playerSp / spCost
    if math.abs(self.bind.fill_skillUltimate - value) > 0.001 then
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
end

function this:setSkillCdUltimate(cd)
  if self.bind.txt_skillCdUltimate ~= cd then
    self.bind.txt_skillCdUltimate = cd
  end
end

function this:doEffect_skillUltimate(flag)
  if self.skillUltimate == flag then
    return
  end
  self.skillUltimate = flag
  if flag then
    self.bindComponents.ultimateSkillAnim:Play("anim_battle_ultSkill_ready", 1)
  else
    self.bindComponents.ultimateSkillAnim:Play("anim_battle_ultSkill_init", 1)
  end
end

function this:onClick_ultimateSkill()
  if self.skillUltimate then
    self:resetUltimateSkill()
    self.bindComponents.ultimateSkillAnim:Play("anim_battle_ultSkill_cost", 1)
    self.ultimateCostTimer = Timer.once(1.12, function()
      if self.skillUltimate then
        self.bindComponents.ultimateSkillAnim:Play("anim_battle_ultSkill_ready", 1)
      else
        self.bindComponents.ultimateSkillAnim:Play("anim_battle_ultSkill_init", 1)
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

function this:resetEffect()
  self.skillUltimate = false
end

function this:initSystem()
  self.systemToTrans = {
    [L_SystemConst.enum.ultimateSkill] = {
      self.bindComponents.ultimateSkill
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

function this:setMainControl()
  self:refreshSkillIcon()
end

function this:onPlayerOutMount()
  self:resetEffect()
end

function this:switchSkill()
  self:refreshSkillIcon()
end

function this:close()
  self:resetUltimateSkill()
  self:destroyAllLocker()
  C_UpdateSource.RemoveUpdateEventHandler(self.updateHandle)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_BattleDataManager:removeListener(L_BattleDataManager.event.refreshSkillIcon, self.switchSkill, self)
end

return this
