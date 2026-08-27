local base = require("Game.TinyGames.FlappyBird.Entity.FlappyBird_EntityBase")
local FlappyBird_Chocolate = class("FlappyBird_Chocolate", base)

function FlappyBird_Chocolate:OnInit()
  self:SetGravityInfluenceEnable(false)
  self:SetMoveFollowBackGroud()
  self.bonusScore = 3
end

return FlappyBird_Chocolate
