local bs_1001022 = class("bs_1001022", LuaSkillBase)
local base = LuaSkillBase
bs_1001022.config = {
  effectId_trail = 100208,
  effectId_line = 100207,
  selectId_skill = 9,
  select_range = 10,
  skill_speed = 1,
  actionId = 1002,
  skill_time = 15,
  start_time = 9,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0,
    returndamage_formula = 0
  },
  hurt_config_extra = {
    hit_formula = 0,
    def_formula = 0,
    basehurt_formula = 100201,
    crit_formula = 0,
    returndamage_formula = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  }
}

function bs_1001022:ctor()
end

function bs_1001022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1001022:PlaySkill(data)
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget == nil then
    return
  end
  local target = moveTarget.targetRole
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data)
  self.caster:LookAtTarget(target)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.skill_speed, self.config.start_time, attackTrigger)
end

function bs_1001022:OnAttackTrigger(target, data)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_line, self)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc)
end

function bs_1001022:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    }, false, false)
    skillResult:EndResult()
    local transferList = LuaSkillCtrl:CallTargetSelect(self, self.config.selectId_skill, self.config.select_range)
    if transferList == 0 then
      return
    end
    for i = 0, transferList.Count - 1 do
      local role = transferList[i].targetRole
      if role ~= target.targetRole and role.intensity ~= 0 then
        LuaSkillCtrl:CallEffect(role, self.config.effectId_line, self, nil, target.targetRole)
        LuaSkillCtrl:CallEffect(role, self.config.effectId_trail, self, self.SkillEventFunc_extra, target.targetRole)
      end
    end
  end
end

function bs_1001022:SkillEventFunc_extra(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config_extra, nil, true)
    skillResult:EndResult()
  end
end

function bs_1001022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1001022
