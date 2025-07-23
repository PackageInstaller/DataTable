module("bag.BagEquipPreviewScrollerItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mTransAction = self.m_childTrans["GroupAction"]

    self:addOnClick(self.UIObject.gameObject, self.onClickItemHandler)
end

function setData(self, param)
    super.setData(self, param)

    local selectVo = self.data
    local equipVo = selectVo:getDataVo()
    if (equipVo) then
        bag.BagManager:addEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)

        if (not self.mEquipGrid) then
            if equipVo.__cname == props.EquipVo.__cname then
                self.mEquipGrid = EquipGrid:poolGet()
                self.mEquipGrid:setData(equipVo, self.mTransAction)
            end
            if equipVo.__cname == props.OrderVo.__cname then
                self.mEquipGrid = OrderGrid:poolGet()
                self.mEquipGrid:setParent(self.mTransAction)
            end
        end
        self.mEquipGrid:setIsShowUseInTip(false)
        self.mEquipGrid:setCallBack(self, self.onClickItemHandler)
    else
        self:deActive()
    end
end

function onPlayGridActionHandler(self)
    self:removeActionFrameSn()
    self.mInitRotate = 180
    self.mAddRotate = 5
    self.mAcceleration = 1
    self.mAddTime = 0
    gs.TransQuick:SetRotation(self.mTransAction, 0, self.mInitRotate, 0)
    self.mActionFrameSn = LoopManager:addFrame(1, 0, self, self.onActionFrameHandler)
end

function onActionFrameHandler(self, deltaTime)
    self.mAddTime = self.mAddTime + 1
    self.mInitRotate = self.mInitRotate - self.mAddRotate - self.mAcceleration * self.mAddTime
    self.mInitRotate = self.mInitRotate < 0 and 0 or self.mInitRotate
    gs.TransQuick:SetRotation(self.mTransAction, 0, self.mInitRotate, 0)
    if (self.mInitRotate <= 0) then
        self:removeActionFrameSn()
    end
end

function removeActionFrameSn(self)
    if (self.mActionFrameSn) then
        LoopManager:removeFrameByIndex(self.mActionFrameSn)
        self.mActionFrameSn = nil
    end
end

function onClickItemHandler(self)
    local selectVo = self.data
    local equipVo = selectVo:getDataVo()

    local rect = self.mEquipGrid:getIconRect()
    local id = equipVo.id or 0

    bag.BagManager:dispatchEvent(bag.BagManager.SELECT_PROPS_GRID, { selectVo = selectVo, rectTransform = rect })
end

function deActive(self)
    super.deActive(self)
    if (self.mEquipGrid) then
        self.mEquipGrid:poolRecover()
        self.mEquipGrid = nil
    end
    bag.BagManager:removeEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)
    self:removeActionFrameSn()
end

function onDelete(self)
    self:removeOnClick(self.UIObject.gameObject, self.onClickItemHandler)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]