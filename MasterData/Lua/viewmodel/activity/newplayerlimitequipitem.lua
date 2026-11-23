NewPlayerLimitEquipItem = {}

NewPlayerLimitEquipItem.__index = NewPlayerLimitEquipItem

local objs = {
    rare = {path = "Rare",type = "Image"},
    icon = {path = "Icon",type = "RawImage"},
    button = {path = "Icon",type = "Button"},
}

function NewPlayerLimitEquipItem.New(object)
    local self = {}
    setmetatable(self, NewPlayerLimitEquipItem)
    self.gameObject = object
    self.transform = self.gameObject.transform
    self.transform.anchoredPosition = Vector2(-6.3, 10.7)
    self:Init()
    return self
end

function NewPlayerLimitEquipItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        LuaMgr.ShowPanel(UIName.WeaponTipsViewModel, self.data.WeaponID)
    end
    LuaMgr.AddClick(self.button,self.clickCommand)
end

function NewPlayerLimitEquipItem:SetData(data)
    self.data = data
    local equipConfig = ConfigMgr.Config.equipments[self.data.WeaponID]
    if equipConfig ~= nil then
        self.rare.sprite = GetRareSprite(equipConfig.rare)
        self.icon.texture = GetItemTexture(equipConfig.id)
    end
    self.gameObject:SetActive(true)
end

function NewPlayerLimitEquipItem:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function NewPlayerLimitEquipItem:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.button, self.clickCommand)
        self.clickCommand = nil
    end
    self.gameObject = nil
end