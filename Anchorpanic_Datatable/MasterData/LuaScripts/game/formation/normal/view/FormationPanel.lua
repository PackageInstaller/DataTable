module("formation.FormationPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("formation/FormationPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
formationType = 1 -- 1备战 2 怪物信息
isShowBlackBg = 0 -- 是否显示全屏纯黑防穿帮底图

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(72107))
    self:setBg("", false)
    self:setUICode(LinkCode.HeroTeam)
end

-- 初始化数据
function initData(self)
    self.m_teamId = nil
    self.m_formationId = nil
    self.m_myAllHeroTidList = nil
    self.mItemList = {}
    self.mArrowStateKey = "FormationPanelHeroListState1"
    self.mMaxHeight = 372
    self.mMinHeight = 0 -- 60.27
    self.mStarItemList = {}
    self.mWeaknessGrid = {}
    self.mIsSelectHero = false

    -- 0<=A<20,杂项5401
    self.mRecommandLvData = {
        { 0, 20, 5401 },
        { 20, 40, 5402 },
        { 40, 60, 5403 },
        { 60, 80, 5404 },
        { 80, 100, 5405 }
    }
end

function getManager(self)
    return self.m_manager
end

function setManager(self, cusManager)
    self.m_manager = cusManager
end

function configUI(self)
    self.mCanvasGroup = self:getChildGO("mGroupNode"):GetComponent(ty.CanvasGroup)
    self.mArrowLeft = self:getChildGO("mArrowLeft")
    self.mArrowLeftCanvGroup = self.mArrowLeft:GetComponent(ty.CanvasGroup)
    self.mBtnSave = self:getChildGO("mBtnSave")
    self.mImgEleBg = self:getChildGO("mImgEleBg")
    self.mArrowRight = self:getChildGO("mArrowRight")
    self.mArrowRightCanvGroup = self.mArrowRight:GetComponent(ty.CanvasGroup)
    self.mTeamList = self:getChildTrans("mTeamList")
    self.mBtnFuncTips = self:getChildGO("mBtnFuncTips")
    self.mRecommandLv = self:getChildGO("mRecommandLv")
    self.mClearDetail = self:getChildGO("mClearDetail")
    self.mImgDevelop = self:getChildTrans("mImgDevelop")
    self.mRecommandFight = self:getChildGO('mRecommandFight')
    self.mImgDevelopLine = self:getChildGO("mImgDevelopLine")
    self.mRecommandEnableBg = self:getChildGO('mRecommandEnableBg')
    self.mRecommandFormation = self:getChildTrans("mRecommandFormation")
    -- self.m_textFight = self:getChildGO('mTxtFight'):GetComponent(ty.Text)
    self.m_textTitle = self:getChildGO('mTxtTitle'):GetComponent(ty.Text)
    self.mTxtDevelop = self:getChildGO("mTxtDevelop"):GetComponent(ty.Text)
    self.mRecommandBg = self:getChildGO('mRecommandBg'):GetComponent(ty.Image)
    self.mTxtRecommand = self:getChildGO('mTxtRecommand'):GetComponent(ty.Text)
    self.mTxtRecommandLv = self:getChildGO('mTxtRecommandLv'):GetComponent(ty.Text)
    self.mTxtRecommandFight = self:getChildGO('mTxtRecommandFight'):GetComponent(ty.Text)
    self.mImgMiniFormation = self:getChildGO('mImgMiniFormation'):GetComponent(ty.AutoRefImage)
    self.mBtnCloseFormation = self:getChildGO("mBtnCloseFormation")

    -- 队列切卡
    self.mTeamNode = self:getChildGO("mTeamNode")
    self.m_teamScrollGo = self:getChildGO('mTeamScroller')
    self.mImgArrowUp = self:getChildGO("mImgArrowUp")
    self.mImgArrowDown = self:getChildGO("mImgArrowDown")
    self.m_teamScroll = self.m_teamScrollGo:GetComponent(ty.LyScroller)
    self.mScrollerRect = self.m_teamScrollGo:GetComponent(ty.ScrollRect)
    self.mEventTrigger = self.m_teamScroll:GetComponent(ty.LongPressOrClickEventTrigger)
    self.m_teamScroll:SetItemRender(formation.FormationTeamItem)
    -- 阵型
    self.mScrollerSelectTrans = self:getChildTrans('mScrollerSelect')
    self.mScrollerSelect = self:getChildGO('mScrollerSelect'):GetComponent(ty.LyScroller)
    self.mFormationScrollerRect = self.mScrollerSelectTrans:GetComponent(ty.ScrollRect)
    self.mScrollerSelect:SetItemRender(formation.FormationSelectItem)

    self.mBtnAssist = self:getChildGO('mBtnAssist')
    self.mBtnControl = self:getChildGO('mBtnControl')
    self.mBtnCaptain = self:getChildGO('mBtnCaptain')
    self.mBtnFormation = self:getChildGO('mBtnFormation')
    self.mBtnDevelop = self:getChildGO('mBtnDevelop')
    -- 宠物
    self.mPetNode = self:getChildTrans("mPetNode")

    -- 拖拽线
    self.m_goLine = self:getChildGO('mImgLine')
    self.m_transLine = self:getChildTrans('mImgLine')

    self.mBtnElement = self:getChildGO("mBtnElement")
    self.mBtnEnemyInfo = self:getChildGO("mBtnEnemyInfo")

    self.mBtnTarget = self:getChildGO("mBtnTarget")
    self.mBtnPosEff = self:getChildGO("mBtnPosEff")
    self.mTxtPosEff = self:getChildGO("mTxtPosEff"):GetComponent(ty.Text)
    self.mHeroDevelopNode = self:getChildTrans("mHeroDevelopNode")
    self.mImgLock = self:getChildGO("mImgLock")
    self.mImgLock:SetActive(false)
    self.mBtnPosEff:SetActive(false)
    self.mBtnTarget:SetActive(false)
    self.mNowSelectFormation = self:getChildGO("mNowSelectFormation")
    self.mNowImgIcon = self:getChildGO("mNowImgIcon"):GetComponent(ty.AutoRefImage)
    self.mGroupMove = self:getChildTrans("mGroupMove")
    self.mMoveNode = self:getChildTrans("mMoveNode")

    -- 环境
    self.mEleTipGroup = self:getChildGO("mEleTipGroup")
    -- self.mEleSkillBg = self:getChildGO("mEleSkillBg"):GetComponent(ty.AutoRefImage)
    -- self.mEleSkillIcon = self:getChildGO("mEleSkillIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtEleSkillName = self:getChildGO("mTxtEleSkillName"):GetComponent(ty.Text)
    self.mTxtEleSkillDes = self:getChildGO("mTxtEleSkillDes"):GetComponent(ty.Text)
end

function active(self, args)
    Perset3dHandler:setupShowData(MainCityConst.ROLE_MODE_FORMATION, nil, nil, "")
    super.active(self, args)
    MoneyManager:setMoneyTidList()
    -- TextureCameraHandler:open()
    self:setManager(args.manager)
    self:getManager():addEventListener(self:getManager().HERO_TEAM_SEE, self.__onTeamSelectHandler, self)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_SEE, self.__onFormationSelectHandler, self)
    self:getManager():addEventListener(self:getManager().UPDATE_TEAM_FORMATION_DATA,
    self.__onFormationDataUpdateHandler, self)
    self:getManager():addEventListener(self:getManager().UPDATE_FIGHT_TEAM_ID, self.__checkUpdateTeamView, self)
    self:getManager():addEventListener(self:getManager().UPDATE_TEAM_NAME, self.__checkUpdateTeamView, self)
    self:getManager()
    :addEventListener(self:getManager().UPDATE_TEAM_FORMATION_ID, self.__checkUpdateFormationView, self)
    self:getManager():addEventListener(self:getManager().UPDATE_TEAM_CAPTAIN_ID, self.__checkUpdateCaptainView, self)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_TILE_SELECT, self.__onClickFormationTileHandler,
    self)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_TILE_POINTER_DOWN,
    self.__onPointerDownFormationTileHandler, self)
    self:getManager():addEventListener(self:getManager().HERO_FORMATION_TILE_POINTER_UP,
    self.__onPointerUpFormationTileHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_FORMATION_HEROLIST, self.onRestoreArrowHandler, self)
    hero.HeroFlagManager:addEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.updateTeamFlag, self)
    self.mNowSelectFormation:SetActive(false)
    self.mGroupMove.gameObject:SetActive(true)

    self.m_teamId = self.m_teamId and self.m_teamId or self:getManager():getFightTeamId()
    if (not self.m_teamId) then
        Debug:log_error("FormationPanel", "出战队列id错误")
        return
    end
    self.m_formationId = self.m_formationId and self.m_formationId or self:getManager():getFightFormationId()

    if (not self.m_formationId) then
        Debug:log_error("FormationPanel", "出战阵型id错误")
        return
    end

    self:__checkUpdateView()

    -- local isShow = StorageUtil:getBool1(self.mArrowStateKey)
    local isShow = true
    if StorageUtil:getNumber1(self.mArrowStateKey) == 2 then
        -- 默认打开，0和1 为true
        isShow = false
    end
    self:onRestoreArrowHandler(isShow)
    formation.FormationManager:setSelectFormationTeamId(self.m_teamId)
    gs.RenderSettings.fog = false
    self.IS_CHECK_FOR_CLOSE = true
    gs.CameraMgr:GetDefSceneCamera().gameObject:SetActive(true)
    self.mRecommandLv:SetActive(self.mBtnSave.activeSelf ~= true)
    self.mClearDetail:SetActive(false)
    self.mBtnCloseFormation:SetActive(false)
    self.mEleTipGroup:SetActive(false)
    local camera = gs.CameraMgr:GetDefSceneCamera()
    self.flipComponent = camera:GetComponent(ty.FlipCameraComponent)
    self.flipComponent:SetFlipHorizontal(false)
