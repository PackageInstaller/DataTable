--[[ 
-----------------------------------------------------
@filename       : DirectBuyView
@Description    : 直购礼包购买界面
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("purchase.DirectBuyView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("purchase/DirectBuyView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mTabType = nil
    self.mSubTabType = nil
    self.mSubChildTabIndex = nil
end

-- 关闭所有UI
function onCloseAllCall(self)
    self:__playerClose()
    super.onCloseAllCall(self)
end

-- 玩家点击关闭
function onClickClose(self)
    self:__playerClose()
    super.onClickClose(self)
end

function __playerClose(self)
    self:initData()
end

function configUI(self)
    self.mTabParent = self:getChildTrans('GroupTab')
    self.mTabItem = self:getChildGO('GroupTabItem')

    self.mTabView = self:getChildTrans('GroupTabView')
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.PAY_ITIANIUM_TID, MoneyTid.ITIANIUM_TID })
    self.mTabType = args.type
    self.mSubTabType = args.subType or purchase.DirectBuySubTab.DIRECT_BUY
    self.mSubChildTabIndex=args.subChildTabIndex or purchase.DirectBuySubTab.LIMITED
    self:__updateTab()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    self.tabBar:reset()
    if self.mSubView then
        self.mSubView:destroy()
        self.mSubView = nil
    end
end

function initViewText(self)
end

function addAllUIEvent(self)
end

function __onUpdateViewHandler(self)
    self:__updateView(false)
end

function __updateTab(self)
    local typeConfigList = purchase.DirectBuyManager:getTypeConfigList()
    local list = {}
    for i = 1, #typeConfigList do
        table.insert(list, { page = typeConfigList[i]:getPageType(), nomalLan = typeConfigList[i]:getLang(), nomalLanEn = typeConfigList[i]:getEngLang() })
    end
    self.tabBar = CustomTabBar:create(self.mTabItem, self.mTabParent, self.__onSetPageHandler, self)
    self.tabBar:setData(list)
    self.tabBar:setPage(self.mSubTabType)
end

function __onSetPageHandler(self, cusPage)
    self.mSubTabType = cusPage
    self:__updateView()
end

function __updateView(self, isInit)
    if self.mSubView then
        self.mSubView:destroy()
        self.mSubView = nil
    end
    self.mSubView = self:__getSubView(self.mSubTabType)
    self.mSubView:show(self.mTabView, self.mSubTabType,self.mSubChildTabIndex)
end

function __getSubView(self, subTabType)
    if (subTabType == purchase.DirectBuySubTab.DIRECT_BUY) then
        return UI.new(purchase.DirectBuySubView_1)
    elseif (subTabType == purchase.DirectBuySubTab.DORMITORY) then
        return UI.new(purchase.DirectBuySubView_1)
    end
    Debug:log_error("DirectBuyView", "未定义直购礼包子页签类型")
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]