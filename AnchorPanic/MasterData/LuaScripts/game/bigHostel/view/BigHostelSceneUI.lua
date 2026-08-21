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
    self.mImg_Hide1 = self:getChildGO("mImg_Hide1")
    self.mImg_Hide2 = self:getChildGO("mImg_Hide2")

    self.mBtnSkip = self:getChildGO("mBtnSkip")
    self.mBtnPlay = self:getChildGO("mBtnPlay")
    self.mBtnInit = self:getChildGO("mBtnInit")

    self.mLTGrounp = self:getChildTrans("mLTGrounp"):GetComponent(ty.RectTransform)

    self.mInfoGroup = self:getChildGO("mInfoGroup")
    self.mHideGroup = self:getChildGO("mHideGroup")

    self.mTalkBlockLayer = self:getChildGO("mTalkBlockLayer")
    self.mNameTxt = self:getChildGO("mNameTxt"):GetComponent(ty.Text)
    self.mMsgTxt = self:getChildGO("mMsgTxt"):GetComponent(ty.Text)

    self.mSceneSelectGroup = self:getChildGO("mSceneSelectGroup")
    self.mSelectItem = self:getChildGO("mSelectItem")

    self.mImgSceneIcon = self:getChildGO("mImgSceneIcon"):GetComponent(ty.AutoRefImage)
    self.mBtnSwitchImg = self.mBtnSwitch:GetComponent(ty.AutoRefImage)

    self.mBtnCamera = self:getChildGO("mBtnCamera")
    self.mImgCamera1 = self:getChildGO("mImgCamera1")
    self.mImgCamera2 = self:getChildGO("mImgCamera2")

    self.mPropsItem = self:getChildGO("mPropsItem")
    self.mScenePropsGroup = self:getChildTrans("mScenePropsGroup")

    self.mBtnCold = self:getChildGO("mBtnCold")
    self.mBtnHot = self:getChildGO("mBtnHot")
    self.mSliderGlass = self:getChildGO("mSliderGlass"):GetComponent(ty.Slider)

    self.mDualViewPanel = self.UIObject:GetComponent(ty.CharacterDualViewPanel)
    self.mGroupDualViewPortrait = self:getChildGO("mGroupDualViewPortrait")
    local dualViewPortrait = self:getChildGO("mImgDualViewPortrait")
    self.mImgDualViewPortrait = dualViewPortrait and dualViewPortrait:GetComponent(ty.RawImage) or nil
    self.mImgTWClicEffect = self:getChildGO("mImgTWClicEffect")
end

function isDualViewSupportedMode(self)
    return self.m_UIType == BigHostelConst.SceneUI_Type.MIANUI or
    self.m_UIType == BigHostelConst.SceneUI_Type.INTERACTIVE or
    self.m_UIType == BigHostelConst.SceneUI_Type.TRIAL
end

function bindDualView(self)
    if not self:isDualViewSupportedMode() then
        return false
    end

    if self.mDualViewPanel == nil or gs.GoUtil.IsCompNull(self.mDualViewPanel) then
        logError("[DualView] BigHostelSceneUI is missing CharacterDualViewPanel.")
        return false
    end
    if self.mGroupDualViewPortrait == nil or gs.GoUtil.IsGoNull(self.mGroupDualViewPortrait) then
        logError("[DualView] BigHostelSceneUI is missing mGroupDualViewPortrait.")
        return false
    end
    if self.mImgDualViewPortrait == nil or gs.GoUtil.IsCompNull(self.mImgDualViewPortrait) then
        logError("[DualView] BigHostelSceneUI is missing mImgDualViewPortrait RawImage.")
        return false
    end
    local modelTrans = self.m_sceneModel and self.m_sceneModel:getDualViewBindTrans() or nil
    if modelTrans == nil or gs.GoUtil.IsTransNull(modelTrans) then
        logError("[DualView] BigHostel runtime model is not ready.")
        return false
    end

    if self.mDualViewPanel.IsBound == true then
        if self.m_dualViewBoundModelTrans == modelTrans then
            return true
        end
        self:unbindDualView()
    end

    if self.mDualViewPanel:SetQuality(gs.DualViewQuality.VeryHigh) ~= true then
        logError("[DualView] Failed to select High quality before binding.")
        return false
    end
    if self.mDualViewPanel:BindTarget(modelTrans, self.mImgDualViewPortrait) ~= true then
        logError("[DualView] Failed to bind the BigHostel runtime model.")
        return false
    end

    if self.mDualViewPanel.UsesArtCamera ~= true then
        self:unbindDualView()
        logError("[DualView] 绑定成功但未使用有效的美术参考相机。")
        return false
    end

    self.mDualViewPanel:SetCustomResolution(600, 600)

    self.m_dualViewBoundModelTrans = modelTrans
    return true
