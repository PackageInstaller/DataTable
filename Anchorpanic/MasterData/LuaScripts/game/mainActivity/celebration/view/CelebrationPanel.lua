--[[
-----------------------------------------------------
@filename       : CelebrationPanel
@Description    : 活动主界面
@date           : 2023-3-28 15:59:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("Celebration.CelebrationPanel", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("activity/CelebrationPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(121006))
    self:setUICode(LinkCode.Celebration)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.GroupTabItem = self:getChildGO("GroupTabItem")

    self.mNoClick = self:getChildGO("mNoClick")
end
-- 激活
function active(self, args)
    MoneyManager:setMoneyTidList({})
    super.active(self, args)
   
    GameDispatcher:addEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.updateActivityLimit, self)
    GameDispatcher:addEventListener(EventName.UPDATE_CELEBRATION_RED_STATE, self.updateRedFlag, self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.updateActivityLimitClose, self)
    GameDispatcher:addEventListener(EventName.CELEBRATION_NOCLICK, self.refreshNoClick, self)

    self:updateRedFlag()

    self.mNoClick:SetActive(false)
end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.ACTIVITY_OPEN_UPDATE, self.updateActivityLimit, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CELEBRATION_RED_STATE, self.updateRedFlag, self)
    GameDispatcher:removeEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.updateActivityLimitClose, self)
    GameDispatcher:removeEventListener(EventName.CELEBRATION_NOCLICK, self.refreshNoClick, self)

    self:removeRedFlag()
    self.curPage = nil
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
    for _, pageVo in pairs(Celebration.CelebrationConst:getTabList()) do
        local isFlag = pageVo.isBubble
        if isFlag and activity.ActivityManager:getActivityVoById(pageVo.activityId) and activity.ActivityManager:getActivityVoById(pageVo.activityId):isOpen() then
            self:addBubble(pageVo.page)
        else
            self:removeBubble(pageVo.page)
        end
    end
end

function updateActivityLimitClose(self, idList)
    local tabDataList = self:getTabDataList()
    if #tabDataList <= 0 then
        self:close()
        return
    end
    local tabType = tabDataList[self:getLastTabIndex(self.curPage)].page
    self:refreshTab(tabType)
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

function updateActivityLimit(self)
    self:refreshTab(self.curPage)
end

function refreshTab(self, tabType)
    local tabType = tabType or self:getTabDataList()[1].page
    self.tabBar:setData(self:getTabDataList())
    self.tabBar:setType(tabType)
    self:updateRedFlag()
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
    for _, pageVo in ipairs(Celebration.CelebrationConst:getTabList()) do
        self:removeBubble(pageVo.page)
    end
end

function getTabDatas(self)
    self.tabDataList = {}
    for index, vo in pairs(Celebration.CelebrationConst:getTabList()) do
        if activity.ActivityManager:getActivityVoById(vo.activityId) and activity.ActivityManager:getActivityVoById(vo.activityId):isOpen() then
            self.tabDataList[index] = {type = vo.page, content = {vo.nomalLan}, nomalIcon = vo.nomalIcon, selectIcon = vo.nomalIcon}
        end
    end
    return self.tabDataList
end

function getTabClass(self)
    for _, vo in pairs(Celebration.CelebrationConst:getTabList()) do
        self.tabClassDic[vo.page] = vo.view
    end
    return self.tabClassDic
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
