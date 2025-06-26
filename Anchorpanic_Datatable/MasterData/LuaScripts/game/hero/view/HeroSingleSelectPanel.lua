--[[   
     英雄通用单选界面
]]
module('hero.HeroSingleSelectPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('hero/HeroSingleSelectPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(1339))
    self:setSize(1120, 520)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.teamId = nil
    self.heroRedType = nil
    local singleFilterData = hero.HeroManager:getRsyncSingleFilterData()
    if (not singleFilterData) then
        local filterData = hero.HeroManager:getFilterData()
        if (not filterData) then
            filterData = {}
            filterData.isFilterSame = hero.HeroManager:getRsyncSingleFilterData() == "1"
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
        hero.HeroManager:setRsyncSingleFilterData()
        singleFilterData = hero.HeroManager:getRsyncSingleFilterData()
    end
    -- 过滤相同战员
    self.mIsFilterSame = singleFilterData.isFilterSame
    -- 是否查找喜欢的英雄
    self.mIsFindLike = singleFilterData.isFindLike
    -- 是否查找锁定的英雄
    self.mIsFindLock = singleFilterData.isFindLock
    -- 是否降序
    self.mIsDescending = singleFilterData.isDescending
    -- 选择的排序类型
    self.mSelectSortType = singleFilterData.selectSortType
    -- 提供的筛选字典
    self.mSelectFilterDic = singleFilterData.selectFilterDic

    -- self.mSelectSortType = self.mSelectSortType == nil and showBoard.panelSortType.LEVEL or self.mSelectSortType

    self.mDelayRecover = nil
    self.mDelayData = nil
    self.mDelayScroller = nil

    self:__recover()
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mScroll = self:getChildGO("Scroll"):GetComponent(ty.LyScroller)
    self.mScroll:SetItemRender(hero.HeroListScrollItem_4)

    self.mSortView = hero.HeroSortMinView.new()
    self.mSortView:setParentTrans(self:getChildTrans("mNodeFilter"))
    -- 点击排序item
    local function __onClickSortItemHandler(self)
        -- 外面的排序筛选只同步一部分
        local filterData = hero.HeroManager:getFilterData()
        filterData.isFilterSame = self.mSortView:getIsFilterSame()
        filterData.isDescending = self.mSortView:getIsDescending()
        filterData.selectSortType = self.mSortView:getSortFilterType()
        filterData.isFindLike = self.mSortView:getIsLike()
        filterData.isFindLock = self.mSortView:getIsLock()
        hero.HeroManager:setFilterSameHero(self.mSortView:getIsFilterSame() and "1" or "0")
        hero.HeroManager:setFilterData(filterData)

        self.mIsFilterSame = self.mSortView:getIsFilterSame()
        self.mIsDescending = self.mSortView:getIsDescending()
        self.mSelectSortType = self.mSortView:getSortFilterType()
        self.mIsFindLike, self.mIsFindLock = self.mSortView:getIsLike(), self.mSortView:getIsLock()
        self.mSelectFilterDic = self.mSortView:getSearchFilterDic()
        self:__updateView(false)
    end
    self.mSortView:setCallBack(self, __onClickSortItemHandler)
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
    if self.mSortView then
        self.mSortView:destroy()
        self.mSortView = nil
    end
end

function __recover(self)
    if (self.mHeroScrollList) then
        for i = 1, #self.mHeroScrollList do
            LuaPoolMgr:poolRecover(self.mHeroScrollList[i])
        end
    end
    if (self.mDelayRecover) then
        LoopManager:removeFrameByIndex(self.mDelayRecover)
        self.mDelayRecover = nil
    end
    self.mHeroScrollList = {}
end

-- 激活
function active(self, args)
    super.active(self, args)
    if (args) then
        if args.teamId then
            self.teamId = args.teamId
        end
        if args.redType then
            self.heroRedType = args.redType
        else
            self.heroRedType = hero.HeroFlagManager.FLAG_BTN_DEVELOP
        end

        --自定义选中检查函数 用于选中前的选择判断
        self.beforeSelectionCheckFunction = args.beforeSelectionCheckFunction or nil
    end
    hero.HeroManager:addEventListener(hero.HeroManager.PANEL_SINGLE_SELECT_HERO, self.__onUpdateShowHeroHandler, self)
    self:__updateFilterData()
    self:__updateView(true)
end

-- 非激活
function deActive(self)
    super.deActive(self)
    hero.HeroManager:removeEventListener(hero.HeroManager.PANEL_SINGLE_SELECT_HERO, self.__onUpdateShowHeroHandler, self)
    self.mSortView:resetAll()
    self:removeAllDelay()
    hero.setSingleSelectOffset(self.mScroll:GetContent().anchoredPosition.y)
    self.beforeSelectionCheckFunction = nil
