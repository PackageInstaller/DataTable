module("chat.ChatBasePanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("chat/ChatBasePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mFirstOpen = true
end

function configUI(self)
    self.mGroupUP = self:getChildTrans("mGroupUP")
    -- 输入组容器
    self.mGroupInput = self:getChildGO("mGroupInput")

    -- 内容输入
    self.mContentInputField = self:getChildGO("mContentInputField"):GetComponent(ty.InputField)
    self.mDefaultText = self.mContentInputField.placeholder:GetComponent(ty.Text)
    self.mTextInputRect = self:getChildGO("mTextInput"):GetComponent(ty.RectTransform)
    self.mCaret = nil

    self.mGroupNormal = self:getChildGO("mGroupNormal")
    -- msc组容器
    self.mBtnMsc = self:getChildGO("mBtnMsc")
    self.mBtnMscTrigger = self.mBtnMsc:GetComponent(ty.LongPressOrClickEventTrigger)
    self.mMscCheckRect = self:getChildGO("mMscCheckRect"):GetComponent(ty.RectTransform)

    self.mBtnEmoji = self:getChildGO("mBtnEmoji")
    self.mBtnEmoji2 = self:getChildGO("mBtnEmoji2")
    self.mBtnSend = self:getChildGO("mBtnSend")
    self.mGroupRoom = self:getChildGO("mGroupRoom")
    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mTxtChannel = self:getChildGO("mTxtChannel"):GetComponent(ty.Text)

    self.mGroupInput:SetActive(true)
    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mBtnSetting = self:getChildGO("mBtnSetting")
end

function initViewText(self)
    self:setBtnLabel(self.mBtnSend, 6, "发送")
    self.mTxtChannel.text = _TT(512)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnEmoji, self.onClickEmojiHandler)
    self:addUIEvent(self.mBtnSend, self.onClickSendHandler)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
    self:addUIEvent(self.mBtnSetting, self.onClickSetting)

end

function onClickSetting(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_CHATSETTING_PANEL)
end

function addTriggerEvent(self)
    local isCancel = false
    local function frameUpdate()
        self.m_mousePos = gs.Input.mousePosition
        local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(self.m_mousePos)
        local localPos = self.mMscCheckRect:InverseTransformPoint(mouseWorldPos)
        local areaSize = self.mMscCheckRect.sizeDelta
        if (localPos.y >= -areaSize.y / 2 and localPos.y <= areaSize.y / 2 and localPos.x >= -areaSize.x / 2 and localPos.x <= areaSize.x / 2) then
            isCancel = false
        else
            isCancel = true
        end
        if (self.mChatMscView) then
            self.mChatMscView:updateState(isCancel)
        end
    end
    local function _onReqBeginSpeechHandler()
        if(sdk.SdkManager:getIsSimulator())then
            gs.Message.Show("模拟器暂不支持本功能")
        else
            gs.AudioManager:StopPcm()
            if(sdk.SdkManager:checkPermission(sdk.AndroidPermission.RECORD_AUDIO))then
                if(not self.mXunFeiFrameSn)then
                    self.mXunFeiFrameSn = LoopManager:addFrame(1, 0, self, frameUpdate)
                end
                self:onReqBeginSpeechHandler()
            else
                sdk.SdkManager:checkAndRequestPermission(sdk.AndroidPermission.RECORD_AUDIO, "授权提示", "语音聊天需要开启麦克风进行录音", "确认", "取消", "已授权", "请自行设置允许录音权限")
            end
        end
    end
    self.mBtnMscTrigger.onLongPress:AddListener(_onReqBeginSpeechHandler)
    local function _onReqEndSpeechHandler()
        if(self.mXunFeiFrameSn)then
            LoopManager:removeFrameByIndex(self.mXunFeiFrameSn)
            self.mXunFeiFrameSn = nil
        end
        if (self.mXunFeiState == sdk.XunFeiState.ReqBegin or self.mXunFeiState == sdk.XunFeiState.ResBegin) then
            if (isCancel) then
                self:onReqCancelSpeechHandler()
            else
                self:onReqEndSpeechHandler()
            end
        end
    end
    self.mBtnMscTrigger.onPointerUp:AddListener(_onReqEndSpeechHandler)

    --内容输入
    local function inputChange(content)
        if self.mFirstOpen then
            gs.TransQuick:UIPosY(self.mTextInputRect, -2)
            self.mFirstOpen = false
        end
        if not self.mCaret then
            local caretPrefab = self.mContentInputField.transform:Find("mContentInputField Input Caret")
            if caretPrefab then --移动端带自输入键盘的会遮挡而不出现光标
                self.mCaret = caretPrefab:GetComponent(ty.RectTransform)
            end
        end
        if self.mCaret then
            if #content ~= 0 then
                gs.TransQuick:UIPosY(self.mCaret, 5)
            else
                gs.TransQuick:UIPosY(self.mCaret, -2)
            end
        end
        self:contentInputChanged(content)
    end
    self.mContentInputField.onValueChanged:AddListener(inputChange)
    local function inputEnd(content)
        self:contentInputEnd(content)
    end
    self.mContentInputField.onEndEdit:AddListener(inputEnd)

    -- 房间号输入
    self.mRoomInputField = self:getChildGO("mRoomInputField"):GetComponent(ty.InputField)
    local function inputChange(content)
        self:roomInputChanged(content)
    end
    self.mRoomInputField.onValueChanged:AddListener(inputChange)
    local function inputEnd(content)
        self:roomInputEnd(content)
    end
    self.mRoomInputField.onEndEdit:AddListener(inputEnd)
