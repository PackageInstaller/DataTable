local DataModel = {}

function DataModel:Init(id)
  DataModel.dropList = {}
  DataModel.openIndex = nil
  DataModel.chooseLevelData = {}
  DataModel.activityCA = PlayerData:GetFactoryData(id)
  DataModel.signBattleLevelList = DataModel.activityCA.signLevelList
  local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
  DataModel.maxEnergy = PlayerData:GetUserInfo().max_energy or initConfig.energyMax
  DataModel.listCount = #DataModel.activityCA.signLevelList + 2
  DataModel.imgPath = "UI/Activity/ActivitySignBattle/Images_Shana/index_"
end

function DataModel:SetSignBattleData(json)
  DataModel.signBattleData = json.cs_activity or {}
end

function DataModel.GetBattleData(id)
  if id then
    DataModel.activityCA = PlayerData:GetFactoryData(id)
  end
  local cs_activity = DataModel.signBattleData
  local data = cs_activity[tostring(DataModel.activityCA.id)]
  return data
end

function DataModel.GetCurrentIndex()
  local index = 0
  local data = DataModel.GetBattleData()
  if data == nil then
    return index
  end
  index = #data.pass_level_index
  if index > #DataModel.signBattleLevelList - 1 then
    index = #DataModel.signBattleLevelList - 1
  end
  return index
end

function DataModel.GetUnlockIndex()
  local data = DataModel.GetBattleData()
  if data and data.unlock_level_max_index ~= nil then
    return data.unlock_level_max_index
  end
  return 0
end

function DataModel.GetFinishIndex(index)
  local data = DataModel.GetBattleData()
  if data and data.pass_level_index[index] ~= nil then
    return true
  end
  return false
end

function DataModel:SetDropList(levelCA)
  DataModel.dropList = {}
  local isReceived = PlayerData:GetLevelFirstRewardsReceived(levelCA.id)
  local firstPassAward = levelCA.firstPassAward
  for i = 1, #firstPassAward do
    table.insert(DataModel.dropList, {
      num = firstPassAward[i].num,
      id = firstPassAward[i].itemId,
      type = 1,
      isFinish = isReceived,
      index = #DataModel.dropList
    })
  end
  local dropListNew = PlayerData:GetLevelDropList(levelCA)
  for i = 1, #dropListNew do
    table.insert(DataModel.dropList, {
      num = dropListNew[i].num,
      id = dropListNew[i].id,
      type = 2,
      index = #DataModel.dropList
    })
  end
  if isReceived == true then
    table.sort(DataModel.dropList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type > b.type
    end)
  else
    table.sort(DataModel.dropList, function(a, b)
      if a.type == b.type then
        return a.index < b.index
      end
      return a.type < b.type
    end)
  end
end

return DataModel
