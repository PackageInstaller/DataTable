local GuideNotePermTrainingSortUtil = {}

function GuideNotePermTrainingSortUtil.GetSeasonLeftTime(gameplayType)
  local seasonId = 0
  if SeasonRotationModel and SeasonRotationModel.Instance and SeasonRotationModel.Instance.GetSeasonId then
    seasonId = SeasonRotationModel.Instance:GetSeasonId(gameplayType) or 0
  end
  local endTime = 0
  if SeasonRotationCfgUtils and SeasonRotationCfgUtils.GetEndTime then
    endTime = SeasonRotationCfgUtils.GetEndTime(seasonId, gameplayType) or 0
  end
  if endTime <= 0 then
    return math.maxinteger
  end
  do return math.max, 0 end
  return math.max, 0, endTime - TimeUtils.GetServerTime()
end

function GuideNotePermTrainingSortUtil.GetAbyssLeftTime()
  local abyssModel = AbyssExtModel and AbyssExtModel.Instance or nil
  local endTime = abyssModel and abyssModel.GetEndTime and abyssModel:GetEndTime() or 0
  if endTime and endTime > 0 then
    do return math.max, 0 end
    return math.max, 0, endTime - TimeUtils.GetServerTime()
  end
  return math.maxinteger
end

return GuideNotePermTrainingSortUtil
