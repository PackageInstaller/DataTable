local FlappyBird_EntityBase = class("FlappyBird_EntityBase")
local CollisionUtil = require("Game.TinyGames.FlappyBird.FlappyBirdUtil.FlappyBirdCollisionUtil")

function FlappyBird_EntityBase:ctor(mapEvnData)
  self.pos = {x = 0, y = 0}
  self.velocity = {x = 0, y = 0}
  self.colliderBox = {
    left = -1,
    bottom = -1,
    right = 1,
    top = 1
  }
  self.evnData = mapEvnData
  self.__isMoveFollowBackGround = false
  self.__enableGravityInfluence = false
  self.viewPos = Vector2.New(self.pos.x / 1000, self.pos.y / 1000)
  self:OnInit()
end

function FlappyBird_EntityBase:OnInit()
end

function FlappyBird_EntityBase:SetPos(x, y)
  self.pos.x = x
  self.pos.y = y
end

function FlappyBird_EntityBase:SetGravityInfluenceEnable(value)
  self.__enableGravityInfluence = value
end

function FlappyBird_EntityBase:SetColliderSize(left, bottom, right, top)
  self.colliderBox.left = left
  self.colliderBox.bottom = bottom
  self.colliderBox.right = right
  self.colliderBox.top = top
end

function FlappyBird_EntityBase:IsOnCollission(otherEntity)
  return CollisionUtil.IsRectRectOnCollission(self.pos, self.colliderBox, otherEntity.pos, otherEntity.colliderBox)
end

function FlappyBird_EntityBase:UpdatePos()
  if self.__enableGravityInfluence then
    self.velocity.y = self.velocity.y - self.evnData.gravityScale
    self.velocity.y = math.max(self.evnData.minVerticalVelocity, self.velocity.y)
  end
  self.pos.x = self.pos.x + self.velocity.x
  self.pos.y = self.pos.y + self.velocity.y
end

function FlappyBird_EntityBase:OnUpdateLogic()
  self:UpdatePos()
end

function FlappyBird_EntityBase:SetMoveFollowBackGroud()
  self.velocity = self.evnData.backGroudMoveSpeed
  self.__isMoveFollowBackGround = true
end

function FlappyBird_EntityBase:LogicPos2UnityPos()
  self.viewPos.x = self.pos.x / 1000
  self.viewPos.y = self.pos.y / 1000
  return self.viewPos
end

return FlappyBird_EntityBase
