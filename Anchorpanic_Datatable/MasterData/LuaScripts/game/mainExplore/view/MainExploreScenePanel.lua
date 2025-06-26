--[[ 
-----------------------------------------------------
@filename       : MainExploreScenePanel
@Description    : 主线探索场景界面
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreScenePanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("mainExplore/MainExploreScenePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("")
    self:setUICode(LinkCode.MainExplore)
    
    self.gBtnClose:SetActive(false)
    self.gBtnCloseAll:SetActive(false)
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose(false)
end

-- 玩家点击关闭
function onClickClose(self)
    super.onClickClose(self)
    self:playerClose(true)
end

function playerClose(self, isOpenEnterPanel)
    local mapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
    GameDispatcher:dispatchEvent(EventName.MAIN_EXPLORE_REMOVE_EVENT_TRIGGER, {eventTrigger = self.mEventTrigger})
    GameDispatcher:dispatchEvent(EventName.CLOSE_MAIN_EXPLORE_SCENE)
    if(isOpenEnterPanel)then
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, { type = mainPlay.MainPlayConst.MAINPLAY_MAIN })
        -- 打开入口界面
        if(mapConfigVo)then
            if(mapConfigVo.dupType == DupType.DUP_MAIN_LINE)then
                local chapterVo, stageVo = battleMap.MainMapManager:getChapterVoByStageId(mapConfigVo.dupId)
                if (chapterVo and stageVo) then
                    GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_STAGE_LIST_PANEL, {chapterVo = chapterVo, stageVo = stageVo})
                end
            end
        end
    end
end

function open(self, args)
    super.open(self, args)
end

function initData(self)
    self.mHeroCdTime = nil
    self.mHeroTotalCdTime = 1
    self.mHeroItemList = nil
    self.mHeroCdItemList = nil
    self.mInteractItemList = nil
    self.mTipOvalBigRadius = sysParam.SysParamManager:getValue(SysParamType.MAIN_EXPLORE_TIP_OVAL_BIG, 250)
    self.mTipOvalSmallRadius = sysParam.SysParamManager:getValue(SysParamType.MAIN_EXPLORE_TIP_OVAL_SMALL, 150)
end

-- 初始化
function configUI(self)
    self.mRootUI = self:getChildGO("root")

    -- 触碰触发器
    self.mEventTrigger = self:getChildGO("ToucherEvent"):GetComponent(ty.LongPressOrClickEventTrigger)
    -- 遮挡区域
    self.mToucherAbility = self:getChildGO("ToucherAbility")
    
    -- 指引提示按钮相关
    self.mBtnRemind = self:getChildGO("mBtnRemind")
    self.mTxtRemindTitle = self:getChildGO("mTxtRemindTitle"):GetComponent(ty.Text)
    self.mTxtRemindDist = self:getChildGO("mTxtRemindDist"):GetComponent(ty.Text)
    self.mTxtRemindDes = self:getChildGO("mTxtRemindDes"):GetComponent(ty.Text)
    -- 指引提示箭头相关
    self.mGoRemindView = self:getChildGO("RemindView")
    self.mTransRemindView = self:getChildTrans("RemindView")
    self.mGoRemindPoint = self:getChildGO("RemindPoint")
    self.mTransRemindPoint = self:getChildTrans("RemindPoint")
    self.mGoArrow = self:getChildGO("NodeArrow")
    self.mTransArrow = self:getChildTrans("NodeArrow")
    self.mArrowCG = self.mTransArrow:GetComponent(ty.CanvasGroup)
    self.mTxtRemindPointTip = self:getChildGO("mTxtRemindPointTip"):GetComponent(ty.Text)
    self.mRectRemindPoint = self.mGoRemindPoint:GetComponent(ty.RectTransform)

    -- 小地图相关
    self.mGroupMiniMap = self:getChildGO("mGroupMiniMap")
    self.mContentMiniMap = self:getChildTrans("mContentMiniMap")
    
    -- 物资按钮
    self.mBtnGoods = self:getChildGO("mBtnGoods")
    -- 阵型编辑按钮
    self.mBtnFormationEdit = self:getChildGO("mBtnFormationEdit")
    -- 设置按钮
    self.mBtnSetting = self:getChildGO("mBtnSetting")
    -- 攻击按钮
    self.mBtnAttack = self:getChildGO("mBtnAttack")

    -- 菜单相关
    self.mBtnMenu = self:getChildGO("mBtnMenu")
    self.mMenuGroup = self:getChildGO("MenuGroup")
    self.mImgBgClick = self:getChildGO("ImgBgClick")
    self.mBtnExit = self:getChildGO("mBtnExit")
    self.mBtnBack = self:getChildGO("mBtnBack")
    self.mBtnResume = self:getChildGO("mBtnResume")
    
    -- 备用操作战员区域相关
    self.mContentHero = self:getChildTrans("mContentHero")
    self.mItemHero = self:getChildGO("mItemHero")
    -- 交互区域相关
    self.mEventScrollBg = self:getChildGO("mEventScrollBg")
    self.mContentEvent = self:getChildTrans("mContentEvent")
    self.mItemInteract = self:getChildGO("mItemInteract")
    
    -- 触发的消息显示相关
    self.mGoPass = self:getChildGO("GroupPass")
    self.mGroupMessage = self:getChildGO("GroupMessage")
    self.mTextMessage = self:getChildGO("TextMessage"):GetComponent(ty.Text)
    self.mImgMessage = self:getChildGO("ImgMessage"):GetComponent(ty.AutoRefImage)

    -- 摇杆区域相关
    self.mJoystickNode = self:getChildTrans("JoystickNode")

    self:setGuideTrans("guide_mainExploreScene_menu",self.mBtnMenu.transform)
    self:setGuideTrans("guide_mainExploreScene_edit",self.mBtnFormationEdit.transform)
    self:setGuideTrans("guide_mainExploreScene_goods",self.mBtnGoods.transform)
    self:setGuideTrans("guide_mainExploreScene_remind",self.mBtnRemind.transform)
    

end

function initViewText(self)
    self:setBtnLabel(self.mBtnGoods, 63014, "物资")
    self:setBtnLabel(self.mBtnFormationEdit, 63015, "战员状态")
    self:setBtnLabel(self.mBtnMenu, 63016, "菜单")
    self:setBtnLabel(self.mBtnExit, 63017, "撤退")
    self:setBtnLabel(self.mBtnBack, 63018, "返回")
    self:setBtnLabel(self.mBtnResume, 63019, "继续")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mGroupMiniMap, self.onClickMiniMapHandler)
    self:addUIEvent(self.mBtnGoods, self.onClickGoodsHandler)
    self:addUIEvent(self.mBtnFormationEdit, self.onClickFormationEditHandler)
    self:addUIEvent(self.mBtnSetting, self.onClickSettingHandler)
    self:addUIEvent(self.mBtnRemind, self.onClickRemindHandler)
    self:addUIEvent(self.mBtnMenu, self.onClickMenuHandler)
    self:addUIEvent(self.mImgBgClick, self.onClickMenuBgHandler)
    self:addUIEvent(self.mBtnExit, self.onClickExitHandler)
    self:addUIEvent(self.mBtnBack, self.onClickBackHandler)
    self:addUIEvent(self.mBtnResume, self.onClickResumeHandler)
    self:addUIEvent(self.mBtnAttack, self.onClickAttackHandler)
