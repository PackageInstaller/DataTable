









DispatchingDataCell = {}
DispatchingDataCell.__index = DispatchingDataCell

local objs = {
    nameText = {path = "Name", type = UITool.Text},
}

DispatchingDataCell.New = function()

    local self = {}
    setmetatable(self, DispatchingDataCell)
    return self
end

function DispatchingDataCell:Init()
    for i = 1, 6 do
        local heroHeadName = string.format("CharacterHead%d", i)
        local tempPath = string.format("LeftGroup/SelectHoreParent/%s", heroHeadName)
        objs[heroHeadName] = {path = tempPath, type = UITool.GameObject}
    end
    UITool.Parse(self.gameObject, self, objs)
end

function DispatchingDataCell:SetData(data)
    if data ~= nil then
        self.data = data.data
    end
    self:SetItem()
end

function DispatchingDataCell:SetItem()
    self.data = nil
end

function DispatchingDataCell:ClearItems()
end

function DispatchingDataCell:Clear()
    self:ClearItems()
end

function DispatchingDataCell:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end