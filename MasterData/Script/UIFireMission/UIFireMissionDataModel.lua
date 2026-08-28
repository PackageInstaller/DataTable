local DataModel = {
  initParams = {},
  decodeParams = {},
  questInfo = {}
}

function DataModel.InitQuestInfo()
  DataModel.questInfo = {}
  local activityCA = PlayerData:GetFactoryData(DataModel.decodeParams.activityId)
  local serverActivityQuest = PlayerData.ServerData.quests.activity_quests
  for i, v in ipairs(activityCA.PersonalProgressList) do
    local detailServer = serverActivityQuest[tostring(v.id)]
    local t = {}
    t.id = v.id
    t.pcnt = detailServer and detailServer.pcnt or 0
    t.idx = i
    t.state = PlayerData.GetQuestState(t.id)
    DataModel.questInfo[i] = t
  end
  DataModel.SortQuestInfo()
end

function DataModel.SortQuestInfo()
  table.sort(DataModel.questInfo, function(a, b)
    if a.state == EnumDefine.EQuestState.Finish and b.state ~= EnumDefine.EQuestState.Finish then
      return true
    end
    if a.state ~= EnumDefine.EQuestState.Finish and b.state == EnumDefine.EQuestState.Finish then
      return false
    end
    if a.state == EnumDefine.EQuestState.UnFinish and b.state ~= EnumDefine.EQuestState.UnFinish then
      return true
    end
    if a.state ~= EnumDefine.EQuestState.UnFinish and b.state == EnumDefine.EQuestState.UnFinish then
      return false
    end
    if a.state == EnumDefine.EQuestState.Receive and b.state ~= EnumDefine.EQuestState.Receive then
      return false
    end
    if a.state ~= EnumDefine.EQuestState.Receive and b.state == EnumDefine.EQuestState.Receive then
      return true
    end
    return a.idx < b.idx
  end)
end

function DataModel.IsHadQuestCanGet(activityId)
  local activityCA = PlayerData:GetFactoryData(activityId)
  if activityCA then
    for i, v in ipairs(activityCA.PersonalProgressList) do
      if PlayerData.GetQuestState(v.id) == EnumDefine.EQuestState.Finish then
        return true
      end
    end
  end
  return false
end

function DataModel.GetQuestCompletePercent(activityId)
  local activityCA = PlayerData:GetFactoryData(activityId)
  local totalCount = 1
  local completeCount = 0
  if activityCA then
    totalCount = #activityCA.PersonalProgressList
    for i, v in ipairs(activityCA.PersonalProgressList) do
      if PlayerData.GetQuestState(v.id) == EnumDefine.EQuestState.Receive then
        completeCount = completeCount + 1
      end
    end
  end
  return completeCount / totalCount
end

return DataModel
