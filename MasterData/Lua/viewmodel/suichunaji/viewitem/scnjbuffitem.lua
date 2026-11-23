



SCNJBuffItem = {}
SCNJBuffItem.__index = SCNJBuffItem

local objs = {
    icon = {path = "Group/Icon", type = UITool.Image},
    nameText = {path = "Group/Name", type = UITool.Text},
    buffButton = {path = "Group", type = UITool.Button}
}

SCNJBuffItem.New = function()

    local self = {}
    setmetatable(self, SCNJBuffItem)
    return self
end

function SCNJBuffItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.onClickCallback = function()
        if self.data.OnClickCallback ~= nil then
            self.data.OnClickCallback(self)
        end
    end
    LuaMgr.AddClick(self.buffButton, self.onClickCallback)
end

function SCNJBuffItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    self:SetItem()
end

function SCNJBuffItem:SetItem()
    self.icon.sprite = LuaMgr.GetSprite(SCNJConst.BuffIconAtlaName, self.data.BuffIcon)
    self.nameText.text = LuaMgr.GetLangText(self.data.BuffNameLan)
end

function SCNJBuffItem:ClearItems()
end

function SCNJBuffItem:Clear()
    self:ClearItems()
end

function SCNJBuffItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.data = nil
end