end

function deActive(self)
    self:clearEffPrefab()
    super.deActive(self)
    self:getManager():resetFilterDic()
    self:recoverPetItem()
    MoneyManager:setMoneyTidList()
    -- TextureCameraHandler:close()
    self:getManager():removeEventListener(self:getManager().HERO_TEAM_SEE, self.__onTeamSelectHandler, self)
    self:getManager():removeEventListener(self:getManager().HERO_FORMATION_SEE, self.__onFormationSelectHandler, self)
    self:getManager():removeEventListener(self:getManager().UPDATE_TEAM_FORMATION_DATA, self.__onFormationDataUpdateHandler, self)
    self:getManager():removeEventListener(self:getManager().UPDATE_FIGHT_TEAM_ID, self.__checkUpdateTeamView, self)
    self:getManager():removeEventListener(self:getManager().UPDATE_TEAM_NAME, self.__checkUpdateTeamView, self)
    self:getManager():removeEventListener(self:getManager().UPDATE_TEAM_FORMATION_ID, self.__checkUpdateFormationView, self)
    self:getManager():removeEventListener(self:getManager().UPDATE_TEAM_CAPTAIN_ID, self.__checkUpdateCaptainView, self)
    self:getManager():removeEventListener(self:getManager().HERO_FORMATION_TILE_SELECT, self.__onClickFormationTileHandler, self)
    self:getManager():removeEventListener(self:getManager().HERO_FORMATION_TILE_POINTER_DOWN, self.__onPointerDownFormationTileHandler, self)
    self:getManager():removeEventListener(self:getManager().HERO_FORMATION_TILE_POINTER_UP, self.__onPointerUpFormationTileHandler, self)

    GameDispatcher:removeEventListener(EventName.OPEN_FORMATION_HEROLIST, self.onRestoreArrowHandler, self)
    hero.HeroFlagManager:removeEventListener(hero.HeroFlagManager.FLAG_UPDATE, self.updateTeamFlag, self)
    self.m_sceneController:clearMap()
    gs.RenderSettings.fog = true
    self.mRecommandFight:SetActive(false)
    self:recoverEleGrid()
    self:getManager():dispatchEvent(self:getManager().CLOSE_FORMATION_HERO_SELECT_PANEL)
    self.mEventTrigger.onBeginDrag:RemoveAllListeners()
    self.mEventTrigger.onDrag:RemoveAllListeners()
    self.mEventTrigger.onEndDrag:RemoveAllListeners()
    gs.TransQuick:SizeDelta02(self.mScrollerSelectTrans, self.mMaxHeight)
    self.mScrollerSelect:CleanAllItem()
    RedPointManager:remove(self.mPetNode.transform)
    if (self.m_frameSn) then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
        self.m_goLine:SetActive(false)
    end

    if self.mCameraTween then
        self.mCameraTween:Kill()
    end
end

function initViewText(self)
    self:setBtnLabel(self.mBtnElement, 3069, "源能同调")
    self:setBtnLabel(self.mBtnControl, 1292, "出战")
    self:setBtnLabel(self.mBtnFormation, 1293, "当前阵型")
    self.mTxtDevelop.text = _TT(1294) -- "战员\n培养"
    self:setBtnLabel(self.mBtnEnemyInfo, nil, "敌方信息")
    self:setBtnLabel(self.mBtnPosEff, 3075, "战场环境")
    self.mTxtRecommand.text = "推荐阵容"
    self.m_textTitle.text = _TT(1283)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnControl, self.__onClickBtnControlHandler,
    UrlManager:getUIBaseSoundPath("ui_basic_battle.prefab"))
    self:addUIEvent(self.mBtnCaptain, self.__onClickCaptainHandler)
    self:addUIEvent(self.mBtnFormation, self.__onClickFormationHandler)
    self:addUIEvent(self.mBtnCloseFormation, self.onClickBtnClose)
    self:addUIEvent(self.mBtnDevelop, self.onRestoreArrowHandler)
    self:addUIEvent(self.mBtnAssist, self.__onClickBtnAssistHandler)
    self:addUIEvent(self.mBtnFuncTips, self.onClickFuncTipsHandler)
    self:addUIEvent(self.mBtnElement, self.onBtnClickElementHandler)
    self:addUIEvent(self.mBtnEnemyInfo, self.onClickEnemyInfoHandler)
    self:addUIEvent(self.mBtnPosEff, self.onClickPosEffInfoHandler)
    self:addUIEvent(self.mBtnTarget, self.onClickTargetInfoHandler)

    self:addUIEvent(self.mArrowLeft, self.onChangePreTeamHandler)
    self:addUIEvent(self.mArrowRight, self.onChangeNextTeamHandler)
    self:addUIEvent(self.mNowSelectFormation, self.__onClickFormationHandler)
    self:addUIEvent(self.mRecommandLv, self.onOpenRecommandTips)
    function dragBegin()
        TweenFactory:canvasGroupAlphaTo(self.mArrowLeftCanvGroup, 1, 0, 0.5)
        TweenFactory:canvasGroupAlphaTo(self.mArrowRightCanvGroup, 1, 0, 0.5)
    end
    self.mEventTrigger.onBeginDrag:AddListener(dragBegin)

    function drag()
        local posX = self.mTeamList.transform.localPosition.x
        local index = math.floor((-(posX + 250.6)) / 215 + 1.9)
        local teamId = self:getManager():getAllTeamIdList()[index]
        self:onChangeTeamHandler(teamId, false)
    end
    self.mEventTrigger.onDrag:AddListener(drag)

    function dragEnd()
        local endPosX = self.mTeamList.transform.localPosition.x
        local index = math.floor((-(endPosX + 250.6)) / 215 + 1.9)
        local teamId = self:getManager():getAllTeamIdList()[index]
        self:onChangeTeamHandler(teamId)
        self:teewnIndex()

        TweenFactory:canvasGroupAlphaTo(self.mArrowLeftCanvGroup, 0, 1, 0.5)
        TweenFactory:canvasGroupAlphaTo(self.mArrowRightCanvGroup, 0, 1, 0.5)
    end
    self.mEventTrigger.onEndDrag:AddListener(dragEnd)
end

function onClickBtnClose(self)
    self.mBtnCloseFormation:SetActive(false)
    self.mEleTipGroup:SetActive(false)
    self:__updateTeamList(false)
    if self.mFormationScrollerRect.enabled then
        self:__onClickFormationHandler()
    end
end

function updateTarget(self)
    local dupVo = self:getDupVo()
    if dupVo ~= nil and dupVo.targetList then
        self.mBtnTarget:SetActive(true)
    else
        self.mBtnTarget:SetActive(false)
    end
end

