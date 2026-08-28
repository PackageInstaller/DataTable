local DataModel = {
  activityId = nil,
  activityCA = {},
  NPCDialogEnum = {enterText = "enterText", talkText = "talkText"},
  remainTime = 1,
  reward = nil,
  lastDay = 0,
  progressNum = 0
}

function DataModel:Init(parms)
  DataModel.reward = nil
  DataModel.activityId = parms.activityId
  DataModel.activityCA = PlayerData:GetFactoryData(DataModel.activityId)
end

return DataModel
