_class("IAffixParam", Object)
IAffixParam = IAffixParam

function IAffixParam:Constructor(t, typeID, index)
  self._affixType = t.affixType
  self._configTypeID = typeID
  self._configIndex = index
end

function IAffixParam:GetAffixType()
  return self._affixType
end

function IAffixParam:GetAffixConfigTypeID()
  return self._configTypeID
end

function IAffixParam:GetConfigIndex()
  return self._configIndex
end

function IAffixParam:Init(world)
end

_class("AffixChangePetAttrParam", IAffixParam)
AffixChangePetAttrParam = AffixChangePetAttrParam

function AffixChangePetAttrParam:Constructor(t)
  self._type = t.type
  self._percent = t.percent or 1
  self._count = t.count or 0
end

function AffixChangePetAttrParam:GetType()
  return self._type
end

function AffixChangePetAttrParam:CalcAttr(attrNum)
  return math.floor(attrNum * self._percent + self._count)
end

_class("AffixChangePetChainCountParam", IAffixParam)
AffixChangePetChainCountParam = AffixChangePetChainCountParam

function AffixChangePetChainCountParam:Constructor(t)
  self._percent = t.percent or 1
  self._count = t.count or 0
end

function AffixChangePetChainCountParam:CalcChainCount(sourceChainCount)
  return math.floor(self._percent * sourceChainCount + self._count)
end

_class("AffixChangeMonsterAttrParam", IAffixParam)
AffixChangeMonsterAttrParam = AffixChangeMonsterAttrParam

function AffixChangeMonsterAttrParam:Constructor(t)
  self._monsterID = t.monsterID
  self._attack = t.attack
  self._hp = t.hp
  self._defence = t.defence
  if not t.attack and not t.hp and not t.defence then
    Log.exception("Parse  AffixChangeMonsterAttrParam Failed")
  end
end

function AffixChangeMonsterAttrParam:GetMonsterID()
  return self._monsterID
end

function AffixChangeMonsterAttrParam:GetMonsterAttack()
  return self._attack
end

function AffixChangeMonsterAttrParam:GetMonsterHP()
  return self._hp
end

function AffixChangeMonsterAttrParam:GetMonsterDefence()
  return self._defence
end

_class("AffixReplaceMonsterAIParam", IAffixParam)
AffixReplaceMonsterAIParam = AffixReplaceMonsterAIParam

function AffixReplaceMonsterAIParam:Constructor(t)
  self._monsterID = t.monsterID
  self._sourceAIID = t.sourceAIID
  self._aiType = t.aiType
  self._targetAIID = t.targetAIID
end

function AffixReplaceMonsterAIParam:GetMonsterID()
  return self._monsterID
end

function AffixReplaceMonsterAIParam:GetAIType()
  return self._aiType
end

function AffixReplaceMonsterAIParam:ReplaceAI(sourceAIID)
  if sourceAIID == self._sourceAIID then
    return self._targetAIID
  end
  return sourceAIID
end

_class("AffixReplaceMonsterSkillIDParam", IAffixParam)
AffixReplaceMonsterSkillIDParam = AffixReplaceMonsterSkillIDParam

function AffixReplaceMonsterSkillIDParam:Constructor(t)
  self._monsterID = t.monsterID
  self._sourceSkillID = t.sourceSkillID
  self._targetSkillID = t.targetSkillID
end

function AffixReplaceMonsterSkillIDParam:GetMonsterID()
  return self._monsterID
end

function AffixReplaceMonsterSkillIDParam:ReplaceSkillID(sourceSkillID)
  if sourceSkillID == self._sourceSkillID then
    return self._targetSkillID
  end
  return sourceSkillID
end

_class("AffixChangeTrapAttrParam", IAffixParam)
AffixChangeTrapAttrParam = AffixChangeTrapAttrParam

function AffixChangeTrapAttrParam:Constructor(t)
  self._trapID = t.trapID
  self._attack = t.attack
  self._hp = t.hp
  self._maxHP = t.maxHP
  self._defence = t.defence
  self._trapPower = t.trapPower
  if not t.attack and not t.hp and not t.defence and not t.maxHP and not t.trapPower then
    Log.exception("Parse  AffixChangeTrapAttrParam Failed")
  end
end

function AffixChangeTrapAttrParam:GetTrapID()
  return self._trapID
end

function AffixChangeTrapAttrParam:GetTrapAttack()
  return self._attack
end

function AffixChangeTrapAttrParam:GetTrapHP()
  return self._hp
end

function AffixChangeTrapAttrParam:GetTrapMaxHP()
  return self._maxHP
end

function AffixChangeTrapAttrParam:GetTrapDefence()
  return self._defence
end

