local DataModel = {
  activityId = nil,
  eventList = {},
  eventObjList = {},
  indexSelected = 0,
  isOpenBtnList = -1,
  lastHour = 0,
  isBuffer = true,
  lastHourBuffer = 0,
  eventId = nil,
  isAuto = false,
  autoTypeList = {},
  typeIndexList = {
    1,
    2,
    3,
    4
  }
}

function DataModel:Init(parms)
  DataModel.activityId = parms.activityId
  DataModel.eventList = {}
  DataModel.isBattleReturn = parms.isBattleReturn
  if DataModel.indexSelected ~= 0 then
    DataModel.indexSelected = parms.indexSelected or 0
  end
  DataModel.isOpenBtnList = parms.isOpenBtnList or -1
  DataModel.eventId = parms.eventId
  local serverTime = TimeUtil:GetServerTimeStamp()
  local targetTimeBuffer = TimeUtil:GetNextSpecialTimeStamp(5, 1, 0)
  local timeTableBuffer = TimeUtil:SecondToTable(targetTimeBuffer - serverTime)
  local targetTime = TimeUtil:GetNextSpecialTimeStamp(5, 0, 5)
  local timeTable = TimeUtil:SecondToTable(targetTime - serverTime)
  if 0 < timeTableBuffer.hour or timeTableBuffer.hour == 0 and 1 <= timeTableBuffer.minute then
    DataModel.lastHour = timeTable.hour
    DataModel.isBuffer = false
  else
    DataModel.isBuffer = true
  end
end

function DataModel:SetEventData(json)
  DataModel.eventList = {}
  for a, b in pairs(json.hidden_event) do
    local row = {}
    row.typeIndex = 1
    row.type = "hidden"
    row.posIndex = tonumber(a)
    row.eventId = tonumber(b)
    row.iconIndex = 5
    row.eventIndex = a
    local polluteCfg = PlayerData:GetFactoryData(99900056, "ConfigFactory")
    local clickList = polluteCfg.ClickHiddenEventList
    for i = 1, #clickList do
      if clickList[i].id == row.eventId then
        row.lv = math.floor((clickList[i].enemyLvMin + clickList[i].enemyLvMax) / 2)
        break
      end
    end
    table.insert(DataModel.eventList, row)
  end
  for k, v in pairs(json.scan_pollute_events) do
    if v.click_dungeon_events then
      for a, b in pairs(v.click_dungeon_events) do
        local row = {}
        row.areaId = tonumber(k)
        row.typeIndex = 2
        row.type = "dungeon"
        row.posIndex = tonumber(a)
        row.eventId = tonumber(b)
        local eventCA = PlayerData:GetFactoryData(row.eventId, "AFKEventFactory")
        row.iconIndex = eventCA.dungeonTypeIndex
        row.eventIndex = a
        local num = PlayerData:GetDungeonNum(row.areaId, row.eventIndex)
        local indexL = 1
        for i, v in ipairs(eventCA.levelList) do
          if num >= v.count then
            indexL = i
          end
        end
        local tempIndex = indexL > #eventCA.levelList2 and #eventCA.levelList2 or indexL
        local lvListId = eventCA.levelList2[tempIndex].id
        local list = PlayerData:GetFactoryData(lvListId, "ListFactory")
        local lvList = list.lvList
        local completeNum = PlayerData:GetDungeonCompleteNum(row.eventId)
        local lvIndex = completeNum + 1
        row.lv = lvList[lvIndex > #lvList and #lvList or lvIndex].lv
        table.insert(DataModel.eventList, row)
      end
    end
    if v.click_level_events then
      for a, b in pairs(v.click_level_events) do
        local row = {}
        row.areaId = tonumber(k)
        row.typeIndex = 3
        row.type = "pollute"
        row.posIndex = tonumber(a)
        row.eventId = tonumber(b)
        row.eventIndex = a
        row.iconIndex = 3
        local eventCA = PlayerData:GetFactoryData(row.eventId, "AFKEventFactory")
        local levelId = eventCA.levelId
        local levelCA = PlayerData:GetFactoryData(levelId, "LevelFactory")
        local user_lv = PlayerData:GetUserInfo().lv
        if levelCA.isEnemyLvEquilsPlayer then
          row.lv = user_lv + levelCA.enemyLvOffset
        else
          row.lv = levelCA.recomGrade
        end
        table.insert(DataModel.eventList, row)
      end
    end
    if v.click_resident_events then
      for a, b in pairs(v.click_resident_events) do
        local row = {}
        row.areaId = tonumber(k)
        row.typeIndex = 4
        row.type = "resident"
        local values = string.split(a, ":")
        row.listId = tonumber(values[1])
        row.posIndex = tonumber(values[2])
        row.eventId = tonumber(b)
        row.eventIndex = a
        row.iconIndex = 4
        local t = string.split(row.eventIndex, ":")
        local areaCA = PlayerData:GetFactoryData(row.areaId, "AreaFactory")
        if areaCA.ClickLevelList and table.count(areaCA.ClickLevelList) then
          for k, v in pairs(areaCA.ClickLevelList) do
            if tonumber(v.id) == tonumber(t[1]) then
              row.lv = math.floor((v.levelLvMax + v.levelLvMin) / 2)
              break
            end
          end
        end
        table.insert(DataModel.eventList, row)
      end
    end
  end
  table.sort(DataModel.eventList, function(a, b)
    if a.typeIndex == b.typeIndex then
      return a.lv > b.lv
    end
    return a.typeIndex < b.typeIndex
  end)
end

return DataModel
