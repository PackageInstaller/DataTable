--[[
-----------------------------------------------------
@filename       : PrivateChatPanel
@Description    : 私聊
@date           : 2020-08-04 16:30:26
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.PrivateChatPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("friend/PrivateChatPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    --self:setSize(750, 600)

    --self:setBg("common_bg_2.jpg", false)

end

function initData(self)
    self.mSelectId = nil
    self.mItemList = {}

    -- 每次加载多少条聊天记录
    self.mOnceCount = 20

    -- 管理下拉更新的变量
    self.mIsScollTop = false

    -- 当前发送的聊天信息id，自增长
    self.mIndex = 1

    -- 是否输入文本模式
    self.mIsInput = true
end

--析构
function dtor(self)
end

-- 初始化
function configUI(self)
    self.mScrollList = self:getChildGO("mScrollList"):GetComponent(ty.LyScroller)
    self.mScrollList:SetItemRender(friend.PrivateChatListItem)

    self.mScrollView = self:getChildTrans("mScrollView")
    self.mScrollContent = self:getChildTrans("mTalkContent")
    self.mScrollView:GetComponent(ty.ScrollRect).onValueChanged:AddListener(function()
        self:onScollChanged()
    end)

    self.mInputTxt = self:getChildGO("mInputTxt"):GetComponent(ty.InputField)

    self.mTalkGroup = self:getChildTrans("mTalkGroup")
    self.mBtnEmoji = self:getChildGO("mBtnEmoji")
    self.mBtnSend = self:getChildGO("mBtnSend")
    self.mBtnGift = self:getChildGO("mBtnGift")

    self.mTxtMsg = self:getChildGO("mTxtMsg")

    self.mInputTxt.characterLimit = chat.ChatManager:getChatConfig(chat.ChannelType.PRIVATE).maxWords

    self.mBtnSwitch = self:getChildGO("mBtnSwitch")
    self.mSwitchImg = self:getChildGO("mSwitchImg"):GetComponent(ty.AutoRefImage)
    self.mBtnMsc = self:getChildGO("mBtnMsc")
    self.mBtnMscTrigger = self.mBtnMsc:GetComponent(ty.LongPressOrClickEventTrigger)
    self.mMscCheckRect = self:getChildGO("MscCheckRect"):GetComponent(ty.RectTransform)
    --------------------------------------------------------讯飞测试----------------------------------------------------
    self.mTextSpeechTip = self:getChildGO("TextSpeechTip"):GetComponent(ty.Text)
    local function playPcm()
        gs.AudioManager.PcmVolume = 100
        gs.AudioManager:PlayPcm(sdk.SdkManager:getXunFeiAudioRPath("wings_test"), sdk.XunFeiParam.SampleRate, nil)
    end
    local function stopPcm()
        gs.AudioManager:StopPcm()
    end
    self:addOnClick(self:getChildGO("BtnPlayPcm"), playPcm)
    self:addOnClick(self:getChildGO("BtnStopPcm"), stopPcm)
    --------------------------------------------------------讯飞测试----------------------------------------------------
end

function addTriggerEvent(self)
    local isCancel = false
    local function frameUpdate()
        self.mMousePos = gs.Input.mousePosition
        local mouseWorldPos = gs.CameraMgr:ScreenToWorldByUICamera(self.mMousePos)
        local localPos = self.mMscCheckRect:InverseTransformPoint(mouseWorldPos)
        local areaSize = self.mMscCheckRect.sizeDelta
        if (localPos.y >= -areaSize.y / 2 and localPos.y <= areaSize.y / 2 and localPos.x >= -areaSize.x / 2 and localPos.x <= areaSize.x / 2) then
            isCancel = false
        else
            isCancel = true
        end
        if (self.m_chatMscView) then
            self.m_chatMscView:updateState(isCancel)
        end
    end
    local function _onReqBeginSpeechHandler()
        LoopManager:addFrame(1, 0, self, frameUpdate)
        self:onReqBeginSpeechHandler()
        -- 测试
        -- self:onOpenMscViewHandler()
    end
    self.mBtnMscTrigger.onLongPress:AddListener(_onReqBeginSpeechHandler)
    local function onReqEndSpeechHandler()
        LoopManager:removeFrame(self, frameUpdate)
        if (self.mXunFeiState == sdk.XunFeiState.ReqBegin) then
            if (isCancel) then
                self:onReqCancelSpeechHandler()
            else
                self:onReqEndSpeechHandler()
            end
            -- 测试
            -- self:onCloseOpenMscViewHandler()
        end
    end
    self.mBtnMscTrigger.onPointerUp:AddListener(onReqEndSpeechHandler)
end

function removeTriggerEvent(self)
    self.mBtnMscTrigger.onLongPress:RemoveAllListeners()
    self.mBtnMscTrigger.onPointerUp:RemoveAllListeners()
    self.mBtnMscTrigger.onPointerExit:RemoveAllListeners()
end

--激活
function active(self, args)
    super.active(self)
    self.mSelectId = args.id
    self:setFriendChatNewTime()
    self:addTriggerEvent()

    self:clearNewMessge()
    self:updateList()

    GameDispatcher:addEventListener(EventName.SHOW_PRIVATE_CHAT_INFO, self.onShowChatMemberHandler, self)
    GameDispatcher:addEventListener(EventName.CHAT_SELECT_EMOJI, self.onSelectEmojiHandler, self)

    friend.FriendManager:addEventListener(friend.FriendManager.PRIVATE_CHAT_ADD, self.onAddChatContentHandler, self)
    friend.FriendManager:addEventListener(friend.FriendManager.PRIVATE_CHAT_UPDATE, self.onUpdateChatContentHandler, self)
    friend.FriendManager:addEventListener(friend.FriendManager.FRIEND_UPDATE, self.onUpdateFriendHandlerHandler, self)
    
    GameDispatcher:dispatchEvent(EventName.REQ_EMOJI_UNLOCK_LIST)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeTriggerEvent()

    GameDispatcher:removeEventListener(EventName.SHOW_PRIVATE_CHAT_INFO, self.onShowChatMemberHandler, self)
    GameDispatcher:removeEventListener(EventName.CHAT_SELECT_EMOJI, self.onSelectEmojiHandler, self)

    friend.FriendManager:removeEventListener(friend.FriendManager.PRIVATE_CHAT_ADD, self.onAddChatContentHandler, self)
    friend.FriendManager:removeEventListener(friend.FriendManager.PRIVATE_CHAT_UPDATE, self.onUpdateChatContentHandler, self)
    friend.FriendManager:removeEventListener(friend.FriendManager.FRIEND_UPDATE, self.onUpdateFriendHandlerHandler, self)

    -- LoopManager:removeFrame(self, self.splitFrameAddChatLog)
    self:removeItem()

    if self.selectData then
        self.selectData.isSelect = false
    end

    -- 关闭聊天更新好友信息
    friend.FriendManager:dispatchEvent(friend.FriendManager.FRIEND_UPDATE)

end

function initViewText(self)
    self:setBtnLabel(self.mBtnSend, 25155, "发送")
    self:setBtnLabel(self.mBtnMsc, 25156, "长按录音")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnEmoji, self.onOpenEmojiHandler)
    self:addUIEvent(self.mBtnSend, self.onSendHandler)
    self:addUIEvent(self.mBtnGift, self.onGiftHandler)
    self:addUIEvent(self.mBtnSwitch, self.onSwitchHandler)
    self:addUIEvent(self.mBtnMsc, self.onSwitchHandler)
end

-- 更新唤起聊天窗口的时间，排在第一位
function setFriendChatNewTime(self)
    local index = friend.FriendManager:checkChatMember(self.mSelectId)
    local list = friend.FriendManager:getChatList()
    local chatVo = list[index]
    if chatVo then
        chatVo.lastCallTime = os.time()
    end
end

-- 打开表情
function onOpenEmojiHandler(self)
    if self.mEmojiPanel == nil then
        self.mEmojiPanel = UI.new(friend.PrivateEmojiPanel)
        self.mEmojiPanel:addEventListener(View.EVENT_CLOSE, self.onEmojiPanelCloseHandler, self)
    end
    self.mEmojiPanel:open({posX = 80, posY = 0})
end

-- 关闭表情
function onEmojiPanelCloseHandler(self)
    self.mEmojiPanel:removeEventListener(View.EVENT_CLOSE, self.onEmojiPanelCloseHandler, self)
    self.mEmojiPanel = nil
end

function onSwitchHandler(self)
    self.mIsInput = self.mIsInput == false
    if self.mIsInput then
        self.mInputTxt.gameObject:SetActive(true)
        self.mBtnMsc:SetActive(false)
        self.mSwitchImg:SetImg(UrlManager:getPackPath("chat/chat_btn_7.png"))
        self.mBtnEmoji:SetActive(true)
        self.mBtnGift:SetActive(true)
        self.mBtnSend:SetActive(true)
        --self.mBtnSwitch:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("chat/chat_btn_7.png"))
    else
        self.mInputTxt.gameObject:SetActive(false)
        self.mBtnMsc:SetActive(true)
        self.mSwitchImg:SetImg(UrlManager:getPackPath("chat/chat_btn_13.png"))

        self.mBtnEmoji:SetActive(false)
        self.mBtnGift:SetActive(false)
        self.mBtnSend:SetActive(false)
        --self.mBtnSwitch:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("chat/chat_btn_4.png"))
    end
