local DataModel = {rewardState = 1}
DataModel.BtnEnm = {
  unFinish = 1,
  finish = 2,
  receive = 3
}

function DataModel:Init()
  DataModel.activityCA = PlayerData:GetFactoryData(DataModel.activityId)
  DataModel.maxLevel = #DataModel.activityCA.signLevelList
  DataModel.end_Ts = nil
end

function DataModel:GetRewardButtonIsActive(id)
  local cs_activity = DataModel.signBattleData
  if id then
    DataModel.activityId = id
    DataModel:Init()
  end
  local data = cs_activity[tostring(DataModel.activityId)]
  if table.count(cs_activity) == 0 or data == nil or #data.pass_level_index ~= DataModel.maxLevel then
    return DataModel.BtnEnm.unFinish
  end
  if #data.pass_level_index == DataModel.maxLevel and data.reward == false then
    return DataModel.BtnEnm.finish
  end
  if data.reward == true then
    return DataModel.BtnEnm.receive
  end
end

function DataModel:SetSignBattleData(json)
  DataModel.signBattleData = json.cs_activity or {}
end

return DataModel
