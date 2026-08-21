_class("BuffResultBase", Object)
BuffResultBase = BuffResultBase

function BuffResultBase:Constructor()
end

_class("BuffResultAddHPShield", BuffResultBase)
BuffResultAddHPShield = BuffResultAddHPShield

function BuffResultAddHPShield:Constructor(entityID, damageInfo)
  self._entityID = entityID
  self._damageInfo = damageInfo
  self._chainPetEntityID = nil
end

function BuffResultAddHPShield:SetChainPetEntityID(entityID)
  self._chainPetEntityID = entityID
end

function BuffResultAddHPShield:GetChainPetEntityID()
  return self._chainPetEntityID
end

function BuffResultAddHPShield:GetShield()
  return self._shield
end

function BuffResultAddHPShield:GetEntityID()
  return self._entityID
end

function BuffResultAddHPShield:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddHPShield:SetNotifyChainSkillTimeIndex(v)
  self._notifyChainSkillTimeIndex = v
end

function BuffResultAddHPShield:GetNotifyChainSkillTimeIndex()
  return self._notifyChainSkillTimeIndex
end

function BuffResultAddHPShield:SetNotifyChainSkillStageIndex(v)
  self._notifyChainSkillStageIndex = v
end

function BuffResultAddHPShield:GetNotifyChainSkillStageIndex()
  return self._notifyChainSkillStageIndex
end

_class("BuffResultRemoveHPShield", BuffResultBase)
BuffResultRemoveHPShield = BuffResultRemoveHPShield

function BuffResultRemoveHPShield:Constructor(entityID, damageInfo)
  self._entityID = entityID
  self._damageInfo = damageInfo
  self._chainPetEntityID = nil
end

function BuffResultRemoveHPShield:SetChainPetEntityID(entityID)
  self._chainPetEntityID = entityID
end

function BuffResultRemoveHPShield:GetChainPetEntityID()
  return self._chainPetEntityID
end

function BuffResultRemoveHPShield:GetEntityID()
  return self._entityID
end

function BuffResultRemoveHPShield:GetDamageInfo()
  return self._damageInfo
end

function BuffResultRemoveHPShield:SetNotifyChainSkillTimeIndex(v)
  self._notifyChainSkillTimeIndex = v
end

function BuffResultRemoveHPShield:GetNotifyChainSkillTimeIndex()
  return self._notifyChainSkillTimeIndex
end

function BuffResultRemoveHPShield:SetNotifyChainSkillStageIndex(v)
  self._notifyChainSkillStageIndex = v
end

function BuffResultRemoveHPShield:GetNotifyChainSkillStageIndex()
  return self._notifyChainSkillStageIndex
end

_class("BuffResultAddHPByTargetBuffEffectType", BuffResultBase)
BuffResultAddHPByTargetBuffEffectType = BuffResultAddHPByTargetBuffEffectType

function BuffResultAddHPByTargetBuffEffectType:Constructor(addHP, damageInfo)
  self._addHP = addHP
  self._damageInfo = damageInfo
end

function BuffResultAddHPByTargetBuffEffectType:GetAddHP()
  return self._addHP
end

function BuffResultAddHPByTargetBuffEffectType:GetDamageInfo()
  return self._damageInfo
end

_class("BuffResultChangeSkillFinalByTargetEdgeDistance", BuffResultBase)
BuffResultChangeSkillFinalByTargetEdgeDistance = BuffResultChangeSkillFinalByTargetEdgeDistance

function BuffResultChangeSkillFinalByTargetEdgeDistance:Constructor(rate, effectlist, finalvalue)
  self._rate = rate
  self._effectlist = effectlist
  self._finalvalue = finalvalue
end

function BuffResultChangeSkillFinalByTargetEdgeDistance:GetRate()
  return self._rate
end

function BuffResultChangeSkillFinalByTargetEdgeDistance:GetEffectList()
  return self._effectlist
end

function BuffResultChangeSkillFinalByTargetEdgeDistance:GetFinalValue()
  return self._finalvalue
end

_class("BuffResultHPLock", BuffResultBase)
BuffResultHPLock = BuffResultHPLock

function BuffResultHPLock:Constructor(index)
  self._index = index
end

function BuffResultHPLock:GetLockIndex()
  return self._index
end

_class("BuffResultAccumulateChangePower", BuffResultBase)
BuffResultAccumulateChangePower = BuffResultAccumulateChangePower

function BuffResultAccumulateChangePower:Constructor(accChain, power)
  self._accChain = accChain
  self._power = power
end

function BuffResultAccumulateChangePower:GetAccChain()
  return self._accChain
end

function BuffResultAccumulateChangePower:GetPower()
  return self._power
end

function BuffResultAccumulateChangePower:RequireNTPowerReady(petEntityID)
  self._petEntityID = petEntityID
  self._requireNTPowerReady = true
end

function BuffResultAccumulateChangePower:GetPetEntityID()
  return self._petEntityID
end

function BuffResultAccumulateChangePower:IsNTPowerReadyRequired()
  return self._requireNTPowerReady
end

_class("BuffResultAccumulateMarkLayer", BuffResultBase)
BuffResultAccumulateMarkLayer = BuffResultAccumulateMarkLayer

function BuffResultAccumulateMarkLayer:Constructor(attackerID, defenderID, attackPos, layer)
  self._attackerID = attackerID
  self._defenderID = defenderID
  self._attackPos = attackPos
  self._layer = layer
end

function BuffResultAccumulateMarkLayer:GetAttackerID()
  return self._attackerID
end

function BuffResultAccumulateMarkLayer:GetDefenderID()
  return self._defenderID
end

function BuffResultAccumulateMarkLayer:GetAttackPos()
  return self._attackPos
end

function BuffResultAccumulateMarkLayer:GetLayer()
  return self._layer
end

_class("BuffResultAccumulateSoulAddDamage", BuffResultBase)
BuffResultAccumulateSoulAddDamage = BuffResultAccumulateSoulAddDamage

function BuffResultAccumulateSoulAddDamage:Constructor(layer)
  self._layer = layer
end

function BuffResultAccumulateSoulAddDamage:GetLayer()
  return self._layer
end

_class("BuffResultAddLayer", BuffResultBase)
BuffResultAddLayer = BuffResultAddLayer

function BuffResultAddLayer:Constructor(layer, donotDisplay, casterEntity)
  self._layer = layer
  self._donotDisplay = donotDisplay
  self._casterEntity = casterEntity
  self._totalLayerCount = 0
end

function BuffResultAddLayer:SetTotalLayer(layer)
  self._totalLayerCount = layer
end

function BuffResultAddLayer:GetTotalLayer()
  return self._totalLayerCount
end

function BuffResultAddLayer:GetLayer()
  return self._layer
end

function BuffResultAddLayer:GetDonotDisplay()
  return self._donotDisplay
end

function BuffResultAddLayer:SetTriggerPos(v)
  self._triggerPos = v
end

function BuffResultAddLayer:GetTriggerPos()
  return self._triggerPos
end

function BuffResultAddLayer:GetCasterEntity()
  return self._casterEntity
end

function BuffResultAddLayer:SetNotifyLayerChange_Entity(e)
  self._setNotifyLayerChange_entity = e
end

function BuffResultAddLayer:SetNotifyLayerChange_TotalLayer(n)
  self._setNotifyLayerChange_totalLayer = n
end

function BuffResultAddLayer:GetNotifyLayerChange_Entity()
  return self._setNotifyLayerChange_entity
end

function BuffResultAddLayer:GetNotifyLayerChange_TotalLayer()
  return self._setNotifyLayerChange_totalLayer
end

function BuffResultAddLayer:SetBuffSeq(buffSeq)
  self._buffSeq = buffSeq
end

function BuffResultAddLayer:GetBuffSeq()
  return self._buffSeq
end

function BuffResultAddLayer:SetNotifyEntityID(id)
  self._notifyEntityID = id
end

function BuffResultAddLayer:GetNotifyEntityID()
  return self._notifyEntityID
end

_class("BuffResultAddPetHpAtkDef", BuffResultBase)
BuffResultAddPetHpAtkDef = BuffResultAddPetHpAtkDef

function BuffResultAddPetHpAtkDef:Constructor(hp, atk, def, damageInfo)
  self._hp = hp
  self._damageInfo = damageInfo
  self._atk = atk
  self._def = def
end

function BuffResultAddPetHpAtkDef:GetAddHP()
  return self._hp
end

function BuffResultAddPetHpAtkDef:GetAddAtk()
  return self._atk
end

function BuffResultAddPetHpAtkDef:GetAddDef()
  return self._def
end

function BuffResultAddPetHpAtkDef:GetDamageInfo()
  return self._damageInfo
end

_class("BuffResultChangeDefenceByCaster", BuffResultBase)
BuffResultChangeDefenceByCaster = BuffResultChangeDefenceByCaster

function BuffResultChangeDefenceByCaster:Constructor(eid, light)
  self._casterID = eid
  self._light = light
end

function BuffResultChangeDefenceByCaster:GetEntityID()
  return self._casterID
end

function BuffResultChangeDefenceByCaster:ShowLight()
  return self._light
end

_class("BuffResultUndoChangeDefenceByCaster", BuffResultBase)
BuffResultUndoChangeDefenceByCaster = BuffResultUndoChangeDefenceByCaster

function BuffResultUndoChangeDefenceByCaster:Constructor(eid, black)
  self._casterID = eid
  self._black = black
end

