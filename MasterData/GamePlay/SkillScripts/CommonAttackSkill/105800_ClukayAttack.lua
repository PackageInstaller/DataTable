local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105800 = class("bs_105800", bs_1)
local base = bs_1
bs_105800.config = {
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
  effectId_passAoe = 105803,
  HurtConfig1 = 17,
  HurtConfig2 = 17,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  SkinId_Idle = 305804,
  SkinId_Swim = 305805,
  commom_config = {
    effectId_trail = 105807,
    effectId_action_1 = 105809,
    effectId_passtrail = 105804,
    effectId_passqk = 105806,
    effectId_passqk2 = 105828,
    effectId_passtrail2 = 105821,
    effectId_passtrail3 = 105823
  },
  idle_config = {
    effectId_trail = 30580704,
    effectId_action_1 = 30580904,
    effectId_passtrail = 30580404,
    effectId_passqk = 30580604,
    effectId_passqk2 = 30582804,
    effectId_passtrail2 = 30582104,
    effectId_passtrail3 = 30582304
  },
  swim_config = {
    effectId_trail = 30580705,
    effectId_action_1 = 30580905,
    effectId_passtrail = 30580405,
    effectId_passqk = 30580605,
    effectId_passqk2 = 30582805,
    effectId_passtrail2 = 30582105,
    effectId_passtrail3 = 30582305
  }
}
bs_105800.config = setmetatable(bs_105800.config, {
  __index = base.config
})

function bs_105800:ctor()
end

function bs_105800:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.effect = {}
  local SkinId = LuaSkillCtrl:GetCasterSkinId(self.caster)
  if SkinId == self.config.SkinId_Swim then
    self.effect = self.config.swim_config
  elseif SkinId == self.config.SkinId_Idle then
    self.effect = self.config.idle_config
  else
    self.effect = self.config.commom_config
  end
end

function bs_105800:RealPlaySkill(target, data)
  if LuaSkillCtrl:CallRange(1, 1000) <= self.caster.recordTable["105801_Roll"] then
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

function bs_105800:ExecuteEffectAttack(data, atkActionId, target, effectId1, effectId2)
  if self.effect.effectId_trail ~= nil then
    if data.audioId4 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
    end
    if self.effect.effectId_trail_ex ~= nil then
      if atkActionId == data.action1 then
        effectId1 = effectId1 or data.self.effect.effectId_trail
        LuaSkillCtrl:CallEffectWithArg(target, effectId1, self, nil, false, self.SkillEventFunc, data)
      else
        effectId2 = effectId2 or data.self.effect.effectId_trail_ex
        LuaSkillCtrl:CallEffectWithArg(target, effectId2, self, nil, false, self.SkillEventFunc, data)
      end
    else
      effectId1 = effectId1 or self.effect.effectId_trail
      LuaSkillCtrl:CallEffectWithArg(target, effectId1, self, nil, false, self.SkillEventFunc, data)
    end
  elseif data.effectId_hit_target ~= nil then
    LuaSkillCtrl:CallEffectWithArg(target, data.effectId_hit_target, self, nil, false, self.SkillEventFunc, data)
  end
end

function bs_105800:CalcAtkActionSpeedForAirplane(atkInterval, atkId)
  local atkTotalFrames = self.config.skill_time
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_105800:GetAtkTriggerFrameForAirplane(atkId, atkInterval)
  local atkTotalFrames = self.config.skill_time
  local triggerFrameCfg = self.config.start_time
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_105800:CalcAtkActionSpeedForAirplane2(atkInterval, atkId)
  local atkTotalFrames = self.config.skill_time2
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_105800:GetAtkTriggerFrameForAirplane2(atkId, atkInterval)
  local atkTotalFrames = self.config.skill_time2
  local triggerFrameCfg = self.config.start_time2
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_105800:OnAttackTrigger2(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
    LuaSkillCtrl:CallEffect(self.caster, self.effect.effectId_passqk2, self)
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

function bs_105800:SkillEventFunc2(data, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig1, {
      self.caster.recordTable["105801_arg2"]
    })
    skillResult:EndResult()
  end
end

function bs_105800:OnAttackTrigger3(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
    LuaSkillCtrl:CallEffect(self.caster, self.effect.effectId_passqk, self)
    LuaSkillCtrl:CallEffectWithArg(target, self.effect.effectId_passtrail2, self, nil, false, self.SkillEventFunc3, data)
    LuaSkillCtrl:StartTimer(self, 3, function()
      LuaSkillCtrl:CallEffect(self.caster, self.effect.effectId_passqk, self)
      LuaSkillCtrl:CallEffectWithArg(target, self.effect.effectId_passtrail, self, nil, false, self.SkillEventFunc3, data)
    end)
    LuaSkillCtrl:StartTimer(self, 5, function()
      LuaSkillCtrl:CallEffect(self.caster, self.effect.effectId_passqk, self)
      LuaSkillCtrl:CallEffectWithArg(target, self.effect.effectId_passtrail3, self, nil, false, self.SkillEventFunc3, data)
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

function bs_105800:SkillEventFunc3(data, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig2, {
      self.caster.recordTable["105801_arg3"]
    }, false, false)
    skillResult:EndResult()
  end
end

function bs_105800:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105800