function updatePosEff(self)
    self:clearEffPrefab()
    local dupVo = self:getDupVo()

    if dupVo ~= nil and dupVo.posEffectId and #dupVo.posEffectId > 0 then

        self.posEffectIds = dupVo.posEffectId
        self.heroEffId = dupVo.posEffectId[1]
        self.enemyEffId = dupVo.posEffectId[2]
        -- local camera = gs.CameraMgr:GetDefSceneCamera()
        -- self.flipComponent = camera:GetComponent(ty.FlipCameraComponent)
        -- self.flipComponent:SetFlipHorizontal(false)

        if not table.empty(self.posEffectIds) then
            self:updatePosEffPrefab()
        end
        self.mBtnPosEff:SetActive(true)
    else
        self.mBtnPosEff:SetActive(false)
    end
end

function updatePosEffPrefab(self)
    for i, id in ipairs(self.posEffectIds) do
        local posEffVo = self:getManager():getPosEffConfigData(id)
        if posEffVo.size == 1 and posEffVo.posList[1] ~= 0 then
            for i = 1, #posEffVo.posList do
                local parentTrans = self.m_sceneController:getDeactiveTile(posEffVo.col[i], posEffVo.row[i]).transform

                local effPrefab = AssetLoader.GetGO(UrlManager:get3DBuffPath(posEffVo.mEffectPrefabIcon[i]))
                effPrefab.transform:SetParent(parentTrans, false)

                local isEmpty = formation.FormationSceneController:isEmpty(posEffVo.col[i], posEffVo.row[i])

                local renderArray = gs.GoUtil.GetRendererComsInChildren(effPrefab)
                local len = renderArray.Length - 1
                for i = 0, len do
                    local materials = renderArray[i].materials
                    local materialLen = materials.Length - 1
                    for i = 0, materialLen do
                        materials[i]:SetColor("_TintColor", isEmpty and gs.COlOR_GREY or gs.COlOR_WHITE)
                    end
                end

                if isEmpty == false then
                    local effBuffPrefab = AssetLoader.GetGO(UrlManager:get3DBuffPath(posEffVo.mEffectPrefabBuff[i]))
                    effBuffPrefab.transform:SetParent(parentTrans, false)
                    table.insert(self.mHasHeroEffList, effBuffPrefab)
                end

                table.insert(self.mDefPosEffList, effPrefab)
            end
        end
    end
end

function clearEffPrefab(self)
    if self.mDefPosEffList then
        for i = 1, #self.mDefPosEffList do
            gs.GameObject.Destroy(self.mDefPosEffList[i])
        end
    end

    if self.mHasHeroEffList then
        for i = 1, #self.mHasHeroEffList do
            gs.GameObject.Destroy(self.mHasHeroEffList[i])
        end
    end

    self.mDefPosEffList = {}
    self.mHasHeroEffList = {}
end

function onChangePreTeamHandler(self)
    local index = table.indexof01(self:getManager():getAllTeamIdList(), self.m_teamId)
    local preTeam = self:getManager():getAllTeamIdList()[index - 1]
    self:onChangeTeamHandler(preTeam)
end

function onChangeNextTeamHandler(self)
    local index = table.indexof01(self:getManager():getAllTeamIdList(), self.m_teamId)
    local nextTeam = self:getManager():getAllTeamIdList()[index + 1]
    self:onChangeTeamHandler(nextTeam)
end

function onChangeTeamHandler(self, teamId, isTween)
    local manager = self:getManager()
    if (manager:getTeamIdIndex(teamId) > 1) then
        if (not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_EXCEPT_FIRST_TEAM, true)) then
            return
        end
    end
    manager:dispatchEvent(manager.HERO_TEAM_SEE, {
        teamId = teamId,
        isTween = isTween
    })
end

function onClickPosEffInfoHandler(self)
    self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_POSEFF, {
        posEffIds = self.posEffectIds,
        manager = self:getManager()
    })
    self.mEleTipGroup:SetActive(false)
    self.mBtnCloseFormation:SetActive(false)
end

function onClickTargetInfoHandler(self)
    local dupVo = self:getDupVo()
    self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_TARGET, {
        vo = dupVo,
        manager = self:getManager()
    })

    self.mEleTipGroup:SetActive(false)
    self.mBtnCloseFormation:SetActive(false)
end

-- 点击元素同调
function onBtnClickElementHandler(self)
    local heroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_ELEMENT, {
        teamId = self.m_teamId,
        formationId = self.m_formationId,
        heroList = heroList
    })
end

function getDupVo(self)
    return self:getManager():getDupVo()
end

function onClickEnemyInfoHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, {
        dupVo = self:getDupVo()
    })
end

function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, {
        id = LinkCode.HeroTeam
    })
end

function onOpenRecommandTips(self)
    TipsFactory:RecommendTips({ data = tips.TipsManager:getRecommandData()[1] })
end

-- 玩家点击关闭
function onClickClose(self)
    if self.mIsSelectHero then
        self:getManager():dispatchEvent(self:getManager().CLOSE_FORMATIONHERO_CHOOSE)
        self.mIsSelectHero = false
        return
    end
    if not self.isCanClickClose then
        return
    end
    self:__playerClose()
    super.onClickClose(self)
    self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
    self:__playerClose()
    super.onCloseAllCall(self)
    self:getManager():runCallBack(formation.CALL_FUN_REASON.PLAYER_CLOSE_ALL)
end

function __playerClose(self)
    self:recoverHeadItems()
    self:recoverEleGrid()
    self:initData()
    -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
    self:rsyncFormationList(true)
    self:getManager():setSelectFormationTeamId(nil)
    formation.FormationManager:resetPetTempList()
end

function forceClose(self)
    -- 设置标识触发关闭函数是否检查
    self.IS_CHECK_FOR_CLOSE = false
    -- self:closeAll()
end

function close(self, isClearData)
    if self.mIsSelectHero then
        return
    end
    if (isClearData) then
        self:initData()
    end
    super.close(self)
end

function rsyncFormationList(self, isClearOther)
    if (self.IS_CHECK_FOR_CLOSE) then
        if (isClearOther ~= false) then
            self:getManager():clearAllTeamOtherHero()
        end
        self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
    end
end

-- 阵型瓦片点击事件
function __onClickFormationTileHandler(self, args)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FORMATION_MOVE, true) == false then
        return
    end

    if args == nil then
        return
    end

    local isLock, id = self:getManager():getFormationTileLock(self.m_formationId, args.col, args.row)

    if isLock == true and id > 0 then
        local stageVo = battleMap.MainMapManager:getStageVo(id)
        gs.Message.Show(_TT(47, stageVo.indexName))
        return
    end

    if (self:isLoadFinish() and not self.mTweening) then
        local colIndex = args.col
        local rowIndex = args.row
        -- 获取配置里的可以上阵的格子次序位置
        local heroPos = self:getManager():getFormationTilePos(self.m_formationId, colIndex, rowIndex)
        -- 是否可以上阵的格子
        if (heroPos > 0) then
            self.mCanvasGroup.alpha = 0
            self.mCanvasGroup.gameObject:SetActive(false)
            self.m_sceneController:showChooseVFX(colIndex, rowIndex)
            if not self.mIsSelectHero then
                self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_HERO_SELECT_PANEL, {
                    teamId = self.m_teamId,
                    formationId = self.m_formationId,
                    rowIndex = rowIndex,
                    colIndex = colIndex,
                    closeCall = {
                        target = self,
                        func = self.recoverCanvasGroup,
                        group = self.mGroupMove
                    }
                })
                if self.mHeroDevelopNode.gameObject.activeSelf then
                    TweenFactory:move2LPosX(self.mGroupMove, self.mGroupMove.localPosition.x - 270, 0.3, gs.DT.Ease.Linear)
                end
                local cameraTrans = gs.CameraMgr:GetDefSceneCameraTrans()
                self.mCameraTween = cameraTrans:DOLocalMove(gs.Vector3(2, 0, 0), 0.5)
                self.m_selectMousePos = nil
                self.m_goLine:SetActive(false)
            else
                self:onClickBtnClose()
                GameDispatcher:dispatchEvent(EventName.REFRESH_FORMATION_HERO_SELECT, {
                    teamId = self.m_teamId,
                    formationId = self.m_formationId,
                    rowIndex = rowIndex,
                    colIndex = colIndex,
                    closeCall = {
                        target = self,
                        func = self.recoverCanvasGroup,
                        group = self.mGroupMove
                    }

                })
            end
            self.mIsSelectHero = true
        end

        local effectId, bgUrl, icon = self:getManager():getPosHasEffect(self.heroEffId, colIndex, rowIndex)
        if effectId then
            self.mEleTipGroup:SetActive(true)
            self.mBtnCloseFormation:SetActive(true)
            self.mTeamNode:SetActive(false)
            local buffVo = fight.SkillManager:getSkillRo(effectId)
            self.mTxtEleSkillName.text = buffVo.m_name
            self.mTxtEleSkillDes.text = buffVo.m_desc
        end
    end