end

function removeTriggerEvent(self)
    if(self.mXunFeiFrameSn)then
        LoopManager:removeFrameByIndex(self.mXunFeiFrameSn)
        self.mXunFeiFrameSn = nil
    end
    self.mBtnMscTrigger.onLongPress:RemoveAllListeners()
    self.mBtnMscTrigger.onPointerUp:RemoveAllListeners()
    self.mBtnMscTrigger.onPointerExit:RemoveAllListeners()

    self.mContentInputField.onValueChanged:RemoveAllListeners()
    self.mContentInputField.onEndEdit:RemoveAllListeners()
    self.mRoomInputField.onValueChanged:RemoveAllListeners()
    self.mRoomInputField.onEndEdit:RemoveAllListeners()
end

function active(self)
    super.active(self)
    self:addTriggerEvent()
    GameDispatcher:addEventListener(EventName.CHAT_SELECT_EMOJI, self.onSelectEmojiHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_END_RECORD, self.onReqEndSpeechHandler, self)
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_XUNFEI_BEGIN, self.onSpeechBeginHandler, self)
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_XUNFEI_ERROR, self.onSpeechErrorHandler, self)
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_XUNFEI_END, self.onSpeechEndandler, self)
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_XUNFEI_RESULT, self.onSpeechResultHandler, self)

    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.refreshRedPoint, self)
    GameDispatcher:addEventListener(EventName.REFRESH_CHATBUBBLE_REDSTATE, self.refreshRedPoint, self)

    self:updateSpeechTip(sdk.XunFeiState.None)
    self:refreshRedPoint()

    -- gs.TransQuick:LPosX(self.mGroupUP, 0)
    -- TweenFactory:move2LPosX(self.mGroupUP, 700, 0.3)
end

