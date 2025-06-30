module("favorable.FavorablePanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("favorable/FavorablePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(41720))
    self:setBg("", false)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.currentTabView = {}
    self.mTabDic = {}
    --是否是初始化
    self.mIsInit = false
    self.showTabType = 2
    --最新的等级
    self.mUpLv = 0
    --最新数值
    self.mNewValue = 0
end

function initTabBar(self)
end

function configUI(self)
    super.configUI(self)
    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mBtnBackList = self:getChildGO("mBtnBackList")
    self.mCVInfo = self:getChildGO("mCVInfo")
    self.mGroupTab = self:getChildTrans("mGroupTab")
    self.mSliderEffcet = self:getChildGO("mSliderEffcet")
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mSliderLv = self:getChildGO("mSliderLv"):GetComponent(ty.Slider)
    self.mTxtCVName = self:getChildGO("mTxtCVName"):GetComponent(ty.Text)
    self.mTxtHerName = self:getChildGO("mTxtHerName"):GetComponent(ty.Text)
    self.mTxtFavorable = self:getChildGO("mTxtFavorable"):GetComponent(ty.Text)
    self.mTempSliderLv = self:getChildGO("mTempSliderLv"):GetComponent(ty.Image)
    self.mTxtFavorableLv = self:getChildGO("mTxtFavorableLv"):GetComponent(ty.Text)
    self.mImgHeroIcon = self:getChildGO("mImgHeroIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtAddFavorable = self:getChildGO("mTxtAddFavorable"):GetComponent(ty.Text)
    self.mImgQualityBar = self:getChildGO("mImgQualityBar"):GetComponent(ty.Image)
    self.mBtnFavorable = self:getChildGO("mBtnFavorable")
    self.mBtnStory = self:getChildGO("mBtnStory")
    self.mModelPlayer = ModelScenePlayer.new()
end

function active(self, args)
    -- 此处确保尽快看到展示的场景
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_CULTIVATE, nil, nil, UrlManager:getBgPath("hero5/hero5_bg_4.png"))
    if not args or not args.type then
        args = { type = 1 }
    end
    super.active(self, args)
    self.cusHeroId = hero.HeroManager:getPanelShowHeroId()
    self.heroVo = hero.HeroManager:getHeroVo(self.cusHeroId)
    GameDispatcher:addEventListener(EventName.UPDATE_FAVORABLE_PREDATA, self.updatePreView, self)
    GameDispatcher:addEventListener(EventName.UPDATE_FAVORABLE, self.onUpdateFavorable, self)
    GameDispatcher:addEventListener(EventName.FAVORABLE_REWARD_GAIN_UPDATE, self.onUpdateFavorable, self)
    hero.HeroManager:addEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.changeHero, self)
    self:updateTab()
    self:show()
    self:updateCaseBubble()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FAVORABLE_PREDATA, self.updatePreView, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FAVORABLE, self.onUpdateFavorable, self)
    GameDispatcher:removeEventListener(EventName.FAVORABLE_REWARD_GAIN_UPDATE, self.onUpdateFavorable, self)
    hero.HeroManager:removeEventListener(hero.HeroManager.PANEL_SHOW_HERO_CHANGE, self.changeHero, self)
    self:recoverModel(true)
    if (self.tabBar) then
        self.tabBar:reset()
    end
    self.mSliderLv:DOKill()
    self.mIsInit = false
    self:recoveAllSn()
    RedPointManager:remove(self.mBtnFavorable.transform)
    RedPointManager:remove(self.mBtnBackList.transform)
end

function recoveAllSn(self)

    if (self.popSn) then
        LoopManager:removeFrameByIndex(self.popSn)
        self.popSn = nil
    end

    if (self.mNumListSn) then
        LoopManager:removeFrameByIndex(self.mNumListSn)
        self.mNumListSn = nil
    end

    if (self.mExpSn) then
        LoopManager:removeFrameByIndex(self.mExpSn)
        self.mExpSn = nil
    end

    if (self.mModelSn) then
        LoopManager:removeFrameByIndex(self.mModelSn)
        self.mModelSn = nil
    end
