module("braceletsCommunicate.BraceletsCommunicatePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("braceletsCommunicate/BraceletsCommunicatePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗
isBlur = 1

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.Communication)
end

-- 初始化数据
function initData(self)
    self.mTargetListItem = {}
    self.mMsgListItem = {}
    self.mBtnList = {}
    self.mGroupTargetData = {}
    self.mTimeSn = nil
    self.mIsDraging = false
    self.mIsOpenPrivate = true
    self.mCommunicateSn = nil
    self.mReplySn = nil

    -- 刷新保存多少条记录(建议同下条参数)
    self.channelMaxCount = 10
    -- 历史消息每次加载多少条聊天记录
    self.mOnceLoadCount = 10
    -- 是否需要加载
    self.mIsNeedLoad = false
    -- 显示的第一条数据的唯一值
    self.mFirstItemSn = nil
    self.mScrollSn = nil

    -- 当前聊天新增的缓存列表
    self.mChatCacheList = nil
    -- 当前聊天正在显示的缓存列表
    self.mChatCacheShowList = nil
    self.mNowAllCount = 0
    self.mNowStartIndex = 1
end

function configUI(self)
    self.Left = self:getChildGO("Left")
    self.Right = self:getChildGO("Right")
    self.mReply = self:getChildGO("mReply")

    self.mImgPower = self:getChildTrans("mImgPower")
    self.mImgWifi = self:getChildGO("mImgWifi"):GetComponent(ty.AutoRefImage)

    self.mBtnPrivateChat = self:getChildGO("mBtnPrivateChat")
    self.mBtnPublicChat = self:getChildGO("mBtnPublicChat")
    self.mTxtPrivate = self:getChildGO("mTxtPrivate"):GetComponent(ty.Text)
    self.mIconPrivate = self:getChildGO("mIconPrivate"):GetComponent(ty.Image)
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

    self.mTxtPublic = self:getChildGO("mTxtPublic"):GetComponent(ty.Text)
    self.mIconPublic = self:getChildGO("mIconPublic"):GetComponent(ty.Image)

    self.mLyScroller = self:getChildGO("LyScroller"):GetComponent(ty.LyScroller)
    self.mLyScroller:SetItemRender(braceletsCommunicate.BraceletsCommunicateTargetItem)

    self.mGroupUP = self:getChildTrans("mGroupUP")
    self.mGroupRoom = self:getChildGO("mGroupRoom")
    self.mTxtChannel = self:getChildGO("mTxtChannel"):GetComponent(ty.Text)
    self.mTxtChannelDes = self:getChildGO("mTxtChannelDes"):GetComponent(ty.Text)
    self.mScrollView = self:getChildGO("mScrollView"):GetComponent(ty.ScrollRect)
    self.mScrollRect = self.mScrollView:GetComponent(ty.RectTransform)

    self.mGroupHorizontalLine = self:getChildGO("mGroupHorizontalLine")
    self.mContentTrans = self:getChildTrans("mContent")
    self.mContentRect = self.mContentTrans:GetComponent(ty.RectTransform)
    self.mEventTrigger = self.mScrollView:GetComponent(ty.LongPressOrClickEventTrigger)
    self.mScrollerValueEvent = self.mScrollView:GetComponent(ty.ScrollRect).onValueChanged

    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mChooseContent = self:getChildTrans("mChooseContent")
    self.mChooseRect = self.mChooseContent:GetComponent(ty.RectTransform)
    self.mBtnChoose = self:getChildGO("mBtnChoose")

    self.EmptyStateItem = self:getChildGO("EmptyStateItem")
    self.mTxtEmptyTip = self:getChildGO("mTxtEmptyTip"):GetComponent(ty.Text)
    self.mMask = self:getChildGO("mMask")

    self.mPrivateRed = self:getChildGO("mPrivateRed")
    self.mTxtPrivateRed = self:getChildGO("mTxtPrivateRed"):GetComponent(ty.Text)
    self.mPublicRed = self:getChildGO("mPublicRed")
    self.mTxtPublicRed = self:getChildGO("mTxtPublicRed"):GetComponent(ty.Text)

    self.mEmojiTrans = self:getChildTrans("mEmoji")
    self.mEmojiItem = self:getChildGO("mEmojiItem")
