local AwakerAffectDataUtils = {}

function AwakerAffectDataUtils.GetAwakerLikeLv(awakerId)
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  if not awaker then
    return 0
  end
  return awaker.likeLevel
end

function AwakerAffectDataUtils.GetAwakerLike(awakerId)
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  if not awaker then
    return 0
  end
  return awaker.like or 0
end

function AwakerAffectDataUtils.GetAwakerLv(awakerId)
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  if not awaker then
    return 0
  end
  return awaker.level
end

function AwakerAffectDataUtils.GetAwakerPotencyLv(awakerId)
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  if not awaker then
    return 0
  end
  return awaker.potency
end

function AwakerAffectDataUtils.StoryOrVoiceUnlockCheck(awakerId, conditionType, param)
  local result = false
  local condition = CommonDefine.AwakerFileUnlock_Condition
  if conditionType == condition.AwakerFavorabilityLevel then
    local likeLv = AwakerAffectDataUtils.GetAwakerLikeLv(awakerId)
    result = likeLv >= param[1]
  elseif conditionType == condition.Awaker_Level then
    local awakerLv = AwakerAffectDataUtils.GetAwakerLv(awakerId)
    result = awakerLv >= param[1]
  elseif conditionType == condition.StageFirstClear then
    local stageId = param[1]
    local isFinish = MainCopyDataUtils.IsStageDataFirstFinish(stageId)
    result = isFinish
  elseif conditionType == condition.PotencyLevel then
    local awakerPotencyLv = AwakerAffectDataUtils.GetAwakerPotencyLv(awakerId)
    result = awakerPotencyLv >= param[1]
  end
  return result
end

return AwakerAffectDataUtils
