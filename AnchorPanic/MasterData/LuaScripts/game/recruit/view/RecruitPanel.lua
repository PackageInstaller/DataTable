module("recruit.RecruitPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("recruit/RecruitPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗 3 不应用遮罩的常驻页面(事影循回)
isScreensave = 1
isShowBlackBg = 1 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1280, 720)
    self:setTxtTitle(_TT(28001))

    self:setBg("", false)
    self:setUICode(LinkCode.Recruit)
end

function initTabBar(self)

end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.m_curTabType = nil
    self.m_tabDic = nil

    self.isSetTran = false
    self.mCurMenuList = {}
    self.isInit = false
end

function configUI(self)
    super.configUI(self)
    self.m_content = self:getChildTrans('mTabContent')
    self.mChildPoint = self:getChildTrans("mChildPoint")

    self.mBtnLeft = self:getChildGO("mBtnLeft")
    self.mBtnRight = self:getChildGO("mBtnRight")

    self.mScrollRectTran = self:getChildGO("mScroll"):GetComponent(ty.RectTransform)
    self.mScrollRect = self:getChildGO("mScroll"):GetComponent(ty.ScrollRect)

    self.GroupTabItemRect = self:getChildGO("GroupTabItem"):GetComponent(ty.RectTransform)
    self.mContentRect = self.m_content:GetComponent(ty.RectTransform)
end

function getTabViewParent(self)
    return self.mChildPoint
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:__onPlayerClose()
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:__onPlayerClose()

    recruit.RecruitManager:SetOpenRulePanel(false)
end

-- 玩家关闭所有窗口的c#回调
function __onPlayerClose(self)
    self.m_curTabType = nil
end

function active(self, args)
    super.active(self, args)
    GameView.UINode["GUIDE"]:GetComponent(ty.Canvas).sortingOrder = 1700

    self.m_curTabType = self.m_curTabType or args.type

    if recruit.RecruitManager:isOpenRulePanel() then
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_RULE_PANEL, {type = self.m_curTabType})
    end

    self:updateMoneyBar(self.m_curTabType)

    self:updateTab()
    if not self.updateTabTimer then
        self.updateTabTimer = LoopManager:addTimer(10, -1, self, self.onTimer)
    end

    self:addEvent()

    self:updateGuide()
end

function deActive(self)
    super.deActive(self)
    GameView.UINode["GUIDE"]:GetComponent(ty.Canvas).sortingOrder = 1400

    MoneyManager:setMoneyTidList()

    self.tabBar:reset()
    self.tabBar = nil

    self.mCurMenuList = {}
    recruit.RecruitController.canSendRecruitHero = true

    if self.updateTabTimer then
        LoopManager:removeTimer(self, self.onTimer)
        self.updateTabTimer = nil
    end

    self:removeEvent()
end

function initViewText(self)

end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLeft, self.onClickLeft)
    self:addUIEvent(self.mBtnRight, self.onClickRight)
end

function addEvent(self)
    GameDispatcher:addEventListener(EventName.UPDATE_RECRUIT_PANEL, self.updateTab, self)
    GameDispatcher:addEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)

    --背包数据更新
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.updataRedState, self)
end

function removeEvent(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.updateTab, self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)

    bag.BagManager:removeEventListener(bag.BagManager.BAG_UPDATE, self.updataRedState, self)

end

function onClickLeft(self)
    if self.mCurSelectIndex > 1 then
        self.mCurSelectIndex = self.mCurSelectIndex - 1
    else
        self.mCurSelectIndex = #self.mCurMenuList
    end

    self:onSelectPage()
end

function onClickRight(self)
    if self.mCurSelectIndex < #self.mCurMenuList then
        self.mCurSelectIndex = self.mCurSelectIndex + 1
    else
        self.mCurSelectIndex = 1
    end

    self:onSelectPage()
end

function onTimer(self)
    self:updateTab()
end