end

function refreshDualViewVisible(self)
    local panelValid = self.mDualViewPanel ~= nil and not gs.GoUtil.IsCompNull(self.mDualViewPanel)
    if not panelValid then
        return false
    end

    -- 模式切换是资源边界。共享界面离开互动或试用模式时，不能继续
    -- 持有上一个角色的副视图 RT。
    local modeEligible = self:isDualViewSupportedMode()
    local isBound = self.mDualViewPanel.IsBound == true
    if not modeEligible then
        if isBound then
            self:unbindDualView()
        end
        return false
    end

    local shouldBind = bigHostel.BigHostelManager:getDualViewEnabled()
    -- 共享 SceneUI 仍然存活时，运行时角色可能被替换。
    -- 重新进入绑定流程：目标未变化时复用，模型根节点变化时先解绑再绑定。
    if shouldBind then
        local modelTrans = self.m_sceneModel and self.m_sceneModel:getDualViewBindTrans() or nil
        if modelTrans == nil or gs.GoUtil.IsTransNull(modelTrans) then
            if isBound then
                self:unbindDualView()
                isBound = false
            end
        else
            self.m_dualViewBindAttemptedModelTrans = modelTrans
            isBound = self:bindDualView()
        end
    end

    local shouldShow = shouldBind and isBound and
    self.m_Hide ~= true and self.m_isDualViewSceneUIHidden ~= true
    if shouldShow then
        self.mDualViewPanel:SetVisible(true)
        shouldShow = self.mDualViewPanel.IsBound == true and
        self.mDualViewPanel.IsVisible == true
    elseif isBound then
        -- SetVisible(false) 会停止渲染回调并禁用 RawImage，
        -- 但保留同一个 RT，供下一次开启复用。
        self.mDualViewPanel:SetVisible(false)
    end
    return shouldShow
end

-- 运行时角色或美术参考相机被销毁、重建，或违反绑定契约时，C# 可能异步解绑。
-- 只有业务状态要求副视图显示时才重新协调；普通隐藏必须保留现有绑定。
function syncDualViewPanelState(self)
    if self.mDualViewPanel == nil or gs.GoUtil.IsCompNull(self.mDualViewPanel) then
        return
    end
    if not self:isDualViewSupportedMode() or
        bigHostel.BigHostelManager:getDualViewEnabled() ~= true or
        self.m_Hide == true or self.m_isDualViewSceneUIHidden == true then
        return
    end

    local modelTrans = self.m_sceneModel and self.m_sceneModel:getDualViewBindTrans() or nil
    local modelReady = modelTrans ~= nil and not gs.GoUtil.IsTransNull(modelTrans)
    if modelReady and
        (self.mDualViewPanel.IsBound ~= true or self.m_dualViewBoundModelTrans ~= modelTrans) and
        self.m_dualViewBindAttemptedModelTrans ~= modelTrans then
        -- 覆盖两种情况：提前开启时模型稍后才完成加载，
        -- 以及运行时角色根节点替换但没有额外 UI 事件通知。
        self.m_dualViewBindAttemptedModelTrans = modelTrans
        self:refreshDualViewVisible()
        return
    end

    if self.mDualViewPanel.IsBound == true and self.mDualViewPanel.IsVisible == true then
        return
    end

    -- C# 绑定失败时不在每帧重试。若仍残留部分绑定，只停止渲染，
    -- 等待下一次明确的刷新事件重新尝试。
    if self.mDualViewPanel.IsBound == true then
        self.mDualViewPanel:SetVisible(false)
    end
end

function unbindDualView(self)
    local panelValid = self.mDualViewPanel ~= nil and not gs.GoUtil.IsCompNull(self.mDualViewPanel)
    if panelValid then
        self.mDualViewPanel:SetVisible(false)
    end
    if panelValid then
        self.mDualViewPanel:Unbind()
    end
    self.m_dualViewBoundModelTrans = nil
end

function onDualViewTargetRelease(self)
    self:unbindDualView()
    self.m_dualViewBindAttemptedModelTrans = nil
end

