local bs_1 = class("bs_1", LuaSkillBase)
local base = LuaSkillBase
bs_1.config = {
  rangeOffset = 0,
  effectId_trail = nil,
  effectId_trail_ex = nil,
  effectId_split_shoot = nil,
  effectId_split_shoot_ex = nil,
  effectId_action_1 = nil,
  effectId_action_2 = nil,
  effectId_start1 = nil,
  effectId_start2 = nil,
  effectId_start3 = nil,
  effectId_start4 = nil,
  effectId_hit_target = nil,
  effectId_1 = nil,
  effectId_2 = nil,
  effectId_3 = nil,
  targetSelect = 1001,
  action1 = 1001,
  action2 = 1004,
  audioId1 = nil,
  time1 = 0,
  audioId2 = nil,
  time2 = 0,
  audioId3 = nil,
  audioId4 = nil,
  audioId5 = nil,
  Imp = false,
  baseActionSpd = 1,
  atkDirectionRange = 30
}

function bs_1:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.hurt_config = {}
  self.lastAttackRole = nil
  self.caster.recordTable.lastAttackRole = nil
  self.lastBewitch = false
  self.attackNum = 0
  self.caster.recordTable["1_attack_effect"] = nil
end

function bs_1:PlaySkill(passdata)
  self:CheckAndRecordIsDoubleAttack(passdata)
  local data
  if passdata ~= nil then
    data = setmetatable(passdata, {
      __index = self.config
    })
  else
    data = self.config
  end
  self:SetAttackRole(data)
  if self.lastAttackRole ~= nil and LuaSkillCtrl:IsAbleAttackTarget(self.caster, self.lastAttackRole, data.rangeOffset + self.caster.attackRange, true) and LuaSkillCtrl:IsWorthAttacking(self, self.lastAttackRole) then
    self.caster:LookAtTarget(self.lastAttackRole)
    if LuaSkillCtrl:IsAbleAttackCheckExcludedDir(self.caster, self.lastAttackRole, self.config.atkDirectionRange) then
      self.rotateWaited = true
      LuaSkillCtrl:StartTimer(self, 3, BindCallback(self, self.RealPlaySkill, self.lastAttackRole, data))
    else
      self.rotateWaited = false
      self:RealPlaySkill(self.lastAttackRole, data)
    end
  else
    self.lastAttackRole = nil
    self.caster.recordTable.lastAttackRole = nil
    self:ClearDoubleAttackNum()
    self:CancleCasterWait()
  end
end

function bs_1:SetAttackRole()
  self.displaySelectEfc = false
  local moveTarget = self:GetMoveSelectTarget()
  if moveTarget ~= nil then
    local curAtkRole = moveTarget.targetRole
    if curAtkRole ~= nil then
      if self.lastAttackRole ~= curAtkRole then
        self.displaySelectEfc = true
      end
      self.lastAttackRole = curAtkRole
    end
  end
end

function bs_1:CallSelectEffect()
  if self.caster.recordTable.completeFirstComatk and self.displaySelectEfc and self.lastAttackRole ~= nil then
    LuaSkillCtrl:CallSelectTargetEffect(self, self.lastAttackRole)
    self.displaySelectEfc = false
  end
end

function bs_1:RealPlaySkill(target, data)
  self:CallSelectEffect()
  local atkSpeed = LuaSkillCtrl:CallFormulaNumber(9997, self.caster, self.caster)
  local atkSpeedRatio = 1
  local atkActionId = data.action1
  local atkTriggerFrame = 0
  local atkId = 1
  if 1 < self.attackNum then
    local prob = LuaSkillCtrl:CallRange(1, 2)
    atkId = prob
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
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, atkActionId, atkSpeedRatio, atkTriggerFrame, attackTrigger, atkId)
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
end

function bs_1:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
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
      self:ExecuteEffectAttack(data, atkActionId, extraTarget, data.effectId_split_shoot, data.effectId_split_shoot_ex)
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
  if self.cskill.skillCfg.BreakNum ~= 0 then
    target:TryCallBreakNumChange(-self.cskill.skillCfg.BreakNum)
  end
end

function bs_1:ExecuteEffectAttack(data, atkActionId, target, effectId1, effectId2)
  if data.effectId_trail ~= nil then
    if data.audioId4 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
    end
    if data.effectId_trail_ex ~= nil then
      if atkActionId == data.action1 then
        effectId1 = effectId1 or data.effectId_trail
        LuaSkillCtrl:CallEffectWithArg(target, effectId1, self, nil, false, self.SkillEventFunc, data)
      else
        effectId2 = effectId2 or data.effectId_trail_ex
        LuaSkillCtrl:CallEffectWithArg(target, effectId2, self, nil, false, self.SkillEventFunc, data)
      end
    else
      effectId1 = effectId1 or data.effectId_trail
      LuaSkillCtrl:CallEffectWithArg(target, effectId1, self, nil, false, self.SkillEventFunc, data)
    end
  elseif data.effectId_hit_target ~= nil then
    LuaSkillCtrl:CallEffectWithArg(target, data.effectId_hit_target, self, nil, false, self.SkillEventFunc, data)
  end
end

function bs_1:CheckAndGetExtraEffectTarget(targetRole, skillSelectId)
  if not LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.SplitShoot) then
    return nil
  end
  if skillSelectId == nil then
    skillSelectId = 10001
  end
  local targets = LuaSkillCtrl:CallTargetSelect(self, skillSelectId, 2)
  if targets == nil or targets.Count <= 0 then
    return nil
  end
  for i = 0, targets.Count - 1 do
    local role = targets[i].targetRole
    if role ~= targetRole then
      return role
    end
  end
end

function bs_1:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  self.recordDoubleAttackNum = self.recordDoubleAttackNum + 1
  if self.recordDoubleAttackNum <= 1 then
    self:CallDoubleAttackData(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
  end
  if self.recordDoubleAttackNum >= 2 then
    self:ClearDoubleAttackNum()
    self:CancleCasterWait()
  end
end

function bs_1:CallDoubleAttackData(data, target, attackFrame, atkSpeedRatio, actionId, attackTrigger)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    LuaSkillCtrl:CallRoleAction(self.caster, actionId, atkSpeedRatio)
    LuaSkillCtrl:StartTimer(self, attackFrame, attackTrigger)
  else
    self:ClearDoubleAttackNum()
    self:CancleCasterWait()
  end
end

function bs_1:CheckAndRecordIsDoubleAttack(passdata)
  self.isDoubleAttack = LuaSkillCtrl:RoleContainsBuffFeature(self.caster, eBuffFeatureType.DoubleAttack)
  self:ClearDoubleAttackNum()
  self.passdata = passdata
end

function bs_1:ClearDoubleAttackNum()
  self.recordDoubleAttackNum = 0
end

function bs_1:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, generalHurtConfig)
    skillResult:EndResult()
  end
end

function bs_1:OnCasterDie()
  base.OnCasterDie(self)
end

function bs_1:LuaDispose()
  self:ClearDoubleAttackNum()
  self.lastAttackRole = nil
  self.passdata = nil
  base.LuaDispose(self)
end

return bs_1