function AffixChangeTrapAttrParam:GetTrapPower()
  return self._trapPower
end

_class("AffixPlayerBeHitCountParam", IAffixParam)
AffixPlayerBeHitCountParam = AffixPlayerBeHitCountParam

function AffixPlayerBeHitCountParam:Constructor(t)
  self._beHitCount = t.beHitCount
end

function AffixPlayerBeHitCountParam:GetPlayerBeHitCount()
  return self._beHitCount
end

_class("AffixReplaceLevelCompleteTypeParam", IAffixParam)
AffixReplaceLevelCompleteTypeParam = AffixReplaceLevelCompleteTypeParam

function AffixReplaceLevelCompleteTypeParam:Constructor(t)
  self._type = t.type
  self._param = t.param
  self._useInLastWave = t.useInLastWave or true
end

function AffixReplaceLevelCompleteTypeParam:GetType()
  return self._type
end

function AffixReplaceLevelCompleteTypeParam:GetParam()
  return self._param
end

function AffixReplaceLevelCompleteTypeParam:IsUseInLastWave()
  return self._useInLastWave
end

_class("AffixAddBuffParam", IAffixParam)
AffixAddBuffParam = AffixAddBuffParam

function AffixAddBuffParam:Constructor(t)
  if type(t.affixBuffIDList) == "number" then
    self._affixBuffIDList = {
      t.affixBuffIDList
    }
  else
    self._affixBuffIDList = t.affixBuffIDList
  end
end

function AffixAddBuffParam:GetAffixBuffIDList()
  return self._affixBuffIDList
end

_class("AffixChangeWaveIDParamBase", IAffixParam)
AffixChangeWaveIDParamBase = AffixChangeWaveIDParamBase

function AffixChangeWaveIDParamBase:Constructor(t)
  self._waveNum = t.waveNum
  self._sourceID = t.sourceID
  self._targetID = t.targetID
  if not t.sourceID or not t.targetID then
    Log.exception("sourceID:", t.sourceID, "targetID:", t.targetID)
  end
end

function AffixChangeWaveIDParamBase:GetSourceID()
  return self._sourceID
end

function AffixChangeWaveIDParamBase:GetTargetID()
  return self._targetID
end

function AffixChangeWaveIDParamBase:GetWaveNum()
  return self._waveNum
end

_class("AffixAddWaveIDParamBase", IAffixParam)
AffixAddWaveIDParamBase = AffixAddWaveIDParamBase

function AffixAddWaveIDParamBase:Constructor(t)
  self._waveNum = t.waveNum
  self._id = t.id
  self._pos = Vector2(t.pos[1], t.pos[2])
  if not (t.id and t.pos) or #t.pos ~= 2 then
    Log.exception("id:", t.id, "pos:", t.pos)
  end
end

function AffixAddWaveIDParamBase:GetWaveNum()
  return self._waveNum
end

function AffixAddWaveIDParamBase:GetID()
  return self._id
end

function AffixAddWaveIDParamBase:GetPos()
  return self._pos
end

_class("AffixChangeWaveInternalIDParamBase", AffixChangeWaveIDParamBase)
AffixChangeWaveInternalIDParamBase = AffixChangeWaveInternalIDParamBase

function AffixChangeWaveInternalIDParamBase:Constructor(t)
  self._refreshID = t.refreshID
end

function AffixChangeWaveInternalIDParamBase:GetRefreshID()
  return self._refreshID
end

_class("AffixAddWaveInternalIDParamBase", AffixAddWaveIDParamBase)
AffixAddWaveInternalIDParamBase = AffixAddWaveInternalIDParamBase

function AffixAddWaveInternalIDParamBase:Constructor(t)
  self._refreshID = t.refreshID
end

function AffixAddWaveInternalIDParamBase:GetRefreshID()
  return self._refreshID
end

_class("AffixAddWaveTrapIDAndPosParamBase", AffixAddWaveIDParamBase)
AffixAddWaveTrapIDAndPosParamBase = AffixAddWaveTrapIDAndPosParamBase

function AffixAddWaveTrapIDAndPosParamBase:Constructor(t)
  self._rotation = Vector2(t.rotation[0], t.rotation[1])
end

function AffixAddWaveTrapIDAndPosParamBase:GetRotation()
  return self._rotation
end

_class("AffixAddWaveInternalTrapIDAndPosParam", AffixAddWaveInternalIDParamBase)
AffixAddWaveInternalTrapIDAndPosParam = AffixAddWaveInternalTrapIDAndPosParam

function AffixAddWaveInternalTrapIDAndPosParam:Constructor(t)
  self._rotation = Vector2(t.rotation[0], t.rotation[1])
end

function AffixAddWaveInternalTrapIDAndPosParam:GetRotation()
  return self._rotation
