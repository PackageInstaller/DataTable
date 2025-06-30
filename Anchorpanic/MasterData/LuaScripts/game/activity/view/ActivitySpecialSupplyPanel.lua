--[[ 
-----------------------------------------------------
@filename       : ActivitySpecialSupplyPanel
@Description    : 特供活动界面
@date           : 2024-9-9 18:25:00
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module("activity.ActivitySpecialSupplyPanel", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("activity/ActivityPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(72115))
    self:setBg("manual_bg.jpg", false, "manual")
    self:setUICode(LinkCode.SpecialSupply)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
    -- 限时活动列表
    self.mActivityLimitList = {}
    -- 活动列表
    self.mActivityList = {}
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.GroupTabItem = self:getChildGO("GroupTabItem")
    self.mNoClick = self:getChildGO("mNoClick")
end
-- 激活
function active(self, args)
    super.active(self, args)
    -- MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_RED, self.updateRedFlag, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.updateActivityLimit, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.updateActivityLimitClose, self)
    GameDispatcher:addEventListener(EventName.CELEBRATION_NOCLICK, self.refreshNoClick, self)

    self:updateRedFlag()

    self.mNoClick:SetActive(false)
end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_ACTIVITY_RED, self.updateRedFlag, self)
    GameDispatcher:removeEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.updateActivityLimit, self)
    GameDispatcher:removeEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.updateActivityLimitClose, self)
    GameDispatcher:removeEventListener(EventName.CELEBRATION_NOCLICK, self.refreshNoClick, self)

    self:removeRedFlag()
    self.curPage = nil
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

-- 玩家点击关闭
function onClickClose(self)
    if self.mNoClick.activeInHierarchy then 
        return
    end
    super.onClickClose(self)
end

-- 打开导航栏
function openNavigationLink(self)
    if self.mNoClick.activeInHierarchy then 
        return
    end
    super.openNavigationLink(self)
end

function refreshNoClick(self, value)
    self.mNoClick:SetActive(value)
    self.tabBar:setCanClick(value)
end

-- 更新主UI红点信息--isActivityLimit是否是显示活动
function updateRedFlag(self)
    for _, activityVo in pairs(activity.ActivitySpecialSupplyConst:getTabList()) do
        local isFlag = activityVo.isBubble
        if isFlag then
            self:addBubble(activityVo.page)
        else
            self:removeBubble(activityVo.page)
        end
    end
end

function setTabBar(self)
    if #self:getTabDataList() <= 0 then
        return
    end

    if not self.tabViewGo then
        self.tabViewGo = AssetLoader.GetGO(UrlManager:getUIPrefabPath("compent/TabView.prefab"), self)
        self.tabView_childGos, self.tabView_childTrans = GoUtil.GetChildHash(self.tabViewGo)
        self.tabViewGo.transform:SetParent(self.base_childTrans["mGroupCusTab"], false)
    end

    self.tabBar = CustomTabBar:create(self.GroupTabItem, self.tabView_childTrans["TabBarNode"], self.onClickMenuHandler, self, nil, "TabViewTabBar1")
    self.tabBar:setData(self:getTabDataList())
end

function removeRedFlag(self)
    for _, activityVo in ipairs(activity.ActivitySpecialSupplyConst:getTabList()) do
        self:removeBubble(activityVo.page)
    end
end

function getTabDatas(self)
    self.tabDataList = {}
    for index, vo in pairs(activity.ActivitySpecialSupplyConst:getTabList()) do
        self.tabDataList[index] = { type = vo.page, content = { vo.nomalLan }, nomalIcon = vo.nomalIcon, selectIcon = vo.nomalIcon }
        --  activity.ActivityManager:registerActivityVo(vo, vo.isLimit)
    end
    return self.tabDataList
end

function getTabClass(self)
    for _, vo in pairs(activity.ActivitySpecialSupplyConst:getTabList()) do
        self.tabClassDic[vo.page] = vo.view
    end
    return self.tabClassDic
end

function updateActivityLimit(self)
    self:refreshTab(self.curPage)
end

function updateActivityLimitClose(self)
    local tabType = self.curPage
    self:refreshTab(tabType)
end

function refreshTab(self, tabType)
    local isHide=true
    for k, v in pairs(self:getTabDataList()) do
        if v.page==tabType then
            isHide = false
        end
    end
    if table.nums(self:getTabDataList())>0 then
        local tabType = isHide and self:getTabDataList()[1].page or tabType
        self.tabBar:setData(self:getTabDataList())
        self.tabBar:setType(tabType)
    else
        self:onClose()
    end
end

function getTabViewParent(self)
    return self:getChildTrans("mTransView")
end

function onClose(self)
    self:close()
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]