end

function initViewText(self)
    self.mTxtEmptyTip.text = _TT(522)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnPublicChat, self.onClickPublicHandler)
    self:addUIEvent(self.mBtnPrivateChat, self.onClickPrivateHandler)
    self:addUIEvent(self.mBtnClose, self.onClickCloseCommunicateHandler)
    self:addUIEvent(self.mMask, self.onClickCommunicate)
end

function onClickPrivateHandler(self, isInit)
    local privateData = braceletsCommunicate.BraceletsCommunicateManager:getPrivateChat()
    if self.mIsOpenPrivate and not isInit then
        return
    end
    self:updateMsgImmediately()
    self.mGroupTargetData = privateData
    self:updateTargetItem()
    self.mTxtPrivate.color = gs.ColorUtil.GetColor("202226ff")
    self.mIconPrivate.color = gs.ColorUtil.GetColor("202226ff")

    self.mTxtPublic.color = gs.ColorUtil.GetColor("82898cff")
    self.mIconPublic.color = gs.ColorUtil.GetColor("82898cff")
    self.mIsOpenPrivate = true
end

function onClickPublicHandler(self)
    local publicData = braceletsCommunicate.BraceletsCommunicateManager:getPublicChat()
    if not self.mIsOpenPrivate then
        return
    end
    self:updateMsgImmediately()
    self.mGroupTargetData = publicData
    self:updateTargetItem()
    self.mTxtPrivate.color = gs.ColorUtil.GetColor("82898cff")
    self.mIconPrivate.color = gs.ColorUtil.GetColor("82898cff")

    self.mTxtPublic.color = gs.ColorUtil.GetColor("202226ff")
    self.mIconPublic.color = gs.ColorUtil.GetColor("202226ff")
    self.mIsOpenPrivate = false
end

function onClickCloseCommunicateHandler(self)
    if braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget() == nil then
        return
    end
    self.Right:SetActive(false)
    TweenFactory:move2LPosX(self.Left.transform, -24, 0.3)
    self:updateMsgImmediately()
    braceletsCommunicate.BraceletsCommunicateManager:setNowSelectTarget(nil)
    self:updateTargetItem()
    if self.mScrollSn then
        LoopManager:removeFrameByIndex(self.mScrollSn)
        self.mScrollSn = nil
    end
end

-- 回复界面
function onClickReplyHandler(self, call)
    self:recoverBtnList()
    self:clearReplySn()
    --self.mChooseContent.gameObject:SetActive(true)
    local mNowSelectTargetId = braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget()
    local newestSegId, newestTalkId, _ = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateMsgVo(
        mNowSelectTargetId):getNewestSegmentId()
    local configVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateConfig(mNowSelectTargetId)
        :getTalkVo(newestSegId, newestTalkId)
        self.mChooseContent.gameObject:SetActive(configVo.type == 2)
        self.mEmojiTrans.gameObject:SetActive(configVo.type == 3)

    for k, v in pairs(configVo.nextId) do
        local configVoMsg = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateConfig(mNowSelectTargetId)
            :getTalkMsg(newestSegId, v)
            local btnItem
        if configVo.type == 2 then
            btnItem = SimpleInsItem:create(self.mBtnChoose, self.mChooseContent,
                "BraceletsCommunicatePanelBtnChoose")
            local btnText = btnItem:getChildGO("mTxtBtnTxt"):GetComponent(ty.Text)
            local btnColor = btnItem:getGo():GetComponent(ty.Image)

            btnText.text = configVoMsg
            btnText.color = gs.ColorUtil.GetColor("202226ff")

            if btnText:GetComponent(ty.RectTransform).sizeDelta.y > 30 then
                btnText.alignment = gs.TextAnchor.UpperLeft
            else
                btnText.alignment = gs.TextAnchor.UpperCenter
            end
        elseif configVo.type == 3 then
            btnItem = SimpleInsItem:create(self.mEmojiItem, self.mEmojiTrans,
            "BraceletsBtnEmoji")
            btnItem.m_go:GetComponent(ty.AutoRefImage):SetImg(configVoMsg)
        end

      

        if k == #configVo.nextId then
            -- 延迟等待自动布局完成
            self.mReplySn = LoopManager:addFrame(1, 1, self, function()
                call()
            end)
        end
        btnItem:addUIEvent(nil, function()
            GameDispatcher:dispatchEvent(EventName.REQ_COMMUNICATE_SELETE, {
                targetId = mNowSelectTargetId,
                talkId = v
            })
            self:recoverBtnList()
            self:clearReplySn()
            self.mChooseContent.gameObject:SetActive(false)
            TweenFactory:move2LPosY(self.mContentRect, self.mContentRect.sizeDelta.y, 0.5)
        end)
        table.insert(self.mBtnList, btnItem)
    end
