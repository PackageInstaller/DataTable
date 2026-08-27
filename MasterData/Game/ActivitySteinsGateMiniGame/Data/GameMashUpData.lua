local TinyGameDataBase = require("Game.TinyGames.Common.TinyGameDataBase")
local GameMashUpData = class("GameMashUpData", TinyGameDataBase)

function GameMashUpData:ctor(uid, gameId, cat)
  self._cfg = ConfigData.mash_up[gameId]
  self:__GetTinyGameData()
end

function GameMashUpData:GetMashScore(index)
  return self._cfg.score_per_ball[index] or 0
end

function GameMashUpData:InitPlayData()
  self:SetNumIsNew(false)
  self:SetNowScore(0)
end

function GameMashUpData:SetNowScore(num)
  self.nowScore = num
end

function GameMashUpData:GetNowScore()
  return self.nowScore
end

function GameMashUpData:SetNumIsNew(bool)
  self.isNew = bool
end

function GameMashUpData:GetNumIsNew()
  return self.isNew
end

return GameMashUpData
