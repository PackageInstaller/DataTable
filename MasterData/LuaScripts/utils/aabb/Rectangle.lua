module("Rectangle", Class.impl())

function create(self, minX, maxX, minY, maxY)
    self.center = gs.Vector2((minX + maxX) / 2, (minY + maxY) / 2)
    self.minX = minX
    self.maxX = maxX
    self.minY = minY
    self.maxY = maxY

    self.minPoint = gs.Vector2(minX, minY)
    self.maxPoint = gs.Vector2(maxX, maxY)
end

function hits(self, other)
    return not (other.minPoint.x > self.maxPoint.x or other.minPoint.y > self.maxPoint.y or other.maxPoint.x <
               self.minPoint.x or other.maxPoint.y < self.minPoint.y)
end

return _M