end

_class("AffixChangeAllMonsterAttrParam", IAffixParam)
AffixChangeAllMonsterAttrParam = AffixChangeAllMonsterAttrParam

function AffixChangeAllMonsterAttrParam:Constructor(t)
  self._paramY = t.paramY
  self._paramZ = t.paramZ
end

function AffixChangeAllMonsterAttrParam:GetParamY()
  return self._paramY
end

function AffixChangeAllMonsterAttrParam:GetParamZ()
  return self._paramZ
end

_class("AffixChangeLevelRoundParam", IAffixParam)
AffixChangeLevelRoundParam = AffixChangeLevelRoundParam

function AffixChangeLevelRoundParam:Constructor(t)
  self._change = t.change
end

function AffixChangeLevelRoundParam:GetChange()
  return self._change
end

_class("AffixChangeWaveInternalParam", IAffixParam)
AffixChangeWaveInternalParam = AffixChangeWaveInternalParam

function AffixChangeWaveInternalParam:Constructor(t)
  self._waveNum = t.waveNum
  self._refreshIndex = t.refreshIndex
  self._param = t.param
end

function AffixChangeWaveInternalParam:GetWaveNum()
  return self._waveNum
end

function AffixChangeWaveInternalParam:GetRefreshIndex()
  return self._refreshIndex
end

function AffixChangeWaveInternalParam:GetParam()
  return self._param
end

_class("AffixAddWaveInternalParam", IAffixParam)
AffixAddWaveInternalParam = AffixAddWaveInternalParam

function AffixAddWaveInternalParam:Constructor(t)
  self._refreshID = t.refreshID
  self._type = t.type
  self._param = t.param
  self._waveNum = t.waveNum
end

function AffixAddWaveInternalParam:GetParam()
  return self._param
end

function AffixAddWaveInternalParam:GetRefreshID()
  return self._refreshID
end

function AffixAddWaveInternalParam:GetType()
  return self._type
end

function AffixAddWaveInternalParam:GetWaveNum()
  return self._waveNum
end

_class("AffixReplaceMonsterBuffParam", IAffixParam)
AffixReplaceMonsterBuffParam = AffixReplaceMonsterBuffParam

function AffixReplaceMonsterBuffParam:Constructor(t)
  self._monsterID = t.monsterID
  self._buffList = t.buffList
  if not t.buffList or type(t.buffList) ~= "table" then
    Log.exception("Parse  AffixReplaceMonsterBuffParam Failed")
  end
end

function AffixReplaceMonsterBuffParam:GetMonsterID()
  return self._monsterID
end

function AffixReplaceMonsterBuffParam:GetBuffList()
  return self._buffList
end

_class("AffixAddMonsterBuffParam", AffixReplaceMonsterBuffParam)
AffixAddMonsterBuffParam = AffixAddMonsterBuffParam
_class("AffixReplaceMonsterEliteBuffParam", IAffixParam)
AffixReplaceMonsterEliteBuffParam = AffixReplaceMonsterEliteBuffParam

function AffixReplaceMonsterEliteBuffParam:Constructor(t)
  self._monsterID = t.monsterID
  self._eliteBuffList = t.eliteBuffList
  if not t.eliteBuffList or type(t.eliteBuffList) ~= "table" then
    Log.exception("Parse", self._className, " Failed")
  end
end

function AffixReplaceMonsterEliteBuffParam:GetMonsterID()
  return self._monsterID
end

function AffixReplaceMonsterEliteBuffParam:GetEliteBuffList()
  return self._eliteBuffList
end

_class("AffixAddMonsterEliteBuffParam", AffixReplaceMonsterEliteBuffParam)
AffixAddMonsterEliteBuffParam = AffixAddMonsterEliteBuffParam
_class("AffixReplaceTrapSkillParam", IAffixParam)
AffixReplaceTrapSkillParam = AffixReplaceTrapSkillParam

function AffixReplaceTrapSkillParam:Constructor(t)
  self._trapID = t.trapID
  self._triggerSkillID = t.Trigger
  self._appearSkillID = t.Appear
  self._dieSkillID = t.Die
  self._activeSkillID = t.Active
end

function AffixReplaceTrapSkillParam:GetTrapID()
  return self._trapID
end

function AffixReplaceTrapSkillParam:GetTriggerSkillID()
  return self._triggerSkillID
end

function AffixReplaceTrapSkillParam:GetAppearSkillID()
  return self._appearSkillID
end

function AffixReplaceTrapSkillParam:GetDieSkillID()
  return self._dieSkillID
end

function AffixReplaceTrapSkillParam:GetActiveSkillID()
  return self._activeSkillID
end

