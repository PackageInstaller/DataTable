module("bag.BreakHeroEggScrollerItem", Class.impl(bag.BagEquipScrollerItem))

--背包武器Item 模组 手环
function setGrid(self)
    local selectVo = self.data
    local equipVo = selectVo:getDataVo()
    if (equipVo) then
        if(bag.BagManager.propsOpState == 2 and equipVo.isLock == 1 or not equipVo.isCanDecompose) then
        self:setNormalSelect(false)
        self.isSelect = false
        if(bag.BagManager:getBreakSelect(equipVo)) then 
                bag.BagManager:setBreakProps(equipVo.id)
            end
        else
            self.isSelect = bag.BagManager:getBreakSelect(equipVo)
            self:setNormalSelect(self.isSelect)
        end

        bag.BagManager:addEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)

        if (self.mPropsGrid) then
            read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.mPropsGrid.updateIsNew, self.mPropsGrid)
            self.mPropsGrid:poolRecover()
        end
         

        self.mPropsGrid = PropsGrid:poolGet()
      

        self.mPropsGrid:setData(equipVo, self.mTransAction)
        self.mPropsGrid:setIsShowUseInTip(true)
        --self.mPropsGrid:setShowLockState(true)
        --self.mPropsGrid:setShowHeroIcon(true)
        -- 此处屏蔽，由PropsGrid默认的触发tip动画
        -- self.mPropsGrid:setCallBack(self, self.onClickGridHandler)
        read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.mPropsGrid.updateIsNew, self.mPropsGrid)
    else
        self:deActive()
    end
end

-- 设置普通选中状态
function setNormalSelect(self, isSelect, isClick)
    if (isSelect) then
        self.isNew = read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, self.data:getDataVo().id)
        if self.isNew then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {type = ReadConst.NEW_EQUIP, id = self.data:getDataVo().id})
        end
        self:getChildGO("mImgSelect"):SetActive(true)
        if self.mPropsGrid and isClick and bag.BagManager:getBreakBraceletsShowTips() then
            --self.mPropsGrid:onDefaultClickHandler()
        end
    else
        self:getChildGO("mImgSelect"):SetActive(false)
    end
    self.isSelect = isSelect
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
    --self.isSelect = bag.BagManager:getBreakSelect(equipVo)
    --self:setNormalSelect(self.isSelect, true)
end


function deActive(self)
    super.deActive(self)
    if (self.mPropsGrid) then
        read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.mPropsGrid.updateIsNew, self.mPropsGrid)
        self.mPropsGrid:poolRecover()
        self.mPropsGrid = nil
    end
    bag.BagManager:removeEventListener(bag.BagManager.START_BAG_ITEM_ACTION, self.onPlayGridActionHandler, self)
    self:removeActionFrameSn()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]