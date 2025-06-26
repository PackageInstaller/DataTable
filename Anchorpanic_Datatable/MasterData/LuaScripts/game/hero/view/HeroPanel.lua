module("hero.HeroPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("hero/HeroPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
isShow3DBg = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(52005))
    -- self:setBg("hero5_bg_3.jpg", false, "hero5")
    self:setUICode(LinkCode.Hero)
    self:setGuideTrans("guide_BtnClose_HeroPanel", self.gBtnClose.transform)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.m_curHeroId = nil
    -- 置空将当前面板查看的英雄id
    hero.HeroManager:setPanelShowHeroId(self.m_curHeroId)

    local filterData = hero.HeroManager:getFilterData()
    if (not filterData) then
        filterData = {}
        filterData.isFilterSame = hero.HeroManager:getFilterSameHero() == "1"
        filterData.isShowAll = false
        filterData.isFindLike = false
        filterData.isFindLock = false
        filterData.isDescending = true
        filterData.selectSortType = showBoard.panelSortType.LEVEL
        filterData.selectFilterDic = {}
        hero.HeroManager:setFilterData(filterData)
        for type in pairs(showBoard.panelFilterTypeDic) do
            filterData.selectFilterDic[type] = {}
            filterData.selectFilterDic[type][showBoard.filterSubTypeAll] = true
        end
    end
    self:__updateFilterData()
    self:__recover()
end

function __updateFilterData(self)
    local filterData = hero.HeroManager:getFilterData()
    -- 过滤相同战员
    self.m_isFilterSame = filterData.isFilterSame
    -- 显示全部战员
    self.m_isShowAll = filterData.isShowAll
    -- -- 显示红点战员
    -- self.m_isShowRed = filterData.m_isShowRed
    -- 是否查找喜欢的英雄
    self.m_isFindLike = filterData.isFindLike
    -- 是否查找锁定的英雄
    self.m_isFindLock = filterData.isFindLock
    -- 是否降序
    self.m_isDescending = filterData.isDescending
    -- 选择的排序类型
    self.m_selectSortType = filterData.selectSortType
    -- 提供的筛选字典
    self.m_selectFilterDic = filterData.selectFilterDic
end

function __recover(self)
    if (self.m_heroScrollList) then
        for i = 1, #self.m_heroScrollList do
            self.m_heroScrollList[i].tweenId = 0
            LuaPoolMgr:poolRecover(self.m_heroScrollList[i])
        end
    end
    self.m_heroScrollList = {}
end

