local base = require("Game.TinyGames.FlappyBird.Entity.FlappyBird_EntityBase")
local FlappyBird_AccItem = class("FlappyBird_AccItem", base)

function FlappyBird_AccItem:OnInit()
  self:SetGravityInfluenceEnable(false)
  self:SetMoveFollowBackGroud()
  self.accLastFrame = 90
  self.invinciableDuration = 150
  self.speedRatio = 4
end

function FlappyBird_AccItem:GetAccLastFrame()
  return self.accLastFrame
end

return FlappyBird_AccItem
