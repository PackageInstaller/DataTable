


























BalatroBrandItem = {}
BalatroBrandItem.__index = BalatroBrandItem

BalatroBrandItem.SizeType = {
    Big = 1,
    Middle = 2,
    Small = 3
}

BalatroBrandItem.ExistBeselectedItem = false
BalatroBrandItem.ToMiddleAniName = "UIBalatro_DealBrand_tomiddle"
BalatroBrandItem.ToBigAniName = "UIBalatro_DealBrand_tobig"
BalatroBrandItem.ClickAniName = "UIBalatro_DealBrand_click"
BalatroBrandItem.LoopAniName = "UIBalatro_DealBrand_loop"
BalatroBrandItem.SmallBornAniName = "UIBalatro_DealBrand_smallsize_born"
BalatroBrandItem.DealScoreAniName = "UIBalatro_DealBrand_Score"
BalatroBrandItem.DealBrandAniName = "UIBalatro_DealBrand"

local objs = {
    rectTrans = {path = "", type = BalatroUtil.RectTransform},
    dragEvent = {path = "", type = BalatroUtil.OnDragEvent},
    animator = {path = "", type = BalatroUtil.Animator},
    sizeBig = {path = "SizeBig", type = BalatroUtil.Image},
    sizeMiddle = {path = "SizeMiddle", type = BalatroUtil.Image},
    sizeSmall = {path = "SizeSmall", type = BalatroUtil.Image},
    superBigIcon = {path = "SizeBig/luckIcon", type = BalatroUtil.Image},
    superMiddleIcon = {path = "SizeMiddle/luckIcon", type = BalatroUtil.Image},
    superSmallIcon = {path = "SizeSmall/luckIcon", type = BalatroUtil.Image},
    weakFlagBig = {path = "SizeBig/weakFlag", type = BalatroUtil.Image},
    weakFlagMiddle = {path = "SizeMiddle/weakFlag", type = BalatroUtil.Image},
    weakFlagSmall = {path = "SizeSmall/weakFlag", type = BalatroUtil.Image},
    chooseFlagBig = {path = "SizeBig/lightIcon", type = BalatroUtil.Image},
    chooseFlagMiddle = {path = "SizeMiddle/lightIcon", type = BalatroUtil.Image},
    chooseFlagSmall = {path = "SizeSmall/lightIcon", type = BalatroUtil.Image},
    usedFlagSmall = {path = "SizeSmall/darkIcon", type = BalatroUtil.GameObject},
    jumpWordItem = {path = "SizeSmall/JumpWordPrefab", type = BalatroUtil.GameObject}
}