end

-- 激活
function active(self, args)
    MoneyManager:setMoneyTidList()
    GameDispatcher:addEventListener(EventName.CLOSE_MAIN_EXPLORE_SCENE_PANEL, self.onCloseScenePanelHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAIN_EXPORE_UI_VISIBLE, self.onUiVisibleHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAIN_EXPLORE_TOUCH_ABILITY, self.onUpdateTouchAbilityHandler, self)
    mainExplore.MainExploreSceneManager:addEventListener(mainExplore.MainExploreSceneManager.PLAYER_INTERACT_UPDATE, self.onPlayerInteractUpdateHandler, self)
    mainExplore.MainExploreSceneManager:addEventListener(mainExplore.MainExploreSceneManager.PLAYER_ENVIROMENT_UPDATE, self.onPlayerEnviromentUpdateHandler, self)
    mainExplore.MainExploreSceneManager:addEventListener(mainExplore.MainExploreSceneManager.PLAYER_FIRST_INTRODUCE_UPDATE, self.onPlayerFirstIntroduceUpdateHandler, self)
    mainExplore.MainExploreSceneManager:addEventListener(mainExplore.MainExploreSceneManager.PLAYER_TARGET_ATTACK_UPDATE, self.onPlayerTargetAttackUpdateHandler, self)
    mainExplore.MainExploreSceneManager:addEventListener(mainExplore.MainExploreSceneManager.PLAYER_TARGET_REMIND_UPDATE, self.onPlayerTargetRemindUpdateHandler, self)
    formation.FormationMainExploreManager:addEventListener(formation.FormationMainExploreManager.UPDATE_TEAM_FORMATION_DATA, self.onUpdateHeroListHandler, self)
    GameDispatcher:addEventListener(EventName.SHOW_MAIN_EXPLORE_MESSAGE, self.onShowMessageHandler, self)
    GameDispatcher:addEventListener(EventName.MAIN_EXPLORE_PLAYER_UPDATE, self.onUpdateHeroListHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAIN_EXPLORE_HERO_LIST, self.onUpdateHeroListHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAIN_EXPORE_PASS, self.onCheckAllDupPassHandler, self)
    GameDispatcher:dispatchEvent(EventName.MAIN_EXPLORE_ADD_EVENT_TRIGGER, {eventTrigger = self.mEventTrigger})

    if(not self.mMapView)then
        self.mMapView = mainExplore.MainExploreMapView.new()
        self.mMapView:setParentTrans(self.mContentMiniMap)
    end
    if(not self.mJoyStick)then
        self.mJoyStick = mainExplore.MainExploreJoystickView.new()
        self.mJoyStick:setParentTrans(self.mJoystickNode)
    end
    self.mToucherAbility:SetActive(false)
    mainExplore.MainExploreManager:setRate(nil)
    self:updateView()

    guide.GuideCondition:condition29()
