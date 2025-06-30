module('chat.ChatItemNew', Class.impl('lib.component.BaseContainer'))

UIRes = UrlManager:getUIPrefabPath("chat/ChatItemNew.prefab")

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

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    if self.UIObject then
        gs.GOPoolMgr:Recover(self.UIObject, self.UIRes)
    end

    self:removeAllTimer()
    self:clearAllTimeout()

    if self.m_chatHeadGrid then
        self.m_chatHeadGrid:poolRecover()
        self.m_chatHeadGrid = nil
    end

    self.UIObject = nil
    self.UITrans = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    self:__deActive()

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
    self.mImgBgLeft = self:getChildGO("ImgBgLeft"):GetComponent(ty.AutoRefImage)
    self.mRectLeftBg = self:getChildGO("ImgBgLeft"):GetComponent(ty.RectTransform)

    self.mHeadNodeLeft = self:getChildTrans("HeadNodeLeft")
    self.mTextNameLeft = self:getChildGO("TextNameLeft"):GetComponent(ty.Text)
    self.mImgTitleLeft = self:getChildGO("ImgTitleLeft"):GetComponent(ty.AutoRefImage)

    self.mGroupContentLeftText = self:getChildGO("GroupContentLeftText")
    self.mLeftContent = self:getChildGO("TextLeftContent"):GetComponent(ty.Text)
    self.mLeftContentRect = self:getChildGO("TextLeftContent"):GetComponent(ty.RectTransform)

    self.mGroupContentLeftEmoji = self:getChildGO("GroupContentLeftEmoji")
    self.mImgEmojiLeft = self:getChildGO("ImgEmojiLeft"):GetComponent(ty.AutoRefImage)
    self.mFrameEmojiLeft = self:getChildGO("ImgEmojiLeft"):GetComponent(ty.ImageFrame)

    -- 自己
    self.mGroupRight = self:getChildGO("GroupRight")
    self.mImgBgRight = self:getChildGO("ImgBgRight"):GetComponent(ty.AutoRefImage)
    self.mRectRightBg = self:getChildGO("ImgBgRight"):GetComponent(ty.RectTransform)

    self.mHeadNodeRight = self:getChildTrans("HeadNodeRight")
    self.mTextNameRight = self:getChildGO("TextNameRight"):GetComponent(ty.Text)
    self.mImgTitleRight = self:getChildGO("ImgTitleRight"):GetComponent(ty.AutoRefImage)

    self.mGroupContentRightText = self:getChildGO("GroupContentRightText")
    self.mRightContent = self:getChildGO("TextRightContent"):GetComponent(ty.Text)
    self.mRightContentRect = self:getChildGO("TextRightContent"):GetComponent(ty.RectTransform)

    self.mGroupContentRightEmoji = self:getChildGO("GroupContentRightEmoji")
    self.mImgEmojiRight = self:getChildGO("ImgEmojiRight"):GetComponent(ty.AutoRefImage)
    self.mFrameEmojiRight = self:getChildGO("ImgEmojiRight"):GetComponent(ty.ImageFrame)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function setData(self, chatVo)
    self.mChatVo = chatVo
    self:__updateView()
end

function __updateView(self)
    local isOwn = self.mChatVo:isOwn()
    if (isOwn) then
        self.mGroupLeft:SetActive(false)
        self.mGroupRight:SetActive(true)
        if (self.mChatVo.contentType == chat.ContentType.JUST_TEXT) then
            self.mGroupContentRightText:SetActive(true)
            self.mGroupContentRightEmoji:SetActive(false)
        else
            self.mGroupContentRightText:SetActive(false)
            self.mGroupContentRightEmoji:SetActive(true)
        end
        self:__updateRightInfo()
    else
        self.mGroupLeft:SetActive(true)
        self.mGroupRight:SetActive(false)
        if (self.mChatVo.contentType == chat.ContentType.JUST_TEXT) then
            self.mGroupContentLeftText:SetActive(true)
            self.mGroupContentLeftEmoji:SetActive(false)
        else
            self.mGroupContentLeftText:SetActive(false)
            self.mGroupContentLeftEmoji:SetActive(true)
        end
        self:__updateLeftInfo()
    end
end

