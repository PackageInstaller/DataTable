




EquipItemModel = {}

EquipItemModel.__index = EquipItemModel

local objs = {
    bgButton = {path = "BgButton", type = "Button"},
    rare = {path = "BgButton", type = "Image"},
    rareIsShow = {path = "BgButton", type = "GameObject"},
    icon = {path = "Icon", type = "RawImage"},
    iconIsShow = {path = "Icon", type = "GameObject"},
    lock = {path = "Lock", type = "GameObject"},
}

function EquipItemModel.New(prefab, parent)
    local self = {}
    setmetatable(self, EquipItemModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.bgCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.EquipItemClick, self.data.id)
    end
    LuaMgr.AddClick(self.bgButton,self.bgCommand)
    return self
end

function EquipItemModel:SetData(data)
    self.data = data
    local tempData = DataMgr.Player.equipmentFiles[self.data.id]
    if tempData ~= nil then
        self.rare.sprite = LuaMgr.GetSprite("ItemRare","itemRare"..self.data.rare)
        self.icon.texture = LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(self.data.id))
    end
    SetActive(self.lock,tempData == nil)
    SetActive(self.rareIsShow,tempData ~= nil)
    SetActive(self.iconIsShow,tempData ~= nil)
    self.gameObject:SetActive(true)
end

function EquipItemModel:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function EquipItemModel:Destroy()
    if (self.bgCommand ~= nil) then
        LuaMgr.RemoveClick(self.bgButton, self.bgCommand)
        self.bgCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end