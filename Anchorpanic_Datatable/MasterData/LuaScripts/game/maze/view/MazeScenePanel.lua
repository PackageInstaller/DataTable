--[[ 
    迷宫场景面板
]]
module("maze.MazeScenePanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("maze/MazeScenePanel.prefab")

destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("")
    self:setTxtTitle(_TT(52088))
    self:setUICode(LinkCode.DupMaze)
end

-- 关闭所有UI
function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:__playerClose(false)
end

-- 玩家点击关闭
function onClickClose(self)
    if not self.mIsCanClick then return end

    super.onClickClose(self)
    self:__playerClose(true)
end

function openNavigationLink(self)
    if not self.mIsCanClick then return end
    super.openNavigationLink(self)
end

function __playerClose(self, isOpenEnterPanel)
    GameDispatcher:dispatchEvent(EventName.MAZE_REMOVE_EVENT_TRIGGER, { eventTrigger = self.mEventTrigger })
    GameDispatcher:dispatchEvent(EventName.CLOSE_MAZE_SCENE)
    if (isOpenEnterPanel) then
        GameDispatcher:dispatchEvent(EventName.EXIT_SCENE_AFTER_OPEN_PANEL, { battleType = PreFightBattleType.DupMaze })
        GameDispatcher:dispatchEvent(EventName.OPEN_MAINPLAY_PANEL, { type = mainPlay.MainPlayConst.MAINPLAY_CHALLAGE })
        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_PANEL)
    end
end

function open(self, args)
    super.open(self, args)
end

function initData(self)
    self.mPlayerMoveFrameSn = nil
end

-- 初始化
function configUI(self)
    self.mRootUI = self:getChildGO("root")
    self.mEventTrigger = self:getChildGO("ToucherEvent"):GetComponent(ty.LongPressOrClickEventTrigger)

    self.mGroupAbnormal = self:getChildGO('mGroupAbnormal')

    self.mGroupProgress = self:getChildTrans("mGroupProgress")
    self.mProgressItem = self:getChildGO("mProgressItem")
    self.mTxtProgressTitle = self:getChildGO("mTxtProgressTitle"):GetComponent(ty.Text)

    self.mArrowCG = self:getChildTrans("NodeArrow"):GetComponent(ty.CanvasGroup)

    self.mBtnGoods = self:getChildGO("mBtnGoods")
    self.mBtnFormationEdit = self:getChildGO("mBtnFormationEdit")
    self.mBtnReset = self:getChildGO("mBtnReset")

    self.mGoPass = self:getChildGO("GroupPass")
    self.mGroupMessage = self:getChildGO("GroupMessage")
    self.mTextMessage = self:getChildGO("TextMessage"):GetComponent(ty.Text)
    self.mImgMessage = self:getChildGO("ImgMessage"):GetComponent(ty.AutoRefImage)

    self.mBtnShowPlayer = self:getChildGO("mBtnShowPlayer")
    self.mCameraSlider = self:getChildGO('CameraSlider'):GetComponent(ty.Slider)
    self.mMaskClick = self:getChildGO("mMaskClick")

    self.mGroupDirTip = self:getChildTrans("GroupDirTip")
    self.mGoArrow = self:getChildGO("NodeArrow")
    self.mTransArrow = self:getChildTrans("NodeArrow")
    local rect = self:getChildGO("NodeArrow"):GetComponent(ty.RectTransform).rect
    self.mArrowHalfW, self.mArrowHalfH = rect.width / 2, rect.height / 2

    self.mToucherAbility = self:getChildGO("ToucherAbility")
    self:setGuideTrans("funcTips_mazeScene_1", self:getChildTrans("mGuideMaze3"))
    self:setGuideTrans("funcTips_mazeScene_2", self:getChildTrans("mGuideMaze1"))
    self:setGuideTrans("funcTips_mazeScene_3", self:getChildTrans("mGuideMaze4"))
    self:setGuideTrans("funcTips_mazeScene_4", self:getChildTrans("mGuideMaze2"))
    self:setGuideTrans("funcTips_mazeScene_5", self:getChildTrans("mBtnShowPlayer"))
    self:setGuideTrans("funcTips_mazeScene_6", self:getChildTrans("mBtnFormationEdit"))
end

