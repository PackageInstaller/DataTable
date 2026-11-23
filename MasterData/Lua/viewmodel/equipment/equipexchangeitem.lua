




EquipExchangeItem = {}

EquipExchangeItem.__index = EquipExchangeItem

local objs = {
    rare = {path = "Rare", type = "Image"},
    icon = {path = "Icon", type = "RawImage"},
    level = {path = "Level", type = "Text"},
    lock = {path = "State/Lock", type = "GameObject"},
    using = {path = "State/Using", type = "GameObject"},
    star1 = {path = "Star/Star0", type = "GameObject"},
    star2 = {path = "Star/Star1", type = "GameObject"},
    star3 = {path = "Star/Star2", type = "GameObject"},
    star4 = {path = "Star/Star3", type = "GameObject"},
    star5 = {path = "Star/Star4", type = "GameObject"},
    star6 = {path = "Star/Star5", type = "GameObject"},
    choose = {path = "Choose", type = "GameObject"},
    contrast = {path = "Contrast", type = "GameObject"},
    bgButton = {path = "Btn", type = "Button"},
    attrState = { path = "State/AttrLock", type = "GameObject" },
    lockImg = { path = "State/AttrLock", type = "Image" },
}

function EquipExchangeItem.New(prefab, parent)
    local self = {}
    setmetatable(self, EquipExchangeItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.bgCommand = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.EquipWearClick,self.groupId,self.data.index, self)
    end
    LuaMgr.AddClick(self.bgButton,self.bgCommand)
    return self
end

function EquipExchangeItem:SetData(data,groupId)
    self.data = data
    self.groupId = groupId
    local equipData = DataMgr.Player.equipments[self.data.equipId]
    local equipConfig = ConfigMgr.Config.equipments[self.data.equipIdState]
    if equipData == nil or equipConfig == nil then return end
    self.rare.sprite = LuaMgr.GetSprite("ItemRare","itemRare"..equipConfig.rare)
    self.icon.texture = LuaMgr.GetTexture(ConfigHelper.GetItemIconPath(equipConfig.id))
    self.level.text = string.format("lv.%d",equipData.level)
    SetActive(self.lock,equipData.locking)
    SetActive(self.using,self.data.usingState)

    local attrLockNum = 0
    if type(equipData.additionalAttrs) ~= "function" and not TableIsNull(equipData.additionalAttrs) then
        for i = 1, #equipData.additionalAttrs do
            if equipData.additionalAttrs[i].lock then
                attrLockNum = attrLockNum + 1
            end
        end
    end
    if attrLockNum > 0 then
        self.lockImg.sprite = LuaMgr.GetSprite("Backpack","attrLock_"..attrLockNum)
    end
    SetActive(self.attrState,attrLockNum > 0)
    
    SetActive(self.star1,self.data.starState >= 1)
    SetActive(self.star2,self.data.starState >= 2)
    SetActive(self.star3,self.data.starState >= 3)
    SetActive(self.star4,self.data.starState >= 4)
    SetActive(self.star5,self.data.starState >= 5)
    SetActive(self.star6,self.data.starState >= 6)
    SetActive(self.choose,self.data.choose)
    SetActive(self.contrast,self.data.contrast)
    self.gameObject:SetActive(true)
end

function EquipExchangeItem:SetLocked(locking)
    SetActive(self.lock, locking)
end

function EquipExchangeItem:Clear()
    self.data = nil
    self.gameObject:SetActive(false)
end

function EquipExchangeItem:Destroy()
    if (self.bgCommand ~= nil) then
        LuaMgr.RemoveClick(self.bgButton, self.bgCommand)
        self.bgCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end