end

function closeAll(self)
    favorable.FavorableManager.mRecordFavorChoose = false
    super.closeAll(self)
end

function getTabClass(self)
    self.tabClassDic[favorable.FavorableConst.HERO_FAVORABLE] = favorable.FavorableGiveView
    return self.tabClassDic
end

function initViewText(self)
    self:setBtnLabel(self.mBtnFavorable, nil, "档案")
    self:setBtnLabel(self.mBtnStory,nil,_TT(41758))
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFavorable, self.onOpenDetailHandler)
    self:addUIEvent(self.mBtnLast, self.onClickHeroPreHandler)
    self:addUIEvent(self.mBtnNext, self.onClickHeroNextHandler)
    self:addUIEvent(self.mBtnBackList, self.onClickBackListHandler)
    self:addUIEvent(self.mBtnStory,self.onClickStoryHandler)
end

function onClickHeroPreHandler(self)
    local index = self:getIndexById(self.cusHeroId)
    local heroVo = self.heroList[index - 1]
    if heroVo then
        local nowHeroId = heroVo:getDataVo().id
        self.isHeroChanged = self.cusHeroId ~= nowHeroId
        self.cusHeroId = nowHeroId
        self.heroVo = hero.HeroManager:getHeroVo(self.cusHeroId)
        self.mUpLv = 0
        self:onUpdateFavorable()
    end
end
-- 后一个英雄
function onClickHeroNextHandler(self)
    local index = self:getIndexById(self.cusHeroId)
    local heroVo = self.heroList[index + 1]
    if heroVo then
        local nowHeroId = heroVo:getDataVo().id
        self.isHeroChanged = self.cusHeroId ~= nowHeroId
        self.cusHeroId = nowHeroId
        self.heroVo = hero.HeroManager:getHeroVo(self.cusHeroId)
        self.mUpLv = 0
        self:onUpdateFavorable()
    end
end

function onClickStoryHandler(self)
    if not self.heroFavorableData.hasStory then
        gs.Message.Show(_TT(41749))
        return
    end

    self:setActiveArgs(self:getActiveArgs())
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_STORY_PANEL, { heroId = self.cusHeroId, heroTid = self.heroVo.tid })
end

-- 打开英雄选择界面
function onClickBackListHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_SHOW_SELECT_PANEL, { teamId = self.teamId, redType = hero.HeroFlagManager.FLAG_BTN_FAVORABLE })
end

function onOpenDetailHandler(self)
    self:setActiveArgs(self:getActiveArgs())
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILS_PANEL, { heroId = self.cusHeroId, heroTid = self.heroVo.tid })
end

function getIndexById(self, id)
    local index = 1
    if (self.heroList == nil) then
        self:getHeroList()
    end
    for i = 1, #self.heroList do
        if (self.heroList[i]:getDataVo().id == id) then
            index = i
            break
        end
    end
    return index
end

function getHeroList(self, index)
    if (self.heroList == nil) then
        local filterData = hero.HeroManager:getFilterData()
        if (not filterData) then
            filterData = {}
            filterData.isFilterSame = hero.HeroManager:getFilterSameHero() == "1"
            filterData.isFindLike = false
            filterData.isFindLock = false
            filterData.isDescending = true
            filterData.selectSortType = showBoard.panelSortType.POWER
            filterData.selectFilterDic = {}
            for type in pairs(showBoard.panelFilterTypeDic) do
                filterData.selectFilterDic[type] = {}
                filterData.selectFilterDic[type][showBoard.filterSubTypeAll] = true
            end
        end
        local list, _ = showBoard.ShowBoardManager:getHeroScrollList(nil, filterData.selectSortType, filterData.isDescending, filterData.selectFilterDic,
        filterData.isFilterSame, false, filterData.isFindLike, filterData.isFindLock, true)
        self.heroList = list
    end

    if (index ~= nil) then
        return self.heroList[index]
    end
end