function __updateLeftInfo(self)
    self.mTextNameLeft.text = self.mChatVo:getSendName()
    local titleDataRo = decorate.DecorateManager:getPlayerTitleConfigVo(self.mChatVo:getSendTitle())
    if (titleDataRo) then
        self.mImgTitleLeft.gameObject:SetActive(true)
        self.mImgTitleLeft:SetImg(UrlManager:getPlayerTitleUrl(titleDataRo:getIcon()), false)
    else
        self.mImgTitleLeft.gameObject:SetActive(false)
    end

    if (not self.m_chatHeadGrid) then
        self.m_chatHeadGrid = chat.ChatHeadGrid:poolGet()
    end
    self.m_chatHeadGrid:setData(self.mChatVo)
    self.m_chatHeadGrid:setParent(self.mHeadNodeLeft)
    self.m_chatHeadGrid:setScale(1)
    self.m_chatHeadGrid:setClickEnable(true)
    self.m_chatHeadGrid:setCallBack(self, self.__onClickHeadGridHandler)

    if (self.mChatVo.contentType == chat.ContentType.JUST_TEXT) then
        local content = self.mChatVo.content
        self.mLeftContent.text = content
        self.mRightContent.text = ""
        local textWidth = math.min(self.mLeftContent.preferredWidth or gs.LayoutUtility.GetPreferredSize(self.mLeftContentRect, 0), 385)
        gs.TransQuick:SizeDelta01(self.mLeftContentRect, textWidth)
        local textHeight = self.mLeftContent.preferredHeight or gs.LayoutUtility.GetPreferredSize(self.mLeftContentRect, 1)
        gs.TransQuick:SizeDelta02(self.mLeftContentRect, textHeight)
        self.mContentWidth = textWidth
        self.mContentHeight = textHeight
    else
        if (self.mChatVo.contentType == chat.ContentType.STATIC_EMOJI) then
            self.mFrameEmojiLeft.enabled = false
            -- 先清理下服用到的之前的帧相关
            self.mImgEmojiLeft:SetImg(nil, true)
            self.mImgEmojiLeft:SetImg(chat.getEmojiUrl(self.mChatVo.contentType, self.mChatVo.content), true)
        elseif (self.mChatVo.contentType == chat.ContentType.DYNAMIC_EMOJI) then
            self.mFrameEmojiLeft.enabled = true
            self.mFrameEmojiLeft:SetSpriteList(unpack(chat.getEmojiUrl(self.mChatVo.contentType, self.mChatVo.content)))
        end
        self.mContentWidth = 128
        self.mContentHeight = 128
    end

    local bgWidth, bgHeight = self:__getBgSize()
    gs.TransQuick:SizeDelta(self.mRectLeftBg, bgWidth, bgHeight)

    self.mHeight = math.max(bgHeight + 2 * 30, 120)
    gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), self.mHeight)
end

function __updateRightInfo(self)
    self.mTextNameRight.text = self.mChatVo:getSendName()
    local titleDataRo = decorate.DecorateManager:getPlayerTitleConfigVo(self.mChatVo:getSendTitle())
    if (titleDataRo) then
        self.mImgTitleRight.gameObject:SetActive(true)
        self.mImgTitleRight:SetImg(UrlManager:getPlayerTitleUrl(titleDataRo:getIcon()), false)
    else
        self.mImgTitleRight.gameObject:SetActive(false)
    end

    if (not self.m_chatHeadGrid) then
        self.m_chatHeadGrid = chat.ChatHeadGrid:poolGet()
    end
    self.m_chatHeadGrid:setData(self.mChatVo)
    self.m_chatHeadGrid:setParent(self.mHeadNodeRight)
    self.m_chatHeadGrid:setScale(1)
    self.m_chatHeadGrid:setClickEnable(true)
    self.m_chatHeadGrid:setCallBack(self, self.__onClickHeadGridHandler)

    if (self.mChatVo.contentType == chat.ContentType.JUST_TEXT) then
        -- local content = FilterWordUtil:filter(self.mChatVo.content)
        local content = self.mChatVo.content
        self.mLeftContent.text = ""
        self.mRightContent.text = content
        -- local realW = math.min(string.getWidth(content), 500)
        local textWidth = math.min(self.mRightContent.preferredWidth or gs.LayoutUtility.GetPreferredSize(self.mRightContentRect, 0), 385)
        gs.TransQuick:SizeDelta01(self.mRightContentRect, textWidth)
        local textHeight = self.mRightContent.preferredHeight or gs.LayoutUtility.GetPreferredSize(self.mRightContentRect, 1)
        gs.TransQuick:SizeDelta02(self.mRightContentRect, textHeight)
        self.mContentWidth = textWidth
        self.mContentHeight = textHeight
    else
        if (self.mChatVo.contentType == chat.ContentType.STATIC_EMOJI) then
            self.mFrameEmojiRight.enabled = false
            -- 先清理下服用到的之前的帧相关
            self.mImgEmojiRight:SetImg(nil, true)
            self.mImgEmojiRight:SetImg(chat.getEmojiUrl(self.mChatVo.contentType, self.mChatVo.content), true)
        elseif (self.mChatVo.contentType == chat.ContentType.DYNAMIC_EMOJI) then
            self.mFrameEmojiRight.enabled = true
            self.mFrameEmojiRight:SetSpriteList(unpack(chat.getEmojiUrl(self.mChatVo.contentType, self.mChatVo.content)))
        end
        self.mContentWidth = 128
        self.mContentHeight = 128
    end

    -- self.mImgBgRight:SetImg("", false)   -- 根据解锁气泡类型设置
    local bgWidth, bgHeight = self:__getBgSize()
    gs.TransQuick:SizeDelta(self.mRectRightBg, bgWidth, bgHeight)

    self.mHeight = math.max(bgHeight + 2 * 30, 120)
    gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), self.mHeight)
end

-- 获取气泡背景宽高
function __getBgSize(self)
    if (self.mChatVo.contentType == chat.ContentType.JUST_TEXT) then
        local left = 20                             -- 文本左边x坐标距离气泡背景图左边距离
        local right = 30                            -- 文本右边x坐标距离气泡背景图右边距离
        local bgWidth = left + self.mContentWidth + right
        local bgHeight = self.mContentHeight + 2 * self:__getBgPadTopBottom()
        if (bgWidth >= 410) then
            bgWidth = 410
        end
        return bgWidth, bgHeight
    else
        return 160, 145
    end
end

function __onClickHeadGridHandler(self, args)
    local chatVo = args
    local roleVo = role.RoleManager:getRoleVo()
    if (roleVo.playerId ~= chatVo.sendId) then
        GameDispatcher:dispatchEvent(EventName.OPEN_ROLE_INFO_TIPS_PANEL, { id = chatVo.sendId})
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
    return 10
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