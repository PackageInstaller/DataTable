







JZQWGameProps = {}
JZQWGameProps.__index = JZQWGameProps

JZQWGameProps.New = function()

    local self = {}
    setmetatable(self, JZQWGameProps)
    self:Init()
    return self
end

function JZQWGameProps:Init()
    self.ID = nil
    self.Config = nil
    self.ActivateID = nil
    self.ActivateObjs = {}
    self.CanCombine = false
    self.CanPick = false
    self.IsOwner = false
end

function JZQWGameProps:SetData(data)
end

function JZQWGameProps:ClearItems()
end

function JZQWGameProps:Clear()
    self:ClearItems()
end

function JZQWGameProps:Destroy()
    self:Clear()
end