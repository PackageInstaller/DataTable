local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_105600 = class("bs_105600", bs_1)
local base = bs_1
bs_105600.config = {
  effectId_trail = 105608,
  action1 = 1001,
  action2 = 1001,
  effectId_action_1 = 105610,
  baseActionSpd = 1,
  skill_time = 39,
  start_time = 15,
  buffId_tr = 105602,
  effectId_passtrail = 105611,
  effectId_passqk = 105613,
  action_pass = 1004,
  HurtConfig = 15
}
bs_105600.config = setmetatable(bs_105600.config, {
  __index = base.config
})

function bs_105600:ctor()
end

function bs_105600:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_105600:RealPlaySkill(target, data)
  if LuaSkillCtrl:CallRange(1, 1000) <= self.caster.recordTable["105601_Roll"] then
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
    base.RealPlaySkill(self, target, data)
  end
end

function bs_105600:CalcAtkActionSpeedForAirplane(atkInterval, atkId)
  local atkTotalFrames = self.config.skill_time
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_105600:GetAtkTriggerFrameForAirplane(atkId, atkInterval)
  local atkTotalFrames = self.config.skill_time
  local triggerFrameCfg = self.config.start_time
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_105600:OnAttackTrigger2(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_passqk, self)
    LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_passtrail, self, nil, false, self.SkillEventFunc2, data)
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

function bs_105600:SkillEventFunc2(data, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
      self.caster.recordTable["105601_arg2"]
    }, false, false)
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.buffId_tr, 1, 1)
  end
end

function bs_105600:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105600
