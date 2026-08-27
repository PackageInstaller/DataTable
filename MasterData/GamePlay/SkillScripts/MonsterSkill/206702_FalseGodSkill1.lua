local bs_206702 = class("bs_206702", LuaSkillBase)
local base = LuaSkillBase
bs_206702.config = {
  actionId_start = 1002,
  start_time = 5,
  skill_time = 20,
  effectId_start = 2067021,
  buffId_critical = 2067021
}

function bs_206702:ctor()
end

function bs_206702:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_206702:PlaySkill()
  self:AbandonSkillCdAutoReset(true)
  self:CallCasterWait(self.config.skill_time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  LuaSkillCtrl:PlayAuSource(self.caster, 459)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, 1, self.config.start_time, attackTrigger)
  LuaSkillCtrl:StartTimer(nil, self.config.skill_time, function()
    self:EndSkillAndCallNext()
  end)
end

function bs_206702:EndSkillAndCallNext()
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

function bs_206702:OnAttackTrigger()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_critical, 1, self.arglist[1])
end

function bs_206702:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_206702:LuaDispose()
  base.LuaDispose(self)
end

return bs_206702
