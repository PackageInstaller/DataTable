-- @FileName:   BigHostelSceneUI.lua
-- @Description:   描述
-- @Author: ZDH
-- @Date:   2024-07-03 17:48:19
-- @Copyright:   (LY) 2024 锚点降临

module('game.bigHostel.view.BigHostelSceneUI', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("bigHostel/BigHostelSceneUI.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

escapeClose = 0 -- 是否能通过esc关闭窗口
isShowCloseAll = 0 --是否显示导航按钮

--构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(750, 600)
    self:setBg("")
    -- self:setTxtTitle(_TT(52021))
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mTouch = self:getChildGO("mTouch"):GetComponent(ty.LongPressOrClickEventTrigger)

    self.mBtnSwitch = self:getChildGO("mBtnSwitch")
    self.mBtnHide = self:getChildGO("mBtnHide")
    self.mBtnSkip = self:getChildGO("mBtnSkip")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnInit = self:getChildGO("mBtnInit")

    self.mLTGrounp = self:getChildTrans("mLTGrounp"):GetComponent(ty.RectTransform)

    self.mInfoGroup = self:getChildGO("mInfoGroup")
    self.mHideGroup = self:getChildGO("mHideGroup")

    self.mTalkBlockLayer = self:getChildGO("mTalkBlockLayer")
    self.mNameTxt = self:getChildGO("mNameTxt"):GetComponent(ty.Text)
    self.mMsgTxt = self:getChildGO("mMsgTxt"):GetComponent(ty.Text)
end

function initViewText(self)
    self:setBtnLabel(self.mBtnSkip, 84516, "跳过")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSwitch, self.onClickSwitch)
    self:addUIEvent(self.mBtnHide, self.onClickHide)
    self:addUIEvent(self.mBtnSkip, self.onClickSkip)
    self:addUIEvent(self.mBtnInit, self.onClickInit)
end

-- 设置货币栏
function setMoneyBar(self)
end

-- 点击关闭
function onClickClose(self)
    UIFactory:alertMessge(_TT(84515), true, function()
        if mainui.MainUIManager.isShowBigHostel then
            GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.InitIdle)
            GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
            local model_data = bigHostel.BigHostelManager:getHostelHero()
            model_data.main_type = BigHostelConst.SceneUI_Type.MIANUI
            bigHostel.BigHostelManager:setHostelData(model_data)
        end

        super.onClickClose(self)
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    end, _TT(1), nil, true, nil, _TT(2))
end

--激活
function active(self, args)
    super.active(self)

    self.m_args = args or {}

    self:AddEventListener()
    self:onAddPointerEvent()

    self.m_Hide = false

    local anchoredPosition = gs.VEC2_ZERO
    if self.m_args.main_type == BigHostelConst.SceneUI_Type.MIANUI then
        anchoredPosition = gs.Vector2(-100, 0)
    end

    self.mLTGrounp.anchoredPosition = anchoredPosition

    self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)

    self:playGoAction()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:RemoveEventListener()
    self:onRemovePointerEvent()

    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end

    CS.UnityEngine.Cursor.SetCursor("arts/texture/customUI/MouseIcon.png", gs.Vector2.zero, CS.UnityEngine.CursorMode.Auto)
end

-- 增加长按事件
function onAddPointerEvent(self)
    local function onPointerDownHandler()
        self:onPointerDownHandler()
    end
    self.mTouch.onPointerDown:AddListener(onPointerDownHandler)

    local function onPointerUpHandler()
        self:onPointerUpHandler()
    end
    self.mTouch.onPointerUp:AddListener(onPointerUpHandler)

    local function onDragHandler()
        self:onDragHandler()
    end
    self.mTouch.onDrag:AddListener(onDragHandler)

    local function onEndDragHandler()
        self:onEndDragHandler()
    end
    self.mTouch.onEndDrag:AddListener(onEndDragHandler)

    local function onClickHandler()
        self:onClickHandler()
    end
    self.mTouch.onClick:AddListener(onClickHandler)
end

-- 移除长按事件
function onRemovePointerEvent(self)
    self.mTouch.onPointerDown:RemoveAllListeners()
    self.mTouch.onPointerUp:RemoveAllListeners()
    self.mTouch.onDrag:RemoveAllListeners()
    self.mTouch.onEndDrag:RemoveAllListeners()
    self.mTouch.onClick:RemoveAllListeners()
end

