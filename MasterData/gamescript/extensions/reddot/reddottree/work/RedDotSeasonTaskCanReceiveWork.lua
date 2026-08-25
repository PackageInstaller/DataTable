local RedDotSeasonTaskCanReceiveWork, Super = System.NewPoolClass("RedDotSeasonTaskCanReceiveWork", RedDotSingleFlow)

function RedDotSeasonTaskCanReceiveWork:ctor(gameplayType, featureId, featureKey)
  Super.ctor(self, "赛季玩法任务可领奖")
  self.gameplayType = gameplayType
  self.featureId = featureId
  self.featureKey = featureKey or 0
end

function RedDotSeasonTaskCanReceiveWork:Execute()
  if self.featureId then
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(self.featureId, self.featureKey)
    if not unlocked then
      return false
    end
  end
  if RedPointDataUtils.IsSeasonGameplayTaskRewardAvailable(self.gameplayType) then
    return RedDotDefine.RedDotType.Red
  end
  return false
end

return RedDotSeasonTaskCanReceiveWork
