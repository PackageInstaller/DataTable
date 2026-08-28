local DataModel = {
  DailyBoxStatus = 0,
  DailyQuestCanAcceptCount = 0,
  DailyDefaultQuestNum = 0,
  QuestPond = {},
  AcceptedQuestInfo = {},
  QuestPondSelect = {},
  WeeklyQuestInfo = {},
  WeekSelectIdx = 1,
  CurQuestType = 0,
  QuestType = {Daily = 1, Weekly = 2},
  WeekDayTimeStampRecord = {},
  TodayInfo = {},
  PassStartTimeStamp = 0,
  PassEndTimeStamp = 0,
  IsInPassBattleTime = true,
  DailyBoxIndex = 0
}

function DataModel.InitBattlePassInfo()
  local state, battlePassId = PlayerData:GetNowPassData()
  if state == false then
    DataModel.IsInPassBattleTime = false
  end
  local battlePass = PlayerData:GetFactoryData(battlePassId, "BattlePassFactory")
  DataModel.PassStartTimeStamp = TimeUtil:TimeStamp(battlePass.PassStartTime)
  DataModel.PassEndTimeStamp = TimeUtil:TimeStamp(battlePass.PassEndTime)
  local serverNow = TimeUtil:GetServerTimeStamp()
  DataModel.IsInPassBattleTime = serverNow >= DataModel.PassStartTimeStamp and serverNow <= DataModel.PassEndTimeStamp
end

function DataModel.RefreshAllInfo()
  DataModel.RefreshTodayInfo()
  DataModel.InitBattlePassInfo()
  DataModel.CalcEveryWeekOpenTime()
  DataModel.RefreshDailyQuestAcceptInfo()
  DataModel.RefreshWeeklyQuestInfo()
  DataModel.RefreshQuestPondInfo()
  if PlayerData.ServerData.liveness_rewards ~= nil then
    local timeStamp = PlayerData.ServerData.liveness_rewards["0"]
    local record = os.date("*t", timeStamp)
    if record.day ~= DataModel.TodayInfo.day then
      PlayerData.ServerData.liveness_rewards = nil
    end
  end
  DataModel.DailyBoxIndex = PlayerData.ServerData.liveness_rewards and table.count(PlayerData.ServerData.liveness_rewards) or 0
end

function DataModel.RefreshTodayInfo()
  local serverTime = TimeUtil:GetServerTimeStamp()
  DataModel.TodayInfo = os.date("*t", serverTime)
end

function DataModel.RefreshDailyQuestAcceptInfo()
  local dailyQuestConfig = PlayerData:GetFactoryData(99900010, "ConfigFactory")
  local defaultQuest = dailyQuestConfig.defaultQuestList
  DataModel.AcceptedQuestInfo = {}
  local temp1 = {}
  local temp2 = {}
  local temp3 = {}
  for k, v in pairs(PlayerData.ServerData.quests.daily_quests) do
    local isDefault = false
    for k1, v1 in pairs(defaultQuest) do
      if v1.id == tonumber(k) then
        isDefault = true
        break
      end
    end
    local t = {}
    if isDefault == true or v.recv == 0 then
      t.id = tonumber(k)
      t.unlock = v.unlock
      t.recv = v.recv
      t.pcnt = v.pcnt
      t.isDefault = isDefault
      local levelFactory = PlayerData:GetFactoryData(t.id, "LevelFactory")
      t.maxPcnt = levelFactory.num
      t.pcnt = t.pcnt > t.maxPcnt and t.maxPcnt or t.pcnt
    end
    if isDefault and v.recv == 0 then
      table.insert(temp1, t)
    end
    if not isDefault and v.recv == 0 then
      table.insert(temp2, t)
    end
    if isDefault and v.recv > 0 then
      table.insert(temp3, t)
    end
  end
  DataModel.Sort1(temp1)
  DataModel.Sort1(temp2)
  DataModel.Sort1(temp3)
  
  local function f(t)
    for k, v in pairs(t) do
      table.insert(DataModel.AcceptedQuestInfo, v)
    end
  end
  
  f(temp1)
  f(temp2)
  local totalCount = #defaultQuest + dailyQuestConfig.questNum
  local startIdx = totalCount - #temp3 + 1
  for i = startIdx, totalCount do
    DataModel.AcceptedQuestInfo[i] = temp3[i - startIdx + 1]
  end
end

function DataModel.GetAccpetedQuestCount()
  local count = 0
  for k, v in pairs(DataModel.AcceptedQuestInfo) do
    if not v.isDefault then
      count = count + 1
    end
  end
  return count
end

