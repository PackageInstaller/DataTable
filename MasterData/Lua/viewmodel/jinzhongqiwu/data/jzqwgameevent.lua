



JZQWGameEvent = {}
JZQWGameEvent.__index = JZQWGameEvent

JZQWGameEvent.New = function()

    local self = {}
    setmetatable(self, JZQWGameEvent)
    return self
end

function JZQWGameEvent:Init()
end

function JZQWGameEvent:SetData(data)
end

function JZQWGameEvent:ClearItems()
end

function JZQWGameEvent:Clear()
    self:ClearItems()
end

function JZQWGameEvent:Destroy()
    self:Clear()
end