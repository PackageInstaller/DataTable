--[[   
     英雄阵型选择界面
]]
module("explore.ExploreSelectPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("explore/ExploreSelectPanel.prefab")
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(29561))
    self:setSize(1120, 520)
    self:initData()
end

function getManager(self)
    return self.mManager
end

function setManager(self, cusManager)
    self.mManager = cusManager
end

-- 初始化数据
function initData(self)
    self.mTeamId = nil
    self.mFormationId = nil
    self.mColIndex = nil
    self.mRowIndex = nil
    self.mTileFormationHeroVo = nil
    
    local filterData = hero.HeroManager:getFilterData()
    if (not filterData) then
        filterData = {}
        filterData.isFilterSame = hero.HeroManager:getFilterSameHero() == "1"
        filterData.isFindLike = false
        filterData.isFindLock = false
        filterData.isDescending = true
        filterData.selectSortType = showBoard.panelSortType.POWER
        filterData.selectFilterDic = {}
        hero.HeroManager:setFilterData(filterData)
        for type in pairs(showBoard.panelFilterTypeDic) do
            filterData.selectFilterDic[type] = {}
            filterData.selectFilterDic[type][showBoard.filterSubTypeAll] = true
        end
    end
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

-- 初始化
function configUI(self)
    self.mScrollerSelect = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScrollerSelect:SetItemRender(self:getHeadSelectItem())
    self.mGroupSort = self:getChildGO("mGroupSort")
    self.mTransGroupFilter = self:getChildTrans("mGroupFilter")
    self.mBtnOk = self:getChildGO("mBtnOk")
    self.mNodeFilter = self:getChildTrans("mNodeFilter")
    -- 排序页面
    self.mSortView = hero.HeroSortView.new()
    self.mSortView:setParentTrans(self.mNodeFilter)
    self.mSortView:setAlignCenter(525, 218)
    -- 点击排序item
    local function __onClickSortItemHandler(self)
        local filterData = hero.HeroManager:getFilterData()
        filterData.isFilterSame = self.mSortView:getIsFilterSame()
        filterData.isDescending = self.mSortView:getIsDescending()
        filterData.selectSortType = self.mSortView:getSortFilterType()
        filterData.isFindLike = self.mSortView:getIsLike()
        filterData.isFindLock = self.mSortView:getIsLock()
        -- filterData.selectFilterDic = self.mSortView:getSearchFilterDic()
        hero.HeroManager:setFilterData(filterData)

        self.mIsFilterSame = filterData.isFilterSame
        self.mIsDescending = filterData.isDescending
        self.mSelectSortType = filterData.selectSortType
        self.mIsFindLike, self.mIsFindLock = filterData.isFindLike, filterData.isFindLock
        self.mSelectFilterDic = self.mSortView:getSearchFilterDic()
        self:setData(nil, false)
    end
    self.mSortView:setCallBack(self, __onClickSortItemHandler)
    
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.mCondType = args.data.type
    self.mNeedNumList = args.data.needNumList
    self:setManager(args.manager)
    self:getManager():addEventListener(
        self:getManager().EXPLORE_HERO_SELECT_CHANGE,
        self.onFormationHeroSelectHandler,
        self
    )
    self:setData(args.data, true)
end

-- 非激活
function deActive(self)
    self:getManager():removeEventListener(
            self:getManager().EXPLORE_HERO_SELECT_CHANGE,
            self.onFormationHeroSelectHandler,
            self
        )
    super.deActive(self)
    self.mSortView:resetAll()
end

-- 移除
function destroy(self, isAuto)
    super.destroy(self, isAuto)
    if self.mSortView then
        self.mSortView:destroy()
        self.mSortView = nil
    end
end

-- 玩家点击关闭
function onClickClose(self)
    self:__closeOpenAction()
    GameDispatcher:dispatchEvent(EventName.UPDATE_EXPLORE_SELECT)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnOk, 40038, "选择")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnOk, self.onOkClickHandler)
end

function onOkClickHandler(self)
    self:onClickClose()
end

-- 设置排序数据
function showSortView(self)
    self.mSortView:setFilterSame(true, self.mIsFilterSame)
    self.mSortView:addFilterMenu(showBoard.panelFilterTypeList, showBoard.panelFilterTypeDic, self.mSelectFilterDic, self.mIsFindLike, self.mIsFindLock, false)
    self.mSortView:addSortMenu(showBoard.panelSortTypeList, self.mSelectSortType, self.mIsDescending, false)
end

function getHeadSelectItem(self)
    return explore.ExploreHeadSelectItem
end

function onFormationHeroSelectHandler(self, args)
    local selectHeroId = args.heroId
    explore.exploreManager:changeHeroList(selectHeroId)
    self:setData(args.data, false)
end

function setData(self, cusData, isInit)
    self:showSortView()
    if cusData then
        self.mTeamId = cusData.teamId
        self.mFormationId = cusData.formationId
        self.mColIndex = cusData.colIndex
        self.mRowIndex = cusData.rowIndex
    end
    self:recoverListData(self.mScrollerSelect.DataProvider)
    local scrollList = self:getDataList()
    if isInit then
        self.mScrollerSelect.DataProvider = scrollList
    else
        self.mScrollerSelect:ReplaceAllDataProvider(scrollList)
    end
end

function getDataList(self)
    -- 通用英雄列表
    local scrollList = {}
    local fomationList = {}
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.mSelectSortType, self.mIsDescending, self.mSelectFilterDic, self.mIsFilterSame, false, self.mIsFindLike, self.mIsFindLock)
    for i = 1, #heroList do
        local heroVo = heroList[i]:getDataVo()
        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo(
            {
                dataVo = heroVo,
                teamId = self.mTeamId,
                formationId = self.mFormationId,
                manager = self:getManager()
            }
        )
        local isInFormation = self:getManager():getExploreHeroById(heroVo.id)
        if (isInFormation) then
            table.insert(fomationList, scrollVo)
        else
            table.insert(scrollList, scrollVo)
        end
    end
    for i, v in ipairs(scrollList) do
        table.insert(fomationList, v)
    end
    scrollList = fomationList
    return scrollList
end

function sortHeroList(self, list)
    local retList = {}
    local notList = {}
    local formList = {}
    local otherList = {}

    for i = 1, #list do
        local isFormation = explore.exploreManager:getExploreHeroById(list[i].id)
        if isFormation then
            table.insert(formList,list[i])
        else
            table.insert(otherList,list[i])
        end
    end
    if self.mCondType == explore.EventType.heroType then
        for i = 1, #self.mNeedNumList do
            for j = 1, #otherList do
                if otherList[j]:getDataVo().professionType == self.mNeedNumList[i] then
                    table.insert(retList, otherList[j])
                end
            end
        end
        for i = 1, #otherList do
            if (table.indexof01(retList, otherList[i]) <= 0) then
                table.insert(notList, otherList[i])
            end
        end
    elseif self.mCondType == explore.EventType.eleType then
        for i = 1, #self.mNeedNumList do
            for j = 1, #otherList do
                if otherList[j]:getDataVo().eleType == self.mNeedNumList[i] then
                    table.insert(retList, otherList[j])
                end
            end
        end
        for i = 1, #otherList do
            if (table.indexof01(retList, otherList[i]) <= 0) then
                table.insert(notList, otherList[i])
            end
        end
    end
    for i = 1, #retList do
        table.insert(formList, retList[i])
    end
    for i = 1, #notList do
        table.insert(formList, notList[i])
    end
    return formList
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
