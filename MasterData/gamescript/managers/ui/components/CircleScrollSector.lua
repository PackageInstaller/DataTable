local PI = math.pi
local CircleScrollSector = System.NewComponent("CircleScrollSector")

function CircleScrollSector:ctor(bendAngle, showHeight)
  self.bendAngle = bendAngle
  self.showHeight = showHeight
  self.radius = showHeight / 2 / math.sin(self:deg2rad(bendAngle))
  self.distance2center = self.radius * math.cos(self:deg2rad(bendAngle))
end

function CircleScrollSector:TranformSectorPoint(point, contentOffset)
  local offsetY = contentOffset
  local height = math.abs(-point.y - offsetY - self.showHeight * 0.5)
  local rad = math.asin(height / self.radius)
  local deltaX = self.radius * math.cos(rad) - self.distance2center
  return {
    x = deltaX,
    y = point.y,
    z = point.z
  }
end

function CircleScrollSector:deg2rad(angle)
  return angle * PI / 180
end

function CircleScrollSector:rad2deg(rad)
  return rad * 180 / PI
end

return CircleScrollSector
