module("chat.ChatPanel", Class.impl(chat.ChatBasePanel))

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mSelectPage = nil

    -- 首次加载多少条聊天记录
    self.mFirstShowCount = 15
    -- 历史消息每次加载多少条聊天记录
    self.mOnceLoadCount = 20
    -- 是否需要加载
    self.mIsNeedLoad = false
    -- 显示的第一条数据的唯一值
    self.mFirstItemSn = nil

    -- 当前聊天新增的缓存列表
    self.mChatCacheList = nil
    -- 当前聊天正在显示的缓存列表
    self.mChatCacheShowList = nil
    -- 当前界面列表是否已经初始完毕
    self.mIsInitListOk = nil
    -- 消息刷新帧计时器
    self.mMsgTimeSn = nil
    -- 聊天item列表
    self.mItemList = nil
    -- 间隔
    self.mContentGap = 10
    -- 未读消息条数
    self.mUnReadCount = 0

    -- -- 当前未读消息的唯一标识
    -- self.mReadEndSn = nil
end

function configUI(self)
    super.configUI(self)

    self.mTextLoadTip = self:getChildGO("mTextLoadTip"):GetComponent(ty.Text)

    self.mScrollRect = self.mScrollView:GetComponent(ty.RectTransform)
    self.mContentTrans = self:getChildTrans("mContent")
    self.mContentRect = self.mContentTrans:GetComponent(ty.RectTransform)
    self.mEventTrigger = self.mScrollView:GetComponent(ty.LongPressOrClickEventTrigger)
    self.mEventTrigger.onBeginDrag:AddListener(function() self:onBeginDragHandler() end)
    self.mEventTrigger.onEndDrag:AddListener(function() self:onEndDragHandler() end)
    self.mScrollerValueEvent = self.mScrollView:GetComponent(ty.ScrollRect).onValueChanged

    self.mGroupChannel = self:getChildTrans("mGroupChannel")
    -- 消息提示容器
    self.mGroupMsgTip = self:getChildGO("mGroupMsgTip")
    -- 消息提示文本
    self.mTextMsgTip = self:getChildTrans("mTextMsgTip"):GetComponent(ty.Text)

    -- 切换频道提示容器
    self.mGroupSwitchTip = self:getChildGO("mGroupSwitchTip")
    -- 切换频道提示文本
    self.mTextSwitchTip = self:getChildTrans("mTextSwitchTip"):GetComponent(ty.Text)
    -- 消息提示容器canvasGroup
    self.mCanvasGroupSwitch = self.mGroupSwitchTip:GetComponent(ty.CanvasGroup)
end

function initViewText(self)
    super.initViewText(self)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mGroupMsgTip, self.onClickUnReadMsgHandler)
end

function active(self, args)
    super.active(self, args)
    self:resetAllItem()
    sdk.SdkManager:addEventListener(sdk.SdkManager.SDK_XUNFEI_RESULT, self.onSpeechResultFinishHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_CHAT_FORBID, self.onUpdateForbidHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_CHAT_PANEL_DATA, self.onUpdatePanelHandler, self)
    GameDispatcher:addEventListener(EventName.UPDATE_CHANGE_ROOM_RESULT, self.onUpdateChangeRoomResultHandler, self)
    GameDispatcher:addEventListener(EventName.CHAT_MSG_UPDATE, self.onChatMsgUpdateHandler, self)

    self:setChannelTab(args)

    GameDispatcher:dispatchEvent(EventName.REQ_EMOJI_UNLOCK_LIST)
end

function deActive(self)
    super.deActive(self)
    self:resetAllItem()
    sdk.SdkManager:removeEventListener(sdk.SdkManager.SDK_XUNFEI_RESULT, self.onSpeechResultFinishHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CHAT_FORBID, self.onUpdateForbidHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CHAT_PANEL_DATA, self.onUpdatePanelHandler, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CHANGE_ROOM_RESULT, self.onUpdateChangeRoomResultHandler, self)
    GameDispatcher:removeEventListener(EventName.CHAT_MSG_UPDATE, self.onChatMsgUpdateHandler, self)

    self:removeScrollToFrameSn()
    self:removeScrollFrameSn()
    self:removeCdTimeFrameSn()
    self:removeForbidTimeFrameSn()
    self:removeMsgTimeSn()
    self:removeMsgFrameSn()
    -- 通知后端降低频率
    GameDispatcher:dispatchEvent(EventName.REQ_NOTIFY_SERVER_CHAT_CLOSE, { channel = self:getCurChannel() })

    self.mChatCacheList = nil
    self.mChatCacheShowList = nil
    self.mIsInitListOk = false
    chat.ChatManager:disposeSn()
    gs.AudioManager:StopPcm()

    if self.tabBar then
        self.tabBar:reset()
        self.tabBar = nil
    end
