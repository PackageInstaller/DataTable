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
    self.m_curTabId = nil
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
    self.m_curTabId = nil
end

function active(self, args)
    super.active(self, args)
    GameView.UINode["GUIDE"]:GetComponent(ty.Canvas).sortingOrder = 1700

    self.m_curTabId = self.m_curTabId or args.recruitId

    if recruit.RecruitManager:isOpenRulePanel() then
        GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_RULE_PANEL, {recruitId = self.m_curTabId})
    end

    local appType = recruit.RecruitManager:getOpenAppSelectPanel()
    if appType ~= nil then
        local recruitType = recruit.RecruitManager:getRecruitTypeById(self.m_curTabId)

        if recruitType == recruit.RecruitType.RECRUIT_APP_ACTTOP or recruitType == recruit.RecruitType.RECRUIT_APP_BRACELETS then
            GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_APP_SELECTPANEL, {recruitId = self.m_curTabId, type = appType})
        else
            GameDispatcher:dispatchEvent(EventName.CLOSE_RECRUIT_APP_SELECTPANEL)
            recruit.RecruitManager:SetOpenAppSelectPanel(nil)
        end
    end

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

function autoSetype(self, args)

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
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updataRedState, self)

    --背包数据更新
    bag.BagManager:addEventListener(bag.BagManager.BAG_UPDATE, self.updataRedState, self)
end

function removeEvent(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_RECRUIT_PANEL, self.updateTab, self)
    GameDispatcher:removeEventListener(EventName.MAINACTIVITY_REDSTATE_UPDATE, self.updataRedState, self)
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.updataRedState, self)

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
    local menuList = recruit.RecruitManager:getRecruitMenuDic()

    local list = {}
    -- 一键页签tab
    for i, v in pairs(menuList) do
        if v:isOpenTime() then
            if funcopen.FuncOpenManager:isOpen(v.funcId) then
                local RecruitInfo = recruit.RecruitManager:getRecruitInfo(v.id)
                local RecruitConfigVo = recruit.RecruitManager:getRecruitConfigVo(v.id)
                local isFree = RecruitInfo.free_times < RecruitConfigVo.free_times

                if (v.type == recruit.RecruitType.RECRUIT_NEW_PLAYER and RecruitInfo.recruit_daily_times >= sysParam.SysParamManager:getValue(SysParamType.RECRUIT_NEW_PLAYER_TIMES)) then
                elseif v.type == recruit.RecruitType.RECRUIT_ACTIVITY_3 and RecruitInfo.recruit_daily_times > 0 then
                else
                    local iconPath = string.format("arts/ui/pack/recruit/recruit_tab_%s_%s.png", v.type, v.id)
                    table.insert(list, {page = v.id, nomalIcon = iconPath, nomalLanEnId = v.subLang, sign = isFree, sort = v.sort})
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
        return a.sort < b.sort
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
    if self.m_curTabId then
        for i = 1, #self.mCurMenuList do
            if self.mCurMenuList[i].page == self.m_curTabId then
                self.mCurSelectIndex = i
                break
            end
        end
    end
end

function scrollToIndex(self, tabId)
    if self.isInit then
        self:_scrollToIndex(tabId)
    else
        self:setTimeout(0.2, function ()
            self:_scrollToIndex(tabId)
            self.isInit = true
        end)
    end
end

function _scrollToIndex(self, tabId)
    if self.mContentRect.rect.width < self.mScrollRectTran.rect.width then
        return
    end

    local guideRo = guide.GuideManager:getCurGuideRo()
    if guideRo then
        if guideRo:getRefID() == 1021 then
            tabId = recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_TOP)
        elseif guideRo:getRefID() == 2003 then
            tabId = recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_BRACELETS)
        end
    else
        tabId = tabId or self.m_curTabId
    end

    if self.tabBar then
        local itemGO = self.tabBar.btnMap[tabId].m_go
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