function initViewText(self)
    self:setBtnLabel(self.mBtnSkip, 84516, "跳过")

    if self.m_childGos["mBtn4535_2_h_StartTW"] then
        self:setBtnLabel(self.m_childGos["mBtn4535_2_h_StartTW"], 50096, "跳舞小游戏")
    end

    if self.m_childGos["mBtn4535_2_h_StartCZ"] then
        self:setBtnLabel(self.m_childGos["mBtn4535_2_h_StartCZ"], 50097, "跳舞小游戏")
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSwitch, self.onClickSwitch)
    self:addUIEvent(self.mBtnHide, self.onClickHide)
    self:addUIEvent(self.mBtnSkip, self.onClickSkip)
    self:addUIEvent(self.mBtnInit, self.onClickInit)
    self:addUIEvent(self.mBtnCamera, self.onClickCamera)
    self:addUIEvent(self.mBtnCold, self.onClickCold)
    self:addUIEvent(self.mBtnHot, self.onClickHot)

    local onValueChanged = function (val)
        if self.m_initGlassValue == true then
            return
        end
        self:onSliderGlassValueChanged(val)
    end

    self.mSliderGlass.onValueChanged:AddListener(onValueChanged)
    self.mSliderGlass.minValue = 0.3
    self.mSliderGlass.maxValue = 0.9
end

-- 设置货币栏
function setMoneyBar(self)
end

-- 点击关闭
function onClickClose(self)
    UIFactory:alertMessge(_TT(84515), true, function()
        local isShowBigHostel, hostel_data = bigHostel.BigHostelManager:getMainUIShow()
        local model_data = bigHostel.BigHostelManager:getHostelHero()

        if isShowBigHostel and model_data.model_id == hostel_data.model_id and model_data.heroTid == hostel_data.heroTid then
            GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.InitIdle)
            GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
        end

        super.onClickClose(self)
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    end, _TT(1), nil, true, nil, _TT(2))
end

--激活
function active(self, args)
    super.active(self)

    local model_data = bigHostel.BigHostelManager:getHostelHero()
    self.m_UIType = model_data.main_type

    self:AddEventListener()
    self:onAddPointerEvent()

    self.m_Hide = false
    self.m_isDualViewSceneUIHidden = false

    local anchoredPosition = gs.VEC2_ZERO
    if self.m_UIType == BigHostelConst.SceneUI_Type.MIANUI then
        anchoredPosition = gs.Vector2(-100, 0)
    end

    self.mLTGrounp.anchoredPosition = anchoredPosition

    self.m_sceneModel = bigHostel.BigHostelManager:getSceneModel()
    self.m_dualViewBindAttemptedModelTrans = nil
    self:refreshDualViewVisible()

    self.m_frameSn = LoopManager:addFrame(1, 0, self, self.onFrame)

    self:playGoAction()
    self:checkCameraBtnState()
    self:checkClickCameraState()
    self:refreshUIComponent()
    self:onShowSceneProps()
end

--反激活（销毁工作）
function deActive(self)
    self:unbindDualView()
    -- bigHostel.BigHostelManager:setDualViewEnabled(false)

    super.deActive(self)

    self:RemoveEventListener()
    self:onRemovePointerEvent()

    self.mSliderGlass.onValueChanged:RemoveAllListeners()

    self:clearSceneProps()

    self:clearColdHotTimeOutSn()

    if self.m_frameSn then
        LoopManager:removeFrameByIndex(self.m_frameSn)
        self.m_frameSn = nil
    end

    self:ClearTw()
    self:clearTwClickEffect()
    self:clearCZClickEffect()

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
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_DUALVIEW_ENABLE_CHANGE, self.refreshDualViewVisible, self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_DUALVIEW_TARGET_RELEASE, self.onDualViewTargetRelease, self)

    GameDispatcher:addEventListener(EventName.BIGHOSTEL_SHOWSTART_OVER, self.playGoAction, self)

    GameDispatcher:addEventListener(EventName.BIGHOSTEL_ACTION_SHOWLINE, self.onCvPlaying, self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_ACTION_CLOSELINE, self.onCvEnd, self)

    GameDispatcher:addEventListener(EventName.BIGHOSTEL_SWITCH_ANISTATE, self.onAnimSwitch, self)

    GameDispatcher:addEventListener(EventName.BIGHOSTEL_SHOWUICOMPONENT, self.refreshUIComponent, self)
    GameDispatcher:addEventListener(EventName.BIGHOSTEL_SHOW_SCENEPROPSLIST, self.onShowSceneProps, self)
end

function RemoveEventListener(self)
    GameDispatcher:removeEventListener(EventName.HIDE_BIGHOSTEL_SCENEUI, self.onHideUI, self)
    GameDispatcher:removeEventListener(EventName.SHOW_BIGHOSTEL_SCENEUI, self.onShowUI, self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_DUALVIEW_ENABLE_CHANGE, self.refreshDualViewVisible, self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_DUALVIEW_TARGET_RELEASE, self.onDualViewTargetRelease, self)

    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SHOWSTART_OVER, self.playGoAction, self)

    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_ACTION_SHOWLINE, self.onCvPlaying, self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_ACTION_CLOSELINE, self.onCvEnd, self)

    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SWITCH_ANISTATE, self.onAnimSwitch, self)

    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SHOWUICOMPONENT, self.refreshUIComponent, self)
    GameDispatcher:removeEventListener(EventName.BIGHOSTEL_SHOW_SCENEPROPSLIST, self.onShowSceneProps, self)

