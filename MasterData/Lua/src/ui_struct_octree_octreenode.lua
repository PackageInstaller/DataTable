local this = class("ocTreeNode")

function this:ctor(bounds)
  self.bounds = bounds
  self.children = {}
  self.polyhedrons = {}
end

function this:getSize()
  return self.bounds:getSize()
end

function this:getMaxSize()
  return self.bounds:getMaxSize()
end

function this:getMin()
  return self.bounds.min
end

function this:getMax()
  return self.bounds.max
end

function this:getChildSize()
  return self:getMaxSize() * 0.5
end

function this:addPolyhedron(polyhedron)
  table.insert(self.polyhedrons, polyhedron)
end

function this:addChildNode(node)
  table.insert(self.children, node)
end

function this:containsPolyhedron(polyhedron)
  return self.bounds:contains(polyhedron.bounds)
end

function this:containsPoint(point)
  return self.bounds:containsPoint(point)
end

function this:intersectsPolyhedron(polyhedron)
  return self.bounds:intersects(polyhedron.bounds)
end

function this:query(point)
  local res = {}
  for _, v in ipairs(self.polyhedrons) do
    local result = v:containsPoint(point)
    if result then
      res[v] = true
    end
  end
  return res
end

return this