end

-- 点击出对话
function onClickCommunicate(self, isEnd)
    local mNowSelectTargetId = braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget()
    if not mNowSelectTargetId or self.mIsDraging then
        return
    end
    local newestSegId, newestTalkId, index = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateMsgVo(
        mNowSelectTargetId):getNewestSegmentId()
    local configVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateConfig(mNowSelectTargetId)
    local talkVo = configVo:getTalkVo(newestSegId, newestTalkId)
    if talkVo.type == 2 or index == 2 then
        if self.mCommunicateSn then
            LoopManager:removeTimerByIndex(self.mCommunicateSn)
            self.mCommunicateSn = nil
        end
        return
    end
    if (index == 1 and #talkVo.relation > 1) then
        if not braceletsCommunicate.BraceletsCommunicateManager:getNewestHasRead(mNowSelectTargetId) or
            (talkVo.reward ~= 0) then
            local heroVo = hero.HeroManager:getHeroConfigVo(talkVo.relation[1])
            local who = heroVo.name
            gs.Message.Show(who .. "好感度+" .. talkVo.relation[2])
        end
    end
    if not braceletsCommunicate.BraceletsCommunicateManager:getNewestHasRead(mNowSelectTargetId) then
        braceletsCommunicate.BraceletsCommunicateManager:setNewestHasRead(mNowSelectTargetId, newestTalkId, true)
        GameDispatcher:dispatchEvent(EventName.UPDATE_TARGET_INFO, mNowSelectTargetId)
        self:checkRed()
        if talkVo.nextId[1] ~= 2 then
            self.mNowAllCount = 0
            -- self:onLoadHistoryHandler()
            local lastCommunication = self.mMsgListItem[#self.mMsgListItem]
            if lastCommunication then
                lastCommunication:__updateView()
            end
        end
        if talkVo.reward > 0 then
            GameDispatcher:dispatchEvent(EventName.REQ_COMMUNICATE, mNowSelectTargetId) -- 领取奖励
        end
    else
        if index == 1 then
            GameDispatcher:dispatchEvent(EventName.REQ_COMMUNICATE, mNowSelectTargetId)
        end
    end
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_COMMUNICATION,
        braceletsCommunicate.BraceletsCommunicateManager:checkIsRed())
end

function active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_COMMUNICATE_TARGET, self.onChatMsgUpdateHandler, self)
    GameDispatcher:addEventListener(EventName.CHANGE_COMMUNICATE_TARGET, self.onChangeTarget, self)
    GameDispatcher:addEventListener(EventName.UPDATE_COMMUNICATE_HISTORY, self.onReloadHistory, self)
    self.mTxtPrivate.color = gs.ColorUtil.GetColor("202226ff")
    self.mIconPrivate.color = gs.ColorUtil.GetColor("202226ff")

    self.mTxtPublic.color = gs.ColorUtil.GetColor("82898cff")
    self.mIconPublic.color = gs.ColorUtil.GetColor("82898cff")
    self:updateView(true)
    self:checkRed()
    if not self.mTimeSn then
        local function TimeCount()
            self.mTxtTime.text = gs.DeviceInfoMgr:GetDateTime()
            local battery = gs.DeviceInfoMgr:GetBatteryLevel() == -1 and 1 or gs.DeviceInfoMgr:GetBatteryLevel()
            gs.TransQuick:ScaleX(self.mImgPower, battery)
            if gs.DeviceInfoMgr:GetIsWifi() == 1 then
                self.mImgWifi:SetImg(UrlManager:getPackPath("mainui/mainui_3.png"), true)
            else
                self.mImgWifi:SetImg(UrlManager:getPackPath("mainui/mainui_28.png"), true)
            end
        end
        self.mTimeSn = LoopManager:addTimer(0, 0, self, TimeCount)
    end

    self.mEventTrigger.onClick:AddListener(function()
        self:onClickCommunicate()
    end)
    self.mEventTrigger.onBeginDrag:AddListener(function()
        self:onBeginDragHandler()
        self.mIsDraging = true
    end)
    self.mEventTrigger.onEndDrag:AddListener(function()
        self:onEndDragHandler()
        self.mIsDraging = false
    end)
