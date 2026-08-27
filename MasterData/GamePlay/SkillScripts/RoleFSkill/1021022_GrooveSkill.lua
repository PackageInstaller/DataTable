local bs_1021022 = class("bs_1021022", LuaSkillBase)
local base = LuaSkillBase
bs_1021022.config = {
  effectId_start = 10272,
  effectId_loop = 10271,
  buffId_dodge = 167,
  buffId_attackfast = 166,
  buffId_lockCd = 170,
  audioId1 = 76,
  skill_time = 999,
  start_time = 5,
  actionId_start = 1008,
  actionId_loop = 1007,
  actionId_end = 1009,
  action_speed = 1
}

function bs_1021022:ctor()
end

function bs_1021022:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1021022_3", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, eBattleRoleType.character)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1021022_1", 1, self.BeforeEndBattle)
end

function bs_1021022:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss and target.roleType == 1 and target:GetBuffTier(self.config.buffId_dodge) > 0 then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_attackfast, 1, self.arglist[5], true)
  end
end

function bs_1021022:PlaySkill(data)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(self.config.skill_time)
  self.audioloop = LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_lockCd, 1, self.config.start_time + self.arglist[4], true)
end

function bs_1021022:OnAttackTrigger()
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[4])
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_start, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallBuff(self, targetlist[i].targetRole, self.config.buffId_dodge, 1, self.arglist[4])
    end
  end
  LuaSkillCtrl:StartTimer(self, self.arglist[4], function()
    self:CancleCasterWait()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_lockCd, 0, true)
    if self.audioloop ~= nil then
      LuaSkillCtrl:StopAudioByBack(self.audioloop)
    end
  end)
end

function bs_1021022:OnBreakSkill(role)
  if role == self.caster then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    local targetOver = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetOver.Count > 0 then
      for i = 0, targetOver.Count - 1 do
        LuaSkillCtrl:DispelBuff(targetOver[i].targetRole, self.config.buffId_dodge, 1, true)
      end
    end
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId_lockCd, 0, true)
    self:CancleCasterWait()
  end
  base.OnBreakSkill(self, role)
end

function bs_1021022:BeforeEndBattle()
  if self.audioloop ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audioloop)
    self.audioloop = nil
  end
end

function bs_1021022:OnCasterDie()
  base.OnCasterDie(self)
  local targetOver = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetOver.Count > 0 then
    for i = 0, targetOver.Count - 1 do
      LuaSkillCtrl:DispelBuff(targetOver[i].targetRole, self.config.buffId_dodge, 1, true)
    end
  end
  if self.audioloop ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audioloop)
    self.audioloop = nil
  end
end

function bs_1021022:LuaDispose()
  base.LuaDispose(self)
  self.audioloop = nil
end

return bs_1021022
