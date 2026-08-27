local bs_301301 = class("bs_301301", LuaSkillBase)
local base = LuaSkillBase
bs_301301.config = {
  effectId = 10911,
  rootEffectId = 10113,
  startAnimId = 1002,
  buffID_1158 = 1158,
  HurtConfig = {
    basehurt_formula = 10087,
    hit_formula = 10201,
    crit_formula = 0
  },
  select_id = 5,
  select_range = 10,
  skill_time = 15,
  skill_speed = 1,
  start_time = 8
}

function bs_301301:ctor()
end

function bs_301301:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_301301", 1, self.BeforeEndBattle)
end

function bs_301301:CallBack()
  if self.damTimer ~= nil and self.damTimer:IsOver() then
    self.damTimer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, self.config.select_id, self.config.select_range)
  for i = 0, targetlist.Count - 1 do
    if targetlist[i].targetRole.belongNum ~= 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetlist[i].targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig)
      skillResult:EndResult()
    end
  end
end

function bs_301301:PlaySkill(data)
  local waitTime = self.config.skill_time + self.arglist[3]
  self:CallCasterWait(waitTime)
  if self.effect == nil then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.startAnimId, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_1158, 1)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[3])
  if self.damTimer == nil then
    self.damTimer = LuaSkillCtrl:StartTimer(self, self.arglist[2], self.CallBack, self, -1, self.arglist[2])
  end
  LuaSkillCtrl:StartTimer(nil, self.arglist[3], self.CallBack1, self, 0, 0)
end

function bs_301301:CallBack1()
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
end

function bs_301301:BeforeEndBattle()
end

function bs_301301:OnCasterDie()
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  base.OnCasterDie(self)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
end

function bs_301301:OnBreakSkill(role)
  if self.effect ~= nil then
    self.effect:Die()
    self.effect = nil
  end
  if self.damTimer then
    self.damTimer:Stop()
    self.damTimer = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1158, 0)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_301301:LuaDispose()
  base.LuaDispose(self)
  self.effect = nil
end

return bs_301301
