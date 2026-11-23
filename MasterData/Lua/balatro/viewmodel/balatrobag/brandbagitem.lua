












BrandBagItem = {}
BrandBagItem.__index = BrandBagItem

local objs = {
    clickBtn = {path = "", type = BalatroUtil.Button},
    dragEvent = {path = "", type = BalatroUtil.OnDragEvent},
    frame = {path = "Frame", type = BalatroUtil.Image},
    icon = {path = "Icon", type = BalatroUtil.Image},
    lockFlag = {path = "LockFlag", type = BalatroUtil.GameObject}
}

function BrandBagItem.New(prefab, parent)

    local self = {}
    setmetatable(self, BrandBagItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickItem = function()
        LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroBagOpenTips, self)
    end
    LuaMgr.AddClick(self.clickBtn, self.OnClickItem)
    return self
end


function BrandBagItem:SetData(data)
    self._data = data
    SetActive(self.gameObject, true)
    self.frame.sprite = nil
    SetActive(self.frame.gameObject, false)
    self.icon.sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, data:GetResName())
    SetActive(self.lockFlag, data:GetOwnStatus() == BalatroUtil.BalatroOwnStatus.None)
end


function BrandBagItem:GetData()
    return self._data
end

function BrandBagItem:GetGameObject()
    return self.gameObject
end

function BrandBagItem:Clear()
    self._data = nil
    SetActive(self.gameObject, false)
end

function BrandBagItem:Destroy()
    if (self.OnClickItem ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.OnClickItem)
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end