end

function checkTrial(self)
    if self.m_UIType == BigHostelConst.SceneUI_Type.TRIAL then
        gs.Message.Show(_TT(50091))
        return false
    end

    return true
end

function onSliderGlassValueChanged(self, value)
    self.m_sceneModel:setGlassAlpha(value)
end

function onClickCold(self)
    self:clearColdHotTimeOutSn()
    self.m_coldHotTimer = self:setTimeout(0.5, function ()
        self.m_sceneModel:setInt("interactive", 1)
    end)
end

function onClickHot(self)
    self:clearColdHotTimeOutSn()
    self.m_coldHotTimer = self:setTimeout(0.5, function ()
        self.m_sceneModel:setInt("interactive", 2)
    end)

end

function clearColdHotTimeOutSn(self)
    if self.m_coldHotTimer then
        self:clearTimeout(self.m_coldHotTimer)
        self.m_coldHotTimer = nil
    end
end

function onClickSwitch(self)
    if not self:checkTrial() then
        return
    end

    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.Switch)
end

function onClickHide(self)
    if self.m_UIType == BigHostelConst.SceneUI_Type.MIANUI then
        self:close(self)
        GameDispatcher:dispatchEvent(EventName.ENTER_NEW_MAP, MAP_TYPE.MAIN_CITY)
    else
        self.m_Hide = not self.m_Hide
        self.mHideGroup:SetActive(not self.m_Hide)
        self.mImg_Hide1:SetActive(self.m_Hide)
        self.mImg_Hide2:SetActive(not self.m_Hide)

        if self.m_UIType ~= BigHostelConst.SceneUI_Type.MIANUI then
            self.gBtnClose:SetActive(not self.m_Hide)
        end

        self:refreshDualViewVisible()
    end
end

function onClickSkip(self)
    self:switchInitAction()
    self:playGoAction(false)
end

function onClickInit(self)
    if not self:checkTrial() then
        return
    end

    if self.m_sceneModel.m_onFreeGq == true then
        return
    end

    UIFactory:alertMessge(_TT(84517), true, function()
        self:switchInitAction()
    end, _TT(1), nil, true, nil, _TT(2))
end

function onClickCamera(self)
    local state = bigHostel.BigHostelManager:getDisableFreeCameraReset()

    bigHostel.BigHostelManager:disableFreeCameraReset(not state)
    self:checkClickCameraState()
end

function checkClickCameraState(self)
    local state = bigHostel.BigHostelManager:getDisableFreeCameraReset()

    self.mImgCamera1:SetActive(not state)
    self.mImgCamera2:SetActive(state)
end

function switchInitAction(self)
    GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_BLACK)

    LoopManager:setTimeout(1, self, function ()
        GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_LIVE_SETTRIGGER, BigHostelConst.BaseAnimatorParams.InitIdle)
        GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
    end)
end

----是否正在播放入场动画
function playGoAction(self, value)
    if value == nil then
        value = AnimatorUtil.isPlayHash(self.m_sceneModel.m_ani, BigHostelConst.startStateHash)
    end

    self.mBtnSwitch:SetActive(not value)
    self.mBtnInit:SetActive(not value)
    self.mBtnHide:SetActive(not value)
    self.gBtnClose:SetActive(not value and self.m_UIType ~= BigHostelConst.SceneUI_Type.MIANUI and self.m_Hide == false)

    self.mBtnPlay:SetActive(value)
    self.mBtnSkip:SetActive(value)
end

function onHideUI(self)
    self.m_isDualViewSceneUIHidden = true
    self.mInfoGroup:SetActive(false)
    self:refreshDualViewVisible()
end

function onShowUI(self)
    self.m_isDualViewSceneUIHidden = false
    self.mInfoGroup:SetActive(true)
    self:refreshDualViewVisible()
end

function onAnimSwitch(self, ani_state)
    self:checkCameraBtnState()
end

function onShowSceneProps(self)
    self:clearSceneProps()

    local args = bigHostel.BigHostelManager:getSceneProps()
    if table.empty(args) then
        self.mScenePropsGroup.gameObject:SetActive(false)
        return
    end

    self.m_scenePropKey = args.key

    for _, data in pairs(args.list) do
        local item = SimpleInsItem:create(self.mPropsItem, self.mScenePropsGroup, "BigHostelSceneUI_sceneProps")
        item.data = data
        item:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(data.icon, false)
        local bgPath = data.bg or "arts/ui/pack/bigHostel/bigHostel_btn_18.png"
        item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(bgPath, false)

        item:getChildGO("mEffects"):SetActive(false)

        if data.clickCall then
            item:addUIEvent(nil, function (_item)
                local curState = _item.data.clickCall()
                for _, v in pairs(self.m_scenePropsItems) do
                    v:getChildGO("mEffects"):SetActive(v.data.state == curState)
                end
            end)
        end

        table.insert(self.m_scenePropsItems, item)
    end

    if not self.mScenePropsGroup.gameObject.activeSelf then
        self.mScenePropsGroup.gameObject:SetActive(true)
    end