end

-- 发送聊天
function onSendHandler(self)
    local content = self.mInputTxt.text
    if FilterWordUtil:hasIllegalWord(content) then
        -- gs.Message.Show("存在非法符号")
        gs.Message.Show(_TT(25154))
        return
    end
    if (not chat.isLegal(content, true)) then
        return
    end
    self.mInputTxt.text = ""
    GameDispatcher:dispatchEvent(EventName.SEND_PRIVATE_CHAT_INFO, {id = self.mIndex, friendId = self.mSelectId, contentType = chat.ContentType.JUST_TEXT, content = content})
    self.mIndex = self.mIndex + 1
end

function onGiftHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_FRIEND_GIFT_SEND, self.mSelectId)
end

-- 发送表情
function onSelectEmojiHandler(self, args)
    if self.mEmojiPanel then
        self.mEmojiPanel:close()
    end
    GameDispatcher:dispatchEvent(EventName.SEND_PRIVATE_CHAT_INFO, {id = self.mIndex, friendId = self.mSelectId, contentType = args.emojiType, content = args.emojiContent})
    self.mIndex = self.mIndex + 1
end

-- 好友数据更新
function onUpdateFriendHandlerHandler(self)
    self:updateList(true)
end

-- 更新聊天对象列表
function updateList(self, isUpdate)

    local mIndex = friend.FriendManager:checkChatMember(self.mSelectId)
    local list = friend.FriendManager:getChatList()
    if self.mScrollList.Count <= 0 then
        self.mScrollList.DataProvider = list
    else
        self.mScrollList:ReplaceAllDataProvider(list)
    end
    -- if not isUpdate then
    --     self:setTimeout(0.1, function()
    --         mIndex = mIndex - 1
    --         self.mScrollList:ScrollToImmediately(mIndex)
    --     end)
    -- end

    if #list <= 0 then
        self:close()
        return
    end

    if mIndex <= 0 then
        self.mSelectId = list[1].id
    end

    if not isUpdate or mIndex <= 0 then
        self:showChatMember(self.mSelectId)
    end

