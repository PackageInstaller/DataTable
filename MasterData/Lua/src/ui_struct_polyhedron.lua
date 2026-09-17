local this = class("polyhedron")

function this:ctor(id)
  self.id = id
  self.vertices = nil
  self.startPint = nil
  self.endPoint = nil
  self.bounds = nil
end

function this:getId()
  return self.id
end

function this:getBounds()
  return self.bounds
end

function this:build(vertices, startPoint, endPoint)
  self.vertices = vertices
  self.startPoint = startPoint
  self.endPoint = endPoint
  self:generateBounds()
end

function this:setPoint(startPoint, endPoint)
  if startPoint then
    self.startPint = startPoint
  end
  if endPoint then
    self.endPoint = endPoint
  end
end

function this:generateBounds()
  local minX, maxX, minZ, maxZ = math.huge, -math.huge, math.huge, -math.huge
  for i = 1, #self.vertices do
    local vertex = self.vertices[i]
    if minX > vertex.x then
      minX = vertex.x
    end
    if maxX < vertex.x then
      maxX = vertex.x
    end
    if minZ > vertex.z then
      minZ = vertex.z
    end
    if maxZ < vertex.z then
      maxZ = vertex.z
    end
  end
  self.bounds = L_Struct:getBounds()
  self.bounds.min = L_Vector3.new(minX, self.startPoint.y, minZ)
  self.bounds.max = L_Vector3.new(maxX, self.endPoint.y, maxZ)
  return self.bounds
end

function this:calculateArea()
  local area = 0
  local numVertices = #self.vertices
  for i = 1, numVertices do
    local j = i % numVertices + 1
    area = area + (self.vertices[i].x * self.vertices[j].z - self.vertices[j].x * self.vertices[i].z)
  end
  return math.abs(area) / 2
end

function this:containsPoint(point)
  if point.y < self.startPoint.y or point.y > self.endPoint.y then
    return false
  end
  local numVertices = #self.vertices
  local inside = false
  for i = 1, numVertices do
    local j = i % numVertices + 1
    local xi, zi = self.vertices[i].x, self.vertices[i].z
    local xj, zj = self.vertices[j].x, self.vertices[j].z
    if zi > point.z ~= (zj > point.z) and point.x < (xj - xi) * (point.z - zi) / (zj - zi) + xi then
      inside = not inside
    end
  end
  return inside
end

function this:getSize()
  return self.bounds:getSize()
end

function this:getMaxSize()
  return self.bounds:getMaxSize()
end

return this
