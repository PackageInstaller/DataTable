local this = class("bounds")

function this:ctor(max, min)
  self.min = max
  self.max = min
end

function this:intersects(other)
  if self.max.x < other.min.x or self.min.x > other.max.x then
    return false
  end
  if self.max.y < other.min.y or self.min.y > other.max.y then
    return false
  end
  if self.max.z < other.min.z or self.min.z > other.max.z then
    return false
  end
  return true
end

function this:contains(other)
  if self.min.x > other.min.x or self.min.y > other.min.y or self.min.z > other.min.z then
    return false
  end
  if self.max.x < other.max.x or self.max.y < other.max.y or self.max.z < other.max.z then
    return false
  end
  return true
end

function this:containsPoint(point)
  return point.x >= self.min.x and point.x <= self.max.x and point.y >= self.min.y and point.y <= self.max.y and point.z >= self.min.z and point.z <= self.max.z
end

function this:getCenter()
  return (self.min + self.max) / 2
end

function this:getSize()
  return self.max - self.min
end

function this:getMaxSize()
  local x = self.max.x - self.min.x
  local y = self.max.y - self.min.y
  local z = self.max.z - self.min.z
  return math.max(x, y, z)
end

return this