end

-- 切换聊天对象信息
function onShowChatMemberHandler(self, cusId)
    if self.mSelectId == cusId then
        return
    end
    self:showChatMember(cusId)
    self:clearNewMessge()
end

-- 展示聊天对象信息
function showChatMember(self, cusId)
    if cusId == 0 then
        return
    end
    self.mSelectId = cusId

    if not self.selectData or self.selectData.id ~= cusId then
        if self.selectData then
            local selectIndex = self:getIndexById(self.selectData.id)
            local selectData = self.mScrollList:GetLuaDataByIndex(selectIndex)
            selectData.isSelect = false
            self.mScrollList:SetLuaDataByIndex(selectIndex, selectData)
        end
        local mIndex = self:getIndexById(cusId)
        local data = self.mScrollList:GetLuaDataByIndex(mIndex)
        data.isSelect = true
        self.mScrollList:SetLuaDataByIndex(mIndex, data)
        self.selectData = data
    end

    self:initChatContent(cusId)
end

function onUpdateChatContentHandler(self, cusId)
    self:initChatContent(cusId)
end

-- 滚动变化，实现下拉刷新
function onScollChanged(self)
    local y = self.mScrollContent.anchoredPosition.y
    if self.mPos > 1 then
        if y < 1 and y > -1 then
            self.mTxtMsg:GetComponent(ty.Text).text = _TT(25152)--"下拉查看更多信息"
            self.mTxtMsg:SetActive(true)
        elseif y <= -100 then
            if self.mIsScollTop == false then
                self.mTxtMsg:GetComponent(ty.Text).text = _TT(25153)--"松开加载"
                self.mTxtMsg:SetActive(true)
            end
            self.mIsScollTop = true
        elseif self.mIsScollTop then
            self.mTxtMsg:SetActive(false)
            self:updateChatContent(self.mSelectId)
            self.mIsScollTop = false
        else
            self.mTxtMsg:SetActive(false)
        end
    else
        self.mTxtMsg:SetActive(false)
    end
