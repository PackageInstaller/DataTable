local HTGPlayerBase = class("HTGPlayerBase")

function HTGPlayerBase:ctor(tinyGameData, selfHistoryHighScore, playEndTime)
  self.__tinyGameData = tinyGameData
  self.__tinyGameUID = tinyGameData:GetTinyGameUid()
  self.__tinyGameType = tinyGameData:GetTinyGameCat()
  self.__tinyGameInstanceId = tinyGameData:GetTinyGameId()
  self.__playEndTime = playEndTime
  self.__selfHistoryHighScore = selfHistoryHighScore
  self.__selfHighScore = tinyGameData:GetTinyGameHighest()
  self.__rankData = {}
  self:InitTinyGameData()
  self:UpdateRankData()
end

function HTGPlayerBase:InitTinyGameData()
end

function HTGPlayerBase:EnterTinyGame()
  error("please write specific tiny game enter func for every tiny game")
end

function HTGPlayerBase:UpdateSelfHighScore()
  self.__selfHighScore = self.__tinyGameData:GetTinyGameHighest()
  return self.__selfHighScore
end

function HTGPlayerBase:UpdateRankData()
  local mineGrade = self:__CreateMineGrade()
  local allFriendData = self:__GetFriendGradeData() or {}
  table.insert(allFriendData, mineGrade)
  self:__SortRankData(allFriendData)
  self.__rankData.mineGrade = mineGrade
  self.__rankData.allFriendData = allFriendData
end

function HTGPlayerBase:__CreateMineGrade()
  if self.mineGrade == nil then
    self.mineGrade = {}
  end
  self.mineGrade.uid = PlayerDataCenter:GetSelfId()
  self.mineGrade.name = PlayerDataCenter:GetSelfName()
  self.mineGrade.score = self.__selfHighScore
  return self.mineGrade
end

function HTGPlayerBase:__GetFriendGradeData()
  if not PlayerDataCenter.friendDataCenter:IsFriendDataCenterInited() then
    return nil
  end
  local friendDataList = PlayerDataCenter.friendDataCenter:GetFreindList()
  if friendDataList == nil or #friendDataList <= 0 then
    return nil
  end
  local allGrades = {}
  for _, friendData in ipairs(friendDataList) do
    local eachFriendGrade = {}
    eachFriendGrade.uid = friendData:GetUserUID()
    eachFriendGrade.name = friendData:GetUserName()
    eachFriendGrade.score = 0
    local tinyGameData = friendData:GetTinyGameData(self.__tinyGameType, self.__tinyGameInstanceId)
    if tinyGameData ~= nil then
      eachFriendGrade.score = tinyGameData.score
    end
    table.insert(allGrades, eachFriendGrade)
  end
  return allGrades
end

function HTGPlayerBase:__SortRankData(allFriendData)
  if 1 < #allFriendData then
    table.sort(allFriendData, function(a, b)
      if a.score == b.score then
        return a.uid < b.uid
      else
        return a.score > b.score
      end
    end)
  end
end

function HTGPlayerBase:GetHTGMineRank()
  if self.__rankData.mineGrade == nil then
    return 0
  end
  if self.__rankData.allFriendData == nil then
    return 1
  end
  return table.indexof(self.__rankData.allFriendData, self.__rankData.mineGrade)
end

function HTGPlayerBase:GetTinyGameType()
  return self.__tinyGameType
end

function HTGPlayerBase:GetPlayEndTime()
  return self.__playEndTime or 0
end

function HTGPlayerBase:GetPlayEndTimeStr()
  local time = self:GetPlayEndTime()
  local date = TimeUtil:TimestampToDate(time)
  return string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
end

function HTGPlayerBase:GetHTGRankData()
  self:UpdateRankData()
  return self.__rankData
end

function HTGPlayerBase:GetHTGHistoryHighScore()
  return self.__selfHistoryHighScore or 0
end

function HTGPlayerBase:HTGCommonSettle(score, callback)
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNet:CS_TinyGame_Settle(self.__tinyGameUID, score, function(msg)
    if msg.Count <= 0 then
      error("CS_TinyGame_Settle msg.Count error:" .. tostring(msg.Count))
      return
    end
    local tinyGameCenterElem = msg[0]
    if tinyGameCenterElem.highest > self:GetHTGHistoryHighScore() then
      self.__selfHistoryHighScore = tinyGameCenterElem.highest
    end
    self:UpdateSelfHighScore()
    self:UpdateRankData()
    if callback ~= nil then
      callback(tinyGameCenterElem)
    end
  end)
end

return HTGPlayerBase
