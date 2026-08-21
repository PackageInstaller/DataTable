module("bag.BagEquipScrollerItem", Class.impl(bag.BagScrollerItem))

--背包武器Item 模组 手环
function setGrid(self)
    local selectVo = self.data
    local equipVo = selectVo:getDataVo()
    if (equipVo) then
        -- if(bag.BagManager.propsOpState == 2 and equipVo.isLock == 1 or not equipVo.isCanDecompose) then
        --     -- self:setNormalSelect(false)
        --     self.isSelect = false
        --     if(bag.BagManager:getBreakSelect(equipVo)) then 
        --         bag.BagManager:setBreakProps(equipVo.id)
        --     end
        -- else
        --     self.isSelect = bag.BagManager:getBreakSelect(equipVo)
        --     -- self:setNormalSelect(self.isSelect)
        -- end

        bag.BagManager:addEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)

        if (self.mPropsGrid) then
            self.mPropsGrid:poolRecover()
        end
         
        if  equipVo.type == PropsType.EQUIP and equipVo.subType == PropsEquipSubType.SLOT_7 then 
            self.mPropsGrid = BraceletsGrid:poolGet()
        else 
            self.mPropsGrid = EquipGrid:poolGet()
        end

        self.mPropsGrid:setData(equipVo, self.mTransAction)
        self.mPropsGrid:setIsShowUseInTip(true)
        self.mPropsGrid:setShowLockState(true)
        self.mPropsGrid:setShowHeroIcon(true)
        -- 此处屏蔽，由PropsGrid默认的触发tip动画
        -- self.mPropsGrid:setCallBack(self, self.onClickGridHandler)
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

function removeActionFrameSn(self)
    if (self.mActionFrameSn) then
        LoopManager:removeFrameByIndex(self.mActionFrameSn)
        self.mActionFrameSn = nil
    end
end

function onClickGridHandler(self)
    local selectVo = self.data
    local equipVo = selectVo:getDataVo()
    local rect = self.mPropsGrid:getIconRect()
    local id = equipVo.id or 0
    logInfo("道具id：" .. id .. ", tid: " .. equipVo.tid)
    self.isNew = read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, equipVo.id)
    if self.isNew then
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NEW_EQUIP, id = equipVo.id })
    end
    bag.BagManager:dispatchEvent(bag.BagManager.SELECT_PROPS_GRID, { selectVo = selectVo, rectTransform = rect })
end

function deActive(self)
    super.deActive(self)
    if (self.mPropsGrid) then
        self.mPropsGrid:poolRecover()
        self.mPropsGrid = nil
    end
    bag.BagManager:removeEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)
    self:removeActionFrameSn()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]