end

function initChatContent(self, cusId)
    self.mPos = 0
    self:updateChatContent(cusId, true)
end

-- 更新聊天记录
function updateChatContent(self, cusId, isInit)
    if self.mSelectId ~= cusId then
        return
    end
    if isInit then
        self:removeItem()
    end

    local list = friend.FriendManager:getFriendChatData(self.mSelectId)
    if not list then
        return
    end

    self.mScrollView:SetParent(GameView.mainUI, false)

    local list = friend.FriendManager:getFriendChatData(self.mSelectId)
    local max = self.mPos == 0 and #list or self.mPos
    local min = math.max(1, max - self.mOnceCount - 1)
    self.mPos = math.max(1, min - 1)

    local firstItem
    for i = max, min, -1 do
        local vo = list[i]
        local preVo = list[i - 1]
        if vo then
            local item = friend.PrivateChatTalkItem:poolGet()
            item:setData(self.mScrollContent, vo, preVo)
            item.UITrans:SetAsFirstSibling()
            table.insert(self.mItemList, item)
            if not firstItem then
                firstItem = item
            end
        else
            break
        end
    end

    self.mScrollContent.anchoredPosition = gs.Vector2.zero
    if isInit then
        self:chatScollOver(0)
    else
        self:chatScollPos(firstItem)
    end
end

-- 聊天内容滚动到指定
function chatScollPos(self, item)
    local scollTo = function()
        local posY = -item.UITrans.anchoredPosition.y - item.UITrans.rect.size.y
        local mPos = self.mScrollContent.anchoredPosition
        mPos.y = posY - 80
        self.mScrollContent.anchoredPosition = mPos
        self.mScrollView:SetParent(self.mTalkGroup, false)
    end
    self.frameId = LoopManager:addFrame(3, 1, self, scollTo)
end

