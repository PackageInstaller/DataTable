require("buff_logic_base")
_class("BuffLogicAddLayer", BuffLogicBase)
BuffLogicAddLayer = BuffLogicAddLayer

function BuffLogicAddLayer:Constructor(buffInstance, logicParam)
  self._layer = logicParam.layer
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._dontDisplay = logicParam.dontDisplay or false
  self._multiplier = logicParam.multiplier
  self._addByMonsetHPCostVal = logicParam.addByMonsetHPCostVal
end

function BuffLogicAddLayer:DoLogic(notify, _, logicIndex)
  local alterLayer = self._buffInstance:GetAlterLayerOnLoad()
  if alterLayer then
    local l = alterLayer[logicIndex]
    if l then
      Log.info("BuffLogicAddLayer: layer altered from ", self._layer, "to ", l)
      self._layer = l
    end
  end
  local cfgLayer = self._layer
  if self._addByMonsetHPCostVal and notify and notify:GetNotifyType() == NotifyType.MonsterHPCChange then
    local key = self._addByMonsetHPCostVal
    local notifyRecordNum = notify:GetCumulativeTriggerNum(key)
    if notifyRecordNum then
      cfgLayer = notifyRecordNum
    end
  end
  local svc = self._world:GetService("BuffLogic")
  local pos = notify.GetAttackPos and notify:GetAttackPos() or nil
  local mul = 1
  if notify.GetWalkGridCount and notify:GetWalkGridCount() then
    mul = notify:GetWalkGridCount()
  end
  local addLayer = cfgLayer and cfgLayer * mul or 0
  local oldFinalLayer = svc:GetBuffLayer(self._entity, self._layerType)
  if self._multiplier then
    addLayer = math.floor(oldFinalLayer * (self._multiplier - 1)) * mul
  end
  local casterEntity = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or nil
  local curMarkLayer, buffinst, overflowLayer = svc:AddBuffLayer(self._entity, self._layerType, addLayer, pos, casterEntity)
  if not buffinst then
    return
  end
  self:PrintBuffLogicLog("BuffLogicAddLayer entity=", self._entity:GetID(), " layerType=", self._layerType, " layer=", curMarkLayer)
  self:TryProcessLayerAsActiveSkillEnergy(self._entity, curMarkLayer)
  local buffResult = BuffResultLayer:New(curMarkLayer, buffinst:BuffSeq(), addLayer, self._layerType)
  buffResult.__oldFinalLayer = oldFinalLayer
  if notify:GetNotifyType() == NotifyType.PlayerEachMoveStart or notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    buffResult:SetMovePos(notify:GetPos())
  end
  if notify:GetNotifyType() == NotifyType.TrapSkillStart then
    buffResult:SetMovePos(notify:GetPos())
  end
  if notify:GetNotifyType() == NotifyType.BeforeHighFrequencyDamageHit then
    local n = notify
    buffResult:SetHighFrequencyDamageIndex(n:GetHitIndex())
  end
  if notify:GetNotifyType() == NotifyType.AfterHighFrequencyDamageHit then
    local n = notify
    buffResult:SetHighFrequencyDamageIndex(n:GetHitIndex())
  end
  if notify:GetNotifyType() == NotifyType.PlayerBeHit then
    buffResult.damageIndex = notify:GetDamageIndex()
  end
  if notify:GetNotifyType() == NotifyType.MonsterBeHit then
    buffResult:SetDamageStageIndex(notify:GetDamageStageIndex())
    buffResult:SetCurSkillDamageIndex(notify:GetCurSkillDamageIndex())
    local battleStatCmpt = self._world:BattleStat()
    local round = battleStatCmpt:GetLevelTotalRoundCount()
    buffResult:SetLevelTotalRoundCount(round)
  end
  if notify.GetAttackPos and notify.GetTargetPos then
    buffResult.attackPos = notify:GetAttackPos()
    buffResult.targetPos = notify:GetTargetPos()
  end
  if notify.GetNormalAttackIndex then
    buffResult.normalAttackIndex = notify:GetNormalAttackIndex()
  end
  if notify.GetAttackerEntity and notify.GetDefenderEntity then
    buffResult.attackerEntity = notify:GetAttackerEntity()
    buffResult.defenderEntity = notify:GetDefenderEntity()
  end
  if notify:GetNotifyType() == NotifyType.MinosAbsorbTrap then
    local trapEntity = notify:GetNotifyEntity()
    buffResult.abTrapID = trapEntity:GetID()
  end
  if notify:GetNotifyType() == NotifyType.PetMinosAbsorbTrap then
    local trapEntity = notify:GetNotifyEntity()
    buffResult.abTrapID = trapEntity:GetID()
  end
  if notify:GetNotifyType() == NotifyType.SuperGridTriggerEnd or notify:GetNotifyType() == NotifyType.PoorGridTriggerEnd then
    buffResult:SetTriggerPos(notify:GetTriggerPos())
  end
  if notify:GetNotifyType() == NotifyType.NotifyLayerChange then
    local nt = notify
    buffResult:SetNotifyLayerChange_Entity(nt:GetNotifyEntity())
    buffResult:SetNotifyLayerChange_TotalLayer(nt:GetTotalCount())
  end
  if notify:GetNotifyType() == NotifyType.TrapDead then
    local entity = notify:GetNotifyEntity()
    buffResult:SetEntityID(entity:GetID())
  end
  if notify:GetNotifyType() == NotifyType.NormalEachAttackEnd then
    buffResult.attacker = notify:GetAttackerEntity()
    buffResult.defender = notify:GetDefenderEntity()
    buffResult.attackPos = notify:GetAttackPos()
    buffResult.targetPos = notify:GetTargetPos()
  end
  local layerName = svc:GetBuffLayerName(self._layerType)
  buffResult.totalLayerCount = svc:GetBuffTotalLayer(self._entity, layerName)
  buffResult:SetFinalLayer(curMarkLayer)
  local casterID = casterEntity and casterEntity:GetID() or nil
  buffResult.__buffLogicAddLayer_source = casterID
  svc:SetPoisonByAttackCasterID(self._entity, self._layerType, casterID)
  svc:SetRebeccaPoisonCasterID(self._entity, self._layerType, casterID)
  local viewParams = self._buffInstance:BuffConfigData():GetViewParams() or {}
  if viewParams.IsHPEnergy then
    self._entity:BuffComponent():SetBuffValue("HPEnergyBuffEffectType", self._buffInstance:GetBuffEffectType())
  end
  buffResult:SetDontDisplay(self._dontDisplay)
  buffResult:SetOverflowLayer(overflowLayer)
  if self._dontDisplay then
    return
  end
  return buffResult