function configUI(self)
    super.configUI(self)

    self.m_heroDisBtn = self:getChildGO("HeroDisBtn")

    self.m_groupSort = self:getChildGO("GroupSort")
    self.m_groupScroll = self:getChildGO("GroupScroll")

    self.m_scrollGo = self:getChildGO("Scroll")
    self.mScrollerRect = self.m_scrollGo:GetComponent(ty.ScrollRect)
    self.m_scrollRect = self.m_scrollGo:GetComponent(ty.RectTransform)
    self.m_scroll = self.m_scrollGo:GetComponent(ty.LyScroller)

    self.m_scrollGo2 = self:getChildGO("Scroll2")
    self.mScrollerRect2 = self.m_scrollGo2:GetComponent(ty.ScrollRect)
    self.m_scrollRect2 = self.m_scrollGo2:GetComponent(ty.RectTransform)
    self.m_scroll2 = self.m_scrollGo2:GetComponent(ty.LyScroller)

    self.mHeroListItem1 = self:getChildGO("HeroListItem_1")
    self.mHeroListItem2 = self:getChildGO("HeroListItem_2")

    self.m_scroll:SetItemRender(hero.HeroListScrollItem_1)
    self.m_scroll2:SetItemRender(hero.HeroListScrollItem_2)

    self.m_textEmptyTip = self:getChildGO("TextEmptyTip"):GetComponent(ty.Text)

    self.m_sortView = hero.HeroSortView.new()

    self.m_sortView:setParentTrans(self:getChildTrans("NodeFilter"))
    -- 点击排序item
    local function __onClickSortItemHandler(self)

        local filterData = hero.HeroManager:getFilterData()
        filterData.isFilterSame = self.m_sortView:getIsFilterSame()
        filterData.isShowAll = self.m_sortView:getIsShowAll()
        filterData.isFindLike = self.m_sortView:getIsLike()
        filterData.isFindLock = self.m_sortView:getIsLock()
        filterData.isDescending = self.m_sortView:getIsDescending()
        filterData.selectSortType = self.m_sortView:getSortFilterType()
        hero.HeroManager:setFilterSameHero(self.m_sortView:getIsFilterSame() and "1" or "0")
        hero.HeroManager:setFilterData(filterData)

        self.m_isFilterSame = self.m_sortView:getIsFilterSame()
        self.m_isShowAll = self.m_sortView:getIsShowAll()
        self.m_isShowRed = self.m_sortView:getIsShowRed()
        self.m_isDescending = self.m_sortView:getIsDescending()
        self.m_selectSortType = self.m_sortView:getSortFilterType()
        self.m_isFindLike, self.m_isFindLock = self.m_sortView:getIsLike(), self.m_sortView:getIsLock()
        self.m_selectFilterDic = self.m_sortView:getSearchFilterDic()
        self.isFirstSort = false

        -- 清除记录的英雄界面的列表位置
        if (hero.HeroManager:getIsVer()) then
            hero.setHeroPanelOffset(self.m_scroll:GetContent().anchoredPosition.y)
        else
            hero.setHeroPanelOffset(self.m_scroll2:GetContent().anchoredPosition.x)
        end
        local list, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, false, self.m_isFindLike, self.m_isFindLock, self.isFirstSort)
        if (not idDic[self.m_curHeroId]) then
            if (#list > 0) then
                self.m_curHeroId = list[1]:getDataVo().id
                hero.HeroManager:setPanelShowHeroId(self.m_curHeroId)
            else
                self.m_curHeroId = nil
                hero.HeroManager:setPanelShowHeroId(self.m_curHeroId)
            end
        end
        self:setData(false, list, idDic)
    end
    self.m_sortView:setCallBack(self, __onClickSortItemHandler)
    self.isFirstSort = true
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)

    if self.m_sortView then
        self.m_sortView:destroy()
        self.m_sortView = nil
    end
end

-- 玩家点击关闭
function onClickClose(self)
    self:__playerClose()
    super.onClickClose(self)
    -- 清除记录的英雄界面的列表位置
    hero.setHeroPanelOffset(nil)
    -- Perset3dHandler:hideAdditiveScene()
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:__playerClose()
    super.onCloseAllCall(self)
    -- 清除记录的英雄界面的列表位置
    hero.setHeroPanelOffset(nil)
end

function __playerClose(self)
    hero.HeroManager:setRsyncSingleFilterData()
    self.isFirstSort = true
    self:initData()
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.HERO_LIST_INIT, self.__onInitHeroListHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.__onUpdateHeroDetailDataHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_UPDATE, self.__onHeroListUpdateHandler, self)

    hero.HeroManager:addEventListener(hero.HeroManager.HERO_LIST_SELECT, self.__onListSelectHandler, self)

    self:__updateFilterData()
    self.m_curHeroId = hero.HeroManager:getPanelShowHeroId()
    if (self.m_curHeroId ~= nil) then
        self:setData(false, nil, nil)
    else
        self.m_curHeroId = args
        self:setData(true, nil, nil)
    end
    hero.HeroManager:setPanelShowHeroId(self.m_curHeroId)
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.HERO_LIST_INIT, self.__onInitHeroListHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.__onUpdateHeroDetailDataHandler, self)
    GameDispatcher:removeEventListener(EventName.HERO_LIST_UPDATE, self.__onHeroListUpdateHandler, self)

    hero.HeroManager:removeEventListener(hero.HeroManager.HERO_LIST_SELECT, self.__onListSelectHandler, self)

    hero.HeroManager:setAllSortList()
    self.m_sortView:resetAll()
    if (hero.HeroManager:getIsVer()) then
        hero.setHeroPanelOffset(self.m_scroll:GetContent().anchoredPosition.y)
    else
        hero.setHeroPanelOffset(self.m_scroll2:GetContent().anchoredPosition.x)
    end
    if self.m_scroll then
        self.m_scroll:CleanAllItem()
    end
    if self.m_scroll2 then
        self.m_scroll2:CleanAllItem()
    end
