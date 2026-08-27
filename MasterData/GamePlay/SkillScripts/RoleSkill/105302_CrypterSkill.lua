local bs_105302 = class("bs_105302", LuaSkillBase)
local base = LuaSkillBase
bs_105302.config = {
  buffId_speed = 105301,
  actionId = 1002,
  skill_speed = 1.5,
  start_time = 10,
  skill_time = 30,
  effectId_trail = 105312,
  HurtConfigID = 13
}

function bs_105302:ctor()
end

function bs_105302:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105302:PlaySkill(data)
  local target = self:SetSkillTarget()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data)
  if target ~= nil then
    self.caster:LookAtTarget(target)
  end
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.skill_speed, self.config.start_time, attackTrigger)
end

function bs_105302:SetSkillTarget()
  local last_target = self.caster.recordTable.lastAttackRole
  local target
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return
    end
    target = tempTarget.targetRole
  end
  return target
end

function bs_105302:OnAttackTrigger(target, data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_speed, 1, self.arglist[4] * self.caster.recordTable.energy_num)
  LuaSkillCtrl:CallEffect(target, self.config.effectId_trail, self, self.SkillEventFunc)
end

function bs_105302:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigID, {
      self.arglist[1] + self.caster.recordTable.energy_num * self.arglist[2]
    })
    skillResult:EndResult()
    self:OnSkillDamageEnd()
  end
end

function bs_105302:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105302
