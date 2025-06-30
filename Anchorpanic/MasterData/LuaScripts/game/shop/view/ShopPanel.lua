--[[
-----------------------------------------------------
@filename       : ShopPanel
@Description    : 商店
@date           : 2020-08-31 19:31:01
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.shop.view.ShopPanel', Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath('shop/ShopPanel.prefab')

panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isScreensave = 0
isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1500, 800)
    self.tabBar:reset()
    self:setOffset(0, 0, 0, 0)
    self:setTxtTitle(_TT(27523))
    self:setBg("common_bg_015.jpg", false)
    self:setUICode(LinkCode.Shop)
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
    self:setTabbar()
    self.mScrollRect.enabled = true
    super.active(self, args)
    self:onUpdateContent()
    GameDispatcher:addEventListener(EventName.UPDATE_SHOP_TAB_CONTENT, self.onUpdateContent, self)

    -- self.base_childGos["gBtnCloseAll"]:SetActive(map.MapLoader.m_curMapType ~= MAP_TYPE.DORMITORY)
end

function onUpdateContent(self)
    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupTab)
    if self.mGroupTabRect.sizeDelta.y <= self.mGroupTabHeight then
        gs.TransQuick:LPosY(self.mGroupTab, 0)
    end
    if self.mGroupTabHeight <= 0 then
        self.mGroupTabHeight = self.mGroupTabRect.sizeDelta.y
    end
    --self.mScrollRect.enabled = self.mGroupTabRect.sizeDelta.y > self.mGroupTabHeight
    self:onMoveLocation(self.curPage)
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
    self.curPage = nil
end

function autoSetype(self, args)
    local page
    if args and type(args) == "number" then
        page = args
    else
        page = (args and args.type) and args.type or self:getTabDatas()[1].type
    end
    if (self.curPage == nil) then
        self:setType(page, args)
    else
        self:setType(self.curPage, args)
    end
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

function getTabDatas(self)
    return self.tabDataList
end

function getTabClass(self)
    local list = shop.ShopManager:getShopShowList()
    for i, vo in ipairs(list) do
        if vo.id == ShopTabType.CONVERT then
            self.tabClassDic[vo.id] = shop.ShopConvertView
        elseif vo.id == ShopTabType.FRAGMENTS then
            self.tabClassDic[vo.id] = shop.ShopFragmentsView
        else
            self.tabClassDic[vo.id] = shop.ShopSubView
        end
    end
    return self.tabClassDic
end

function getTabViewParent(self)
    return self.mGroup
end

function getTabBarParent(self)
    return self.mGroupTab
end

function setTabbar(self)
    self:clearTabItem()
    local list = shop.ShopManager:getShopShowList()
    for i, vo in ipairs(list) do
        if funcopen.FuncOpenManager:isOpen(vo.funcId) then
            local tabItem = UI.new(shop.ShopTabItem)
            tabItem:setParentTrans(self.mGroupTab)
            tabItem:setData(vo, i, self.setTabIndex, self, self.subType, i)
            self.tabData[vo.sort] = tabItem
        end
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
        item:setSelect(false)
    end
    local tabItem = self.tabData[index]
    tabItem:setSelect(true)
    self:setType(index)
end

function setType(self, cusTabType, cusArgs)
    if (self.curPage == cusTabType) then
        return
    end
    super.setType(self, cusTabType, cusArgs)
    self:setTabIndex(cusTabType)
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
