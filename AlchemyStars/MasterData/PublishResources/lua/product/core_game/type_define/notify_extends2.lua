_class("NTMultiHPSwitch", INotifyBase)
NTMultiHPSwitch = NTMultiHPSwitch

function NTMultiHPSwitch:Constructor(curMultiHPStage)
  self._curMultiHPStage = curMultiHPStage
end

function NTMultiHPSwitch:GetNotifyType()
  return NotifyType.MultiHPSwitch
end

function NTMultiHPSwitch:GetMultiHPStage()
  return self._curMultiHPStage
end

_class("NTRoundResultStart", INotifyBase)
NTRoundResultStart = NTRoundResultStart

function NTRoundResultStart:Constructor(team)
  self._teamEntity = team
end

function NTRoundResultStart:GetNotifyType()
  return NotifyType.RoundResultStart
end

function NTRoundResultStart:GetNotifyEntity()
  return self._teamEntity
end

_class("NTFeatureStepPointMoveCost", INotifyBase)
NTFeatureStepPointMoveCost = NTFeatureStepPointMoveCost

function NTFeatureStepPointMoveCost:Constructor(teamEntity, curVal, oldVal, costVal)
  self._teamEntity = teamEntity
  self._curVal = curVal
  self._oldVal = oldVal
  self._costVal = costVal
end

function NTFeatureStepPointMoveCost:GetNotifyType()
  return NotifyType.FeatureStepPointMoveCost
end

function NTFeatureStepPointMoveCost:GetNotifyEntity()
  return self._teamEntity
end

function NTFeatureStepPointMoveCost:GetCurVal()
  return self._curVal
end

function NTFeatureStepPointMoveCost:GetOldVal()
  return self._oldVal
end

function NTFeatureStepPointMoveCost:GetCostVal()
  return self._costVal
end

_class("NTFeatureShopCoinCountChange", INotifyBase)
NTFeatureShopCoinCountChange = NTFeatureShopCoinCountChange

function NTFeatureShopCoinCountChange:Constructor(curCoinCount, oriCoinCount)
  self._curCoinCount = curCoinCount
  self._oriCoinCount = oriCoinCount
end

function NTFeatureShopCoinCountChange:GetNotifyType()
  return NotifyType.FeatureShopCoinCountChange
end

function NTRoundResultStart:GetCurCoinCount()
  return self._curCoinCount
end

function NTRoundResultStart:GetOriCoinCount()
  return self._oriCoinCount
end

_class("NTFeatureStepPointSkillCost", INotifyBase)
NTFeatureStepPointSkillCost = NTFeatureStepPointSkillCost

function NTFeatureStepPointSkillCost:Constructor(teamEntity, curVal, oldVal, costVal)
  self._teamEntity = teamEntity
  self._curVal = curVal
  self._oldVal = oldVal
  self._costVal = costVal
end

function NTFeatureStepPointSkillCost:GetNotifyType()
  return NotifyType.FeatureStepPointSkillCost
end

function NTFeatureStepPointSkillCost:GetNotifyEntity()
  return self._teamEntity
end

function NTFeatureStepPointSkillCost:GetCurVal()
  return self._curVal
end

function NTFeatureStepPointSkillCost:GetOldVal()
  return self._oldVal
end

function NTFeatureStepPointSkillCost:GetCostVal()
  return self._costVal
end

_class("NTPopStarProAddFeatureEnergy", INotifyBase)
NTPopStarProAddFeatureEnergy = NTPopStarProAddFeatureEnergy

function NTPopStarProAddFeatureEnergy:Constructor()
  self._addNum = 0
  self._cumulativeTriggerNum = 0
end

function NTPopStarProAddFeatureEnergy:GetNotifyType()
  return NotifyType.PopStarProAddFeatureEnergy
end

function NTPopStarProAddFeatureEnergy:SetAddNum(num)
  self._addNum = num
end

function NTPopStarProAddFeatureEnergy:GetAddNum()
  return self._addNum
end

function NTPopStarProAddFeatureEnergy:SetCumulativeTriggerNum(num)
  self._cumulativeTriggerNum = num
end

function NTPopStarProAddFeatureEnergy:GetCumulativeTriggerNum()
  return self._cumulativeTriggerNum
end

_class("NTGridConvertSubordinate", INotifyBase)
NTGridConvertSubordinate = NTGridConvertSubordinate

function NTGridConvertSubordinate:Constructor(entity, convertInfoArray)
  self._entity = entity
  self._convertInfoArray = convertInfoArray
  self._convertScope = {}
  if convertInfoArray then
    for _, convertInfo in ipairs(convertInfoArray) do
      local pos = convertInfo:GetPos()
      table.insert(self._convertScope, pos)
    end
  end
end

function NTGridConvertSubordinate:GetNotifyType()
  return NotifyType.GridConvertSubordinate
end

function NTGridConvertSubordinate:GetNotifyEntity()
  if self._entity and self._entity:HasSuperEntity() and self._entity:EntityType():IsSkillHolder() then
    return self._entity:GetSuperEntity()
  end
  return self._entity
end

function NTGridConvertSubordinate:GetConvertScope()
  if #self._convertScope > 0 then
    return self._convertScope
  end
end

_class("NTBeforePetActiveSkillClearPower", INotifyBase)
NTBeforePetActiveSkillClearPower = NTBeforePetActiveSkillClearPower

function NTBeforePetActiveSkillClearPower:Constructor(entity, skillID)
  self._entity = entity
  self._skillID = skillID