function BuffResultUndoChangeDefenceByCaster:GetEntityID()
  return self._casterID
end

function BuffResultUndoChangeDefenceByCaster:ShowBlack()
  return self._black
end

_class("BuffResultBuffEffectTrigger", BuffResultBase)
BuffResultBuffEffectTrigger = BuffResultBuffEffectTrigger

function BuffResultBuffEffectTrigger:Constructor(buffCnt, success)
  self._buffCount = buffCnt
  self._success = success
end

function BuffResultBuffEffectTrigger:GetBuffCount()
  return self._buffCount
end

function BuffResultBuffEffectTrigger:GetSuccess()
  return self._success
end

_class("BuffResultDamage", BuffResultBase)
BuffResultDamage = BuffResultDamage

function BuffResultDamage:Constructor(damageInfo)
  self._damageInfo = damageInfo
end

function BuffResultDamage:GetDamageInfo()
  return self._damageInfo
end

function BuffResultDamage:GetWalkPos()
  return self._walkPos
end

function BuffResultDamage:SetWalkPos(walkPos)
  self._walkPos = walkPos
end

function BuffResultDamage:GetEndPos()
  return self._endPos
end

function BuffResultDamage:SetEndPos(endPos)
  self._endPos = endPos
end

function BuffResultDamage:SetAttackID(entityID)
  self._attackID = entityID
end

function BuffResultDamage:GetAttackID()
  return self._attackID
end

_class("BuffResultExplode", BuffResultBase)
BuffResultExplode = BuffResultExplode

function BuffResultExplode:Constructor(combo, damageInfo)
  self._combo = combo
  self._damageInfo = damageInfo
end

function BuffResultExplode:GetCombo()
  return self._combo
end

function BuffResultExplode:GetDamageInfo()
  return self._damageInfo
end

_class("BuffResultAddPoison", BuffResultBase)
BuffResultAddPoison = BuffResultAddPoison

function BuffResultAddPoison:Constructor(damageInfo, recoverDamageInfo)
  self._damageInfo = damageInfo
  self._recoverDamageInfo = recoverDamageInfo
end

function BuffResultAddPoison:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddPoison:GetRecoverDamageInfo()
  return self._recoverDamageInfo
end

_class("BuffResultPlayEffect", BuffResultBase)
BuffResultPlayEffect = BuffResultPlayEffect

function BuffResultPlayEffect:Constructor(effid)
  self._effectID = effid
end

function BuffResultPlayEffect:GetEffectID()
  return self._effectID
end

_class("BuffResultAddHPByLayerMark", BuffResultBase)
BuffResultAddHPByLayerMark = BuffResultAddHPByLayerMark

function BuffResultAddHPByLayerMark:Constructor(damageInfo, eid)
  self._damageInfo = damageInfo
  self._entityID = eid
end

function BuffResultAddHPByLayerMark:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddHPByLayerMark:GetEntityID()
  return self._entityID
end

_class("BuffResultAddHPComplex", BuffResultBase)
BuffResultAddHPComplex = BuffResultAddHPComplex

function BuffResultAddHPComplex:Constructor(damageInfo, headout, delay)
  self._damageInfo = damageInfo
  self._headout = headout
  self._delay = delay
end

function BuffResultAddHPComplex:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddHPComplex:GetHeadout()
  return self._headout
end

function BuffResultAddHPComplex:GetDelay()
  return self._delay
end

function BuffResultAddHPComplex:SetLayerName(layerName)
  self._layerName = layerName
end

function BuffResultAddHPComplex:GetLayerName()
  return self._layerName
end

function BuffResultAddHPComplex:SetLayerTotalCount(layer)
  self._layerTotalCount = layer
end

function BuffResultAddHPComplex:GetLayerTotalCount()
  return self._layerTotalCount
end

_class("BuffResultLayer", BuffResultBase)
BuffResultLayer = BuffResultLayer

function BuffResultLayer:Constructor(layer, buffseq, addLayer, layerType)
  self._layer = layer
  self._buffseq = buffseq
  self._addLayer = addLayer
  self._layerType = layerType
end

function BuffResultLayer:GetLayerType()
  return self._layerType
end

function BuffResultLayer:GetLayer()
  return self._layer
end

function BuffResultLayer:GetAddLayer()
  return self._addLayer
end

function BuffResultLayer:GetBuffSeq()
  return self._buffseq
end

function BuffResultLayer:SetMovePos(pos)
  self._movePos = pos
end

function BuffResultLayer:GetMovePos()
  return self._movePos
end

function BuffResultLayer:SetHighFrequencyDamageIndex(idx)
  self._highFrequencyDamageIndex = idx
end

function BuffResultLayer:GetHighFrequencyDamageIndex()
  return self._highFrequencyDamageIndex
end

function BuffResultLayer:SetDontDisplay(b)
  self._dontDisplay = b
end

function BuffResultLayer:IsDontDisplay()
  return self._dontDisplay
end

function BuffResultLayer:SetEntityID(eid)
  self._entityID = eid
end

function BuffResultLayer:GetEntityID()
  return self._entityID
end

function BuffResultLayer:SetTriggerPos(v)
  self._triggerPos = v
end

function BuffResultLayer:GetTriggerPos()
  return self._triggerPos
end

function BuffResultLayer:SetFinalLayer(v)
  self._finalLayer = v
end

function BuffResultLayer:GetFinalLayer()
  return self._finalLayer
end

function BuffResultLayer:SetNotifyLayerChange_Entity(e)
  self._setNotifyLayerChange_entity = e
end

function BuffResultLayer:SetNotifyLayerChange_TotalLayer(n)
  self._setNotifyLayerChange_totalLayer = n
end

function BuffResultLayer:GetNotifyLayerChange_Entity()
  return self._setNotifyLayerChange_entity
end

function BuffResultLayer:GetNotifyLayerChange_TotalLayer()
  return self._setNotifyLayerChange_totalLayer
end

function BuffResultLayer:SetDamageStageIndex(index)
  self._damageStageIndex = index
end

function BuffResultLayer:GetDamageStageIndex()
  return self._damageStageIndex
end

function BuffResultLayer:SetCurSkillDamageIndex(val)
  self._curSkillDamageIndex = val
end

function BuffResultLayer:GetCurSkillDamageIndex()
  return self._curSkillDamageIndex
end

function BuffResultLayer:SetLevelTotalRoundCount(val)
  self._levelTotalRoundCount = val
end

function BuffResultLayer:GetLevelTotalRoundCount()
  return self._levelTotalRoundCount
end

function BuffResultLayer:SetOverflowLayer(count)
  self._overflowLayer = count
end

function BuffResultLayer:GetOverflowLayer()
  return self._overflowLayer or 0
end

_class("BuffResultClearLayer", BuffResultBase)
BuffResultClearLayer = BuffResultClearLayer

function BuffResultClearLayer:Constructor(layer, donotDisplay, ownerEntityID, layerType, isUnload, targetBuffSeq)
  self._layer = layer
  self._donotDisplay = donotDisplay
  self._ownerEntityID = ownerEntityID
  self._layerType = layerType
  self._isUnload = isUnload
  self._targetBuffSeq = targetBuffSeq
end

function BuffResultClearLayer:SetChangeLayer(layer)
  self._changeLayer = layer
end

function BuffResultClearLayer:GetChangeLayer()
  return self._changeLayer
end

function BuffResultClearLayer:GetLayer()
  return self._layer
end

function BuffResultClearLayer:GetDonotDisplay()
  return self._donotDisplay
end

function BuffResultClearLayer:GetOwnerEntityID()
  return self._ownerEntityID
end

function BuffResultClearLayer:GetLayerType()
  return self._layerType
end

function BuffResultClearLayer:GetIsUnload()
  return self._isUnload
end

function BuffResultClearLayer:GetTargetBuffSeq()
  return self._targetBuffSeq
end

function BuffResultClearLayer:SetTotalLayer(n)
  if 100 < n then
    Log.error()
  end
  self._totalLayerCount = n
end

function BuffResultClearLayer:GetTotalLayer()
  return self._totalLayerCount
end

function BuffResultClearLayer:SetTriggerPos(v)
  self._triggerPos = v
end

function BuffResultClearLayer:GetTriggerPos()
  return self._triggerPos
end

function BuffResultClearLayer:SetMovePos(pos)
  self._movePos = pos
end

function BuffResultClearLayer:GetMovePos()
  return self._movePos
end

function BuffResultClearLayer:SetLayer(layer)
  self._layer = layer
end

function BuffResultClearLayer:GetLayer()
  return self._layer
end

function BuffResultClearLayer:SetEntityID(eid)
  self._entityID = eid
end

function BuffResultClearLayer:GetEntityID()
  return self._entityID
end

_class("BuffResultLayerMark", BuffResultBase)
BuffResultLayerMark = BuffResultLayerMark

function BuffResultLayerMark:Constructor(layer, eid)
  self._layer = layer
  self._casterID = eid
end

function BuffResultLayerMark:GetLayer()
  return self._layer
end

function BuffResultLayerMark:GetEntityID()
  return self._casterID
end

_class("BuffResultCastSkillWithChainCount", BuffResultBase)
BuffResultCastSkillWithChainCount = BuffResultCastSkillWithChainCount

function BuffResultCastSkillWithChainCount:Constructor(eid)
  self._entityID = eid
end

function BuffResultCastSkillWithChainCount:GetEntityID()
  return self._entityID
end

_class("BuffResultCastSkillWithAttribute", BuffResultBase)
BuffResultCastSkillWithAttribute = BuffResultCastSkillWithAttribute

