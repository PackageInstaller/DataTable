





SettingPlayerTitleLine = {}

SettingPlayerTitleLine.__index = SettingPlayerTitleLine

function SettingPlayerTitleLine.New()
    local self = {}
    setmetatable(self, SettingPlayerTitleLine)
    return self
end

function SettingPlayerTitleLine:Init()
    
end

function SettingPlayerTitleLine:SetData(data)
    self.data = data.data
end

function SettingPlayerTitleLine:Clear()
    self.data = nil
end

function SettingPlayerTitleLine:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end