end

function initViewText(self)
end

function __onUpdateShowHeroHandler(self, args)
    if self.beforeSelectionCheckFunction then
        local isContinue = self.beforeSelectionCheckFunction(args.heroId)
        if not isContinue then
            return 
        end
    end
    local heroIdList = {}
    for i = #self.mHeroScrollList, 1, -1 do
        table.insert(heroIdList, 1, self.mHeroScrollList[i]:getDataVo().id)
    end
    hero.HeroManager:setPanelShowHeroIdList(heroIdList)
    hero.HeroManager:setPanelShowHeroId(args.heroId)

    GameDispatcher:dispatchEvent(EventName.UPDATE_HEAD_CHANGE)
    self:close()
end

function __updateView(self, isInit)
    self:__updateFilterView(isInit)
    self:__updateListView(isInit)
end

function __updateFilterView(self, isInit)
    self.mSortView:setFilterSame(true, self.mIsFilterSame)
    self.mSortView:addFilterMenu(showBoard.panelFilterTypeList, showBoard.panelFilterTypeDic, self.mSelectFilterDic, self.mIsFindLike, self.mIsFindLock, false, true)
    self.mSortView:addSortMenu(showBoard.panelSortTypeList, self.mSelectSortType, self.mIsDescending, false, true)
    self.mSortView:setHideShowAll()
end

function __updateFilterData(self)
    local filterData = hero.HeroManager:getFilterData()
    -- 过滤相同战员
    self.mIsFilterSame = filterData.isFilterSame
    -- 是否查找喜欢的英雄
    self.mIsFindLike = filterData.isFindLike
    -- 是否查找锁定的英雄
    self.mIsFindLock = filterData.isFindLock
    -- 是否降序
    self.mIsDescending = filterData.isDescending
    -- 选择的排序类型
    self.mSelectSortType = filterData.selectSortType
    -- 提供的筛选字典
    self.mSelectFilterDic = filterData.selectFilterDic
end

-- 更新英雄列表界面
function __updateListView(self, isInit)
    local index = 0
    self.mDelayRecover = LoopManager:addFrame(0, 1, self, self.__recover)
    local function scrollerData()
        local heroList = nil
        if (self.teamId ~= nil) then
            heroList = {}
            for k, v in pairs(formation.FormationManager:getSelectFormationHeroList(self.teamId)) do
                local heroVo = hero.HeroManager:getHeroVo(v.heroId)
                table.insert(heroList, heroVo)
            end
        end
        local list, idDic = showBoard.ShowBoardManager:getHeroScrollList(heroList, self.mSelectSortType, self.mIsDescending, self.mSelectFilterDic, self.mIsFilterSame, false, self.mIsFindLike, self.mIsFindLock)
        self.mHeroScrollList = list
        for i = 1, #self.mHeroScrollList do
            local heroScrollVo = self.mHeroScrollList[i]
            self.mHeroScrollList[i].heroRedStyle = self.heroRedType
            local heroVo = heroScrollVo:getDataVo()
            if (hero.HeroManager:getPanelShowHeroId() == heroVo.id) then
                heroScrollVo:setSelect(true)
                index = i - 1
            else
                heroScrollVo:setSelect(false)
            end
        end
        if (self.mDelayData) then
            LoopManager:removeFrameByIndex(self.mDelayData)
            self.mDelayData = nil
        end
    end
    self.mDelayData = LoopManager:addFrame(0, 1, self, scrollerData)

    local function handleScroller()
        if (isInit or self.mScroll.Count <= 0) then
            self.mScroll.DataProvider = self.mHeroScrollList
            if (hero.getSingleSelectOffset()) then
                self.mScroll:JumpToPosition(gs.Vector2(0, hero.getSingleSelectOffset()))
                -- gs.TransQuick:UIPosY(self.mScroll:GetContent(), )
            else
                self.mScroll:SetItemIndex(index, 0, 0, 0)
            end
        else
            self.mScroll:ReplaceAllDataProvider(self.mHeroScrollList)
        end
        if (self.mDelayScroller) then
            LoopManager:removeFrameByIndex(self.mDelayScroller)
            self.mDelayScroller = nil
        end
    end
    self.mDelayScroller = LoopManager:addFrame(0, 1, self, handleScroller)
end

function removeAllDelay(self)
    if (self.mDelayRecover) then
        LoopManager:removeFrameByIndex(self.mDelayRecover)
        self.mDelayRecover = nil
    end
    if (self.mDelayData) then
        LoopManager:removeFrameByIndex(self.mDelayData)
        self.mDelayData = nil
    end
    if (self.mDelayScroller) then
        LoopManager:removeFrameByIndex(self.mDelayScroller)
        self.mDelayScroller = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1339):	"<size=24>战</size>员列表"
]]