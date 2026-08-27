local TinyGameDataBase = require("Game.TinyGames.Common.TinyGameDataBase")
local GameMashDownData = class("GameMashDownData", TinyGameDataBase)

function GameMashDownData:ctor(uid, gameId, cat)
  self._cfg = ConfigData.mash_up[gameId]
  self:__GetTinyGameData()
end

function GameMashDownData:GetMashScore(index)
  return self._cfg.score_per_ball[index] or 0
end

function GameMashDownData:InitPlayData()
  self:SetNumIsNew(false)
  self:SetNowScore(0)
end

function GameMashDownData:SetNowScore(num)
  self.nowScore = num
end

function GameMashDownData:GetNowScore()
  return self.nowScore
end

function GameMashDownData:SetNumIsNew(bool)
  self.isNew = bool
end

function GameMashDownData:GetNumIsNew()
  return self.isNew
end

return GameMashDownData