function BuffResultCastSkillWithAttribute:Constructor(skillID, skillHolderID, skillResult)
  self._skillID = skillID
  self._skillHolderID = skillHolderID
  self._skillResult = skillResult
end

function BuffResultCastSkillWithAttribute:GetSkillID()
  return self._skillID
end

function BuffResultCastSkillWithAttribute:GetSkillHolderID()
  return self._skillHolderID
end

function BuffResultCastSkillWithAttribute:GetSkillResult()
  return self._skillResult
end

_class("BuffResultCastSkill_ByAction", BuffResultBase)
BuffResultCastSkill_ByAction = BuffResultCastSkill_ByAction

function BuffResultCastSkill_ByAction:Constructor(skillID, skillResult)
  self._skillID = skillID
  self._skillResult = skillResult
end

function BuffResultCastSkill_ByAction:GetSkillID()
  return self._skillID
end

function BuffResultCastSkill_ByAction:GetSkillResult()
  return self._skillResult
end

_class("BuffResultAddHPMax", BuffResultBase)
BuffResultAddHPMax = BuffResultAddHPMax

function BuffResultAddHPMax:Constructor(entityID, damageInfo, maxHPResult, displayDamage, notAddHP)
  self._entityID = entityID
  self._damageInfo = damageInfo
  self._maxHPResult = maxHPResult
  self._displayDamage = displayDamage
  self._notAddHP = notAddHP
end

function BuffResultAddHPMax:GetEntityID()
  return self._entityID
end

function BuffResultAddHPMax:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddHPMax:GetDisplayDamage()
  return self._displayDamage
end

function BuffResultAddHPMax:GetMaxHPResult()
  return self._maxHPResult
end

function BuffResultAddHPMax:GetNotAddHP()
  return self._notAddHP
end

_class("BuffResultTransferCasterLayerShieldToTarget", BuffResultBase)
BuffResultTransferCasterLayerShieldToTarget = BuffResultTransferCasterLayerShieldToTarget

function BuffResultTransferCasterLayerShieldToTarget:Constructor(casterID, targetID, targetNewLayer)
  self._casterID = casterID
  self._targetID = targetID
  self._targetNewLayer = targetNewLayer
end

function BuffResultTransferCasterLayerShieldToTarget:GetCasterID()
  return self._casterID
end

function BuffResultTransferCasterLayerShieldToTarget:GetTargetID()
  return self._targetID
end

function BuffResultTransferCasterLayerShieldToTarget:GetTargetNewLayer()
  return self._targetNewLayer
end

_class("BuffResultAddSkillIncreaseByAttack", BuffResultBase)
BuffResultAddSkillIncreaseByAttack = BuffResultAddSkillIncreaseByAttack

function BuffResultAddSkillIncreaseByAttack:Constructor(layer)
  self._layer = layer
end

function BuffResultAddSkillIncreaseByAttack:GetLayer()
  return self._layer
end

_class("BuffResultAddHP", BuffResultBase)
BuffResultAddHP = BuffResultAddHP

function BuffResultAddHP:Constructor(damageInfo)
  self._damageInfo = damageInfo
end

function BuffResultAddHP:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddHP:SetNotifyAttackerPos(pos)
  self._attackerPos = pos
end

function BuffResultAddHP:SetNotifyDefenderPos(pos)
  self._defenderPos = pos
end

function BuffResultAddHP:SetNotifyAttackerID(eid)
  self._attackerID = eid
end

function BuffResultAddHP:SetNotifyDefenderID(eid)
  self._defenderID = eid
end

function BuffResultAddHP:SetMatchPass(matchPass)
  self._matchPass = matchPass
end

function BuffResultAddHP:SetNotifyEntityID(id)
  self._notifyEntityID = id
end

function BuffResultAddHP:SetNotifyPos(pos)
  self._notifyPos = pos
end

function BuffResultAddHP:GetNotifyPos()
  return self._notifyPos
end

function BuffResultAddHP:GetNotifyEntityID()
  return self._notifyEntityID
end

function BuffResultAddHP:GetNotifyAttackerPos()
  return self._attackerPos
end

function BuffResultAddHP:GetNotifyDefenderPos()
  return self._defenderPos
end

function BuffResultAddHP:GetNotifyAttackerID()
  return self._attackerID
end

function BuffResultAddHP:GetNotifyDefenderID()
  return self._defenderID
end

function BuffResultAddHP:GetMatchPass()
  return self._matchPass
end

_class("BuffResultChangeActivatePassive", BuffResultBase)
BuffResultChangeActivatePassive = BuffResultChangeActivatePassive

function BuffResultChangeActivatePassive:Constructor(light, forceInit, forceInitType)
  self.light = light
  self.forceInit = forceInit
  self.forceInitType = forceInitType
end

function BuffResultChangeActivatePassive:GetLight()
  return self.light
end

function BuffResultChangeActivatePassive:GetForceInit()
  return self.forceInit
end

function BuffResultChangeActivatePassive:GetForceInitType()
  return self.forceInitType
end

function BuffResultChangeActivatePassive:SetTotalLayer(n)
  self._totalLayerCount = n
end

function BuffResultChangeActivatePassive:GetTotalLayer()
  return self._totalLayerCount
end

function BuffResultChangeActivatePassive:SetLayer(n)
  self._layerCount = n
end

function BuffResultChangeActivatePassive:GetLayer()
  return self._layerCount
end

function BuffResultChangeActivatePassive:SetLayerName(layerName)
  self._layerName = layerName
end

function BuffResultChangeActivatePassive:GetLayerName()
  return self._layerName
end

_class("BuffResultReflexiveDamage", BuffResultBase)
BuffResultReflexiveDamage = BuffResultReflexiveDamage

function BuffResultReflexiveDamage:Constructor(attackerId, attackPos, damageInfo, layer)
  self._originalAttackId = attackerId
  self._defenderID = attackerId
  self._attackPos = attackPos
  self._damageInfo = damageInfo
  self._layer = layer
  self._skillHolderID = nil
end

function BuffResultReflexiveDamage:GetOriginalAttackerID()
  return self._originalAttackId
end

function BuffResultReflexiveDamage:GetDefenderID()
  return self._defenderID
end

function BuffResultReflexiveDamage:GetAttackPos()
  return self._attackPos
end

function BuffResultReflexiveDamage:GetDamageInfo()
  return self._damageInfo
end

function BuffResultReflexiveDamage:GetLayer()
  return self._layer
end

function BuffResultReflexiveDamage:SetSkillHolderID(skillHolderID)
  self._skillHolderID = skillHolderID
end

function BuffResultReflexiveDamage:GetSkillHolderID()
  return self._skillHolderID
end

function BuffResultReflexiveDamage:SetSkillID(skillID)
  self._skillID = skillID
end

function BuffResultReflexiveDamage:GetSkillID()
  return self._skillID
end

function BuffResultReflexiveDamage:SetCurSkillDamageIndex(val)
  self._curSkillDamageIndex = val
end

function BuffResultReflexiveDamage:GetCurSkillDamageIndex()
  return self._curSkillDamageIndex
end

_class("BuffResultDoIncreaseActiveSkillAtk", BuffResultBase)
BuffResultDoIncreaseActiveSkillAtk = BuffResultDoIncreaseActiveSkillAtk

function BuffResultDoIncreaseActiveSkillAtk:Constructor(light, layer)
  self._light = light
  self._layer = layer
end

function BuffResultDoIncreaseActiveSkillAtk:GetLight()
  return self._light
end

function BuffResultDoIncreaseActiveSkillAtk:GetLayer()
  return self._layer
end

_class("BuffResultUndoIncreaseActiveSkillAtk", BuffResultBase)
BuffResultUndoIncreaseActiveSkillAtk = BuffResultUndoIncreaseActiveSkillAtk

function BuffResultUndoIncreaseActiveSkillAtk:Constructor(dark)
  self._dark = dark
end

function BuffResultUndoIncreaseActiveSkillAtk:GetDark()
  return self._dark
end

_class("BuffResultRecoveryOnLostHP", BuffResultBase)
BuffResultRecoveryOnLostHP = BuffResultRecoveryOnLostHP

function BuffResultRecoveryOnLostHP:Constructor(damageInfo)
  self._damageInfo = damageInfo
end

function BuffResultRecoveryOnLostHP:GetDamageInfo()
  return self._damageInfo
end

_class("BuffResultShieldToAtk", BuffResultBase)
BuffResultShieldToAtk = BuffResultShieldToAtk

function BuffResultShieldToAtk:Constructor(addAttack)
  self._addAttack = addAttack
end

function BuffResultShieldToAtk:GetAddAttack()
  return self._addAttack
end

_class("BuffResultShieldToHP", BuffResultBase)
BuffResultShieldToHP = BuffResultShieldToHP

function BuffResultShieldToHP:Constructor(addHP, damageInfo, shield)
  self._addHP = addHP
  self._damageInfo = damageInfo
  self._curShield = shield
end

function BuffResultShieldToHP:GetAddHP()
  return self._addHP
end

function BuffResultShieldToHP:GetDamageInfo()
  return self._damageInfo
end

function BuffResultShieldToHP:GetShieldToHp_CurShield()
  return self._curShield
end

_class("BuffResultShowBossHp", BuffResultBase)
BuffResultShowBossHp = BuffResultShowBossHp

function BuffResultShowBossHp:Constructor(entityId)
  self._entityID = entityId
end

