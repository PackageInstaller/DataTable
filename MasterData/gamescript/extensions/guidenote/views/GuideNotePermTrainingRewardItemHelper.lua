local GuideNotePermTrainingRewardItemHelper = {}

function GuideNotePermTrainingRewardItemHelper.BuildSeasonTaskRewardItemData(viewSelf, gameObj, reward, seasonId, gameplayType, refreshCallback)
  if not reward or not reward.tid then
    return {itemTid = 0, itemCount = 0}
  end
  local seasonTaskId
  if SeasonRotationCfgUtils and SeasonRotationCfgUtils.GetSeasonTaskId then
    seasonTaskId = SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, gameplayType)
  end
  return {
    itemTid = reward.tid,
    itemCount = reward.num,
    clickFunc = function()
      if not seasonTaskId then
        return
      end
      if not TaskDataUtils.IsTaskCanReward(seasonTaskId) then
        local binder = viewSelf and viewSelf.binder or nil
        local transform = gameObj and gameObj.transform or nil
        ItemDataUtils.ShowItemDetailTips(binder, transform, nil, reward.tid)
        return
      end
      TaskDataUtils.TaskComplete(seasonTaskId, function()
        if refreshCallback then
          refreshCallback()
        end
      end)
    end,
    isGotFunc = function()
      if not seasonTaskId then
        return false
      end
      do return TaskDataUtils.TaskFinshAndGetedAward end
      return TaskDataUtils.TaskFinshAndGetedAward, seasonTaskId
    end,
    isShowRing = function()
      if not seasonTaskId then
        return false
      end
      do return TaskDataUtils.IsTaskCanReward end
      return TaskDataUtils.IsTaskCanReward, seasonTaskId
    end
  }
end

function GuideNotePermTrainingRewardItemHelper.BuildAbyssRewardItemData(reward)
  if not reward or not reward.tid then
    return {itemTid = 0, itemCount = 0}
  end
  return {
    itemTid = reward.tid,
    itemCount = reward.num
  }
end

return GuideNotePermTrainingRewardItemHelper