function deActive(self)
    super.deActive(self)
    self:removeTriggerEvent()
    GameDispatcher:removeEventListener(EventName.CHAT_SELECT_EMOJI, self.onSelectEmojiHandler, self)
    GameDispatcher:removeEventListener(EventName.REQ_END_RECORD, self.onReqEndSpeechHandler, self)
    sdk.SdkManager:removeEventListener(sdk.SdkManager.SDK_XUNFEI_BEGIN, self.onSpeechBeginHandler, self)
    sdk.SdkManager:removeEventListener(sdk.SdkManager.SDK_XUNFEI_ERROR, self.onSpeechErrorHandler, self)
    sdk.SdkManager:removeEventListener(sdk.SdkManager.SDK_XUNFEI_END, self.onSpeechEndandler, self)
    sdk.SdkManager:removeEventListener(sdk.SdkManager.SDK_XUNFEI_RESULT, self.onSpeechResultHandler, self)

    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.refreshRedPoint, self)
    GameDispatcher:removeEventListener(EventName.REFRESH_CHATBUBBLE_REDSTATE, self.refreshRedPoint, self)

    self:updateSpeechTip(sdk.XunFeiState.ReqCancel)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CHAT_PANEL)
    self.mCaret = nil

    RedPointManager:remove(self.mBtnSetting.transform)
end

function refreshRedPoint(self)
    local isActive = decorate.DecorateManager:getChatBubbleRedState()
    if isActive then
        RedPointManager:add(self.mBtnSetting.transform, nil, 9.3, 13.6)
    else
        RedPointManager:remove(self.mBtnSetting.transform)
    end
end

-- function closeOpenAction(self)
--     GameDispatcher:dispatchEvent(EventName.CLOSE_CHAT_PANEL)
--     TweenFactory:move2LPosX(self.mGroupUP, 0, 0.3, nil, function() self:close() end)
-- end

--------------------------------------------------------------------------------------------------------------------------------
-- 请求开始录音
function onReqBeginSpeechHandler(self)
    self.mXunFeiState = sdk.XunFeiState.ReqBegin
    self:updateSpeechTip()
end

-- 请求停止录音
function onReqEndSpeechHandler(self)
    if (self.mXunFeiState == sdk.XunFeiState.ResEnd) then
        logInfo("录音已自动停止", self.cname)
    elseif (self.mXunFeiState == sdk.XunFeiState.ResResult) then
        logInfo("录音已自动返回结果", self.cname)
    elseif (self.mXunFeiState == sdk.XunFeiState.ResError) then
        logInfo("录音已自动返回错误", self.cname)
    else
        self.mXunFeiState = sdk.XunFeiState.ReqEnd
        self:updateSpeechTip()
    end
end

-- 请求取消录音
function onReqCancelSpeechHandler(self)
    if (self.mXunFeiState == sdk.XunFeiState.ResEnd) then
        logInfo("录音已自动停止", self.cname)
    elseif (self.mXunFeiState == sdk.XunFeiState.ResResult) then
        logInfo("录音已自动返回结果", self.cname)
    elseif (self.mXunFeiState == sdk.XunFeiState.ResError) then
        logInfo("录音已自动返回错误", self.cname)
    else
        self.mXunFeiState = sdk.XunFeiState.ReqCancel
        self:updateSpeechTip()
    end
end

-- 录音开始
function onSpeechBeginHandler(self, args)
    self.mXunFeiState = sdk.XunFeiState.ResBegin
    self:updateSpeechTip()
end

-- 录音出错
function onSpeechErrorHandler(self, args)
    self.mXunFeiState = sdk.XunFeiState.ResError
    self:updateSpeechTip()
end

-- 录音停止
function onSpeechEndandler(self, args)
    self.mXunFeiState = sdk.XunFeiState.ResEnd
    self:updateSpeechTip()
end

-- 录音结果解析完毕
function onSpeechResultHandler(self, args)
    self.mXunFeiState = sdk.XunFeiState.ResResult
    -- self.mContentInputField.text = args.content
    self:updateSpeechTip()
end

