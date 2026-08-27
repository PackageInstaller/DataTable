local ShaleAttackChange = {}
ShaleAttackChange.config = {selectId = 6}

function ShaleAttackChange:RealPlaySkill(target, data)
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

function ShaleAttackChange:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if data.audioId3 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
    local targetList = LuaSkillCtrl:CallTargetSelectWithRange(self, self.config.selectId, 2, target)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i].targetRole)
        LuaSkillCtrl:HurtResult(self, skillResult)
        skillResult:EndResult()
      end
    end
    if data.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    if self.caster.recordTable.completeFirstComatk == nil then
      self.caster.recordTable.completeFirstComatk = true
    end
  else
    self:BreakSkill()
  end
end

return ShaleAttackChange
