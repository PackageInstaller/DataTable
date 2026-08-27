local bs_207701 = class("bs_207701", LuaSkillBase)
local base = LuaSkillBase
bs_207701.config = {
  buffId_Invisibility = 3004,
  skill_time = 19,
  start_time = 11,
  actionId = 1020,
  action_speed = 1,
  audioId = 207703
}

function bs_207701:ctor()
end

function bs_207701:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_207701_AfterHurt", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_207701:OnAfterBattleStart()
end

function bs_207701:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and 0 < hurt and isTriggerSet == true then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_Invisibility, 1, true)
  end
end

function bs_207701:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:StartTimer(self, self.config.start_time, function()
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId)
  end)
end

function bs_207701:OnAttackTrigger()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_Invisibility, 1, self.arglist[1], true)
end

function bs_207701:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_207701
