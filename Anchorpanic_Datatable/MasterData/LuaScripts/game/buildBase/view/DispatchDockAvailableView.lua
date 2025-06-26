--[[ 
-----------------------------------------------------
@filename       : BuildBaseDroneSpView
@Description    : 点击 派遣任务弹窗
@date           : 2023-02-25 11:40:02
@Author         : Tonn
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("buildBase.DispatchDockAvailableView ", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("buildBase/DispatchDockAvailableView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle("派遣战员")
    self:setSize(1117, 520)

end
-- 析构  
function dtor(self)
    super.dtor(self)
end

function initData(self)
    super.initData(self)
    self.mBaseItems = {}
    self.mExtraItems = {}
    self.mAttrDic = {}
    self.mStarsDic = {}
    self.heroPosList = {}
    --英雄头像字典
    self.mHeroHeadDic = {}
    -- self.onCilckDic = {}
    -- for i = 1, 3 do
    --     self.onCilckDic[i] = false
    -- end
    self.mClickFlag = false
end

-- 初始化
function configUI(self)
    self.mTxtTile = self:getChildGO("mTxtTile"):GetComponent(ty.Text)
    self.mTxtDis = self:getChildGO("mTxtDis"):GetComponent(ty.Text)
    self.mBtnAuto = self:getChildGO("mBtnAuto"):GetComponent(ty.Button)
    self.mBtnStart = self:getChildGO("mBtnStart"):GetComponent(ty.Button)
    self.mRecommendGroup = self:getChildTrans("mRecommendGroup")
    self.mRecommendAttr2 = self:getChildTrans("mRecommendAttr2")
    self.mBaseItemsTrans = self:getChildTrans("mBaseGroup")
    self.mExtraItemsTrans = self:getChildTrans("mExtraGroup")
    self.mExtraItem = self:getChildGO("mExtraItem")
    self.mBtnRecMemer = self:getChildGO("mBtnRecMemer")
    self.mImgRecMemer = self:getChildGO("mImgRecMemer")
    self.mTeamGroup = self:getChildGO("mTeamGroup")
    self.mTeamGroup:SetActive(false)
    self.mAvailableGroup = self:getChildGO("mAvailableGroup")
    self.mAvailableGroup:SetActive(true)
    self.mBtnAddMember_01 = self:getChildGO("mBtnAddMember_01")
    self.mBtnAddMember_02 = self:getChildGO("mBtnAddMember_02")
    self.mBtnAddMember_03 = self:getChildGO("mBtnAddMember_03")
    self.mBtnDetermine = self:getChildGO("mBtnDetermine")
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mTxtRate = self:getChildGO("mTxtRate"):GetComponent(ty.Text)
    self.mScroll = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mScroll:SetItemRender(buildBase.DispatchHeroSelectItem)
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.exploreId = args.exploreId
    self.taskId = args.taskId
    buildBase.DispatchDockManager:addEventListener(
    buildBase.DispatchDockManager.ON_AUTO_DISPATCH,
    self.onAutoDispatch,
    self)
    buildBase.DispatchDockManager:addEventListener(
    buildBase.DispatchDockManager.ON_HERO_SELECT,
    self.onSelectHeroHandler,
    self
    )

    buildBase.DispatchDockManager:addEventListener(
    buildBase.DispatchDockManager.ON_SELETED_HERO_CHANGE,
    self.onSelectedHeroChanged,
    self
    )
    self:updateData()
    self:init()
end

-- 销毁
function deActive(self)
    super.deActive(self)
    self:clearItems()
    LoopManager:removeTimer(self, self.close)
    buildBase.DispatchDockManager:removeEventListener(
    buildBase.DispatchDockManager.ON_AUTO_DISPATCH,
    self.onAutoDispatch,
    self)
    buildBase.DispatchDockManager:removeEventListener(
    buildBase.DispatchDockManager.ON_HERO_SELECT,
    self.onSelectHeroHandler,
    self
    )

    buildBase.DispatchDockManager:removeEventListener(
    buildBase.DispatchDockManager.ON_SELETED_HERO_CHANGE,
    self.onSelectedHeroChanged,
    self
    )
    buildBase.DispatchDockManager:onClearDispatchMemebers()
    self.mTeamGroup:SetActive(false)
    self.mAvailableGroup:SetActive(true)

    self:clearHearoHead()
    if self.mScroll then
        self.mScroll:CleanAllItem()
    end
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAuto, self.onAutoDispatchHandler)
    self:addUIEvent(self.mBtnStart, self.onStartDispatchHandler)
    self:addUIEvent(self.mBtnAddMember_01, self.onAddMembersDispatchHandler)
    self:addUIEvent(self.mBtnAddMember_02, self.onAddMembersDispatchHandler2)
    self:addUIEvent(self.mBtnAddMember_03, self.onAddMembersDispatchHandler3)
    self:addUIEvent(self.mBtnDetermine, self.onClickCommit)
    self:addUIEvent(self.mBtnCancel, self.onClickCancel)
end

function closeAll(self)
    super.closeAll(self)
end

function updateData(self)
    self.mTaskConfig = buildBase.DispatchDockManager:getTaskConfig(self.taskId)
    self.buildId = buildBase.DispatchDockManager:getBaseBuildId()
end

function init(self)
    self.mTxtTile.text = _TT(self.mTaskConfig.title)
    self.mTxtDis.text = _TT(self.mTaskConfig.des)
    self:updateBaseItem()
    self:updateExtraItems()
    self:updateAttr()
    self:updateStars()
end

function updateBaseItem(self)
    self:clearBaseItems()
    local itemDic = buildBase.DispatchDockManager:getBaseItemCofigs(self.taskId)
    for _, vo in pairs(itemDic) do
        local propsGrid = PropsGrid:createByData({ tid = vo.tid, num = vo.num, parent = self.mBaseItemsTrans, scale = 0.53, showUseInTip = false })
        self.mBaseItems[_] = propsGrid
    end
end

function updateExtraItems(self)
    local rateHelper = 0
    local baseLen = #buildBase.DispatchDockManager.dispatchHeroList
    local taskVo = buildBase.DispatchDockManager:getTaskConfig(self.taskId)
    rateHelper = baseLen * taskVo.baseIncome
    local len = buildBase.DispatchDockManager:checkExtraProps(self.taskId)
    rateHelper = rateHelper + (len * taskVo.extraIncome)
    rateHelper = (rateHelper / 10000) > 1 and 1 or (rateHelper / 10000)

    if rateHelper < 1 then
        self.mTxtRate.text = "（达成率：" .. HtmlUtil:color(tostring(rateHelper * 100) .. "%", "009106ff") .. " )"

    else
        self.mTxtRate.text = "（达成率：" .. HtmlUtil:color(tostring(100) .. "%", "0080f2ff") .. " )"
    end
    self:clearExtraItems()
    local itemDic = buildBase.DispatchDockManager:getExtraItemCofigs(self.taskId)
    local numHelper = 0
    for _, vo in pairs(itemDic) do
        if vo.num == 1 then
            numHelper = vo.num
        else
            numHelper = math.floor(vo.num * rateHelper)
        end
        local propsGrid = PropsGrid:createByData({ tid = vo.tid, num = numHelper, parent = self.mExtraItemsTrans, scale = 0.53, showUseInTip = false })
        self.mExtraItems[_] = propsGrid
    end
end

function updateAttr(self)
    self:clearAttrItems()
    if next(self.mTaskConfig.eleType) then
        for _, type in pairs(self.mTaskConfig.eleType) do
            local item = SimpleInsItem:create(self.mBtnRecMemer, self.mRecommendGroup, "skills_DispatchDockAvailableView")
            local img = item:getChildGO("mImgRGIcon"):GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getHeroEleTypeIconUrl(type), false)
            self.mAttrDic[_] = item
        end
    end
    if self.mTaskConfig.heroType and next(self.mTaskConfig.heroType) then
        local item = SimpleInsItem:create(self.mBtnRecMemer, self.mRecommendGroup, "skills_DispatchDockAvailableView")
        local img = item:getChildGO("mImgRGIcon"):GetComponent(ty.AutoRefImage)
        img:SetImg(UrlManager:getHeroJobWhiteIconUrl(self.mTaskConfig.heroType[1]), false)
        self.mAttrDic[#self.mAttrDic + 1] = item
    end
end

function updateAttr2(self)
    self:clearAttrItems()
    if next(self.mTaskConfig.eleType) then
        for _, type in pairs(self.mTaskConfig.eleType) do
            local item = SimpleInsItem:create(self.mImgRecMemer, self.mRecommendAttr2, "attrs_DispatchDockAvailableView")
            local img = item:getChildGO("mImgRec"):GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getHeroEleTypeIconUrl(type), false)
            self.mAttrDic[_] = item
        end
    end
    if self.mTaskConfig.heroType and next(self.mTaskConfig.heroType) then
        local item = SimpleInsItem:create(self.mImgRecMemer, self.mRecommendAttr2, "attrs_DispatchDockAvailableView")
        local img = item:getChildGO("mImgRec"):GetComponent(ty.AutoRefImage)
        img:SetImg(UrlManager:getHeroJobWhiteIconUrl(self.mTaskConfig.heroType[1]), false)
        self.mAttrDic[#self.mAttrDic + 1] = item
    end
end

function updateStars(self)
    if not self.mStarsGroupTrans then
        self.mStarsGroupTrans = self:getChildTrans("mStarsGroupTrans")
    end
    if not self.mStarIcon then
        self.mStarIcon = self:getChildGO("mStarIcon")
    end
    self:clearStars()
    if self.mTaskConfig.star then
        for i = 1, self.mTaskConfig.star do
            local item = SimpleInsItem:create(self.mStarIcon, self.mStarsGroupTrans, "stars_DispatchDockAvailableView")
            self.mStarsDic[i] = item
        end
    end
end

function onAutoDispatchHandler(self)
    buildBase.DispatchDockManager:autoDispatch(self.taskId, self.exploreId)
end

function onStartDispatchHandler(self)
    local result = buildBase.DispatchDockManager:dispatchMemebers(self.exploreId)
    if result then
        self:close()
    else
        gs.Message.Show(_TT(76195))
    end
end

function mBtnHandler(self, idx)
    if idx > 3 then
        return
    end
    if idx == 1 then
        if not self.mFx_01 then
            self.mFx_01 = self.mBtnAddMember_01:GetComponent(ty.UIDoTween)
        end
        self.mFx_01:BeginTween()
    elseif idx == 2 then
        if not self.mFx_02 then
            self.mFx_02 = self.mBtnAddMember_02:GetComponent(ty.UIDoTween)
        end
        self.mFx_02:BeginTween()
    elseif idx == 3 then
        if not self.mFx_03 then
            self.mFx_03 = self.mBtnAddMember_03:GetComponent(ty.UIDoTween)
        end
        self.mFx_03:BeginTween()
    end
    self.mClickFlag = not self.mClickFlag
    -- for i = 1, 3 do
    --     -- if idx ~= i then
    --     --     self.onCilckDic[i] = false
    --     -- else
    --     --     self.onCilckDic[i] = not self.onCilckDic[i]
    --     -- end

    --     self.onCilckDic[i] = not self.onCilckDic[i]
    -- end
    if self.mClickFlag then
        self.mTeamGroup:SetActive(true)
        self.mAvailableGroup:SetActive(false)
        self:updateAttr2()
        self:filterInit()
        self:updateFilterData()
        self:setData()
        return
    end

    buildBase.DispatchDockManager:setSelectedPos(0)
    self.mTeamGroup:SetActive(false)
    self.mAvailableGroup:SetActive(true)
    self:updateBaseItem()
    self:updateExtraItems()
    self:updateAttr()
end

function onAddMembersDispatchHandler(self)
    self:mBtnHandler(1)
    buildBase.DispatchDockManager:setSelectedPos(1)
end

function onAddMembersDispatchHandler2(self)
    self:mBtnHandler(2)
    buildBase.DispatchDockManager:setSelectedPos(2)
end

function onAddMembersDispatchHandler3(self)
    self:mBtnHandler(3)
    buildBase.DispatchDockManager:setSelectedPos(3)
end

function onClickCommit(self)
    if self.mScroll then
        self.mScroll:CleanAllItem()
    end
    self.mClickFlag = false
    self.mTeamGroup:SetActive(false)
    self.mAvailableGroup:SetActive(true)

    self:updateBaseItem()
    self:updateExtraItems()
    self:updateAttr()
end

function onClickCancel(self)
    -- local pos = buildBase.DispatchDockManager:getPos()
    -- self.onCilckDic[pos] = false
    buildBase.DispatchDockManager.dispatchHeroList = {}
    self:clearHearoHead()
    if self.mScroll then
        self.mScroll:CleanAllItem()
    end
    self.mTeamGroup:SetActive(false)
    self.mAvailableGroup:SetActive(true)
    self.mClickFlag = false
    self:updateBaseItem()
    self:updateExtraItems()
    self:updateAttr()
end



function onAutoDispatch(self)
    LoopManager:removeTimer(self, self.close)
    self:clearHearoHead()
    local list = buildBase.DispatchDockManager.dispatchHeroList
    if list then
        if not self.mHeadTrans then
            self.mHeadTrans = {}
            for i = 1, 3 do
                self.mHeadTrans[i] = self:getChildTrans("mImgAddMember_0" .. i)
            end
        end
        for i = 1, 3 do
            if list[i] then
                local heroVo = hero.HeroManager:getHeroConfigVo(list[i])
                local heroHead = HeroHeadGrid:poolGet()
                heroHead:setData(heroVo, false)
                heroHead:setEleType(false)
                heroHead:setType(false)
                heroHead:setShowColor(false)
                heroHead:setScale(0.82)
                heroHead:setParent(self.mHeadTrans[i])
                heroHead:setSiblingIndex(2)
                self.mHeroHeadDic[i] = heroHead
            end
        end
    end
    if self.mScroll then
        self.mScroll:CleanAllItem()
    end
    self.mTeamGroup:SetActive(false)
    self.mAvailableGroup:SetActive(true)

    self:updateBaseItem()
    self:updateExtraItems()
    self:updateAttr()
end

--选择英雄小Icon
function onSelectHeroHandler(self, heroId)
    buildBase.DispatchDockManager:changeHeroList(heroId, self.exploreId, self.taskId)
end

function onSelectedHeroChanged(self)
    if not self.mHeadTrans then
        self.mHeadTrans = {}
        for i = 1, 3 do
            self.mHeadTrans[i] = self:getChildTrans("mImgAddMember_0" .. i)
        end
    end
    self:clearHearoHead()
    if next(buildBase.DispatchDockManager.dispatchHeroList) then
        for pos, heroTid in pairs(buildBase.DispatchDockManager.dispatchHeroList) do
            local heroVo = hero.HeroManager:getHeroConfigVo(heroTid)
            local heroHead = HeroHeadGrid:poolGet()
            heroHead:setData(heroVo)
            heroHead:setEleType(false)
            heroHead:setType(false)
            heroHead:setShowColor(false)
            heroHead:setScale(0.82)
            heroHead:setParent(self.mHeadTrans[pos])
            heroHead:setSiblingIndex(2)
            self.mHeroHeadDic[pos] = heroHead
        end
    end
    self:updateBaseItem()
    self:updateExtraItems()
    self:setData(nil, nil)
end


function setData(self, list, idDic)
    if (not list and not idDic) then
        list, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType, self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, false, self.m_isFindLike, self.m_isFindLock, self.isFirstSort)
    end
    if (#list <= 0) then
        self:recover()
    end
    self.m_heroScrollList = list
    local heroIdList = {}
    for i = #self.m_heroScrollList, 1, -1 do
        table.insert(heroIdList, 1, self.m_heroScrollList[i]:getDataVo().id)
    end
    self:updateView()
end

-- 更新界面
function updateView(self)
    if (self.m_heroScrollList) then
        local index = 0
        for i = 1, #self.m_heroScrollList do
            local heroScrollVo = self.m_heroScrollList[i]
            local heroVo = heroScrollVo:getDataVo()
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
        self.mTaskConfig = buildBase.DispatchDockManager:getTaskConfig(self.taskId)
        self:Sort(self.m_heroScrollList, false)
        if self.mScroll.Count <= 0 then
            self.mScroll.DataProvider = self.m_heroScrollList
        else
            self.mScroll:ReplaceAllDataProvider(self.m_heroScrollList)
        end
    end
end

--冒泡排序 后期需要优化至nLogn 的排序法
function Sort(self, isIncrease)
    local count = #self.m_heroScrollList
    for j = 1, count - 1 do
        for i = 1, count - 1 do
            local pre = 0
            local nex = 0
            if next(self.mTaskConfig.eleType) then
                if self.m_heroScrollList[i].m_dataVo.eleType == self.mTaskConfig.eleType[1] then
                    pre = -2
                else
                    pre = math.abs(self.m_heroScrollList[i].m_dataVo.eleType - self.mTaskConfig.eleType[1])
                end

                if self.mTaskConfig.eleType[2] then
                    if self.m_heroScrollList[i].m_dataVo.eleType == self.mTaskConfig.eleType[2] then
                        if pre > -1 then
                            pre = -1
                        end
                    else
                        pre = math.abs(self.m_heroScrollList[i].m_dataVo.eleType - self.mTaskConfig.eleType[1])
                    end
                end

                if self.m_heroScrollList[i + 1].m_dataVo.eleType == self.mTaskConfig.eleType[1] then
                    nex = -2
                else
                    nex = math.abs(self.m_heroScrollList[i + 1].m_dataVo.eleType - self.mTaskConfig.eleType[1])
                end

                if self.mTaskConfig.eleType[2] then
                    if self.m_heroScrollList[i + 1].m_dataVo.eleType == self.mTaskConfig.eleType[2] then
                        if nex > -1 then
                            nex = -1
                        end
                    else
                        nex = math.abs(self.m_heroScrollList[i + 1].m_dataVo.eleType - self.mTaskConfig.eleType[1])
                    end
                end

            end

            if next(self.mTaskConfig.heroType) then
                if self.m_heroScrollList[i].m_dataVo.professionType == self.mTaskConfig.heroType[1] then
                    if pre >= 0 then
                        pre = 0
                    else
                        pre = -3
                    end
                else
                    pre = math.abs(self.m_heroScrollList[i].m_dataVo.professionType - self.mTaskConfig.heroType[1])
                end


                if self.m_heroScrollList[i + 1].m_dataVo.professionType == self.mTaskConfig.heroType[1] then
                    if nex >= 0 then
                        nex = 0
                    else
                        nex = -3
                    end
                else
                    nex = math.abs(self.m_heroScrollList[i + 1].m_dataVo.professionType - self.mTaskConfig.heroType[1])
                end

            end

            local preoVo = self.m_heroScrollList[i]
            local nexVo = self.m_heroScrollList[i + 1]
            if isIncrease and pre > nex then --递增
                self.m_heroScrollList[i] = nexVo
                self.m_heroScrollList[i + 1] = preoVo
            elseif not isIncrease and pre < nex then --递减
                self.m_heroScrollList[i] = preoVo
                self.m_heroScrollList[i + 1] = nexVo
            end
        end
    end

end

function sortSkill(selectVo1, selectVo2)
    local d1 = selectVo1.eleTyep
    local d2 = selectVo2.eleTyep

    if selectVo1.eleTyep == self.mTaskConfig.eleTyep then
        d1 = -1
    end

    if selectVo2.eleTyep == self.mTaskConfig.eleTyep then
        d2 = -1
    end
    return d1 > d2

end

function __updateGuide(self, scrollList)
    if (#scrollList > 0) then
        for i = 0, #scrollList - 1 do
            local heroVo = scrollList[i + 1]:getDataVo()
            if (heroVo) then
                if (heroVo.id == hero.HeroManager:getMinHeroId()) then
                    local scrollItem = self.mScroll:GetItemLuaClsByIndex(i)
                    -- 是否在显示列表内
                    if (scrollItem) then
                        self:setGuideTrans("hero_list_first_item", scrollItem:getGuideTrans())
                    end
                end
                if (heroVo.tid == sysParam.SysParamManager:getValue(SysParamType.TWO_HERO_ID)) then
                    local scrollItem = self.mScroll:GetItemLuaClsByIndex(i)
                    -- 是否在显示列表内
                    if (scrollItem) then
                        self:setGuideTrans("hero_list_first_item_2", scrollItem:getGuideTrans())
                    end
                end
                if (heroVo.tid == sysParam.SysParamManager:getValue(SysParamType.THIRD_HERO_ID)) then
                    local scrollItem = self.mScroll:GetItemLuaClsByIndex(i)
                    -- 是否在显示列表内
                    if (scrollItem) then
                        self:setGuideTrans("hero_list_first_item_3", scrollItem:getGuideTrans())
                    end
                end
            end
        end
    end
end

function filterInit(self)
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
end

function updateFilterData(self)
    local filterData = hero.HeroManager:getFilterData()
    -- 过滤相同战员
    self.m_isFilterSame = filterData.isFilterSame
    -- 显示全部战员
    self.m_isShowAll = filterData.isShowAll
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

function clearItems(self)
    self:clearBaseItems()
    self:clearExtraItems()
    self:clearAttrItems()
    self:clearStars()
end

function clearBaseItems(self)
    if next(self.mBaseItems) then
        for _, v in pairs(self.mBaseItems) do
            v:poolRecover()
        end
        self.mBaseItems = {}
    end
end

function clearExtraItems(self)

    if next(self.mExtraItems) then
        for _, v in pairs(self.mExtraItems) do
            v:poolRecover()
        end
        self.mExtraItems = {}
    end
end


function clearAttrItems(self)
    if next(self.mAttrDic) then
        for _, v in pairs(self.mAttrDic) do
            v:poolRecover()
        end
    end
    self.mAttrDic = {}
end

function clearStars(self)
    if next(self.mStarsDic) then
        for _, v in pairs(self.mStarsDic) do
            v:poolRecover()
        end
    end
    self.mStarsDic = {}
end

function clearHearoHead(self)
    if next(self.mHeroHeadDic) then
        for _, item in pairs(self.mHeroHeadDic) do
            item:poolRecover()
            item = nil
        end
    end
    self.mHeroHeadDic = {}
end

function cancelAllSelect(self)
    -- if self.mImgSelected_01 then
    --     self.mImgSelected_01:SetActive(false)
    -- end
    -- if self.mImgSelected_02 then
    --     self.mImgSelected_02:SetActive(false)
    -- end
    -- if self.mImgSelected_03 then
    --     self.mImgSelected_03:SetActive(false)
    -- end
end

return _M


--[[ 替换语言包自动生成，请勿修改！
]]