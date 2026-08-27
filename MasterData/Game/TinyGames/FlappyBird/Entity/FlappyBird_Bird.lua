local base = require("Game.TinyGames.FlappyBird.Entity.FlappyBird_EntityBase")
local FlappyBird_Bird = class("FlappyBird_Bird", base)

function FlappyBird_Bird:OnInit()
  self:SetGravityInfluenceEnable(false)
  self.__invinciable = false
end

function FlappyBird_Bird:SetColliderSize(size)
  base.SetColliderSize(self, size.left, size.bottom, size.right, size.top)
end

function FlappyBird_Bird:InjectUpdateInvinciableView(updateInvinciable, remainFrame)
  self.__updateInvinciable = updateInvinciable
  self.__invinciableRemainFrame = remainFrame
end

function FlappyBird_Bird:ReSetVelocity()
  self.velocity.x = 0
  self.velocity.y = 0
end

function FlappyBird_Bird:SetInvinciable(value, duration)
  if self.__invinciable ~= value then
    self.__invinciable = value
  end
  self.invinciableDuration = duration
end

function FlappyBird_Bird:UpdateInvinciable()
  if not self.__invinciable then
    return
  end
  if self.invinciableDuration <= 0 then
    self:SetInvinciable(false, 0)
    self.remainInvinciable = false
    if self.__updateInvinciable ~= nil then
      self.__updateInvinciable(false)
    end
  else
    self.invinciableDuration = self.invinciableDuration - 1
    if self.invinciableDuration <= self.__invinciableRemainFrame and not self.remainInvinciable then
      self.remainInvinciable = true
      self.__updateInvinciable(true, 3)
    end
  end
end

function FlappyBird_Bird:IsInvinciable()
  return self.__invinciable
end

function FlappyBird_Bird:Jump(jumpForce)
  self.velocity.y = jumpForce
  if not self.__firstJump then
    self.__firstJump = true
    self:SetGravityInfluenceEnable(true)
  end
end

function FlappyBird_Bird:IsCompletedFirstJump()
  return self.__firstJump
end

function FlappyBird_Bird:OnUpdateLogic()
  base.OnUpdateLogic(self)
  if self:IsInvinciable() then
    self:UpdateInvinciable()
  end
end

function FlappyBird_Bird:ResetBird()
  self.remainInvinciable = false
  self.__firstJump = false
  self:SetGravityInfluenceEnable(false)
  self:SetPos(0, 0)
  self:ReSetVelocity()
end

return FlappyBird_Bird
