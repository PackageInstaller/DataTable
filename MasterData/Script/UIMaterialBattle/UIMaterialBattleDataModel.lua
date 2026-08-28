local DataModel = {
  ActivityId = nil,
  BattleList = {},
  BattleLeftIndex = 1,
  ChooseLeftData = {},
  BattleCurrentNum = 0
}

function DataModel:BattleInit()
  local stageBattleLabel = PlayerData:GetFactoryData(99900001).stageBattleLabel
  for k, v in pairs(stageBattleLabel) do
    DataModel.BattleList[k] = {}
    DataModel.BattleList[k].nameText = GetText(v.nameText)
    DataModel.BattleList[k].desText = GetText(v.desText)
    DataModel.BattleList[k].nodeName = v.nodeName
    DataModel.BattleList[k].prefabPath = v.prefabPath
    local path = string.split(v.prefabPath, "/")[4]
    local modelPath = "UI" .. path .. "/UI" .. path .. "DataModel"
    local levelConfig = require(modelPath).GetConfig()
    local materialLevelGroupList = levelConfig.materialLevelGroupList
    DataModel.BattleList[k].modelPath = modelPath
    DataModel.BattleList[k].materialLevelTimes = levelConfig.materialLevelTimes
    local materialRefreshType = levelConfig.materialRefreshType
    local targetTime
    if materialRefreshType == "Week" then
      targetTime = TimeUtil:GetNextWeekTime(1, 5)
    else
      targetTime = TimeUtil:GetNextSpecialTimeStamp(5, 0, 0, TimeUtil:GetServerTimeStamp())
    end
    DataModel.BattleList[k].targetTime = targetTime
    DataModel.BattleList[k].data = {}
    for c, d in pairs(materialLevelGroupList) do
      local levelCA = PlayerData:GetFactoryData(d.id)
      local row = {}
      row.index = c
      row.id = d.id
      row.cost = levelCA.cost
      row.name = levelCA.name
      row.spineScale = levelCA.spineScale
      row.spineX = levelCA.spineX
      row.spineY = levelCA.spineY
      row.resDir = PlayerData:GetFactoryData(levelCA.bossViewId).resDir
      row.rewardViewList = levelCA.rewardViewList
      local isActivity = false
      row.openDay = levelCA.openDay
      row.minDay = nil
      if 0 < #levelCA.openDay then
        for m, n in pairs(levelCA.openDay) do
          if TimeUtil:CheckWDay(n.week, 5) == true then
            isActivity = true
            break
          end
          row.minDay = row.minDay == nil and n.week or math.min(row.minDay, n.week)
        end
      else
        isActivity = true
      end
      row.isActivity = isActivity
      row.isActivityInt = isActivity == true and 1 or 0
      row.closedTextId = levelCA.closedTextId
      table.insert(DataModel.BattleList[k].data, row)
    end
    table.sort(DataModel.BattleList[k].data, function(a, b)
      if a.isActivityInt == 0 and b.isActivityInt == 0 then
        if a.minDay == b.minDay then
          return a.index < b.index
        end
        return a.minDay < b.minDay
      end
      if a.isActivityInt == 1 and b.isActivityInt == 1 then
        return a.index < b.index
      end
      return a.isActivityInt > b.isActivityInt
    end)
  end
  DataModel.ChooseLeftData = {}
end

function DataModel:SetBattleLeftListIndex(index)
  index = index or 1
  DataModel.BattleLeftIndex = index
  local currentData = DataModel.BattleList[DataModel.BattleLeftIndex]
  DataModel.ChooseLeftData = currentData.data
  local modelPath = currentData.modelPath
  DataModel.BattleCurrentNum = require(modelPath).CurrentNum
end

return DataModel