end

function BuffLogicAddLayer:DoOverlap(logicParam, context)
  local svc = self._world:GetService("BuffLogic")
  local addLayer = self._layer and self._layer or 0
  if self._multiplier then
    addLayer = math.floor(svc:GetBuffLayer(self._entity, self._layerType) * (self._multiplier - 1))
  end
  local casterEntity = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or nil
  local curMarkLayer, buffinst, overflowLayer = svc:AddBuffLayer(self._entity, logicParam.layerType or self._buffInstance:GetBuffEffectType(), addLayer, nil, casterEntity)
  if not buffinst then
    return
  end
  self:PrintBuffLogicLog("BuffLogicAddLayer entity=", self._entity:GetID(), " layerType=", self._layerType, " layer=", curMarkLayer)
  self:TryProcessLayerAsActiveSkillEnergy(curMarkLayer)
  local buffResult = BuffResultLayer:New(curMarkLayer, buffinst:BuffSeq(), addLayer, self._layerType)
  local layerName = svc:GetBuffLayerName(self._layerType)
  buffResult.totalLayerCount = svc:GetBuffTotalLayer(self._entity, layerName)
  local contextCasterEntity = context and context.casterEntity or nil
  local casterID = contextCasterEntity and contextCasterEntity:GetID() or nil
  buffResult.__buffLogicAddLayer_source = casterID
  buffResult:SetDontDisplay(self._dontDisplay)
  buffResult:SetOverflowLayer(overflowLayer)
  if self._dontDisplay then
    return
  end
  return buffResult
end

