local FlappyBird_Tube = class("FlappyBird_Tube")
local CollisionUtil = require("Game.TinyGames.FlappyBird.FlappyBirdUtil.FlappyBirdCollisionUtil")

function FlappyBird_Tube:ctor(tubeType)
  self.__tubeType = tubeType
  self.offset = {x = 0, y = 0}
  self.pos = {x = 0, y = 0}
  self.viewPos = Vector2.New(self.pos.x / 1000, self.pos.y / 1000)
end

function FlappyBird_Tube:SetColliderSize(halfWidth, halfHeight)
  self.colliderBox = {
    left = -halfWidth,
    bottom = -halfHeight,
    right = halfWidth,
    top = halfHeight
  }
end

function FlappyBird_Tube:GetTubeType()
  return self.__tubeType
end

function FlappyBird_Tube:SetOffset2Center(x, y)
  self.offset.x = x
  self.offset.y = y
end

function FlappyBird_Tube:IsOnTubeCollission(otherEntity)
  return CollisionUtil.IsRectRectOnCollission(self.pos, self.colliderBox, otherEntity.pos, otherEntity.colliderBox)
end

function FlappyBird_Tube:SetTubePos(x, y)
  self.pos.x = x + self.offset.x
  self.pos.y = y + self.offset.y
end

function FlappyBird_Tube:LogicPos2UnityPos()
  self.viewPos.x = self.pos.x / 1000
  self.viewPos.y = self.pos.y / 1000
  return self.viewPos
end

return FlappyBird_Tube
