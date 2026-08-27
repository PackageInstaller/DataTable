local bs_209205 = class("bs_209205", LuaSkillBase)
local base = LuaSkillBase
bs_209205.config = {
  skill_time = 54,
  actionId = 1105,
  action_speed = 1,
  start_time = 15,
  buffId_speed = 209203,
  effectId = 209212
}

function bs_209205:ctor()
end

function bs_209205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_209205:PlaySkill()
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, self.config.skill_time)
  self:AbandonSkillCdAutoReset(true)
end

function bs_209205:OnAttackTrigger()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetList.Count > 0 then
    for i = 0, targetList.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetList[i].targetRole, self.config.buffId_speed, 1, self.arglist[3])
    end
  end
  self:EndSkillAndCallNext()
end

function bs_209205:EndSkillAndCallNext()
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
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_209205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_209205
