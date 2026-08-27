local bs_203001 = class("bs_203001", LuaSkillBase)
local base = LuaSkillBase
bs_203001.config = {
  buffId_209 = 209,
  effectId = 10577,
  HurtConfig = {
    basehurt_formula = 10078,
    minhurt_formula = 9994,
    hit_formula = 0,
    crit_formula = 0,
    correct_formula = 9989
  },
  HealConfig = {baseheal_formula = 501},
  start_time = 10,
  end_time = 12,
  startAnimId = 1008,
  buffId_170 = 170
}

function bs_203001:ctor()
end

function bs_203001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_202901_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_203001:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(self.config.start_time + self.arglist[4] + self.config.end_time)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_170, 1, self.config.start_time + self.arglist[4], true)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, 1, self.config.start_time, attackTrigger)
end

function bs_203001:OnAttackTrigger(data)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[4])
  LuaSkillCtrl:CallBuffRepeated(self, self.caster, self.config.buffId_209, 1, self.arglist[4], false, false, self.OnBuffExecute)
end

function bs_203001:OnBuffExecute(buff, targetRole)
  local heal = self.caster.maxHp * self.arglist[2] // 1000
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, self.config.HealConfig, {heal}, true)
  skillResult:EndResult()
end

function bs_203001:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and target:GetBuffTier(self.config.buffId_209) > 0 and isTriggerSet ~= true and skill.isCommonAttack == true then
    LuaSkillCtrl:CallEffect(sender, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_203001:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
    skillResult:EndResult()
  end
end

function bs_203001:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_209, 0)
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
    self:CancleCasterWait()
  end
end

function bs_203001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_203001
