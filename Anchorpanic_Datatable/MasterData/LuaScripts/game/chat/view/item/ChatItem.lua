module('chat.ChatItem', Class.impl('lib.component.BaseContainer'))

UIRes = UrlManager:getUIPrefabPath("chat/ChatItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mChatVo = nil

    self.mContentWidth = 0
    self.mContentHeight = 0
    self.mHeight = nil
    self.mPosY = nil
end

function create(self, parent, cusVo, cusPreVo)
    local item = self:poolGet()
    item:initData()
    item:setParentTrans(parent)
    item:setData(cusVo, cusPreVo)
    return item
end

-- 为组件加入侦听点击事件
function addUIEvent(self, obj, callBack, soundPath, ...)
    self:addOnClick(obj, callBack, soundPath, ...)
    self.uiEventList = self.uiEventList or {}
    table.insert(self.uiEventList, obj)
end

-- 移除一个页面组件监听
function removeUIEvent(self, obj)
    self:removeOnClick(obj)
    table.removebyvalue(self.uiEventList, obj)
end

-- 移除所有页面组件点击侦听
function removeAllUIEvent(self)
    if self.uiEventList then
        for i = #self.uiEventList, 1, -1 do
            self:removeOnClick(self.uiEventList[i])
            table.remove(self.uiEventList, i)
        end
    end
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    self:removeAllUIEvent()
    self:__deActive()

    if self.UIObject then
        gs.GOPoolMgr:Recover(self.UIObject, self.UIRes)
    end

    self.UIObject = nil
    self.UITrans = nil
    self.m_childGos = nil
    self.m_childTrans = nil

    LuaPoolMgr:poolRecover(self)
end

function addOnParent(self, cusSiblingIndex)
    if self.UIObject == nil then
        self.UIObject = gs.GOPoolMgr:Get(self.UIRes)
        if self.UIObject then
            self.UITrans = self.UIObject.transform
            self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
            self:configUI()
        end
    end
    super.addOnParent(self, cusSiblingIndex)
end

function configUI(self)
    -- 其他人
    self.mGroupLeft = self:getChildGO("GroupLeft")
    self.mImgBgLeft = self:getChildTrans("ImgBgLeft")
    self.mRectLeftBg = self:getChildGO("ImgBgLeft"):GetComponent(ty.RectTransform)
    -- 其他人头像称号
    self.mHeadNodeLeft = self:getChildTrans("HeadNodeLeft")
    self.mTextNameLeft = self:getChildGO("TextNameLeft"):GetComponent(ty.Text)
    self.mImgTitleLeft = self:getChildGO("ImgTitleLeft"):GetComponent(ty.AutoRefImage)
    -- 其他人文本消息内容
    self.mGroupContentLeftText = self:getChildGO("GroupContentLeftText")
    self.mLeftContent = self:getChildGO("TextLeftContent"):GetComponent(ty.Text)
    self.mLeftContentRect = self:getChildGO("TextLeftContent"):GetComponent(ty.RectTransform)
    -- 其他人表情消息内容
    self.mGroupContentLeftEmoji = self:getChildGO("GroupContentLeftEmoji")
    self.mImgEmojiLeft = self:getChildGO("ImgEmojiLeft"):GetComponent(ty.AutoRefImage)
    self.mFrameEmojiLeft = self:getChildGO("ImgEmojiLeft"):GetComponent(ty.ImageFrame)
    -- 其他人语音消息内容
    self.GroupContentLeftVoice = self:getChildGO("GroupContentLeftVoice")
    self.mLeftVoiceContent = self:getChildGO("TextLeftVoiceContent"):GetComponent(ty.Text)
    self.mLeftVoiceContentRect = self:getChildGO("TextLeftVoiceContent"):GetComponent(ty.RectTransform)
    self.mTextLeftVoiceLen = self:getChildGO("TextLeftVoiceLen"):GetComponent(ty.Text)
    self.mBtnLeftVoice = self:getChildGO("mBtnLeftVoice")
    self:addUIEvent(self.mBtnLeftVoice, self.onClickVoiceHandler, "", self.mBtnLeftVoice)

    -- 自己
    self.mGroupRight = self:getChildGO("GroupRight")
    self.mImgBgRight = self:getChildTrans("ImgBgRight")
    self.mRectRightBg = self:getChildGO("ImgBgRight"):GetComponent(ty.RectTransform)
    -- 自己头像称号
    self.mHeadNodeRight = self:getChildTrans("HeadNodeRight")
    self.mTextNameRight = self:getChildGO("TextNameRight"):GetComponent(ty.Text)
    self.mImgTitleRight = self:getChildGO("ImgTitleRight"):GetComponent(ty.AutoRefImage)
    -- 自己文本消息内容
    self.mGroupContentRightText = self:getChildGO("GroupContentRightText")
    self.mRightContent = self:getChildGO("TextRightContent"):GetComponent(ty.Text)
    self.mRightContentRect = self:getChildGO("TextRightContent"):GetComponent(ty.RectTransform)
    -- 自己表情消息内容
    self.mGroupContentRightEmoji = self:getChildGO("GroupContentRightEmoji")
    self.mImgEmojiRight = self:getChildGO("ImgEmojiRight"):GetComponent(ty.AutoRefImage)
    self.mFrameEmojiRight = self:getChildGO("ImgEmojiRight"):GetComponent(ty.ImageFrame)
    -- 自己语音消息内容
    self.GroupContentRightVoice = self:getChildGO("GroupContentRightVoice")
    self.mRightVoiceContent = self:getChildGO("TextRightVoiceContent"):GetComponent(ty.Text)
    self.mRightVoiceContentRect = self:getChildGO("TextRightVoiceContent"):GetComponent(ty.RectTransform)
    self.mTextRightVoiceLen = self:getChildGO("TextRightVoiceLen"):GetComponent(ty.Text)
    self.mBtnRightVoice = self:getChildGO("mBtnRightVoice")
    self:addUIEvent(self.mBtnRightVoice, self.onClickVoiceHandler, "", self.mBtnRightVoice)

    self.mTxtLeftTime = self:getChildGO("mTxtLeftTime"):GetComponent(ty.Text)
    self.mTxtRightTime = self:getChildGO("mTxtRightTime"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
    if self.m_chatHeadGrid then
        self.m_chatHeadGrid:poolRecover()
        self.m_chatHeadGrid = nil
    end

    if (self.mLeftChatBubbleTrans and not gs.GoUtil.IsTransNull(self.mLeftChatBubbleTrans)) then
        gs.GOPoolMgr:Recover(self.mLeftChatBubbleTrans.gameObject, self.mBubblePath)
        self.mLeftChatBubbleTrans = nil
    end

    if (self.mRightChatBubbleTrans and not gs.GoUtil.IsTransNull(self.mRightChatBubbleTrans)) then
        gs.GOPoolMgr:Recover(self.mRightChatBubbleTrans.gameObject, self.mBubblePath)
        self.mRightChatBubbleTrans = nil
    end
end

function setData(self, chatVo)
    self.mChatVo = chatVo
    self:__updateView()
end

function __updateView(self)
    local bubbleConfig = decorate.DecorateManager:getChatBubbleConfig(self.mChatVo.chatBubbleId)
    if bubbleConfig then
        self.mBubblePath = bubbleConfig:getPrefabPath()
        local leftChatBubbleGo = gs.GOPoolMgr:Get(self.mBubblePath)
        self.mLeftChatBubbleTrans = leftChatBubbleGo.transform
        gs.TransQuick:SetParentOrg(self.mLeftChatBubbleTrans, self.mImgBgLeft)
        gs.TransQuick:UIPos(self.mLeftChatBubbleTrans:GetComponent(ty.RectTransform), 0, 0)

        local rightChatBubbleGo = gs.GOPoolMgr:Get(self.mBubblePath)
        self.mRightChatBubbleTrans = rightChatBubbleGo.transform
        gs.TransQuick:SetParentOrg(self.mRightChatBubbleTrans, self.mImgBgRight)
        gs.TransQuick:UIPos(self.mRightChatBubbleTrans:GetComponent(ty.RectTransform), 0, 0)

        local contentType = self.mChatVo.contentType
        local isOwn = self.mChatVo:isOwn()
        if (isOwn) then
            self.mGroupLeft:SetActive(false)
            self.mGroupRight:SetActive(true)
            self.mGroupContentRightText:SetActive(contentType == chat.ContentType.JUST_TEXT)
            self.mGroupContentRightEmoji:SetActive(contentType == chat.ContentType.STATIC_EMOJI or contentType == chat.ContentType.DYNAMIC_EMOJI)
            self.GroupContentRightVoice:SetActive(contentType == chat.ContentType.VOICE_TEXT)
            self:__updateRightInfo(bubbleConfig)
        else
            self.mGroupLeft:SetActive(true)
            self.mGroupRight:SetActive(false)
            self.mGroupContentLeftText:SetActive(contentType == chat.ContentType.JUST_TEXT)
            self.mGroupContentLeftEmoji:SetActive(contentType == chat.ContentType.STATIC_EMOJI or contentType == chat.ContentType.DYNAMIC_EMOJI)
            self.GroupContentLeftVoice:SetActive(contentType == chat.ContentType.VOICE_TEXT)
            self:__updateLeftInfo(bubbleConfig)
        end
    end
end

function __updateLeftInfo(self, bubbleConfig)
    local contentType = self.mChatVo.contentType
    self.mTextNameLeft.text = self.mChatVo:getSendName()
    local titleDataRo = decorate.DecorateManager:getPlayerTitleConfigVo(self.mChatVo:getSendTitle())
    if (titleDataRo) then
        self.mImgTitleLeft.gameObject:SetActive(true)
        self.mImgTitleLeft:SetImg(UrlManager:getPlayerTitleUrl(titleDataRo:getIcon()), false)
    else
        self.mImgTitleLeft.gameObject:SetActive(false)
    end

    self.mTxtLeftTime.text = TimeUtil.getFormatTimeBySeconds_12(self.mChatVo.sendTime)

    if (not self.m_chatHeadGrid) then
        self.m_chatHeadGrid = chat.ChatHeadGrid:poolGet()
    end
    self.m_chatHeadGrid:setData(self.mChatVo)
    self.m_chatHeadGrid:setParent(self.mHeadNodeLeft)
    self.m_chatHeadGrid:setScale(1)
    self.m_chatHeadGrid:setClickEnable(true)
    self.m_chatHeadGrid:setCallBack(self, self.__onClickHeadGridHandler)

    if (contentType == chat.ContentType.JUST_TEXT) then
        local content = self.mChatVo.content
        self.mLeftContent.text = bubbleConfig:getColorContent(content)
        local textWidth = math.min(self.mLeftContent.preferredWidth or gs.LayoutUtility.GetPreferredSize(self.mLeftContentRect, 0), 385)
        gs.TransQuick:SizeDelta01(self.mLeftContentRect, textWidth)
        local textHeight = self.mLeftContent.preferredHeight or gs.LayoutUtility.GetPreferredSize(self.mLeftContentRect, 1)
        gs.TransQuick:SizeDelta02(self.mLeftContentRect, textHeight)
        self.mContentWidth = textWidth
        self.mContentHeight = textHeight
    elseif (contentType == chat.ContentType.STATIC_EMOJI or contentType == chat.ContentType.DYNAMIC_EMOJI) then
        if (contentType == chat.ContentType.STATIC_EMOJI) then
            self.mFrameEmojiLeft.enabled = false
            -- 先清理下服用到的之前的帧相关
            self.mImgEmojiLeft:SetImg(nil, true)
            self.mImgEmojiLeft:SetImg(chat.getEmojiUrl(contentType, self.mChatVo.content), true)
        elseif (contentType == chat.ContentType.DYNAMIC_EMOJI) then
            self.mFrameEmojiLeft.enabled = true
            self.mFrameEmojiLeft:SetSpriteList(unpack(chat.getEmojiUrl(contentType, self.mChatVo.content)))
        end
        self.mContentWidth = 128
        self.mContentHeight = 128
    elseif (contentType == chat.ContentType.VOICE_TEXT) then
        local voiceContent, key, voiceLen = chat.parseVoiceFormatContent(self.mChatVo.content)
        self.mTextLeftVoiceLen.text = bubbleConfig:getColorContent(voiceLen .. "s''")
        self.mLeftVoiceContent.text = bubbleConfig:getColorContent(voiceContent)
        local textWidth = math.min(self.mLeftVoiceContent.preferredWidth or gs.LayoutUtility.GetPreferredSize(self.mLeftVoiceContentRect, 0), 385)
        gs.TransQuick:SizeDelta01(self.mLeftVoiceContentRect, textWidth)
        local textHeight = self.mLeftVoiceContent.preferredHeight or gs.LayoutUtility.GetPreferredSize(self.mLeftVoiceContentRect, 1)
        gs.TransQuick:SizeDelta02(self.mLeftVoiceContentRect, textHeight)
        self.mContentWidth = textWidth
        self.mContentHeight = textHeight
    else
        Debug:log_error("ChatItem", string.format("未实现的消息类型:%s", contentType))
    end

    local bgWidth, bgHeight = self:__getBgSize()
    gs.TransQuick:SizeDelta(self.mRectLeftBg, bgWidth, bgHeight)

    self.mHeight = math.max(bgHeight + 2 * 30, 120)
    gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), self.mHeight)