end

-- function onFuncOpenUpdateHandler(self)
--     self.m_heroDisBtn:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_DISMISS, false))
-- end

function initViewText(self)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.m_heroDisBtn, self.onDisClick)
end

function onDisClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DISMISS_PANEL)
end
-- 英雄列表初始化
function __onInitHeroListHandler(self)
    self:setData(false, nil, nil)
end

-- 英雄列表选择
function __onListSelectHandler(self, args)
    print("英雄id：" .. args.heroVo.id .. "，" .. "tid：" .. args.heroVo.tid)
    self.m_curHeroId = args.heroVo.id
    hero.HeroManager:setPanelShowHeroId(self.m_curHeroId)
    self.m_isOpenHeroDevelop = true
end

-- 英雄列表更新
function __onHeroListUpdateHandler(self, args)
    if (table.indexof(args.addList, self.m_curHeroId) ~= false) then
        self:setData(false, nil, nil)
    end
end

-- 英雄详细数据更新
function __onUpdateHeroDetailDataHandler(self, args)
    if (self.m_curHeroId == args.heroId) then
        self:setData(false, nil, nil)
    end
end

function setData(self, isInit, list, idDic)
    self.m_sortView:setShowAll(true, self.m_isShowAll)
    self.m_sortView:setShowRed(true, self.m_isShowRed)

    -- self.m_sortView:setFilterSame(true, self.m_isFilterSame)
    self.m_sortView:addFilterMenu(showBoard.panelFilterTypeList, showBoard.panelFilterTypeDic, self.m_selectFilterDic, self.m_isFindLike, self.m_isFindLock, false)
    self.m_sortView:addSortMenu(showBoard.panelSortTypeList, self.m_selectSortType, self.m_isDescending, false)
    local function changeType()
        hero.HeroManager:setIsVer(not hero.HeroManager:getIsVer())
        if hero.HeroManager:getIsVer() then
            self.m_scroll:CleanAllItem(true)
        else
            self.m_scroll2:CleanAllItem(true)
        end
        -- self.isReshow = false
        self:updateListView(false, true)
    end
    self.m_sortView:addChangeTypeBtn(changeType)

    if (not list and not idDic) then
        list, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, false, self.m_isFindLike, self.m_isFindLock, self.isFirstSort)
    end

    if (not self.m_curHeroId or not idDic[self.m_curHeroId]) then
        if (#list > 0) then
            self.m_curHeroId = list[1]:getDataVo().id
            hero.HeroManager:setPanelShowHeroId(self.m_curHeroId)
            local heroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
            if (heroVo and not heroVo:checkIsPreData()) then
                self:__recover()
                self.m_heroScrollList = list
            end
        else
            self.m_curHeroId = nil
            hero.HeroManager:setPanelShowHeroId(self.m_curHeroId)
            self:__recover()
            self.m_heroScrollList = list
        end
    else
        self:__recover()
        self.m_heroScrollList = list
    end

    local heroIdList = {}
    for i = #self.m_heroScrollList, 1, -1 do
        table.insert(heroIdList, 1, self.m_heroScrollList[i]:getDataVo().id)
    end
    hero.HeroManager:setPanelShowHeroIdList(heroIdList)

    -- 单独插入两段列表
    local unGetCanComposeList, unGetUnComposeList = hero.HeroManager:getUnGetHeroList()
    unGetCanComposeList = showBoard.ShowBoardManager:getHeroScrollList(unGetCanComposeList, showBoard.panelSortType.COLOR, true, self.m_selectFilterDic, false, false, false, false)
    unGetUnComposeList = showBoard.ShowBoardManager:getHeroScrollList(unGetUnComposeList, showBoard.panelSortType.COLOR, true, self.m_selectFilterDic, false, false, false, false)
    for i = 1, #unGetCanComposeList do
        table.insert(self.m_heroScrollList, 1, unGetCanComposeList[i])
    end
    local allSortList = {}
    for i = 1, #self.m_heroScrollList do
        table.insert(allSortList, self.m_heroScrollList[i])
    end
    for i = 1, #unGetUnComposeList do
        table.insert(allSortList, unGetUnComposeList[i])
    end

    hero.HeroManager:setAllSortList(allSortList)
    if (self.m_isShowAll) then
        self.m_heroScrollList = allSortList
    end

    if self.m_isShowRed then
        local tempList = {}
        for k, v in pairs(self.m_heroScrollList) do
            if hero.HeroFlagManager:getFlag(v:getDataVo().id) then
                table.insert(tempList, v)
            end
        end
        self.m_heroScrollList = tempList
    end

    local unAllGettList = hero.HeroManager:getAllUnGetHeroList()
    local unGetList = showBoard.ShowBoardManager:getHeroScrollList(unAllGettList, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, false, self.m_isFindLike, self.m_isFindLock, false)
    logInfo("当前类型未获取" .. #unGetList .. "未获取总" .. #unAllGettList)
    self:updateDetailsList(unGetList)
    self:updateView(isInit)
end

-- 更新界面
function updateView(self, isInit)
    self:updateListView(isInit)
end

function scrollerSetting(self)
    if (hero.HeroManager:getIsVer()) then
        self.m_scrollGo:SetActive(true)
        self.m_scrollGo2:SetActive(false)
    else
        self.m_scrollGo:SetActive(false)
        self.m_scrollGo2:SetActive(true)
    end
end

-- 更新英雄列表界面
function updateListView(self, isInit, changeType)
    if (self.m_heroScrollList) then
        local index = 0
        for i = 1, #self.m_heroScrollList do
            local heroScrollVo = self.m_heroScrollList[i]
            local heroVo = heroScrollVo:getDataVo()
            if (self.m_curHeroId == heroVo.id) then
                heroScrollVo:setSelect(true)
                index = i - 1
            else
                heroScrollVo:setSelect(false)
            end
        end

        if guide.GuideManager:getCurHasGuide() == true then
            local needList = {}
            local otherHero = {}
            for i = 1, #self.m_heroScrollList do
                if self.m_heroScrollList[i]:getDataVo().tid == guide.GuideManager:getNextStepData().next_need_id then
                    table.insert(needList, self.m_heroScrollList[i])
                else
                    table.insert(otherHero, self.m_heroScrollList[i])
                end
            end

            for i = 1, #otherHero do
                table.insert(needList, otherHero[i])
            end
            self.m_heroScrollList = needList
        end
        local len = #self.m_heroScrollList
        if self.m_isOpenHeroDevelop then
            for i = 1, len do
                self.m_heroScrollList[i].tweenId = nil
            end
            self.m_isOpenHeroDevelop = nil
        else
            if hero.HeroManager:getIsVer() then
                local m_WHRate = gs.Screen.height / gs.Screen.width
                local max = m_WHRate < 0.7 and 12 or 18
                for i = 1, len do
                    self.m_heroScrollList[i].tweenId = nil
                    if i <= (max <= len and max or len) then
                        self.m_heroScrollList[i].tweenId = i * 1.5
                    end
                end
            else
                for i = 1, len do
                    self.m_heroScrollList[i].tweenId = nil
                    if i <= (6 <= len and 6 or len) then
                        self.m_heroScrollList[i].tweenId = i * 1.5
                    end
                end
            end
        end
        if changeType or isInit then
            self:scrollerSetting()
        end
        -- 定位
        if (hero.HeroManager:getIsVer()) then
            if self.m_scroll.Count == 0 then
                self.m_scroll.DataProvider = self.m_heroScrollList
            else
                self.m_scroll:ReplaceAllDataProvider(self.m_heroScrollList)
            end
            if (hero.getHeroPanelOffset()) then
                gs.TransQuick:UIPosY(self.m_scroll:GetContent(), hero.getHeroPanelOffset())
            else
                self.mScrollerRect.verticalNormalizedPosition = 1
                -- 超过滚动列表大小才需要定位，在内容不超过滚动列表大小时调用定位会异常跳动
                -- local scrollHeight = self.m_scrollRect.rect.height
                -- local height = self.m_scroll:GetContent().sizeDelta.y
                -- if(height > scrollHeight)then
                --     self.m_scroll:SetItemIndex(index, 0, 0, 0)
                -- end
            end
            -- 曲线救国强制缓动触发刷新
            self.m_scroll:JumpToPosition(gs.Vector2(0, self.m_scroll:GetContent().anchoredPosition.y + 0.01), 0.01)
        else
            if self.m_scroll2.Count == 0 then
                self.m_scroll2.DataProvider = self.m_heroScrollList
            else
                self.m_scroll2:ReplaceAllDataProvider(self.m_heroScrollList)
            end
            if (hero.getHeroPanelOffset()) then
                gs.TransQuick:UIPosX(self.m_scroll2:GetContent(), hero.getHeroPanelOffset())
            else
                -- -- 超过滚动列表大小才需要定位，在内容不超过滚动列表大小时调用定位会异常跳动
                -- local scrollWidth = self.m_scrollRect2.rect.width
                -- local width = self.m_scroll2:GetContent().sizeDelta.x
                -- if(width > scrollWidth)then
                --     self.m_scroll2:SetItemIndex(index, 0, 0, 0)
                -- end
                self.mScrollerRect2.horizontalNormalizedPosition = 0
            end
            self.m_scroll2:JumpToPosition(gs.Vector2(self.m_scroll2:GetContent().anchoredPosition.x + 0.01, 0), 0.01)
        end

        if (#self.m_heroScrollList <= 0) then
            self.m_textEmptyTip.text = _TT(1338)
        else
            self.m_textEmptyTip.text = ""
        end
        self:__updateGuide(self.m_heroScrollList)
    end
end

function __updateGuide(self, scrollList)
    if (#scrollList > 0) then
        local scroll = hero.HeroManager:getIsVer() and self.m_scroll or self.m_scroll2
        for i = 0, #scrollList - 1 do
            local heroVo = scrollList[i + 1]:getDataVo()
            if (heroVo) then
                if (heroVo.id == hero.HeroManager:getMinHeroId()) then
                    local scrollItem = scroll:GetItemLuaClsByIndex(i)
                    -- 是否在显示列表内
                    if (scrollItem) then
                        self:setGuideTrans("hero_list_first_item", scrollItem:getGuideTrans())
                    end
                end
                if (heroVo.tid == sysParam.SysParamManager:getValue(SysParamType.TWO_HERO_ID)) then
                    local scrollItem = scroll:GetItemLuaClsByIndex(i)
                    -- 是否在显示列表内
                    if (scrollItem) then
                        self:setGuideTrans("hero_list_first_item_2", scrollItem:getGuideTrans())
                    end
                end
                if (heroVo.tid == sysParam.SysParamManager:getValue(SysParamType.THIRD_HERO_ID)) then
                    local scrollItem = scroll:GetItemLuaClsByIndex(i)
                    -- 是否在显示列表内
                    if (scrollItem) then
                        self:setGuideTrans("hero_list_first_item_3", scrollItem:getGuideTrans())
                    end
                end
            end
        end
    end
end
-- 更新当前筛选英雄列表
function updateDetailsList(self, unGetList)
    local heroShowList = {}
    local curHeroId = nil
    local list = showBoard.ShowBoardManager:getHeroScrollList(hero.HeroManager:getAllHeroList(), self.m_selectSortType, true, self.m_selectFilterDic, false, false, false, false)
    if unGetList then
        for _, v in ipairs(unGetList) do
            if table.indexof(list, v) == false then
                table.insert(list, v)
            end
        end
    end
    if (#list > 0) then
        for _, v in ipairs(list) do
            table.insert(heroShowList, v:getDataVo())
        end
    end

    hero.HeroManager:setCurHeroList(heroShowList)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1338):	"- 当前暂无战员 -"
]]