-- 聊天内容滚动到最新
function chatScollOver(self, cusOff)
    local scollOver = function()
        if not self.m_childTrans or table.empty(self.m_childTrans) then
            return
        end

        if self.mTalkGroup == nil or gs.GoUtil.IsTransNull(self.mTalkGroup) then
            self.mTalkGroup = self:getChildTrans("mTalkGroup")
        end

        if self.mScrollView == nil or gs.GoUtil.IsTransNull(self.mScrollView) then
            self.mScrollView = self:getChildTrans("mScrollView")
        end

        if self.mScrollContent == nil or gs.GoUtil.IsTransNull(self.mScrollContent) then
            self.mScrollContent = self:getChildTrans("mTalkContent")
        end

        self.mScrollView:SetParent(self.mTalkGroup, false)
        if self.mScrollContent.rect.size.y >= self.mScrollView.rect.size.y then
            local mPos = self.mScrollContent.anchoredPosition
            mPos.y = self.mScrollContent.rect.size.y - self.mScrollView.rect.size.y + cusOff
            self.mScrollContent.anchoredPosition = mPos
        end
        -- self.mScrollView.gameObject:SetActive(true)
    end
    self.frameId2 = LoopManager:addFrame(3, 1, self, scollOver)
end

-- 单独添加一句聊天内容
function onAddChatContentHandler(self, cusId)
    self:addChatContent(cusId)
    self:chatScollOver(0)
    self:clearNewMessge()
end