end

-- 非激活
function deActive(self)
    MoneyManager:setMoneyTidList()
    GameDispatcher:removeEventListener(EventName.CLOSE_MAIN_EXPLORE_SCENE_PANEL, self.onCloseScenePanelHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAIN_EXPORE_UI_VISIBLE, self.onUiVisibleHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAIN_EXPLORE_TOUCH_ABILITY, self.onUpdateTouchAbilityHandler, self)
    mainExplore.MainExploreSceneManager:removeEventListener(mainExplore.MainExploreSceneManager.PLAYER_INTERACT_UPDATE, self.onPlayerInteractUpdateHandler, self)
    mainExplore.MainExploreSceneManager:removeEventListener(mainExplore.MainExploreSceneManager.PLAYER_ENVIROMENT_UPDATE, self.onPlayerEnviromentUpdateHandler, self)
    mainExplore.MainExploreSceneManager:removeEventListener(mainExplore.MainExploreSceneManager.PLAYER_FIRST_INTRODUCE_UPDATE, self.onPlayerFirstIntroduceUpdateHandler, self)
    mainExplore.MainExploreSceneManager:removeEventListener(mainExplore.MainExploreSceneManager.PLAYER_TARGET_ATTACK_UPDATE, self.onPlayerTargetAttackUpdateHandler, self)
    mainExplore.MainExploreSceneManager:removeEventListener(mainExplore.MainExploreSceneManager.PLAYER_TARGET_REMIND_UPDATE, self.onPlayerTargetRemindUpdateHandler, self)
    formation.FormationMainExploreManager:removeEventListener(formation.FormationMainExploreManager.UPDATE_TEAM_FORMATION_DATA, self.onUpdateHeroListHandler, self)
    GameDispatcher:removeEventListener(EventName.SHOW_MAIN_EXPLORE_MESSAGE, self.onShowMessageHandler, self)
    GameDispatcher:removeEventListener(EventName.MAIN_EXPLORE_PLAYER_UPDATE, self.onUpdateHeroListHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAIN_EXPLORE_HERO_LIST, self.onUpdateHeroListHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAIN_EXPORE_PASS, self.onCheckAllDupPassHandler, self)
    GameDispatcher:dispatchEvent(EventName.MAIN_EXPLORE_REMOVE_EVENT_TRIGGER, {eventTrigger = self.mEventTrigger})

    if (self.mMapView) then
        self.mMapView:destroy()
        self.mMapView = nil
    end
    if (self.mJoyStick) then
        self.mJoyStick:destroy()
        self.mJoyStick = nil
    end
    self:clearTimeOut1()
    self:clearTimeOut2()
    self:removeRemindTweener()
    
    self:resetHeroCdTime()
    self:recoveryHeroItemList()
    self:recoveryInteractItemList()
