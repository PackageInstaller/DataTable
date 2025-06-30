module("bag.BagScrollerItem", Class.impl("lib.component.BaseItemRender"))

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self:getChildGO("mBtnClickItem"), self.onClickGridHandler)
end

function onInit(self, go)
    super.onInit(self, go)
    self.mTransAction = self.m_childTrans["GroupAction"]
end

function active(self)
    super.active(self)
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateBubbleState, self)
end

function setData(self, param)
    super.setData(self, param)
    self:setGrid()

end

function setGrid(self)
    local selectVo = self.data
    local propsVo = selectVo:getDataVo()
    if (propsVo) then
        if not self.mPropsGrid then
            self.mPropsGrid = PropsSelectGrid:poolGet()
        end
        self:updateBubbleView()

        self.mPropsGrid:setData(propsVo)
        self.mPropsGrid:setParent(self.mTransAction)
        self.mPropsGrid:setIsShowUseInTip(true)
        -- 此处屏蔽，由PropsGrid默认的触发tip动画
        -- self.mPropsGrid:setCallBack(self, self.onClickGridHandler)
        -- 分解选中
        if selectVo:getArgs() and selectVo:getArgs().selectBreak then
            self:setDecomposeSelect(selectVo:getArgs().selectBreak)
        else
            self:setDecomposeSelect(false)
        end

        bag.BagManager:addEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)
    else
        self:deActive()
    end
end

function updateBubbleState(self)
    self:updateBubbleView()
end

function updateBubbleView(self)
    local isBubble = false
    local selectVo = self.data
    local propsVo = selectVo:getDataVo()
    if (propsVo) then
        isBubble = bag.BagManager:checkIsNewAdd(propsVo)
    end
    if (isBubble) then
        self.mFrameOutSn =LoopManager:setFrameout(1, self, function()
            local redSouce=UrlManager:getCommon5Path("common_0223.png")
            local pos=gs.Vector2(45,59.2)
            if (propsVo.effectType == UseEffectType.ADD_DISCOUNT_ITEM) then
                redSouce=nil
                pos=gs.Vector2(64,64)
            end
            RedPointManager:add(self.m_childTrans["GroupAction"], redSouce, pos.x, pos.y)
        end)
    else
        RedPointManager:remove(self.m_childTrans["GroupAction"])
    end
end

function onPlayGridActionHandler(self)
    self:removeActionFrameSn()
    self.mInitRotate = 180
    self.mAddRotate = 5
    self.mAcceleration = 1
    self.mAddTime = 0
    self.mActionFrameSn = LoopManager:addFrame(1, 0, self, self.onActionFrameHandler)
end

function onActionFrameHandler(self)
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
    gs.TransQuick:SetRotation(self.mTransAction, 0, 0, 0)
end

-- 设置分解时的选中状态
function setDecomposeSelect(self, isSelect)
    if (self.mPropsGrid) then
        if (isSelect) then
            self.mPropsGrid:setSelectState(true)
        else
            self.mPropsGrid:setSelectState(false)
        end
    end
end

function onClickGridHandler(self, args)
    local selectVo = self.data
    local propsVo = selectVo:getDataVo()
    local rect = self.mPropsGrid:getIconRect()
    local id = propsVo.id or 0
    logInfo("道具id：" .. id .. ", tid: " .. propsVo.tid)
    local cusType=propsVo.effectType == UseEffectType.ADD_DISCOUNT_ITEM and ReadConst.DISCOUNT_BUBBLE or ReadConst.NORMALBAGITEM
    self.isNew = read.ReadManager:isModuleRead(cusType, propsVo.tid)
    if self.isNew then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = cusType, id = propsVo.tid })
    end
    bag.BagManager:dispatchEvent(bag.BagManager.SELECT_PROPS_GRID, { selectVo = selectVo, isShowUseBtn = self.mPropsGrid:getCanUseInTip(), rectTransform = rect })
end

function deActive(self)
    super.deActive(self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updateBubbleState, self)
    if self.UIObject then
        RedPointManager:remove(self.mTransAction)
    end
    if (self.mPropsGrid) then
        -- GameDispatcher:removeEventListener(self.mPropsGrid.EVENT_LOAD_FINISH, self.onLoadFinishHandler, self)
        self.mPropsGrid:poolRecover()
        self.mPropsGrid = nil
    end
    bag.BagManager:removeEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)
    self:removeActionFrameSn()

    LoopManager:removeFrameByIndex(self.mFrameOutSn)
    self.mFrameOutSn = nil
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]