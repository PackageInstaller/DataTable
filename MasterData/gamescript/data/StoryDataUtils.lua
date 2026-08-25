local StoryDataUtils = {}

function StoryDataUtils.ResetStoryData()
  local key = CommonDefine.LocalSaveKey.AutoStory
  DataCenter.storyData.AutoPlay = MobileFileDataManager.Instance:GetPlayerFileValue(key, false)
  DataCenter.storyData.StepPlay = false
  DataCenter.storyData.NpcUid = 0
end

function StoryDataUtils.GetNpcUid()
  DataCenter.storyData.NpcUid = DataCenter.storyData.NpcUid - 1
  return DataCenter.storyData.NpcUid
end

function StoryDataUtils.GetStoryData(storyId)
  return DT["Story.Story_" .. storyId]
end

function StoryDataUtils.GetNodeData(storyId, nodeId)
  local storyConfig = StoryDataUtils.GetStoryData(storyId)
  return storyConfig.NodeList[nodeId]
end

return StoryDataUtils