function DataModel.RefreshWeeklyQuestInfo()
  DataModel.WeeklyQuestInfo = {}
  local weekCount = 0
  local state, battlePassId = PlayerData:GetNowPassData()
  if state then
    local seasonBattle = PlayerData:GetFactoryData(battlePassId, "BattlePassFactory")
    local passRewardList = seasonBattle.weekQuestList
    local maxWeekCount = #passRewardList
    for i = 0, maxWeekCount - 1 do
      local v = PlayerData.ServerData.quests.weekly_quests[tostring(i)]
      if v == nil then
        break
      end
      local t = {}
      local recvCount = 0
      for k1, v1 in pairs(v) do
        local t1 = {}
        if type(v1) == "table" then
          t1.id = tonumber(k1)
          t1.unlock = v1.unlock
          t1.recv = v1.recv
          t1.pcnt = v1.pcnt
          if 0 < t1.recv then
            recvCount = recvCount + 1
          end
          local levelFactory = PlayerData:GetFactoryData(t1.id, "LevelFactory")
          t1.maxPcnt = levelFactory.num
          t1.pcnt = t1.pcnt > t1.maxPcnt and t1.maxPcnt or t1.pcnt
        end
        table.insert(t, t1)
      end
      DataModel.Sort2(t)
      local t2 = {}
      t2.questList = t
      t2.recvCount = recvCount
      t2.openTime = DataModel.WeekDayTimeStampRecord[weekCount + 1] or 0
      table.insert(DataModel.WeeklyQuestInfo, t2)
      weekCount = weekCount + 1
    end
    for i = weekCount + 1, maxWeekCount do
      local t = {}
      t.questList = {}
      t.recvCount = 0
      t.openTime = DataModel.WeekDayTimeStampRecord[i] or 0
      table.insert(DataModel.WeeklyQuestInfo, t)
    end
  end
end

function DataModel.CalcEveryWeekOpenTime()
  DataModel.WeekDayTimeStampRecord = {}
  local state, battlePassId = PlayerData:GetNowPassData()
  if state then
    local battlePass = PlayerData:GetFactoryData(battlePassId, "BattlePassFactory")
    local startTime = battlePass.PassStartTime
    local startTimeStamp = TimeUtil:TimeStamp(startTime)
    local startTimeInfo = os.date("*t", startTimeStamp)
    table.insert(DataModel.WeekDayTimeStampRecord, startTimeStamp)
    local oneDayTime = 86400
    local wday = startTimeInfo.wday
    if wday == 1 then
      wday = 7
    else
      wday = wday - 1
    end
    startTimeStamp = startTimeStamp + (7 - wday + 1) * oneDayTime
    table.insert(DataModel.WeekDayTimeStampRecord, startTimeStamp)
    local weekCount = #battlePass.weekQuestList
    local weekTime = 7 * oneDayTime
    for i = 3, weekCount do
      startTimeStamp = startTimeStamp + weekTime
      table.insert(DataModel.WeekDayTimeStampRecord, startTimeStamp)
    end
  end
end

function DataModel.RefreshQuestPondInfo()
  DataModel.QuestPondSelect = {}
  DataModel.QuestPond = {}
  for k, v in pairs(PlayerData.ServerData.quests.daily_pool) do
    local t = {}
    t.id = v
    t.select = false
    table.insert(DataModel.QuestPond, t)
  end
  DataModel.Sort1(DataModel.QuestPond)
end

function DataModel.ClearQuestPondSelectInfo()
  for k, v in pairs(DataModel.QuestPond) do
    v.select = false
  end
  DataModel.QuestPondSelect = {}
end

function DataModel.CalcRewardToBattlePassScore(id)
  id = tonumber(id)
  local questCA = PlayerData:GetFactoryData(id, "QuestFactory")
  for k, v in pairs(questCA.rewardsList) do
    local id = tonumber(v.id)
    local itemCA = PlayerData:GetFactoryData(id, "ItemFactory")
    if itemCA.mod == "\233\128\154\232\161\140\232\175\129\233\129\147\229\133\183" then
      local passKind = tonumber(itemCA.battlePassKind) or 1
      local points = itemCA.battlePassEXP or 0
      local passData = PlayerData:GetBattlePass(passKind)
      if passData then
        passData.points = (passData.points or 0) + (points or 0)
      end
    end
  end
end

function DataModel.Sort1(t)
  table.sort(t, function(a, b)
    local questCA1 = PlayerData:GetFactoryData(a.id, "QuestFactory")
    local questCA2 = PlayerData:GetFactoryData(b.id, "QuestFactory")
    if EnumDefine.QuestRarityNum[questCA1.Rarity] > EnumDefine.QuestRarityNum[questCA2.Rarity] then
      return true
    elseif EnumDefine.QuestRarityNum[questCA1.Rarity] == EnumDefine.QuestRarityNum[questCA2.Rarity] and questCA1.sort > questCA2.sort then
      return true
    end
    return false
  end)
end

function DataModel.Sort2(t)
  table.sort(t, function(a, b)
    if a.recv ~= nil and b.recv ~= nil then
      if a.recv > 0 and b.recv == 0 then
        return false
      elseif a.recv == 0 and b.recv > 0 then
        return true
      else
        local questCA1 = PlayerData:GetFactoryData(a.id, "QuestFactory")
        local questCA2 = PlayerData:GetFactoryData(b.id, "QuestFactory")
        if EnumDefine.QuestRarityNum[questCA1.Rarity] > EnumDefine.QuestRarityNum[questCA2.Rarity] then
          return true
        elseif EnumDefine.QuestRarityNum[questCA1.Rarity] == EnumDefine.QuestRarityNum[questCA2.Rarity] and questCA1.sort > questCA2.sort then
          return true
        end
      end
    end
    return false
  end)
end

return DataModel
