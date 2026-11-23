





WeaponEquipItem = {}

WeaponEquipItem.__index = WeaponEquipItem

local objs = {
    rare = {path = "Rare",type = "Image"},
    icon = {path = "Icon",type = "RawImage"},
    button = {path = "Icon",type = "Button"},
}

function WeaponEquipItem.New()
    local self = {}
    setmetatable(self, WeaponEquipItem)
    return self
end

function WeaponEquipItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        LuaMgr.ShowPanel(UIName.WeaponTipsViewModel, self.data.data.WeaponID)
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
end

function WeaponEquipItem:SetData(data)
    self.data = data.data
    local equipConfig = ConfigMgr.Config.equipments[self.data.data.WeaponID]
    if equipConfig ~= nil then
        self.rare.sprite = GetRareSprite(equipConfig.rare)
        self.icon.texture = GetItemTexture(equipConfig.id)
    end
    self.gameObject:SetActive(true)
end

function WeaponEquipItem:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function WeaponEquipItem:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end