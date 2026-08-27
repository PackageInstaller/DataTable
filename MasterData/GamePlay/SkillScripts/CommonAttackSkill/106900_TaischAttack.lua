local bs_106900 = class("bs_106900", LuaSkillBase)
local base = LuaSkillBase
bs_106900.config = {
  effectId = 106901,
  actionId = 1001,
  action_speed = 1,
  actionId_start_time = 10,
  action_skilltime = 10
}

function bs_106900:ctor()
end

function bs_106900:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_106900:PlaySkill(data)
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget ~= nil then
    self.caster:LookAtTarget(moveTarget.targetRole)
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.action_skilltime
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
end

function bs_106900:OnAttackTrigger(data)
  LuaSkillCtrl:CallAddPlayerHmp(self.caster.recordTable.add_mp)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, nil, nil, self.config.action_speed, true)
end

function bs_106900:OnBreakSkill(role)
  base.OnBreakSkill(self, role)
end

function bs_106900:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_106900:LuaDispose()
  base.LuaDispose(self)
end

return bs_106900