function initViewText(self)
    self.mTxtProgressTitle.text = _TT(46009)
    self:setBtnLabel(self.mBtnFormationEdit, 46819, "战员状态")
    self:setBtnLabel(self.mBtnReset, 46818, "重置")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mGroupAbnormal, self.onOpenAbnormalView)
    self:addUIEvent(self.mBtnGoods, self.__onClickGoodsHandler)
    self:addUIEvent(self.mBtnFormationEdit, self.__onClickFormationEditHandler)
    self:addUIEvent(self.mBtnReset, self.__onClickResetHandler)
    self:addUIEvent(self.mBtnShowPlayer, self.__onClickShowPlayerHandler)
    self:addUIEvent(self:getChildGO("mBtnFuncTips"), self.onClickFuncTipsHandler)
end

-- 激活
function active(self, args)
    MoneyManager:setMoneyTidList()
    local function _cameraSliderChange(value)
        self.__onUpdateCameraHeightHandler(self, value)
    end
    self.mCameraSlider.onValueChanged:AddListener(_cameraSliderChange)
    GameDispatcher:addEventListener(EventName.MAZE_ASSETS_LOAD_FINISH, self.__onAssetsLoadFinishHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MAZE_SCENE_PANEL, self.__onCloseScenePanelHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAZE_TOUCH_ABILITY, self.__onUpdateTouchAbilityHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAZE_UI_VISIBLE, self.onUiVisibleHandler, self)
    maze.MazeCamera:addEventListener(maze.MazeCamera.CAMERA_UPDATE, self.__onUpdateCameraHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAZE_SCENE_DATA, self.__onUpdateMazeDataHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_MAZE_PANEL_DATA, self.__onUpdateMazeDataHandler, self)
    GameDispatcher:addEventListener(EventName.SHOW_MAZE_MESSAGE, self.__onShowMessageHandler, self)
    GameDispatcher:dispatchEvent(EventName.MAZE_ADD_EVENT_TRIGGER, { eventTrigger = self.mEventTrigger })
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(maze.MazeSceneManager:getMazeId())
    if (playerVo) then
        playerVo:addEventListener(playerVo.PLAYER_MOVE_UPDATE, self.__onPlayerMoveUpdateHandler, self)
        playerVo:addEventListener(playerVo.PLAYER_MOVE_FINISH, self.__onPlayerMoveFinishHandler, self)
        playerVo:addEventListener(playerVo.PLAYER_MOVE_END, self.__onPlayerMoveEndHandler, self)
    end
    self:refreshMaskClick(false)

    self.mToucherAbility:SetActive(false)
    self:__updateView()
end

-- 非激活
function deActive(self)
    MoneyManager:setMoneyTidList()
    self.mCameraSlider.onValueChanged:RemoveAllListeners()
    GameDispatcher:removeEventListener(EventName.MAZE_ASSETS_LOAD_FINISH, self.__onAssetsLoadFinishHandler, self)
    GameDispatcher:removeEventListener(EventName.CLOSE_MAZE_SCENE_PANEL, self.__onCloseScenePanelHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAZE_TOUCH_ABILITY, self.__onUpdateTouchAbilityHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAZE_UI_VISIBLE, self.onUiVisibleHandler, self)
    maze.MazeCamera:removeEventListener(maze.MazeCamera.CAMERA_UPDATE, self.__onUpdateCameraHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAZE_SCENE_DATA, self.__onUpdateMazeDataHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAZE_PANEL_DATA, self.__onUpdateMazeDataHandler, self)
    GameDispatcher:removeEventListener(EventName.SHOW_MAZE_MESSAGE, self.__onShowMessageHandler, self)
    GameDispatcher:dispatchEvent(EventName.MAZE_REMOVE_EVENT_TRIGGER, { eventTrigger = self.mEventTrigger })
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(maze.MazeSceneManager:getMazeId())
    if (playerVo) then
        playerVo:removeEventListener(playerVo.PLAYER_MOVE_UPDATE, self.__onPlayerMoveUpdateHandler, self)
        playerVo:removeEventListener(playerVo.PLAYER_MOVE_FINISH, self.__onPlayerMoveFinishHandler, self)
        playerVo:removeEventListener(playerVo.PLAYER_MOVE_END, self.__onPlayerMoveEndHandler, self)
    end
    self:__clearTimeOut1()
    self:__clearTimeOut2()
    self:__removeTweener()
    self:removeProgressItem()
    self:removePlayerMoveFrame()
    self:recoverAbnormalListItem()

    -- 界面被关，直接停止相机移动，防止新打开的界面用到相机被影响
    maze.MazeCamera:stopMove()