end

function onCloseScenePanelHandler(self)
    self:playerClose(true)
end

function onUiVisibleHandler(self, visible)
    self.mRootUI:SetActive(visible)
    self.mJoyStick:setEnable(visible)
end

function onUpdateTouchAbilityHandler(self, args)
    self.mToucherAbility:SetActive(args)
    self.mJoyStick:setEnable(not args)
end

-- 英雄列表更新
function onUpdateHeroListHandler(self)
    self:updateHeroList()
end

-- 消息更新
function onShowMessageHandler(self)
    if(not self.mTimeOutIndex2)then
        local showTip = mainExplore.MainExploreSceneManager:getShowTip()
        if(showTip)then
            self.mGroupMessage:SetActive(true)
            self.mTextMessage.text = showTip.content
            -- self.mImgMessage:SetImg("", true)
            local function finishCall()
                self:clearTimeOut2()
                self:onShowMessageHandler()
            end
            self.mTimeOutIndex2 = LoopManager:setTimeout(2, self, finishCall)
        end
    end
end

-- 交互对象列表更新
function onPlayerInteractUpdateHandler(self, args)
    self:recoveryInteractItemList()
    local interactThingList = args
    for i = 1, #interactThingList do
        local eventConfigVo = interactThingList[i]:getEventConfigVo()
        if(eventConfigVo.eventType ~= mainExplore.EventType.DUP_MONSTER and eventConfigVo.eventType ~= mainExplore.EventType.DUP_BOSS)then
            if(eventConfigVo.isAutoTrigger)then
                print(string.format("自动触发事件%s：%s", eventConfigVo.eventId, eventConfigVo:getDes()))
                mainExplore.MainExploreEventExecutor:checkTriggerEvent(eventConfigVo)
            else
                local enable = mainExplore.MainExploreManager:getEventTriggerEnable(eventConfigVo.eventId)
                if(enable)then
                    -- 添加
                    local item = SimpleInsItem:create(self.mItemInteract, self.mContentEvent, self.__cname .. "_self.mItemInteract")
                    local mChoice = item:getChildGO("mChoice")
                    local mTxtInteract = item:getChildGO("mTxtInteract"):GetComponent(ty.Text)
                    local mInteractIcon = item:getChildGO("mInteractIcon"):GetComponent(ty.AutoRefImage)
                    mChoice:SetActive(false)
                    mTxtInteract.text = eventConfigVo:getTitle()
                    mInteractIcon:SetImg(UrlManager:getPackPath(eventConfigVo.miniIcon), true)
                    local function _clickMenuFun()
                        mChoice:SetActive(true)
                        mainExplore.MainExploreEventExecutor:checkTriggerEvent(eventConfigVo, nil)
                    end
                    item:addUIEvent("mImgClick", _clickMenuFun)
                    table.insert(self.mInteractItemList, {eventConfigVo = eventConfigVo, item = item})
                end
            end
        end
    end
    self.mEventScrollBg:SetActive(#self.mInteractItemList > 0)
end

-- 环境对象列表更新
function onPlayerEnviromentUpdateHandler(self, args)
    local eventConfigVo = nil
    if(args.addEventThing)then
        eventConfigVo = args.addEventThing:getEventConfigVo()
        mainExplore.MainExploreEventExecutor:checkTriggerEventEffect(eventConfigVo.eventId, nil, {updateState = 1}, nil, nil, nil, nil)
    end
    if(args.delEventConfigVo)then
        eventConfigVo = args.delEventConfigVo
        mainExplore.MainExploreEventExecutor:checkTriggerEventEffect(eventConfigVo.eventId, nil, {updateState = 0}, nil, nil, nil, nil)
    end
end

-- 初次对话目标更新
function onPlayerFirstIntroduceUpdateHandler(self, args)
    local introduceThing = mainExplore.MainExplorePlayerProxy:getIntroduceThing()
    if(introduceThing)then
        GameDispatcher:dispatchEvent(EventName.REQ_MAIN_EXPLORE_FIRST_INTRODUCE, {introduceId = introduceThing:getEventConfigVo().introduceId})
    end
end

-- 玩家攻击目标更新
function onPlayerTargetAttackUpdateHandler(self, args)
end

-- 玩家提示目标更新
function onPlayerTargetRemindUpdateHandler(self, args)
    local remindThing, remindParam = mainExplore.MainExplorePlayerProxy:getRemindThing()
    if(remindThing)then
        local playerThing = mainExplore.MainExplorePlayerProxy:getThing()
        local distance = math.v3Distance(playerThing:getThingVo():getPosition(), remindThing:getThingVo():getPosition())
        -- 左上角的指引提示
        if(remindParam.allCount > 1)then
            self.mTxtRemindTitle.text = string.format("%s(%s/%s)", remindThing:getEventConfigVo():getTitle(), remindParam.finishCount, remindParam.allCount)
        else
            self.mTxtRemindTitle.text = remindThing:getEventConfigVo():getTitle()
        end
        self.mTxtRemindDist.text = string.format("%sm", math.ceil(distance))
        self.mTxtRemindDes.text = remindThing:getEventConfigVo():getDes()
        
        if(mainExplore.MainExploreManager:getRemindVisible())then
            local isInOval, angle = self:setUIPosByThing(playerThing, remindThing, self.mRectRemindPoint)
            if(isInOval == true)then
                self.mTxtRemindPointTip.text = ""
                self:removeRemindTweener()
                self.mGoArrow:SetActive(false)
            else
                self.mTxtRemindPointTip.text = string.format("%sm", math.ceil(distance))
                if(not self.mRemindTweener)then
                    self.mRemindTweener = TweenFactory:canvasGroupAlphaTo(self.mArrowCG, 1, 0.01, 0.3, gs.DT.Ease.Linear, finishCall, delayTween, true)
                end
                gs.TransQuick:SetLRotation(self.mTransArrow, 0, 0, angle)
                self.mGoArrow:SetActive(true)
            end
            self.mGoRemindPoint:SetActive(true)
        else
            self.mGoRemindPoint:SetActive(false)
        end
        self.mBtnRemind:SetActive(true)
    else
        self:removeRemindTweener()
        self.mGoArrow:SetActive(false)
        self.mGoRemindPoint:SetActive(false)
        self.mBtnRemind:SetActive(false)
    end
end

function setUIPosByThing(self, playerThing, targetThing, updateRectTrans)
    if(playerThing and targetThing)then
        -- local playerPos = playerThing:getThingVo():getPosition()
        -- local centerPos = math.Vector3(playerPos.x, playerPos.y + playerThing:getPlayerConfigVo().agentHeight / 2, playerPos.z)
        -- local uiCenterPos = gs.CameraMgr:World2RelativeUI(centerPos, self.mTransRemindView, 1)
        -- local uiCenterX = uiCenterPos.x
        -- local uiCenterY = uiCenterPos.y
        local uiCenterX = 0
        local uiCenterY = 0
        local targetPos = targetThing:getThingVo():getPosition()
        local uiTargetPos = gs.CameraMgr:World2RelativeUI(targetPos, self.mTransRemindView, 1)
        local angle = math.getTargeAngle(uiCenterX, uiCenterY, uiTargetPos.x, uiTargetPos.y, 2)
        local isInOval = gs.MathUtil.IsInOval(uiCenterX, uiCenterY, self.mTipOvalBigRadius, self.mTipOvalSmallRadius, uiTargetPos.x, uiTargetPos.y)
        if(isInOval)then
            gs.TransQuick:UIPos(updateRectTrans, uiTargetPos.x, uiTargetPos.y)
        else
            gs.MathUtil.UIPosOval(uiCenterX, uiCenterY, self.mTipOvalBigRadius, self.mTipOvalSmallRadius, angle - 90, updateRectTrans)
        end
        return isInOval, angle
    else
        return false
    end
end

-- 通关更新
function onCheckAllDupPassHandler(self)
    self:clearTimeOut1()
    self.mGoPass:SetActive(false)
    local allDupPassData = mainExplore.MainExploreManager:getAllDupPassData()
    if(allDupPassData)then
        if(allDupPassData.mapId == mainExplore.MainExploreManager:getTriggerDupData().mapId)then
            local checkResetCallFun = function()
                mainExplore.MainExploreManager:setAllDupPassData(nil)
                local mapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
                local playConfigVo = mainExplore.MainExploreSceneManager:getPlayConfigVo(mapConfigVo.dupType)
                if(playConfigVo.isAutoReset)then
                    self:playerClose(true)
                    GameDispatcher:dispatchEvent(EventName.REQ_RESET_MAIN_EXPLORE_MAP, {mapId = mapConfigVo.mapId})
                end
            end
            local finishCall = nil
            if(#allDupPassData.awardMsgList > 0)then
                local function showAwardFinish()
                    checkResetCallFun()
                end
                finishCall = function ()
                    self.mGoPass:SetActive(false)
                    ShowAwardPanel:showPropsAwardMsg(allDupPassData.awardMsgList, showAwardFinish)
                end
            else
                finishCall = function ()
                    self.mGoPass:SetActive(false)
                    checkResetCallFun()
                end
            end
            if(finishCall)then
                self.mGoPass:SetActive(true)
                self.mTimeOutIndex1 = LoopManager:setTimeout(2, self, finishCall)
            end
        end
    end
end

-- 打开地图
function onClickMiniMapHandler(self)
    mainExplore.MainExploreManager:setRate(0)
    GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_EXPLORE_MAP_PANEL)
end

-- 打开物资
function onClickGoodsHandler(self)
    mainExplore.MainExploreManager:setRate(0)
    GameDispatcher:dispatchEvent(EventName.OPEN_MAIN_EXPLORE_GOODS_PANEL, {mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId})
end

-- 打开阵型编辑
function onClickFormationEditHandler(self)
    local formatoinCallFun = function(callReason)
        mainExplore.MainExploreCamera:removePhysicsRaycaster()
    end
    mainExplore.MainExploreCamera:addPhysicsRaycaster()
    local exploreMapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
    local data = {mapId = mainExplore.MainExploreManager:getTriggerDupData().mapId, uniqueTidList = mainExplore.MainExploreManager:getMainExploreHeroList(mainExplore.MainExploreManager:getTriggerDupData().mapId, mainExplore.HERO_SOURCE_TYPE.SUPPORT, true)}
    formation.openFormation(formation.TYPE.MAIN_EXPLORE, exploreMapConfigVo.dupType, { data = data }, formatoinCallFun)
    mainExplore.MainExploreManager:setRate(0)
end

-- 打开设置界面
function onClickSettingHandler(self)
    mainExplore.MainExploreManager:setRate(0)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Setting })