function BuffResultShowBossHp:GetEntityID()
  return self._entityID
end

_class("BuffResultChangeAttack", BuffResultBase)
BuffResultChangeAttack = BuffResultChangeAttack

function BuffResultChangeAttack:Constructor(casterID, addValue, isLight)
  self._casterID = casterID
  self._addValue = addValue
  self._isLight = isLight
end

function BuffResultChangeAttack:GetEntityID()
  return self._casterID
end

function BuffResultChangeAttack:GetAddValue()
  return self._addValue
end

function BuffResultChangeAttack:GetIsLight()
  return self._isLight
end

_class("BuffResultChangeAttackUndo", BuffResultBase)
BuffResultChangeAttackUndo = BuffResultChangeAttackUndo

function BuffResultChangeAttackUndo:Constructor(casterID, casterBlack, isBlack)
  self._casterID = casterID
  self._casterBlack = casterBlack
  self._isBlack = isBlack
end

function BuffResultChangeAttackUndo:GetCasterID()
  return self._casterID
end

function BuffResultChangeAttackUndo:GetCasterBlack()
  return self._casterBlack
end

function BuffResultChangeAttackUndo:GetIsBlack()
  return self._isBlack
end

_class("BuffResultChangeAttackByCasterLayer", BuffResultBase)
BuffResultChangeAttackByCasterLayer = BuffResultChangeAttackByCasterLayer

function BuffResultChangeAttackByCasterLayer:Constructor(casterID, val)
  self._casterID = casterID
  self._val = val
end

function BuffResultChangeAttackByCasterLayer:GetCasterID()
  return self._casterID
end

function BuffResultChangeAttackByCasterLayer:GetValue()
  return self._val
end

_class("BuffResultUndoChangeAttackByCasterLayer", BuffResultBase)
BuffResultUndoChangeAttackByCasterLayer = BuffResultUndoChangeAttackByCasterLayer

function BuffResultUndoChangeAttackByCasterLayer:Constructor(casterID)
  self._casterID = casterID
end

function BuffResultUndoChangeAttackByCasterLayer:GetCasterID()
  return self._casterID
end

_class("BuffResultChangeAttackByCaster", BuffResultBase)
BuffResultChangeAttackByCaster = BuffResultChangeAttackByCaster

function BuffResultChangeAttackByCaster:Constructor(casterID, val, light, pstid, casterPstID)
  self._casterID = casterID
  self._val = val
  self._light = light
  self._pstid = pstid
  self._casterPstID = casterPstID
end

function BuffResultChangeAttackByCaster:GetCasterID()
  return self._casterID
end

function BuffResultChangeAttackByCaster:GetValue()
  return self._val
end

function BuffResultChangeAttackByCaster:GetLight()
  return self._light
end

function BuffResultChangeAttackByCaster:GetPstID()
  return self._pstid
end

function BuffResultChangeAttackByCaster:GetCasterPstID()
  return self._casterPstID
end

_class("BuffResultUndoChangeAttackByCaster", BuffResultBase)
BuffResultUndoChangeAttackByCaster = BuffResultUndoChangeAttackByCaster

function BuffResultUndoChangeAttackByCaster:Constructor(black, casterPstID)
  self._casterPstID = casterPstID
  self._black = black
end

function BuffResultUndoChangeAttackByCaster:GetBlack()
  return self._black
end

function BuffResultUndoChangeAttackByCaster:GetCasterPstID()
  return self._casterPstID
end

_class("BuffResultChangeAttackSkill", BuffResultBase)
BuffResultChangeAttackSkill = BuffResultChangeAttackSkill

function BuffResultChangeAttackSkill:Constructor(trapCasterID)
  self._trapCasterID = trapCasterID
end

function BuffResultChangeAttackSkill:GetTrapCasterID()
  return self._trapCasterID
end

_class("BuffResultChangeDefence", BuffResultBase)
BuffResultChangeDefence = BuffResultChangeDefence

function BuffResultChangeDefence:Constructor(changeType, val, entityID, light)
  self._changeType = changeType
  self._entityID = entityID
  self._light = light
  self._val = val
end

function BuffResultChangeDefence:GetChangeType()
  return self._changeType
end

function BuffResultChangeDefence:GetEntityID()
  return self._entityID
end

function BuffResultChangeDefence:GetLight()
  return self._light
end

function BuffResultChangeDefence:GetValue()
  return self._val
end

_class("BuffResultChangeDefenceUndo", BuffResultBase)
BuffResultChangeDefenceUndo = BuffResultChangeDefenceUndo

function BuffResultChangeDefenceUndo:Constructor(black)
  self._black = black
end

function BuffResultChangeDefenceUndo:GetBlack()
  return self._black
end

_class("BuffResultChangePetActiveSkill", BuffResultBase)
BuffResultChangePetActiveSkill = BuffResultChangePetActiveSkill

function BuffResultChangePetActiveSkill:Constructor(layer, skillID)
  self._layer = layer
  self._skillID = skillID
end

function BuffResultChangePetActiveSkill:GetLayer()
  return self._layer
end

function BuffResultChangePetActiveSkill:GetSkillID()
  return self._skillID
end

_class("BuffResultChangePetExtraActiveSkill", BuffResultBase)
BuffResultChangePetExtraActiveSkill = BuffResultChangePetExtraActiveSkill

function BuffResultChangePetExtraActiveSkill:Constructor(ordSkillID, newSkillID)
  self._ordSkillID = ordSkillID
  self._newSkillID = newSkillID
end

function BuffResultChangePetExtraActiveSkill:GetOriSkillID()
  return self._ordSkillID
end

function BuffResultChangePetExtraActiveSkill:GetNewSkillID()
  return self._newSkillID
end

_class("BuffResultChangePetLegendPower", BuffResultBase)
BuffResultChangePetLegendPower = BuffResultChangePetLegendPower

function BuffResultChangePetLegendPower:Constructor(petPowerList)
  self._petPowerList = petPowerList
end

function BuffResultChangePetLegendPower:GetPetPowerList()
  return self._petPowerList
end

_class("BuffResultChangePetLegendPowerWithChainCount", BuffResultBase)
BuffResultChangePetLegendPowerWithChainCount = BuffResultChangePetLegendPowerWithChainCount

function BuffResultChangePetLegendPowerWithChainCount:Constructor(petPowerList)
  self._petPowerList = petPowerList
end

function BuffResultChangePetLegendPowerWithChainCount:GetPetPowerList()
  return self._petPowerList
end

_class("BuffResultChangePetPower", BuffResultBase)
BuffResultChangePetPower = BuffResultChangePetPower

function BuffResultChangePetPower:Constructor(petPowerList, notifyView)
  self._petPowerList = petPowerList
  self._notifyView = notifyView
end

function BuffResultChangePetPower:GetPetPowerList()
  return self._petPowerList
end

function BuffResultChangePetPower:GetNotifyView()
  return self._notifyView
end

_class("BuffResultChangePetPowerForExtraSkill", BuffResultBase)
BuffResultChangePetPowerForExtraSkill = BuffResultChangePetPowerForExtraSkill

function BuffResultChangePetPowerForExtraSkill:Constructor(petPowerList, notifyView)
  self._petPowerList = petPowerList
  self._notifyView = notifyView
end

function BuffResultChangePetPowerForExtraSkill:GetPetPowerList()
  return self._petPowerList
end

function BuffResultChangePetPowerForExtraSkill:GetNotifyView()
  return self._notifyView
end

_class("BuffResultChangePetPowerForOverdraw", BuffResultBase)
BuffResultChangePetPowerForOverdraw = BuffResultChangePetPowerForOverdraw

function BuffResultChangePetPowerForOverdraw:Constructor(petPowerList, notifyView)
  self._petPowerList = petPowerList
  self._notifyView = notifyView
end

function BuffResultChangePetPowerForOverdraw:GetPetPowerList()
  return self._petPowerList
end

function BuffResultChangePetPowerForOverdraw:GetNotifyView()
  return self._notifyView
end

_class("BuffResultRecordPetPowerAndWatch", BuffResultBase)
BuffResultRecordPetPowerAndWatch = BuffResultRecordPetPowerAndWatch

function BuffResultRecordPetPowerAndWatch:Constructor(entityID, petPstID, power, ready, grayWatch, notifyView)
  self._entityID = entityID
  self._petPstID = petPstID
  self._power = power
  self._ready = ready
  self._grayWatch = grayWatch
  self._notifyView = notifyView
end

function BuffResultRecordPetPowerAndWatch:GetEntityID()
  return self._entityID
end

function BuffResultRecordPetPowerAndWatch:GetPetPstID()
  return self._petPstID
end

function BuffResultRecordPetPowerAndWatch:GetPower()
  return self._power
end

function BuffResultRecordPetPowerAndWatch:GetReady()
  return self._ready
end

function BuffResultRecordPetPowerAndWatch:GetGrayWatch()
  return self._grayWatch
end

function BuffResultRecordPetPowerAndWatch:GetNotifyView()
  return self._notifyView
end

_class("BuffResultChangePetPowerOverdraw", BuffResultBase)
BuffResultChangePetPowerOverdraw = BuffResultChangePetPowerOverdraw

function BuffResultChangePetPowerOverdraw:Constructor(ready, overdraw)
  self._ready = ready
  self._overdraw = overdraw
end

function BuffResultChangePetPowerOverdraw:GetReady()
  return self._ready
end

function BuffResultChangePetPowerOverdraw:GetOverdraw()
  return self._overdraw