end

function deActive(self)
    self:updateMsgImmediately()
    braceletsCommunicate.BraceletsCommunicateManager:setNowSelectTarget(nil)
    GameDispatcher:removeEventListener(EventName.UPDATE_COMMUNICATE_TARGET, self.onChatMsgUpdateHandler, self)
    GameDispatcher:removeEventListener(EventName.CHANGE_COMMUNICATE_TARGET, self.onChangeTarget, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_COMMUNICATE_HISTORY, self.onReloadHistory, self)
    self.mEventTrigger.onClick:RemoveAllListeners()
    self.mEventTrigger.onBeginDrag:RemoveAllListeners()
    self.mEventTrigger.onEndDrag:RemoveAllListeners()
    self.mLyScroller:CleanAllItem()
    self:recoverBtnList()
    self:clearReplySn()
    self:recoverMsgList()
    self.mChatCacheList = nil
    self.mChatCacheShowList = nil

    if self.mTimeSn then
        LoopManager:removeTimerByIndex(self.mTimeSn)
        self.mTimeSn = nil
    end
    if self.mScrollSn then
        LoopManager:removeFrameByIndex(self.mScrollSn)
        self.mScrollSn = nil
    end
    if self.mCommunicateSn then
        LoopManager:removeTimerByIndex(self.mCommunicateSn)
        self.mCommunicateSn = nil
    end
    -- RedPointManager:remove(self.mBtnPrivateChat.transform)
    -- RedPointManager:remove(self.mBtnPublicChat.transform)
    self.mNowAllCount = 0
end

function onUpdateTarget(self)
    self:updateTargetItem()
    self:checkRed()
end

-- 变更聊天对象
function onChangeTarget(self, targetId)
    self.mEmojiTrans.gameObject:SetActive(false)
    local mNowSelectTargetId = braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget()
    if mNowSelectTargetId == nil then
        braceletsCommunicate.BraceletsCommunicateManager:setNowSelectTarget(targetId)
        -- 动效
        TweenFactory:move2LPosX(self.Left.transform, -414, 0.3, gs.DT.Ease.Linear, function()
        end)
        self.Right:SetActive(true)
    else
        if mNowSelectTargetId == targetId then
            return
        end
        self.mNowAllCount = 0
        self:recoverMsgList()
        self.mChooseContent.gameObject:SetActive(false)
        self:updateMsgImmediately()
        braceletsCommunicate.BraceletsCommunicateManager:setNowSelectTarget(targetId)
    end
    self:updateView()
end

function onReloadHistory(self, targetId)
    if targetId == braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget() then
        self:onLoadHistoryHandler()
    end
    self:updateTargetItem()
    self:checkRed()
    -- GameDispatcher:dispatchEvent(EventName.UPDATE_TARGET_INFO, targetId)
end

function updateView(self, isInit)
    self:updateTargetItem()
    self:onLoadHistoryHandler()
    if isInit then
        self:onClickPrivateHandler(isInit)
    end
end