end

-- 打开指引提示界面
function onClickRemindHandler(self)
    local visible =  mainExplore.MainExploreManager:getRemindVisible()
    mainExplore.MainExploreManager:setRemindVisible(not visible)
end

-- 打开菜单界面
function onClickMenuHandler(self)
    self.mMenuGroup:SetActive(true)
    mainExplore.MainExploreManager:setRate(0)
end

-- 关闭菜单界面
function onClickMenuBgHandler(self)
    self.mMenuGroup:SetActive(false)
    mainExplore.MainExploreManager:setRate(nil)
end

-- 点击撤退
function onClickExitHandler(self)
    UIFactory:alertMessge(
        _TT(63029),
        true,
        function()
            local mapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
            self:onClickMenuBgHandler()
            self:playerClose(true)
            GameDispatcher:dispatchEvent(EventName.REQ_RESET_MAIN_EXPLORE_MAP, {mapId = mapConfigVo.mapId})
        end,
        _TT(1), --"确定"
        nil,
        true,
        function()
        end,
        _TT(2),
         --"取消"
        _TT(4341), --"重置提示"
        nil,
        RemindConst.XXX)
end

-- 点击返回
function onClickBackHandler(self)
    UIFactory:alertMessge(
        _TT(63030),
        true,
        function()
            self:onClickMenuBgHandler()
            self:playerClose(true)
        end,
        _TT(1), --"确定"
        nil,
        true,
        function()
        end,
        _TT(2),
         --"取消"
        _TT(4341), --"重置提示"
        nil,
        RemindConst.XXX)
