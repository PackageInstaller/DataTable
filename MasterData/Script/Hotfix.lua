local Hofix = {}
if GameSetting.platform == "Harmony" or GameSetting.IsOpenXLuaHotfix ~= nil and GameSetting.IsOpenXLuaHotfix == false then
  return
end
if CommonTips.IsNewApp("1.7") then
  xlua.hotfix(CS.Battle.BuffTriggerDamage, "Compare", function(self, buffDamage)
    if self.ca.onlyFromSelf and buffDamage.owner ~= self.owner then
      return false
    end
    if self.ca.onlyFromTarget and buffDamage.owner ~= self.target then
      return false
    end
    if self.ca.onlyToSelf and buffDamage.target ~= self.owner then
      return false
    end
    if self.ca.onlyToTarget and buffDamage.target ~= self.target then
      return false
    end
    if self.ca:GetValue("checkAdditionalAttack") and buffDamage.ca.isNoAdditionalAttack then
      return false
    end
    if self.ca:GetValue("isHealTrigger") and buffDamage.ca.type ~= "Heal" and buffDamage.ca.type ~= "HitHeal" and buffDamage.ca.type ~= "Recover" then
      return false
    end
    if self.ca:GetValue("isDamageTrigger") and (buffDamage.ca.type == "Heal" or buffDamage.ca.type == "HitHeal" or buffDamage.ca.type == "Recover") then
      return false
    end
    if self.ca.targetTagList ~= nil and self.ca.targetTagList.Count > 0 then
      return CS.CompareTool.CardTagCompare(buffDamage.ca.typeTagList, self.ca.targetTagList, self.ca.judgeType)
    end
    if 0 < self.ca.targetBuffId.id then
      return buffDamage.ca.id == self.ca.targetBuffId.id
    end
    return true
  end)
  xlua.hotfix(CS.Battle.BuffTriggerDamage, "ExcuteBuff", function(self, buffDamage, finalDmg_SN, overflowDmg_SN)
    if self.ca.buffId.id > 0 then
      local snapshotSource = self:GetSnapshotSource(buffDamage)
      if self.ca.isRefreshSnapshot and self._lastRefreshSnapshotFrame < self._cbus.currentFrame and snapshotSource ~= nil and snapshotSource.property ~= nil and snapshotSource.property.propertyDic ~= nil then
        self._snapshot:SetParams(snapshotSource.property.propertyDic, true)
        self._snapshot.actionData:SetSkillParamSN((snapshotSource.property:GetSkillParam(-1)))
        self._lastRefreshSnapshotFrame = self._cbus.currentFrame
      end
      if self.ca.tag ~= "" then
        self._snapshot:SetAttributeBase(finalDmg_SN, self.ca.tag, "Number", true)
      end
      if self.ca.overflowTag ~= "" then
        self._snapshot:SetAttributeBase(overflowDmg_SN, self.ca.overflowTag, "Number", true)
      end
      if self.ca.toDamageSource then
        local tBuff = CS.Battle.BuffBase._buffFactory:Produce(self.ca.buffId.id, snapshotSource, self._snapshot, self.action, buffDamage.owner, self.positionSN, self.isSkill, self.from, self.fromUnitSID)
        buffDamage.owner:AddBuff(tBuff)
      else
        local tBuff = CS.Battle.BuffBase._buffFactory:Produce(self.ca.buffId.id, snapshotSource, self._snapshot, self.action, buffDamage.target, self.positionSN, self.isSkill, self.from, self.fromUnitSID)
        buffDamage.target:AddBuff(tBuff)
      end
    end
  end)
  xlua.hotfix(CS.Battle.BuffDamage, "SetSnapshot", function(self, snapshot)
    base(self):SetSnapshot(snapshot)
    self._snapshot.damageType = self.ca.type
    local teamData = self.owner.teamData
    if teamData == nil then
      if self.owner.Owner ~= nil then
        teamData = self.owner.Owner.teamData
      else
        return
      end
    end
    if teamData == nil then
      return
    end
    local roleList = teamData and teamData.roleList or {Count = 0}
    local tCriSN = 0
    local tCriDamageSN = 0
    local length = roleList.Count
    for i = 0, length - 1 do
      local tUnit = roleList[i]
      tCriSN = tCriSN + tUnit.property:GetValueSN("Cri")
      tCriDamageSN = tCriDamageSN + tUnit.property:GetValueSN("CriDamage")
    end
    tCriSN = SafeMath.Division(tCriSN, length * SafeMath.safeNumberTime)
    tCriDamageSN = SafeMath.Division(tCriDamageSN, length * SafeMath.safeNumberTime)
    teamData.sysUnit.property:SetAttributeBase(tCriSN, "Cri")
    teamData.sysUnit.property:SetAttributeBase(tCriDamageSN, "CriDamage")
    teamData.sysUnit.property:handleSnapshot()
  end)
  xlua.hotfix(CS.Battle.CardAICore, "HandleCommonAdjustWeight", function(self, action)
    self.currentAction = action
    self.currentCard = action.card
    local length = self._commonAdjustWeightList.Count
    for i = 0, length - 1 do
      if self._commonAdjustWeightList[i].condition:Excute(self) then
        action.weight = action.weight + self._commonAdjustWeightList[i].weight
      end
    end
    length = self._commonAdjustWeightExList.Count
    for i = 0, length - 1 do
      if self._commonAdjustWeightExList[i].condition:Excute(self) then
        action.weight = action.weight + self._commonAdjustWeightExList[i].weight
      end
    end
    if self.currentCard ~= nil then
      local condCardId = self.currentCard.ca.id
      if self.currentCard.cardProperty and self.currentCard.cardProperty.fakeCard then
        condCardId = self.currentCard.cardProperty.fakeCard.ca.id
      end
      if self.extraCardWeightDic:ContainsKey(condCardId) then
        action.weight = action.weight + self.extraCardWeightDic[condCardId]
      end
      if self._extraCardConditionDic:ContainsKey(condCardId) then
        for i = 0, self._extraCardConditionDic[condCardId].Count - 1 do
          if self._extraCardConditionDic[condCardId][i].condition:Excute(self) then
            action.weight = action.weight + self._extraCardConditionDic[condCardId][i].weight
          end
        end
      end
      if self.currentCard.cardProperty then
        local property = self.currentCard.cardProperty.property
        if property then
          local makeDmgSN = 10000 + property:GetValueSN("MakeDamageUp") - property:GetValueSN("MakeDamageDown")
          local makeDmgFinalSN = 10000 + property:GetValueSN("MakeDamageFinalUp") - property:GetValueSN("MakeDamageFinalDown")
          local val = (SafeMath.Multiplication(makeDmgSN, makeDmgFinalSN) - 10000) / 100
          action.weight = action.weight + math.floor(val)
        end
      end
    end
  end)
  xlua.hotfix(CS.Battle.BuffRecordDataUnitCountByTag, "OnStart", function(self, target)
    base(self):OnStart(target)
    if target.ca.factory.Name == "UnitFactory" then
      local targetMask = 0
      local targetType = self.ca.targetType
      if targetType == "Ally" or targetType == "AllyExceptSelf" or targetType == "Self" then
        targetMask = self.owner.selfMask
      elseif targetType == "Enemy" or targetType == "EnemyExceptSelf" then
        targetMask = self.owner.hitMask
      elseif targetType == "Every" or targetType == "ExceptSelf" then
        targetMask = CS.Enum_Unit.HitMask.Every.value__
      elseif targetType == "OnlyTeam1" then
        targetMask = CS.Enum_Unit.HitMask.OnlyTeam1.value__
      elseif targetType == "OnlyTeam2" then
        targetMask = CS.Enum_Unit.HitMask.OnlyTeam2.value__
      elseif targetType == "OnlyTeam3" then
        targetMask = CS.Enum_Unit.HitMask.OnlyTeam3.value__
      end
      local pos = target:GetUnitOffsetPosition()
      local targetX_SN = pos.x_SN
      local targetY_SN = pos.y_SN
      local targetZ_SN = pos.z_SN
      local targetList = CS.System.Collections.Generic.List(CS.Battle.Unit)()
      if 0 < self.ca.radius_SN then
        local tList
        if targetType == "Self" then
          tList = CS.System.Collections.Generic.List(CS.Battle.Unit)()
          tList:Add(self.owner)
        else
          tList = self._hitTest:HitTestRectReturnAll(targetX_SN, targetY_SN, self.ca.radius_SN, 100000, targetMask, self.owner.Side, nil, false, true)
          if targetType == "AllyExceptSelf" or targetType == "ExceptSelf" then
            tList.Remove(self.owner)
          end
          if targetType == "EnemyExceptSelf" then
            tList.Remove(target)
          end
        end
        self._unitManager:GetTargetList(tList, targetList, -1, self.ca.condition, self.ca.attributeType, self.ca.numberType, self.ca.number_SN, self.ca.targetTagList, self.ca.filterBuffFO.id, self.ca.filterBuffJudgeType, self.ca.filterBuffLevel, self.ca.filterBuffTypeFO.id, self.ca.filterStance, self.ca.filterPosition, targetX_SN, self.owner, self.ca.isAimSelf)
      end
      self:RecordData(SafeMath.IntToSafeNumber(targetList.Count))
    end
    self:OnEnd()
    return 0
  end)
  xlua.hotfix(CS.Battle.BuffSpeedUpDot, "Update", function(self)
    base(self):Update()
    self._intervalFrame = self._intervalFrame + 1
    if self._intervalFrame >= self.ca.intarval then
      local isOnEnd = true
      local count = self._list.Count
      for i = 0, count - 1 do
        local item = self._list[i]
        item.dotTimeLeft = item.dotTimeLeft - 1
        if 0 > item.dotTimeLeft then
          break
        end
        isOnEnd = false
        self:HandleBuff(item.dotCA.dotEffectList, item.dotSnapshot, true)
      end
      if isOnEnd then
        self:OnEnd()
      else
        self._intervalFrame = 0
      end
    end
  end)
  xlua.hotfix(CS.Battle.Unit, "DeadHandler", function(self)
    self.controller:SetOrder(CS.Battle.ControllerBase.Order.Null)
    self.isAlive = false
    local summons = CS.System.Collections.Generic.List(CS.Battle.Summon)(self.summonList)
    local length = summons.Count
    for i = 0, length - 1 do
      summons[i]:AfterSummonerDead()
    end
    summons:Clear()
    summons = nil
    self:ChangeAction(CS.Enum_Unit.BaseAction.Dead, true)
    self:DispelAll()
    self._battleControlManager:RemoveRoleCards(self)
    self._unitMananger:UnregUnit(self)
    if self.bulletControllerList ~= nil then
      for i = 0, self.bulletControllerList.Count - 1 do
        local item = self.bulletControllerList[i]
        item:ClearAllBullet(false)
      end
    end
    self.view:hideBossStatus()
    self.extraTagList:Clear()
    self:SetExtraTagList(self.ca.tagList, true)
  end)
  xlua.hotfix(CS.Battle.CardAICore, "SetCurrentAction", function(self, action)
    local battleUIManager = self._cbus:GetManager("BattleUIManager")
    if self._currentAction ~= action and self._currentAction ~= nil and self._currentAction.ca.mod == "\228\189\191\231\148\168\229\141\161\231\137\140" then
      battleUIManager.battleUI:CardAISetCardPress(nil)
    end
    if action ~= nil and action.ca.mod == "\228\189\191\231\148\168\229\141\161\231\137\140" and action.card ~= nil and action.card.cardProperty ~= nil then
      self.currentCard = action.card
      local node = battleUIManager.battleUI:GetHandCardNodeByHandUniqueIndex(action.card.cardProperty.cardUniqueId)
      if node ~= nil then
        battleUIManager.battleUI:CardAISetCardPress(node.item)
      end
    end
    self._currentAction = action
  end)
  xlua.hotfix(CS.Battle.BuffTriggerCumulativeCost, "ReduceCost", function(self, cost_SN)
    if not self.ca.isAdd then
      self.curVal = self.curVal + cost_SN
      local targetVal = self.ca.targetSN
      if self.ca.targetTag ~= nil and self.ca.targetTag ~= "" then
        targetVal = self.snapshot:GetValueSN(self.ca.targetTag, true)
      end
      if targetVal <= self.curVal then
        local buffCount = math.floor(self.curVal / targetVal)
        self.curVal = self.curVal % targetVal
        for i = 1, buffCount do
          self:AddBuff()
        end
      end
    end
  end)
  xlua.hotfix(CS.Battle.BuffTriggerCumulativeCost, "AddCost", function(self, cost_SN)
    if self.ca.isAdd then
      self.curVal = self.curVal + cost_SN
      local targetVal = self.ca.targetSN
      if self.ca.targetTag ~= nil and self.ca.targetTag ~= "" then
        targetVal = self.snapshot:GetValueSN(self.ca.targetTag, true)
      end
      if targetVal <= self.curVal then
        local buffCount = math.floor(self.curVal / targetVal)
        self.curVal = self.curVal % targetVal
        for i = 1, buffCount do
          self:AddBuff()
        end
      end
    end
  end)
  xlua.hotfix(CS.Battle.TeamData, "AddCost", function(self, costSN, canMore, isSkill)
    if canMore == nil then
      canMore = false
    end
    if isSkill == nil then
      isSkill = false
    end
    if self.CostMax_SN < self.Cost_SN and not canMore and 0 < costSN then
      return
    end
    if self._costMax_SN < self._cost_SN + costSN and not canMore and 0 < costSN then
      costSN = self._costMax_SN - self._cost_SN
    elseif 0 > self._cost_SN + costSN then
      costSN = 0 - self._cost_SN
    end
    self._cost_SN = self._cost_SN + costSN
    if 0 < costSN then
      self._flowAddPowerIndexSN = self._flowAddPowerIndexSN + costSN
    else
      self._flowReducePowerIndexSN = self._flowReducePowerIndexSN + costSN
    end
    local BroadcastLong = xlua.get_generic_method(CS.EventManager, "Broadcast")(CS.System.Int64)
    if self._flowAddPowerIndexSN >= SafeMath.safeNumberTime then
      local addCost = self._flowAddPowerIndexSN
      self._flowAddPowerIndexSN = self._flowAddPowerIndexSN % SafeMath.safeNumberTime
      BroadcastLong(self._eventManager, CS.Enum_Event.AdjustBattleCost, self._cost_SN)
      BroadcastLong(self._eventManager, CS.Enum_Event.AddBattleCost, addCost)
    end
    if -self._flowReducePowerIndexSN >= SafeMath.safeNumberTime then
      local addCost = self._flowReducePowerIndexSN
      self._flowReducePowerIndexSN = self._flowReducePowerIndexSN % SafeMath.safeNumberTime
      BroadcastLong(self._eventManager, CS.Enum_Event.AdjustBattleCost, self._cost_SN)
      BroadcastLong(self._eventManager, CS.Enum_Event.ReduceBattleCost, -addCost)
    end
  end)
  xlua.hotfix(CS.Battle.BattleResult, "AddData", function(self, id, dataType, numSN, iPlayerSide)
    if iPlayerSide == nil then
      iPlayerSide = 1
    end
    local tList = self.roleInfoList
    if iPlayerSide == 2 then
      tList = self.roleInfoListTeam2
    end
    if tList:ContainsKey(id) then
      local value = SafeMath.SafeNumberToInt(numSN)
      if dataType == CS.Battle.DataType.Damage then
        if value < 0 then
          value = value + 4294967296
        end
        tList[id].damage = tList[id].damage + value
        self.damageTotal = self.damageTotal + value
      elseif dataType == CS.Battle.DataType.GetHit then
        tList[id].getHit = tList[id].getHit + value
        self.getHitTotal = self.getHitTotal + value
      elseif dataType == CS.Battle.DataType.Heal then
        tList[id].heal = tList[id].heal + value
        self.healTotal = self.healTotal + value
      elseif dataType == CS.Battle.DataType.GetHeal then
        tList[id].getHeal = tList[id].getHeal + value
      elseif dataType == CS.Battle.DataType.Dieacts then
        tList[id].dieacts = tList[id].dieacts + value
      elseif dataType == CS.Battle.DataType.EnergyCost then
        tList[id].dieacts = tList[id].energyCost + value
      end
    end
  end)
  xlua.hotfix(CS.Battle.BuffTriggerBase, "OnEnd", function(self)
    if self._isStart then
      self._isStart = false
      self:RemoveListener()
    end
    base(self):OnEnd()
  end)
  xlua.hotfix(CS.Battle.LeaderCardConditionCreateCardCount, "ListenerCallBack", function(self, cardProperty)
    if cardProperty.card == nil then
      return
    end
    if CS.CompareTool.CardTagCompare(cardProperty.card, self.ca.tagList, self.ca.tagType, false) then
      self:AddProgress(self.ca.progAddNum)
    end
  end)
end
return Hofix