function updateTab(self)
    local menuList = recruit.RecruitManager:getRecruitMenuList()

    local list = {}
    -- 一键页签tab
    for i, v in ipairs(menuList) do
        if v:isOpenTime() then
            if funcopen.FuncOpenManager:isOpen(v.funcId) then
                local RecruitInfo = recruit.RecruitManager:getRecruitInfo(v.type)
                local RecruitConfigVo = recruit.RecruitManager:getRecruitConfigVo(v.type)
                local isFree = RecruitInfo.free_times < RecruitConfigVo.free_times

                if (v.type == recruit.RecruitType.RECRUIT_NEW_PLAYER and RecruitInfo.recruit_daily_times >= sysParam.SysParamManager:getValue(SysParamType.RECRUIT_NEW_PLAYER_TIMES)) then
                elseif v.type == recruit.RecruitType.RECRUIT_ACTIVITY_3 and RecruitInfo.recruit_daily_times > 0 then
                else
                    local iconPath = string.format("arts/ui/pack/recruit/recruit_pnl_%s.png", v.type)
                    table.insert(list, {id = v.id, page = v.type, nomalIcon = iconPath, nomalLanEnId = v.subLang, sign = isFree})
                end
            end
        end
    end

    --判断是不是可以刷新
    if #self.mCurMenuList == #list then
        local isReturn = false
        for i, v1 in ipairs(self.mCurMenuList) do
            local isSame = false
            for i, v2 in ipairs(list) do
                if v1.id == v2.id and v1.sign == v2.sign then
                    isSame = true
                    break
                end
            end
            if isSame == false then
                isReturn = true
                break
            end
        end
        if not isReturn then
            return
        end
    end

    self.mCurMenuList = list
    table.sort(self.mCurMenuList, function(a, b)
        return a.id < b.id
    end)
    if not self.tabBar then
        self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self.m_content, self.setSubPage, self, self.mCurMenuList, "RecruitPanelTabItem")
    else
        self.tabBar:setData(self.mCurMenuList)
    end

    self.mCurSelectIndex = 1
    self:refreshCurSelectIndex()
    self:onSelectPage()

    self:updataRedState()
end

function onSelectPage(self)
    self.tabBar:setPage(self.mCurMenuList[self.mCurSelectIndex].page)
end

function refreshCurSelectIndex(self)
    if self.m_curTabType then
        for i = 1, #self.mCurMenuList do
            if self.mCurMenuList[i].page == self.m_curTabType then
                self.mCurSelectIndex = i
                break
            end
        end
    end
end

function scrollToIndex(self, tabType)
    if self.isInit then
        self:_scrollToIndex(tabType)
    else
        self:setTimeout(0.2, function ()
            self:_scrollToIndex(tabType)
            self.isInit = true
        end)
    end
end

function _scrollToIndex(self, tabType)
    if self.mContentRect.rect.width < self.mScrollRectTran.rect.width then
        return
    end

    tabType = tabType or self.m_curTabType
    if self.tabBar then
        local itemGO = self.tabBar.btnMap[tabType].m_go
        if itemGO then
            local itemRect = itemGO:GetComponent(ty.RectTransform)
            local itemAnchoredPosition_X = itemRect.anchoredPosition.x + (itemRect.rect.width / 2) --item 的中心位置

            local scroll_width = math.abs(self.mContentRect.anchoredPosition.x - self.mScrollRectTran.rect.width / 2) --在conten 中的Scoll的中心位置

            local anchoredPosition_x = self.mContentRect.anchoredPosition.x + ((itemAnchoredPosition_X - scroll_width) * -1)
            local minPosX = (self.mContentRect.rect.width - self.mScrollRectTran.rect.width) * -1
            if anchoredPosition_x > 0 then
                anchoredPosition_x = 0
            elseif anchoredPosition_x < minPosX then
                anchoredPosition_x = minPosX
            end

            --当前content的位置+ 需要移动的位置
            self.mContentRect.anchoredPosition = gs.Vector2(anchoredPosition_x, self.mContentRect.anchoredPosition.y)
        end
    end
end