end

-- 点击继续
function onClickResumeHandler(self)
    self:onClickMenuBgHandler()
end

-- 点击攻击按钮
function onClickAttackHandler(self)
    local isInProtecting = mainExplore.MainExploreManager:getIsInProtecting()
    if(isInProtecting)then
        gs.Message.Show(_TT(63032))
    else
        local attackThing = mainExplore.MainExplorePlayerProxy:getAttackThing()
        if(attackThing)then
            local eventConfigVo = attackThing:getEventConfigVo()
            if(eventConfigVo.eventType == mainExplore.EventType.DUP_MONSTER or eventConfigVo.eventType == mainExplore.EventType.DUP_BOSS)then
                local enable = mainExplore.MainExploreManager:getEventTriggerEnable(eventConfigVo.eventId)
                if(enable)then
                    local playerThing = mainExplore.MainExplorePlayerProxy:getThing()
                    local function attackFinish()
                        playerThing:setBehaviorState(mainExplore.BehaviorState.IDLE, nil, nil)
                        mainExplore.MainExploreEventExecutor:checkTriggerEvent(eventConfigVo, {attacker = playerThing})
                    end
                    playerThing:setBehaviorState(mainExplore.BehaviorState.PLAYER_ATTACK, nil, attackFinish)
                else
                    gs.Message.Show(_TT(63021))
                end
            end
            return
        end
        gs.Message.Show(_TT(63033))
    end