function setSubPage(self, cusId)
    local tabType = recruit.RecruitManager:getRecruitTypeById(cusId)
    if (tabType == recruit.RecruitType.RECRUIT_APP_ACTTOP or tabType == recruit.RecruitType.RECRUIT_APP_BRACELETS)and subPack.SubDownLoadController:isExistNeedUpdate() then
        gs.Message.Show("请等待资源下载完成获得最佳体验")
        return
    end

    self.m_curTabId = cusId

    self:setType(cusId)
    self:refreshCurSelectIndex()
    self:scrollToIndex()

    self.mBtnLeft:SetActive(self.mCurSelectIndex > 1)
    self.mBtnRight:SetActive(self.mCurSelectIndex < #self.mCurMenuList)
end

function setType(self, curTabId, cusArgs)
    super.setType(self, curTabId, cusArgs)

    self:updateMoneyBar(curTabId)
end

function getClassInsByType(self, curTabId)
    local tabType = recruit.RecruitManager:getRecruitTypeById(curTabId)

    local instance = self.m_classInsDic[tabType]
    if (not instance) then
        local tabClass = self:getTabClass()[tabType]
        if type(tabClass) == "table" then
            instance = tabClass.new(curTabId)
        else
            instance = UI.new(tabClass)
        end

        if instance.subName ~= "TabSubView" then
            logWarn('TabView', instance._NAME .. ' 请尽量继承TabSubView ')
        end

        instance:setParentTrans(self:getTabViewParent())

        self.m_classInsDic[curTabId] = instance
    end
    return instance
end

function updateMoneyBar(self, curTabId)
    local configVo = recruit.RecruitManager:getRecruitConfigVo(curTabId)
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
    self.tabClassDic[recruit.RecruitType.RECRUIT_APP_ACTTOP] = recruit.RecruitAppTopTabView
    self.tabClassDic[recruit.RecruitType.RECRUIT_APP_BRACELETS] = recruit.RecruitAppBraceletsTabView

    return self.tabClassDic
end

function updataRedState(self)
    local recruit_id = recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_NEW_PLAYER)

    --新手
    local newPlayRedState = recruit.RecruitManager:updateNewPlayRedState()
    if newPlayRedState then
        self.tabBar:addBubble(recruit_id, 81.5, 31.5)
    else
        self.tabBar:removeBubble(recruit_id)
    end

    --UP站员
    local actTopRecruitList = recruit.RecruitManager:getRecruitConfigListByType(recruit.RecruitType.RECRUIT_ACTIVITY_1)
    for _, configVo in pairs(actTopRecruitList) do
        local menuVo = recruit.RecruitManager:getRecruitMenuVo(configVo.id)
        if menuVo:isOpenTime() then
            if funcopen.FuncOpenManager:isOpen(menuVo.funcId) then
                if recruit.RecruitManager:getIsShowTrial(configVo:getTry_hero()) then
                    self.tabBar:addBubble(configVo.id, 81.5, 31.5)
                else
                    self.tabBar:removeBubble(configVo.id)
                end
            end
        end
    end

    --UP 烙哼
    local actBraceletsShopRedState = recruit.RecruitManager:updateActBraceletsShopRedState()
    local recruitList = recruit.RecruitManager:getRecruitConfigListByType(recruit.RecruitType.RECRUIT_ACTIVITY_2)
    for _, configVo in pairs(recruitList) do
        if recruit.RecruitManager:updateActBraceletsShopBuyRedState(configVo.id) or actBraceletsShopRedState then
            self.tabBar:addBubble(configVo.id, 81.5, 31.5)
        else
            self.tabBar:removeBubble(configVo.id)
        end
    end

    --定向烙哼
    recruit_id = recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_APP_BRACELETS)
    local appBraceletsRedState = recruit.RecruitManager:updateAppBraceletsShopRedState()
    if appBraceletsRedState or recruit.RecruitManager:updateAppBraceletsShopBuyRedState(recruit_id) or recruit.RecruitManager:updateSeniorAppBraceletsRedState() then
        self.tabBar:addBubble(recruit_id, 81.5, 31.5)
    else
        self.tabBar:removeBubble(recruit_id)
    end

    --定向站员
    recruit_id = recruit.RecruitManager:getRecruitIdByType(recruit.RecruitType.RECRUIT_APP_ACTTOP)
    local redState = recruit.RecruitManager:updateSeniorAppActRedState()
    if redState then
        self.tabBar:addBubble(recruit_id, 81.5, 31.5)
    else
        self.tabBar:removeBubble(recruit_id)
    end
end

function updateGuide(self)
    local nextStepData = guide.GuideManager:getNextStepData()
    if nextStepData and nextStepData.next_need_id ~= 0 then
        local tabId = 1
        for i = 1, #self.mCurMenuList do
            if self.mCurMenuList[i].page == nextStepData.next_need_id then
                tabId = self.mCurMenuList[i].page
                break
            end
        end
        self:scrollToIndex(tabId)
    end

    if self.tabBar.btnList then
        for i = 1, #self.tabBar.btnList do
            self:setGuideTrans("guide_recruit_tabItem_" .. self.mCurMenuList[i].page, self.tabBar.btnList[i]:getChildTrans("mBtnNomal"))
        end
    end

    self:setGuideTrans("guide_BtnCloseAll", self.gBtnCloseAll.transform)
    self:setGuideTrans("guide_recruit_BtnLeft", self.mBtnLeft.transform)
    self:setGuideTrans("guide_recruit_BtnRight", self.mBtnRight.transform)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