end

function recoverCanvasGroup(self)
    self.mIsSelectHero = false
    self.mTweening = true
    self.mBtnCloseFormation:SetActive(false)
    self:onClickBtnClose()
    self.m_sceneController:hideChooseVFX()
    self.mEleTipGroup:SetActive(false)
    self.mCanvasGroup.gameObject:SetActive(true)
    self.mCanvasGroup.alpha = 1
    -- TweenFactory:canvasGroupAlphaTo(self.mCanvasGroup, 0, 1, 0.7, gs.DT.Ease.Linear)
    self.mGroupMove:SetParent(self.mMoveNode, false)
    if self.mHeroDevelopNode.gameObject.activeSelf then
        TweenFactory:move2LPosX(self.mGroupMove, self.mGroupMove.localPosition.x + 270, 0.3, gs.DT.Ease.Linear,
        function()
            self.mGroupMove:SetAsFirstSibling()
            self.mBtnCloseFormation.transform:SetAsFirstSibling()
            self.mTweening = false
        end)
    else
        self.mGroupMove:SetAsFirstSibling()
        self.mBtnCloseFormation.transform:SetAsFirstSibling()
        self.mTweening = false
    end

    local cameraTrans = gs.CameraMgr:GetDefSceneCameraTrans()
    self.mCameraTween = cameraTrans:DOLocalMove(gs.Vector3(0, 0, 0), 0.5)

end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if (count <= 0) then
        gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))
    else
        local function run()
            -- 可能会有援助的怪物，必要同步
            self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
            -- 设置出战队列
            self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {
                teamId = self.m_teamId
            })
            -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
            self:forceClose()
            -- 回调外部
            self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
            -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
            self:rsyncFormationList(true)
        end

        if self:getDupVo() then
            local recommandFight = self:getDupVo().suggestLevel[2] -- 推荐等级
            if (recommandFight == nil or recommandFight <= 0) then
                run()
            else
                local isShowTips = false
                local fight = self:getFormationAvgLv()
                for i, v in pairs(self.mRecommandLvData) do
                    if v[1] <= recommandFight and v[2] > recommandFight then
                        local value = sysParam.SysParamManager:getValue(v[3])
                        isShowTips = (recommandFight - fight) >= value
                        break
                    end
                end
                isShowTips = isShowTips or (count < (#self:getDupVo().enemyList - sysParam.SysParamManager:getValue(SysParamType.FORMATION_TIP_OTHER_JUG)))
                if (isShowTips) then
                    UIFactory:alertMessge(_TT(1366), true, function()
                        run()
                    end, _TT(1), nil, true, function()
                    end, _TT(2), _TT(5), nil, RemindConst.FORMATION_FIGHT)
                else
                    run()
                end
            end
        else
            run()
        end
    end
end

-- 队列选择改变
function __onTeamSelectHandler(self, args)
    local teamId = args.teamId
    local isTween = args.isTween
    if (self.m_teamId ~= teamId) then
        self.m_teamId = teamId
        formation.FormationManager:setSelectFormationTeamId(teamId)
        --self:updateEleEff()
        self:updateLoopEleEff()
        if (self:isLoadFinish()) then
            -- gs.Message.Show("队列："..self.m_teamId)
            self.m_formationId = self:getManager():getFightFormationId(self.m_teamId)
            self:__updateView(false, isTween)
            self:onRestoreHandler(true)
        end
    end
end

-- 阵型选择改变
function __onFormationSelectHandler(self, args)
    local formationId = args.formationId
    if (formationId == self:getManager():getFightFormationId(self.m_teamId)) then
        -- gs.Message.Show(_TT(1285))
        self:__onClickFormationHandler()
        -- self.mEleTipGroup:SetActive(false)
    else
        self.m_formationId = formationId
        self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_CHANGE, {
            teamId = self.m_teamId,
            formationId = self.m_formationId
        })
        --self:updateEleEff()
        self:updateLoopEleEff()
        self:onRestoreHandler(true)
        self:getManager():dispatchEvent(self:getManager().CLOSE_FORMATIONHERO_CHOOSE)
    end
end

-- 阵型相关数据改变
function __onFormationDataUpdateHandler(self, args)
    if args.targetPos then
        local row, col = self:getManager():getFormationTileRowCol(self.m_formationId, args.targetPos)
        if self:getManager():getFormationHeroVoByPos(self.m_teamId, args.targetPos) == nil then
            self.m_sceneController:showExitVFX(col, row)
        else
            self.m_sceneController:showHandoffVFX(col, row)
        end

        self:updateEleEff(false)
    end
    self:__updateView(false, false)
end

function updateLoopEleEff(self)
    self.m_sceneController:closeEffLoopPrefab()
    local heroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local eleCountList = {}
    for i = 0, 5 do
        eleCountList[i] = { count = 0, list = {} }
    end
    for k, v in pairs(heroList) do
        local heroVo = hero.HeroManager:getHeroVo(v.heroId)
        if heroVo then
            eleCountList[heroVo.eleType].count = eleCountList[heroVo.eleType].count + 1
            table.insert(eleCountList[heroVo.eleType].list, v)
        end
    end

    for k, v in pairs(eleCountList) do
        if v.count >= 2 then
            for i = 1, #v.list do
                local value = v.list[i]
                local vo = self:getManager():getFormationHeroVoById(self.m_teamId, value.heroId)
                local row, col = self:getManager():getFormationTileRowCol(self.m_formationId, vo.heroPos)
                self.m_sceneController:playEffLoopPrefab(col, row, k, v.count)
            end
        end
    end
end

function updateEleEff(self, isInit)
    self.m_sceneController:clearEffPrefab()

    local heroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local eleCountList = {}
    for i = 0, 5 do
        eleCountList[i] = { count = 0, list = {} }
    end
    for k, v in pairs(heroList) do
        local heroVo = hero.HeroManager:getHeroVo(v.heroId)
        if heroVo then
            eleCountList[heroVo.eleType].count = eleCountList[heroVo.eleType].count + 1
            table.insert(eleCountList[heroVo.eleType].list, v)
        end
    end

    --现在改成了仅元素同调发生变化并激活时才显示对应的元素同调
    local changeEle = {}
    local noChange = true
    if self.oldEle then
        for k, v in pairs(self.oldEle) do
            if v.count ~= eleCountList[k].count and (eleCountList[k].count == 2 or eleCountList[k].count == 3) then
                table.insert(changeEle, k)
            end
        end
    end

    self.oldEle = eleCountList
    for i = 1, #changeEle do
        local key = changeEle[i]
        local list = eleCountList[key].list
        for i = 1, #list do
            local value = list[i]
            local vo = self:getManager():getFormationHeroVoById(self.m_teamId, value.heroId)
            local row, col = self:getManager():getFormationTileRowCol(self.m_formationId, vo.heroPos)
            self.m_sceneController:playEffPrefab(col, row, key)
        end
    end

    self:updateLoopEleEff()
    -- if noChange == false and isInit == false then
    --     for k, v in pairs(eleCountList) do
    --         if v.count >= 2 then
    --             for i=1,# v.list do
    --                 local vo =self:getManager(): getFormationHeroVoById(self.m_teamId,v.list[i].heroId)
    --                 local row,col =self:getManager():getFormationTileRowCol(self.m_formationId, vo.heroPos)
    --                 self.m_sceneController:playEffPrefab(col,row,k)
    --             end
    --         end
    --     end
    -- end
end

-- 打开队长界面
function __onClickCaptainHandler(self)
    local isHasOtherCaptain = false
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    for _, formationHeroVo in pairs(formationHeroList) do
        if (not formationHeroVo.isCaptainHero) then
            isHasOtherCaptain = true
            break
        end
    end
    if (isHasOtherCaptain) then
        self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_CAPTAIN_SELECT_PANEL, {
            teamId = self.m_teamId,
            formationId = self.m_formationId
        })
    else
        -- 暂无战员可选择
        gs.Message.Show(_TT(1234))
    end
