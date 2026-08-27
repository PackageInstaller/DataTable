local bs_213303 = class("bs_213303", LuaSkillBase)
local base = LuaSkillBase
bs_213303.config = {
  skill_time = 25,
  buff_rage = 213302,
  actionId = 1002,
  action_speed = 1,
  start_time = 10
}

function bs_213303:ctor()
end

function bs_213303:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_213303:PlaySkill(data)
  self:OnSkillTake()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, self.config.skill_time, true)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  self:AbandonSkillCdAutoReset(true)
end

function bs_213303:OnAttackTrigger(data)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buff_rage, 1, self.arglist[1])
  self:EndSkillAndCallNext()
end

function bs_213303:EndSkillAndCallNext()
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self:CallNextBossSkill()
end

function bs_213303:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_213303
