local bs_101106 = class("bs_101106", LuaSkillBase)
local base = LuaSkillBase
bs_101106.config = {
  buffId_maxHpUp_maxHpUp_maxHpUp = 101108,
  effectId = 101113,
  effectId_line = 101115,
  effectId_Hit = 101106,
  buffId = 101102,
  buffId_damage = 101106,
  HurtConfig = 3,
  buffId_Hpcur = 101107
}

function bs_101106:ctor()
end

function bs_101106:InitSkill(isMidwaySkill)
  self.timeattack = 0
  self.time = 0
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_101101_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_101101_13", 1, self.OnAfterPlaySkill)
  self:OnCasterAttributeChange()
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_101101_attrObs", 1, self.OnCasterAttributeChange)
end

function bs_101106:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    self.timeattack = self.timeattack + 1
  end
  if role == self.caster and skill.isCommonAttack and self.timeattack == self.arglist[1] - 1 and self.time < self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_maxHpUp_maxHpUp_maxHpUp, 1, nil, true)
    local heal = self.caster.skill_intensity * (self.arglist[2] + 500) // 1000
    LuaSkillCtrl:CallHeal(heal, self, self.caster, true)
    self.time = self.time + 1
    self.timeattack = 0
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
  if role == self.caster and skill.isNormalSkill and self.time < self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_maxHpUp_maxHpUp_maxHpUp, self.arglist[7], nil, true)
    local heal = self.caster.skill_intensity * (self.arglist[2] + 500) // 1000 * self.arglist[7]
    LuaSkillCtrl:CallHeal(heal, self, self.caster, true)
    self.time = self.time + self.arglist[7]
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  if target == self.caster and skill.isCommonAttack and role.belongNum ~= self.caster.belongNum and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[9] then
    LuaSkillCtrl:CallEffect(role, self.config.effectId_line, self, nil, self.caster)
    LuaSkillCtrl:CallEffect(role, self.config.effectId_line, self, nil, self.caster)
    LuaSkillCtrl:CallEffect(role, self.config.effectId_line, self, nil, self.caster)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[10])
    LuaSkillCtrl:CallBuffRepeated(self, role, self.config.buffId_damage, 1, self.arglist[10], false, false, self.OnBuffExecute)
  end
end

function bs_101106:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
    self.arglist[11]
  }, true)
  skillResult:EndResult()
  LuaSkillCtrl:CallEffect(targetRole, self.config.effectId_Hit, self)
end

function bs_101106:OnCasterAttributeChange()
  if self.num == nil then
    self.num = 0
    self._change_def = 0
    self.maxHp = self.caster.maxHp
  end
  local change_hp = self.caster.maxHp - self.maxHp
  local change_def = change_hp * self.arglist[6] // self.arglist[5]
  if self._change_def ~= change_def then
    local num = change_def - self._change_def
    self.caster:AddRoleProperty(eHeroAttr.magic_res, num, eHeroAttrType.Extra)
    self.caster:AddRoleProperty(eHeroAttr.def, num, eHeroAttrType.Extra)
    self._change_def = change_def
  end
end

function bs_101106:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Hpcur, 1, nil, true)
end

function bs_101106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101106
