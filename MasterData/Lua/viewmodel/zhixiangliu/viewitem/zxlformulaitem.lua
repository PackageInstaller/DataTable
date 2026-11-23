


ZXLFormulaItem = {}
ZXLFormulaItem.__index = ZXLFormulaItem

local objs = {
    goalIcon = {path = "Group/Goal/Icon", type = UITool.Image}
}

function ZXLFormulaItem.New()

    local self = {}
    setmetatable(self, ZXLFormulaItem)
    self.icons = {}
    return self
end

function ZXLFormulaItem:BatchInitNode()
    for i = 1, 3 do
        local iconName = "icon" .. i
        local data = {}
        data.path = string.format("Group/Material%d/Icon", i)
        data.type = UITool.Image
        objs[iconName] = data
    end
end

function ZXLFormulaItem:Init()
    self:BatchInitNode()
    UITool.Parse(self.gameObject, self, objs)
end

function ZXLFormulaItem:SetData(data)
    self.data = data.data
    self:SetItem()
end

function ZXLFormulaItem:SetItem()
    for i = 1, #self.data.matConfigs do
        local iconName = "icon" .. i
        local config = self.data.matConfigs[i]
        self[iconName].sprite = LuaMgr.GetSprite(ZXLConst.AtlaName, config.Icon)
    end
    self.goalIcon.sprite = LuaMgr.GetSprite(ZXLConst.AtlaName, self.data.config.Icon)
end

function ZXLFormulaItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function ZXLFormulaItem:Destroy()
    if (self.item ~= nil) then
        self.item:Clear()
        self.item = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end