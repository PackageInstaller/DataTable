local bs_106100 = class("bs_106100", LuaSkillBase)
local base = LuaSkillBase
bs_106100.config = {
  effectId_action = 106101,
  actionId_start = 1031,
  actionId_loop = 1032,
  actionId_end = 1033,
  action_speed = 1,
  actionId_start_time = 6
}

function bs_106100:ctor()
end

function bs_106100:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.loopTime = 40
  self.caster.recordTable.NeedRestart = true
end

function bs_106100:PlaySkill(data)
  if self.caster.recordTable.NeedRestart == true then
    self.caster.recordTable.NeedRestart = false
    self.effect_loop = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_action, self, nil)
    local moveTarget = self:GetMoveSelectTarget()
    if moveTarget ~= nil then
      self.caster:LookAtTarget(moveTarget.targetRole)
    end
    local time = self.config.actionId_start_time + self.loopTime
    self:CallCasterWait(time)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, nil)
  else
    local time = self.loopTime
    self:CallCasterWait(time)
  end
end

function bs_106100:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
  self.caster.recordTable.NeedRestart = true
  if self.effect_loop ~= nil then
    self.effect_loop:Die()
    self.effect_loop = nil
  end
end

function bs_106100:OnCasterDie()
  if self.effect_loop ~= nil then
    self.effect_loop:Die()
    self.effect_loop = nil
  end
  base.OnCasterDie(self)
end

function bs_106100:LuaDispose()
  self.effect_loop = nil
  base.LuaDispose(self)
end

return bs_106100
