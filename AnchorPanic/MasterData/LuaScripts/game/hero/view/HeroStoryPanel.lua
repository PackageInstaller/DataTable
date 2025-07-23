--[[ 
-----------------------------------------------------
@filename       : HeroStoryPanel
@Description    : 战员剧情
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroStoryPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("hero/HeroStoryPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(41725))
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
    self.selfClose = true
    self.mIsShowFashion = true
    self.mAudioData = nil
    self.mVoiceSn = nil
    self.mIsFirstShow = false
    self.mOnClickFun = nil
    self.mIsPlaying=false
end

function configUI(self)
    super.configUI(self)
    self.mGroup = self:getChildGO("mGroup")
    self.mBtnPre = self:getChildGO("mBtnPre")
    self.mBtnEle = self:getChildGO("mBtnEle")
    self.mBtnJob = self:getChildGO("mBtnJob")
    self.mModelPlayer = ModelScenePlayer.new()
    self.mBtnHide = self:getChildGO("mBtnHide")
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mImgTalkBg = self:getChildGO("mImgTalkBg")
    self.mBtnChange = self:getChildGO("mBtnChange")
    self.mViewTrans = self:getChildTrans("mViewTrans")
    self.mClickerArea = self:getChildGO("mClickerArea")
    self.mTabBarNode = self:getChildTrans("mTabBarNode")
    self.mGroupTabItem = self:getChildGO("mGroupTabItem")
    self.mAnimator = self.UIObject:GetComponent(ty.Animator)
    self.mGroupFavorable = self:getChildGO("mGroupFavorable")
    self.mTxtTalk = self:getChildGO("mTxtTalk"):GetComponent(ty.Text)
    self.mTalkBgCanvas = self.mImgTalkBg:GetComponent(ty.CanvasGroup)
    self.mTxtCvName = self:getChildGO("mTxtCvName"):GetComponent(ty.Text)
    self.mIconJob = self:getChildGO("mIconJob"):GetComponent(ty.AutoRefImage)
    self.mIconEle = self:getChildGO("mIconEle"):GetComponent(ty.AutoRefImage)
    self.mTxtHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mImgChange = self:getChildGO("mImgChange"):GetComponent(ty.AutoRefImage)
    self.mImgHeroPic = self:getChildGO("mImgHeroPic"):GetComponent(ty.AutoRefImage)
    self.mTxtFavorableLv = self:getChildGO("mTxtFavorableLv"):GetComponent(ty.Text)
    self.mImgHideChange = self:getChildGO("mImgHideChange"):GetComponent(ty.AutoRefImage)
end

function getActiveArgs(self)
    return { heroId = self.curHeroId, heroTid = self.curHeroTid }
end

function active(self, args)
    self.mImgTalkBg:SetActive(false)
    --获取默认动画
    local sRo = fight.RoleShowManager:getModeData(MainCityConst.ROLE_MODE_CLIP)
    if sRo then
        local actName = sRo:getAction()
        if actName and #actName > 0 then
            self.mAlwayHash = gs.Animator.StringToHash(actName)
        else
            local alwayAniName = sRo:getAlways()
            self.mAlwayHash = gs.Animator.StringToHash(alwayAniName)
        end
    end

    if (favorable.FavorableManager.mRecordFavorChoose) then
        self.curHeroId = hero.HeroManager:getPanelShowHeroId()
        self.curHeroTid = hero.HeroManager:getHeroVo(self.curHeroId).tid
        favorable.FavorableManager.mRecordFavorChoose = false
    else
        self.curHeroId = args.heroId
        self.curHeroTid = args.heroTid
    end
    if self.args[self.curPage] then
        self.args[self.curPage] = self:getActiveArgs()
    end
    super.active(self, args)
    if args.isShowFashion ~= nil then
        self.mIsShowFashion = args.isShowFashion
    end
    if args.onClickFun then
        self.mOnClickFun = args.onClickFun
    end
    self.curHeroVo = hero.HeroManager:getHeroVo(self.curHeroId)
    if (self.curHeroId == nil or self.curHeroVo == nil) then
        self.curHeroVo = hero.HeroManager:getHeroConfigVo(self.curHeroTid)
    end
    GameDispatcher:addEventListener(EventName.FAVORABLE_REWARD_GAIN_UPDATE, self.updateBubble, self)
    GameDispatcher:addEventListener(EventName.HERO_DETAIL_CLOSE, self.onClosePanel, self)
    GameDispatcher:addEventListener(EventName.HERO_FILES_SHOW_ACTION, self.playAction, self)
    self:updateTab()
    self.selfClose = true

    self.mBtnNext:SetActive(false)
    self.mBtnPre:SetActive(false)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.FAVORABLE_REWARD_GAIN_UPDATE, self.updateBubble, self)
    GameDispatcher:removeEventListener(EventName.HERO_DETAIL_CLOSE, self.onClosePanel, self)
    GameDispatcher:removeEventListener(EventName.HERO_FILES_SHOW_ACTION, self.playAction, self)
    self:destroyTimeSn()
    self:updateRoleNodeState(true)
    if self.mAudioData then
        AudioManager:stopAudioSound(self.mAudioData)
        self:onShowHeroInTeractTextOnlyHandler(nil)
        self.mAudioData = nil
        self:playAction({ state = false })
    end
    self.mIsInit = false
    if self.mVoiceSn then
        LoopManager:removeTimerByIndex(self.mVoiceSn)
        self.mVoiceSn = nil
    end

    self:recoverModel(true)
    if self.mTween then
        self.mTween:Kill()
    end
    if self.sceneCameraTrans then
        gs.TransQuick:LPosZero(self.sceneCameraTrans)
    end
end

function close(self)
    super.close(self)
    if (self.curHeroId ~= nil) then
        hero.HeroManager:setPanelShowHeroId(self.curHeroId)
    end
end

-- 设置货币栏
function setMoneyBar(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:setBtnLabel(self.mBtnHide, 280, "隐藏UI")
    --self:setBtnLabel(self.mBtnChange, 1196, "切換")
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnHide, self.onClickHideHanler)
    self:addUIEvent(self.mBtnPre, self.onClickHeroPreHandler)
    self:addUIEvent(self.mBtnNext, self.onClickHeroNextHandler)
    self:addUIEvent(self.mBtnChange, self.onClickChange3DHandler)
    self:addUIEvent(self.mBtnEle, self.onOpenJobAndEleTips, nil, true)
    self:addUIEvent(self.mBtnJob, self.onOpenJobAndEleTips, nil, false)
end

function onClosePanel(self)
    self:close()
end

function onOpenJobAndEleTips(self, isEle)
    if isEle then
        TipsFactory:heroEleAndOccTips(2, self.mBtnEle.transform)
    else
        TipsFactory:heroEleAndOccTips(1, self.mBtnJob.transform)
    end
end

function onClickHideHanler(self)
    if self.mGroup.activeSelf == true then
        self:setBtnLabel(self.mBtnHide, 281, "显示UI")
        self.mGroup:SetActive(false)
        self.mImgHideChange:SetImg(UrlManager:getPackPath("mainui/mainui_6.png"), true)
        self.mAnimator:SetTrigger("show")
        if favorable.FavorableManager.mDetailShow3D then
            self:onClickBackCenterHandler()
        end
    else
        self.mAnimator:SetTrigger("exit")
        self:setBtnLabel(self.mBtnHide, 280, "隐藏UI")
        self.mGroup:SetActive(true)
        self.mImgHideChange:SetImg(UrlManager:getPackPath("mainui/mainui_7.png"), true)
        if favorable.FavorableManager.mDetailShow3D then
            self:onClickMoveLeftHandler()
        end
    end
    self.base_childGos["mGroupTop"]:SetActive(self.mGroup.activeSelf == true)
end

-- 前一个英雄
function onClickHeroPreHandler(self)
    local index = self:getIndexByTid(self.curHeroTid)
    local heroVo = self.heroList[index - 1]
    if heroVo then
        self.curHeroId = heroVo:getDataVo().id
        self.curHeroTid = heroVo:getDataVo().tid
        self.curHeroVo = heroVo:getDataVo()
        self:updateTab()
        self:changeHero(0, self.curHeroId, self.curHeroTid)
        if self.mOnClickFun then
            self.mOnClickFun(self.curHeroTid)
        end
    end
end
-- 后一个英雄
function onClickHeroNextHandler(self)
    local index = self:getIndexByTid(self.curHeroTid)
    local heroVo = self.heroList[index + 1]
    if heroVo then
        self.curHeroId = heroVo:getDataVo().id
        self.curHeroTid = heroVo:getDataVo().tid
        self.curHeroVo = heroVo:getDataVo()
        self:updateTab()
        self:changeHero(0, self.curHeroId, self.curHeroTid)
        if self.mOnClickFun then
            self.mOnClickFun(self.curHeroTid)
        end
    end
end

function setType(self, cusTabType, cusArgs, cusIsDispatch)
    if (self.curPage and cusTabType ~= self.curPage) then
        self.args[self.curPage] = nil
    end
    super.setType(self, cusTabType, cusArgs, false)
    if (self.tabBar.curSelectPage == favorable.FavorableConst.HERO_FILE_INTERACT) then
        if not favorable.FavorableManager.mDetailShow3D then
            favorable.FavorableManager.mDetailShow3D = true
            self:updateModelView(self.curHeroVo)
            self:updateHeroNode()
            self:updatePic()
        end
    else
        if self.mAudioData then
            AudioManager:stopAudioSound(self.mAudioData)
            self:onShowHeroInTeractTextOnlyHandler(nil)
            self.mAudioData = nil
            self:playAction({ state = false })
        elseif self.mIsPlaying then
            self:onShowHeroInTeractTextOnlyHandler(nil)
            self:playAction({ state = false })
        end
    end
    self.mBtnChange:SetActive(self.tabBar.curSelectPage ~= favorable.FavorableConst.HERO_FILE_INTERACT)
end

function getTabViewParent(self)
    return self.mViewTrans
end

function getHeroList(self, index)
    self.heroList = hero.HeroManager:getAllSortList()
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
        local unGetCanComposeList, unGetUnComposeList = hero.HeroManager:getUnGetHeroList()
        unGetCanComposeList = showBoard.ShowBoardManager:getHeroScrollList(unGetCanComposeList, showBoard.panelSortType.COLOR, true, filterData.selectFilterDic, false, false, false, false)
        unGetUnComposeList = showBoard.ShowBoardManager:getHeroScrollList(unGetUnComposeList, showBoard.panelSortType.COLOR, true, filterData.selectFilterDic, false, false, false, false)
        for i = 1, #unGetCanComposeList do
            table.insert(list, 1, unGetCanComposeList[i])
        end
        for i = 1, #unGetUnComposeList do
            table.insert(list, unGetUnComposeList[i])
        end
        hero.HeroManager:setAllSortList(list)
        self.heroList = hero.HeroManager:getAllSortList()
    end

    if (index ~= nil) then
        return self.heroList[index]
    end
end

function onClickFavorHandler(self)
    -- self.selfClose = false
    self:setActiveArgs(self:getActiveArgs())
    -- hero.HeroManager:setPanelShowHeroId()
    favorable.FavorableManager.mRecordFavorChoose = true
    GameDispatcher:dispatchEvent(EventName.OPEN_FAVORABLE_PANEL)
end

function onClickChange3DHandler(self)
    favorable.FavorableManager.mDetailShow3D = not favorable.FavorableManager.mDetailShow3D
    self:updateModelView(self.curHeroVo)
    self:updatePic()
end

function getTabDatas(self)
    self.tabDataList = {}
    --table.insert(self.tabDataList, favorable.FavorableConst.HERO_DETAIL)
    table.insert(self.tabDataList, favorable.FavorableConst.HERO_STORY)
    --table.insert(self.tabDataList, favorable.FavorableConst.HERO_FILE_VOICE)
    --table.insert(self.tabDataList, favorable.FavorableConst.HERO_FILE_INTERACT)

    for i = 1, #self.tabDataList do
        local tabType = self.tabDataList[i]
        local content = favorable.FavorableConst.TAB_LIST2[tabType].nomalLan
        self.tabDataList[i] = { type = tabType, content = { content }, nomalIcon = favorable.getPageIcon(tabType), selectIcon = favorable.getPageIcon(tabType) }
    end
    return self.tabDataList
end

function getTabClass(self)
    --self.tabClassDic[favorable.FavorableConst.HERO_DETAIL] = hero.HeroDetailsSubPanel
    self.tabClassDic[favorable.FavorableConst.HERO_STORY] = favorable.FavorableStoryView
    --self.tabClassDic[favorable.FavorableConst.HERO_FILE_VOICE] = favorable.FavorableVoiceView
    --self.tabClassDic[favorable.FavorableConst.HERO_FILE_INTERACT] = favorable.FavorableActionView
    return self.tabClassDic
end

function updateTab(self)
    if self.mAudioData then
        AudioManager:stopAudioSound(self.mAudioData)
        self:onShowHeroInTeractTextOnlyHandler(nil)
        self.mAudioData = nil
    end
    -- if (self.curHeroId == nil) then
    --     self.tabBar:setPage(favorable.FavorableConst.HERO_DETAIL)
    --     self.tabBar:setHideItem({ favorable.FavorableConst.HERO_FILE_CASE, favorable.FavorableConst.HERO_FILE_VOICE, favorable.FavorableConst.HERO_FILE_INTERACT })
    -- else
        self.tabBar:setPage(favorable.FavorableConst.HERO_STORY)

        self.tabBar:setDefIsSelect(false)
    --    self.tabBar:setHideItem({ favorable.FavorableConst.HERO_DETAIL })
    --end
    self:updateView()
end

function updateView(self)
    self:updatePic()
    self:updateModelView(self.curHeroVo)
    self:updateBtnState(self.curHeroVo.tid)
    self:updateBubble()
    self:updateHeroInfo()
end

function updateHeroInfo(self)
    self.mTxtHeroName.text = self.curHeroVo.name
    self.mTxtCvName.text = self.curHeroVo.zhCVName
    self.mGroupFavorable:SetActive(self.curHeroVo.favorableLevel)
    if self.curHeroVo.favorableLevel then
        self.mTxtFavorableLv.text = self.curHeroVo.favorableLevel .. "级"
    end
    self.mIconEle:SetImg(UrlManager:getHeroEleTypeIconUrl(self.curHeroVo.eleType), true)
    self.mIconJob:SetImg(UrlManager:getHeroJobSmallIconUrl(self.curHeroVo.professionType), true)
end

function updatePic(self)
    local show3D = favorable.FavorableManager.mDetailShow3D
    if (show3D) then
        self.mImgHeroPic.gameObject:SetActive(false)
    else
        local model = self.curHeroVo:getHeroModel()
        self.mImgHeroPic:SetImg(UrlManager:getheroRecordUrl(model), true)
        self.mImgHeroPic.gameObject:SetActive(true)
        self:updateRoleNodeState(false)
    end
    local stateImg = favorable.FavorableManager.mDetailShow3D and UrlManager:getPackPath("heroFavorable/hero_favorable_34.png") or UrlManager:getPackPath("heroFavorable/hero_favorable_35.png")
    self.mImgChange:SetImg(stateImg, true)
end

function updateRoleNodeState(self, isShow)
    local modelNode = Perset3dHandler:getSceneShowData(MainCityConst.ROLE_MODE_CLIP).roleNodeTrans:Find("model" .. self.curHeroVo.model .. 'Root')
    if modelNode and self.mModelPlayer:getModelTrans() then
        modelNode.gameObject:SetActive(isShow)
    end
end

function getIndexByTid(self, tid)
    local index = 1
    if (self.heroList == nil) then
        self:getHeroList()
    end
    for i = 1, #self.heroList do
        if (self.heroList[i]:getDataVo().tid == tid) then
            index = i
            break
        end
    end
    return index
end

function updateBtnState(self, heroTid)
    if not heroTid then
        self.mBtnPre:SetActive(false)
        self.mBtnNext:SetActive(false)
        return
    end

    local index = self:getIndexByTid(self.curHeroTid)
    self.mBtnPre:SetActive(self.heroList[index - 1] ~= nil)
    self.mBtnNext:SetActive(self.heroList[index + 1] ~= nil)
end

--切换当前按钮状态  0:无语音播放 1：语音播放
function changeHero(self, state, heroId, heroTid)
    GameDispatcher:dispatchEvent(EventName.CHANGE_SHOW_HERO, { state = state, heroId = heroId, heroTid = heroTid })
end

function updateHeroNode(self)
    if (self.mModelPlayer:getModelTrans()) then
        self:updateRoleNodeState(favorable.FavorableManager.mDetailShow3D)
        if (favorable.FavorableManager.mDetailShow3D) then
            self.mModelPlayer.m_modelView:setModeType(MainCityConst.ROLE_MODE_CLIP)
        end
    end
    --self.gImgBg:SetActive(not favorable.FavorableManager.mDetailShow3D)
end

function setTabBar(self)
    if #self:getTabDataList() <= 0 then
        return
    end
    self.tabBar = CustomTabBar:create(self.mGroupTabItem, self.mTabBarNode, self.onClickMenuHandler, self, nil, "TabViewTabBar")
    self.tabBar:setData(self:getTabDataList())
end

function updateModelView(self, heroVo, type)
    if (heroVo and (favorable.FavorableManager.mDetailShow3D or not self.mIsFirstShow)) then
        local model = heroVo:getUIModel()
        if type == 2 then
            self.mModelPlayer:setModelData(model, false, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, nil, self.mClickerArea, true)
        else
            self.mModelPlayer:setModelData(model, false, true, 1, true, MainCityConst.ROLE_MODE_CLIP, nil, self.mClickerArea, true, function()
                if not self.mIsFirstShow then
                    self.mIsFirstShow = true
                end
                self:updateHeroNode()
            end)
        end
    else
        self:recoverModel(false)
    end
end

function playAction(self, args)
    if self.mModelPlayer then
        if args.state then
            self:destroyTimeSn()
            self.mModelPlayer.m_modelView:playAction(gs.Animator.StringToHash(args.actName))
            local cvData = AudioManager:getCVData(args.cvId)
            self:onShowHeroInTeractTextOnlyHandler(cvData.lines)
            self.mModelPlayer.m_modelView:getAniLenght(args.actName, function(length)
                favorable.FavorableManager:setNowActionTime(length)
                GameDispatcher:dispatchEvent(EventName.UPDATE_FAVORABLE_ACTIONSTART, args.actName)
            end)
            if (args.startCall) then
                args.startCall()
            end

            if self.mVoiceSn then
                LoopManager:removeTimerByIndex(self.mVoiceSn)
                self.mVoiceSn = nil
            end
            local baseData = hero.HeroInteractManager:getConfigData01(self.curHeroVo.model, nil, args.actName)
            self.mIsPlaying=true
            self.mVoiceSn = LoopManager:addTimer(math.max(hero.HeroInteractManager:getCvDataLayBack(baseData), 0.1), 1, self, function()
                if AudioManager:preloadCvByCvId(args.cvId) then
                    self.mAudioData = AudioManager:playHeroCVOnReplace(args.cvId, function()
                        self.mAudioData = nil
                        self.mIsPlaying=false
                        self:onShowHeroInTeractTextOnlyHandler(nil)
                    end)
                else
                    self.mTimeSn = LoopManager:setTimeout(5, self, function (instance)
                        instance:destroyTimeSn()
                        instance.mAudioData = nil
                        instance.mIsPlaying=false
                        instance:onShowHeroInTeractTextOnlyHandler(nil)
                    end)
                end
            end)
        else
            self.mIsPlaying=false
            self.mModelPlayer.m_modelView:playAction(self.mAlwayHash)
            if self.mAudioData then
                AudioManager:stopAudioSound(self.mAudioData)
                self:onShowHeroInTeractTextOnlyHandler(nil)
                self.mAudioData = nil
            end
            if self.mVoiceSn then
                LoopManager:removeTimerByIndex(self.mVoiceSn)
                self.mVoiceSn = nil
            end
            favorable.FavorableManager:setNowActionTime(0)
            if (args.finishCall) then
                args.finishCall()
            end
        end
    end
end

-- cv台词文本
function onShowHeroInTeractTextOnlyHandler(self, textContent)
    if textContent and textContent ~= "" then
        self.mTxtTalk.text = textContent
        self.mImgTalkBg:SetActive(true)
        TweenFactory:canvasGroupAlphaTo(self.mTalkBgCanvas, 0, 1, 0.4)
    else
        TweenFactory:canvasGroupAlphaTo(self.mTalkBgCanvas, 1, 0, 0.4)
        self.mImgTalkBg:SetActive(false)
    end
end

function updateBubble(self, heroVo)
    if (self.curHeroId == nil) then
        return
    end
    local flag = favorable.FavorableManager:getCaseRewardHasRed(self.curHeroId)
    if flag then
        self:addBubble(favorable.FavorableConst.HERO_FILE_CASE, 57.3, 12.8)
    else
        self:removeBubble(favorable.FavorableConst.HERO_FILE_CASE)
    end
end

-----------------------------------------摄像机相关操作------------------------------------------------
-- 镜头往返切换
function deepCamera(self, PosX, Time)
    if self.mTween then
        self.mTween:Kill()
    end
    self.sceneCameraTrans = gs.CameraMgr:GetDefSceneCameraTrans()
    self.mTween = TweenFactory:move2LPosX(self.sceneCameraTrans, PosX, Time, nil, function()
        self.mCameraPosX = PosX
    end)
end
--居中
function onClickBackCenterHandler(self)
    -- self:deepCamera(-0.5, 1)
    self:recoverModel(false)
    self:updateModelView(self.curHeroVo, 2)
end
-- 返回原位
function onClickMoveLeftHandler(self)
    -- self:deepCamera(0, 1)
    self:recoverModel(false)
    self:updateModelView(self.curHeroVo, 1)
end

function recoverModel(self, isResetMaincity)
    self.mModelPlayer:reset(isResetMaincity)
end

function destroyTimeSn(self)
    if self.mTimeSn then
        LoopManager:clearTimeout(self.mTimeSn)
        self.mTimeSn = nil
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]