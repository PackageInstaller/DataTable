TeamWeaponAscensionCostItem = {}

TeamWeaponAscensionCostItem.__index = TeamWeaponAscensionCostItem

local objs = {
    onClick = { path = "Group/Rare", type = "UIButtonClick" },
    rare = { path = "Group/Rare", type = "Image" },
    icon = { path = "Group/Icon", type = "RawImage" },
    countText = { path = "Group/Num/Count", type = "Text" },
}

function TeamWeaponAscensionCostItem.New(obj)
    local self = {}
    setmetatable(self, TeamWeaponAscensionCostItem)
    self.gameObject = obj
    return self
end

function TeamWeaponAscensionCostItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClick = function()
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel, self.data.itemId, false, false, false, 0)
    end
    LuaMgr.AddClick(self.onClick, self.OnClick)
end

function TeamWeaponAscensionCostItem:SetData(pdata)
    self.data = pdata.data
    self.rare.sprite = self.data.itemRare
    self.icon.texture = self.data.itemIcon
    self.countText.text = self.data.itemCount
end

function TeamWeaponAscensionCostItem:Clear()
    self.data = nil
end

function TeamWeaponAscensionCostItem:Destroy()
    if (self.OnClick ~= nil) then
        LuaMgr.RemoveClick(self.onClick, self.OnClick)
        self.OnClick = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end