end

function clearSceneProps(self)
    if self.m_scenePropsItems then
        for _, v in pairs(self.m_scenePropsItems) do
            v.data = nil
            v:poolRecover()
        end
    end

    self.m_scenePropsItems = {}
    self.m_scenePropKey = nil
end

function refreshUIComponent(self)
    local dic = bigHostel.BigHostelManager:getUIComponentShowState()
    for key, data in pairs(dic) do
        self:onShowUIComponent(data)
    end
end

function onShowUIComponent(self, args)
    local component_name = args.key
    local value = args.val

    if component_name == "mGroupDualViewPortrait" then
        bigHostel.BigHostelManager:setDualViewEnabled(value)
        return
    end

    local component = self.m_childGos[component_name]
    if component ~= nil then
        local isCZClickButton = string.find(component_name, "mBtn4535_2_h_CZ_ClickLeft_", 1, true) == 1
            or string.find(component_name, "mBtn4535_2_h_CZ_ClickRight_", 1, true) == 1

        if args.text ~= nil then
            local textComponent = component:GetComponent(ty.Text)
            if textComponent ~= nil then
                if component_name == "mTextComboCount" and tonumber(textComponent.text) ~= args.text then
                    textComponent.text = args.text
                    local animator = component:GetComponent(ty.Animator)
                    animator:SetTrigger("show")
                end
            end
        end

        local pointerTrigger = component:GetComponent(ty.LongPressOrClickEventTrigger)
        if pointerTrigger ~= nil then
            pointerTrigger.onPointerDown:RemoveAllListeners()
            pointerTrigger.onPointerUp:RemoveAllListeners()

            if value then
                if isCZClickButton then
                    pointerTrigger.onPointerDown:AddListener(function ()
                        self:playCZClickEffect(component)
                    end)
                end
                if args.pointDownCall ~= nil then
                    pointerTrigger.onPointerDown:AddListener(function ()
                        args.pointDownCall(self)
                    end)
                end
                if args.pointUpCall ~= nil then
                    pointerTrigger.onPointerUp:AddListener(function ()
                        args.pointUpCall(self)
                    end)
                end
            end
        end

        if component.activeSelf == value then
            if value and args.call ~= nil then
                if self.uiEventList then
                    self:removeUIEvent(component)
                end
                self:addUIEvent(component, function ()
                    self:ClearTw()
                    args.call(self)
                    if string.find(component_name, "mImgCliclItem_") then
                        self:playTwClickEffect(component)
                    end
                end)
            end
            return
        end

        component:SetActive(value)

        if value then
            if component_name == "1503_5_YS" then
                self.m_initGlassValue = true
                self.mSliderGlass.value = self.m_sceneModel:getGlassAlpha()
                self.m_initGlassValue = nil
            elseif string.find(component_name, "mImgCliclItem_") then--4535_2_h_TW 点圈圈按钮逻辑
                local RectTransform = component:GetComponent(ty.RectTransform)
                local parent_RectTransform = component.transform.parent:GetComponent(ty.RectTransform)
                local width = parent_RectTransform.rect.width
                local height = parent_RectTransform.rect.height
                --计算横向的位置
                local w1 = width / args.nums
                local w2 = w1 / 2
                local index = tonumber(string.split(component_name, "_")[2])
                local pos_x = (index - 1) * w1 + w2

                RectTransform.anchoredPosition = gs.Vector2(pos_x, math.random(0, height))

                local scaleRectTrans = component.transform:Find("mImg_01"):GetComponent(ty.RectTransform)
                gs.TransQuick:Scale(scaleRectTrans, 1.5, 1.5, 1)
                local delayTime = math.random(50, 100) / 100--延迟多久开始缩小
                local durationTime = math.random(80, 150) / 100 --多久缩小到最小

                self:ClearTw()
                self.mTwClickTimeOutSn = self:setTimeout(delayTime, function ()
                    self.mTwClickTweener = scaleRectTrans:DOScale(gs.Vector3(0.2, 0.2, 1), durationTime)
                    self.mTwClickTweener:OnComplete(function ()
                        self:ClearTw()

                        if args.tweenCall then
                            args.tweenCall()
                        end
                    end)
                end)
            end

            if args.call ~= nil then
                self:addUIEvent(component, function ()
                    self:ClearTw()
                    args.call(self)
                    if string.find(component_name, "mImgCliclItem_") then
                        self:playTwClickEffect(component)
                    end
                end)
            end
        else
            if string.find(component_name, "mImgCliclItem_") then
                self:ClearTw()
            end
            if self.uiEventList then
                self:removeUIEvent(component)
            end
        end
    end