function updateTargetItem(self)
    self.EmptyStateItem:SetActive(#self.mGroupTargetData == 0)
    if (self.mLyScroller.Count == 0) then
        self.mLyScroller.DataProvider = self.mGroupTargetData
    else
        self.mLyScroller:ReplaceAllDataProvider(self.mGroupTargetData)
    end
end

-- 滚动列表拖动开始
function onBeginDragHandler(self)
    self.mScrollerValueEvent:RemoveAllListeners()
    self.mScrollerValueEvent:AddListener(function()
        self:onScollChangedHandler()
    end)
end

function onScollChangedHandler(self)
    local y = self.mContentRect.anchoredPosition.y
    if y <= 0.1 and self.mContentRect.sizeDelta.y > self.mScrollRect.rect.size.y then
        self.mIsNeedLoad = true
    end
end

function onEndDragHandler(self)
    self.mScrollerValueEvent:RemoveAllListeners()
    if (self.mIsNeedLoad) then
        self:onLoadHistoryHandler(self.mIsNeedLoad)
        self.mIsNeedLoad = false
    end
end

-- 历史消息
function onLoadHistoryHandler(self, needLoad)
    self.mMask:SetActive(true)
    local mNowSelectTargetId = braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget()
    self.mTxtChannel.gameObject:SetActive(false)
    if not mNowSelectTargetId then
        return
    end
    -- 旧消息
    local msgVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateMsgVo(mNowSelectTargetId)
    local configVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateConfig(mNowSelectTargetId)
    if configVo.type == 2 then
        self.mTxtChannel.text = configVo.name
        self.mTxtChannelDes.gameObject:SetActive(false)
    else
        local heroTid = configVo.heroList[1]
        local heroConfig = hero.HeroManager:getHeroConfigVo(heroTid)
        self.mTxtChannel.text = heroConfig.name
        self.mTxtChannelDes.text = _TT(configVo.signId)

        self.mTxtChannelDes.gameObject:SetActive(self.mTxtChannelDes.text ~= "")
    end
    self.mTxtChannel.gameObject:SetActive(true)
    local anchoPosY = self.mContentRect.anchoredPosition.y
    local deltaY = self.mContentRect.sizeDelta.y + 100
    self:recoverMsgList()
    local newestSegId, newestTalkId, index = msgVo:getNewestSegmentId()
    local list = {}
    local isEnd = false
    local replyEnd = false
    local isImg = false

    for k, v in pairs(msgVo.segmentDic) do
        local segId = k
        local talkList = v
        local nextId = nil
        isEnd = false
        replyEnd = false
        -- 获得正序
        for i = #talkList, 1, -1 do
            if talkList[i] == 0 then
                break
            end
            local msgConfig = configVo:getTalkVo(segId, talkList[i])
            if (msgConfig.type == 2 or msgConfig.type == 3) and (i > 1) then
            else
                table.insert(list, {
                    segId = segId,
                    index = i,
                    msgConfig = msgConfig,
                    isEnd = false
                })
            end
            replyEnd = ((msgConfig.type == 2 or msgConfig.type == 3) and (i == 1))
            isImg = msgConfig.type == 3
            isEnd = msgConfig.nextId[1] == 0

            if isEnd and
                (braceletsCommunicate.BraceletsCommunicateManager:getNewestStoreNum(mNowSelectTargetId) == 0 or
                    newestSegId > segId) then
                table.insert(list, {
                    isEnd = true
                })
            end
        end
    end
    local loadCount = 0
    self.mNowStartIndex = #list - (self.mOnceLoadCount + self.mNowAllCount) + 1
    self.mNowStartIndex = self.mNowStartIndex <= 0 and 1 or self.mNowStartIndex
    if self.mNowStartIndex < 1 then
        start = 1
    end
    for i = self.mNowStartIndex, #list do
        if (not list[i].isEnd) then
            if (list[i].msgConfig.type == 2 or list[i].msgConfig.type == 3) and (list[i].index > 1) then
            else
                --- 加内容
                local msgItem = braceletsCommunicate.BraceletsCommunicateItem:create(self.mContentTrans,
                    list[i].msgConfig, configVo.heroList, mNowSelectTargetId, list[i].segId)
                table.insert(self.mMsgListItem, msgItem)
            end
        else
            --- 加线
            local msgItem = braceletsCommunicate.BraceletsCommunicateItem:create(self.mContentTrans)
            table.insert(self.mMsgListItem, msgItem)
        end
        loadCount = loadCount + 1
        if (loadCount >= self.mOnceLoadCount + self.mNowAllCount) then
            self.mNowAllCount = loadCount
        end
    end
    if self.mScrollSn then
        LoopManager:removeFrameByIndex(self.mScrollSn)
        self.mScrollSn = nil
    end
    self.mScrollSn = LoopManager:addFrame(2, 1, self, function()
        if needLoad then
            -- 上拉加载聊天内容时的定位
            gs.TransQuick:UIPosY(self.mContentRect, self.mContentRect.sizeDelta.y - deltaY)
            self.mMask:SetActive(false)
            return
        else
            self.mScrollView.verticalNormalizedPosition = 0
        end

        if replyEnd and not needLoad then -- 直接出对话
            self:onClickReplyHandler(function()
                self.mMask:SetActive(false)
                if isImg then
                    if self.mScrollRect.sizeDelta.y ~= 77.5 - 143 then
                        gs.TransQuick:SizeDelta02(self.mScrollRect, 77.5 - 143 )
                    end
                else
                    if self.mScrollRect.sizeDelta.y ~= 77.5 - self.mChooseRect.sizeDelta.y + 20 then
                        gs.TransQuick:SizeDelta02(self.mScrollRect, 77.5 - self.mChooseRect.sizeDelta.y + 20)
                    end
                end
               
                if self.mScrollView.verticalNormalizedPosition > 0.05 then
                    self.mScrollView.verticalNormalizedPosition = 0
                end
            end)
            return
        elseif not replyEnd and self.mScrollRect.sizeDelta.y ~= 77.5 then
            gs.TransQuick:SizeDelta02(self.mScrollRect, 77.5)
        end

        if not isEnd or (index == 1) then
            self:updateDelayMsg()
        end
        -- 有对话 或者 结束且已读
        if (replyEnd or
            (isEnd and braceletsCommunicate.BraceletsCommunicateManager:getNewestHasRead(mNowSelectTargetId))) then
            self.mMask:SetActive(false)
        else
            self.mMask:SetActive(true)
        end
    end)
end

-- 聊天消息新增更新
function onChatMsgUpdateHandler(self, args)
    -- 先除再加入 -- 
    local needDelCount = #self.mMsgListItem - self.channelMaxCount
    if (needDelCount > 0) then
        local delHeight = 0
        for i = 1, needDelCount do
            local item = table.remove(self.mMsgListItem, 1)
            delHeight = item:getHeight()
            item:poolRecover()
            item = nil
        end
    end

    local lastCommunication = self.mMsgListItem[#self.mMsgListItem]
    if lastCommunication then
        lastCommunication:__updateView()
    end

    self.mNowAllCount = 0
    local mNowSelectTargetId = braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget()
    local isEnd = args.isEnd
    local replyEnd = false
    local isImg = false
    if not isEnd then
        local configVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateConfig(mNowSelectTargetId)
        local msgVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateMsgVo(mNowSelectTargetId)
        local msgConfig = configVo:getTalkVo(args.partId, args.talkId)
        replyEnd = (msgConfig.type == 2 or msgConfig.type == 3)
        isImg = msgConfig.type == 3
        local msgItem = braceletsCommunicate.BraceletsCommunicateItem:create(self.mContentTrans, msgConfig,
            configVo.heroList, mNowSelectTargetId, args.partId)
        table.insert(self.mMsgListItem, msgItem)
    else
        local msgItem = braceletsCommunicate.BraceletsCommunicateItem:create(self.mContentTrans)
        table.insert(self.mMsgListItem, msgItem)
    end
    self.mEmojiTrans.gameObject:SetActive(false)
    GameDispatcher:dispatchEvent(EventName.UPDATE_TARGET_INFO, mNowSelectTargetId)

    if self.mScrollSn then
        LoopManager:removeFrameByIndex(self.mScrollSn)
        self.mScrollSn = nil
    end
    self.mScrollSn = LoopManager:addFrame(2, 1, self, function()
        if replyEnd and not needLoad then -- 直接出对话
            self:onClickReplyHandler(function()
                self.mMask:SetActive(false)
                if isImg then
                    if self.mScrollRect.sizeDelta.y ~= 77.5- 143 then
                        gs.TransQuick:SizeDelta02(self.mScrollRect, 77.5- 143 )
                    end
                else
                    if self.mScrollRect.sizeDelta.y ~= 77.5 - self.mChooseRect.sizeDelta.y + 20 then
                        gs.TransQuick:SizeDelta02(self.mScrollRect, 77.5 - self.mChooseRect.sizeDelta.y + 20)
                    end
                end
              
                if self.mScrollView.verticalNormalizedPosition > 0.05 then
                    self.mScrollView.verticalNormalizedPosition = 0
                end
            end)
            return
        elseif not replyEnd and self.mScrollRect.sizeDelta.y ~= 77.5 then
            gs.TransQuick:SizeDelta02(self.mScrollRect, 77.5)
        end
        self.mScrollView.verticalNormalizedPosition = 0

        if not isEnd then
            self:updateDelayMsg()
        end
        -- 有对话 或者 结束且已读
        if (replyEnd or
            (isEnd and braceletsCommunicate.BraceletsCommunicateManager:getNewestHasRead(mNowSelectTargetId))) then
            self.mMask:SetActive(false)
        else
            self.mMask:SetActive(true)
        end
    end)
    self:checkRed()
end

function getIsBottom(self)
    local curIsBottom = false
    if (not gs.GoUtil.IsCompNull(self.mContentRect)) then
        local deltaY = math.ceil(self.mContentRect.sizeDelta.y - self.mScrollRect.rect.size.y)
        if (deltaY <= 0.1) then
            curIsBottom = true
        elseif (math.ceil(self.mContentRect.anchoredPosition.y) >= deltaY) then
            curIsBottom = true
        end
    end
    return curIsBottom
end

-- 延迟刷新消息
function updateDelayMsg(self)
    if self.mCommunicateSn then
        LoopManager:removeTimerByIndex(self.mCommunicateSn)
        self.mCommunicateSn = nil
    end
    local mNowSelectTargetId = braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget()
    local msgVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateMsgVo(mNowSelectTargetId)
    local newestSegId, newestTalkId, index = msgVo:getNewestSegmentId()
    local configVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateConfig(mNowSelectTargetId)
    local configMsgVo = configVo:getTalkVo(newestSegId, newestTalkId)
    local hasRead = braceletsCommunicate.BraceletsCommunicateManager:getNewestHasRead(mNowSelectTargetId)
    local autoClick = function()
        self:onClickCommunicate()
    end
    if configMsgVo.type == 2 then
        autoClick()
    elseif configMsgVo.type ~= 2 and configMsgVo.reward == 0 then
        self.mCommunicateSn = LoopManager:addTimer(sysParam.SysParamManager:getValue(SysParamType.AUTOWAIT), 2, self,
            autoClick)
    end
end

-- 立即刷新消息
function updateMsgImmediately(self)
    local mNowSelectTargetId = braceletsCommunicate.BraceletsCommunicateManager:getNowSelectTarget()
    if mNowSelectTargetId == nil then
        return
    end
    local msgVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateMsgVo(mNowSelectTargetId)
    local newestSegId, newestTalkId, index = msgVo:getNewestSegmentId()
    local configVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateConfig(mNowSelectTargetId)
    local configMsgVo = configVo:getTalkVo(newestSegId, newestTalkId)
    local newestSegId, newestTalkId, index = msgVo:getNewestSegmentId()
    local hasRead = braceletsCommunicate.BraceletsCommunicateManager:getNewestHasRead(mNowSelectTargetId)
    if (not hasRead and (configMsgVo.type ~= 2 and configMsgVo.reward == 0)) then
        self:onClickCommunicate()
    end
end

function checkRed(self)
    local privateRed, privateCount = braceletsCommunicate.BraceletsCommunicateManager:checkClassicRed()
    local publicRed, publicCount = braceletsCommunicate.BraceletsCommunicateManager:checkClassicRed(true)
    self.mPrivateRed:SetActive(privateRed)
    self.mTxtPrivateRed.text = privateCount
    self.mPublicRed:SetActive(publicRed)
    self.mTxtPublicRed.text = publicCount
end

function clearReplySn(self)
    if self.mReplySn then
        LoopManager:removeFrameByIndex(self.mReplySn)
    end
end

function recoverMsgList(self)
    for k, v in pairs(self.mMsgListItem) do
        v:poolRecover()
    end
    self.mMsgListItem = {}
end

function recoverBtnList(self)
    for k, v in pairs(self.mBtnList) do
        v:poolRecover()
    end
    self.mBtnList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
