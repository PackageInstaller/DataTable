--[[
-----------------------------------------------------
@filename       : ShoppingPanel
@Description    : 贸易所主界面
@date           : 2023-03-28 20:47:01
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.shop.view.ShoppingPanel', Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath('shop/ShoppingPanel.prefab')

panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = -1
isScreensave = 0
isShow3DBg = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1500, 800)
    self:setTxtTitle(_TT(27523))
    self:setBg("shop_bg_1.jpg", true, "shop")
    self:setUICode(LinkCode.Shopping)
end

-- 初始化数据
function initData(self)
    self.showTabType = 2
    super.initData(self)
    self.tabData = {}
    self.mGroupTabHeight = 0
end

-- 适应全面屏，刘海缩进

function configUI(self)
    super.configUI(self)
    self.mGroup = self:getChildTrans("mGroup")
    self.mGroupTab = self:getChildTrans("mGroupTab")
    self.mViewportRect = self:getChildTrans("Viewport"):GetComponent(ty.RectTransform)
    self.mGroupTabRect = self:getChildGO("mGroupTab"):GetComponent(ty.RectTransform)
    self.mScrollRect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
end

function active(self, args)
    self.subType = args.subType
    self.subChildType = args.subChildType

    if not self.isReshow then
        purchase.FashionShopManager:setDefOpenFashionType(args.openFashionType)
    end
    

    self.type = args.type
    self.mScrollRect.enabled = true
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_SHOP_TAB_CONTENT, self.onUpdateContent, self)
    self.base_childGos["gBtnCloseAll"]:SetActive(map.MapLoader.m_curMapType ~= MAP_TYPE.DORMITORY)
end

function onUpdateContent(self)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupTab)
    if self.mGroupTabRect.sizeDelta.y <= self.mGroupTabHeight then
        gs.TransQuick:LPosY(self.mGroupTab, 0)
    end
    if self.mGroupTabHeight <= 0 then
        self.mGroupTabHeight = self.mGroupTabRect.sizeDelta.y
    end
    --self:onMoveLocation(self.curPage)
end
--按钮定位移动
function onMoveLocation(self, cusTabBar)
    local btnPosY = math.abs(self.tabData[cusTabBar].UITrans.anchoredPosition.y - self.tabData[cusTabBar].UITrans.sizeDelta.y)
    local spacing = self.mViewportRect.rect.height - btnPosY
    if spacing < 0 then
        gs.TransQuick:LPosY(self.mGroupTab, math.abs(spacing))
    end
end

function deActive(self)
    super.deActive(self)
    self:clearTabItem()
    GameDispatcher:removeEventListener(EventName.UPDATE_SHOP_TAB_CONTENT, self.onUpdateContent, self)
end

function getTabViewParent(self)
    return self:getChildTrans("ViewContent")
end

function autoSetype(self, args)
    if (self.curPage == nil) then
        self:setTabbar()
        self:setType(self.type, args)
        self:setTabIndex(self.type)
    else
        if self.type > 2 then
            self.subChildType = self.curPage
            self:updateSubType(self.curPage)
        end
        self:setTabbar()
        self:setTabChildIndex(self.subType, args, true)
        self:setTabIndex(self.type)
    end
end

function openView(self, args)
    self.type = args.type
    self.subType = args.subType
    self.subChildType = args.subChildType
    purchase.FashionShopManager:setDefOpenFashionType(args.openFashionType)

    self:setTabbar()
    self:setTabChildIndex(self.subType, args, true)
    self:setTabIndex(self.type)
end

-- 可Override后提供需要active传入子页面的参数
function getActiveArgs(self)
    return {type = self:getPage()}
end

-- 更新页签列表
function updateTabBar(self)
    if self.tabBar then
        self.tabBar:reset()
        self.tabBar:setItems(self:getTabDatas(), 1)
    end
end

function updateSubType(self, pageSubType)
    for _, tabvo in pairs(shop.getTabMainLsit()) do
        for i, vo in ipairs(tabvo.list) do
            if tabvo.page == ShopMainTabType.Shop then
                if vo.id == pageSubType then
                    self.subType = vo.pageType
                    self.type = ShopMainTabType.Shop
                    break
                end
            else
                if vo.subList then
                    for _, funcId in ipairs(vo.subList) do
                        if funcId == pageSubType then
                            self.type = ShopMainTabType.Recharge
                            self.subType = vo.funcId
                            break
                        end
                    end
                else
                    if vo.funcId == pageSubType then
                        self.type = ShopMainTabType.Recharge
                        self.subType = vo.funcId
                        break
                    end
                end
            end
        end
    end
end

function getTabClass(self)
    for _, tabvo in pairs(shop.getTabMainLsit()) do
        for i, vo in ipairs(tabvo.list) do
            if tabvo.page == ShopMainTabType.Shop then
                if vo.id == ShopTabType.CONVERT then
                    self.tabClassDic[vo.id] = shop.ShopConvertView
                elseif vo.id == ShopTabType.FRAGMENTS then
                    self.tabClassDic[vo.id] = shop.ShopFragmentsView
                else
                    self.tabClassDic[vo.id] = shop.ShopSubView
                end
            else
                if vo.subList then
                    for index, funcId in ipairs(vo.subList) do
                        self.tabClassDic[funcId] = vo.viewList[index]
                    end
                else
                    self.tabClassDic[vo.funcId] = vo.view
                end
            end
        end
    end
    return self.tabClassDic
end

function setTabbar(self)
    self:clearTabItem()
    for i, vo in ipairs(shop.getTabMainLsit()) do
        local tabItem;
        if vo.page == ShopMainTabType.Recharge then
            tabItem = UI.new(purchase.PurchaseMainTabItem)
        else
            tabItem = UI.new(shop.ShopTabMainItem)
        end
        tabItem:setParentTrans(self.mGroupTab)
        tabItem:setData(vo, i, self.setType, self, self.subType, i, vo.list, self.subChildType, self.type, self.setTabIndex)
        self.tabData[i] = tabItem
    end
end

function clearTabItem(self)
    for k, item in pairs(self.tabData) do
        item:deActive()
        item:destroy()
        item = nil
    end
    self.tabData = {}
end

-- 设置tab
function setTabIndex(self, index)
    for i, item in pairs(self.tabData) do
        item:setSelect(index == i)
    end
    -- self:setType(index)
end

-- 设置tab
function setTabChildIndex(self, cusTabType, cusArgs, isInit)
    if (self.curPage == cusTabType and (not isInit)) then
        return
    end
    super.setType(self, cusTabType, cusArgs, true)
end

function setType(self, cusTabType, cusArgs)
    if (self.curPage == cusTabType) then
        return
    end
    if activity.ActitvityExtraManager:getIsLimitShopTypeParam(activity.LimitShopActivityType.View,cusTabType) then
        GameDispatcher:dispatchEvent(EventName.REQ_OPEN_SOME_VIEW_UNLOCK_GIFT,{id = cusTabType})
    end
    super.setType(self, cusTabType, cusArgs, true)
end

function getType(self, subType)
    for _, vo in ipairs(shop.getTabMainLsit()) do
        if vo.page == ShopMainTabType.Recharge then
            for k, v in ipairs(vo.list) do
                if v.funcId == subType then
                    return vo.page
                end
            end
        end
    end
end

function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose()
end

function onClickClose(self)
    super.onClickClose(self)
    self:playerClose()
end

function playerClose(self)
    GameDispatcher:dispatchEvent(EventName.CUSTOM_CONVENANT_SCENE_CHANGE)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