end

function playTwClickEffect(self, clickComponent)
    if self.mImgTWClicEffect == nil or gs.GoUtil.IsGoNull(self.mImgTWClicEffect) then
        return
    end

    local clickRect = clickComponent:GetComponent(ty.RectTransform)
    local templateRect = self.mImgTWClicEffect:GetComponent(ty.RectTransform)
    if clickRect == nil or templateRect == nil then
        return
    end

    local effect = gs.GameObject.Instantiate(self.mImgTWClicEffect, templateRect.parent, false)
    if effect == nil or gs.GoUtil.IsGoNull(effect) then
        return
    end

    local effectRect = effect:GetComponent(ty.RectTransform)
    if effectRect == nil then
        gs.GameObject.Destroy(effect)
        return
    end
    effectRect.anchoredPosition = clickRect.anchoredPosition
    effect.transform:SetAsLastSibling()
    effect:SetActive(true)

    self.mTwClickEffectList = self.mTwClickEffectList or {}
    local effectData = {go = effect}
    table.insert(self.mTwClickEffectList, effectData)
    effectData.timeoutSn = self:setTimeout(1, function ()
        if effectData.go and not gs.GoUtil.IsGoNull(effectData.go) then
            gs.GameObject.Destroy(effectData.go)
        end
        for i = #self.mTwClickEffectList, 1, -1 do
            if self.mTwClickEffectList[i] == effectData then
                table.remove(self.mTwClickEffectList, i)
                break
            end
        end
    end)
end

function clearTwClickEffect(self)
    if self.mTwClickEffectList then
        for i = #self.mTwClickEffectList, 1, -1 do
            local effectData = self.mTwClickEffectList[i]
            if effectData.timeoutSn then
                self:clearTimeout(effectData.timeoutSn)
            end
            if effectData.go and not gs.GoUtil.IsGoNull(effectData.go) then
                gs.GameObject.Destroy(effectData.go)
            end
            table.remove(self.mTwClickEffectList, i)
        end
    end
end

function playCZClickEffect(self, clickComponent)
    local effectTrans = clickComponent.transform:Find("mEffect")
    if effectTrans == nil or gs.GoUtil.IsTransNull(effectTrans) then
        return
    end

    local effect = effectTrans.gameObject
    local effectKey = clickComponent:GetHashCode()
    self.mCZClickEffectDic = self.mCZClickEffectDic or {}
    local oldEffectData = self.mCZClickEffectDic[effectKey]
    if oldEffectData and oldEffectData.timeoutSn then
        self:clearTimeout(oldEffectData.timeoutSn)
    end

    effect:SetActive(false)
    effect:SetActive(true)
    local effectData = {effect = effect}
    self.mCZClickEffectDic[effectKey] = effectData
    effectData.timeoutSn = self:setTimeout(1, function ()
        if effectData.effect and not gs.GoUtil.IsGoNull(effectData.effect) then
            effectData.effect:SetActive(false)
        end
        if self.mCZClickEffectDic[effectKey] == effectData then
            self.mCZClickEffectDic[effectKey] = nil
        end
    end)
end

function clearCZClickEffect(self)
    if self.mCZClickEffectDic then
        for _, effectData in pairs(self.mCZClickEffectDic) do
            if effectData.timeoutSn then
                self:clearTimeout(effectData.timeoutSn)
            end
            if effectData.effect and not gs.GoUtil.IsGoNull(effectData.effect) then
                effectData.effect:SetActive(false)
            end
        end
        self.mCZClickEffectDic = {}
    end
end

function ClearTw(self)
    if self.mTwClickTimeOutSn then
        self:clearTimeout(self.mTwClickTimeOutSn)
        self.mTwClickTimeOutSn = nil
    end

    if self.mTwClickTweener then
        self.mTwClickTweener:Kill()
        self.mTwClickTweener = nil
    end
end

function checkCameraBtnState(self)
    local can = self.m_sceneModel:canDisableFreeCameraReset()
    self.mBtnCamera:SetActive(can)
    if can == false then
        bigHostel.BigHostelManager:disableFreeCameraReset(false)
        self:checkClickCameraState()
    end
end

