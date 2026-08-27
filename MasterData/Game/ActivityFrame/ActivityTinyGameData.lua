local ActivityTinyGameData = class("ActivityTinyGameData")
local TinyGameEnum = require("Game.TinyGames.TinyGameEnum")

function ActivityTinyGameData:UpdateTinyGameData(tinyGameMsg)
  self._uid = tinyGameMsg.uid
  self._id = tinyGameMsg.id
  self._cat = tinyGameMsg.cat
  self._actLongId = tinyGameMsg.actLongId
  self._score = tinyGameMsg.score
  self._highest = tinyGameMsg.highest
  if tinyGameMsg.rewardLv ~= nil then
    self._point = tinyGameMsg.rewardLv.point
    self._rewardGotLv = tinyGameMsg.rewardLv.rewardGotLv
  end
  if tinyGameMsg.scoreMap ~= nil then
    self.tiniGameSubLevelScoreMap = tinyGameMsg.scoreMap
  end
end

function ActivityTinyGameData:GetTinyGameUid()
  return self._uid
end

function ActivityTinyGameData:GetTinyGameId()
  return self._id
end

function ActivityTinyGameData:GetTinyGameCat()
  return self._cat
end

function ActivityTinyGameData:GetTinyGameActFrameId()
  return self._actLongId
end

function ActivityTinyGameData:GetTinyGameHighest()
  return self._highest
end

function ActivityTinyGameData:GetTinyGameRewardLevelPoint()
  return self._point
end

function ActivityTinyGameData:SetTinyGameRewardLevelPoint(point)
  self._point = point
end

function ActivityTinyGameData:GetTinyGameRewardGotLv()
  return self._rewardGotLv
end

function ActivityTinyGameData:SetTinyGameRewardGotLv(level)
  self._rewardGotLv = level
end

function ActivityTinyGameData:IsBrotatoGame()
  return self._cat == TinyGameEnum.eType.brotato
end

return ActivityTinyGameData