-- 父节点
function getTabViewParent(self)
    return self:getChildTrans("mFavorableTrans")
end

-- 可Override后提供需要active传入子页面的参数
function getActiveArgs(self)
    return { heroId = self.cusHeroId }
end

function updateTab(self)
    local list = favorable.FavorableConst.TAB_LIST
    self.tabBar = CustomTabBar:create(self:getChildGO("GroupTabItem"), self.mGroupTab, self.setType, self)
    self.tabBar:setData(list)
    self.tabBar:setPage(2)
end

function __updateModelView(self, heroVo)
    if (heroVo) then
        self.mModelPlayer:setData(heroVo.id, true, 1, true, MainCityConst.ROLE_MODE_CULTIVATE, UrlManager:getBgPath("hero5/hero5_bg_4.png"))
    else
        self:recoverModel(false)
    end
end

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
end

function changeHero(self)
    local nowHeroId = hero.HeroManager:getPanelShowHeroId()
    self.isHeroChanged = self.cusHeroId ~= nowHeroId
    self.cusHeroId = nowHeroId
    self.heroVo = hero.HeroManager:getHeroVo(self.cusHeroId)
    self.mUpLv = 0
    self:onUpdateFavorable()
    self:updateBubble(self.cusHeroId)
end

function onUpdateFavorable(self, flag)
    if flag then
        self.isHeroChanged = nil
    end
    hero.HeroManager:setPanelShowHeroId(self.cusHeroId)
    self:show()
    self:updateCaseBubble()
end

