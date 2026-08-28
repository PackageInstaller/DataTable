local DataModel = {IsAutoDungeon = 0, AutoStep = 0}

function DataModel:SetDropList(levelCA)
  DataModel.ChooseRewardList = {}
  local isReceived = PlayerData:GetLevelFirstRewardsReceived(levelCA.id)
  local firstPassAward = levelCA.firstPassAward
  for i = 1, #firstPassAward do
    local id = firstPassAward[i].itemId
    local cfg = PlayerData:GetFactoryData(id)
    local quality = cfg.qualityInt == nil and 1 or cfg.qualityInt + 1
    table.insert(DataModel.ChooseRewardList, {
      num = firstPassAward[i].num,
      id = firstPassAward[i].itemId,
      type = 1,
      isFinish = isReceived,
      index = #DataModel.ChooseRewardList,
      quality = quality
    })
  end
  local dropListNew = PlayerData:GetLevelDropList(levelCA)
  for i = 1, #dropListNew do
    local id = dropListNew[i].id
    local cfg = PlayerData:GetFactoryData(id)
    local quality = cfg.qualityInt == nil and 1 or cfg.qualityInt + 1
    table.insert(DataModel.ChooseRewardList, {
      num = dropListNew[i].num,
      id = dropListNew[i].id,
      type = 2,
      index = #DataModel.ChooseRewardList,
      quality = quality
    })
  end
  
  local function ContainsItem(list, item)
    for i = 1, #list do
      if list[i].id == item.id then
        return true
      end
    end
    return false
  end
  
  for i = 1, #levelCA.randWaveList do
    local waveListCA = PlayerData:GetFactoryData(levelCA.randWaveList[i].waveListId)
    if waveListCA then
      for m = 1, #waveListCA.enemyRandWaveList do
        local waveCA = PlayerData:GetFactoryData(waveListCA.enemyRandWaveList[m].id)
        local waveDropList = waveCA.dropTableList
        for j = 1, #waveDropList do
          local dropCA = PlayerData:GetFactoryData(waveDropList[j].listId)
          for k = 1, #dropCA.leveldropList do
            if not ContainsItem(DataModel.ChooseRewardList, dropCA.leveldropList[k]) then
              local id = dropCA.leveldropList[k].id
              local cfg = PlayerData:GetFactoryData(id)
              local quality = cfg.qualityInt == nil and 1 or cfg.qualityInt + 1
              table.insert(DataModel.ChooseRewardList, {
                num = nil,
                id = id,
                type = 2,
                index = #DataModel.ChooseRewardList,
                quality = quality
              })
            end
          end
        end
      end
    end
  end
  if isReceived == true then
    table.sort(DataModel.ChooseRewardList, function(a, b)
      if a.type == b.type then
        if a.quality == b.quality then
          if a.id == b.id or a.id < 80300000 and b.id < 80300000 then
            return a.index < b.index
          else
            return a.id < b.id
          end
        else
          return a.quality > b.quality
        end
      end
      return a.type > b.type
    end)
  else
    table.sort(DataModel.ChooseRewardList, function(a, b)
      if a.type == b.type then
        if a.quality == b.quality then
          if a.id == b.id or a.id < 80300000 and b.id < 80300000 then
            return a.index < b.index
          else
            return a.id < b.id
          end
        else
          return a.quality > b.quality
        end
      end
      return a.type < b.type
    end)
  end
end

return DataModel
