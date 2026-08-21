_class("HomelandBrickConnect", Object)
HomelandBrickConnect = HomelandBrickConnect

function HomelandBrickConnect:Constructor(firstBrick, firstDirection, secondBrick, secondDirection)
  self._firstBrick = firstBrick
  self._firstBrickDirection = firstDirection
  self._secondBrick = secondBrick
  self._secondBrickDirection = secondDirection
  self:SetEdgeVisible(false)
end

function HomelandBrickConnect:Destroy()
  self:SetEdgeVisible(true)
end

function HomelandBrickConnect:SetEdgeVisible(status)
  self._firstBrick:SetEdgeVisible(self._firstBrickDirection, status)
  self._secondBrick:SetEdgeVisible(self._secondBrickDirection, status)
end

function HomelandBrickConnect:Contain(brick)
  if self._firstBrick:Equal(brick) then
    return true
  end
  if self._secondBrick:Equal(brick) then
    return true
  end
  return false
end