end

--是否可以点击界面
function refreshMaskClick(self,value)
    self.mIsCanClick = not value
    self.mMaskClick:SetActive(value)
end

function onOpenAbnormalView(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_ABNORMAL_SHOW_PANEL, { mazeId = maze.MazeSceneManager:getMazeId() })
end

function __onClickGoodsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_GOODS_PANEL, { mazeId = maze.MazeSceneManager:getMazeId() })
end

--打开规则说明界面
function onClickFuncTipsHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FUNCTIPS_VIEW, { id = LinkCode.DupMaze })
end

function __onClickFormationEditHandler(self)
    local formatoinCallFun = function(callReason)
        maze.MazeCamera:removePhysicsRaycaster()
    end
    maze.MazeCamera:addPhysicsRaycaster()
    local data = { mazeId = maze.MazeSceneManager:getMazeId(), uniqueTidList = maze.MazeManager:getMazeHeroList(maze.MazeSceneManager:getMazeId(), maze.HERO_SOURCE_TYPE.SUPPORT, true) }
    formation.openFormation(formation.TYPE.MAZE, maze.MazeSceneManager:getMazeId(), { data = data }, formatoinCallFun)
end

function __onClickResetHandler(self)
    UIFactory:alertMessge(
    "是否重新开启当前迷宫？\n(关卡宝箱不重置)",
    true,
    function()
        local mazeId = maze.MazeSceneManager:getMazeId()
        self:__playerClose(true)
        GameDispatcher:dispatchEvent(EventName.REQ_MAZE_RESET, { mazeId = mazeId })
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

function __onClickShowPlayerHandler(self)
    -- 定位置玩家格子位置
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(maze.MazeSceneManager:getMazeId())
    maze.MazeCamera:setRowCol(playerVo:getRow(), playerVo:getCol(), true)
end

function __onUpdateCameraHeightHandler(self, value)
    local maxHeight = maze.MazeCamera:getCameraMaxHeight()
    local minHeight = maze.MazeCamera:getCameraMinHeight()
    maze.MazeCamera:setCameraHeight(minHeight + (maxHeight - minHeight) * self.mCameraSlider.value)
end

function removeProgressItem(self)
    if (self.mProgressItemList) then
        for i = #self.mProgressItemList, 1, -1 do
            local item = self.mProgressItemList[i]
            item:poolRecover()
        end
    end
    self.mProgressItemList = {}
end

function __updateView(self)
    self:removeProgressItem()
    local mazeConfigVo = maze.MazeSceneManager:getMazeConfigVo(maze.MazeSceneManager:getMazeId())
    local mazeVo = maze.MazeManager:getMazeVo(maze.MazeSceneManager:getMazeId())

    local item = SimpleInsItem:create(self.mProgressItem, self.mGroupProgress, "MazeScenePanelmProgressItem")
    item:getChildGO("ImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("maze5/maze_box_1.png"), true)
    item:getChildGO("mTxtNowCount"):GetComponent(ty.Text).text = mazeConfigVo.allGorgeousBoxNum - mazeVo.remainGorgeousBoxNum
    item:getChildGO("mTxtTotalCount"):GetComponent(ty.Text).text = "/" .. mazeConfigVo.allGorgeousBoxNum
    table.insert(self.mProgressItemList, item)
    local function onClickBoxHandler()
        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_AWARDPREVIEW_PANEL, { propsList = mazeConfigVo:getGorgeousBoxAwardList() })
    end
    item:addUIEvent(nil, onClickBoxHandler)

    item = SimpleInsItem:create(self.mProgressItem, self.mGroupProgress, "MazeScenePanelmProgressItem")
    item:getChildGO("ImgIcon"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("maze5/maze_box_2.png"), true)
    item:getChildGO("mTxtNowCount"):GetComponent(ty.Text).text = mazeConfigVo.allNormalBoxNum - mazeVo.remainNormalBoxNum
    item:getChildGO("mTxtTotalCount"):GetComponent(ty.Text).text = "/" .. mazeConfigVo.allNormalBoxNum
    table.insert(self.mProgressItemList, item)
    local function onClickBoxHandler()
        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_AWARDPREVIEW_PANEL, { propsList = mazeConfigVo:getAbnormalBoxAwardList() })
    end
    item:addUIEvent(nil, onClickBoxHandler)

    self:__checkAllDupPass()
    self:updateAbnormal()
    self:onUiVisibleHandler(true)

    local maxHeight = maze.MazeCamera:getCameraMaxHeight()
    local minHeight = maze.MazeCamera:getCameraMinHeight()
    self.mCameraSlider.value = (maze.MazeCamera:getCameraCurHeight() - minHeight) / (maxHeight - minHeight)
