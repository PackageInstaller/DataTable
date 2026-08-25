local PI = math.pi
local Sector = System.NewComponent("Sector")

function Sector:ctor(startAngle, endAngle, shiftY, maxDeltaAngle)
  self.startAngle = startAngle
  self.endAngle = endAngle
  self.shiftY = shiftY or 0
  self.maxDeltaAngle = maxDeltaAngle or endAngle - startAngle
  self.sectionCount = 1
  self.deltaAngle = self.maxDeltaAngle
end

function Sector:SetWidth(width)
  self.radius = width / 2 / math.sin(self:deg2rad(self.endAngle))
  self.depth = self.radius * math.cos(self:deg2rad(self.endAngle))
  self.center = {
    x = 0,
    y = -self.depth + self.shiftY
  }
end

function Sector:SetSectionCount(count)
  self.sectionCount = count
  if count <= 1 then
    self.deltaAngle = 0
  else
    local deltaAngle = (self.endAngle - self.startAngle) / (self.sectionCount - 1)
    self.deltaAngle = math.min(self.maxDeltaAngle, deltaAngle)
  end
end

function Sector:GetSectionPoint(sectionIndex)
  local angle = self:GetSectionAngle(sectionIndex)
  do return self.GetPointByAngle, self end
  return self.GetPointByAngle, self, angle
end

function Sector:GetSectionIndexByPoint(pos)
  if 0 == self.deltaAngle then
    return 1
  end
  local x = pos.x - self.center.x
  local y = pos.y - self.center.y
  local angle = self:rad2deg(math.atan2(x, y))
  local beginAngle = self:GetSectionBeginAngle() - self.deltaAngle * 0.5
  local index = math.floor((angle - beginAngle) / self.deltaAngle) + 1
  return index
end

function Sector:GetSectionBeginAngle()
  local isOdd = 1 == self.sectionCount % 2
  local beginAngle = 0 - (self.sectionCount // 2 - (isOdd and 0 or 0.5)) * self.deltaAngle
  return beginAngle
end

function Sector:GetSectionAngle(sectionIndex)
  local beginAngle = self:GetSectionBeginAngle()
  local angle = beginAngle + (sectionIndex - 1) * self.deltaAngle
  return angle
end

function Sector:GetSectionPointByAngle(angle)
  do return self.GetPointByAngle, self end
  return self.GetPointByAngle, self, angle
end

function Sector:GetPointByAngle(angle)
  local rad = self:deg2rad(angle)
  local x = self.center.x + self.radius * math.sin(rad)
  local y = self.center.y + self.radius * math.cos(rad)
  return {x = x, y = y}
end

function Sector:getAngle()
  return self.endAngle - self.startAngle
end

function Sector:deg2rad(angle)
  return angle * PI / 180
end

function Sector:rad2deg(rad)
  return rad * 180 / PI
end

return Sector
