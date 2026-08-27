local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_545 = class("bs_545", bs_1)
local base = bs_1
bs_545.config = {
  effectId_1 = 204811,
  effectId_2 = 204812,
  audioId3 = 436
}
bs_545.config = setmetatable(bs_545.config, {
  __index = base.config
})

function bs_545:ctor()
end

function bs_545:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
end

function bs_545:RealPlaySkill(target, data)
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
  if not LuaSkillCtrl.IsInTDBattle then
    self.caster.recordTable.lastAttackRole = target
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
        local effectGrid = LuaSkillCtrl:GetGridWithRole(target)
        local effectGrid = LuaSkillCtrl:GetTargetWithGrid(effectGrid.x, effectGrid.y)
        self.caster.recordTable["1_attack_effect"] = LuaSkillCtrl:CallEffect(effectGrid, data.effectId_1, self, nil, nil, atkSpeedRatio, true)
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
end

function bs_545:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if self.caster.attackRange == 1 then
    if data.audioId3 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      if data.Imp == true then
        LuaSkillCtrl:PlayAuHit(self, target)
      end
      LuaSkillCtrl:HurtResult(self, skillResult)
      skillResult:EndResult()
      if self.caster.recordTable.completeFirstComatk == nil then
        self.caster.recordTable.completeFirstComatk = true
      end
    else
      self:BreakSkill()
    end
  elseif LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    if data.effectId_action_1 ~= nil then
      if atkActionId == data.action1 then
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_1, self)
      else
        LuaSkillCtrl:CallEffect(self.caster, data.effectId_action_2, self)
      end
    end
    if data.effectId_start3 ~= nil then
      if atkActionId == data.action1 then
        LuaSkillCtrl:CallEffect(target, data.effectId_start3, self, nil, nil, atkSpeedRatio)
      else
        LuaSkillCtrl:CallEffect(target, data.effectId_start4, self, nil, nil, atkSpeedRatio)
      end
    end
    local extraTarget = self:CheckAndGetExtraEffectTarget(target)
    self:ExecuteEffectAttack(data, atkActionId, target)
    if extraTarget ~= nil then
      self:ExecuteEffectAttack(data, atkActionId, extraTarget)
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
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

function bs_545:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_545