end

-- 打开阵型界面
function __onClickFormationHandler(self)
    local lock, formationId = self:getManager():isLockFormation()
    if lock == 1 then
        gs.Message.Show(_TT(3074))
        return
    end
    local height = self.mScrollerSelectTrans.rect.height - self.mScrollerSelectTrans.rect.height % 0.001
    if height <= self.mMinHeight then
        self:updateFormationList()
        self.mImgArrowUp:SetActive(false)
        self.mImgArrowDown:SetActive(true)
        self.mBtnCloseFormation:SetActive(true) -- 打开
        self.mNowSelectFormation:SetActive(false)
        gs.TransQuick:SizeDelta02(self.mScrollerSelectTrans, self.mMaxHeight)
        self.mFormationScrollerRect.enabled = true
    else
        self:onRestoreHandler(false)
    end
end

function onRestoreHandler(self, isInit)
    local height = self.mScrollerSelectTrans.rect.height - self.mScrollerSelectTrans.rect.height % 0.001
    if height >= self.mMinHeight or isInit then
        if isInit then
            self:updateFormationList(isInit)
        end
        self.mImgArrowUp:SetActive(true)
        self.mImgArrowDown:SetActive(false)
        if not self.mEleTipGroup.activeSelf then
            self.mBtnCloseFormation:SetActive(false) -- 关闭
        end
        self.mNowImgIcon:SetImg(UrlManager:getPackPath(string.format("formation5/formation_mini_icon_%s.png",
        self.m_formationId)), true)
        self.mNowSelectFormation:SetActive(true)
        gs.TransQuick:SizeDelta02(self.mScrollerSelectTrans, self.mMinHeight)
        self.mFormationScrollerRect.enabled = false
    end
end
-- 还原战员培养箭头回调
function onRestoreArrowHandler(self, isExpansion)
    local isShow = self.mHeroDevelopNode.gameObject.activeSelf ~= true --点击触发
    if isExpansion ~= nil then
        isShow = isExpansion --active 和引导触发
    end
    self.mHeroDevelopNode.gameObject:SetActive(isShow)
    TweenFactory:move2PosXEx(self:getChildTrans("mBtnDevelop"), (isShow and 276 or 37), 0.01)
    TweenFactory:move2PosXEx(self.mGroupMove, (isShow and 438 or 205), 0.01)
    self.mTxtDevelop.gameObject:SetActive((not isShow))
    self.mImgDevelopLine:SetActive(isShow)
    local rotate = (self.mHeroDevelopNode.gameObject.activeSelf == false) and 180 or 0
    gs.TransQuick:SetRotation(self.mImgDevelop, 0, rotate, 0)

    local saveState = true
    if StorageUtil:getNumber1(self.mArrowStateKey) == 2 then
        saveState = false
    end
    if isShow ~= saveState then
        saveState = (isShow == true) and 1 or 2
        StorageUtil:saveNumber1(self.mArrowStateKey, saveState)
    end
end

-- 打开培养界面
function __onClickDevelopHandler(self, args)
    if self.mIsSelectHero then
        return
    end
    local targetId = args
    hero.HeroManager:setPanelShowHeroId(targetId)
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DEVELOP_PANEL, {
        heroId = targetId,
        tabType = hero.DevelopTabType.LVL_UP,
        subData = {},
        teamId = self.m_teamId,
        isPrepare = true
    })
end

-- 打开助战界面
function __onClickBtnAssistHandler(self)
    self:getManager():dispatchEvent(self:getManager().OPEN_FORMATION_ASSIST_PANEL, {
        teamId = self.m_teamId,
        formationId = self.m_formationId
    })
end

-- 场景预制体是否完毕
function isLoadFinish(self)
    return self.m_sceneController and self.m_sceneController:isLoadFinish()
end

-- 检测更新界面
function __checkUpdateView(self)
    self.m_sceneController = formation.FormationSceneController
    self.m_sceneController:setManager(self:getManager())
    local __finishCall = function()
        self:__updateView()
        self:onRestoreHandler(true)
    end
    self.m_sceneController:enterMap("", self:__getBgURL(), __finishCall)
end

-- 检测更新队列列表界面
function __checkUpdateTeamView(self, args)
    if (self:isLoadFinish()) then
        if (self.m_teamId == args.teamId) then
            self:__updateTeamList(false)
        end
    end
end

-- 检测更新阵型列表界面
function __checkUpdateFormationView(self, args)
    if (self:isLoadFinish()) then
        if (self.m_teamId == args.teamId) then
            self.m_formationId = args.formationId
            self:__updateMiniFormation(false)
            self:__updateMapView()
        end
    end
end

-- 检测更新队长界面
function __checkUpdateCaptainView(self, args)
    if (self:isLoadFinish()) then
        if (self.m_teamId == args.teamId) then
            self:__updateCaptain(false)
        end
    end
end

-- 更新界面
function __updateView(self, cusInit, isTween)
    if (self:isLoadFinish()) then
        local data = self:getManager():getData()
        if (data and type(data) == "table" and data.battleType) then
            if (data.battleType == PreFightBattleType.ArenaChallenge) then
                self.mBtnEnemyInfo:SetActive(false)

            elseif data.battleType == PreFightBattleType.MainMapStage or data.battleType ==
            PreFightBattleType.ClimbTowerDup or data.battleType == PreFightBattleType.RogueLike or data.battleType ==
            PreFightBattleType.DupApostle2War or data.battleType == PreFightBattleType.ElementTower then
                local lock, formationId = self:getManager():isLockFormation()
                self.mImgLock:SetActive(lock == 1)
            end
        else
            self.mBtnEnemyInfo:SetActive(false)
        end

        self:updateFightBtn()
        self:updateHeroOrMonster()
        -- 助战
        local nowNum = self:getManager():getAssistUnlockNum()
        local nowAssist = #self:getManager():getSelectTeamAssistHeroList(self.m_teamId)

        if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_ASSIST, false) == true and nowNum > 0) then
            self.mBtnAssist:SetActive(true)
            self:setBtnLabel(self.mBtnAssist, 1240, "助战 (" .. nowAssist .. "/" .. nowNum .. ")", nowAssist, nowNum)
        else
            self.mBtnAssist:SetActive(false)
        end

        self.isCanClickClose = true
        self.gBtnClose:SetActive(true)
        self.gBtnCloseAll:SetActive(false)

        cusInit = cusInit == nil and true or cusInit

        -- if cusInit then
        --     self:updateEleEff(true)
        --     self:updateLoopEleEff()
        -- end
        --初始化时清理掉之前的元素特效
        self.m_sceneController:closeEffLoopPrefab()

        self:__updateTeamList(cusInit)
        self:__updateFightPowerView(cusInit)
        self:__updateCaptain(cusInit)
        self:__updateMiniFormation(cusInit)
        self:__updateMapView()
        self:updatePosEff()
        self:updatePetItem()
        self:updateTarget()
        self:updateLockToogle()
        --延迟，因为从敌人阵型界面返回会不对
        self:setTimeout(0.2, function()
            self:__updateGuide()
        end)
        self:updateChildCustom()
        if isTween == nil or isTween then
            self:teewnIndex()
        end
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO) == false or
        funcopen.FuncOpenManager:isOpen(50219) == false then
            self.mBtnDevelop:SetActive(false)
        end
    end
end

function updateChildCustom(self)

end

function updateLockToogle(self)

end

