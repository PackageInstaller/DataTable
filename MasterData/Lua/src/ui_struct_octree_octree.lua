local this = class("ocTree")

function this:ctor()
  self.root = nil
end

function this:getRoot()
  return self.root
end

function this:initialize(polyList)
  local bounds = self:generateBounds(polyList)
  self.root = L_Struct:getOcTreeNode(bounds)
  for _, v in pairs(polyList) do
    self:insert(v, self.root)
  end
end

function this:clear()
  self.root = nil
end

function this:generateBounds(polyhedrons)
  local minX, minY, minZ, maxX, maxY, maxZ = math.huge, math.huge, math.huge, -math.huge, -math.huge, -math.huge
  for _, polyhedron in ipairs(polyhedrons) do
    local bounds = polyhedron:getBounds()
    minX, minY, minZ = math.min(minX, bounds.min.x), math.min(minY, bounds.min.y), math.min(minZ, bounds.min.z)
    maxX, maxY, maxZ = math.max(maxX, bounds.max.x), math.max(maxY, bounds.max.y), math.max(maxZ, bounds.max.z)
  end
  local bounds = L_Struct:getBounds()
  bounds.min = L_Vector3.new(minX, minY, minZ)
  bounds.max = L_Vector3.new(maxX, maxY, maxZ)
  return bounds
end

function this:insert(polyhedron, node)
  node = node or self:getRoot()
  local splitSize = node:getChildSize()
  local polySize = polyhedron:getMaxSize()
  if splitSize < polySize then
    node:addPolyhedron(polyhedron)
  else
    if #node.children == 0 then
      self:split(node)
    end
    for _, v in ipairs(node.children) do
      if v:containsPolyhedron(polyhedron) then
        self:insert(polyhedron, v)
        break
      elseif v:intersectsPolyhedron(polyhedron) then
        node:addPolyhedron(polyhedron)
        break
      end
    end
  end
end

function this:split(node)
  local bounds = node.bounds
  local half = node:getSize() / 2
  for x = 0, 1 do
    for y = 0, 1 do
      for z = 0, 1 do
        local childBounds = L_Struct:getBounds()
        childBounds.min = L_Vector3.new(bounds.min.x + half.x * x, bounds.min.y + half.y * y, bounds.min.z + half.z * z)
        childBounds.max = L_Vector3.new(bounds.min.x + half.x * (x + 1), bounds.min.y + half.y * (y + 1), bounds.min.z + half.z * (z + 1))
        local childNode = L_Struct:getOcTreeNode(childBounds)
        node:addChildNode(childNode)
      end
    end
  end
end

function this:queryPoint(point)
  local root = self:getRoot()
  if root and root:containsPoint(point) then
    local polys = self:queryPointInNode(point, root)
    local resMap = {}
    for poly, _ in pairs(polys) do
      resMap[poly.id] = true
    end
    local resList = {}
    for id, _ in pairs(resMap) do
      table.insert(resList, id)
    end
    table.sort(resList)
    return resList
  end
  return {}
end

function this:queryPointInNode(point, node)
  local bottomLeft = node:getMin()
  local gSize = node:getMaxSize() * 0.5
  local z = gSize >= point.z - bottomLeft.z and 0 or 1
  local y = gSize >= point.y - bottomLeft.y and 0 or 2
  local x = gSize >= point.x - bottomLeft.x and 0 or 4
  local id = x + y + z + 1
  local childNode = node.children[id]
  local result = {}
  if childNode then
    result = self:queryPointInNode(point, childNode)
  end
  table.merge(result, node:query(point))
  return result
end

return this
