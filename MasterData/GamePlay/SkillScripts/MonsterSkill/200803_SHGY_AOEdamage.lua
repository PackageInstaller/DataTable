local bs_200803 = class("40000_AOEdamage", LuaSkillBase)
local base = LuaSkillBase
bs_200803.config = {
  attackdelay = 15,
  effectId1 = 10933,
  effectId2 = 10934,
  audioId1 = 54,
  hurtConfig = {
    basehurt_formula = 10012,
    hit_formula = 0,
    crit_formula = 0,
    correct_formula = 9989
  },
  skill_time = 30,
  skill_speed = 1,
  start_time = 5,
  startAnimId = 1002,
  select_id = 9,
  select_range = 10
}

function bs_200803:ctor()
end

function bs_200803:InitSkill(isMidwaySkill)
end

function bs_200803:PlaySkill(data)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, self.config.skill_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self, nil, nil, nil, true)
end

function bs_200803:OnAttackTrigger(data)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetList.Count <= 0 then
    return
  end
  for i = 0, targetList.Count - 1 do
    LuaSkillCtrl:CallEffectWithArg(targetList[i].targetRole, self.config.effectId2, self, false, false, self.SkillEventFunc)
  end
end

function bs_200803:SkillEventFunc(effect, eventId, target)
  if effect.dataId == self.config.effectId2 and eventId == eBattleEffectEvent.Trigger then
    local targetRole = target.targetRole
    if targetRole ~= nil and targetRole.hp > 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:PlayAuHit(self, targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig)
      skillResult:EndResult()
    end
  end
end

function bs_200803:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200803
