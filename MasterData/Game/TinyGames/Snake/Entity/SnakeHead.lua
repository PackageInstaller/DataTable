local SnakeBase = require("Game.TinyGames.Snake.Entity.SnakeBase")
local SnakeHead = class("SnakeHead", SnakeBase)
local SnakeGameConfig = require("Game.TinyGames.Snake.Config.SnakeGameConfig")
local cs_Tweening = CS.DG.Tweening

function SnakeHead:ctor(go, x, z)
end

function SnakeHead:PlaySnakeMoveAni(tween)
  tween:SetEase(cs_Tweening.Ease.Linear)
end

return SnakeHead
