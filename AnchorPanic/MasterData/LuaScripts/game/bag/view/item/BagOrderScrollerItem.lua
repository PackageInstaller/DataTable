module("bag.BagOrderScrollerItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mTransAction = self.m_childTrans["GroupAction"]
end

function setData(self, param)
    super.setData(self, param)

    local selectVo = self.data
    local equipVo = selectVo:getDataVo()
    if (equipVo) then
        -- self:setNormalSelect(selectVo:getSelect())
        -- 分解选中
        if selectVo:getArgs() and selectVo:getArgs().selectBreak ~= nil then
            self:setNormalSelect(selectVo:getArgs().selectBreak)
        else
            self:setNormalSelect(false)
        end

        bag.BagManager:addEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)

        if (not self.mEquipGrid) then
            self.mEquipGrid = OrderGrid:poolGet()
        end
        self.mEquipGrid:setData(equipVo)
        self.mEquipGrid:setParent(self.mTransAction)
        self.mEquipGrid:setIsShowUseInTip(true)
        -- self.mEquipGrid:setPosition(gs.Vector3(140 / 2, -140 / 2, 0))
        -- 此处屏蔽，由PropsGrid默认的触发tip动画
        -- self.mEquipGrid:setCallBack(self, self.onClickItemHandler)
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

-- 设置普通选中状态
function setNormalSelect(self, isSelect)
    if (isSelect) then
        self.m_childGos["ImgSelect"]:SetActive(true)
    else
        self.m_childGos["ImgSelect"]:SetActive(false)
    end
end

-- 设置分解时的选中状态
function setDecomposeSelect(self, isSelect)
    if (self.mEquipGrid) then
        if (isSelect) then
            self.mEquipGrid:setSelectState(true)
        else
            self.mEquipGrid:setSelectState(false)
        end
    end
end

function onClickItemHandler(self)
    local selectVo = self.data
    local equipVo = selectVo:getDataVo()
    -- 此处屏蔽，主动触发tip动画
    -- tips.EquipTips:showTips(equipVo, nil, {rectTransform = self.m_childTrans["ImgIcon"]:GetComponent(ty.RectTransform)})

    local rect = self.mEquipGrid:getIconRect()
    local id = equipVo.id or 0
    logInfo("道具id：" .. id .. ", tid: " .. equipVo.tid)

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
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