end

_class("BuffResultShowPetPowerOverdraw", BuffResultBase)
BuffResultShowPetPowerOverdraw = BuffResultShowPetPowerOverdraw

function BuffResultShowPetPowerOverdraw:Constructor(ready, overdraw)
  self._ready = ready
  self._overdraw = overdraw
end

function BuffResultShowPetPowerOverdraw:GetReady()
  return self._ready
end

function BuffResultShowPetPowerOverdraw:GetOverdraw()
  return self._overdraw
end

_class("BuffResultChangeShaderValue", BuffResultBase)
BuffResultChangeShaderValue = BuffResultChangeShaderValue

function BuffResultChangeShaderValue:Constructor(root, param, blood)
  self._root = root
  self._blood = blood
  self._param = param
end

function BuffResultChangeShaderValue:GetRoot()
  return self._root
end

function BuffResultChangeShaderValue:GetBlood()
  return self._blood
end

function BuffResultChangeShaderValue:GetParam()
  return self._param
end

_class("BuffResultChangeSkillIncrease", BuffResultBase)
BuffResultChangeSkillIncrease = BuffResultChangeSkillIncrease

function BuffResultChangeSkillIncrease:Constructor(light)
  self._light = light
end

function BuffResultChangeSkillIncrease:GetLight()
  return self._light
end

_class("BuffResultRemoveSkillIncrease", BuffResultBase)
BuffResultRemoveSkillIncrease = BuffResultRemoveSkillIncrease

function BuffResultRemoveSkillIncrease:Constructor(black)
  self._black = black
end

function BuffResultRemoveSkillIncrease:GetBlack()
  return self._black
end

_class("BuffResultCreateSkillHolder", BuffResultBase)
BuffResultCreateSkillHolder = BuffResultCreateSkillHolder

function BuffResultCreateSkillHolder:Constructor(skillHolderID)
  self._skillHolderID = skillHolderID
end

function BuffResultCreateSkillHolder:GetSkillHolderID()
  return self._skillHolderID
end

function BuffResultCreateSkillHolder:SetAbsolutePositionMode(v)
  self._absolutePositionMode = v
end

function BuffResultCreateSkillHolder:GetAbsolutePositionMode()
  return self._absolutePositionMode
end

function BuffResultCreateSkillHolder:SetHideOnDefault(v)
  self._hideOnDefault = v
end

function BuffResultCreateSkillHolder:GetHideOnDefault()
  return self._hideOnDefault
end

_class("BuffResultCreateTrap", BuffResultBase)
BuffResultCreateTrap = BuffResultCreateTrap

function BuffResultCreateTrap:Constructor(eIds, pos)
  self._eIds = eIds
  self._pos = pos
end

function BuffResultCreateTrap:GetEntityIds()
  return self._eIds
end

function BuffResultCreateTrap:GetPos()
  return self._pos
end

_class("BuffResultCreateTrapWithChainScope", BuffResultBase)
BuffResultCreateTrapWithChainScope = BuffResultCreateTrapWithChainScope

function BuffResultCreateTrapWithChainScope:Constructor(eIds)
  self._eIds = eIds
  self._trapSkillResults = {}
end

function BuffResultCreateTrapWithChainScope:GetEntityIds()
  return self._eIds
end

function BuffResultCreateTrapWithChainScope:AddTrapSkillResult(trapId, skillResult, triggerId)
  table.insert(self._trapSkillResults, {
    trapId,
    skillResult,
    triggerId
  })
end

function BuffResultCreateTrapWithChainScope:GetTrapSkillResults()
  return self._trapSkillResults
end

_class("BuffResultDeathInstant", BuffResultBase)
BuffResultDeathInstant = BuffResultDeathInstant

function BuffResultDeathInstant:Constructor(casterID, isDead)
  self._casterID = casterID
  self._isDead = isDead
end

function BuffResultDeathInstant:GetCasterID()
  return self._casterID
end

function BuffResultDeathInstant:GetIsDead()
  return self._isDead
end

_class("BuffResultDeathToDeath", BuffResultBase)
BuffResultDeathToDeath = BuffResultDeathToDeath

function BuffResultDeathToDeath:Constructor(entityID, skillID, skillResult)
  self._entityID = entityID
  self._skillID = skillID
  self._skillResult = skillResult
end

function BuffResultDeathToDeath:GetEntityID()
  return self._entityID
end

function BuffResultDeathToDeath:GetSkillID()
  return self._skillID
end

function BuffResultDeathToDeath:GetSkillResult()
  return self._skillResult
end

_class("BuffResultHarmReduction", BuffResultBase)
BuffResultHarmReduction = BuffResultHarmReduction

function BuffResultHarmReduction:Constructor(layer, lines, harmReduction, previewSkillID, previewSkillHolder, uiText)
  self._layer = layer
  self._lines = lines
  self._harmReduction = harmReduction
  self._previewSkillID = previewSkillID
  self._previewSkillHolder = previewSkillHolder
  self._uiText = uiText
end

function BuffResultHarmReduction:GetLayer()
  return self._layer
end

function BuffResultHarmReduction:GetLines()
  return self._lines
end

function BuffResultHarmReduction:GetHarmReduction()
  return self._harmReduction
end

function BuffResultHarmReduction:GetPreviewSkillID()
  return self._previewSkillID
end

function BuffResultHarmReduction:GetPreviewSkillHolder()
  return self._previewSkillHolder
end

function BuffResultHarmReduction:GetUIText()
  return self._uiText
end

_class("BuffResultHitBackEndDamage", BuffResultBase)
BuffResultHitBackEndDamage = BuffResultHitBackEndDamage

function BuffResultHitBackEndDamage:Constructor(defenderID, damageInfo)
  self._defenderID = defenderID
  self._damageInfo = damageInfo
end

function BuffResultHitBackEndDamage:GetDefenderID()
  return self._defenderID
end

function BuffResultHitBackEndDamage:GetDamageInfo()
  return self._damageInfo
end

_class("BuffResultAddRecoveryUpByTeam", BuffResultBase)
BuffResultAddRecoveryUpByTeam = BuffResultAddRecoveryUpByTeam

function BuffResultAddRecoveryUpByTeam:Constructor(rate, maxRate, value)
  self._rate = rate
  self._maxRate = maxRate
  self._value = value
end

function BuffResultAddRecoveryUpByTeam:GetRate()
  return self._rate
end

function BuffResultAddRecoveryUpByTeam:GetMaxRate()
  return self._maxRate
end

function BuffResultAddRecoveryUpByTeam:GetValue()
  return self._value
end

_class("BuffResultRefreshGrid", BuffResultBase)
BuffResultRefreshGrid = BuffResultRefreshGrid

function BuffResultRefreshGrid:Constructor(refreshList, target)
  self._refreshList = refreshList
  self._target = target
end

function BuffResultRefreshGrid:GetRefreshList()
  return self._refreshList
end

function BuffResultRefreshGrid:GetTarget()
  return self._target
end

_class("BuffResultResurgence", BuffResultBase)
BuffResultResurgence = BuffResultResurgence

function BuffResultResurgence:Constructor(e, leader, addval, damageInfo, oldTeamOrder, newTeamOrder)
  self._entity = e
  self._leader = leader
  self._addval = addval
  self._damageInfo = damageInfo
  self._oldTeamOrder = oldTeamOrder
  self._newTeamOrder = newTeamOrder
end

function BuffResultResurgence:GetEntity()
  return self._entity
end

function BuffResultResurgence:GetLeader()
  return self._leader
end

function BuffResultResurgence:GetAddValue()
  return self._addval
end

function BuffResultResurgence:GetDamageInfo()
  return self._damageInfo
end

function BuffResultResurgence:GetOldTeamOrder()
  return self._oldTeamOrder
end

function BuffResultResurgence:GetNewTeamOrder()
  return self._newTeamOrder
end

_class("BuffResultShadowChain", BuffResultBase)
BuffResultShadowChain = BuffResultShadowChain

function BuffResultShadowChain:Constructor(shadowEntityID, petPstID, shadowPrefab, shadowCreate, ownerEntityID)
  self._shadowEntityID = shadowEntityID
  self._shadowPrefab = shadowPrefab
  self._shadowCreate = shadowCreate
  self._petPstID = petPstID
  self._ownerEntityID = ownerEntityID
end

function BuffResultShadowChain:GetShadowEntityID()
  return self._shadowEntityID
end

function BuffResultShadowChain:GetShadowPrefab()
  return self._shadowPrefab
end

function BuffResultShadowChain:GetShadowCreate()
  return self._shadowCreate
end

function BuffResultShadowChain:GetPetPstID()
  return self._petPstID
end

function BuffResultShadowChain:GetOwnerEntityID()
  return self._ownerEntityID
end

_class("BuffResultAddDamageShield", BuffResultBase)
BuffResultAddDamageShield = BuffResultAddDamageShield

function BuffResultAddDamageShield:Constructor(shield)
  self._shield = shield
end

function BuffResultAddDamageShield:GetShield()
  return self._shield
end

_class("BuffResultAddHPShieldHpSpilled", BuffResultBase)
BuffResultAddHPShieldHpSpilled = BuffResultAddHPShieldHpSpilled

function BuffResultAddHPShieldHpSpilled:Constructor(seq)
  self._seq = seq
end

function BuffResultAddHPShieldHpSpilled:GetBuffSeq()
  return self._seq
end

_class("BuffResultUpdateLineRenderer", BuffResultBase)
BuffResultUpdateLineRenderer = BuffResultUpdateLineRenderer

