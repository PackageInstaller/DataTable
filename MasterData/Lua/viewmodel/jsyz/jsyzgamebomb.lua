JSYZGameBomb = {};
JSYZGameBomb.__index = JSYZGameBomb


function JSYZGameBomb.New(id)
    local bomb = {
        id = id,
        x = 0,
        y = 0,
        range = 1,
        timer = 0,

        owner = nil
    }
    setmetatable(bomb, JSYZGameBomb)
    return bomb
end


function JSYZGameBomb:Reset(x, y, range, owner)
    self.x = x
    self.y = y
    self.range = range
    self.timer = JSYZGame.bombTimer
    self.owner = owner
end


function JSYZGameBomb:Update(deltaTime)
    local prevTimer = self.timer
    self.timer = self.timer - deltaTime

    if math.floor(self.timer) < math.floor(prevTimer) then

    end

    return self.timer > 0
end