end

function NTBeforePetActiveSkillClearPower:GetNotifyType()
  return NotifyType.BeforePetActiveSkillClearPower
end

function NTBeforePetActiveSkillClearPower:GetNotifyEntity()
  return self._entity
end

function NTBeforePetActiveSkillClearPower:GetSkillID()
  return self._skillID
end

_class("NTBodyAreaChange", INotifyBase)
NTBodyAreaChange = NTBodyAreaChange

function NTBodyAreaChange:Constructor(entity)
  self._entity = entity
end

function NTBodyAreaChange:GetNotifyType()
  return NotifyType.BodyAreaChange
end

function NTBodyAreaChange:GetNotifyEntity()
  return self._entity
end

_class("NTAfterPetSkillDamage", INotifyBase)
NTAfterPetSkillDamage = NTAfterPetSkillDamage

function NTAfterPetSkillDamage:Constructor(petEntity, skillId)
  self._petEntity = petEntity
  self._skillId = skillId
end

function NTAfterPetSkillDamage:GetNotifyType()
  return NotifyType.AfterPetSkillDamage
end

function NTAfterPetSkillDamage:GetNotifyEntity()
  return self._petEntity
end

function NTAfterPetSkillDamage:GetSkillID()
  return self._skillId
end

_class("NTBeforePetAbsorbMainColorGrid", INotifyBase)
NTBeforePetAbsorbMainColorGrid = NTBeforePetAbsorbMainColorGrid

function NTBeforePetAbsorbMainColorGrid:Constructor(trapEntity, triggerEntity)
  self._trapEntity = trapEntity
  self._triggerEntity = triggerEntity
end

function NTBeforePetAbsorbMainColorGrid:GetTrapID()
  local trapCmpt = self._trapEntity:Trap()
  if not trapCmpt then
    return nil
  end
  local trapID = trapCmpt:GetTrapID()
  return trapID
end

function NTBeforePetAbsorbMainColorGrid:GetNotifyType()
  return NotifyType.BeforePetAbsorbMainColorGrid
end

function NTBeforePetAbsorbMainColorGrid:GetNotifyEntity()
  return self._trapEntity
end

function NTBeforePetAbsorbMainColorGrid:GetTriggerEntity()
  return self._triggerEntity
end

function NTBeforePetAbsorbMainColorGrid:GetNotifyPos()
  return self._trapEntity:GetGridPosition()
end

function NTBeforePetAbsorbMainColorGrid:GetPos()
  return self._trapEntity:GetGridPosition()
end

_class("NTColorPaletteChargeComplete", INotifyBase)
NTColorPaletteChargeComplete = NTColorPaletteChargeComplete

function NTColorPaletteChargeComplete:Constructor(notifyEntity, pieceTypes)
  self._notifyEntity = notifyEntity
  self._pieceTypes = pieceTypes
end

function NTColorPaletteChargeComplete:GetNotifyEntity()
  return self._notifyEntity
end

function NTColorPaletteChargeComplete:GetNotifyType()
  return NotifyType.ColorPaletteChargeComplete
end

function NTColorPaletteChargeComplete:GetPieceTypes()
  return self._pieceTypes
end

_class("NTRandomTetrisEnd", INotifyBase)
NTRandomTetrisEnd = NTRandomTetrisEnd

function NTRandomTetrisEnd:Constructor(notifyEntity, tetrisIndex, tetrisType)
  self._notifyEntity = notifyEntity
  self._tetrisIndex = tetrisIndex
  self._tetrisType = tetrisType
end

function NTRandomTetrisEnd:GetTetrisIndex()
  return self._tetrisIndex
end

function NTRandomTetrisEnd:GetTetrisType()
  return self._tetrisType
end

function NTRandomTetrisEnd:GetNotifyEntity()
  return self._notifyEntity
end

function NTRandomTetrisEnd:GetNotifyType()
  return NotifyType.RandomTetrisEnd
end

_class("NTScorpionSummonEnd", INotifyBase)
NTScorpionSummonEnd = NTScorpionSummonEnd

function NTScorpionSummonEnd:Constructor(groupID)
  self._moveGroupID = groupID
end

function NTScorpionSummonEnd:GetGroupID()
  return self._moveGroupID
end

function NTScorpionSummonEnd:GetNotifyType()
  return NotifyType.ScorpionSummonEnd
end

_class("NTChainAttackFinish", INotifyBase)
NTChainAttackFinish = NTChainAttackFinish

function NTChainAttackFinish:Constructor(team)
  self._teamEntity = team
end

function NTChainAttackFinish:GetNotifyType()
  return NotifyType.ChainAttackFinish
end

function NTChainAttackFinish:GetNotifyEntity()
  return self._teamEntity
end

_class("NTActiveSkillLinkLineChainAttackFinish", INotifyBase)
NTActiveSkillLinkLineChainAttackFinish = NTActiveSkillLinkLineChainAttackFinish

function NTActiveSkillLinkLineChainAttackFinish:Constructor(casterEntity, casterPos)
  self._casterEntity = casterEntity
  self._casterPos = casterPos
end

function NTActiveSkillLinkLineChainAttackFinish:GetNotifyPos()
  return self._casterPos
end

function NTActiveSkillLinkLineChainAttackFinish:GetNotifyType()
  return NotifyType.ActiveSkillLinkLineChainAttackFinish
end

function NTActiveSkillLinkLineChainAttackFinish:GetNotifyEntity()
  return self._casterEntity
end