function BuffLogicAddLayer:TryProcessLayerAsActiveSkillEnergy(petEntity, curMarkLayer)
  local petEntity = self._entity
  if not self._entity:HasSkillInfo() then
    return
  end
  local activeSkillID = self._entity:SkillInfo():GetActiveSkillID()
  local activeSkillConfig = self._world:GetService("Config"):GetSkillConfigData(activeSkillID, self._entity)
  if not activeSkillConfig or activeSkillConfig:GetSkillTriggerType() ~= SkillTriggerType.BuffLayer then
    return
  end
  local buffEffectType = self._buffInstance:GetBuffEffectType()
  local extraParam = activeSkillConfig:GetSkillTriggerExtraParam()
  if self._layerType ~= extraParam.buffEffectType then
    return
  end
  local ready = curMarkLayer >= activeSkillConfig:GetSkillTriggerParam() and 1 or 0
  local blsvc = self._world:GetService("BuffLogic")
  blsvc:ChangePetActiveSkillReady(petEntity, ready)
  if ready then
    local notify = NTPowerReady:New(petEntity)
    self._world:GetService("Trigger"):Notify(notify)
  end
  local skillInfoCmpt = petEntity:SkillInfo()
  local variantActiveSkillInfo = skillInfoCmpt:GetVariantActiveSkillInfo()
  if variantActiveSkillInfo then
    local variantList = variantActiveSkillInfo[activeSkillID]
    for _, variantSkillID in pairs(variantList) do
      local variantSkillCfg = self._world:GetService("Config"):GetSkillConfigData(variantSkillID, self._entity)
      if variantSkillCfg:GetSkillTriggerType() == SkillTriggerType.BuffLayer then
        ready = curMarkLayer >= variantSkillCfg:GetSkillTriggerParam() and 1 or 0
        Log.fatal("BuffLogicAddLayer Ready:", ready, "VariantSkillID:", activeSkillID)
        blsvc:ChangePetActiveSkillReady(petEntity, ready, variantSkillID)
      end
    end
  end
end

BuffClearLayerType = {
  All = 0,
  Percent = 1,
  Count = 2,
  Prob = 3
}
_enum("BuffClearLayerType", BuffClearLayerType)
_class("BuffLogicClearLayer", BuffLogicBase)
BuffLogicClearLayer = BuffLogicClearLayer

function BuffLogicClearLayer:Constructor(buffInstance, logicParam)
  self._layer = logicParam.layer
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._clearType = logicParam.clearType or BuffClearLayerType.All
  self._clearParam = logicParam.clearParam
  self._dontDisplay = logicParam.dontDisplay
  self._ownerEntity = logicParam.ownerEntity or "self"
  self._unloadZeroLayer = logicParam.unloadZeroLayer or 0
  self._clearExtraParam = logicParam.clearExtraParam
  self._ownerEntityMatchNotifyEntity = logicParam.ownerEntityMatchNotifyEntity or 0
end