function show(self)
    self.heroFavorableData = favorable.FavorableManager:getHeroFavorableData(self.heroVo.tid)
    self.numList = {}
    local needExp = 0
    table.insert(self.numList, 0)
    for lv, data in pairs(self.heroFavorableData.favorableData) do
        needExp = data.favorableExp
        if (data.favorableExp == 0) then
            --等级所需经验为0说明已经满级
        else
            table.insert(self.numList, needExp)
        end
    end

    self.curFavorableLv = self.heroVo.favorableLevel
    favorable.FavorableManager:setPreLv(self.curFavorableLv)
    self.curFavorableExp = self.heroVo.favorableExp

    self.mTxtLv.text = self.heroVo.favorableLevel
    if self.numList[self.curFavorableLv + 1] == nil then
        self.maxExp = self.numList[self.curFavorableLv]
    else
        self.maxExp = self.numList[self.curFavorableLv + 1]
    end
    local favorableData = self.heroFavorableData.favorableData[self.heroVo.favorableLevel]

    self.mTxtAddFavorable.text = ""
    self.mTempSliderLv.gameObject:SetActive(false)
    self.mSliderLv.gameObject:SetActive(true)
    self.mTxtName.text = self.heroVo.name
    self.mTxtHerName.text = self.heroVo.name
    self.mTxtCVName.text = self.heroVo.zhCVName
    -- gs.TransQuick:SizeDelta01(self.mImgCVLine, math.ceil(#self.heroVo.zhCVName / 3) * 20)

    local function LoadExp()
        self.mMaxLv = sysParam.SysParamManager:getValue(SysParamType.MAX_FAVORABLE_LV)
        local mMaxExp = self.heroFavorableData.favorableData[self.mMaxLv - 1].favorableExp
        self.isMaxExp = false
        if self.curFavorableExp == 0 and self.maxExp == self.numList[#self.numList] then
            self.mTxtFavorable.text = _TT(25139, self.maxExp, self.maxExp)
            self.isMaxExp = true
            if self.isHeroChanged then
                self.isHeroChanged = nil
                self.mSliderLv.value = 1
            else
                self:updateEffect(self.mNewValue, self.maxExp, 0.5, 0.3)
                self:updateTxtEffect(0, self.maxExp, 0.5)
            end
        else
            self.mTxtFavorable.text = _TT(25139, self.curFavorableExp, self.maxExp)
            if self.isHeroChanged == nil then
                local endValue = (self.curFavorableExp) / (self.maxExp)
                self:updateEffect(self.mNewValue, endValue, 0.5, 0.3)
                self:updateTxtEffect(0, self.numList[self.curFavorableLv] + self.curFavorableExp, 0.5)
            else
                if (self.popSn) then
                    LoopManager:removeFrameByIndex(self.popSn)
                    self.popSn = nil
                end
                self.mSliderLv:DOPause()
                self.isHeroChanged = nil
                self.mSliderLv.value = (self.curFavorableExp) / (self.maxExp)
            end
            self.mNewValue = (self.curFavorableExp) / (self.maxExp)
        end
        if (self.mExpSn) then
            LoopManager:removeFrameByIndex(self.mExpSn)
            self.mExpSn = nil
        end
    end

    self.mExpSn = LoopManager:addFrame(3, 1, self, LoadExp)
    self.mTxtFavorableLv.text = _TT(favorableData.favorable)
    self:__updateModelView(self.heroVo)
    if not self.heroVo then
        self.mBtnLast:SetActive(false)
        self.mBtnNext:SetActive(false)
        return
    end
    self.mImgHeroIcon:SetImg(UrlManager:getHeroHeadUrlByModel(self.heroVo:getHeroModel()), false)
    self.mImgQualityBar.color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(self.heroVo.color))
    local index = self:getIndexById(self.cusHeroId)
    self.mBtnLast:SetActive(self.heroList[index - 1] ~= nil)
    self.mBtnNext:SetActive(self.heroList[index + 1] ~= nil)

    self:updateBubble(self.cusHeroId)

    --self.mBtnStory:SetActive(self.heroFavorableData.hasStory)
end

function updatePreView(self)
    local addNum = favorable.FavorableManager:getSelectNum()
    self.mTempSliderLv.gameObject:SetActive(addNum > 0)
    favorable.FavorableManager:setPreLv(self.curFavorableLv)
    if (addNum == 0) then
        self.mSliderLv.gameObject:SetActive(true)
        self.mTxtAddFavorable.text = ""
        self.mUpLv = 0
        self.mTxtLv.text = self.curFavorableLv
        if self.curFavorableExp == 0 and self.maxExp == self.numList[#self.numList] then
            self.mSliderLv.value = 1
            self.mTxtFavorable.text = _TT(25139, self.numList[#self.numList], self.numList[#self.numList])
            favorable.FavorableManager:setPreLv(self.curFavorableLv)
            return
        end
        self.mTxtFavorable.text = _TT(25139, self.curFavorableExp, self.maxExp)
        favorable.FavorableManager:setPreLv(self.curFavorableLv)
        return
    else
        self.mTxtAddFavorable.text = "+" .. addNum
        local currentExp = addNum + self.curFavorableExp
        local preLv = favorable.FavorableManager:getPreLv()

        for i = self.curFavorableLv + 1, #self.numList do
            if (currentExp >= self.numList[i]) then
                preLv = i
                currentExp = currentExp - self.numList[i]
            end
        end

        local mMaxExp = self.numList[#self.numList]
        self.mSliderLv.gameObject:SetActive(preLv - self.curFavorableLv <= 0)
        if preLv - self.curFavorableLv > 0 then
            self.mTxtLv.text = preLv
            self.mUpLv = preLv - self.curFavorableLv
            if preLv > self.mMaxLv and currentExp >= mMaxExp then
                self.mTempSliderLv.fillAmount = 1
                -- self.mTempSliderLv.gameObject:SetActive(true)
                self.mTxtFavorable.text = _TT(25139, currentExp, self.numList[preLv])
                favorable.FavorableManager:setPreLv(preLv)
                return
            end
        else
            self.mUpLv = 0
            self.mTxtLv.text = self.curFavorableLv
        end
        local showMaxExp = self.numList[preLv + 1]
        if (showMaxExp == nil) then
            showMaxExp = self.numList[preLv]
            currentExp = showMaxExp
            self.mTempSliderLv.fillAmount = 1
        else
            self.mTempSliderLv.fillAmount = (currentExp) / (showMaxExp)
        end
        self.mTxtFavorable.text = _TT(25139, currentExp, showMaxExp)
        favorable.FavorableManager:setPreLv(preLv)
    end
end

-- 动效 endTime为秒self.mFrames实时刷新的帧率
function updateEffect(self, startTValue, endValue, endTime, upTime)
    if startTValue == endValue then
        return
    end
    local curUpLv = 0
    self.mSliderEffcet:SetActive(true)
    self:addEffect("fx_ui_common_slider", self:getChildTrans("mSliderEffcet"))
    self.mTxtLv.text = self.curFavorableLv - self.mUpLv
    if self.mUpLv > 0 then
        upTime = 0.5 / self.mUpLv
        self.mSliderLv:DOValue(1, upTime):SetLoops(self.mUpLv):OnStepComplete(function()
            curUpLv = curUpLv + 1
            self.mTxtLv.text = self.curFavorableLv - self.mUpLv + curUpLv
            self.mSliderLv.value = 0
            if curUpLv == self.mUpLv then
                self.mSliderLv:DOValue(endValue, endTime):OnComplete(function()
                    self.mSliderEffcet:SetActive(false)
                    self:removeEffect("fx_ui_common_slider", self:getChildTrans("mSliderEffcet"))
                    if favorable.FavorableManager:getIsPopUp() == true then
                        local function ShowPop()
                            GameDispatcher:dispatchEvent(EventName.OPEN_FAVORABLUP_VIEW)
                            favorable.FavorableManager:setIsPopUp(false)
                            if (self.popSn) then
                                LoopManager:removeFrameByIndex(self.popSn)
                                self.popSn = nil
                            end
                        end
                        self.popSn = LoopManager:addFrame(2, 1, self, ShowPop)
                    end
                end)
            end
        end)
        return
    end
    self.mSliderLv:DOValue(endValue, endTime):OnComplete(function()
        self.mSliderEffcet:SetActive(false)
        self:removeEffect("fx_ui_common_slider", self:getChildTrans("mSliderEffcet"))
    end)
end

-- 数字动效
function updateTxtEffect(self, startTValue, newScore, endTime)
    local sequence = gs.DT.DOTween.Sequence()
    sequence:SetAutoKill(false):Append(gs.DT.DOTween.To(function(value)
    end, startTValue, newScore, endTime))
end

function updateBubble(self, curHeroId)
    local flag = favorable.FavorableManager:getCaseRewardHasRed(curHeroId)
    if flag then
        RedPointManager:add(self.mBtnFavorable.transform, nil, 40.5, 40.5)
    else
        RedPointManager:remove(self.mBtnFavorable.transform)
    end

    local storyFlag = favorable.FavorableManager:getStoryRewardHasRed(curHeroId)
    if storyFlag then
        RedPointManager:add(self.mBtnStory.transform, nil, 40.5, 40.5)
    else
        RedPointManager:remove(self.mBtnStory.transform)
    end

    if hero.HeroFlagManager:getAllFlagExceptHero(curHeroId, hero.HeroFlagManager.FLAG_BTN_FAVORABLE) then
        RedPointManager:add(self.mBtnBackList.transform, nil, 40.5, 40.5)
    else
        RedPointManager:remove(self.mBtnBackList.transform)
    end

end

-- 更新资料红点
function updateCaseBubble(self)
    local isBubble = favorable.FavorableManager:getCaseRewardHasRed(self.cusHeroId)
    if isBubble then
        self:addBubble(favorable.FavorableConst.HERO_FILE_CASE, 21, 57)
    else
        self:removeBubble(favorable.FavorableConst.HERO_FILE_CASE)
    end
end

function updateHeroStoryBubble(self)
    local isBubble = favorable.FavorableManager:getStoryRewardHasRed(self.cusHeroId)
    if isBubble then
        self:addBubble(favorable.FavorableConst.HERO_STORY, 21, 57)
    else
        self:removeBubble(favorable.FavorableConst.HERO_STORY)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]