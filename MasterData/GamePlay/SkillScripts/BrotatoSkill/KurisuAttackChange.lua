local KurisuAttackChange = {}
KurisuAttackChange.config = {
  effectId_start1 = 107828,
  effectId_start2 = 107828,
  action3 = 1021,
  effectId2 = 107826,
  effectId3 = 107829,
  effectId4 = 107832,
  select_Id = 42,
  effectId_trail = 107801,
  select_Id = 42,
  hurt_id_1 = 45,
  hurt_id_2 = 46
}

function KurisuAttackChange:OnAttackTrigger(target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, self.caster.attackRange, true) then
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
    if self.caster.recordTable.Kurisu_Mode == 3 then
      local shoottimes = self.caster.recordTable.Kurisu_tanshe
      local sender = self.caster
      self:ExecuteEffectAttack1(target, nil, nil, shoottimes, sender)
    else
      self:ExecuteEffectAttack(data, atkActionId, target)
    end
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

function KurisuAttackChange:ExecuteEffectAttack1(target, effectId1, effectId2, times, sender)
  local shoottimes = self.caster.recordTable.Kurisu_tanshe
  if times == shoottimes then
    effectId1 = self.config.effectId4
  else
    effectId1 = self.config.effectId3
  end
  local time_delay = 0
  if 0 < times then
    if times < shoottimes then
      time_delay = 5
    end
    LuaSkillCtrl:StartTimer(nil, time_delay, function()
      LuaSkillCtrl:CallEffectWithArgOverride(target, effectId1, self, sender, false, false, self.SkillEventFunc1, target, sender, times)
    end)
  end
end

function KurisuAttackChange:SkillEventFunc1(target, sender, times, effect, eventId)
  if eventId == eBattleEffectEvent.Trigger then
    if times == self.caster.recordTable.Kurisu_tanshe then
      local args = LuaSkillCtrl:CreatCacheTable(self.caster.recordTable.first_attack, self.hurtArgs)
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_id_1, args, false)
      skillResult:EndResult()
    else
      local args = LuaSkillCtrl:CreatCacheTable(self.caster.recordTable.tanshe_attack, self.hurtArgs)
      local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_id_1, args, false)
      skillResult:EndResult()
    end
    local target_next
    local targetList = LuaSkillCtrl:CallTargetSelect(self, self.config.select_Id, 10)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        if targetList[i].targetRole ~= nil and targetList[i].targetRole ~= target then
          target_next = targetList[i].targetRole
          self:ExecuteEffectAttack1(target_next, nil, nil, times - 1, target)
          break
        end
      end
    end
  end
end

function KurisuAttackChange:ExecuteEffectAttack(data, atkActionId, target, effectId1, effectId2)
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

function KurisuAttackChange:SkillEventFunc(configData, effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(target.targetRole, configData.audioId5)
    end
    if configData.Imp == true then
      LuaSkillCtrl:PlayAuHit(self, target)
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_id_1, {1000}, false)
    skillResult:EndResult()
  end
end

return KurisuAttackChange
