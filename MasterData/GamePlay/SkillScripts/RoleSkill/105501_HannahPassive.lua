local bs_105501 = class("bs_105402", LuaSkillBase)
local base = LuaSkillBase
bs_105501.config = {
  fireSuppressNeedCount = 3,
  buffId_focus = 105501,
  buffId_attackSpeed = 105502,
  effectId = 105515,
  effectId_trail = 105514,
  configId = 3,
  weaponLv = 0
}

function bs_105501:ctor()
end

function bs_105501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_105501_01", 1, self.OnAfterPlaySkill)
  self:AddOnRoleDieTrigger("bs_105501_02", 1, self.OnRoleDie)
  self.targetTable = {}
  self.caster.recordTable.FireSuppressTarget = nil
  self.maxCount = 0
end

function bs_105501:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack then
    local target = role.recordTable.lastAttackRole
    if target ~= nil and target.belongNum ~= self.caster.belongNum and skill.maker.belongNum == self.caster.belongNum then
      self:OnTargetChange(skill.maker, target)
      if self.caster.recordTable.FireSuppressTarget == target and skill.maker ~= self.caster then
        LuaSkillCtrl:CallEffectWithArgOverride(target, self.config.effectId_trail, self, self.caster, nil, nil, self.SkillEventFunc)
      end
    end
  end
end

function bs_105501:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_trail and eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
      self.arglist[1]
    }, nil, nil)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, nil, nil, nil, true)
  end
end

function bs_105501:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum then
    self:OnTargetChange(role, nil)
  elseif role == self.caster.recordTable.FireSuppressTarget then
    self:OnFireSuppressTarget()
  end
end

function bs_105501:OnTargetChange(role, targetRole)
  local lastTargetRole = self.targetTable[role]
  local lastTargetUid
  if lastTargetRole ~= nil then
    lastTargetUid = lastTargetRole.uid
  end
  local nextTargetUid
  if targetRole ~= nil then
    nextTargetUid = targetRole.uid
  end
  if lastTargetUid == nextTargetUid then
    return
  end
  local fireRole = self.caster.recordTable.FireSuppressTarget
  if fireRole ~= nil and fireRole.isDead ~= true then
    local fireUid = fireRole.uid
    local isAdd
    if fireUid == lastTargetUid then
      self.maxCount = self.maxCount - 1
      isAdd = false
    end
    if fireUid == nextTargetUid then
      self.maxCount = self.maxCount + 1
      isAdd = true
    end
    if self.maxCount >= self.config.fireSuppressNeedCount then
      if isAdd == true then
        LuaSkillCtrl:CallBuff(self, role, self.config.buffId_attackSpeed, 1)
      elseif isAdd == false then
        LuaSkillCtrl:DispelBuff(role, self.config.buffId_attackSpeed, 1)
      end
      self.targetTable[role] = targetRole
      return
    else
      self:OnFireSuppressTarget()
    end
  end
  self.targetTable[role] = targetRole
  if targetRole == nil then
    return
  end
  local maxCount = 0
  for k, v in pairs(self.targetTable) do
    if v == targetRole then
      maxCount = maxCount + 1
    end
  end
  if maxCount >= self.config.fireSuppressNeedCount then
    LuaSkillCtrl:CallBuff(self, targetRole, self.config.buffId_focus, 1)
    for k, v in pairs(self.targetTable) do
      if v == targetRole then
        LuaSkillCtrl:CallBuff(self, k, self.config.buffId_attackSpeed, 1)
      end
    end
    self.caster.recordTable.FireSuppressTarget = targetRole
    self.maxCount = maxCount
  end
end

function bs_105501:OnFireSuppressTarget()
  local fireRole = self.caster.recordTable.FireSuppressTarget
  LuaSkillCtrl:DispelBuff(fireRole, self.config.buffId_focus, 1)
  self.caster.recordTable.FireSuppressTarget = nil
  self.maxCount = 0
  for k, v in pairs(self.targetTable) do
    if v == fireRole then
      LuaSkillCtrl:DispelBuff(k, self.config.buffId_attackSpeed, 1)
    end
  end
end

function bs_105501:OnCasterDie()
  self:OnFireSuppressTarget()
  base.OnCasterDie(self)
end

function bs_105501:LuaDispose()
  base.LuaDispose(self)
  self.targetTable = nil
end

return bs_105501
