module("bag.BagBaseTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("bag/tab/BagNormalTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    super.initData(self)
    self.mTabType = nil
    self.mScrollList = {}
    self.mSortData = {}
end

function configUI(self)
    super.configUI(self)

    -- 排序页面
    self.mSortView = bag.BagNewSortView.new()
    self.mSortView:setParentTrans(self:getChildTrans("mTabBarNode"))
    -- self.mSortView:setAlignCenter(564 + 60.4, 268.58 - 35.3)
    self.mSortView:isShowHeroWear(nil)
    self.mSortView:setCallBack(self, self.onClickSortItemHandler)

    -- 道具格子列表
    self.mGridScrollerGo = self:getChildGO("GridScroller")
    self.mGridScroller = self.mGridScrollerGo:GetComponent(ty.LyScroller)
    self:setItemRender(self)
    self.mGridScrollerRect = self:getChildGO("GridList"):GetComponent(ty.RectTransform)
    self.mGroupActin = self:getChildGO("GridList")


end

function setItemRender(self)
    self.mGridScroller:SetItemRender(bag.BagScrollerItem)
end

function active(self)
    super.active(self)
    bag.BagManager:addEventListener(bag.BagManager.BUBBLE_CHANGE, self.onBubbleUpdateHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_INIT, self.__onBagInitHandler, self)
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
end

function deActive(self)
    super.deActive(self)
    bag.BagManager:removeEventListener(bag.BagManager.BUBBLE_CHANGE, self.onBubbleUpdateHandler, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_INIT, self.__onBagInitHandler, self)
    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.__onBagUpdateHandler, self)
    self.mSortView:resetAll()
    self:removeAction()

    self:recoverListData()
    if self.mGridScroller then
        self.mGridScroller:CleanAllItem()
    end
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)

    if self.mSortView then
        self.mSortView:destroy()
        self.mSortView = nil
    end
end

-- 背包红点更新
function onBubbleUpdateHandler(self, args)
end

-- 背包初始化（一登陆/断线重连/服务器道具id重置）
function __onBagInitHandler(self, args)
    self:updateView(false)
end

-- 背包更新
function __onBagUpdateHandler(self, args)
    self:updateView(false)
end

-- 点击了道具格子
function onSelectGridHandler(self, args)
    local selectPropsVo = args.selectVo:getDataVo()
    if (selectPropsVo.type == PropsType.EQUIP) then
        TipsFactory:equipTips(selectPropsVo)
    elseif (selectPropsVo.type ~= PropsType.EQUIP) then
        TipsFactory:propsTips(selectPropsVo)
    end
end

-- 设置排序数据
function showSortView(self)
    self.mSortView:addSortMenu(bag.getSortList(self.mTabType), nil, true, false)
end

-- 点击排序item
function onClickSortItemHandler(self)
    self.mSortData = { isDescending = self.mSortView:getIsDescending(), sortList = self.mSortView:getSortTypeList() }
    self:updateView(false)
end

function setData(self, cusTabType, cusParams)
    self.mTabType = cusTabType
    -- 进入默认一开始是降序
    self.mSortData = { isDescending = true, sortList = bag.getSortList(self.mTabType) }
    self.mPropsId = cusParams.propsId
    self:showSortView()
    self:updateView(true)
end

function updateView(self, cusIsInit)
    self:updatePropsListView(cusIsInit)
    self:updateEmptyTip()
end

-- 列表更新
function updatePropsListView(self, cusIsInit)
    local suitIdList = self.mSuitId and {self.mSuitId} or nil
    local propsList = bag.BagManager:getBagPagePropsList(self.mTabType, suitIdList, nil, nil, self.mSortData, self:getBagType())
    self.mScrollList = {}
    for pos = 1, #propsList do
        local propsVo = propsList[pos]
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
    self:loadGridData(cusIsInit)
end

-- 列表数据装载
function loadGridData(self, cusIsInit)
    if (cusIsInit == nil or cusIsInit == true) then
        self.mGridScroller.DataProvider = self.mScrollList
    else
        -- 避免列表跳动
        if (self.mGridScrollerRect.anchoredPosition.y <= 5) then
            self.mGridScroller.DataProvider = self.mScrollList
        else
            self.mGridScroller:ReplaceAllDataProvider(self.mScrollList)
        end
    end
end

function updateEmptyTip(self)
    GameDispatcher:dispatchEvent(EventName.BAG_EMPTY_STATE, self.mGridScroller.Count > 0)
end

function removeAction(self)
    if (self.mActionFrameSn) then
        LoopManager:removeFrameByIndex(self.mActionFrameSn)
        self.mActionFrameSn = nil
    end
end

-- 获取是否处于分解出售选中状态
function getBreakSelect(self, cusVo)
    local breakList = bag.BagManager:getBreakList()
    local sellData = bag.BagManager:getSellData()
    if sellData and cusVo.id == sellData.id then
        return true
    end
    if breakList and table.indexof(breakList, cusVo.id) ~= false then
        return true
    end
    return false
end

function getBagType(self)
    return nil
end

function recoverListData(self)
    if (self.mScrollList and #self.mScrollList > 0) then
        for i, v in ipairs(self.mScrollList) do
            LuaPoolMgr:poolRecover(v)
        end
    end
    self.mScrollList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]