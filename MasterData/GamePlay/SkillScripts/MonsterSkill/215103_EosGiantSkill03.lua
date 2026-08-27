local bs_215103 = class("bs_215103", LuaSkillBase)
local base = LuaSkillBase
bs_215103.config = {
  actionId_start = 1061,
  actionId_loop = 1028,
  actionId_end = 1062,
  actionId_start1 = 1065,
  actionId_loop2 = 1063,
  actionId_end2 = 1064,
  action_speed = 1,
  actionId_start_time = 12,
  actionId_end_time = 55,
  actionId_end1_time = 15,
  effectId_break = 215110,
  effectId_hit = 215108,
  effectId_atk = 215109,
  configId = 3,
  buffID_1 = 215101,
  buffID_2 = 215102
}

function bs_215103:ctor()
end

function bs_215103:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.loopTime = self.arglist[1]
  self.AtkNum = 0
  self.AtkBreakNum = self.arglist[4]
end

function bs_215103:PlaySkill(data)
  self:RemoveSkillTrigger(eSkillTriggerType.AfterPlaySkill)
  self.AtkNum = 0
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_215103", 1, self.OnAfterPlaySkill)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.loopTime
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  self.ender = LuaSkillCtrl:StartTimer(nil, time, function()
    self:EndSkillAndCallNext()
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, nil, true)
end

function bs_215103:OnAfterPlaySkill(skill, role)
  local target = role.recordTable.lastAttackRole
  if target == nil then
    return
  end
  if target == self.caster and skill.isCommonAttack and role.belongNum ~= self.caster.belongNum then
    LuaSkillCtrl:StartTimer(nil, 8, function()
      self.AtkNum = self.AtkNum + 1
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_hit, self, nil, nil, nil)
      if self.AtkNum == self.AtkBreakNum then
        LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_break, self, nil, nil, nil)
        self:OnBraekTime()
      end
    end, nil)
  end
end

function bs_215103:OnAttackTrigger(data)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_1, 1, self.loopTime, true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.loopTime)
  self.boom = LuaSkillCtrl:StartTimer(nil, self.loopTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, 1.8)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_atk, self, nil, nil, nil, true)
    local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
    if targetList.Count > 0 then
      for i = targetList.Count - 1, 0, -1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
        LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtResultId, {
          self.arglist[3]
        })
        skillResult:EndResult()
      end
    end
    self:RemoveSkillTrigger(eSkillTriggerType.AfterPlaySkill)
  end)
end

function bs_215103:OnBraekTime()
  local breakTime = self.arglist[5]
  self:RemoveSkillTrigger(eSkillTriggerType.AfterPlaySkill)
  if self.boom ~= nil then
    self.boom:Stop()
    self.boom = nil
  end
  if self.ender ~= nil then
    self.ender:Stop()
    self.ender = nil
  end
  self:CancleCasterWait()
  self:CallCasterWait(breakTime)
  LuaSkillCtrl:DispelBuff(self.caster, self.config.buffID_1, 0)
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_start1, self.config.action_speed)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffID_2, 1, breakTime)
  LuaSkillCtrl:StartTimer(nil, 10, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop2, self.config.action_speed)
  end)
  LuaSkillCtrl:StartShowSkillDurationTime(self, breakTime)
  LuaSkillCtrl:StartTimer(nil, breakTime, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end2, self.config.action_speed)
    self:EndSkillAndCallNext()
  end)
end

function bs_215103:EndSkillAndCallNext()
  LuaSkillCtrl:DispelBuff(self.caster, 170, 0)
  if self.caster == nil then
    return
  end
  self:CancleCasterWait()
  local skillMgr = self.caster:GetSkillComponent()
  if skillMgr == nil then
    return
  end
  skillMgr.lastSkill = self.cskill
  self.caster:CallUnFreezeNextSkill()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

function bs_215103:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_215103
