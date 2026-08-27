local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_305800 = class("bs_305800", bs_1)
local base = bs_1
bs_305800.config = {
  effectId_trail = 305807,
  effectId_action_1 = 305809,
  action1 = 1001,
  action2 = 1001,
  action_pass1 = 1021,
  action_pass2 = 1004,
  baseActionSpd = 1,
  skill_time2 = 26,
  start_time2 = 8,
  skill_time = 38,
  start_time = 10,
  buffId_tr = 105602,
  effectId_passtrail = 305804,
  effectId_passqk = 305806,
  effectId_passqk2 = 305828,
  effectId_passtrail2 = 305821,
  effectId_passtrail3 = 305823,
  effectId_passAoe = 105803,
  HurtConfig1 = 17,
  HurtConfig2 = 17,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  }
}
bs_305800.config = setmetatable(bs_305800.config, {
  __index = base.config
})

function bs_305800:ctor()
end

function bs_305800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_305800:RealPlaySkill(target, data)
  if LuaSkillCtrl:CallRange(1, 1000) <= self.caster.recordTable["305801_Roll"] then
    local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, 59, 1, target)
    if targetList ~= nil and targetList.Count >= 2 then
      local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
      local atkSpeedRatio = 1
      local atkActionId = data.action_pass1
      local atkTriggerFrame = 0
      atkSpeedRatio = self:CalcAtkActionSpeedForAirplane(atkSpeed, 2) * self.config.baseActionSpd
      atkActionId = data.action_pass1
      atkTriggerFrame = self:GetAtkTriggerFrameForAirplane(2, atkSpeed)
      local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      self:CallCasterWait(atkSpeed + 2)
      self.caster.recordTable.lastAttackRole = target
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.action_pass1, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
    else
      local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
      local atkSpeedRatio = 1
      local atkActionId = data.action_pass2
      local atkTriggerFrame = 0
      atkSpeedRatio = self:CalcAtkActionSpeedForAirplane2(atkSpeed, 2) * self.config.baseActionSpd
      atkActionId = data.action_pass2
      atkTriggerFrame = self:GetAtkTriggerFrameForAirplane2(2, atkSpeed)
      local attackTrigger3 = BindCallback(self, self.OnAttackTrigger3, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
      self:CallCasterWait(atkSpeed + 2)
      self.caster.recordTable.lastAttackRole = target
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.action_pass2, atkSpeedRatio, atkTriggerFrame, attackTrigger3)
    end
  else
    base.RealPlaySkill(self, target, data)
  end
end

function bs_305800:CalcAtkActionSpeedForAirplane(atkInterval, atkId)
  local atkTotalFrames = self.config.skill_time
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_305800:GetAtkTriggerFrameForAirplane(atkId, atkInterval)
  local atkTotalFrames = self.config.skill_time
  local triggerFrameCfg = self.config.start_time
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_305800:CalcAtkActionSpeedForAirplane2(atkInterval, atkId)
  local atkTotalFrames = self.config.skill_time2
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_305800:GetAtkTriggerFrameForAirplane2(atkId, atkInterval)
  local atkTotalFrames = self.config.skill_time2
  local triggerFrameCfg = self.config.start_time2
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_305800:OnAttackTrigger2(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_passqk2, self)
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_passAoe, self, nil, false, self.SkillEventFunc2, data)
  else
    self:BreakSkill()
  end
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    self:CancleCasterWait()
  end
end

function bs_305800:SkillEventFunc2(data, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig1, {
      self.caster.recordTable["305801_arg2"]
    })
    skillResult:EndResult()
  end
end

function bs_305800:OnAttackTrigger3(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_passqk, self)
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_passtrail2, self, nil, false, self.SkillEventFunc3, data)
    LuaSkillCtrl:StartTimer(self, 3, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_passqk, self)
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_passtrail, self, nil, false, self.SkillEventFunc3, data)
    end)
    LuaSkillCtrl:StartTimer(self, 5, function()
      LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_passqk, self)
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_passtrail3, self, nil, false, self.SkillEventFunc3, data)
    end)
  else
    self:BreakSkill()
  end
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger3, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    self:CancleCasterWait()
  end
end

function bs_305800:SkillEventFunc3(data, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger and (effect.dataId == self.config.effectId_passtrail or effect.dataId == self.config.effectId_passtrail2 or effect.dataId == self.config.effectId_passtrail3) then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig2, {
      self.caster.recordTable["305801_arg3"]
    }, false, false)
    skillResult:EndResult()
  end
end

function bs_305800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_305800
