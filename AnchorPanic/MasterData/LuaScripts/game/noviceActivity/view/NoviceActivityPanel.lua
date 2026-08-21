--[[ 
-----------------------------------------------------
@filename       : NoviceActivityPanel
@Description    : 新手活动主界面
@date           : 2023-6-5 16:50:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module("noviceActivity.NoviceActivityPanel", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("noviceActivity/NoviceActivityPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(90036))
    self:setBg("manual_bg.jpg", false, "manual")
    --  self:setUICode(LinkCode.NoviceActivity)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end
-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTransView = self:getChildGO("mTransView")
end
-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    noviceActivity.NoviceActivityManager:addEventListener(noviceActivity.NoviceActivityManager.UPDATE_RED,
        self.updateBubble, self)

    --GameDispatcher:addEventListener(EventName.ACTIVITY_NOVICE_UPDATE, self.setTabBar, self)
    self:initAllBubble()
    -- self:updateViewState()
    -- self:addTimer(1, 0, self.updateViewState)
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    noviceActivity.NoviceActivityManager:removeEventListener(noviceActivity.NoviceActivityManager.UPDATE_RED,
        self.updateBubble, self)
    --GameDispatcher:removeEventListener(EventName.ACTIVITY_NOVICE_UPDATE, self.setTabBar, self)
    MoneyManager:setMoneyTidList()
    self:removeAllBubble()
    self.curPage = nil
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function setTabBar(self)
    -- cusLog("刷新============setTabBar")
    -- local isClose = activity.ActivityManager:getNoviceActivityIsOpen()
    -- isClose = isClose or activity.ActivityManager:getNoviceActivitySsrIsOpen()
    -- isClose = isClose or activity.ActivityManager:getNoviceActivityRechargeIsOpen()
    -- if not isClose then
    --     self:onClickClose()
    --     return
    -- end

    if #self:getTabDataList() <= 0 then
        return
    end

    -- if activity.ActivityManager:getNoviceActivityIsOpen() then
    --     self.curPage = noviceActivity.NoviceActivityConst:getTabList()[1].page
    -- else
    --     if activity.ActivityManager:getNoviceActivitySsrIsOpen() then
    --         self.curPage = noviceActivity.NoviceActivityConst.NOVICEAVTIVITY_SSR
    --     end

    --     if activity.ActivityManager:getNoviceActivityRechargeIsOpen() then
    --         self.curPage = noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECHARGE
    --     end
    -- end

    -- end

    if not self.tabViewGo then
        self.tabViewGo = AssetLoader.GetGO(UrlManager:getUIPrefabPath("compent/TabView.prefab"), self)
        self.tabView_childGos, self.tabView_childTrans = GoUtil.GetChildHash(self.tabViewGo)
        self.tabViewGo.transform:SetParent(self.base_childTrans["mGroupCusTab"], false)
    end

    if self.tabBar then
        self.tabBar:poolRecover()
    end

    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self.tabView_childTrans["TabBarNode"],
        self.onClickMenuHandler, self, nil, "TabViewTabBar4")
    self.tabBar:setData(self:getTabDataList())
end

function getTabDatas(self)
    self.tabDataList = {}
    for index, vo in pairs(noviceActivity.NoviceActivityConst:getTabList()) do
        self.tabDataList[index] = {
            type = vo.page,
            content = {vo.nomalLan},
            nomalIcon = vo.nomalIcon,
            selectIcon = vo.selectIcon
        }
    end
    return self.tabDataList
end

function getTabViewParent(self)
    return self:getChildTrans("mTransView")
end

function getTabClass(self)
    for _, vo in pairs(noviceActivity.NoviceActivityConst:getTabList()) do
        self.tabClassDic[vo.page] = vo.view
    end
    return self.tabClassDic
end

-- 设置背景
function setPage(self, cusType)
    super.setPage(self, cusType)
    if cusType == noviceActivity.NoviceActivityConst.NOVICEACTIVITY_LINKPLAN then
        self:setBg("link_bg_1.jpg", false, "noviceActivity")
    elseif cusType == noviceActivity.NoviceActivityConst.NOVICEACTIVITY_RECRUITPLAN then
        self:setBg("castingmarks_bg_2.jpg", false, "noviceActivity")
    elseif cusType == noviceActivity.NoviceActivityConst.NOVICEACTIVITY_PROMOTIONPLAN then
        self:setBg("activities_bg_1.jpg", false, "noviceActivity")
    end
end

function updateBubble(self, type)
    local isFlag = noviceActivity.NoviceActivityManager:updateBubble(type)
    if isFlag then
        self:addBubble(type)
    else
        self:removeBubble(type)
    end
end

function initAllBubble(self)
    for _, vo in pairs(noviceActivity.NoviceActivityConst:getTabList()) do
        self:updateBubble(vo.page)
    end
end

function removeAllBubble(self)
    for _, vo in pairs(noviceActivity.NoviceActivityConst:getTabList()) do
        self:removeBubble(vo.page)
    end
end

function updateViewState(self)
    local isClose = activity.ActivityManager:getNoviceActivityIsOpen()
    isClose = isClose or activity.ActivityManager:getNoviceActivitySsrIsOpen()
    isClose = isClose or activity.ActivityManager:getNoviceActivityRechargeIsOpen()
    if not isClose then
        self:onClickClose()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