_class("AffixReplaceTrapBuffParam", IAffixParam)
AffixReplaceTrapBuffParam = AffixReplaceTrapBuffParam

function AffixReplaceTrapBuffParam:Constructor(t)
  self._trapID = t.trapID
  self._buffList = t.buffList
  if not t.buffList or type(t.buffList) ~= "table" then
    Log.exception("Parse", self._className, " Failed")
  end
end

function AffixReplaceTrapBuffParam:GetTrapID()
  return self._trapID
end

function AffixReplaceTrapBuffParam:GetBuffList()
  return self._buffList
end

_class("AffixAddTrapBuffParam", AffixReplaceTrapBuffParam)
AffixAddTrapBuffParam = AffixAddTrapBuffParam
_class("AffixReplaceMonsterSpSkillParam", IAffixParam)
AffixReplaceMonsterSpSkillParam = AffixReplaceMonsterSpSkillParam

function AffixReplaceMonsterSpSkillParam:Constructor(t)
  self._monsterID = t.monsterID
  self._skillType = t.skillType
  self._skillID = t.skillID
  if not (self._monsterID and self._skillType) or not self._skillID then
    Log.exception("Parse", self._className, "Failed")
  end
end

function AffixReplaceMonsterSpSkillParam:GetMonsterID()
  return self._monsterID
end

function AffixReplaceMonsterSpSkillParam:GetSkillType()
  return self._skillType
end

function AffixReplaceMonsterSpSkillParam:GetSkillID()
  return self._skillID
end

_class("AffixChangePieceRefreshTypeParam", IAffixParam)
AffixChangePieceRefreshTypeParam = AffixChangePieceRefreshTypeParam

function AffixChangePieceRefreshTypeParam:Constructor(t)
  self._dir = t.dir and Vector2(t.dir[1], t.dir[2]) or Vector2.down
  self._refreshType = t.refreshType or PieceRefreshType.FallingDown
  self._gapTrapID = t.gapTrapID or 0
end

function AffixChangePieceRefreshTypeParam:GetFallingDirection()
  return self._dir
end

function AffixChangePieceRefreshTypeParam:GetPieceRefreshType()
  return self._refreshType
end

function AffixChangePieceRefreshTypeParam:GetGapTrapID()
  return self._gapTrapID
end

_class("AffixReplaceFeatureModule", IAffixParam)
AffixReplaceFeatureModule = AffixReplaceFeatureModule

function AffixReplaceFeatureModule:Constructor(t)
  self._table = t.configTable
end

function AffixReplaceFeatureModule:GetConfigTable()
  return {
    feature = self._table
  }
end

_class("AffixReplacePieceGenWeightParam", IAffixParam)
AffixReplacePieceGenWeightParam = AffixReplacePieceGenWeightParam

function AffixReplacePieceGenWeightParam:Constructor(t)
  self._generatePieceAmount = t.GeneratePieceAmount
  self._generatePieceWeight = t.GeneratePieceWeight
  self._supplyPieceWeight = t.SupplyPieceWeight
end

function AffixReplacePieceGenWeightParam:GetGeneratePieceAmount()
  return self._generatePieceAmount
end

function AffixReplacePieceGenWeightParam:GetGeneratePieceWeight()
  return self._generatePieceWeight
end

function AffixReplacePieceGenWeightParam:GetSupplyPieceWeight()
  return self._supplyPieceWeight
end

_class("AffixIncreasePetNoDefenceDamageParam", IAffixParam)
AffixIncreasePetNoDefenceDamageParam = AffixIncreasePetNoDefenceDamageParam

function AffixIncreasePetNoDefenceDamageParam:Constructor(t)
  self._increasePercent = t.IncreasePercent
end

function AffixIncreasePetNoDefenceDamageParam:GetIncreasePercent()
  return self._increasePercent
end

_class("AffixChangePetAddBuffMaxRoundParam", IAffixParam)
AffixChangePetAddBuffMaxRoundParam = AffixChangePetAddBuffMaxRoundParam

function AffixChangePetAddBuffMaxRoundParam:Constructor(t)
  self._flagNum = t.FlagNum
  self._changeRound = t.ChangeRound
end

function AffixChangePetAddBuffMaxRoundParam:GetEffectFlagNum()
  return self._flagNum
end

function AffixChangePetAddBuffMaxRoundParam:GetChangeRound()
  return self._changeRound
end

_class("AffixAddChainPathNumParam", IAffixParam)
AffixAddChainPathNumParam = AffixAddChainPathNumParam

function AffixAddChainPathNumParam:Constructor(t)
  self._addChainPathNumt = t.AddChainPathNum
end

function AffixAddChainPathNumParam:GetAddChainPathNum()
  return self._addChainPathNumt
end