function BuffLogicClearLayer:DoLogic(notify)
  local ownerEntity = self._entity
  if self._ownerEntity == "target" then
    ownerEntity = notify:GetDefenderEntity()
  end
  if self._ownerEntityMatchNotifyEntity == 1 and ownerEntity:HasTeam() and ownerEntity:GetID() ~= notify:GetNotifyEntity():GetID() then
    return
  end
  if self._clearType == BuffClearLayerType.Count then
    local addLayerCount = self._buffInstance:GetChangeLayerCount()
    if addLayerCount and addLayerCount[self._layerType] and self._clearParam > addLayerCount[self._layerType] then
      self._clearParam = addLayerCount[self._layerType]
    end
  end
  local svc = self._world:GetService("BuffLogic")
  local leftLayer = svc:GetBuffLayer(ownerEntity, self._layerType) or 0
  local sourceLayer = svc:GetBuffLayer(ownerEntity, self._layerType) or 0
  if self._clearType == BuffClearLayerType.All then
    leftLayer = 0
  elseif self._clearType == BuffClearLayerType.Percent then
    local layer = svc:GetBuffLayer(ownerEntity, self._layerType) or 0
    local resultLayer = layer * self._clearParam
    if not self._clearExtraParam then
      leftLayer = math.floor(resultLayer)
    elseif self._clearExtraParam == 1 then
      leftLayer = math.ceil(resultLayer)
    end
  elseif self._clearType == BuffClearLayerType.Count then
    local layer = svc:GetBuffLayer(ownerEntity, self._layerType)
    leftLayer = layer - self._clearParam
  elseif self._clearType == BuffClearLayerType.Prob then
    local layer = svc:GetBuffLayer(ownerEntity, self._layerType)
    local prob = math.modf(self._clearParam.Prob * 100)
    local randomSvc = self._world:GetService("RandomLogic")
    local rand = randomSvc:LogicRand(1, 100)
    if prob >= rand then
      leftLayer = layer - self._clearParam.Count
    end
  end
  local changeLayer = sourceLayer - leftLayer
  leftLayer = math.max(0, leftLayer)
  svc:SetBuffLayer(ownerEntity, self._layerType, leftLayer)
  local targetBuffSeq = {}
  local targetBuff = ownerEntity:BuffComponent():GetSingleBuffByBuffEffect(self._layerType)
  if targetBuff then
    table.insert(targetBuffSeq, targetBuff:BuffSeq())
  end
  local isUnload = 0
  if self._unloadZeroLayer == 1 and leftLayer == 0 then
    local buffComp = ownerEntity:BuffComponent()
    local existBuff = buffComp:GetBuffArrayByBuffEffect(self._layerType)
    if existBuff and 0 < table.count(existBuff) then
      table.clear(targetBuffSeq)
      for _, value in ipairs(existBuff) do
        table.insert(targetBuffSeq, value:BuffSeq())
        value:Unload(NTBuffUnload:New())
      end
    end
    svc:ClearPoisonByAttackCasterID(ownerEntity, self._layerType)
    svc:ClearRebeccaPoisonCasterID(ownerEntity, self._layerType)
    isUnload = 1
  end
  self:PrintBuffLogicLog("BuffLogicClearLayer entity=", ownerEntity:GetID(), " layerType=", self._layerType, " layer=", leftLayer)
  local buffResult = BuffResultClearLayer:New(leftLayer, self._dontDisplay, ownerEntity:GetID(), self._layerType, isUnload, targetBuffSeq)
  buffResult:SetChangeLayer(changeLayer)
  if notify:GetNotifyType() == NotifyType.NormalEachAttackStart or notify:GetNotifyType() == NotifyType.NormalEachAttackEnd or notify:GetNotifyType() == NotifyType.BuffCastSkillEachAttackBegin or notify:GetNotifyType() == NotifyType.MonsterBeHit then
    buffResult.attacker = notify:GetAttackerEntity()
    buffResult.defender = notify:GetDefenderEntity()
    buffResult.attackPos = notify:GetAttackPos()
    buffResult.targetPos = notify:GetTargetPos()
  end
  if notify:GetNotifyType() == NotifyType.TrapSkillStart then
    buffResult:SetMovePos(notify:GetPos())
  end
  if notify:GetNotifyType() == NotifyType.NotifyLayerChange then
    local n = notify
    if n:GetTotalCount() == 200 then
      Log.error()
    end
    buffResult:SetTotalLayer(n:GetTotalCount())
  end
  if notify:GetNotifyType() == NotifyType.MinosAbsorbTrap then
    local trapEntity = notify:GetNotifyEntity()
    buffResult.abTrapID = trapEntity:GetID()
  end
  if notify:GetNotifyType() == NotifyType.PetMinosAbsorbTrap then
    local trapEntity = notify:GetNotifyEntity()
    buffResult.abTrapID = trapEntity:GetID()
  end
  if notify:GetNotifyType() == NotifyType.SuperGridTriggerEnd or notify:GetNotifyType() == NotifyType.PoorGridTriggerEnd then
    buffResult:SetTriggerPos(notify:GetTriggerPos())
  end
  if notify:GetNotifyType() == NotifyType.ReduceShieldLayer then
    buffResult:SetLayer(notify:GetNotifyLayer())
  end
  if notify:GetNotifyType() == NotifyType.TrapDead then
    local entity = notify:GetNotifyEntity()
    buffResult:SetEntityID(entity:GetID())
  end
  local viewParams = self._buffInstance:BuffConfigData():GetViewParams() or {}
  if viewParams.IsHPEnergy then
    self._entity:BuffComponent():SetBuffValue("HPEnergyBuffEffectType", nil)
  end
  return buffResult
end

function BuffLogicClearLayer:DoOverlap(logicParam)
end

_class("BuffLogicForceRefreshLayer", BuffLogicBase)
BuffLogicForceRefreshLayer = BuffLogicForceRefreshLayer

function BuffLogicForceRefreshLayer:Constructor(buffInstance, logicParam)
  self._buffEffectType = logicParam.buffEffectType
end

function BuffLogicForceRefreshLayer:DoLogic()
  local e = self._buffInstance:Entity()
  local blsvc = self._world:GetService("BuffLogic")
  local layer = blsvc:GetBuffLayer(e, self._buffEffectType)
  local inst = e:BuffComponent():GetSingleBuffByBuffEffect(self._buffEffectType)
  local buffseq = inst:BuffSeq()
  local buffLayerName = inst:GetBuffLayerName()
  return BuffResultForceRefreshLayer:New(layer, buffseq, buffLayerName)
end

function BuffLogicForceRefreshLayer:DoOverlap()
  return self:DoLogic()
end
