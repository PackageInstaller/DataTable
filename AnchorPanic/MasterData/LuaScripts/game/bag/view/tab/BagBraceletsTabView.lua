module("bag.BagBraceletsTabView", Class.impl(bag.BagBaseTabView))

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
    self.mPropsId = nil
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
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
    if self.mSuitScroller then
        self.mSuitScroller:CleanAllItem()
    end
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
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

function setData(self, cusTabType, cusParams)
    super.setData(self, cusTabType, cusParams)
end

function updateView(self, cusIsInit)
    super.updateView(self, cusIsInit)
    if (cusIsInit) then
        self:showSortView()
    end

end

function updatePropsListView(self, cusIsInit)
    local propsList = bag.BagManager:getBagPagePropsList(self.mTabType, nil, nil, nil, self.mSortData, self:getBagType())
    self.mScrollList = {}
    for pos = 1, #propsList do
        local propsVo = propsList[pos]
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
end

function updateEmptyTip(self)
    GameDispatcher:dispatchEvent(EventName.BAG_EMPTY_STATE, self.mSuitScroller.Count > 0)
end

function getBagType(self)
    return bag.BagType.Bracelets
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]