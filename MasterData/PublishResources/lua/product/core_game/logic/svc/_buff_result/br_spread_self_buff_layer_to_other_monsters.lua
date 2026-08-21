_class("BuffResultSpreadDeadMonsterBuffLayerToOtherMonsters", BuffResultBase)
BuffResultSpreadDeadMonsterBuffLayerToOtherMonsters = BuffResultSpreadDeadMonsterBuffLayerToOtherMonsters

function BuffResultSpreadDeadMonsterBuffLayerToOtherMonsters:Constructor(ownerEntityID, defenderEntityID)
  self._ownerEntityID = ownerEntityID
  self._defenderEntityID = defenderEntityID
  self._spreadResults = {}
end

function BuffResultSpreadDeadMonsterBuffLayerToOtherMonsters:GetOwnerEntityID()
  return self._ownerEntityID
end

function BuffResultSpreadDeadMonsterBuffLayerToOtherMonsters:GetDefenderEntityID()
  return self._defenderEntityID
end

function BuffResultSpreadDeadMonsterBuffLayerToOtherMonsters:AddSpreadResult(targetID, layerBuffEffectType, addLayer, finalLayer, buffSeq, casterEntity)
  table.insert(self._spreadResults, {
    targetID = targetID,
    layerBuffEffectType = layerBuffEffectType,
    addLayer = addLayer,
    finalLayer = finalLayer,
    buffSeq = buffSeq,
    casterEntity = casterEntity
  })
end

function BuffResultSpreadDeadMonsterBuffLayerToOtherMonsters:GetSpreadResults()
  return self._spreadResults
end