-- 更新聊天窗信息
function addChatContent(self, cusId)
    if self.mSelectId ~= cusId then
        return
    end

    local list = friend.FriendManager:getFriendChatData(cusId)
    if not list then
        return
    end

    -- 保持最多100条记录,150条后在清理,减少界面乱动
    if #self.mItemList >= 150 then
        while #self.mItemList > 100 do
            local item = table.remove(self.mItemList, 1)
            item:poolRecover()
        end
    end

    local vo = list[#list]
    local preVo = list[#list - 1]

    local item = friend.PrivateChatTalkItem:poolGet()
    item:setData(self.mScrollContent, vo, preVo)
    table.insert(self.mItemList, item)
end

function removeItem(self)
    self.mTxtMsg:SetActive(false)
    for i = #self.mItemList, 1, -1 do
        local v = self.mItemList[i]
        table.remove(self.mItemList, i)
        v:poolRecover()
    end
end

-- 取在列表的顺序--0开始
function getIndexById(self, cusId)
    local list = friend.FriendManager:getChatList()
    for i, v in ipairs(list) do
        if cusId == v.id then
            return (i - 1)
        end
    end
    return 0
end

-- 清除新消息提示
function clearNewMessge(self)
    friend.FriendManager:clearNewMessgeCount(self.mSelectId)
end

-- 打开语音录入界面
function onOpenMscViewHandler(self)
    if not self.m_chatMscView then
        self.m_chatMscView = chat.ChatMscView.new()
    end
end

-- 关闭语音录入界面
function onCloseOpenMscViewHandler(self)
    if (self.m_chatMscView) then
        self.m_chatMscView:destroy()
        self.m_chatMscView = nil
    end
end

--------------------------------------------------------------------------------------------------------------------------------
-- 请求开始录音
function onReqBeginSpeechHandler(self)
    self.mXunFeiState = sdk.XunFeiState.ReqBegin
    self:updateSpeechTip()
end

-- 请求停止录音
function onReqEndSpeechHandler(self)
    if (self.mXunFeiState == sdk.XunFeiState.ResEnd) then
        logInfo("录音已自动停止", self.__cname)
    elseif (self.mXunFeiState == sdk.XunFeiState.ResResult) then
        logInfo("录音已自动返回结果", self.__cname)
    elseif (self.mXunFeiState == sdk.XunFeiState.ResError) then
        logInfo("录音已自动返回错误", self.__cname)
    else
        self.mXunFeiState = sdk.XunFeiState.ReqEnd
        self:updateSpeechTip()
    end
end

-- 请求取消录音
function onReqCancelSpeechHandler(self)
    if (self.mXunFeiState == sdk.XunFeiState.ResEnd) then
        logInfo("录音已自动停止", self.__cname)
    elseif (self.mXunFeiState == sdk.XunFeiState.ResResult) then
        logInfo("录音已自动返回结果", self.__cname)
    elseif (self.mXunFeiState == sdk.XunFeiState.ResError) then
        logInfo("录音已自动返回错误", self.__cname)
    else
        self.mXunFeiState = sdk.XunFeiState.ReqCancel
        self:updateSpeechTip()
    end
end

-- 录音开始
function __onSpeechBeginHandler(self, args)
    self.mXunFeiState = sdk.XunFeiState.ResBegin
    self:updateSpeechTip()
end

-- 录音出错
function __onSpeechErrorHandler(self, args)
    self.mXunFeiState = sdk.XunFeiState.ResError
    self:updateSpeechTip()
end

-- 录音停止
function __onSpeechEndandler(self, args)
    self.mXunFeiState = sdk.XunFeiState.ResEnd
    self:updateSpeechTip()
end

-- 录音结果解析完毕
function __onSpeechResultHandler(self, args)
    self.mXunFeiState = sdk.XunFeiState.ResResult
    self.mInputTxt.text = args.content
    self:updateSpeechTip()
end

function updateSpeechTip(self, state)
    if (state ~= nil) then
        self.mXunFeiState = state
    end
    if (self.mXunFeiState == sdk.XunFeiState.None) then
        self.mTextSpeechTip.text = ""
        self.mIsLongClick = false
        self:onCloseOpenMscViewHandler()
    elseif (self.mXunFeiState == sdk.XunFeiState.ReqBegin) then
        self.mIsLongClick = true
        self.mTextSpeechTip.text = "正在启动..."
        gs.SdkManager:CancelSpeechRecognizer()
        gs.SdkManager:StartSpeechRecognizer("wings_test", sdk.XunFeiParam.speechTimes, sdk.XunFeiParam.Language, sdk.XunFeiParam.SampleRate, sdk.XunFeiParam.Ptt, sdk.XunFeiParam.VadBos, sdk.XunFeiParam.VadEos)
        self:onCloseOpenMscViewHandler()
    elseif (self.mXunFeiState == sdk.XunFeiState.ResBegin) then
        self.mTextSpeechTip.text = "开始录音..."
        self:onOpenMscViewHandler()
    elseif (self.mXunFeiState == sdk.XunFeiState.ResError) then
        self.mIsLongClick = false
        self.mTextSpeechTip.text = "录音出错"
        gs.SdkManager:CancelSpeechRecognizer()
        self:onCloseOpenMscViewHandler()
    elseif (self.mXunFeiState == sdk.XunFeiState.ReqEnd) then
        if (self.mIsLongClick) then
            self.mIsLongClick = false
            self.mTextSpeechTip.text = "正在解析..."
            gs.SdkManager:StopSpeechRecognizer()
            self:onCloseOpenMscViewHandler()
        end
    elseif (self.mXunFeiState == sdk.XunFeiState.ReqCancel) then
        if (self.mIsLongClick) then
            self.mIsLongClick = false
            self.mTextSpeechTip.text = ""
            gs.SdkManager:CancelSpeechRecognizer()
            self:onCloseOpenMscViewHandler()
        end
    elseif (self.mXunFeiState == sdk.XunFeiState.ResEnd) then
        self.mTextSpeechTip.text = "正在解析..."
        self:onCloseOpenMscViewHandler()
    elseif (self.mXunFeiState == sdk.XunFeiState.ResResult) then
        self.mTextSpeechTip.text = ""
        self:onCloseOpenMscViewHandler()
    end
end
--------------------------------------------------------讯飞----------------------------------------------------
return _M

--[[ 替换语言包自动生成，请勿修改！
]]
