local bs_101907 = class("bs_101907", LuaSkillBase)
local base = LuaSkillBase
bs_101907.config = {
  effectId_start = 101907,
  effectId_trail = 101908,
  skill_speed = 1,
  actionId = 1002,
  skill_time = 26,
  start_time = 13,
  hurt_configId = 3
}

function bs_101907:ctor()
end

function bs_101907:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_101907:PlaySkill(data)
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget == nil then
    return
  end
  local target = moveTarget.targetRole
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data)
  self.caster:LookAtTarget(target)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.skill_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_start, self)
end

function bs_101907:OnAttackTrigger(target, data)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc)
end

function bs_101907:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_configId, {
      self.arglist[1]
    })
    skillResult:EndResult()
    LuaSkillCtrl:BroadcastLuaTrigger(eSkillLuaTrigger.FernDragonHurt, target, true)
  end
end

function bs_101907:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_101907
