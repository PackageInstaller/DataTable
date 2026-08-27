local bs_106802 = class("bs_106802", LuaSkillBase)
local base = LuaSkillBase
bs_106802.config = {
  actionId = 1002,
  actionId_start_time = 18,
  action_speed = 1,
  skill_time = 25,
  effectId_loop = 106805,
  effectId_screen = 2
}

function bs_106802:ctor()
end

function bs_106802:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.caster.recordTable.skill_mode = false
  self.caster.recordTable.skill_damage = self.arglist[2]
  self.caster.recordTable.skill_damage_add = self.arglist[3]
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_106802", 1, self.BeforeEndBattle)
end

function bs_106802:PlaySkill(data)
  local time = self.config.skill_time
  self:CallCasterWait(time)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self)
  self.caster.recordTable.curStartShowDurationSkill = self
end

function bs_106802:OnAttackTrigger(data)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, nil, true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  LuaSkillCtrl:ShowCameraEffectFunctionWithPriority(self.config.effectId_screen, 50)
  self.caster.recordTable.skill_mode = true
  LuaSkillCtrl:StartTimer(nil, self.arglist[1], function()
    self.caster.recordTable.skill_mode = false
    LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
    if self.effect ~= nil then
      self.effect:Die()
      self.effect = nil
    end
    LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
    LuaSkillCtrl:StopShowSkillDurationTime(self)
  end, self, nil)
end

function bs_106802:OnBreakSkill(role)
  if role ~= self.caster then
    return
  end
  self:RemoveAllTimers()
  self:RemoveAllBreakKillEffects()
  if self.isSkillUncompleted then
    self.caster:RemoveSkillWaitBuff()
    self.cskill:ReturnCDTimeFromBreak()
    self.isSkillUncompleted = false
  end
end

function bs_106802:BeforeEndBattle()
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
end

function bs_106802:LuaDispose()
  base.LuaDispose(self)
  LuaSkillCtrl:CloseCameraEffectFunctionWithoutId(self.config.effectId_screen)
  self.effect = nil
end

function bs_106802:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106802
