local bs_202402 = class("bs_202402", LuaSkillBase)
local base = LuaSkillBase
bs_202402.config = {
  effectId1 = 10438,
  effectId2 = 10439,
  hurtConfig = {
    basehurt_formula = 10055,
    hit_formula = 10201,
    crit_formula = 0,
    correct_formula = 9989
  },
  select_id = 9,
  select_range = 0,
  startAnimId = 1002,
  start_time = 13,
  skill_time = 20,
  audioId1 = 313
}

function bs_202402:ctor()
end

function bs_202402:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_202402:PlaySkill(data)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetlist.Count > 0 then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId1, self)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.startAnimId, 1, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_202402:OnAttackTrigger(data)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  if targetlist.Count > 0 then
    local number = self.arglist[1] // targetlist.Count
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallEffect(targetlist[i].targetRole, self.config.effectId2, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[i].targetRole)
      LuaSkillCtrl:PlayAuHit(self, targetlist[i].targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurtConfig, {number})
      skillResult:EndResult()
    end
  end
end

function bs_202402:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_202402