function BuffResultUpdateLineRenderer:Constructor(target, current, buffEffect)
  self._target = target
  self._current = current
  self._buffEffect = buffEffect
end

function BuffResultUpdateLineRenderer:GetTarget()
  return self._target
end

function BuffResultUpdateLineRenderer:GetCurrent()
  return self._current
end

function BuffResultUpdateLineRenderer:GetBuffEffect()
  return self._buffEffect
end

_class("BuffResultShowEffectWhenTeamInSkillScope", BuffResultBase)
BuffResultShowEffectWhenTeamInSkillScope = BuffResultShowEffectWhenTeamInSkillScope

function BuffResultShowEffectWhenTeamInSkillScope:Constructor(match, effectId)
  self._match = match
  self._effectId = effectId
end

function BuffResultShowEffectWhenTeamInSkillScope:GetMatch()
  return self._match
end

function BuffResultShowEffectWhenTeamInSkillScope:GetEffectId()
  return self._effectId
end

function BuffResultShowEffectWhenTeamInSkillScope:SetMovePos(pos)
  self._movePos = pos
end

function BuffResultShowEffectWhenTeamInSkillScope:GetMovePos()
  return self._movePos
end

function BuffResultShowEffectWhenTeamInSkillScope:SetBuffID(buffID)
  self._buffID = buffID
end

function BuffResultShowEffectWhenTeamInSkillScope:GetBuffID()
  return self._buffID
end

function BuffResultShowEffectWhenTeamInSkillScope:SetBuffSeq(buffSeq)
  self._buffSeq = buffSeq
end

function BuffResultShowEffectWhenTeamInSkillScope:GetBuffSeq()
  return self._buffSeq or {}
end

_class("BuffResultChangePetChainSkill", BuffResultBase)
BuffResultChangePetChainSkill = BuffResultChangePetChainSkill

function BuffResultChangePetChainSkill:Constructor(light)
  self._light = light
end

function BuffResultChangePetChainSkill:GetLight()
  return self._light
end

_class("BuffResultChangePetChainSkillUndo", BuffResultBase)
BuffResultChangePetChainSkillUndo = BuffResultChangePetChainSkillUndo

function BuffResultChangePetChainSkillUndo:Constructor(black)
  self._black = black
end

function BuffResultChangePetChainSkillUndo:GetBlack()
  return self._black
end

_class("BuffResultAddLegendPowerByMonsterDead", BuffResultBase)
BuffResultAddLegendPowerByMonsterDead = BuffResultAddLegendPowerByMonsterDead

function BuffResultAddLegendPowerByMonsterDead:Constructor(petPstID, newPower, ready)
  self._petPstID = petPstID
  self._newPower = newPower
  self._ready = ready
end

function BuffResultAddLegendPowerByMonsterDead:GetPetPstID()
  return self._petPstID
end

function BuffResultAddLegendPowerByMonsterDead:GetNewPower()
  return self._newPower
end

function BuffResultAddLegendPowerByMonsterDead:GetReady()
  return self._ready
end

function BuffResultAddLegendPowerByMonsterDead:RequireNTPowerReady(petEntityID)
  self._petEntityID = petEntityID
  self._requireNTPowerReady = true
end

function BuffResultAddLegendPowerByMonsterDead:GetPetEntityID()
  return self._petEntityID
end

function BuffResultAddLegendPowerByMonsterDead:IsNTPowerReadyRequired()
  return self._requireNTPowerReady
end

_class("BuffResultDeleteWaringArea", BuffResultBase)
BuffResultDeleteWaringArea = BuffResultDeleteWaringArea

function BuffResultDeleteWaringArea:Constructor(skillHolderID)
  self._skillHolderID = skillHolderID
end

function BuffResultDeleteWaringArea:GetSkillHolderID()
  return self._skillHolderID
end

_class("BuffResultHPBombLayer", BuffResultBase)
BuffResultHPBombLayer = BuffResultHPBombLayer

function BuffResultHPBombLayer:Constructor(entityID, layerCount)
  self._entityID = entityID
  self._layerCount = layerCount
end

function BuffResultHPBombLayer:GetEntityID()
  return self._entityID
end

function BuffResultHPBombLayer:GetLayerCount()
  return self._layerCount
end

_class("BuffResultCastAntiSkill", BuffResultBase)
BuffResultCastAntiSkill = BuffResultCastAntiSkill

function BuffResultCastAntiSkill:Constructor(skillID, skillHolderID, skillResult, startTask)
  self._skillID = skillID
  self._skillHolderID = skillHolderID
  self._skillResult = skillResult
  self._startTask = startTask
end

function BuffResultCastAntiSkill:GetSkillID()
  return self._skillID
end

function BuffResultCastAntiSkill:GetSkillResult()
  return self._skillResult
end

function BuffResultCastAntiSkill:GetStartTask()
  return self._startTask
end

function BuffResultCastAntiSkill:GetSkillHolderID()
  return self._skillHolderID
end

_class("BuffResultUseSaveDamageAdditionalDamage", BuffResultBase)
BuffResultUseSaveDamageAdditionalDamage = BuffResultUseSaveDamageAdditionalDamage

function BuffResultUseSaveDamageAdditionalDamage:Constructor(damageInfo, effectID)
  self._damageInfo = damageInfo
  self._effectID = effectID
end

function BuffResultUseSaveDamageAdditionalDamage:GetDamageInfo()
  return self._damageInfo
end

function BuffResultUseSaveDamageAdditionalDamage:GetEffectID()
  return self._effectID
end

_class("BuffResultChangeTrapPower", BuffResultBase)
BuffResultChangeTrapPower = BuffResultChangeTrapPower

function BuffResultChangeTrapPower:Constructor(entityID, newPower)
  self._entityID = entityID
  self._newPower = newPower
end

function BuffResultChangeTrapPower:GetEntityID()
  return self._entityID
end

function BuffResultChangeTrapPower:GetNewPower()
  return self._newPower
end

_class("BuffResultTransmitDamage", BuffResultBase)
BuffResultTransmitDamage = BuffResultTransmitDamage

function BuffResultTransmitDamage:Constructor(attackerID, transerID, defenderIDs, damageInfos)
  self._originalAttackID = attackerID
  self._transerID = transerID
  self._defenderIDs = defenderIDs
  self._damageInfos = damageInfos
end

function BuffResultTransmitDamage:GetOriginalAttackerID()
  return self._originalAttackID
end

function BuffResultTransmitDamage:GetTranserID()
  return self._transerID
end

function BuffResultTransmitDamage:GetDefenderIDs()
  return self._defenderIDs
end

function BuffResultTransmitDamage:GetDamageInfos()
  return self._damageInfos
end

function BuffResultTransmitDamage:SetAttackPos(attackPos)
  self._attackPos = attackPos
end

function BuffResultTransmitDamage:GetAttackPos()
  return self._attackPos
end

function BuffResultTransmitDamage:SetNotifyHp(notifyHp)
  self._notifyHp = notifyHp
end

function BuffResultTransmitDamage:GetNotifyHp()
  return self._notifyHp
end

_class("BuffResultAddChangeTeamLeaderCount", BuffResultBase)
BuffResultAddChangeTeamLeaderCount = BuffResultAddChangeTeamLeaderCount

function BuffResultAddChangeTeamLeaderCount:Constructor(entityID, newCount)
  self._entityID = entityID
  self._newCount = newCount
end

function BuffResultAddChangeTeamLeaderCount:GetEntityID()
  return self._entityID
end

function BuffResultAddChangeTeamLeaderCount:GetNewCount()
  return self._newCount
end

_class("BuffResultChangeChessPetFinishTurn", BuffResultBase)
BuffResultChangeChessPetFinishTurn = BuffResultChangeChessPetFinishTurn

function BuffResultChangeChessPetFinishTurn:Constructor(entityID, finish)
  self._entityID = entityID
  self._finish = finish
end

function BuffResultChangeChessPetFinishTurn:GetEntityID()
  return self._entityID
end

function BuffResultChangeChessPetFinishTurn:GetFinish()
  return self._finish
end

_class("BuffResultChangePetAndTeamActiveSkill", BuffResultBase)
BuffResultChangePetAndTeamActiveSkill = BuffResultChangePetAndTeamActiveSkill

function BuffResultChangePetAndTeamActiveSkill:Constructor(petPstID, skillID)
  self._skillID = skillID
  self._petPstID = petPstID
end

function BuffResultChangePetAndTeamActiveSkill:GetPetPstID()
  return self._petPstID
end

function BuffResultChangePetAndTeamActiveSkill:GetSkillID()
  return self._skillID
end

_class("BuffResultFeatureDeath", BuffResultBase)
BuffResultFeatureDeath = BuffResultFeatureDeath

function BuffResultFeatureDeath:Constructor(entityID)
  self._entityID = entityID
end

function BuffResultFeatureDeath:GetEntityID()
  return self._entityID
end

_class("BuffResultFillMonsterAntiAttackState", BuffResultBase)
BuffResultFillMonsterAntiAttackState = BuffResultFillMonsterAntiAttackState

function BuffResultFillMonsterAntiAttackState:Constructor(entityID)
  self._entityID = entityID
end

function BuffResultFillMonsterAntiAttackState:GetEntityID()
  return self._entityID
end

_class("BuffResultSetMonsterAntiAttackParam", BuffResultBase)
BuffResultSetMonsterAntiAttackParam = BuffResultSetMonsterAntiAttackParam