end

function __updateRightInfo(self, bubbleConfig)
    local contentType = self.mChatVo.contentType
    self.mTextNameRight.text = self.mChatVo:getSendName()
    local titleDataRo = decorate.DecorateManager:getPlayerTitleConfigVo(self.mChatVo:getSendTitle())
    if (titleDataRo) then
        self.mImgTitleRight.gameObject:SetActive(true)
        self.mImgTitleRight:SetImg(UrlManager:getPlayerTitleUrl(titleDataRo:getIcon()), false)
    else
        self.mImgTitleRight.gameObject:SetActive(false)
    end

    self.mTxtRightTime.text = TimeUtil.getFormatTimeBySeconds_12(self.mChatVo.sendTime)

    if (not self.m_chatHeadGrid) then
        self.m_chatHeadGrid = chat.ChatHeadGrid:poolGet()
    end
    self.m_chatHeadGrid:setData(self.mChatVo)
    self.m_chatHeadGrid:setParent(self.mHeadNodeRight)
    self.m_chatHeadGrid:setScale(1)
    self.m_chatHeadGrid:setClickEnable(true)
    self.m_chatHeadGrid:setCallBack(self, self.__onClickHeadGridHandler)

    if (contentType == chat.ContentType.JUST_TEXT) then
        local content = self.mChatVo.content
        self.mRightContent.text = bubbleConfig:getColorContent(content)
        local textWidth = math.min(self.mRightContent.preferredWidth or gs.LayoutUtility.GetPreferredSize(self.mRightContentRect, 0), 385)
        gs.TransQuick:SizeDelta01(self.mRightContentRect, textWidth)
        local textHeight = self.mRightContent.preferredHeight or gs.LayoutUtility.GetPreferredSize(self.mRightContentRect, 1)
        gs.TransQuick:SizeDelta02(self.mRightContentRect, textHeight)
        self.mContentWidth = textWidth
        self.mContentHeight = textHeight
    elseif (contentType == chat.ContentType.STATIC_EMOJI or contentType == chat.ContentType.DYNAMIC_EMOJI) then
        if (contentType == chat.ContentType.STATIC_EMOJI) then
            self.mFrameEmojiRight.enabled = false
            -- 先清理下服用到的之前的帧相关
            self.mImgEmojiRight:SetImg(nil, true)
            self.mImgEmojiRight:SetImg(chat.getEmojiUrl(contentType, self.mChatVo.content), true)
        elseif (contentType == chat.ContentType.DYNAMIC_EMOJI) then
            self.mFrameEmojiRight.enabled = true
            self.mFrameEmojiRight:SetSpriteList(unpack(chat.getEmojiUrl(contentType, self.mChatVo.content)))
        end
        self.mContentWidth = 128
        self.mContentHeight = 128
    elseif (contentType == chat.ContentType.VOICE_TEXT) then
        local voiceContent, key, voiceLen = chat.parseVoiceFormatContent(self.mChatVo.content)
        self.mTextRightVoiceLen.text = bubbleConfig:getColorContent(voiceLen .. "s''")
        self.mRightVoiceContent.text = bubbleConfig:getColorContent(voiceContent)
        local textWidth = math.min(self.mRightVoiceContent.preferredWidth or gs.LayoutUtility.GetPreferredSize(self.mRightVoiceContentRect, 0), 385)
        gs.TransQuick:SizeDelta01(self.mRightVoiceContentRect, textWidth)
        local textHeight = self.mRightVoiceContent.preferredHeight or gs.LayoutUtility.GetPreferredSize(self.mRightVoiceContentRect, 1)
        gs.TransQuick:SizeDelta02(self.mRightVoiceContentRect, textHeight)
        self.mContentWidth = textWidth
        self.mContentHeight = textHeight
    else
        Debug:log_error("ChatItem", string.format("未实现的消息类型:%s", contentType))
    end

    local bgWidth, bgHeight = self:__getBgSize()
    gs.TransQuick:SizeDelta(self.mRectRightBg, bgWidth, bgHeight)

    self.mHeight = math.max(bgHeight + 2 * 30, 120)
    gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), self.mHeight)
