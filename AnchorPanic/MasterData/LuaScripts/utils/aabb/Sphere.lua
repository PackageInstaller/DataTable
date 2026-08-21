module("Sphere", Class.impl())

function create(self,center,radius)
    self.colType = "Sphere"
    self:updateInfo(center,radius)
end

function updateInfo(self,center,radius)
    self.center = center
    self.radius = radius
end

function compare(self,b)
    if b.colType == "Sphere" then
        local d = MathTool:MV3Subtract(self.center,b.center)
        local dist = MathTool:MV3Dot(d,d)
        local radiusSun = self.radius + b.radius
        return dist <= radiusSun * radiusSun 
    elseif b.colType == "AABB" then
        b:compare(self)
    end
    return false
end

return _M