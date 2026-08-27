local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102400 = class("bs_102400", bs_1)
local base = bs_1
bs_102400.config = {
  effectId_trail = 10736,
  effectId_start3 = 10738,
  effectId_start4 = 10738,
  effectId_JQ = 10740,
  effectId_JQL = 10742,
  effectId_JQR = 10743,
  effectId_JQ_1 = 102414,
  effectId_JQL_1 = 102412,
  effectId_JQR_1 = 102413,
  effectId_JQhit = 10741,
  effectId_JQs = 102406,
  effectId_JQLs = 102407,
  buffId_236 = 236,
  HurtConfig = {basehurt_formula = 3010, hurt_type = 1},
  skill_time = 18,
  start_time = 8,
  actionId = 1008,
  action_speed = 1,
  baseActionSpd = 1,
  audioId1 = 241,
  audioId2 = 242,
  audioId5 = 243,
  audioId_Plane = 244,
  audioId_Hit = 245
}
bs_102400.config = setmetatable(bs_102400.config, {
  __index = base.config
})

function bs_102400:ctor()
end

function bs_102400:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_102400:RealPlaySkill(target, data)
  if self.caster:GetBuffTier(self.config.buffId_236) > 0 then
    local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
    local atkSpeedRatio = 1
    local atkActionId = data.action1
    local atkTriggerFrame = 0
    atkSpeedRatio = self:CalcAtkActionSpeedForAirplane(atkSpeed, 2) * self.config.baseActionSpd
    atkActionId = data.action2
    atkTriggerFrame = self:GetAtkTriggerFrameForAirplane(2, atkSpeed)
    local attackTrigger2 = BindCallback(self, self.OnAttackTrigger2, target, data, self.config.action_speed, self.config.actionId, self.config.start_time)
    self:CallCasterWait(self.config.skill_time)
    self.caster.recordTable.lastAttackRole = target
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, self.config.actionId, atkSpeedRatio, atkTriggerFrame, attackTrigger2)
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId_Plane)
  else
    base.RealPlaySkill(self, target, data)
  end
end

function bs_102400:CalcAtkActionSpeedForAirplane(atkInterval, atkId)
  local atkTotalFrames = self.config.skill_time
  if atkInterval < atkTotalFrames then
    return atkTotalFrames / atkInterval
  else
    return 1
  end
end

function bs_102400:GetAtkTriggerFrameForAirplane(atkId, atkInterval)
  local atkTotalFrames = self.config.skill_time
  local triggerFrameCfg = self.config.start_time
  if atkInterval < atkTotalFrames then
    return triggerFrameCfg * atkInterval // atkTotalFrames
  else
    return triggerFrameCfg
  end
end

function bs_102400:OnAttackTrigger2(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local extraTarget = self:CheckAndGetExtraEffectTarget(target)
  self:CallShoot(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if extraTarget ~= nil then
    self:CallShoot(extraTarget, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  end
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger2, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    self:CancleCasterWait()
  end
end

function bs_102400:CallShoot(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 302404 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_JQs, self, self.SkillEventFunc2)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_JQLs, self)
  elseif LuaSkillCtrl:GetCasterSkinId(self.caster) == 302405 then
    LuaSkillCtrl:CallEffect(target, self.config.effectId_JQ_1, self, self.SkillEventFunc2)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_JQL_1, self)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_JQR_1, self)
  else
    LuaSkillCtrl:CallEffect(target, self.config.effectId_JQ, self, self.SkillEventFunc2)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_JQL, self)
    LuaSkillCtrl:CallEffect(target, self.config.effectId_JQR, self)
  end
end

function bs_102400:SkillEventFunc2(effect, eventId, target)
  if eventId == eBattleEffectEvent.Create then
    local arg1 = self.caster.recordTable.skill_arg1
    LuaSkillCtrl:PlayAuSource(target, self.config.audioId_Hit)
    LuaSkillCtrl:CallEffect(target.targetRole, self.config.effectId_JQhit, self)
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:PlayAuHit(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult)
    skillResult:EndResult()
    local _Cskill = self.caster.recordTable.cskill
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffectWithCSkill(_Cskill, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {arg1})
    skillResult:EndResult()
  end
end

function bs_102400:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_102400