end

function __checkAllDupPass(self)
    self:__clearTimeOut1()
    self.mGoPass:SetActive(false)
    local allDupPassData = maze.MazeManager:getAllDupPassData()
    if (allDupPassData) then
        if (allDupPassData.mazeId == maze.MazeSceneManager:getMazeId()) then
            self.mGoPass:SetActive(true)
            local function finishCall()
                self.mGoPass:SetActive(false)
                ShowAwardPanel:showPropsAwardMsg(allDupPassData.awardMsgList)
            end
            self.mTimeOutIndex1 = LoopManager:setTimeout(2, self, finishCall)
        end
        maze.MazeManager:setAllDupPassData(nil)
    end
end

-- 更新异常列表
function updateAbnormal(self)
    self:recoverAbnormalListItem()
    local mazeConfigVo = maze.MazeSceneManager:getMazeConfigVo(maze.MazeSceneManager:getMazeId())
    local abNormalCount = #mazeConfigVo.abnormalList
    if(abNormalCount > 0)then
        self:getChildGO("mImgABBg"):SetActive(true)
        for i = 1, abNormalCount do
            local item = SimpleInsItem:create(self:getChildGO("GroupAbnormalItem"), self:getChildTrans("mGroupAbnormal"), "DupImpliedAbnormalItem")
            table.insert(self.mAbnormalItemList, item)
        end
    else
        self:getChildGO("mImgABBg"):SetActive(false)
    end
end

-- 回收项
function recoverAbnormalListItem(self)
    if self.mAbnormalItemList then
        for i, v in pairs(self.mAbnormalItemList) do
            v:poolRecover()
        end
    end
    self.mAbnormalItemList = {}
end

function __onAssetsLoadFinishHandler(self)
    if(self.UIObject and not gs.GoUtil.IsGoNull(self.UIObject))then
        self.UIObject:SetActive(false)
    end
    maze.MazeCamera:setCameraFiledOfView(maze.MazeCamera:getCameraFiledOfView())
	GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, true)
    LoopManager:addFrame(1, 1, self, function()
        -- 确保一切都ok后才把加载界面关闭
        UIFactory:closeForcibly()
        
        if(self.UIObject and not gs.GoUtil.IsGoNull(self.UIObject))then
            self.UIObject:SetActive(true)
        end
        maze.MazeCamera:startCameraAction(function() 
            GameDispatcher:dispatchEvent(EventName.UPDATE_MAZE_TOUCH_ABILITY, false) 
        end)
    end)
end

function __onCloseScenePanelHandler(self)
    self:__playerClose(true)
end

function onUiVisibleHandler(self, visible)
    self.mRootUI:SetActive(visible)
end

function __onUpdateTouchAbilityHandler(self, args)
    self.mToucherAbility:SetActive(args)
end

function __onUpdateCameraHandler(self, args)
    self:__updateDirTip()
end

function __onPlayerMoveUpdateHandler(self, args)
    self:refreshMaskClick(true)
    self:__onPlayerMoveFrameUpdateHandler()
    self:addPlayerMoveFrame()
    self:__updateDirTip()
end

function __onPlayerMoveFinishHandler(self, args)
    self:refreshMaskClick(false)
end

function __onPlayerMoveFrameUpdateHandler(self)
    -- 定位置玩家实际位置
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(maze.MazeSceneManager:getMazeId())
    local playerThing = maze.MazeSceneThingManager:getThing(maze.THING_TYPE_PLAYER, playerVo:getRow(), playerVo:getCol())
    local localPos = playerThing:getTrans().localPosition
    maze.MazeCamera:setLPos(localPos.x, localPos.z, true, nil)
end

function __onPlayerMoveEndHandler(self)
    self:removePlayerMoveFrame()
