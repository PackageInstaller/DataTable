-- 直购礼包商店
module('game.purchase.view.DirectBuySubView_1', Class.impl('lib.component.BaseContainer'))

UIRes = UrlManager:getUIPrefabPath('purchase/DirectBuySubView_1.prefab')

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function dtor(self)
end

function initData(self)
    self.mTimeSn = nil
    self.mCurShowTypeList = {}
end

function configUI(self)
    self.mScroller = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mLyScrollerLimit = self:getChildGO("mLyScrollerLimit"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(purchase.DirectBuyItem)
    self.mLyScrollerLimit:SetItemRender(purchase.LimitShopBuyItem)
    self.mGroupTabItem = self:getChildTrans("mGroupTabItem")
end

function active(self)
    super.active(self)
    self:initData()
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_GO, self.__onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.__onUpdateViewHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_LIMIT_SHOP_BUY_PANEL, self.updateLimitShopHandle, self)

    purchase.PurchaseManager:addEventListener(purchase.PurchaseManager.BUBBLE_CHANGE, self.updataRedState, self)

    GameDispatcher:dispatchEvent(EventName.REQ_DIRECT_BUY_INFO)

    self:addTimerHandle()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_GO, self.__onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_DIRECT_BUY_INFO, self.__onUpdateViewHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_LIMIT_SHOP_BUY_PANEL, self.updateLimitShopHandle, self)

    purchase.PurchaseManager:removeEventListener(purchase.PurchaseManager.BUBBLE_CHANGE, self.updataRedState, self)

    self.mScroller:CleanAllItem()
    self.mLyScrollerLimit:CleanAllItem()

    self:clearTimer()
end

function __onUpdateViewHandler(self, args)
    self:__updateView()
end

function __updateView(self)
    if (self.mSubTabType) then
        if (self.mSubTabType == purchase.DirectBuySubTab.DORMITORY) then
            MoneyManager:setMoneyTidList({MoneyTid.PAY_ITIANIUM_TID, MoneyTid.DECORATE_COIN_TID})
        else
            MoneyManager:setMoneyTidList({MoneyTid.PAY_ITIANIUM_TID, MoneyTid.ITIANIUM_TID})
        end
    end

    self.mScroller.gameObject:SetActive(self.mSubTabType ~= purchase.DirectBuySubTab.LIMITED)
    self.mLyScrollerLimit.gameObject:SetActive(self.mSubTabType == purchase.DirectBuySubTab.LIMITED)

    if self.mScroller.gameObject.activeSelf == true then
        self.mScroller:CleanAllItem()
    else
        self.mLyScrollerLimit:CleanAllItem()
    end

    if (self.mSubTabType ~= purchase.DirectBuySubTab.LIMITED) then
        local list = purchase.DirectBuyManager:getDirectBuyList(self.mSubTabType)
        for k, v in pairs(list) do
            v.tweenId = k
        end

        self.mScroller.DataProvider = list
    else
        self:updateLimitShopHandle()
    end
end

function updateLimitShopHandle(self)
    if self.mSubTabType ~= purchase.DirectBuySubTab.LIMITED then
        return
    end

    local LimitShopTypeList = activity.ActitvityExtraManager:getLimitShopTypeList()

    if table.empty(LimitShopTypeList) then
        return
    end

    local tempLits = {}
    for k, v in ipairs(LimitShopTypeList) do
        local vo = {dic = v, tweenId = (k + 0.5) * 0.5}
        table.insert(tempLits, vo)
    end

    self.mLyScrollerLimit.DataProvider = tempLits
end

function addTimerHandle(self)
    if not self.mTimeSn then
        self:checkTab()
        self.mTimeSn = LoopManager:addTimer(1, 0, self, self.checkTab)
    end
end

function setTabIndex(self, type)
    if self.mSubTabType == type then
        return
    end

    self.mSubTabType = type
    self:__updateView(true)
end

function show(self, parent, subPage, subChildType)
    self:setParentTrans(parent)
    self:__updateView()

    local canSelect = false
    for k, v in pairs(self.mTabData) do
        if v.type == type then
            canSelect = true
            break
        end
    end

    if not canSelect then
        subChildType = self.mTabData[1].type
    end

    self:setTabSelect(subChildType)
end

function setTabSelect(self, type)
    if self.mTabItemDic then
        for index, v in pairs(self.mTabData) do
            self.mTabItemDic[index]:setSelect(v.type == type)
        end
    end

    self:setTabIndex(type)
end

function clearTabItem(self)
    if self.mTabItemDic then
        for k, item in pairs(self.mTabItemDic) do
            item:destroy()
        end
        self.mTabItemDic = nil
    end
end

function updataRedState(self)
    local index = nil
    for _index, v in pairs(self.mTabData) do
        if v.type == purchase.DirectBuySubTab.DIRECT_BUY then
            index = _index
            break
        end
    end

    if index ~= nil then
        if purchase.DirectBuyManager:checkRed() then
            self.mTabItemDic[index]:addBubble()
        else
            self.mTabItemDic[index]:removeBubble()
        end
    end
end

function checkTab(self)
    local typeList = {
        [1] =
        {
            lang = 50076,
            type = purchase.DirectBuySubTab.LIMITED,
            functionId = 1909,
        },
        [2] =
        {
            lang = 50088,
            type = purchase.DirectBuySubTab.RECRUIT,
            functionId = 1909,
        },
        [3] =
        {
            lang = 50089,
            type = purchase.DirectBuySubTab.POWER,
            functionId = 1909,
        },
        [4] =
        {
            lang = 50070,
            type = purchase.DirectBuySubTab.DIRECT_BUY,
            functionId = 1901,
        },
        [5] =
        {
            lang = 50071,
            type = purchase.DirectBuySubTab.DORMITORY,
            functionId = 809,
        },
    }

    local tabData = {}

    for i = 1, #typeList do
        if funcopen.FuncOpenManager:isOpen(typeList[i].functionId) then
            local isOpen = true

            if typeList[i].type == 3 then
                local LimitShopTypeList = activity.ActitvityExtraManager:getLimitShopTypeList()
                if table.empty(LimitShopTypeList) then
                    isOpen = false
                end
            end

            if isOpen then
                table.insert(tabData, typeList[i])

            end
        end
    end

    if not table.empty(self.mTabData) then
        local isReturn = true
        for k, v1 in pairs(self.mTabData) do
            local isSame = false
            for k, v2 in pairs(tabData) do
                if v1.type == v2.type then
                    isSame = true
                end
            end

            if isSame == false then
                isReturn = false
                break
            end
        end

        if isReturn then
            return
        end
    end

    self.mTabData = tabData

    self:clearTabItem()
    self.mTabItemDic = {}
    for i = 1, #self.mTabData do
        local tabItem = UI.new(shop.ShopTabChildItem)
        tabItem:setParentTrans(self.mGroupTabItem)
        tabItem:setData(self.mTabData[i].lang, self.mTabData[i].type, self.setTabSelect, self)
        self.mTabItemDic[i] = tabItem
    end

    self:updataRedState()
end

function clearTimer(self)
    if self.mTimeSn then
        LoopManager:removeTimerByIndex(self.mTimeSn)
        self.mTimeSn = nil
    end
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
end
return _M
