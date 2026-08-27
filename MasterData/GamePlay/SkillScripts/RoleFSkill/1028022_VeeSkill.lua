local bs_1028022 = class("bs_1028022", LuaSkillBase)
local base = LuaSkillBase
bs_1028022.config = {
  effectId_skill = 10707,
  buffId_228 = 102802,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  actionId = 1002,
  action_speed = 1,
  skill_time = 31,
  start_time = 11,
  audioId1 = 269
}

function bs_1028022:ctor()
end

function bs_1028022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_1028022:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral then
    target = last_target
  else
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 33, 10)
    if 0 < targetList.Count then
      target = targetList[0].targetRole
    end
  end
  if target ~= nil then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
    self.caster:LookAtTarget(target)
    self:CallCasterWait(self.config.skill_time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  end
end

function bs_1028022:OnAttackTrigger(target)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_skill, self, self.SkillEventFunc)
end

function bs_1028022:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, self.config.buffId_228, 1, self.arglist[1] + 1, false, false, self.OnBuffExecute)
  end
end

function bs_1028022:OnBuffExecute(buff, targetRole)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {
    self.arglist[3]
  })
  skillResult:EndResult()
end

function bs_1028022:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_1028022
