local TinyGameDataBase = require("Game.TinyGames.Common.TinyGameDataBase")
local GameSnakeData = class("GameSnakeData", TinyGameDataBase)
local TinyGameUtil = require("Game.TinyGames.TinyGameUtil")

function GameSnakeData:ctor(uid, gameId, cat)
  self._cfg = ConfigData.tiny_snake[gameId]
end

function GameSnakeData:GetSnakeRewardState()
  local maxScore = self:GetTinyGameHistoryScore()
  local isRewarded = maxScore >= self._cfg.join_score
  return self._cfg.join_score, isRewarded
end

function GameSnakeData:GetSnakeGameReward()
  return self._cfg.join_reward_ids, self._cfg.join_reward_nums
end

function GameSnakeData:GetSnakeRuleId()
  return self._cfg.snake_guide_id
end

return GameSnakeData