----------------------------------------------------------CV
function onCvPlaying(self, args)
    logAll(args)
    if string.NullOrEmpty(args.line) then
        return
    end

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
    self:syncDualViewPanelState()

    if not gs.Application.isMobilePlatform then
        if gs.Input.GetKeyDown(gs.KeyCode.RightArrow) then
            self:invokeCZButtonPointerEvent("mBtn4535_2_h_CZ_ClickRight_1", true)
        elseif gs.Input.GetKeyUp(gs.KeyCode.RightArrow) then
            self:invokeCZButtonPointerEvent("mBtn4535_2_h_CZ_ClickRight_1", false)
        end

        if gs.Input.GetKeyDown(gs.KeyCode.LeftArrow) then
            self:invokeCZButtonPointerEvent("mBtn4535_2_h_CZ_ClickLeft_1", true)
        elseif gs.Input.GetKeyUp(gs.KeyCode.LeftArrow) then
            self:invokeCZButtonPointerEvent("mBtn4535_2_h_CZ_ClickLeft_1", false)
        end
    end

    if gs.ApplicationUtil.IsPC() then
        local mouseX = gs.UnityEngineUtil.GetMousePosX()
        local mousey = gs.UnityEngineUtil.GetMousePosY()

        local showInteractCursor = false

        if (mouseX > 0 and mouseX < gs.Screen.width)and (mousey > 0 or mousey < gs.Screen.width) then
            if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(mouseX, mousey)).Count <= 1 then
                if self.m_sceneModel:getCanInteract() then
                    local sceneCamera = gs.CameraMgr:GetToScreenSceneCamera()
                    local hitInfo_1 = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, "Role", 100)
                    local hitInfo_2 = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, "RealLight", 100)
                    if(hitInfo_1 ~= nil and hitInfo_1.collider ~= nil) then
                        if hitInfo_1.collider.gameObject.tag ~= "Door" then
                            showInteractCursor = true
                        end
                    end

                    if not showInteractCursor then
                        if(hitInfo_2 ~= nil and hitInfo_2.collider ~= nil) then
                            if hitInfo_2.collider.gameObject.tag ~= "Door" then
                                showInteractCursor = true
                            end
                        end
                    end
                end
            end
        end

        if self.m_cursorType == nil or self.m_cursorType ~= showInteractCursor then
            local cursor_path = "arts/texture/customUI/MouseIcon.png"
            if showInteractCursor then
                cursor_path = "arts/texture/customUI/Hostel_MouseIcon.png"
            end

            local cursor = gs.ResMgr:LoadTexture(cursor_path)
            CS.UnityEngine.Cursor.SetCursor(cursor, gs.Vector2.zero, CS.UnityEngine.CursorMode.Auto)

            self.m_cursorType = showInteractCursor
        end
    end

    local model_data = bigHostel.BigHostelManager:getHostelHero()
    if model_data.main_type ~= BigHostelConst.SceneUI_Type.TRIAL and self.m_sceneModel:canSwitch() then
        if gs.Input.GetMouseButtonDown(0) then
            if gs.UnityEngineUtil.GetRaycastUIResults(gs.Vector2(gs.UnityEngineUtil.GetMousePosX(), gs.UnityEngineUtil.GetMousePosY())).Count <= 1 then
                local sceneCamera = gs.CameraMgr:GetToScreenSceneCamera()
                local hitInfo_1 = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, "Role", 100)
                local hitInfo_2 = gs.UnityEngineUtil.RaycastByUICamera(sceneCamera, "RealLight", 100)
                if (hitInfo_1 == nil or hitInfo_1.collider == nil) and (hitInfo_2 == nil or hitInfo_2.collider == nil) and self.m_sceneModel:getCanInteract() then

                    if self.m_clickTime == nil then
                        self.m_clickTime = gs.Time.time
                    end
                end
            end
        elseif not gs.Input.GetMouseButton(0) then
            if self.m_clickTime ~= nil then
                self.m_clickTime = nil
                self.m_sceneModel:disableFreeCamera(false)
            end
        end

        if self.m_clickTime ~= nil then
            if gs.Time.time - self.m_clickTime >= 0.3 then
                self:onSelectSceneLongClick()
            end
        else
            if self.mSceneSelectGroup.activeSelf then
                self.mSceneSelectGroup:SetActive(false)

                if self.m_sceneItemList then
                    for _, v in pairs(self.m_sceneItemList) do
                        v:poolRecover()
                    end

                    self.m_sceneItemList = nil
                end

                if self.m_selectSceneIndex ~= nil and self.m_selectSceneIndex ~= 0 then
                    local idle = "idle_" .. self.m_selectSceneIndex
                    if self.m_curModelIdle ~= idle then
                        GameDispatcher:dispatchEvent(EventName.SHOW_BIGHOSTEL_BLACK)
                        LoopManager:setTimeout(1, self, function ()
                            self.m_sceneModel:setTrigger(idle)
                            self.m_sceneModel:lookAtWeight(0, 0, 0, 0, 0, 0, 0)

                            self.m_selectSceneIndex = nil

                            GameDispatcher:dispatchEvent(EventName.HIDE_BIGHOSTEL_BLACK)
                        end)
                    end

                end
            end
        end
    end

    local scene_list = self.m_sceneModel.Scene_IconList
    if table.empty(scene_list) then
        self.mImgSceneIcon.gameObject:SetActive(false)

        self.mBtnSwitchImg:SetImg("arts/ui/pack/bigHostel/bigHostel_btn_07.png")
    else
        if self.m_curModelIdle ~= self.m_sceneModel:getCurIdle() then
            self.m_curModelIdle = self.m_sceneModel:getCurIdle()
            local index = string.split(self.m_curModelIdle, "_")
            local scene_list = self.m_sceneModel.Scene_IconList

            self.mImgSceneIcon.gameObject:SetActive(true)
            self.mImgSceneIcon:SetImg(string.format("arts/ui/pack/bigHostel/%s.png", scene_list[tonumber(index[2])]))

            self.mBtnSwitchImg:SetImg("arts/ui/pack/bigHostel/bigHostel_btn_08.png")
        end
    end
