













BalatroBrandShowItem = {}
BalatroBrandShowItem.__index = BalatroBrandShowItem

BalatroBrandShowItem.ItemType = {
    None = 0,
    Balatro = 1,
    Props = 2
}

local objs = {
    dragEvent = {path = "", type = BalatroUtil.OnDragEvent},
    animator = {path = "", type = BalatroUtil.Animator},
    icon = {path = "Icon", type = BalatroUtil.Image},
    lockFlag = {path = "Icon/LockFlag", type = BalatroUtil.Image},
}

function BalatroBrandShowItem.New(obj, parent, itemType, index)

    local self = {}
    setmetatable(self, BalatroBrandShowItem)
    print(obj.name, parent.name)
    self.gameObject = LuaMgr.InstantiateGO(obj, parent, false)
    self.gameObject.name = string.format("BrandShow_%d_%d", itemType, index)
    self.transform = self.gameObject.transform
    self.transform.localEulerAngles = Vector3.zero
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.gameObject, true)
    self.ItemType = itemType
    self.siblingIndex = 0
    self.tweener = nil
    self:SetInValid(false)
    return self
end





function BalatroBrandShowItem:SetDragEvent(index, onPointerDown, onDrag, onPointerUp)
    if not self.dragEvent then
        return
    end
    self.dragEvent:SetData(index, onPointerDown, onDrag, onPointerUp)
end

function BalatroBrandShowItem:GetPosition()
    return self.transform.localPosition
end

function BalatroBrandShowItem:SetPosition(posX, posY, noTweener, callback)
    if not noTweener then
        self.tweenCallback = callback
        self:RemoveTweener()
        local func = function()
            self.tweener = nil
            self.siblingIndex = self.transform:GetSiblingIndex()
            if self.tweenCallback then
                self.tweenCallback(self)
            end
        end
        self.tweener = self.transform:DOLocalMoveY(posY, 0.3):OnComplete(func)
    else
        self.transform.localPosition = Vector3(posX, posY, 0)
    end
end

function BalatroBrandShowItem:GetObjName()
    return self.gameObject.name
end

function BalatroBrandShowItem:RemoveTweener()
    if self.tweener then
        self.tweener:Kill(false)
        self.tweener = nil
    end
end

function BalatroBrandShowItem:GetSiblingIndex()
    return self.siblingIndex
end

function BalatroBrandShowItem:SetSiblingIndex(index)
    self.siblingIndex = index
    self:ConfirmSiblingIndex()
end

function BalatroBrandShowItem:GetRealSiblingIndex()
    return self.transform:GetSiblingIndex()
end

function BalatroBrandShowItem:ConfirmSiblingIndex()
    self.transform:SetSiblingIndex(self.siblingIndex)
end


function BalatroBrandShowItem:SetBalatroData(data)
    self.balatroData = data
    if self.balatroData then
        self:SetIcon(self.balatroData:GetResName())
    end
end


function BalatroBrandShowItem:GetBalatroData()
    return self.balatroData
end


function BalatroBrandShowItem:SetPropsData(data)
    self.propsData = data
    if self.propsData then
        self:SetIcon(self.propsData:GetResName())
    end
end


function BalatroBrandShowItem:GetPropsData()
    return self.propsData
end

function BalatroBrandShowItem:SetIcon(resID)
    local sprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, resID)
    self.icon.sprite = sprite
end

function BalatroBrandShowItem:GetItemType()
    return self.ItemType
end

function BalatroBrandShowItem:SetVisible(visible)
    SetActive(self.gameObject, visible)
    if visible == false then
        if self.ItemType == BalatroBrandShowItem.ItemType.Balatro then
            self.balatroData = nil
        elseif self.ItemType == BalatroBrandShowItem.ItemType.Props then
            self.propsData = nil
        end
    end
end

function BalatroBrandShowItem:IsVisible()
    return self.gameObject.activeSelf
end

function BalatroBrandShowItem:SetInValid(isInvalid)
    SetActive(self.lockFlag.gameObject, isInvalid)
end

function BalatroBrandShowItem:PlayAnim(name)
    self.animator:Play(name)
end