end

function setChannelTab(self, curChannel)
    if self.tabBar then
        self.tabBar:reset()
        self.tabBar = nil
    end

    -- 频道页签数据
    local list = {}
    list[1] = { page = chat.ChatTabType.WORLD, nomalLan = "世界" }
    if guild.GuildManager:getJoinGuilded() then
        list[2] = { page = chat.ChatTabType.GUILD, nomalLan = "联盟" }
    end

    self.tabBar = CustomTabBar:create(self:getChildGO("GroupChannelItem"), self.mGroupChannel, self.setPage, self, list, "ChatPanelGroupChannelItem")
    -- self.tabBar:setItemLock(chat.ChatTabType.GUILD, guild.GuildManager:getJoinGuilded() == false)
    if curChannel and #list >= chat.getTabByChannel(curChannel) then
        self.tabBar:setPage(chat.getTabByChannel(curChannel))
    else
        self.tabBar:setPage(1)
    end
end

function setPage(self, cusPage)
    self.mSelectPage = cusPage
    self:updateView(true)

    -- 每次打开请求服务器面板对应频道数据
    GameDispatcher:dispatchEvent(EventName.REQ_CHAT_PANEL_DATA, { channel = self:getCurChannel() })
end

function removeMsgTimeSn(self)
    if (self.mMsgTimeSn) then
        LoopManager:removeFrameByIndex(self.mMsgTimeSn)
    end
    self.mMsgTimeSn = nil
    self.mChatCacheList = nil
end

function removeMsgFrameSn(self)
    if (self.mMsgFrameSn) then
        LoopManager:removeFrameByIndex(self.mMsgFrameSn)
    end
    self.mMsgFrameSn = nil
    self.mChatCacheShowList = nil
end

-- 内容输入改变
function contentInputChanged(self, conten)
end

