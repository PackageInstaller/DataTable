module("seabed.SeabedHeroSelectPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("seabed/SeabedHeroSelectPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(111059))
    self:setSize(0, 0)
    self:setBg("seabed_main.jpg", false, "seabed")
end

-- 初始化数据
function initData(self)
    self.mHeroCardList = {}
    self.eleList = {}
end

function initViewText(self)
    self:setBtnLabel(self.m_btnCancel, 2, "取消")
    self:setBtnLabel(self.m_btnConfirm, 1, "确定")
    self:setBtnLabel(self.m_btnFilter, 1001, "筛选")

    self:getChildGO("mTxtSelect"):GetComponent(ty.Text).text = _TT(111038)
    self:getChildGO("mTxtFight"):GetComponent(ty.Text).text = _TT(111039)
end

-- 初始化
function configUI(self)
    self.m_sortView = hero.HeroSortMaxView.new()
    self.m_sortView:setParentTrans(self:getChildTrans("NodeFilter"))
    self.m_sortView:setCallBack(self, self.__onClickSortItemHandler)
    self.m_sortView.m_uiGos["GroupShowAll"]:SetActive(false)
    self.m_scrollerSelect = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.m_scrollerSelect:SetItemRender(self:__getHeadSelectItem())

    self.m_btnCancel = self:getChildGO("BtnCancel")
    self.m_btnConfirm = self:getChildGO("BtnConfirm")
    self.m_btnFilter = self:getChildGO("BtnFilter")

    self.mHeroSelectContent = self:getChildTrans("mHeroSelectContent")
    self.mHeroItem = self:getChildGO("mHeroItem")

    self.mRecommandLv = self:getChildGO("mRecommandLv")
    self.mRecommandBg = self:getChildGO('mRecommandBg'):GetComponent(ty.Image)
    self.mTxtRecommand = self:getChildGO('mTxtRecommand'):GetComponent(ty.Text)
    self.mTxtRecommandLv = self:getChildGO('mTxtRecommandLv'):GetComponent(ty.Text)
    self.mRecommandFormation = self:getChildTrans("mRecommandFormation")
    self.mImgEleBg = self:getChildGO("mImgEleBg")

    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mBtnNext = self:getChildGO("mBtnNext")

    self:setGuideTrans("functips_seabed_function_heroSelectleft", self:getChildTrans("mHeroSelectContent"))
    self:setGuideTrans("functips_seabed_function_heroSelectright", self:getChildTrans("mFunctionTips_heroSelect"))
    
    
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnNext, self.onBtnNextClickHandler)
end

function onBtnNextClickHandler(self)
    --GameDispatcher:dispatchEvent(EventName.REQ_ENTER_SEABED, {})
    local heroList = seabed.SeabedManager:getHeroSelectList()
    if #heroList >= 1 then
        local args = {}
        args.step = seabed.SeabedStepType.Dif
        args.list = {}

        local dif, d = seabed.SeabedManager:getSelectDifficulty()
        args.list = {dif, d}

        for i = 1, #heroList, 1 do
            table.insert(args.list, heroList[i])
        end
        GameDispatcher:dispatchEvent(EventName.REQ_ENTER_SEABED, args)
    else
        gs.Message.Show(_TT(111040))
    end
end

-- 点击排序item
function __onClickSortItemHandler(self)
    self.mIsFilterUseState = self.m_sortView:getIsFilterUseState()
    -- 过滤相同战员
    self.m_isFilterSame = self.m_sortView:getIsFilterSame()
    self.m_isDescending = self.m_sortView:getIsDescending()
    self.m_selectSortType = self.m_sortView:getSortFilterType()
    self.m_isFindLike, self.m_isFindLock = self.m_sortView:getIsLike(), self.m_sortView:getIsLock()
    self.m_selectFilterDic = self.m_sortView:getSearchFilterDic()
    self:__updateView()
end

function __updateView(self, isInit)
    self.m_sortView:setFilterUseState(false, self.mIsFilterUseState)
    self.m_sortView:setFilterSame(false, self.m_isFilterSame, -10, -600)
    self.m_sortView:addFilterMenu(showBoard.panelFilterTypeList, showBoard.panelFilterTypeDic, self.m_selectFilterDic,
        self.m_isFindLike, self.m_isFindLock, false)
    self.m_sortView:addSortMenu(showBoard.panelSortTypeList, self.m_selectSortType, self.m_isDescending, false)

    self:recoverListData(self.m_scrollerSelect.DataProvider)
    local scrollList = self:getDataList()
    if isInit == true or self.m_scrollerSelect.Count <= 0 then
        self.m_scrollerSelect.DataProvider = scrollList
    else
        self.m_scrollerSelect:ReplaceAllDataProvider(scrollList)
    end
end