end

function updateView(self)
    mainExplore.MainExploreManager:setRate(nil)
    mainExplore.MainExploreEventExecutor:checkWaitEffect()
    self:updateMiniMap()
    self:updateHeroList()
    self:onUiVisibleHandler(true)
    self:onPlayerInteractUpdateHandler(mainExplore.MainExplorePlayerProxy:getInteractThingList())
    self:onCheckAllDupPassHandler()
end

function updateMiniMap(self)
    self.mMapView:setScale(0.6)
    self.mMapView:forceLookPlayer()
end

function updateHeroList(self)
    self:recoveryHeroItemList()
    local hpBarWidth = 70.66
    local mapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
    local formationHeroList = mainExplore.MainExploreManager:getFormationHeroList()
    for i = 1, #formationHeroList do
        local formationHeroVo = formationHeroList[i]
        local heroTid = formationHeroVo:getHeroTid()
        if(heroTid ~= mainExplore.MainExploreManager:getControlHeroTid())then
            local mainexploreHeroVo = mainExplore.MainExploreManager:getMainExploreHero(mapConfigVo.mapId, formationHeroVo.heroId, mainExplore.HERO_SOURCE_TYPE.OWN)

            local item = SimpleInsItem:create(self.mItemHero, self.mContentHero, self.__cname .. "_self.mItemHero")
            local mTxtName = item:getChildGO("mTxtName"):GetComponent(ty.Text)
            local mImgBarBg = item:getChildGO("mImgBarBg"):GetComponent(ty.RectTransform)
            local mImgBar = item:getChildGO("mImgBar"):GetComponent(ty.RectTransform)
            local HeadGrid = item:getChildTrans("HeadGrid")
            local CDMask = item:getChildGO("CDMask")
            local CDMaskImg = CDMask:GetComponent(ty.Image)
            local CDTxt = item:getChildTrans("CDTxt"):GetComponent(ty.Text)
            table.insert(self.mHeroCdItemList, {CDMask = CDMask, CDMaskImg = CDMaskImg, CDTxt = CDTxt})
            
            local heroHeadGrid = HeroHeadGrid:poolGet()
            local heroVo = hero.HeroManager:getHeroVo(formationHeroVo.heroId)
            -- local heroConfigVo = hero.HeroManager:getHeroConfigVo(heroTid)
            heroHeadGrid:setData(heroVo)
            heroHeadGrid:setParent(HeadGrid)
            heroHeadGrid:setName("")
            heroHeadGrid:setScale(1)
            heroHeadGrid:setClickEnable(false)
    
            mTxtName.text = heroVo.name
            gs.TransQuick:SizeDelta01(mImgBarBg, hpBarWidth)
            gs.TransQuick:SizeDelta01(mImgBar, mainexploreHeroVo.nowHp / 100 * hpBarWidth)
            local function _clickMenuFun()
                self.mHeroCdTime = 0
                for k, v in pairs(self.mHeroCdItemList) do
                    v.CDMask:SetActive(true)
                    v.CDMaskImg.fillAmount = 1
                    v.CDTxt.text = ""
                end
                GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_MAIN_EXPLORE_CONTROL_HERO, {heroId = formationHeroVo.heroId})
            end
            item:addUIEvent("mImgClick", _clickMenuFun)
            table.insert(self.mHeroItemList, item)
        end
    end
    self:updateHeroCdTime()
