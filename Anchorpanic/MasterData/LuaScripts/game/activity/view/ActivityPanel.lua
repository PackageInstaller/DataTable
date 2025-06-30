--[[ 
-----------------------------------------------------
@filename       : ActivityPanel
@Description    : 活动主界面
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("activity.ActivityPanel", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("activity/ActivityPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle("活动")
    self:setBg("manual_bg.jpg", false, "manual")
    self:setUICode(LinkCode.Activity)
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
    self:getChildGO("mNoClick"):SetActive(false)
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_RED, self.updateRedFlag, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_HIDE, self.updateHideEntrance, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.updateActivityLimit, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.updateActivityLimitClose, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE, self.onClose, self)
    self:updateRedFlag()
end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.UPDATE_ACTIVITY_RED, self.updateRedFlag, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACTIVITY_HIDE, self.updateHideEntrance, self)
    GameDispatcher:removeEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.updateActivityLimit, self)
    GameDispatcher:removeEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.updateActivityLimitClose, self)
    GameDispatcher:removeEventListener(EventName.ACTIVITY_CLOSE, self.onClose, self)
    self:removeRedFlag()
    self.curPage = nil
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

-- 更新主UI红点信息--isActivityLimit是否是显示活动
function updateRedFlag(self)
    for _, activityVo in pairs(activity.ActivityConst:getTabList()) do
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
    for _, activityVo in ipairs(activity.ActivityConst:getTabList()) do
        self:removeBubble(activityVo.page)
    end
end

function getTabDatas(self)
    self.tabDataList = {}
    for index, vo in pairs(activity.ActivityConst:getTabList()) do
        self.tabDataList[index] = { type = vo.page, content = { vo.nomalLan }, nomalIcon = vo.nomalIcon, selectIcon = vo.nomalIcon, funcId = vo.funcId }
        --  activity.ActivityManager:registerActivityVo(vo, vo.isLimit)
    end
    return self.tabDataList
end

function setType(self, cusTabType, cusArgs, cusIsDispatch)
    super.setType(self, cusTabType, cusArgs, cusIsDispatch)
    if cusTabType == activity.ActivityConst.ACTIVITY_PERMIT then
        self:setBg("permit_bg1.jpg", true, "permit")
    elseif cusTabType == activity.ActivityConst.ACTIVITY_GROUTHFUND then
        self:setBg("growthFund_bg.jpg", true, "growthFund")
    elseif cusTabType == activity.ActivityConst.ACTIVITY_FIRSTCHARGE then
        self:setBg("firstcharge_bg.jpg", true, "firstCharge")
    elseif cusTabType == activity.ActivityConst.ACTIVITY_SEVENLOADING then
        self:setBg("welfareOptSign_bg.jpg", false, "welfareOpt")
    else
        self:setBg("dailyCheckIn_bg.jpg", true, "dailyCheckIn")
    end
end

function getTabClass(self)
    for _, vo in pairs(activity.ActivityConst:getTabList()) do
        self.tabClassDic[vo.page] = vo.view
    end
    return self.tabClassDic
end

function updateActivityLimit(self, list)
    local tempList = {}
    for i, v in pairs(list.openList) do
        table.insert(tempList, v.id)
    end
    if not self:CheckIsCurActivity(tempList) then
        return
    end
    self:refreshTab(self.curPage)
end
--检测是否是当前界面的活动，防止活动开启导致的界面刷新
function CheckIsCurActivity(self, checkList)
    for i, v in pairs(activity.ActivityConst:getActivityList()) do
        if table.indexof(checkList, v) then
            return true
        end
    end
    return false
end

function updateActivityLimitClose(self, msg)
    if not self:CheckIsCurActivity(msg.closeList) then
        return
    end
    self:removeBubble(activity.ActivityConst.ACTIVITY_PERMIT)
    local tabindex = self:getLastTabIndex(activity.ActivityConst.ACTIVITY_PERMIT)
    local tabType = self.curPage
    if self.curPage == activity.ActivityConst.ACTIVITY_PERMIT then
        tabType = self:getTabDataList()[tabindex].page
    end
    self:refreshTab(tabType)
end
--非限时活动隐藏入口
function updateHideEntrance(self, tabType)
    local isHide = false
    local funcId = 0
    if tabType == activity.ActivityConst.ACTIVITY_GROUTHFUND then
        isHide = purchase.GrowthFundManager:getIsGrowthFundOver()
        funcId = funcopen.FuncOpenConst.FUNC_ID_GROWTHFUND
    elseif tabType == activity.ActivityConst.ACTIVITY_FIRSTCHARGE then
        isHide = firstCharge.FirstChargeManager:getIsReciveOver()
    elseif tabType == activity.ActivityConst.ACTIVITY_SEVENLOADING then
        isHide = (not welfareOpt.WelfareOptManager:getSevenOpen())
        funcId = funcopen.FuncOpenConst.FUNC_ID_WELFATEOPT_SEVENDAY
    elseif tabType == activity.ActivityConst.ACTIVITY_SEVENTDAY_TARGET then
        isHide = activityTarget.ActivityTargetManager:getIsFinish()
    elseif tabType == activity.ActivityConst.ACTIVITY_SUBSCRIBE then
        isHide = activity.ActitvityExtraManager:checkIsOpen()
        funcId = activity.ActivitySubscribeGift
        -- elseif tabType == activity.ActivityConst.ACTIVITY_RECHARGE_NICEGIFT then
        --     isHide = false
        --     funcId = funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_RECHARGE_NICE_GIFT
    end
    if isHide then
        self:removeBubble(tabType)
        self:refreshTab()
        mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ACTIVITY, false, funcId)
    end
end

function refreshTab(self, tabType)
    local tabType = tabType or self:getTabDataList()[1].page
    self.tabBar:setData(self:getTabDataList())
    self.tabBar:setType(tabType)
end

function getLastTabIndex(self, type)
    if #self.tabDataList > 0 then
        for index, v in ipairs(self.tabDataList) do
            if v.page == type then
                return index
            end
        end
    end
    return 1
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