function teewnIndex(self)
    local index = table.indexof01(self:getManager():getAllTeamIdList(), self.m_teamId)
    local posX = -250.6 - 177 * (index - 1)
    TweenFactory:move2LPosX(self.mTeamList.transform, posX, 0.3)
    self.mArrowLeft:SetActive(not (index == 1))
    self.mArrowRight:SetActive(not (index == #self:getManager():getAllTeamIdList()))
end

function updateHeroOrMonster(self)
    self:recoverHeadItems()
    local heroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    self.mBtnDevelop:SetActive(#heroList > 0)

    self.mCount = sysParam.SysParamManager:getValue(SysParamType.HERO_LV_UP_RED_ASTRICT)[1]
    self.mNeedLvl = sysParam.SysParamManager:getValue(SysParamType.HERO_LV_UP_RED_ASTRICT)[2]
    self.mCurrentCount = 0

    for k, v in pairs(heroList) do
        local heroVo = hero.HeroManager:getHeroVo(v.heroId)
        if heroVo then
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(v:getHeroTid())
            local item = SimpleInsItem:create(self:getChildGO("mShowItem"), self.mHeroDevelopNode, "FormationPanelheroShowItem")
            self:setGuideTrans("funcTips_formation_item_" .. v:getHeroTid(), item:getTrans())
            item:setArgs(v)
            item:getChildGO("mImgHeroEleType"):SetActive(false)
            item:getChildGO("mTxtLv"):SetActive(true)
            item:getChildGO("mImgBossBg"):SetActive(false)
            item:getChildGO("mImgSelect"):SetActive(false)
            item:getChildGO("mGroupHero"):SetActive(true)
            item:getChildGO("mGroupStatr"):SetActive(heroVo.evolutionLvl > 0)
            item:getChildGO("mHerotype"):SetActive((heroConfigVo.eleType ~= nil))
            item:getChildGO("mTxtHeroName"):GetComponent(ty.Text).text = heroConfigVo.name
            item:getChildGO("mTxtLv"):GetComponent(ty.Text).text = HtmlUtil:colorAndSize("Lv", "FFFFFF", 14) .. heroVo.lvl
            
            --item:getChildGO("mHeroStaminaItem"):SetActive(false)
            item:getChildGO("mIconHead"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getFormationHeadUrl(heroVo:getHeroModel()), true)
            item:getChildGO("mHerotype"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getHeroEleTypeIconUrl2(heroConfigVo.eleType), true)
            item:getChildGO("mIconProfession"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getHeroJobSmallIconUrl(heroConfigVo.professionType), true)
            item:addUIEvent(nil, function()
                self:__onClickDevelopHandler(v.heroId)
            end)
            local color = '2e95ffff'
            if heroVo.color == 3 then --  精英
                color = 'ff72f1ff' -- 紫色
            elseif heroVo.color == 4 then -- 首领
                color = 'ff9e35ff' -- 橙色
            end
            item:getChildGO("mImgColorBar"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(color)
            local curIntegers = heroVo.evolutionLvl
            for i = 1, curIntegers do
                local starItem = SimpleInsItem:create(item:getChildGO("mStar"), item:getChildTrans("mGroupStatr"), "FormationPanelmStar")
                starItem:getGo():GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0048.png"), true)
                table.insert(self.mStarItemList, starItem)
            end
            if self:getViewType() <= 1 then
                self:updateFightEleState(heroConfigVo.eleType)
            end
            table.insert(self.mItemList, item)
        end
    end

    self:updateTeamFlag()
end

function updateTeamFlag(self)
    if #self.mItemList > 0 then
        self.canShowLvl = true
        local allheroList = hero.HeroManager:getHeroList()
        for k, v in pairs(allheroList) do
            if self.mNeedLvl <= v.lvl then
                self.mCurrentCount = self.mCurrentCount + 1
                if self.mCurrentCount >= self.mCount then
                    self.canShowLvl = false
                    break
                end
            end
        end
        for _, item in ipairs(self.mItemList) do
            local isFlag = hero.HeroFlagManager:getFlag(item:getArgs().heroId, hero.HeroFlagManager.FLAG_CAN_WEAR_EQUIP, true)
            isFlag = isFlag or hero.HeroFlagManager:getFlag(item:getArgs().heroId, hero.HeroFlagManager.FLAG_CAN_WEAR_BRACELETS, true)
            if self.canShowLvl == true then
                isFlag = isFlag or hero.HeroFlagManager:getFlag(item:getArgs().heroId, hero.HeroFlagManager.FLAG_CAN_LVL_UP, true)
                isFlag = isFlag or hero.HeroFlagManager:getFlag(item:getArgs().heroId, hero.HeroFlagManager.FLAG_CAN_MILITARY_RANK_UP, true)
            end

            if (isFlag) then
                RedPointManager:add(item:getTrans(), nil, 120, 49)
            else
                RedPointManager:remove(item:getTrans())
            end

        end
    end
end

function updateFightBtn(self)
    self:recoverEleGrid()
    if self:getDupVo() and self:getDupVo().suggestLevel then
        local suggestLv = self:getDupVo().suggestLevel
        local text = ""
        if (suggestLv[1] ~= 0) then
            text = _TT(3071, suggestLv[1]) .. " "
        end
        text = text .. _TT(3072, suggestLv[2])
        self.mTxtRecommandLv.text = text
        self.mRecommandLv:SetActive(self.mBtnSave.activeSelf ~= true)
    else
        self.mRecommandLv:SetActive(false)
    end
    if self:getDupVo() and self:getDupVo().suggestEle then
        local suggestEle = self:getDupVo().suggestEle
        for i = 1, #suggestEle do
            local item = SimpleInsItem:create(self.mImgEleBg, self.mRecommandFormation, "FormationPanelelegrid1")
            local img = item:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)
            img:SetImg(UrlManager:getHeroEleTypeIconUrl(suggestEle[i]), true)
            img.color = gs.ColorUtil.GetColor("ffffffff")
            if self:getViewType() <= 1 then
                img.color = gs.ColorUtil.GetColor("ffffff80")
            end
            table.insert(self.mWeaknessGrid, item)
        end
    end
end

function updateFightEleState(self, ele)
    if self:getDupVo() and self:getDupVo().suggestEle then
        local suggestEle = self:getDupVo().suggestEle
        local index = table.indexof01(suggestEle, ele)
        if index > 0 and (self.mWeaknessGrid[index]) then
            self.mWeaknessGrid[index]:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil
            .GetColor(
            "ffffffff")
        end
    end
end

function recoverEleGrid(self)
    if #self.mWeaknessGrid > 0 then
        for i, item in ipairs(self.mWeaknessGrid) do
            self.mWeaknessGrid[i]:poolRecover()
            self.mWeaknessGrid[i] = nil
        end
        self.mWeaknessGrid = {}
    end
end

function getViewType(self)
    return 1
end

function getFormationListData(self)
    local formationConfigList = self:getManager():getFormationConfigList()
    local scrollDataList = {}
    for i = 1, #formationConfigList do
        if formationConfigList[i]:getIsShow() == 1 then
            local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
            scrollVo:setDataVo({
                showTeamId = self.m_teamId,
                formationConfigVo = formationConfigList[i],
                manager = self:getManager()
            })
            if (self.m_formationId ~= formationConfigList[i]:getRefID()) then
                scrollVo:setSelect(false)
            else
                scrollVo:setSelect(true)
            end
            table.insert(scrollDataList, scrollVo)
        end
    end
    if #scrollDataList > 0 then
        table.sort(scrollDataList, function(a, b)
            return a:getDataVo().formationConfigVo:getRefID() < b:getDataVo().formationConfigVo:getRefID()
        end)
    end
    return scrollDataList
end

function updateFormationList(self, isInit)
    -- 此处poolRecover回收数据后，要确保接下来会执行DataProvider或ReplaceAllDataProvider，以彻底断开LyScroller数据列表和Lua对象池内的引用关系
    self:recoverListData(self.mScrollerSelect.DataProvider)
    local scrollList = self:getFormationListData()
    for k, v in pairs(scrollList) do
        v.isInit = isInit
    end
    if self.mScrollerSelect.Count <= 0 then
        self.mScrollerSelect.DataProvider = scrollList
    else
        self.mScrollerSelect:ReplaceAllDataProvider(scrollList)
    end
end

function __updateTeamList(self, cusInit)
    -- 此处poolRecover回收数据后，要确保接下来会执行DataProvider或ReplaceAllDataProvider，以彻底断开LyScroller数据列表和Lua对象池内的引用关系

    self:recoverListData(self.m_teamScroll.DataProvider)
    local scrollDataList = {}
    local allTeamIdList = self:getManager():getAllTeamIdList()
    for i = 1, #allTeamIdList do
        local teamId = allTeamIdList[i]
        local scrollVo = LuaPoolMgr:poolGet(LyScrollerSelectVo)
        scrollVo:setDataVo({
            teamId = teamId,
            manager = self:getManager()
        })
        if (self.m_teamId ~= teamId) then
            scrollVo:setSelect(false)
        else
            scrollVo:setSelect(true)
        end
        table.insert(scrollDataList, scrollVo)
    end
    if (cusInit) then
        self.m_teamScroll.DataProvider = scrollDataList
    else
        self.m_teamScroll:ReplaceAllDataProvider(scrollDataList)
    end
    self.mTeamNode:SetActive(#scrollDataList > 1 and
    funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FORMATION_MOVE))
end

function recoverListData(self, list)
    if (list and #list > 0) then
        for i, v in ipairs(list) do
            LuaPoolMgr:poolRecover(v)
        end
    end
end

-- 获取推荐等级
function getRecommandLv(self)

end

-- 获取阵型战力
function getFormationAvgLv(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local fight = 0
    for _, formationHeroVo in pairs(formationHeroList) do
        if (not formationHeroVo:getIsMonster()) then
            local heroVo = hero.HeroManager:getHeroVo(formationHeroVo.heroId)
            fight = math.max(fight, heroVo.lvl)
        end
    end
    return fight
end

-- 更新战力
function __updateFightPowerView(self, cusInit)
end

-- 更新队长
function __updateCaptain(self, cusInit)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    for _, formationHeroVo in pairs(formationHeroList) do
        if (formationHeroVo.isCaptainHero) then
            local heroConfigVo = hero.HeroManager:getHeroConfigVo(formationHeroVo:getHeroTid())
            self:setBtnLabel(self.mBtnCaptain, -1, string.format("当前队长:%s", heroConfigVo.name))
            return
        end
    end
    self:setBtnLabel(self.mBtnCaptain, 3028, "暂无队长")
end

-- 更新阵型格子图显示
function __updateMapView(self)
    local formationHeroList = self:getManager():getSelectFormationHeroList(self.m_teamId)
    local formationConfigVo = self:getManager():getFormationConfigVo(self.m_formationId)
    local formationConfigList = formationConfigVo:getFormationList()

    local isHasEmpty = #formationConfigList > #formationHeroList
    if (isHasEmpty) then
        local selectTidList = self:getManager():getMySelectHeroTidList()
        if (not self.m_myAllHeroTidList) then
            self.m_myAllHeroTidList = hero.HeroManager:getAllHeroTidList()
        end
        if (#selectTidList >= #self.m_myAllHeroTidList) then
            self.m_sceneController:setIsShowTipTile(false)
        else
            self.m_sceneController:setIsShowTipTile(true)
        end
    else
        self.m_sceneController:setIsShowTipTile(false)
    end

    local function allFinishCall()
        self:updateEleEff(true)
        self:updateLoopEleEff()
    end

    self.m_sceneController:setModelList(formationConfigList, formationHeroList, self.m_formationId, allFinishCall)
    self:updatePosEff()
end

function __updateGuide(self)
    local formationTileCount, row, col = self:getManager():getFormationTileCount()
    for col_x = 1, col do
        for row_y = 1, row do
            local guideTile = self:getChildTrans(string.format("GuideTile_%s_%s", col_x, row_y))
            local worldPos = self.m_sceneController:getTileWorldPos(col_x, row_y)
            gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetDefSceneCamera(), gs.CameraMgr:GetUICamera(), worldPos,
            self:getChildTrans("GuideNeed"), guideTile)
            self:setGuideTrans(string.format("tofight_formation_tile_texture_%s_%s", col_x, row_y),
            self.m_sceneController:getDeactiveTile(col_x, row_y).transform)
            self:setGuideTrans(string.format("tofight_formation_tile_%s_%s", col_x, row_y), guideTile)
        end
    end
    self:setGuideTrans("guide_formation_btnControl", self.mBtnControl.transform)

    self:setGuideTrans("funcTips_formation_1", self:getChildTrans("mBtnFormation"))
    self:setGuideTrans("funcTips_formation_2", self:getChildTrans("mGroupFuncFormation1"))
    self:setGuideTrans("funcTips_formation_3", self:getChildTrans("mBtnControl"))
    self:setGuideTrans("funcTips_grouppower", self:getChildTrans("mGroupFuncPower"))

    self:setGuideTrans("funcTips_guide_develop", self:getChildTrans("mBtnDevelop"))
    self:setGuideTrans("funcTips_guide_formation_Element", self.mBtnElement.transform)
    self:setGuideTrans("funcTips_guide_formation_BtnPosEff", self.mBtnPosEff.transform)

    self:setGuideTrans("funcTips_guide_formation_BtnEnemyInfo", self.mBtnEnemyInfo.transform)
    self:setGuideTrans("funcTips_guide_formation_RecommandLv", self:getChildTrans("mRecommandLv"))
    self:setGuideTrans("funcTips_guide_formation_BtnFormation", self:getChildTrans("mBtnFormation"))
    self:setGuideTrans("funcTips_guide_formation_ScrollerSelect", self:getChildTrans("mScrollerSelect"))
end

-- 更新迷你阵型图
function __updateMiniFormation(self, cusInit)
    self.mImgMiniFormation:SetImg(UrlManager:getPackPath(string.format("formation5/formation_mini_icon_%s.png",
    self.m_formationId)), false)
end

function updatePetItem(self)
    self:recoverPetItem()

    self.mPetNode.gameObject:SetActive(funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_PET, false))
    local petId = self:getManager():getPetIdByTeamId(self.m_teamId)
    local petConfig = formationLV.FormationLVManager:getLVConfigVo(petId)
    self.mPetHead = formationLV.FormationLVItem:poolGet()
    self.mPetHead:setData(self.mPetNode, petConfig)
    self.mPetHead:setSelect(false)
    self.mPetHead:setInUse(false)
    self.mPetHead:showShape(true)
    self.mPetHead:addOnClick("", function()
        GameDispatcher:dispatchEvent(EventName.OPEN_FORMATIONLV_PANEL, {
            manager = self:getManager(),
            teamId = self.m_teamId,
            petId = petId
        })
    end)
    if petConfig then
        if (formationLV.FormationLVManager:getHasRed()) then
            RedPointManager:add(self.mPetNode.transform, nil, 45, 45)
        else
            RedPointManager:remove(self.mPetNode.transform)
        end
    end
    -- print(petConfig)
end

function recoverPetItem(self)
    if self.mPetHead then
        self.mPetHead:poolRecover()
        self.mPetHead = nil
    end
end
--------------------------------------------------------------------------------------拖拽相关------------------------------------------------------------------------------------------------
function __isCanDrag(self)
    return funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_FORMATION_MOVE) and not self.mIsSelectHero
end

-- 拖拽多少距离才显示线条
function __deltaValue(self)
    return 0
end

-- 阵型瓦片按住事件
function __onPointerDownFormationTileHandler(self, args)
    if (not self:__isCanDrag() or not self:isLoadFinish()) then
        return
    end
    self:revertTargetTile()
    local worldPos = args.worldPos
    self.m_isDel = false
    self.m_selectMousePos = gs.Input.mousePosition
    self.m_selectColIndex = args.col
    self.m_selectRowIndex = args.row

    self.m_selectHeroPos = self:getManager():getFormationTilePos(self.m_formationId, self.m_selectColIndex,
    self.m_selectRowIndex)
    if (self.m_selectHeroPos > 0) then
        gs.CameraMgr:World2CameraUI01(gs.CameraMgr:GetDefSceneCamera(), gs.CameraMgr:GetUICamera(), worldPos,
        self.UITrans, self.m_transLine)
        gs.TransQuick:SizeDelta01(self.m_transLine, 0)
        gs.TransQuick:SetLRotation(self.m_transLine, 0, 0, 0)
        self.m_frameSn = LoopManager:addFrame(1, 0, self, self.__onFramdUpdateHandler)
        self.m_sceneController:showSelectTile(self.m_selectColIndex, self.m_selectRowIndex)
    end
end

-- 恢复目标格子
function revertTargetTile(self)
    if (not self:__isCanDrag() or not self:isLoadFinish()) then
        return
    end
    if (self.m_targetColIndex and self.m_targetRowIndex and self.m_targetHeroPos) then
        if (self.m_selectHeroPos ~= self.m_targetHeroPos) then
            local isLock, id = self:getManager():getFormationTileLock(self.m_formationId, self.m_targetColIndex, self.m_targetRowIndex)
            if (self.m_sceneController:getIsShowTipTile() and
            self.m_sceneController:isEmpty(self.m_targetColIndex, self.m_targetRowIndex)) then
                self.m_sceneController:hideActiveTile(self.m_targetColIndex, self.m_targetRowIndex)
                if isLock == false then
                    self.m_sceneController:showTipTile(self.m_targetColIndex, self.m_targetRowIndex)
                end
            else
                self.m_sceneController:showActiveTile(self.m_targetColIndex, self.m_targetRowIndex)
                self.m_sceneController:hideTipTile(self.m_targetColIndex, self.m_targetRowIndex)
            end
            self.m_sceneController:hideTargetTile(self.m_targetColIndex, self.m_targetRowIndex)
        end
    end
    self.m_targetColIndex = nil
    self.m_targetRowIndex = nil
    self.m_targetHeroPos = nil
end

function __onFramdUpdateHandler(self)
    if (not self:__isCanDrag() or not self:isLoadFinish()) then
        return
    end
    local mousePos = gs.Input.mousePosition
    if (self.m_selectMousePos) then
        local deltaX = self.m_selectMousePos.x - mousePos.x
        local deltaY = self.m_selectMousePos.y - mousePos.y
        if (math.abs(deltaX) <= self:__deltaValue() and math.abs(deltaY) <= self:__deltaValue() and self.mIsSelectHero) then
            return
        end
        self.m_selectMousePos = nil
        self.m_goLine:SetActive(true)
    end
    local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(mousePos)
    local parentMousePos = self.UITrans:InverseTransformPoint(mouseWorldPos)
    local screenMousePos = gs.Vector2(parentMousePos.x, parentMousePos.y)
    local localPos = self.m_transLine.localPosition
    gs.TransQuick:SizeDelta01(self.m_transLine,
    gs.Mathf
    .Sqrt((screenMousePos.x - localPos.x) * (screenMousePos.x - localPos.x) + (screenMousePos.y - localPos.y) *
    (screenMousePos.y - localPos.y)))
    gs.TransQuick:SetLRotation(self.m_transLine, 0, 0, self:pointToAngle(localPos, screenMousePos))

    -- 射线检测
    local sceneCamera = gs.CameraMgr:GetDefSceneCamera()
    local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, "Ground", 100)
    if (hitInfo and hitInfo.collider) then
        local item = hitInfo.collider.gameObject
        local keyData = self.m_sceneController:getTileKeyData(item.name)
        if (keyData) then
            local tile = self.m_sceneController:getDeactiveTile(keyData.col_x, keyData.row_y)

            -- 是否点击了对应的格子
            if (tile) then
                local targetHeroPos = self:getManager():getFormationTilePos(self.m_formationId, keyData.col_x,
                keyData.row_y)
                local isLock, id = self:getManager():getFormationTileLock(self.m_formationId, keyData.col_x, keyData.row_y)
                if (targetHeroPos > 0 and isLock == false) then
                    if (targetHeroPos ~= self.m_targetHeroPos) then
                        if (targetHeroPos ~= self.m_selectHeroPos) then
                            self:revertTargetTile()
                            -- self.m_sceneController:hideActiveTile(keyData.col_x, keyData.row_y)
                            self.m_sceneController:showActiveTile(keyData.col_x, keyData.row_y)
                            self.m_sceneController:hideTipTile(keyData.col_x, keyData.row_y)
                            self.m_sceneController:showTargetTile(keyData.col_x, keyData.row_y)
                        end
                        self.m_targetColIndex = keyData.col_x
                        self.m_targetRowIndex = keyData.row_y
                        self.m_targetHeroPos = targetHeroPos
                        -- print("进入允许站位：", item.name)
                    end
                else
                    self:revertTargetTile()
                    -- print("进入禁止站位：", item.name)
                end
            else
                self:revertTargetTile()
                Debug:log_error("FormationPanel", string.format(
                "数据异常：FormationSceneController:getDeactiveTile()方法找不到对应格子对象%s",
                item.name))
            end
        else
            self:revertTargetTile()
            -- print("进入和阵型无关的区域", item.name)
            self.m_isDel = true
        end
    else
        self:revertTargetTile()
        -- print("进入空白区域")
        self.m_isDel = true
    end
end

function pointToAngle(self, startPos1, endPos2)
    return gs.Mathf.Atan2(endPos2.y - startPos1.y, endPos2.x - startPos1.x) * 180 / 3.14
end

-- 阵型瓦片抬起事件
function __onPointerUpFormationTileHandler(self, args)
    if (not self:__isCanDrag() or not self:isLoadFinish()) then
        return
    end
    -- 选择的数据
    if (self.m_frameSn) then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
        self.m_goLine:SetActive(false)
    end

    local function _checkResult()
        if (self.m_selectHeroPos and self.m_selectHeroPos > 0) then
            if (self.m_selectHeroPos ~= self.m_targetHeroPos) then
                local selectFormationHeroVo = self:getManager():getFormationHeroVoByPos(self.m_teamId,
                self.m_selectHeroPos)
                local selectHeroId = selectFormationHeroVo.heroId
                local selectHeroTid = selectFormationHeroVo:getHeroTid()
                local selectHeroSourceType = selectFormationHeroVo.sourceType
                if (self.m_targetHeroPos) then
                    self:getManager():setSelectFormationHeroList(self.m_teamId, self.m_formationId, selectHeroId,
                    selectHeroTid, selectHeroSourceType, self.m_targetHeroPos, false)
                    -- local row, col = self:getManager():getFormationTileRowCol(self.m_formationId, self.m_targetHeroPos)
                    -- self.m_sceneController:showHandoffVFX(col, row)
                else
                    if (self.m_isDel) then
                        self:getManager():setSelectFormationHeroList(self.m_teamId, self.m_formationId, selectHeroId,
                        selectHeroTid, selectHeroSourceType, self.m_selectHeroPos, false)
                    end
                end
            end
        end
    end

    local sceneCamera = gs.CameraMgr:GetDefSceneCamera()
    local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, "Ground", 100)
    if (hitInfo and hitInfo.collider) then
        local item = hitInfo.collider.gameObject
        local keyData = self.m_sceneController:getTileKeyData(item.name)
        local isLock, id = self:getManager():getFormationTileLock(self.m_formationId, keyData.col_x, keyData.row_y)

        if isLock == true and id > 0 then
            local stageVo = battleMap.MainMapManager:getStageVo(id)
            gs.Message.Show(_TT(47, stageVo.indexName))
            return
        end

        if (keyData) then
            local heroPos = self:getManager():getFormationTilePos(self.m_formationId, keyData.col_x, keyData.row_y)
            if (heroPos > 0) then
                _checkResult()
            end
        end
    else
        _checkResult()
    end

    if (self.m_selectColIndex and self.m_selectRowIndex and self.m_selectHeroPos) then
        self.m_sceneController:hideSelectTile(self.m_selectColIndex, self.m_selectRowIndex)
    end
    self.m_isDel = nil
    self.m_selectMousePos = nil
    self.m_selectColIndex = nil
    self.m_selectRowIndex = nil
    self.m_selectHeroPos = nil

    if (self.m_targetColIndex and self.m_targetRowIndex and self.m_targetHeroPos) then
        self.m_sceneController:hideTargetTile(self.m_targetColIndex, self.m_targetRowIndex)
    end
    self.m_targetColIndex = nil
    self.m_targetRowIndex = nil
    self.m_targetHeroPos = nil
end

--  获取背景图路径
function __getBgURL(self)
    return UrlManager:getBgPath("formation/formation_attack_bg.jpg")
end

function recoverHeadItems(self)
    if #self.mItemList > 0 then
        for _, item in ipairs(self.mItemList) do
            item:poolRecover()
            item = nil
        end
        self.mItemList = {}
    end

    if #self.mStarItemList > 0 then
        for _, item in ipairs(self.mStarItemList) do
            item:poolRecover()
            item = nil
        end
        self.mStarItemList = {}
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(1285):"当前阵形正在使用"
语言包: _TT(1284):"不可出战空队列"
语言包: _TT(1283):"队伍总战力"
]]