


GridPosition = {}
GridPosition.__index = GridPosition

function GridPosition.New(x, y)

    local obj = setmetatable({}, GridPosition)
    obj.X = x
    obj.Y = y
    return obj
end




function GridPosition:Equals(other)
    return self.X == other.X and self.Y == other.Y
end



function GridPosition:Clone()
    return GridPosition.New(self.X, self.Y)
end

function GridPosition:Add(x, y)
    self.X = self.X + (x or 0)
    self.Y = self.Y + (y or 0)
    return self
end

function GridPosition:AddRef(x, y)
    local tempX=  self.X + (x or 0)
    local tempY=  self.Y + (y or 0)
    return GridPosition.New(tempX, tempY)
end



function GridPosition:ToString()
    return string.format("(%d,%d)", self.X, self.Y)
end