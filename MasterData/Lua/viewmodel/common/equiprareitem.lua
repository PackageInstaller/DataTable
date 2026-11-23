





EquipRareItem = {}
EquipRareItem.__index = EquipRareItem

local objs = {
    normal_img = {path = "Normal/Image",type = "Image"},
    choose = {path = "Choose",type = "GameObject"},
    choose_img = {path = "Choose/Image",type = "Image"},
    clickBtn = {path = "Normal",type = "Button"},
}

function EquipRareItem.New()
    local self = {}
    setmetatable(self, EquipRareItem)
    return self
end

function EquipRareItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.clickCommand = function()
        if self.callback ~= nil then
            self.callback(self.data)
        end
    end
    LuaMgr.AddClick(self.clickBtn,self.clickCommand)
end

function EquipRareItem:SetData(data)
    self.data = data.data.data
    self.callback = data.data.callback
    self.rareOptions = data.data.rareOptions
    local sprite = LuaMgr.GetSprite("Backpack", "ui_bb_sx_wz"..self.data - 1)
    self.normal_img.sprite = sprite
    self.choose_img.sprite = sprite
    SetActive(self.choose,self.rareOptions[self.data] ~= nil)
    self.gameObject:SetActive(true)
end

function EquipRareItem:Clear()
    self.data = nil
    self.callback = nil
    self.rareOptions = nil
    self.gameObject:SetActive(false)
end

function EquipRareItem:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end