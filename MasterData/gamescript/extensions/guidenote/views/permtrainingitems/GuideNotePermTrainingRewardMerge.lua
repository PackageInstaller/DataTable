local GuideNotePermTrainingRewardMerge = {}

function GuideNotePermTrainingRewardMerge.MergeRewardsByTid(rewardList)
  if type(rewardList) ~= "table" or #rewardList <= 0 then
    return {}
  end
  local mergedMap = {}
  local orderedTids = {}
  for _, reward in ipairs(rewardList) do
    local tid = reward and reward.tid or 0
    local num = reward and reward.num or 0
    if 0 ~= tid and num > 0 then
      if nil == mergedMap[tid] then
        mergedMap[tid] = num
        table.insert(orderedTids, tid)
      else
        mergedMap[tid] = mergedMap[tid] + num
      end
    end
  end
  local mergedList = {}
  for _, tid in ipairs(orderedTids) do
    table.insert(mergedList, {
      tid = tid,
      num = mergedMap[tid] or 0
    })
  end
  return mergedList
end

return GuideNotePermTrainingRewardMerge
