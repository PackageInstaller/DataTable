local bs_1018022 = class("bs_1018022", LuaSkillBase)
local base = LuaSkillBase
bs_1018022.config = {
  buffId_nurse = 10180301,
  effectId_skill = 101807,
  skill_time = 34,
  start_time = 12,
  actionId = 1002,
  action_speed = 1,
  skill_select = 14,
  heal_config = {baseheal_formula = 3021}
}

function bs_1018022:ctor()
end

function bs_1018022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1018022:PlaySkill(data)
  local target = self:GetMoveSelectTarget()
  if target ~= nil then
    target = target.targetRole
  end
  if target ~= nil then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  end
end

function bs_1018022:OnAttackTrigger(target)
  if target.hp > 0 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self, self.SkillEventFunc)
  end
  if target.hp <= 0 then
    local target_new = LuaSkillCtrl:CallTargetSelect(self, self.config.skill_select, 0)
    if 0 < target_new.Count then
      LuaSkillCtrl:CallEffect(target_new[0].targetRole, self.config.effectId_skill, self, self.SkillEventFunc)
    end
  end
end

function bs_1018022:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId_skill and eventId == eBattleEffectEvent.Trigger then
    local num = (target.targetRole.maxHp - target.targetRole.hp) * 1000 // target.targetRole.maxHp // self.arglist[2] * self.arglist[3]
    local num2 = self.arglist[1] * (1000 + num) // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {num2})
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_nurse, self.arglist[5], nil)
  end
end

function bs_1018022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1018022
