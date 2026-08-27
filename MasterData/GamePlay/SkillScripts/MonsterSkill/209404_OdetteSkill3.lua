local bs_209404 = class("bs_209404", LuaSkillBase)
local base = LuaSkillBase
bs_209404.config = {
  actionId_start = 1028,
  actionId_loop = 1029,
  actionId_end = 1030,
  actionId_end1 = 1054,
  action_speed = 1,
  actionId_start_time = 10,
  actionId_end_time = 62,
  actionId_end1_time = 58,
  effectId_loop = 209412,
  effectId_aoe = 209413,
  effectId_break = 209414,
  hurtResultId = 3,
  damageFormula = 10190
}

function bs_209404:ctor()
end

function bs_209404:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_209404:PlaySkill(data)
  self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_209404_1", 1, self.OnBreakShield)
  self:OnSkillTake()
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  local time = self.config.actionId_start_time + self.config.actionId_end_time + self.arglist[1]
  self:CallCasterWait(time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_start, self.config.action_speed, self.config.actionId_start_time, attackTrigger)
  LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time, function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_loop, self.config.action_speed)
  end, nil)
  LuaSkillCtrl:StartTimer(nil, self.config.actionId_start_time + self.arglist[1], function()
    LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId_end, self.config.action_speed)
    self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
  end, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, 170, 1, time, true)
  self:AbandonSkillCdAutoReset(true)
  local callnextskill = BindCallback(self, self.EndSkillAndCallNext)
  LuaSkillCtrl:StartTimer(self, time, callnextskill)
end

function bs_209404:OnAttackTrigger(data)
  local value = self.caster.maxHp * self.arglist[2] // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Beelneith, value)
  self.effectAtk = LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_loop, self, nil, nil, nil, true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, self.arglist[1])
  self.boom = LuaSkillCtrl:StartTimer(self, self.arglist[1], function()
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_aoe, self, nil, nil, nil, true)
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
    local SelfShieldValue = LuaSkillCtrl:GetShield(self.caster, 3)
    if SelfShieldValue ~= 0 then
      LuaSkillCtrl:ClearShield(self.caster, 3)
    end
    self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
    if self.effectAtk ~= nil then
      self.effectAtk:Die()
      self.effectAtk = nil
    end
  end)
end

function bs_209404:OnBreakShield(shieldType, sender, target)
  if target == self.caster and shieldType == 3 then
    if self.boom ~= nil then
      self.boom:Stop()
      self.boom = nil
    end
    if self.effectAtk ~= nil then
      self.effectAtk:Die()
      self.effectAtk = nil
    end
    local maxhpRate = self.arglist[4]
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_break, self, nil, nil, nil, true)
    local damage = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula, self.caster, self.caster, self, maxhpRate)
    LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true, true)
    local time = self.config.actionId_end1_time
    self:CancleCasterWait()
    self:CallCasterWait(time)
    self:RemoveSkillTrigger(eSkillTriggerType.OnBreakShield)
    local OnDropTrigger = BindCallback(self, self.OnDropTrigger)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId_end1, self.config.action_speed, self.config.actionId_end1_time, OnDropTrigger)
  end
end

function bs_209404:OnDropTrigger()
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:EndSkillAndCallNext()
end

function bs_209404:EndSkillAndCallNext()
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

function bs_209404:OnCasterDie()
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  base.OnCasterDie(self)
end

function bs_209404:LuaDispose()
  self.effectAtk = nil
  base.LuaDispose(self)
end

return bs_209404