end

function updateHeroCdTime(self)
    if(self.mHeroCdTime == nil or self.mHeroCdTime >= self.mHeroTotalCdTime)then
        self:resetHeroCdTime()
    else
        LoopManager:removeFrameByIndex(self.mHeroCdFrameSn)
        self.mHeroCdFrameSn = LoopManager:addFrame(1, 0, self,
        function(self, deltaTime)
            self.mHeroCdTime = self.mHeroCdTime + deltaTime
            if(self.mHeroCdTime >= self.mHeroTotalCdTime)then
                self:resetHeroCdTime()
            else
                for k, v in pairs(self.mHeroCdItemList) do
                    v.CDMask:SetActive(true)
                    v.CDMaskImg.fillAmount = 1 - self.mHeroCdTime / self.mHeroTotalCdTime
                    v.CDTxt.text = string.format("%0.2fs", self.mHeroTotalCdTime - self.mHeroCdTime)
                end
            end
        end)
    end
end

function resetHeroCdTime(self)
    self.mHeroCdTime = nil
    LoopManager:removeFrameByIndex(self.mHeroCdFrameSn)
    self.mHeroCdFrameSn = nil
    for k, v in pairs(self.mHeroCdItemList) do
        v.CDMask:SetActive(false)
    end
end

function clearTimeOut1(self)
    self.mGoPass:SetActive(false)
	if self.mTimeOutIndex1 then
		LoopManager:clearTimeout(self.mTimeOutIndex1)
		self.mTimeOutIndex1 = nil
	end
end

function clearTimeOut2(self)
    self.mGroupMessage:SetActive(false)
	if self.mTimeOutIndex2 then
		LoopManager:clearTimeout(self.mTimeOutIndex2)
		self.mTimeOutIndex2 = nil
	end
end

function removeRemindTweener(self)
    if self.mRemindTweener then
        self.mRemindTweener:Kill()
        self.mRemindTweener = nil
    end
end

function recoveryHeroItemList(self)
    if(self.mHeroItemList)then
        for i = 1, #self.mHeroItemList do
            self.mHeroItemList[i]:poolRecover()
        end
    end
    self.mHeroItemList = {}
    self.mHeroCdItemList = {}
end

function recoveryInteractItemList(self)
    if(self.mInteractItemList)then
        for i = 1, #self.mInteractItemList do
            self.mInteractItemList[i].item:poolRecover()
        end
    end
    self.mInteractItemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(63033):	"暂无目标"
	语言包: _TT(63021):	"请先通过前置事件"
	语言包: _TT(63032):	"正在和平期"
	语言包: _TT(63021):	"请先通过前置事件"
	语言包: _TT(63030):	"是否返回主界面？\n（探索进度自动保存，后续可继续完成本次探索）"
	语言包: _TT(63029):	"撤退则会探索失败，且当前探索进度都将重置\n是否继续"
]]