end

function addPlayerMoveFrame(self)
    self:__onUpdateTouchAbilityHandler(true)
    if (not self.mPlayerMoveFrameSn) then
        self.mPlayerMoveFrameSn = LoopManager:addFrame(1, 0, self, self.__onPlayerMoveFrameUpdateHandler)
    end
end

function removePlayerMoveFrame(self)
    self:__onUpdateTouchAbilityHandler(false)
    if (self.mPlayerMoveFrameSn) then
        LoopManager:removeFrameByIndex(self.mPlayerMoveFrameSn)
        self.mPlayerMoveFrameSn = nil
    end
end

-- 更新方向提示
function __updateDirTip(self)
    local playerVo = maze.MazeSceneManager:getPlayerThingVo(maze.MazeSceneManager:getMazeId())
    local isInScreen, limitUiX, limitUiY, uiX, uiY = self:__getUIPosByRowCol(playerVo:getRow(), playerVo:getCol())
    if (isInScreen == nil) then
        self:__removeTweener()
        self.mGoArrow:SetActive(false)
    else
        if (isInScreen == true) then
            self:__removeTweener()
            self.mGoArrow:SetActive(false)
        else
            self.mGoArrow:SetActive(true)
            gs.TransQuick:UIPos(self.mTransArrow, limitUiX, limitUiY)
            gs.TransQuick:SetLRotation(self.mTransArrow, 0, 0, math.getTargeAngle(limitUiX, limitUiY, uiX, uiY))
            if (not self.mDirTipTween) then
                self.mDirTipTween = TweenFactory:canvasGroupAlphaTo(self.mArrowCG, 1, 0.01, 0.3, gs.DT.Ease.Linear, finishCall, delayTween, true)
            end
        end
    end
end

function __getUIPosByRowCol(self, row, col)
    local thing = maze.MazeSceneThingManager:getThing(maze.THING_TYPE_TILE, row, col)
    if (thing and thing:getTrans()) then
        local tileTopPos = thing:getTrans().position
        tileTopPos.y = tileTopPos.y + maze.MazeScene:getTileHeight()
        local uiPos = gs.CameraMgr:World2RelativeUI(tileTopPos, self.mGroupDirTip, 1)
        local halfW, halfH = ScreenUtil:getScreenSize(0.5)
        -- 微调
        halfW = halfW - 200
        halfH = halfH - 100
        local limitUiX, limitUiY = uiPos.x, uiPos.y
        local isInScreen = math.isInRect(limitUiX, limitUiY, -halfW, halfH, halfW, halfH, -halfW, -halfH, halfW, -halfH)
        if (not isInScreen) then
            limitUiX = math.max(limitUiX, -halfW + self.mArrowHalfW)
            limitUiX = math.min(limitUiX, halfW - self.mArrowHalfW)
            limitUiY = math.max(limitUiY, -halfH + self.mArrowHalfH)
            limitUiY = math.min(limitUiY, halfH - self.mArrowHalfH)
        end
        return isInScreen, limitUiX, limitUiY, uiPos.x, uiPos.y
    else
        return false, nil, nil, nil, nil
    end
end

function __onUpdateMazeDataHandler(self, args)
    self:__updateView()
end

function __onShowMessageHandler(self, args)
    self:__clearTimeOut2()
    self.mGroupMessage:SetActive(true)
    self.mTextMessage.text = args.message
    -- self.mImgMessage:SetImg("", true)
    local function finishCall()
        self.mGroupMessage:SetActive(false)
        if (args.callFun) then
            args.callFun()
        end
    end
    self.mTimeOutIndex2 = LoopManager:setTimeout(2, self, finishCall)
end

function __clearTimeOut1(self)
    self.mGoPass:SetActive(false)
    if self.mTimeOutIndex1 then
        LoopManager:clearTimeout(self.mTimeOutIndex1)
        self.mTimeOutIndex1 = nil
    end
end

function __clearTimeOut2(self)
    self.mGroupMessage:SetActive(false)
    if self.mTimeOutIndex2 then
        LoopManager:clearTimeout(self.mTimeOutIndex2)
        self.mTimeOutIndex2 = nil
    end
end

function __removeTweener(self)
    if self.mDirTipTween then
        self.mDirTipTween:Kill()
        self.mDirTipTween = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(46009):	"宝箱"
]]
