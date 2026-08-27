local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100200 = class("bs_100200", bs_1)
local base = bs_1
bs_100200.config = {
  effectId_11 = 100201,
  effectId_action_1 = 100203,
  effectId_22 = 100202,
  effectId_action_2 = 100204,
  effectId_action_11 = 10020302,
  effectId_action_22 = 10020402,
  effectId_111 = 10020102,
  effectId_222 = 10020102,
  effectId_33 = 100223,
  effectId_44 = 100224
}
bs_100200.config = setmetatable(bs_100200.config, {
  __index = base.config
})

function bs_100200:ctor()
end

function bs_100200:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_100200:RealPlaySkill(target, data)
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  if 1 < self.attackNum then
    local prob = LuaSkillCtrl:CallRange(1, 2)
    if prob == 1 then
      if data.audioId2 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time2, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId2)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 2) * self.config.baseActionSpd
      atkActionId = data.action2
      atkTriggerFrame = self:GetAtkTriggerFrame(2, atkSpeed)
      self.attackNum = 0
    else
      if data.audioId1 ~= nil then
        LuaSkillCtrl:StartTimer(self, data.time1, function()
          LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
        end)
      end
      atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1)
      atkActionId = data.action1
      atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed) * self.config.baseActionSpd
      self.attackNum = self.attackNum + 1
    end
  else
    if data.audioId1 ~= nil then
      LuaSkillCtrl:StartTimer(self, data.time1, function()
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId1)
      end)
    end
    atkSpeedRatio = self:CalcAtkActionSpeed(atkSpeed, 1) * self.config.baseActionSpd
    atkTriggerFrame = self:GetAtkTriggerFrame(1, atkSpeed)
    atkActionId = data.action1
    self.attackNum = self.attackNum + 1
  end
  self.caster.recordTable.lastAttackRole = target
  if LuaSkillCtrl.IsInTDBattle and self.caster.belongNum == 2 then
    self.caster.recordTable.lastAttackRole = nil
  end
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  local waitTime = atkSpeed - 1 - (self.rotateWaited and 3 or 0)
  if 0 < waitTime then
    self:CallCasterWait(waitTime + 2)
  end
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger)
  if self.caster.attackRange == 1 then
    if data.effectId_1 ~= nil then
      if atkActionId == data.action1 then
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_1, self, nil, nil, atkSpeedRatio, true)
      else
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(target, data.effectId_2, self, nil, nil, atkSpeedRatio, true)
      end
    end
    if data.effectId_3 ~= nil then
      LuaSkillCtrl:StartTimer(self, atkTriggerFrame, function()
        LuaSkillCtrl:CallEffect(target, data.effectId_3, self, nil, nil, atkSpeedRatio)
      end)
    end
  end
  if data.effectId_start1 ~= nil then
    if atkActionId == data.action1 then
      LuaSkillCtrl:CallEffect(target, data.effectId_start1, self, nil, nil, atkSpeedRatio, true)
    else
      LuaSkillCtrl:CallEffect(target, data.effectId_start2, self, nil, nil, atkSpeedRatio, true)
    end
  end
  if LuaSkillCtrl:GetCasterSkinId(self.caster) == 300206 then
    if atkActionId == data.action1 then
      self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_11, self)
    else
      self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_22, self)
    end
  end
end

function bs_100200:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    if extraTarget ~= nil then
      self:CallShoot(extraTarget, data, atkActionId)
    end
    self:CallShoot(target, data, atkActionId)
  else
    self:BreakSkill()
  end
  if self.isDoubleAttack then
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
    self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  else
    self:CancleCasterWait()
  end
end

function bs_100200:CallShoot(target, data, atkActionId)
  if self.config.audioId4 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId4)
  end
  if atkActionId == self.config.action1 then
    if LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 300206 then
      if LuaSkillCtrl:GetCasterSkinId(self.caster) == 300208 or LuaSkillCtrl:GetCasterSkinId(self.caster) == 300210 then
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_1, self)
        LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_33, self, false, false, self.SkillEventFunc, data)
      else
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_1, self)
        LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_11, self, false, false, self.SkillEventFunc, data)
      end
    end
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 300206 then
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_111, self, false, false, self.SkillEventFunc, data)
    end
  else
    if LuaSkillCtrl:GetCasterSkinId(self.caster) ~= 300206 then
      if LuaSkillCtrl:GetCasterSkinId(self.caster) == 300208 or LuaSkillCtrl:GetCasterSkinId(self.caster) == 300210 then
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_2, self)
        LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_44, self, false, false, self.SkillEventFunc, data)
      else
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_2, self)
        LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_22, self, false, false, self.SkillEventFunc, data)
      end
    end
    if LuaSkillCtrl:GetCasterSkinId(self.caster) == 300206 then
      LuaSkillCtrl:CallEffectWithArg(target, self.config.effectId_222, self, false, false, self.SkillEventFunc, data)
    end
  end
end

function bs_100200:SkillEventFunc(configData, effect, eventId, target)
  base.SkillEventFunc(self, configData, effect, eventId, target)
  local breakComponent = target.targetRole:GetBreakComponent()
  if breakComponent ~= nil then
    target.targetRole:TryCallBreakNumChange(-self.cskill.skillCfg.BreakNum)
  end
end

function bs_100200:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100200