function updateSpeechTip(self, state)
    if (state ~= nil) then
        self.mXunFeiState = state
    end

    if (self.mXunFeiState == sdk.XunFeiState.None) then
        -- self.mTextSpeechTip.text = ""
        self.mIsLongClick = false
        self:onCloseOpenMscViewHandler()
    elseif (self.mXunFeiState == sdk.XunFeiState.ReqBegin) then
        self.mIsLongClick = true
        self:onCloseOpenMscViewHandler()
        -- self.mTextSpeechTip.text = "正在启动..."
        gs.SdkManager:CancelSpeechRecognizer()
        gs.SdkManager:StartSpeechRecognizer(chat.getVoiceFileName(), sdk.XunFeiParam.speechTimes, sdk.XunFeiParam.Language, sdk.XunFeiParam.SampleRate, sdk.XunFeiParam.Ptt, sdk.XunFeiParam.VadBos, sdk.XunFeiParam.VadEos)
    elseif (self.mXunFeiState == sdk.XunFeiState.ResBegin) then
        -- self.mTextSpeechTip.text = "开始录音..."
        self:onOpenMscViewHandler()
    elseif (self.mXunFeiState == sdk.XunFeiState.ResError) then
        self.mIsLongClick = false
        self:onCloseOpenMscViewHandler()
        -- self.mTextSpeechTip.text = "录音出错"
        gs.SdkManager:CancelSpeechRecognizer()
    elseif (self.mXunFeiState == sdk.XunFeiState.ReqEnd) then
        if (self.mIsLongClick) then
            self.mIsLongClick = false
            self:onCloseOpenMscViewHandler()
            -- self.mTextSpeechTip.text = "正在解析..."
            gs.SdkManager:StopSpeechRecognizer()
        end
    elseif (self.mXunFeiState == sdk.XunFeiState.ReqCancel) then
        if (self.mIsLongClick) then
            self.mIsLongClick = false
            self:onCloseOpenMscViewHandler()
            -- self.mTextSpeechTip.text = ""
            gs.SdkManager:CancelSpeechRecognizer()
        end
    elseif (self.mXunFeiState == sdk.XunFeiState.ResEnd) then
        -- self.mTextSpeechTip.text = "正在解析..."
        self:onCloseOpenMscViewHandler()
    elseif (self.mXunFeiState == sdk.XunFeiState.ResResult) then
        -- self.mTextSpeechTip.text = ""
        self:onCloseOpenMscViewHandler()
    end
end
--------------------------------------------------------讯飞----------------------------------------------------
function setInputLimit(self, count)
    self.mContentInputField.characterLimit = count
end

function setDefaultContent(self, content)
    self.mDefaultText.text = content
end

-- 内容输入改变
function contentInputChanged(self, conten)
end

-- 内容输入结束
function contentInputEnd(self, conten)
end

-- 房间号输入改变
function roomInputChanged(self, conten)
end

-- 房间号输入结束
function roomInputEnd(self, conten)
end

-- 响应表情选择
function onSelectEmojiHandler(self, args)
    -- self.mEmojiPanel:close()
    self.mContentInputField.text = self.mContentInputField.text .. args.emojiContent
end

-- 打开语音录入界面
function onOpenMscViewHandler(self)
    if not self.mChatMscView then
        self.mChatMscView = chat.ChatMscView.new()
    end
end

-- 关闭语音录入界面
function onCloseOpenMscViewHandler(self)
    if (self.mChatMscView) then
        self.mChatMscView:destroy()
        self.mChatMscView = nil
    end
end

-- 打开表情
function onClickEmojiHandler(self)
    if self.mEmojiPanel == nil then
        self.mEmojiPanel = chat.EmojiPanel.new()
        self.mEmojiPanel:addEventListener(View.EVENT_CLOSE, self.onEmojiPanelClose, self)
    end
    self.mEmojiPanel:open()
end

-- 关闭表情
function onEmojiPanelClose(self)
    self.mEmojiPanel:removeEventListener(View.EVENT_CLOSE, self.onEmojiPanelClose, self)
    self.mEmojiPanel = nil
end

-- 发送
function onClickSendHandler(self)
end

function getInput(self)
    return self.mContentInputField
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
