local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_106700 = class("bs_106700", bs_1)
local base = bs_1
bs_106700.config = {
  effectId_1 = 106701,
  action1 = 1001,
  action2 = 1001,
  baseActionSpd = 1,
  skill_time = 28,
  start_time = 7,
  skill_time1 = 31,
  start_time1 = 10,
  buffId_tr = 106702,
  action_pass = 1004,
  effectId_pass1 = 106702,
  effectId_pass2 = 106704,
  HurtConfig = 29,
  HurtConfig2 = 30
}
bs_106700.config = setmetatable(bs_106700.config, {
  __index = base.config
})

function bs_106700:ctor()
end

function bs_106700:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.num = 0
end

function bs_106700:RealPlaySkill(target, data)
  self.num = self.num + 1
  if self.num >= self.caster.recordTable["106701_Roll"] then
    self.num = 0
    local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
    local atkSpeedRatio = 1
    local atkActionId = data.action_pass
    local atkTriggerFrame = 0
    atkSpeedRatio = self:CalcAtkActionSpeedForAirplane(atkSpeed, 2) * self.config.baseActionSpd
    atkActionId = data.action_pass
    atkTriggerFrame = self:GetAtkTriggerFrameForAirplane(2, atkSpeed)
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CallCasterWait(atkSpeed + 2)
    self.caster.recordTable.lastAttackRole = target
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.action_pass, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
  else
    local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
    local atkSpeedRatio = 1
    local atkActionId = data.action1
    local atkTriggerFrame = 0
    atkSpeedRatio = self:CalcAtkActionSpeedForAirplane2(atkSpeed, 2) * self.config.baseActionSpd
    atkActionId = data.action1
    atkTriggerFrame = self:GetAtkTriggerFrameForAirplane2(2, atkSpeed)
    local attackTrigger3 = BindCallback(self, self.OnAttackTrigger3, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CallCasterWait(atkSpeed + 2)
    self.caster.recordTable.lastAttackRole = target
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.action1, atkSpeedRatio, atkTriggerFrame, attackTrigger3)
  end
end

function bs_106700:CalcAtkActionSpeedForAirplane(atkInterval, atkId)
  local atkTotalFrames = self.config.skill_time
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_106700:CalcAtkActionSpeedForAirplane2(atkInterval, atkId)
  local atkTotalFrames = self.config.skill_time1
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_106700:GetAtkTriggerFrameForAirplane(atkId, atkInterval)
  local atkTotalFrames = self.config.skill_time
  local triggerFrameCfg = self.config.start_time
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_106700:GetAtkTriggerFrameForAirplane2(atkId, atkInterval)
  local atkTotalFrames = self.config.skill_time1
  local triggerFrameCfg = self.config.start_time1
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_106700:OnAttackTrigger2(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
    LuaSkillCtrl:CallEffect(target, self.config.effectId_pass1, self)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_pass2, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
      self.caster.recordTable["106701_break"]
    }, false, false)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig2, {
      self.caster.recordTable["106701_break"],
      self.caster.recordTable["106701_arg2"]
    }, false, false)
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId_tr, 1, 1)
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

function bs_106700:OnAttackTrigger3(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
    LuaSkillCtrl:CallEffect(target, self.config.effectId_1, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
      self.caster.recordTable["106701_break"]
    }, false, false)
    skillResult:EndResult()
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

function bs_106700:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_106700