end

-- 获取气泡背景宽高
function __getBgSize(self, type)
    local contentType = type or self.mChatVo.contentType
    if (contentType == chat.ContentType.JUST_TEXT) then
        local left = 15 -- 文本左边x坐标距离气泡背景图左边距离
        local right = 30 -- 文本右边x坐标距离气泡背景图右边距离
        local bgWidth = left + self.mContentWidth + right
        local bgHeight = self.mContentHeight + 2 * self:__getBgPadTopBottom()
        if (bgWidth >= 430) then
            bgWidth = 430
        end
        return bgWidth, bgHeight
    elseif (contentType == chat.ContentType.STATIC_EMOJI or contentType == chat.ContentType.DYNAMIC_EMOJI) then
        return 188, 165
    elseif (contentType == chat.ContentType.VOICE_TEXT) then
        local bgWidth, bgHeight = self:__getBgSize(chat.ContentType.JUST_TEXT)
        local imgVoiceHeight = bgHeight
        bgHeight = bgHeight + imgVoiceHeight
        return math.max(214, bgWidth), bgHeight
    else
        return 0, 0
    end
end

function onClickVoiceHandler(self, btn)
    GameDispatcher:dispatchEvent(EventName.REQ_CHAT_SPEECH_DOWNLOAD, {content = self.mChatVo.content})
end

function __onClickHeadGridHandler(self, args)
    local chatVo = args
    local roleVo = role.RoleManager:getRoleVo()
    if (chatVo.sendId ~= "0" and roleVo.playerId ~= chatVo.sendId) then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, {id = chatVo.sendId})
    end
    -- gs.Message.Show(chatVo:getSendName())
end

function getHeight(self)
    if (not self.mHeight) then
        self.mHeight = 2 * self:__getBgPadTopBottom() + self.mContentHeight
    end
    return self.mHeight
end

function __getBgPadTopBottom(self)
    return 17
end

function setPosY(self, y)
    if (self.mPosY ~= y) then
        self.mPosY = y
        gs.TransQuick:UIPosY(self.UITrans, y)
    end
end

function getPosY(self)
    return self.mPosY
end

function getData(self)
    return self.mChatVo
end

function getSn(self)
    if (self.mChatVo) then
        return self.mChatVo:getSn()
    else
        return 0
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