function BuffResultSetMonsterAntiAttackParam:Constructor(entityID)
  self._entityID = entityID
end

function BuffResultSetMonsterAntiAttackParam:GetEntityID()
  return self._entityID
end

_class("BuffResultCheckAndCastAntiSkill", BuffResultBase)
BuffResultCheckAndCastAntiSkill = BuffResultCheckAndCastAntiSkill

function BuffResultCheckAndCastAntiSkill:Constructor(entityID)
  self._entityID = entityID
end

function BuffResultCheckAndCastAntiSkill:GetEntityID()
  return self._entityID
end

function BuffResultCheckAndCastAntiSkill:SetSkillResult(result)
  self._skillResult = result
end

function BuffResultCheckAndCastAntiSkill:GetSkillResult()
  return self._skillResult
end

function BuffResultCheckAndCastAntiSkill:SetSkillID(skillID)
  self._skillID = skillID
end

function BuffResultCheckAndCastAntiSkill:GetSkillID()
  return self._skillID
end

function BuffResultCheckAndCastAntiSkill:SetBuffSeq(buffSeq)
  self._buffSeq = buffSeq
end

function BuffResultCheckAndCastAntiSkill:GetBuffSeq()
  return self._buffSeq or {}
end

_class("BuffResultAddLayerByDamageOfTeamHp", BuffResultBase)
BuffResultAddLayerByDamageOfTeamHp = BuffResultAddLayerByDamageOfTeamHp

function BuffResultAddLayerByDamageOfTeamHp:Constructor(layer, buffseq, addLayer)
  self._layer = layer
  self._buffseq = buffseq
  self._addLayer = addLayer
end

function BuffResultAddLayerByDamageOfTeamHp:GetLayer()
  return self._layer
end

function BuffResultAddLayerByDamageOfTeamHp:GetAddLayer()
  return self._addLayer
end

function BuffResultAddLayerByDamageOfTeamHp:GetBuffSeq()
  return self._buffseq
end

_class("BuffResultChangePetPowerAndWatch", BuffResultBase)
BuffResultChangePetPowerAndWatch = BuffResultChangePetPowerAndWatch

function BuffResultChangePetPowerAndWatch:Constructor(petPowerList)
  self._petPowerList = petPowerList
end

function BuffResultChangePetPowerAndWatch:GetPetPowerList()
  return self._petPowerList
end

_class("BuffResultElementTargetAddLayerToHighest", BuffResultBase)
BuffResultElementTargetAddLayerToHighest = BuffResultElementTargetAddLayerToHighest

function BuffResultElementTargetAddLayerToHighest:Constructor(buffResultAddLayerList)
  self._buffResultAddLayerList = buffResultAddLayerList
end

function BuffResultElementTargetAddLayerToHighest:GetBuffResultAddLayerList()
  return self._buffResultAddLayerList
end

_class("BuffResultPlayEffectWithChainMove", BuffResultBase)
BuffResultPlayEffectWithChainMove = BuffResultPlayEffectWithChainMove

function BuffResultPlayEffectWithChainMove:Constructor(notifyType, notifyPos, isStart, isEnd, permanentEffectID, moveEffectID, useType, typeParam)
  self._notifyType = notifyType
  self._notifyPos = notifyPos
  self._isStart = isStart
  self._isEnd = isEnd
  self._permanentEffectID = permanentEffectID
  self._moveEffectID = moveEffectID
  self._useType = useType
  self._typeParam = typeParam
end

function BuffResultPlayEffectWithChainMove:GetNotifyType()
  return self._notifyType
end

function BuffResultPlayEffectWithChainMove:GetNotifyPos()
  return self._notifyPos
end

function BuffResultPlayEffectWithChainMove:GetIsStart()
  return self._isStart
end

function BuffResultPlayEffectWithChainMove:GetIsEnd()
  return self._isEnd
end

function BuffResultPlayEffectWithChainMove:GetPermanentEffectID()
  return self._permanentEffectID
end

function BuffResultPlayEffectWithChainMove:GetMoveEffectID()
  return self._moveEffectID
end

function BuffResultPlayEffectWithChainMove:GetUseType()
  return self._useType
end

function BuffResultPlayEffectWithChainMove:GetTypeParam()
  return self._typeParam
end

_class("BuffResultAddTrapExist", BuffResultBase)
BuffResultAddTrapExist = BuffResultAddTrapExist

function BuffResultAddTrapExist:Constructor(currentRound, forceFull, ignoreNextEffectUpdate, isDestroy)
  self._currentRound = currentRound
  self._forceFull = forceFull
  self._ignoreNextEffectUpdate = ignoreNextEffectUpdate
  self._isDestroy = isDestroy
end

function BuffResultAddTrapExist:GetCurrentRound()
  return self._currentRound
end

function BuffResultAddTrapExist:IsForceFull()
  return self._forceFull
end

function BuffResultAddTrapExist:IgnoreNextEffectUpdate()
  return self._ignoreNextEffectUpdate
end

function BuffResultAddTrapExist:IsDestroy()
  return self._isDestroy
end

_class("BuffResultShowPowerfullRoundCountUI", BuffResultBase)
BuffResultShowPowerfullRoundCountUI = BuffResultShowPowerfullRoundCountUI

function BuffResultShowPowerfullRoundCountUI:Constructor(bShow, resDic)
  self._bShow = bShow
  self._resDic = resDic
end

function BuffResultShowPowerfullRoundCountUI:IsShow()
  return self._bShow
end

function BuffResultShowPowerfullRoundCountUI:GetResDic()
  return self._resDic
end

_class("BuffResultSetChainDamage", BuffResultBase)
BuffResultSetChainDamage = BuffResultSetChainDamage

function BuffResultSetChainDamage:Constructor(attackerID, defenderID, lineEffectID, isRemove)
  self._attackerID = attackerID
  self._defenderID = defenderID
  self._lineEffectID = lineEffectID
  self._isRemove = isRemove
end

function BuffResultSetChainDamage:GetAttackerID()
  return self._attackerID
end

function BuffResultSetChainDamage:GetDefenderID()
  return self._defenderID
end

function BuffResultSetChainDamage:GetLineEffectID()
  return self._lineEffectID
end

function BuffResultSetChainDamage:GetIsRemove()
  return self._isRemove
end

function BuffResultSetChainDamage:SetRemoveAnim(removeAnim)
  self._removeAnim = removeAnim
end

function BuffResultSetChainDamage:GetRemoveAnim()
  return self._removeAnim
end

function BuffResultSetChainDamage:SetRemoveEffectID(removeEffectID)
  self._removeEffectID = removeEffectID
end

function BuffResultSetChainDamage:GetRemoveEffectID()
  return self._removeEffectID
end

function BuffResultSetChainDamage:SetRemoveLineEntityList(removeLineEntityList)
  self._removeLineEntityList = removeLineEntityList
end

function BuffResultSetChainDamage:GetRemoveLineEntityList()
  return self._removeLineEntityList
end

function BuffResultSetChainDamage:SetMonsterMoveOneFinish(entityID, walkPos)
  self._monsterMoveEntityID = entityID
  self._monsterMoveWalkPos = walkPos
end

function BuffResultSetChainDamage:GetMonsterMoveOneFinishEntityID()
  return self._monsterMoveEntityID
end

function BuffResultSetChainDamage:GetMonsterMoveOneFinishWalkPos()
  return self._monsterMoveWalkPos
end

function BuffResultSetChainDamage:SetTeamLeaderEachMoveEnd(walkPos)
  self._teamLeaderMoveWalkPos = walkPos
end

function BuffResultSetChainDamage:GetTeamLeaderEachMoveEnd()
  return self._teamLeaderMoveWalkPos
end

_class("BuffResultShowChainDamage", BuffResultBase)
BuffResultShowChainDamage = BuffResultShowChainDamage

function BuffResultShowChainDamage:Constructor(attackerID, defenderID, lineEffectID, isShow)
  self._attackerID = attackerID
  self._defenderID = defenderID
  self._lineEffectID = lineEffectID
  self._isShow = isShow
end

function BuffResultShowChainDamage:GetAttackerID()
  return self._attackerID
end

function BuffResultShowChainDamage:GetDefenderID()
  return self._defenderID
end

function BuffResultShowChainDamage:GetLineEffectID()
  return self._lineEffectID
end

function BuffResultShowChainDamage:GetIsShow()
  return self._isShow
end

_class("BuffResultChainDamage", BuffResultBase)
BuffResultChainDamage = BuffResultChainDamage

function BuffResultChainDamage:Constructor(originalAttackID, attackerID, defenderIDs, damageInfos)
  self._originalAttackID = originalAttackID
  self._attackerID = attackerID
  self._defenderIDs = defenderIDs
  self._damageInfos = damageInfos
end

function BuffResultChainDamage:GetOriginalAttackerID()
  return self._originalAttackID
end

function BuffResultChainDamage:GetAttackerID()
  return self._attackerID
end

function BuffResultChainDamage:GetDefenderIDs()
  return self._defenderIDs
end

function BuffResultChainDamage:GetDamageInfos()
  return self._damageInfos
end

function BuffResultChainDamage:SetAttackPos(attackPos)
  self._attackPos = attackPos
end

function BuffResultChainDamage:GetAttackPos()
  return self._attackPos
end

function BuffResultChainDamage:SetNotifyHp(notifyHp)
  self._notifyHp = notifyHp
end

function BuffResultChainDamage:GetNotifyHp()
  return self._notifyHp
end

