TeamWeaponUpgradeCostItem = {}

TeamWeaponUpgradeCostItem.__index = TeamWeaponUpgradeCostItem

local objs = {
    addNumber = { path = "Group/Rare", type = "UIAddNumber" },
    addNumber1 = { path = "Group/Num/Add", type = "UIAddNumber" },
    addNumber2 = { path = "Group/Num/Del", type = "UIAddNumber" },
    rare = { path = "Group/Rare", type = "Image" },
    icon = { path = "Group/Icon", type = "RawImage" },
    countText = { path = "Group/Count", type = "Text" },
    selectCountText = { path = "Group/Num/Text", type = "Text" },
    selectGo = { path = "Group/Selected", type = "Text" },
}

function TeamWeaponUpgradeCostItem.New(obj)
    local self = {}
    setmetatable(self, TeamWeaponUpgradeCostItem)
    self.gameObject = obj
    return self
end

function TeamWeaponUpgradeCostItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickAdd = function()
        if self.data.onClickAdd ~= nil then
            self.data.onClickAdd(self.data.itemId)
        end
    end
    self.OnClickDel = function()
        if self.data.onClickDel ~= nil then
            self.data.onClickDel(self.data.itemId)
        end
    end
    self.addNumber.Callback = self.OnClickAdd
    self.addNumber1.Callback = self.OnClickAdd
    self.addNumber2.Callback = self.OnClickDel
end

function TeamWeaponUpgradeCostItem:SetData(pdata)
    self.data = pdata.data
    self.rare.sprite = self.data.itemRare
    self.icon.texture = self.data.itemIcon
    self.countText.text = self.data.itemCount
    self.selectCountText.text = tostring(self.data.selectCount)
    SetActive(self.selectGo, self.data.selectCount > 0)
end

function TeamWeaponUpgradeCostItem:SetAddNumParam()
    self.addNumber.Data = self.data.itemId
    self.addNumber.MaxNum = self.data.itemCount
    self.addNumber1.Data = self.data.itemId
    self.addNumber1.MaxNum = self.data.itemCount
    self.addNumber2.Data = self.data.itemId
    self.addNumber2.MaxNum = 999999
end

function TeamWeaponUpgradeCostItem:Clear()
    self.data = nil
end

function TeamWeaponUpgradeCostItem:Destroy()
    self.OnClickAdd = nil
    self.OnClickDel = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end