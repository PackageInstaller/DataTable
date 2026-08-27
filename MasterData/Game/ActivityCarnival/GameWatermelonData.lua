local GameWatermelonData = class("GameWatermelonData")
local TinyGameEnum = require("Game.TinyGames.TinyGameEnum")

function GameWatermelonData:ctor(uid, gameId)
  self._uid = uid
  self._gameId = gameId
  self._cfg = ConfigData.mash_up[gameId]
  self:__GetTinyGameData()
end

function GameWatermelonData:GetWatermeScore(index)
  return self._cfg.score_per_ball[index] or 0
end

function GameWatermelonData:GetWatermeRank()
  local allFriendData = self:__GenFirendScoreData() or {}
  local mineGrade = self:__GenMineScoreData()
  table.insert(allFriendData, mineGrade)
  self:__SortFriendData(allFriendData)
  return allFriendData, mineGrade
end

function GameWatermelonData:UploadWatermelonScore(score, callback)
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNet:CS_TinyGame_Settle(self._uid, score, callback)
end

function GameWatermelonData:GetWatermeHistoryScore()
  if self._gameData == nil then
    self:__GetTinyGameData()
  end
  return self._gameData ~= nil and self._gameData:GetTinyGameHighest() or 0
end

function GameWatermelonData:__GetTinyGameData()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._gameData = activityFrameCtrl:GetTinyGameData(self._uid)
end

function GameWatermelonData:__GenFirendScoreData()
  if not PlayerDataCenter.friendDataCenter:IsFriendDataCenterInited() then
    return nil
  end
  local friendsData = PlayerDataCenter.friendDataCenter:GetFreindList()
  if friendsData == nil or #friendsData <= 0 then
    return nil
  end
  local allScoreGrades = {}
  for _, v in ipairs(friendsData) do
    local eachFriendGrade = {}
    eachFriendGrade.name = v:GetUserName()
    eachFriendGrade.score = 0
    eachFriendGrade.uid = v:GetUserUID()
    local tinyGame = v:GetTinyGameData(TinyGameEnum.eType.ballMerge, self._gameId)
    if tinyGame ~= nil then
      eachFriendGrade.score = tinyGame.score
    end
    table.insert(allScoreGrades, eachFriendGrade)
  end
  return allScoreGrades
end

function GameWatermelonData:__GenMineScoreData()
  if self._mineGrade == nil then
    self._mineGrade = {}
  end
  self._mineGrade.name = PlayerDataCenter:GetSelfName()
  self._mineGrade.uid = PlayerDataCenter:GetSelfId()
  self._mineGrade.score = self._gameData ~= nil and self._gameData:GetTinyGameHighest() or 0
  return self._mineGrade
end

function GameWatermelonData:__SortFriendData(allFriendData)
  if #allFriendData <= 1 then
    return
  end
  table.sort(allFriendData, function(a, b)
    if a.score == b.score then
      return a.uid < b.uid
    else
      return a.score > b.score
    end
  end)
end

return GameWatermelonData
