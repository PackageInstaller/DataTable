local bs_214002 = class("bs_214002", LuaSkillBase)
local base = LuaSkillBase
bs_214002.config = {
  time_ready = 15,
  time_end = 15,
  actionId_1 = 1020,
  action_speed = 1,
  buff_rage = 214001,
  buff_hurt = 214002
}

function bs_214002:ctor()
end

function bs_214002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_214002_2", 1, self.OnAfterHurt, {
    sender = self.caster
  })
end

function bs_214002:PlaySkill(data)
  local last_target = self.caster.recordTable.lastAttackRole
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  if last_target ~= nil then
    self.caster:LookAtTarget(last_target)
  end
  local skilltime = self.config.time_ready + self.config.time_end
  self:CallCasterWait(skilltime)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_1, self.config.action_speed, self.config.time_ready, attackTrigger)
end

function bs_214002:OnAttackTrigger(target)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_rage, 1, self.arglist[3])
end

function bs_214002:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if self.caster:GetBuffTier(self.config.buff_rage) > 0 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buff_hurt, 1, self.arglist[6])
  end
end

function bs_214002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_214002