-- 房间号输入结束
function roomInputEnd(self, conten)
    local roomList = chat.ChatManager:getChannelRoomList(self:getCurChannel())
    if (#roomList > 0) then
        local selectRoom = tonumber(conten)
        local minRoom, maxRoom, isExist = self:getRoomRange(selectRoom)
        local curRoom = tonumber(chat.ChatManager:getChannelRoom(self:getCurChannel()))
        if (isExist) then
            if (selectRoom ~= curRoom) then
                GameDispatcher:dispatchEvent(EventName.REQ_CHANGE_CHANNEL_ROOM, { channel = self:getCurChannel(), room = selectRoom })
            end
        else
            if (selectRoom and selectRoom >= minRoom and selectRoom <= maxRoom) then
                gs.Message.Show(string.substitute(_TT(510), selectRoom)) --"房间号" .. selectRoom .. "爆满，请选择其他房间号"
            else
                gs.Message.Show(string.substitute(_TT(511), minRoom, maxRoom)) --"请输入正确房间号："..minRoom.."~"..maxRoom
            end
            self.mRoomInputField.text = curRoom
        end
    end
end

-- 表情选择
function onSelectEmojiHandler(self, args)
    local result = self:send(args.emojiType, args.emojiContent)
    -- if (result) then
    --     self.m_emojiPanel:close()
    -- end
end

-- 发送
function onClickSendHandler(self)
    local content = self:getInput().text
    if FilterWordUtil:hasIllegalWord(content) then
        gs.Message.Show(_TT(513)) --"存在敏感字或非法符号"
        return
    end
    if (not chat.isLegal(content, true)) then
        return
    end
    local result = self:send(chat.ContentType.JUST_TEXT, FilterWordUtil:filter(content))
    if (result) then
        self:getInput().text = ""
    end
end

function send(self, contentType, content)
    if self:getCurChannel() == chat.ChannelType.GUILD and not guild.GuildManager:getJoinGuilded() then
        gs.Message.Show(_TT(94580)) --你已经离开联盟
        return
    end
    local remainTime = chat.ChatManager:getCdRemainTime(self:getCurChannel())
    if (remainTime <= 0) then
        local room = chat.ChatManager:getChannelRoom(self:getCurChannel())
        if (not room) then
            logError("服务器未返回房间号")
            return false
        else
            local clientTime = GameManager:getClientTime()
            local forbidTime = chat.ChatManager:getForbidTime(self:getCurChannel())
            if (forbidTime and forbidTime > clientTime) then
                gs.Message.Show(string.format(_TT(1197), forbidTime - clientTime)) --"发送消息过于频繁，请%s秒后再试"
                return false
            end

            GameDispatcher:dispatchEvent(EventName.REQ_SEND_CHAT, { contentType = contentType, content = chat.getFormatContent(content), channel = self:getCurChannel(), room = room })
            chat.ChatManager:setCdEndTime(self:getCurChannel())
            self:updateCdTime()
            return true
        end
    else
        gs.Message.Show(string.substitute(_TT(514), remainTime)) --"s后可发言"
        return false
    end
end

-- 点击未读消息提示
function onClickUnReadMsgHandler(self)
    self:scrollToIndex(#self.mItemList)
    self:setUnReadCount(0)
end

-- 滚动列表拖动开始
function onBeginDragHandler(self)
    self.mScrollerValueEvent:RemoveAllListeners()
    self.mScrollerValueEvent:AddListener(function() self:onScollChangedHandler() end)
end
-- 滚动列表拖动改变
function onScollChangedHandler(self)
    local y = self.mContentRect.anchoredPosition.y
    if y <= -40 then
        self.mIsNeedLoad = true
        self:openLoadTip()
    else
        self:closeLoadTip()
    end
end
-- 滚动列表拖动结束
function onEndDragHandler(self)
    self.mScrollerValueEvent:RemoveAllListeners()
    self:closeLoadTip()
    if (self.mIsNeedLoad) then
        self.mIsNeedLoad = false
        self:onLoadHistoryHandler()
    end
end

-- 加载提示
function openLoadTip(self)
    self.mTextLoadTip.text = _TT(25153)--"松开加载"
end
function closeLoadTip(self)
    self.mTextLoadTip.text = ""
end

-- 历史消息
function onLoadHistoryHandler(self)
    local y = self.mContentRect.anchoredPosition.y
    local list = chat.ChatManager:getChatListByChannel(self:getCurChannel())
    local loadHeight = 0
    local loadCount = 0
    for i = #list, 1, -1 do
        if (self.mFirstItemSn ~= nil and list[i]:getSn() < self.mFirstItemSn) then
            self.mFirstItemSn = list[i]:getSn()
            local item = chat.getShowItem(list[i].contentType):create(self.mContentTrans, list[i])
            table.insert(self.mItemList, 1, item)
            loadHeight = loadHeight + item:getHeight() + self.mContentGap
            loadCount = loadCount + 1
            if (loadCount >= self.mOnceLoadCount) then
                break
            end
        end
    end
    local allHeight = 0
    for i = 1, #self.mItemList do
        local item = self.mItemList[i]
        item:setPosY(-allHeight)
        allHeight = allHeight + item:getHeight() + self.mContentGap
    end
    gs.TransQuick:SizeDelta02(self.mContentRect, allHeight)
    gs.TransQuick:UIPosY(self.mContentRect, loadHeight - math.abs(y))
end

-- 聊天消息新增更新
function onChatMsgUpdateHandler(self, args)
    if not args.chatVo or args.chatVo.channel ~= self:getCurChannel() then
        return
    end
    local channelMaxCount = chat.ChatManager:getChatConfig(self:getCurChannel()).maxShowCount
    if (not self.mChatCacheList) then
        self.mChatCacheList = {}
    end
    table.insert(self.mChatCacheList, args.chatVo)
    local delCount = #self.mChatCacheList - channelMaxCount
    for i = 1, delCount do
        table.remove(self.mChatCacheList, 1)
    end
    if (self.mIsInitListOk == false or self.mMsgTimeSn or self.mMsgFrameSn) then
        return
    end
    self:checkAddChatList()
end

-- 定时读取缓冲区
function checkAddChatList(self)
    if (#self.mChatCacheList > 0) then
        if (not self.mMsgTimeSn) then
            self.mMsgTimeSn = LoopManager:addFrame(30, 0, self, self.checkAddChatList)
        end
        if (not self.mChatCacheShowList or #self.mChatCacheShowList <= 0) then
            -- 将读取缓冲区放到分帧显示缓冲区后并清空
            self.mChatCacheShowList = {}
            for i = 1, #self.mChatCacheList do
                table.insert(self.mChatCacheShowList, self.mChatCacheList[i])
            end
            self.mChatCacheList = {}

            self:checkFramingAdd()
        end
    else
        self:removeMsgTimeSn()
    end
end

-- 分帧显示缓冲区
function checkFramingAdd(self)
    if (#self.mChatCacheShowList > 0) then
        if (not self.mMsgFrameSn) then
            -- 量比较多属于刷屏了，大量快速刷人眼看不过来就会感觉闪烁，调整速度为10帧
            if (#self.mChatCacheShowList >= 20) then
                self.mMsgFrameSn = LoopManager:addFrame(10, 0, self, self.checkFramingAdd)
            else
                self.mMsgFrameSn = LoopManager:addFrame(2, 0, self, self.checkFramingAdd)
            end
        end
        self:checkAddChat()
    else
        self:removeMsgFrameSn()

        -- 本轮分帧显示完后检测是否有新一轮缓冲显示
        if (self.mChatCacheList and #self.mChatCacheList > 0) then
            self:checkAddChatList()
        end
    end
end

-- 聊天消息新增
function checkAddChat(self)
    local isBottom = self:getIsBottom()
    local channelMaxCount = chat.ChatManager:getChatConfig(self:getCurChannel()).maxShowCount

    -- 当前最后一条的y坐标
    local endY = 0
    local endItem = self.mItemList[#self.mItemList]
    if (endItem) then
        endY = -endItem:getPosY() + endItem:getHeight() + self.mContentGap
    end
    local addCount = 4
    addCount = math.min(addCount, #self.mChatCacheShowList)
    for i = 1, addCount do
        local chatVo = table.remove(self.mChatCacheShowList, 1)
        -- 添加最新的消息
        local addItem = chat.getShowItem(chatVo.contentType):create(self.mContentTrans, chatVo)
        table.insert(self.mItemList, addItem)
        addItem:setPosY(-endY)
        endY = endY + addItem:getHeight() + self.mContentGap
    end

    -- 删除超出上限的消息 
    local needDelCount = #self.mItemList - channelMaxCount
    if (needDelCount > 0) then
        self:setUnReadCount(self.mUnReadCount - needDelCount)
        local delHeight = 0
        for i = 1, needDelCount do
            local item = table.remove(self.mItemList, 1)
            delHeight = item:getHeight() + self.mContentGap
            item:poolRecover()
            item = nil
        end

        endY = 0
        local count = #self.mItemList
        for i = 1, count do
            local item = self.mItemList[i]
            item:setPosY(-endY)
            endY = endY + item:getHeight() + self.mContentGap

            if (not self.mFirstItemSn or i == 1) then
                self.mFirstItemSn = item:getSn()
            end
        end
    end

    -- 更新滚动区域大小
    gs.TransQuick:SizeDelta02(self.mContentRect, endY)

    if (isBottom) then
        self:scrollToIndex(#self.mItemList)
    else
        self:setUnReadCount(self.mUnReadCount + 1)
    end
end

-- 修改房间号更新
function onUpdateChangeRoomResultHandler(self, args)
    if (args.isSuccess) then
        self:removeMsgTimeSn()
        self:removeMsgFrameSn()
        self.mGroupSwitchTip:SetActive(true)
        local function finishCall()
            self.mGroupSwitchTip:SetActive(false)
        end
        local function hideFun()
            TweenFactory:canvasGroupAlphaTo(self.mCanvasGroupSwitch, 1, 0, 1, nil, finishCall)
        end
        TweenFactory:canvasGroupAlphaTo(self.mCanvasGroupSwitch, 0, 1, 1, nil, hideFun)
        self:updateView(true)
    else
        self:updateRoomView()
    end
end

-- 禁言更新
function onUpdateForbidHandler(self, args)
    self:updateForbidTime()
end

-- 面板对应频道数据更新
function onUpdatePanelHandler(self, args)
    self:updateView(true)
end

-- 讯飞录音解析OK
function onSpeechResultFinishHandler(self, args)
    -- 讯飞语音文件不区分模块，所以在各自模块里监听后再进行转发各自模块处理
    GameDispatcher:dispatchEvent(EventName.REQ_CHAT_SPEECH_UPLOAD, args)
end

function updateView(self, cusInit)
    self:closeLoadTip()
    self:updateListView(cusInit)
    self:updateRoomView()
    self:setUnReadCount(0)
    self:updateRoomPeople()
    self:updateForbidTime()
    self:updateCdTime()
    self:setInputLimit(chat.ChatManager:getChatConfig(self:getCurChannel()).maxWords)
end

function updateListView(self, cusInit)
    self.mIsInitListOk = false
    self:resetAllItem()
    local isBottom = self:getIsBottom()
    local list = chat.ChatManager:getChatListByChannel(self:getCurChannel())
    local showCount = 0
    for i = #list, 1, -1 do
        self.mFirstItemSn = list[i]:getSn()
        local item = chat.getShowItem(list[i].contentType):create(self.mContentTrans, list[i])
        table.insert(self.mItemList, 1, item)
        showCount = showCount + 1
        if (showCount >= self.mFirstShowCount) then
            break
        end
    end
    local count = #self.mItemList
    local allHeight = 0
    for i = 1, count do
        local item = self.mItemList[i]
        item:setPosY(-allHeight)
        allHeight = allHeight + item:getHeight() + self.mContentGap
    end
    gs.TransQuick:SizeDelta02(self.mContentRect, allHeight)

    if (cusInit) then
        -- 设置最底部
        self:scrollToIndex(count)
    else
        -- 设置最底部
        if (isBottom) then
            self:scrollToIndex(count)
        end
    end
    self.mIsInitListOk = true
end

function updateRoomView(self)
    local roomList = chat.ChatManager:getChannelRoomList(self:getCurChannel())
    if (#roomList > 0) then
        self.mGroupRoom:SetActive(true)
        self.mRoomInputField.text = tonumber(chat.ChatManager:getChannelRoom(self:getCurChannel())) --"频道"
    else
        self.mGroupRoom:SetActive(false)
    end
end

function setUnReadCount(self, count)
    if (count >= 0) then
        self.mUnReadCount = count
    else
        self.mUnReadCount = 0
    end
    self:updateUnReanView()
end

function updateUnReanView(self)
    if (self.mUnReadCount > 0) then
        self.mGroupMsgTip:SetActive(true)
        self.mTextMsgTip.text = string.substitute(_TT(515), self.mUnReadCount) --"未读消息["..HtmlUtil:color(self.mUnReadCount, "38ff75").."]条"
        self:addScrollFrameSn()
    else
        self.mGroupMsgTip:SetActive(false)
        self:removeScrollFrameSn()
    end
end

function updateRoomPeople(self)
    local curRoom = tonumber(chat.ChatManager:getChannelRoom(self:getCurChannel()))
    self.mTextSwitchTip.text = string.substitute(_TT(516), curRoom, chat.ChatManager.roomPeople) --"已进入["..HtmlUtil:color(curRoom, "38ff75").."]频道（当前人数："..chat.ChatManager.roomPeople.."）"
end

-- 更新发言的间隔cd
function updateCdTime(self)
    local remainTime = chat.ChatManager:getCdRemainTime(self:getCurChannel())
    if (remainTime > 0) then
        self:setDefaultContent(string.substitute(_TT(514), remainTime)) --"s后可发言"
        if (self.m_cdTimeFrameSn == nil) then
            self.m_cdTimeFrameSn = LoopManager:addTimer(1, 0, self, self.updateCdTime)
            -- self.m_cdTimeFrameSn = self:addTimer(1, 0, self.updateCdTime)
        end
    else
        self:setDefaultContent(_TT(521)) --"请输入"
        self:removeCdTimeFrameSn()
    end
end

function removeCdTimeFrameSn(self)
    if (self.m_cdTimeFrameSn) then
        -- self:removeTimerByIndex(self.m_cdTimeFrameSn)
        LoopManager:removeTimerByIndex(self.m_cdTimeFrameSn)
        self.m_cdTimeFrameSn = nil
    end
end

-- 更新禁言的间隔cd
function updateForbidTime(self)
    local clientTime = GameManager:getClientTime()
    local forbidTime = chat.ChatManager:getForbidTime(self:getCurChannel())
    if (forbidTime and forbidTime > clientTime) then
        self:setDefaultContent(string.substitute(_TT(514), forbidTime - clientTime)) --"s后可发言"
        if (self.m_forbidTimeFrameSn == nil) then
            self.m_forbidTimeFrameSn = LoopManager:addTimer(1, 0, self, self.updateForbidTime)
            -- self.m_forbidTimeFrameSn = self:addTimer(1, 0, self.updateForbidTime)
        end
    else
        self:setDefaultContent(_TT(521)) --"请输入"
        self:removeForbidTimeFrameSn()
    end
end

function removeForbidTimeFrameSn(self)
    if (self.m_forbidTimeFrameSn) then
        -- self:removeTimerByIndex(self.m_forbidTimeFrameSn)
        LoopManager:removeTimerByIndex(self.m_forbidTimeFrameSn)
        self.m_forbidTimeFrameSn = nil
    end
end

-- 滚动至index
function scrollToIndex(self, index)
    if (self.mItemList[index]) then
        local item = self.mItemList[index]
        local targetY = -item:getPosY()
        local dragH = math.max(0, self.mContentRect.sizeDelta.y - self.mScrollRect.rect.size.y)
        targetY = math.min(targetY, dragH)
        gs.TransQuick:UIPosY(self.mContentRect, targetY)

        self:updateReadEndSn(item:getData():getSn())
    end
end

function updateReadEndSn(self, itemSn)
    -- if(itemSn and (not self.mReadEndSn or self.mReadEndSn <= itemSn))then
    --     self.mReadEndSn = itemSn
    -- end
end

function resetAllItem(self)
    if (self.mItemList) then
        for i = 1, #self.mItemList do
            local item = self.mItemList[i]
            item:poolRecover()
        end
    end
    self.mItemList = {}
    self.mFirstItemSn = nil
end

function removeScrollToFrameSn(self)
    if (self.m_scrollToFrameSn) then
        LoopManager:removeFrameByIndex(self.m_scrollToFrameSn)
        self.m_scrollToFrameSn = nil
    end
end

-- 获取房间号范围
function getRoomRange(self, searchRoom)
    local roomList = chat.ChatManager:getChannelRoomList(self:getCurChannel())
    local minRoom = nil
    local maxRoom = nil
    local isExist = false
    for i = 1, #roomList do
        if (not minRoom or roomList[i] < minRoom) then
            minRoom = roomList[i]
            -- 有可能最小房间号也爆满，so最小写死1
            minRoom = 1
        end
        if (not maxRoom or roomList[i] > maxRoom) then
            maxRoom = roomList[i]
        end
        if (roomList[i] == searchRoom) then
            isExist = true
        end
    end
    return minRoom, maxRoom, isExist
end

-- 判断聊天容器是否处于底部
function getIsBottom(self)
    local curIsBottom = false
    if (not gs.GoUtil.IsCompNull(self.mContentRect)) then
        local deltaY = math.ceil(self.mContentRect.sizeDelta.y - self.mScrollRect.rect.size.y)
        if (deltaY <= 0) then
            curIsBottom = true
        elseif (math.ceil(self.mContentRect.anchoredPosition.y) >= deltaY) then
            curIsBottom = true
        end
    end
    return curIsBottom
end

function addScrollFrameSn(self)
    local function updateBottom()
        if (self:getIsBottom()) then
            self:setUnReadCount(0)
        end
    end
    if (not self.mScrollFrameSn) then
        self.mScrollFrameSn = LoopManager:addFrame(5, 0, self, updateBottom)
    end
end

function removeScrollFrameSn(self)
    if (self.mScrollFrameSn) then
        LoopManager:removeFrameByIndex(self.mScrollFrameSn)
        self.mScrollFrameSn = nil
    end
end

function getCurChannel(self)
    return chat.getChannelByTab(self.mSelectPage)
end

function getCurRoom(self)
    return chat.ChatManager:getChannelRoom(self:getCurChannel())
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]