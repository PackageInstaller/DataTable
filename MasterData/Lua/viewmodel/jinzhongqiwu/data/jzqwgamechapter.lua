





JZQWGameChapter = {}
JZQWGameChapter.__index = JZQWGameChapter

JZQWGameChapter.New = function()

    local self = {}
    setmetatable(self, JZQWGameChapter)
    return self
end

function JZQWGameChapter:Init()
end

function JZQWGameChapter:SetData(data)
end

function JZQWGameChapter:ClearItems()
end

function JZQWGameChapter:Clear()
    self:ClearItems()
end

function JZQWGameChapter:Destroy()
    self:Clear()
end