function BuffResultChainDamage:SetPlayDamageText(playDamageText)
  self._playDamageText = playDamageText
end

function BuffResultChainDamage:GetPlayDamageText()
  return self._playDamageText
end

_class("BuffResultSetPreviewChainDamageScope", BuffResultBase)
BuffResultSetPreviewChainDamageScope = BuffResultSetPreviewChainDamageScope

function BuffResultSetPreviewChainDamageScope:Constructor(entityID, skillID)
  self._entityID = entityID
  self._skillID = skillID
end

function BuffResultSetPreviewChainDamageScope:GetEntityID()
  return self._entityID
end

function BuffResultSetPreviewChainDamageScope:GetSkillID()
  return self._skillID
end

_class("BuffResultShowHideUiMultiPowerInfoByIndex", BuffResultBase)
BuffResultShowHideUiMultiPowerInfoByIndex = BuffResultShowHideUiMultiPowerInfoByIndex

function BuffResultShowHideUiMultiPowerInfoByIndex:Constructor(petPstID, uiIndex, bShow)
  self._petPstID = petPstID
  self._uiIndex = uiIndex
  self._bShow = bShow
end

function BuffResultShowHideUiMultiPowerInfoByIndex:GetPetPstID()
  return self._petPstID
end

function BuffResultShowHideUiMultiPowerInfoByIndex:GetUiIndex()
  return self._uiIndex
end

function BuffResultShowHideUiMultiPowerInfoByIndex:GetIsShow()
  return self._bShow
end

_class("BuffResultForceShowPassiveAccumulate", BuffResultBase)
BuffResultForceShowPassiveAccumulate = BuffResultForceShowPassiveAccumulate

function BuffResultForceShowPassiveAccumulate:Constructor(buffLayerList, forceInitType, maxLayerCount)
  self._buffLayerList = buffLayerList
  self._forceInitType = forceInitType
  self._maxLayerCount = maxLayerCount
end

function BuffResultForceShowPassiveAccumulate:GetBuffLayerList()
  return self._buffLayerList
end

function BuffResultForceShowPassiveAccumulate:GetForceInitType()
  return self._forceInitType
end

function BuffResultForceShowPassiveAccumulate:GetMaxLayerCount()
  return self._maxLayerCount
end

_class("BuffResultShowPassiveAccumulateOverload", BuffResultBase)
BuffResultShowPassiveAccumulateOverload = BuffResultShowPassiveAccumulateOverload

function BuffResultShowPassiveAccumulateOverload:Constructor(showOverload)
  self._showOverload = showOverload
end

function BuffResultShowPassiveAccumulateOverload:IsOverLoadShow()
  return self._showOverload
end

_class("BuffResultAddHPByLayer", BuffResultBase)
BuffResultAddHPByLayer = BuffResultAddHPByLayer

function BuffResultAddHPByLayer:Constructor(damageInfo, eid, curLayer, totalLayer, buffSeq)
  self._damageInfo = damageInfo
  self._entityID = eid
  self._curLayer = curLayer
  self._layerTotalCount = totalLayer
  self._buffSeq = buffSeq
end

function BuffResultAddHPByLayer:SetLayerName(layerName)
  self._layerName = layerName
end

function BuffResultAddHPByLayer:GetLayerName()
  return self._layerName
end

function BuffResultAddHPByLayer:GetLayerTotalCount()
  return self._layerTotalCount
end

function BuffResultAddHPByLayer:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddHPByLayer:GetEntityID()
  return self._entityID
end

function BuffResultAddHPByLayer:GetBuffSeq()
  return self._buffSeq
end

function BuffResultAddHPByLayer:GetLayer()
  return self._curLayer
end

_class("BuffResultAddHPByMonsterAttackDamage", BuffResultBase)
BuffResultAddHPByMonsterAttackDamage = BuffResultAddHPByMonsterAttackDamage

function BuffResultAddHPByMonsterAttackDamage:Constructor(damageInfo, eid, sourceEntityID)
  self._damageInfo = damageInfo
  self._entityID = eid
  self._sourceEntityID = sourceEntityID
end

function BuffResultAddHPByMonsterAttackDamage:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddHPByMonsterAttackDamage:GetEntityID()
  return self._entityID
end

function BuffResultAddHPByMonsterAttackDamage:GetSourceEntityID()
  return self._sourceEntityID
end

_class("BuffResultAddHPByMoveNotify", BuffResultBase)
BuffResultAddHPByMoveNotify = BuffResultAddHPByMoveNotify

function BuffResultAddHPByMoveNotify:Constructor(damageInfo, headout, delay)
  self._damageInfo = damageInfo
  self._headout = headout
  self._delay = delay
end

function BuffResultAddHPByMoveNotify:GetDamageInfo()
  return self._damageInfo
end

function BuffResultAddHPByMoveNotify:GetHeadout()
  return self._headout
end

function BuffResultAddHPByMoveNotify:GetDelay()
  return self._delay
end

function BuffResultAddHPByMoveNotify:SetPosNew(pos)
  self._posNew = pos
end

function BuffResultAddHPByMoveNotify:GetPosNew()
  return self._posNew
end

_class("BuffResultAddCombo", BuffResultBase)
BuffResultAddCombo = BuffResultAddCombo

function BuffResultAddCombo:Constructor(changeValue, pos)
  self._changeValue = changeValue
  self._pos = pos
end

function BuffResultAddCombo:GetChangeValue()
  return self._changeValue
end

function BuffResultAddCombo:GetPos()
  return self._pos
end

_class("BuffResultExtraChain", BuffResultBase)
BuffResultExtraChain = BuffResultExtraChain

function BuffResultExtraChain:Constructor(entity)
end

_class("BuffResultSetReplaceChain", BuffResultBase)
BuffResultSetReplaceChain = BuffResultSetReplaceChain

function BuffResultSetReplaceChain:Constructor(replaceEntityID)
  self._replaceEntityID = replaceEntityID
end

function BuffResultSetReplaceChain:GetReplaceEntityID()
  return self._replaceEntityID
end

_class("BuffResultChangeAttackByFeatureShop", BuffResultBase)
BuffResultChangeAttackByFeatureShop = BuffResultChangeAttackByFeatureShop

function BuffResultChangeAttackByFeatureShop:Constructor(casterID, val, light, pstid, casterPstID)
  self._casterID = casterID
  self._val = val
  self._light = light
  self._pstid = pstid
  self._casterPstID = casterPstID
end

function BuffResultChangeAttackByFeatureShop:GetCasterID()
  return self._casterID
end

function BuffResultChangeAttackByFeatureShop:GetValue()
  return self._val
end

function BuffResultChangeAttackByFeatureShop:GetLight()
  return self._light
end

function BuffResultChangeAttackByFeatureShop:GetPstID()
  return self._pstid
end

function BuffResultChangeAttackByFeatureShop:GetCasterPstID()
  return self._casterPstID
end

_class("BuffResultUndoChangeAttackByFeatureShop", BuffResultBase)
BuffResultUndoChangeAttackByFeatureShop = BuffResultUndoChangeAttackByFeatureShop

function BuffResultUndoChangeAttackByFeatureShop:Constructor(black, casterPstID)
  self._casterPstID = casterPstID
  self._black = black
end

function BuffResultUndoChangeAttackByFeatureShop:GetBlack()
  return self._black
end

function BuffResultUndoChangeAttackByFeatureShop:GetCasterPstID()
  return self._casterPstID
end

_class("BuffResultSetOnlyTeamLeaderColorPet", BuffResultBase)
BuffResultSetOnlyTeamLeaderColorPet = BuffResultSetOnlyTeamLeaderColorPet

function BuffResultSetOnlyTeamLeaderColorPet:Constructor(val)
  self._val = val
end

function BuffResultSetOnlyTeamLeaderColorPet:GetVal()
  return self._val
end

_class("BuffResultDamageByTargetMoveDis", BuffResultBase)
BuffResultDamageByTargetMoveDis = BuffResultDamageByTargetMoveDis

function BuffResultDamageByTargetMoveDis:Constructor(damageInfo)
  self._damageInfo = damageInfo
end

function BuffResultDamageByTargetMoveDis:GetDamageInfo()
  return self._damageInfo
end

_class("BuffResultChargeColorPalette", BuffResultBase)
BuffResultChargeColorPalette = BuffResultChargeColorPalette

function BuffResultChargeColorPalette:Constructor(entityID, pieceTypes)
  self._entityID = entityID
  self._pieceTypes = pieceTypes
end

function BuffResultChargeColorPalette:GetEntityID()
  return self._entityID
end

function BuffResultChargeColorPalette:GetPieceTypes()
  return self._pieceTypes
end

_class("BuffResultMonsterMoveGroupLineRenderer", BuffResultBase)
BuffResultMonsterMoveGroupLineRenderer = BuffResultMonsterMoveGroupLineRenderer

function BuffResultMonsterMoveGroupLineRenderer:Constructor(moveEntityID, moveBeginPos, moveFinalPos)
  self._moveEntityID = moveEntityID
  self._moveBeginPos = moveBeginPos
  self._moveFinalPos = moveFinalPos
end

function BuffResultMonsterMoveGroupLineRenderer:GetMoveBeginPos()
  return self._moveBeginPos
end

function BuffResultMonsterMoveGroupLineRenderer:GetMoveFinalPos()
  return self._moveBeginPos
end

function BuffResultMonsterMoveGroupLineRenderer:GetMoveEntityID()
  return self._moveEntityID
end
