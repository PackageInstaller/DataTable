module("bag.BagEquipTabView", Class.impl(bag.BagBaseTabView))

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
    self.mSuitId = nil
    self.mPropsId = nil
    if (not self.m_uiRootSize) then
        local uiRootRect = GameView.stage:GetComponent(ty.RectTransform)
        self.m_uiRootSize = uiRootRect.sizeDelta
    end
end

function configUI(self)
    super.configUI(self)
    self.mGridScrollerGo:SetActive(false)
    -- 装备套装列表
    self.mSuitScrollerGo = self:getChildGO("SuitScroller")
    self.mSuitScroller = self.mSuitScrollerGo:GetComponent(ty.LyScroller)
    self.mSuitScroller:SetItemRender(bag.BagEquipScrollerItem)
    self.mSuitScrollerRect = self:getChildGO("SuitList"):GetComponent(ty.RectTransform)
    self.mGroupSuitActin = self:getChildGO("SuitList")
    self.mTxtEquipNum = self:getChildGO("mTxtEquipNum"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
    bag.BagManager:addEventListener(bag.BagManager.SELECT_EQUIP_SUIT, self.onSelectSuitHandler, self)
    -- self.mTabBarEquipSlot:setType(0)
    self.mTxtEquipNum.gameObject:SetActive(true)
end

function deActive(self)
    super.deActive(self)
    if self.mSuitScroller then
        self.mSuitScroller:CleanAllItem()
    end
    bag.BagManager:removeEventListener(bag.BagManager.SELECT_EQUIP_SUIT, self.onSelectSuitHandler, self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SELL_BREAK_VIEW)
    self.mTxtEquipNum.gameObject:SetActive(false)
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end

function getSuitID(self)
    local suitFilterType = self.mSortView:getSuitFilterType()
    return (suitFilterType ~= -1 and suitFilterType ~= nil) and suitFilterType.suitId or suitFilterType
end

-- 背包红点更新
function onBubbleUpdateHandler(self, args)
    super.onBubbleUpdateHandler(self, args)
end

-- 背包初始化（一登陆/断线重连/服务器道具id重置）
function onBagInitHandler(self, args)
    super.onBagInitHandler(self, args)
end

-- 背包更新
function onBagUpdateHandler(self, args)
    super.onBagUpdateHandler(self, args)

    -- 因为背包列表不显示空格子了，只有更新和删除情况下才可以取到虚拟列表的对应项，新增无法取到对应项，为了方便直接整体刷新数据
    -- 判断选中的物品是否被删掉了
    local delList = args.delList
    local len
    len = #delList
    for i = 1, len do
        local propsVo = delList[i]
        if (propsVo.id == self.mPropsId) then
            self.mPropsId = nil
        end
    end
end

-- 点击了装备套装
function onSelectSuitHandler(self, args)
end

function showSortView(self)
    -- -- 可能由外部指定显示套装，放在这里先加上个套装菜单和部位菜单
    -- local suitConfigList = equip.EquipSuitManager:getFormatSuitConfigList(nil, nil)
    -- table.insert(suitConfigList, 1, -1)
    -- local showSuitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(self.mSuitId)
    -- self.mSortView:addSuitMenu(suitConfigList, showSuitConfigVo, false)
    self.mSortView:showDetailFilterMenu(true)
    self.mSortView:addPosMenu({-1, PropsEquipSubType.SLOT_1, PropsEquipSubType.SLOT_2, PropsEquipSubType.SLOT_3, PropsEquipSubType.SLOT_4, PropsEquipSubType.SLOT_5, PropsEquipSubType.SLOT_6 }, nil, false)
    super.showSortView(self)
end

function setData(self, cusTabType, cusParams)
    super.setData(self, cusTabType, cusParams)
    self.mSuitId = cusParams.suitId
end

-- 列表数据覆盖基类装载
function loadGridData(self, cusIsInit)
    if (cusIsInit == nil or cusIsInit == true) then
        self.mSuitScroller.DataProvider = self.mScrollList
    else
        -- 避免列表跳动
        if (self.mSuitScrollerRect.anchoredPosition.y <= 5) then
            self.mSuitScroller.DataProvider = self.mScrollList
        else
            self.mSuitScroller:ReplaceAllDataProvider(self.mScrollList)
        end
    end

    local maxValue = sysParam.SysParamManager:getValue(SysParamType.EQUIP_MAX_COUNT)
    self.mTxtEquipNum.text = _TT(4387,#self.mScrollList,maxValue)
end

function updatePropsListView(self, cusIsInit)
    -- self.mTabBarEquipSlot:getType()
    -- 普通筛选
    -- local suitFilterType = self.mSortView:getSuitFilterType()
    -- local suitId = (suitFilterType ~= -1 and suitFilterType ~= nil) and suitFilterType.suitId or suitFilterType
    -- local slotPos = self.mSortView:getPosFilterType() ~= -1 and self.mSortView:getPosFilterType() or nil
    -- local propsList = bag.BagManager:getBagPagePropsList(self.mTabType, suitId, slotPos, self.mSortData, self:getBagType())

    -- 特殊筛选
    local colorList, suitIdList, mainAttrKeyList, attachAttrKeyList = self.mSortView:getDetailFilterData()
    local slotPosList = self.mSortView:getPosFilterType() ~= -1 and {self.mSortView:getPosFilterType()} or nil
    local equipList = bag.BagManager:getBagPagePropsList(self.mTabType, suitIdList, slotPosList, colorList, self.mSortData, self:getBagType())
    if((mainAttrKeyList and #mainAttrKeyList > 0) or (attachAttrKeyList and #attachAttrKeyList > 0))then
        for i = #equipList, 1, -1 do
            local equipVo = equipList[i]
            local filterMainAttrList, filterMainAttrDic, filterAttachAttrList, filterAttachAttrDic = nil, nil, nil, nil
            local totalAttrList, totalAttrDic = equipVo:getTotalAttr()
            if (totalAttrList == nil and totalAttrDic == nil) then
                filterMainAttrList, filterMainAttrDic, filterAttachAttrList, filterAttachAttrDic = equipVo:getFilterAttr()
            else
                filterMainAttrList, filterMainAttrDic = equipVo:getMainAttr()
                filterAttachAttrList, filterAttachAttrDic = equipVo:getTuPoAttachAttr()
            end

            local isHadRemove = false
            if(not isHadRemove and mainAttrKeyList)then
                local isInMainAttr = false
                for _, key in pairs(mainAttrKeyList) do
                    if(filterMainAttrDic[key])then
                        isInMainAttr = true
                        break
                    end
                end
                if(not isInMainAttr)then
                    isHadRemove = true
                    table.remove(equipList, i)
                end
            end

            if(not isHadRemove and attachAttrKeyList)then
                local isHadAllAttachAttr = true
                for _, key in pairs(attachAttrKeyList) do
                    if(not filterAttachAttrDic[key])then
                        isHadAllAttachAttr = false
                        break
                    end
                end
                if(not isHadAllAttachAttr)then
                    isHadRemove = true
                    table.remove(equipList, i)
                end
            end
        end
    end

    self.mScrollList = {}
    for pos = 1, #equipList do
        local propsVo = equipList[pos]
        if bag.BagManager.propsOpState ~= 2 or propsVo.isLock ~= 1 then
            local scrollerVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollerVo:setDataVo(propsVo)
            scrollerVo:setSelect(false)

            if self:getBreakSelect(propsVo) then
                scrollerVo:setArgs({ selectBreak = true })
            else
                scrollerVo:setArgs(nil)
            end
            table.insert(self.mScrollList, scrollerVo)
        end
    end
    local mListHelper = {}
    for _, scrollerVo in pairs(self.mScrollList) do
        if scrollerVo:getDataVo().heroId > 0 then
            table.insert(mListHelper, scrollerVo)
        end
    end
    for _, scrollerVo in pairs(mListHelper) do
        table.removebyvalue(self.mScrollList, scrollerVo)
    end

    local pos = 1
    for _, scrollerVo in pairs(mListHelper) do
        table.insert(self.mScrollList, pos, scrollerVo)
        pos = pos + 1
    end
    self:loadGridData(cusIsInit)


end

function updateEmptyTip(self)
    GameDispatcher:dispatchEvent(EventName.BAG_EMPTY_STATE, self.mSuitScroller.Count > 0)
end

-- 供外部关闭按钮调用
function isInSuitView(self)
    return self.mSuitScrollerGo.activeSelf
end

function getBagType(self)
    return bag.BagType.Equip
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]