
JZQWGameTextItem = {}
JZQWGameTextItem.__index = JZQWGameTextItem

local objs = {
    textContent = {path = "TextContent", type = UITool.Text},
}

JZQWGameTextItem.New = function()

    local self = {}
    setmetatable(self, JZQWGameTextItem)
    return self
end

function JZQWGameTextItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end


function JZQWGameTextItem:SetData(data)
   self.textContent.text = data and data.data or ""
end

function JZQWGameTextItem:ClearItems()
end

function JZQWGameTextItem:Clear()
    self:ClearItems()
end

function JZQWGameTextItem:Destroy()

    self:Clear()
end