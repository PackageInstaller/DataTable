_class("BounceRect", Object)
BounceRect = BounceRect

function BounceRect:Constructor(position, size)
  self.position = position
  self.size = size
  self.halfSize = self.size * 0.5
  self:_Refresh()
end

function BounceRect:ChgPosition(position)
  self.position = position
  self:_Refresh()
end

function BounceRect:_Refresh()
  local pos = self.position
  self.min = Vector2(pos.x - self.halfSize.x, pos.y - self.halfSize.y)
  pos = self.position
  self.max = Vector2(pos.x + self.halfSize.x, pos.y + self.halfSize.y)
end

function BounceRect:GetMin()
  return self.min
end

function BounceRect:GetMax()
  return self.max
end

function BounceRect:Contains(pos)
  if pos.x < self.min.x then
    return false
  end
  if pos.x > self.max.x then
    return false
  end
  if pos.y < self.min.y then
    return false
  end
  if pos.y > self.max.y then
    return false
  end
  return true
end
