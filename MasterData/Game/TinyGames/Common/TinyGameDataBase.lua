local TinyGameDataBase = class("TinyGameDataBase")
local TinyGameUtil = require("Game.TinyGames.TinyGameUtil")

function TinyGameDataBase:ctor(uid, gameId, cat)
  self._uid = uid
  self._cat = cat
  self._gameId = gameId
  self:__GetTinyGameData()
end

function TinyGameDataBase:__GetTinyGameData()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._gameData = activityFrameCtrl:GetTinyGameData(self._uid)
end

function TinyGameDataBase:GetTinyGameHistoryScore()
  if self._gameData == nil then
    self:__GetTinyGameData()
  end
  return self._gameData ~= nil and self._gameData:GetTinyGameHighest() or 0
end

function TinyGameDataBase:GetTinyGameRankInfo()
  local mineGrade = TinyGameUtil.CreateMineTinyGameGrade(self:GetTinyGameHistoryScore())
  local allFriendRanks = TinyGameUtil.CreateFriendTinyGameDatas(self._cat, self._gameId)
  table.insert(allFriendRanks, mineGrade)
  return allFriendRanks, mineGrade
end

function TinyGameDataBase:UploadTinyGameScore(score, callback)
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNet:CS_TinyGame_Settle(self._uid, score, callback)
end

function TinyGameDataBase:GetTinyGameRewardLevelPoint()
  if self._gameData == nil then
    self:__GetTinyGameData()
  end
  return self._gameData ~= nil and self._gameData:GetTinyGameRewardLevelPoint() or 0
end

function TinyGameDataBase:SetTinyGameRewardLevelPoint(point)
  if self._gameData == nil then
    self:__GetTinyGameData()
  end
  if self._gameData ~= nil then
    self._gameData:SetTinyGameRewardLevelPoint(point)
  end
end

function TinyGameDataBase:GetTinyGameRewardGotLv()
  if self._gameData == nil then
    self:__GetTinyGameData()
  end
  return self._gameData ~= nil and self._gameData:GetTinyGameRewardGotLv() or 0
end

function TinyGameDataBase:SetTinyGameRewardGotLv(level)
  if self._gameData == nil then
    self:__GetTinyGameData()
  end
  if self._gameData ~= nil then
    self._gameData:SetTinyGameRewardGotLv(level)
  end
end

return TinyGameDataBase