function AddEventListener(self)
    GameDispatcher:addEventListener(EventName.HIDE_BIGHOSTEL_SCENEUI, self.onHideUI, self)
    GameDispatcher:addEventListener(EventName.SHOW_BIGHOSTEL_SCENEUI, self.onShowUI, self)

    GameDispatcher:addEventListener(EventName.BIGHOSTEL_SHOWSTART_OVER, self.playGoAction, self)

    GameDispatcher:addEventListener(EventName.BIGHOSTEL_ACTION_SHOWLINE, self.onCvPlaying, self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_ACTION_CLOSELINE, self.onCvEnd, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.HIDE_BIGHOSTEL_SCENEUI, self.onHideUI, self)
    GameDispatcher:removeEventListener(EventName.SHOW_BIGHOSTEL_SCENEUI, self.onShowUI, self)

    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SHOWSTART_OVER, self.playGoAction, self)

    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_ACTION_SHOWLINE, self.onCvPlaying, self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_ACTION_CLOSELINE, self.onCvEnd, self)
end

function checkTrial(self)
    if self.m_args.main_type == BigHostelConst.SceneUI_Type.TRIAL then
        gs.Message.Show(_TT(50091))
        return false
    end

    return true
end

function onClickSwitch(self)
    if not self:checkTrial() then
        return
    end

    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.Switch)
end

function onClickHide(self)
    if self.m_args.main_type == BigHostelConst.SceneUI_Type.MIANUI then
        self:close(self)
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    else
        self.m_Hide = not self.m_Hide
        self.mHideGroup:SetActive(not self.m_Hide)

        if self.m_args.main_type ~= BigHostelConst.SceneUI_Type.MIANUI then
            self.gBtnClose:SetActive(not self.m_Hide)
        end
    end
end

function onClickSkip(self)
    self:switchInitAction()
end

function onClickInit(self)
    if not self:checkTrial() then
        return
    end

    UIFactory:alertMessge(_TT(84517), true, function()
        self:switchInitAction()
    end, _TT(1), nil, true, nil, _TT(2))
end

function switchInitAction(self)
    GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_BLACK)

    self:setTimeout(1, function ()
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.InitIdle)
        GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
    end)
end

----是否正在播放入场动画
function playGoAction(self, value)
    if value == nil then
        local curSceneModel = bigHostel.BigHostelManager:getSceneModel()
        if curSceneModel then
            value = curSceneModel:getCurStateHash() == BigHostelConst.startStateHash
        end
    end

    self.mBtnSwitch:SetActive(not value)
    self.mBtnInit:SetActive(not value)
    self.mBtnHide:SetActive(not value)
    self.gBtnClose:SetActive(not value and self.m_args.main_type ~= BigHostelConst.SceneUI_Type.MIANUI and self.m_Hide == false)

    self.mBtnPlay:SetActive(value)
    self.mBtnSkip:SetActive(value)
end

function onHideUI(self)
    self.mInfoGroup:SetActive(false)
end

function onShowUI(self)
    self.mInfoGroup:SetActive(true)
end

----------------------------------------------------------CV
function onCvPlaying(self, args)
    if not self.mTalkBlockLayer.activeSelf then
        self.mTalkBlockLayer:SetActive(true)
    end

    self.mNameTxt.text = args.name
    self.mMsgTxt.text = args.line
end

function onCvEnd(self)
    if self.mTalkBlockLayer.activeSelf then
        self.mTalkBlockLayer:SetActive(false)
    end
end

----------------------------------------------------交互操作

function onFrame(self)
    if gs.ApplicationUtil.IsPC() then
        local mouseX = gs.UnityEngineUtil.GetMousePosX()
        local mousey = gs.UnityEngineUtil.GetMousePosY()

        if (mouseX < 0 or mouseX > gs.Screen.width)or (mousey < 0 or mousey > gs.Screen.width) then
            CS.UnityEngine.Cursor.SetCursor("arts/texture/customUI/MouseIcon.png", gs.Vector2.zero, CS.UnityEngine.CursorMode.Auto)
            return
        end

        if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(mouseX, mousey)).Count <= 1 then
            local curIcon = nil

            local sceneCamera = gs.CameraMgr:GetToScreenSceneCamera()
            local hitInfo = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, "Role", 100)
            if hitInfo and hitInfo.collider then
                curIcon = "arts/texture/customUI/Hostel_MouseIcon.png"
            else
                curIcon = "arts/texture/customUI/MouseIcon.png"
            end
            if curIcon ~= nil then
                if self.m_cursorType == nil or self.m_cursorType ~= cursor then
                    local cursor = gs.ResMgr:LoadTexture(curIcon)
                    CS.UnityEngine.Cursor.SetCursor(cursor, gs.Vector2.zero, CS.UnityEngine.CursorMode.Auto)

                    self.m_cursorType = cursor
                end
            end
        end
    end
end

function onPointerDownHandler(self)

end

function onPointerUpHandler(self)

end

function onDragHandler(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG)
end

function onEndDragHandler(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG_END)
end

function onClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SCREEN_MOUSECLICK)
end

return _M