function getDataList(self)
    local inFormationList = {}
    local fomationList = {}
    local heroList, idDic = showBoard.ShowBoardManager:getHeroScrollList(nil, self.m_selectSortType,
        self.m_isDescending, self.m_selectFilterDic, self.m_isFilterSame, self.mIsFilterUseState, self.m_isFindLike,
        self.m_isFindLock)
    local showRemoveVo = nil
    for i = 1, #heroList do
        local heroVo = heroList[i]:getDataVo()
        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({
            dataVo = heroVo,
            isShowRemove = seabed.SeabedManager:getHeroInSelect(heroVo.id)
        })

        local isInFormation = seabed.SeabedManager:getHeroInSelect(heroVo.id)
        if (isInFormation) then
            table.insert(inFormationList, scrollVo)
        else
            table.insert(fomationList, scrollVo)
        end
    end

    for i = 1, #fomationList do
        table.insert(inFormationList, fomationList[i])
    end

    return inFormationList
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

function __getHeadSelectItem(self)
    return seabed.SeabedHeroSelectInitItem
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self.m_sortView:resetAll()
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_HERO_SELECT_PANEL, self.showSelectHero, self)
    self:clearSelectHeroCards()
    self:clearSelectHeroItems()
    self:clearEleList()
    seabed.SeabedManager:clearSelectHeroList()
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.id = args.id
    self:showPanel()
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_HERO_SELECT_PANEL, self.showSelectHero, self)
    local filterDic = self:getDefFilterDic()
    self:initSortData(filterDic)
    self:__updateView(true)

    self:showSelectHero()
end

function showPanel(self)
    local vo = seabed.SeabedManager:getSeabedDifficultyDataById(self.id)
    self.mTxtRecommandLv.text = _TT(3072, vo.suggestLevel)
    
    --self.mTxtName.text = _TT(111033).. self.id
    local tips = ""
    local difList = seabed.SeabedManager:getSeabedDifficultyData()
    for i = 1,#difList do
        if difList[i].id == self.id then
            tips =_TT( difList[i].difficultyTitle)
        end
    end
    self.mTxtTips.text = tips

    self:clearEleList()
    local suggestEle = vo.suggestEle
    for i = 1, #suggestEle do
        local item = SimpleInsItem:create(self.mImgEleBg, self.mRecommandFormation, "heroSelecteleGrid")
        local img = item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
        img:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestEle[i]), true)
        img.color = gs.ColorUtil.GetColor("ffffffff")
        table.insert(self.eleList, item)
    end
end

function clearEleList(self)
    for i = 1, #self.eleList do
        self.eleList[i]:poolRecover()
    end
    self.eleList = {}
end

function initSortData(self, dic)
    self.mIsFilterUseState = dic.mIsFilterUseState
    -- 过滤相同战员
    self.m_isFilterSame = dic.m_isFilterSame
    -- 是否查找喜欢的英雄
    self.m_isFindLike = dic.m_isFindLike
    -- 是否查找锁定的英雄
    self.m_isFindLock = dic.m_isFindLock
    -- 是否降序
    self.m_isDescending = dic.m_isDescending
    -- 选择的排序类型
    self.m_selectSortType = dic.m_selectSortType
    -- 提供的筛选字典
    self.m_selectFilterDic = dic.m_selectFilterDic
end

function getDefFilterDic(self)
    local dic = {}
    -- 是否默认显示处于状态的
    dic.mIsFilterUseState = false
    -- 过滤相同战员
    dic.m_isFilterSame = false
    -- 是否查找喜欢的英雄
    dic.m_isFindLike = false
    -- 是否查找锁定的英雄
    dic.m_isFindLock = false
    -- 是否降序
    dic.m_isDescending = true
    -- 选择的排序类型
    dic.m_selectSortType = showBoard.panelSortType.LEVEL
    -- 提供的筛选字典
    dic.m_selectFilterDic = {}
    for type in pairs(showBoard.panelFilterTypeDic) do
        dic.m_selectFilterDic[type] = {}
        dic.m_selectFilterDic[type][showBoard.filterSubTypeAll] = true
    end
    return dic
end

function showSelectHero(self)
    if self.mHeroItemList == nil or #self.mHeroItemList == 0 then
        self.mHeroItemList = {}
        for i = 1, 5 do
            local item = SimpleInsItem:create(self.mHeroItem, self.mHeroSelectContent, "mSeabedHeroItemItem")
            table.insert(self.mHeroItemList, item)
        end
    end

    self:clearSelectHeroCards()
    local idList = seabed.SeabedManager:getHeroSelectList()
    for i = 1, #idList do
        local heroVo = hero.HeroManager:getHeroVo(idList[i])
        local grid = HeroHeadGrid:poolGet()
        grid:setData(heroVo)
        grid:setStarLvl(heroVo.evolutionLvl)
        grid:setLvl(heroVo.lvl)
        grid:setParent(self.mHeroItemList[i]:getChildTrans("mHeroCardContent"))
        grid:setScale(0.9)

        table.insert(self.mHeroCardList, grid)
    end
end

function clearSelectHeroItems(self)
    for i = 1, #self.mHeroItemList do
        self.mHeroItemList[i]:poolRecover()
    end
    self.mHeroItemList = {}
end

function clearSelectHeroCards(self)
    for i = 1, #self.mHeroCardList do
        self.mHeroCardList[i]:poolRecover()
    end
    self.mHeroCardList = {}
end

return _M