end

function invokeCZButtonPointerEvent(self, componentName, isPointerDown)
    local component = self.m_childGos[componentName]
    if component == nil or not component.activeSelf then
        return
    end

    local pointerTrigger = component:GetComponent(ty.LongPressOrClickEventTrigger)
    if pointerTrigger == nil then
        return
    end

    if isPointerDown then
        pointerTrigger.onPointerDown:Invoke()
    else
        pointerTrigger.onPointerUp:Invoke()
    end
end

function onSelectSceneLongClick(self)
    local scene_list = self.m_sceneModel.Scene_IconList
    local scene_num = table.nums(scene_list)
    if scene_num <= 0 then
        return
    end

    local Screen_rectTrans = self.UIObject:GetComponent(ty.RectTransform)
    local ScreenResolution_width = Screen_rectTrans.rect.width
    local ScreenResolution_heigt = Screen_rectTrans.rect.height

    local camera = gs.CameraMgr:GetUICamera();
    local vector2 = camera:ScreenToViewportPoint(gs.Input.mousePosition)

    if not self.mSceneSelectGroup.activeSelf and self.m_onDrag ~= true then
        self.mSceneSelectGroup:SetActive(true)

        self.m_sceneItemList = {}
        for i = 1, scene_num do
            local parent = self:getChildTrans(string.format("mSelectPoint (%s)", i))
            local item = SimpleInsItem:create(self.mSelectItem, parent, "BigHostelSceneUI_sceneItem")
            item:getChildGO("mIcon"):GetComponent(ty.AutoRefImage):SetImg(string.format("arts/ui/pack/bigHostel/%s.png", scene_list[i]))

            table.insert(self.m_sceneItemList, item)
        end

        self.m_clickPos = gs.Vector3(vector2.x * ScreenResolution_width, vector2.y * ScreenResolution_heigt, 0)
        self.mSceneSelectGroup:GetComponent(ty.RectTransform).anchoredPosition = gs.Vector2(self.m_clickPos.x, self.m_clickPos.y)

        self.m_sceneModel:disableFreeCamera(true)
    end

    local pos = gs.Vector3(vector2.x * ScreenResolution_width, vector2.y * ScreenResolution_heigt, 0)
    local angle = self:getAngle(pos - self.m_clickPos, gs.Vector3.up)
    if angle ~= 0 then
        angle = angle + 18
        if angle >= 360 then
            angle = angle - 360
        end

        self.m_selectSceneIndex = math.ceil(angle / 36)

        if self.m_selectSceneIndex > scene_num then
            self.m_selectSceneIndex = 0
        end
    else
        self.m_selectSceneIndex = 0
    end

    for i = 1, 10 do
        self:getChildGO(string.format("mImgSelect (%s)", i)):SetActive(i == self.m_selectSceneIndex)
    end

end

function getAngle(self, from, to)
    local angle = gs.Vector3.Angle(from, to)
    local v3 = gs.Vector3.Cross(from, to)
    if v3.z > 0 or angle == 0 then
        return angle
    else
        return 360 - angle
    end
end

function onPointerDownHandler(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SCREEN_MOUSEDOWN, self.mTouch.EventData)
end

function onPointerUpHandler(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SCREEN_MOUSEUP)
end

function onDragHandler(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG, self.mTouch.EventData)
    self.m_onDrag = true
end

function onEndDragHandler(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SCREEN_MOUSEDRAG_END, self.mTouch.EventData)
    self.m_onDrag = nil
end

function onClickHandler(self)
    GameDispatcher:dispatchEvent(EventName.BIGHOSTEL_SCREEN_MOUSECLICK)
end

return _M
