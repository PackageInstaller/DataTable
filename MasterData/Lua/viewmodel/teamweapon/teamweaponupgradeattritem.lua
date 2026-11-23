TeamWeaponUpgradeAttrItem = {}

TeamWeaponUpgradeAttrItem.__index = TeamWeaponUpgradeAttrItem

local objs = {
    iconImg = { path = "Group/Icon", type = "Image" },
    nameText = { path = "Group/Name", type = "Text" },
    valueText_1 = { path = "Group/Value_1", type = "Text" },
    valueText_2 = { path = "Group/Value_2", type = "Text" },
    arrowGo = { path = "Group/Arrow", type = "GameObject" },
    effectGo = { path = "Group/vfx_saoguang", type = "GameObject" },
}

function TeamWeaponUpgradeAttrItem.New()
    local self = {}
    setmetatable(self, TeamWeaponUpgradeAttrItem)
    return self
end

function TeamWeaponUpgradeAttrItem:Init()
    UITool.Parse(self.gameObject, self, objs)
end

function TeamWeaponUpgradeAttrItem:SetData(pdata)
    self.data = pdata.data
    self.iconImg.sprite = self.data.icon
    self.nameText.text = self.data.nameStr
    if self.data.isChange then
        self.valueText_1.text = self.data.valueStr_1
        self.valueText_2.text = string.format("<color=#D46B37>%s</color>", self.data.valueStr_2)
    else
        self.valueText_1.text = ""
        self.valueText_2.text = self.data.valueStr_1
    end
    SetActive(self.arrowGo, self.data.isChange)
    SetActive(self.effectGo, self.data.showEffect)
    self.data.showEffect = false
end

function TeamWeaponUpgradeAttrItem:Clear()
    self.data = nil
end

function TeamWeaponUpgradeAttrItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end