function setSubPage(self, cusPage)
    self.m_curTabType = cusPage

    self:setType(cusPage)
    self:refreshCurSelectIndex()
    self:scrollToIndex()

    self.mBtnLeft:SetActive(self.mCurSelectIndex > 1)
    self.mBtnRight:SetActive(self.mCurSelectIndex < #self.mCurMenuList)
end

function setType(self, cusTabType, cusArgs)
    super.setType(self, cusTabType, cusArgs)
    self:updateMoneyBar(cusTabType)
end

function updateMoneyBar(self, cusTabType)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(cusTabType)
    local costMoneyTid_one = configVo:getCostOneId()
    local costMoneyTid_ten = configVo:getCostTenId()
    if costMoneyTid_one ~= 0 and costMoneyTid_ten ~= 0 then
        if costMoneyTid_one ~= costMoneyTid_ten then
            MoneyManager:setMoneyTidList({costMoneyTid_one, costMoneyTid_ten, MoneyTid.ITIANIUM_TID})
        else
            MoneyManager:setMoneyTidList({costMoneyTid_one, MoneyTid.ITIANIUM_TID})
        end
    elseif costMoneyTid_one ~= 0 then
        MoneyManager:setMoneyTidList({costMoneyTid_one, MoneyTid.ITIANIUM_TID})
    elseif costMoneyTid_ten ~= 0 then
        MoneyManager:setMoneyTidList({costMoneyTid_ten, MoneyTid.ITIANIUM_TID})
    end
end

function getTabClass(self)
    self.tabClassDic[recruit.RecruitType.RECRUIT_TOP] = recruit.RecruitTopTabView
    self.tabClassDic[recruit.RecruitType.RECRUIT_NEW_PLAYER] = recruit.RecruitNewPlayerTabView
    self.tabClassDic[recruit.RecruitType.RECRUIT_BRACELETS] = recruit.RecruitBraceletsTabView
    self.tabClassDic[recruit.RecruitType.RECRUIT_ACTIVITY_1] = recruit.RecruitActTopTabView
    self.tabClassDic[recruit.RecruitType.RECRUIT_ACTIVITY_2] = recruit.RecruitActBraceletsTabView
    self.tabClassDic[recruit.RecruitType.RECRUIT_ACTIVITY_3] = recruit.RecruitActPlayerTabView
    return self.tabClassDic
end

function updataRedState(self)
    local newPlayRedState = recruit.RecruitManager:updateNewPlayRedState()
    if newPlayRedState then
        self.tabBar:addBubble(recruit.RecruitType.RECRUIT_NEW_PLAYER, 81.5, 31.5)
    else
        self.tabBar:removeBubble(recruit.RecruitType.RECRUIT_NEW_PLAYER)
    end

    local trial_RedState = mainActivity.MainActivityManager:getIsShowTrial()
    if trial_RedState then
        self.tabBar:addBubble(recruit.RecruitType.RECRUIT_ACTIVITY_1, 81.5, 31.5)
    else
        self.tabBar:removeBubble(recruit.RecruitType.RECRUIT_ACTIVITY_1)

    end
end

function updateGuide(self)
    local nextStepData = guide.GuideManager:getNextStepData()
    if nextStepData and nextStepData.next_need_id ~= 0 then
        local tabType = 1
        for i = 1, #self.mCurMenuList do
            if self.mCurMenuList[i].id == nextStepData.next_need_id then
                tabType = self.mCurMenuList[i].page
                break
            end
        end
        self:scrollToIndex(tabType)
    end

    if self.tabBar.btnList then
        for i = 1, #self.tabBar.btnList do
            self:setGuideTrans("guide_recruit_tabItem_" .. self.mCurMenuList[i].id, self.tabBar.btnList[i]:getChildTrans("mBtnNomal"))
        end
    end

    self:setGuideTrans("guide_BtnCloseAll", self.gBtnCloseAll.transform)
    self:setGuideTrans("guide_recruit_BtnLeft", self.mBtnLeft.transform)
    self:setGuideTrans("guide_recruit_BtnRight", self.mBtnRight.transform)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