function BalatroBrandItem.New(prefab, parent, existEvent, index)

    local self = {}
    setmetatable(self, BalatroBrandItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self.gameObject.name = string.format("BalatroBrandItem_%s", tostring(index))
    UITool.Parse(self.gameObject, self, objs)
    self._IsChoose = false
    if existEvent then
        local onDown = function(index, eventData)
            self:OnDown(index, eventData)
        end
        local onDrag = function(eventData)
            self:OnDrag(eventData)
        end
        local onUp = function(eventData)
            self:OnUp(eventData)
        end
        local onPointerEnter = function(eventData)
            self:OnPointerEnter(eventData)
        end
        local onPointerExit = function(eventData)
            self:OnPointerExit(eventData)
        end
        self.dragEvent:SetData(index, onDown, onDrag, onUp)
        self.dragEvent:SetPointerData(onPointerEnter, onPointerExit)
    end
    self.jumpWordItemData = BalatroJumpWordItem.New(self.jumpWordItem, nil, false)
    SetActive(self.jumpWordItemData.gameObject, false)
    return self
end

function BalatroBrandItem:GetRectTrans()
    return self.rectTrans
end

function BalatroBrandItem:SetSiblingIndex(index)
    self.rectTrans:SetSiblingIndex(index)
end





function BalatroBrandItem:SetData(sizeType, spritName, data)
    if spritName then
        local tempSprite = LuaMgr.GetSprite(BalatroUtil.AlataGeneralBrand, spritName)
        self.sizeBig.sprite = tempSprite
        self.sizeMiddle.sprite = tempSprite
        self.sizeSmall.sprite = tempSprite
    end
    if data then
        self.data = data
    end
    SetActive(self.sizeBig.gameObject, false)
    SetActive(self.sizeMiddle.gameObject, false)
    SetActive(self.sizeSmall.gameObject, false)
    local image = nil
    if sizeType == BalatroBrandItem.SizeType.Big then
        image = self.sizeBig
    elseif sizeType == BalatroBrandItem.SizeType.Middle then
        image = self.sizeMiddle
    else
        image = self.sizeSmall
    end
    SetActive(image.gameObject, true)
    self:SetSuperType()
    self:SetWeakFlag()
end

function BalatroBrandItem:SetSuperType()
    SetActive(self.superBigIcon.gameObject, false)
    SetActive(self.superMiddleIcon.gameObject, false)
    SetActive(self.superSmallIcon.gameObject, false)
    if self.data == nil then
        return
    end
    local superType = self.data:GetSuperShowType()
    if superType == BalatroUtil.ShowType.Normal then
        return
    end
    SetActive(self.superBigIcon.gameObject, true)
    SetActive(self.superMiddleIcon.gameObject, true)
    SetActive(self.superSmallIcon.gameObject, true)
    local tempSprite = LuaMgr.GetSprite(BalatroUtil.AlataOther, string.format("lucky_%d", superType - 1))
    self.superBigIcon.sprite = tempSprite
    self.superMiddleIcon.sprite = tempSprite
    self.superSmallIcon.sprite = tempSprite
end

function BalatroBrandItem:SetWeakFlag()
    SetActive(self.weakFlagBig.gameObject, false)
    SetActive(self.weakFlagMiddle.gameObject, false)
    SetActive(self.weakFlagSmall.gameObject, false)
    if self.data == nil then
        return
    end
    SetActive(self.weakFlagBig.gameObject, self.data:GetIsValid() == false)
    SetActive(self.weakFlagMiddle.gameObject, self.data:GetIsValid() == false)
    SetActive(self.weakFlagSmall.gameObject, self.data:GetIsValid() == false)
end

function BalatroBrandItem:SetChooseFlag()
    SetActive(self.chooseFlagBig.gameObject, false)
    SetActive(self.chooseFlagMiddle.gameObject, false)
    SetActive(self.chooseFlagSmall.gameObject, false)
    if self.data == nil then
        return
    end
    SetActive(self.chooseFlagBig.gameObject, self.data:GetIsValid() == false)
    SetActive(self.chooseFlagMiddle.gameObject, self.data:GetIsValid() == false)
    SetActive(self.chooseFlagSmall.gameObject, self.data:GetIsValid() == false)
end

function BalatroBrandItem:SetUsedFlag()
    SetActive(self.usedFlagSmall, false)
    if self.data == nil then
        return
    end
    SetActive(self.usedFlagSmall, self.data:GetUsed() == true)
end



function BalatroBrandItem:GetData()
    return self.data
end

function BalatroBrandItem:IsChoosed()
    return self._IsChoose
end

function BalatroBrandItem:Reset()
    if self.gameObject == nil then
        return
    end
    self._IsChoose = false
    SetActive(self.sizeBig.gameObject, false)
    SetActive(self.sizeMiddle.gameObject, true)
end

function BalatroBrandItem:OnDown(index, eventData)
    if BalatroDataMgr.GetSettlingStatus() == true then
        self:PlayAnim(BalatroBrandItem.ClickAniName)
        return
    end
    BalatroBrandItem.ExistBeselectedItem = true
    self:OnChooseBrand(true)
    BalatroUtil.PlaySound(3)
end

function BalatroBrandItem:OnDrag(eventData)
end

function BalatroBrandItem:OnUp(eventData)
    BalatroBrandItem.ExistBeselectedItem = false
end

function BalatroBrandItem:OnPointerEnter(eventData)
    if BalatroDataMgr.GetSettlingStatus() == true then
        self:PlayAnim(BalatroBrandItem.ClickAniName)
        return
    end
    if BalatroBrandItem.ExistBeselectedItem == true then
        self:OnChooseBrand(false)
        BalatroUtil.PlaySound(3)
    end
end

function BalatroBrandItem:OnPointerExit(eventData)
end

function BalatroBrandItem:Destroy(clearData)
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    if clearData then
        self.data = nil
    end
end

function BalatroBrandItem:OnChooseBrand(isClick)
    SetActive(self.sizeBig.gameObject, false)
    SetActive(self.sizeMiddle.gameObject, false)
    SetActive(self.sizeSmall.gameObject, false)
    if self._IsChoose == false then
        self._IsChoose = true
        SetActive(self.sizeBig.gameObject, true)
        if isClick ~= nil then
            self:PlayAnim(BalatroBrandItem.ToBigAniName)
        end
    else
        self._IsChoose = false
        SetActive(self.sizeMiddle.gameObject, true)
        if isClick ~= nil then
            self:PlayAnim(BalatroBrandItem.ToMiddleAniName)
        end
    end
    local data = {
        item = self,
        isChoose = self._IsChoose,
        isClick = isClick
    }
    LuaMgr.InvokeUIEventListeners(UIEventConst.BalatroChooseGeneralBrand, data)
end

function BalatroBrandItem:PlayAnim(name, isCal)
    self.animator:Play(name)
    if isCal == true and self.data:IsJoinCal() then
        local jumpItemData = {}
        jumpItemData.NumType = BalatroUtil.ResultType.Score
        jumpItemData.Symbol = BalatroUtil.CalSymbolType.Add
        jumpItemData.Number = self.data:GetPoint()
        jumpItemData.AnimName = "UIBalatro_JumpWordGeneral"
        SetActive(self.jumpWordItemData.gameObject, true)
        self.jumpWordItemData:SetData(jumpItemData)
    end
end