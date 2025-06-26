module('braceletsCommunicate.BraceletsCommunicateItem', Class.impl('lib.component.BaseContainer'))

UIRes = UrlManager:getUIPrefabPath("braceletsCommunicate/BraceletsCommunicateItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mBtnList = {}
    self.mIsClick = false
    self.mContentHeight = 22
end

function create(self, parent, cusVo, heroList, segId, nowTargetId)
    local item = self:poolGet()
    item:initData()
    item:setParentTrans(parent)
    item:setData(cusVo, heroList, segId, nowTargetId)
    return item
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), 120)
    if self.UIObject then
        gs.GOPoolMgr:Recover(self.UIObject, self.UIRes)
    end

    self:removeAllTimer()
    self:clearAllTimeout()

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

    self.mImgHeadLeft = self:getChildTrans("mImgHeadLeft"):GetComponent(ty.AutoRefImage)
    self.mTextNameLeft = self:getChildGO("TextNameLeft"):GetComponent(ty.Text)
    self.mImgTitleLeft = self:getChildGO("ImgTitleLeft"):GetComponent(ty.AutoRefImage)

    self.mGroupContentLeftText = self:getChildGO("GroupContentLeftText")
    self.mLeftContent = self:getChildGO("TextLeftContent"):GetComponent(ty.Text)
    self.mLeftContentRect = self:getChildGO("TextLeftContent"):GetComponent(ty.RectTransform)

    self.mGroupContentLeftEmoji = self:getChildGO("GroupContentLeftEmoji")
    self.mImgEmojiLeft = self:getChildGO("ImgEmojiLeft"):GetComponent(ty.AutoRefImage)
    -- self.mImgHasRec = self:getChildGO("mImgHasRec")
    self.mFrameEmojiLeft = self:getChildGO("ImgEmojiLeft"):GetComponent(ty.ImageFrame)
    self.mInputting = self:getChildGO("mInputting")

    -- 自己
    self.mGroupRight = self:getChildGO("GroupRight")
    self.ImgBgRight = self:getChildGO("ImgBgRight")
    self.mImgBgRight = self:getChildGO("ImgBgRight"):GetComponent(ty.AutoRefImage)
    self.mRectRightBg = self:getChildGO("ImgBgRight"):GetComponent(ty.RectTransform)

    self.mGroupContentRightText = self:getChildGO("GroupContentRightText")
    self.mRightContent = self:getChildGO("TextRightContent"):GetComponent(ty.Text)
    self.mRightContentRect = self:getChildGO("TextRightContent"):GetComponent(ty.RectTransform)

    self.mGroupContentRightEmoji = self:getChildGO("GroupContentRightEmoji")
    self.mImgEmojiRight = self:getChildGO("ImgEmojiRight"):GetComponent(ty.AutoRefImage)
    self.mFrameEmojiRight = self:getChildGO("ImgEmojiRight"):GetComponent(ty.ImageFrame)
    -- self.mChooseContent = self:getChildGO("mChooseContent")
    self.mGroupHorizontalLine = self:getChildGO("mGroupHorizontalLine")

    self.mTxtServer = self:getChildGO("mTxtServer"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
end

function deActive(self)
    self.mGroupContentRightEmoji:SetActive(false)
    super.deActive(self)
end

function setData(self, chatVo, heroList, nowTargetId, segId)
    self.mChatVo = chatVo
    self.mHeroList = heroList
    self.mNowTargetId = nowTargetId
    self.mSegId = segId
    self.mTextNameLeft.gameObject:SetActive(true)
    self.mLeftContent.gameObject:SetActive(true)
    self.mInputting:SetActive(false)
    self:__updateView()
end

function __updateView(self)
    if self.mChatVo then
        self.mGroupLeft:SetActive(true)
        self.mGroupRight:SetActive(true)
        self.mGroupHorizontalLine:SetActive(false)
        local isOwn = true
        if self.mChatVo.type == 0 or self.mChatVo.type == 4 then
            isOwn = false
        end
        if (isOwn) then
            self.mGroupLeft:SetActive(false)
            self.mGroupRight:SetActive(true)
            self.mGroupContentRightText:SetActive(true)
            self.mGroupContentRightEmoji:SetActive(false)
            self:__updateRightInfo()
        else
            self.mGroupLeft:SetActive(true)
            self.mGroupRight:SetActive(false)
            if (self.mChatVo.reward == 0) then
                self.mGroupContentLeftText:SetActive(true)
                self.mGroupContentLeftEmoji:SetActive(false)
            else
                self.mGroupContentLeftText:SetActive(false)
                self.mGroupContentLeftEmoji:SetActive(true)
            end
            self:__updateLeftInfo()
        end
    else
        self.mGroupLeft:SetActive(false)
        self.mGroupRight:SetActive(false)
        self.mGroupHorizontalLine:SetActive(true)
        self.mContentWidth = 128
        self.mHeight = 75
        gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), self.mHeight)
    end
end

function __updateLeftInfo(self)
    local name = ""
    local heroTid = #self.mHeroList > 1 and self.mChatVo.talkerId[1] or self.mHeroList[1]
    local heroConfig = hero.HeroManager:getHeroConfigVo(heroTid)
    self.mImgHeadLeft:SetImg(UrlManager:getIconPath(heroConfig.head), true)
    name = heroConfig.name
    self.mTextNameLeft.text = name
    local showName = braceletsCommunicate.BraceletsCommunicateManager:getIsPrivate(self.mNowTargetId)
    self.mTextNameLeft.gameObject:SetActive(not showName)
    local newestMsgVo = braceletsCommunicate.BraceletsCommunicateManager:getCommunicateMsgVo(self.mNowTargetId)
    local newestSegId, newestTalkId, index = newestMsgVo:getNewestSegmentId()

    local infoDelay = function()
        self.mContentWidth = 128
        if (self.mChatVo.reward == 0) then

            if self.mChatVo.type == 4 then
                
                self.mGroupContentLeftEmoji:SetActive(true)
                self.mGroupContentLeftText:SetActive(false)
                self.mImgEmojiLeft:SetImg(self.mChatVo.msg)
                gs.TransQuick:SizeDelta02(self.mLeftContentRect, 180)
                self.mImgBgLeft.gameObject:SetActive(false)
            else
                local content = self.mChatVo.msg
                self.mLeftContent.text = string.substitute(content, role.RoleManager:getRoleVo():getPlayerName())
                self.mRightContent.text = ""
                local textWidth = math.min(self.mLeftContent.preferredWidth or
                                               gs.LayoutUtility.GetPreferredSize(self.mLeftContentRect, 0), 385)
                gs.TransQuick:SizeDelta01(self.mLeftContentRect, textWidth)
                local textHeight = self.mLeftContent.preferredHeight or
                                       gs.LayoutUtility.GetPreferredSize(self.mLeftContentRect, 1)
                gs.TransQuick:SizeDelta02(self.mLeftContentRect, textHeight)
                self.mContentWidth = textWidth
                self.mContentHeight = textHeight
                self.mLeftContent.gameObject:SetActive(true)
                self.mImgBgLeft.gameObject:SetActive(true)
            end

        else
            self.mImgEmojiLeft:SetImg(nil, true)
            if newestTalkId ~= self.mChatVo.talkId then
                self.mImgEmojiLeft:SetImg(UrlManager:getPackPath("braceletsCommunication/chat_icon_06.png"))
            else
                if index == 1 then
                    self.mImgEmojiLeft:SetImg(UrlManager:getPackPath("braceletsCommunication/chat_icon_05.png"))
                else
                    self.mImgEmojiLeft:SetImg(UrlManager:getPackPath("braceletsCommunication/chat_icon_06.png"))
                end
            end
            -- self.mImgHasRec:SetActive(newestTalkId == self.mChatVo.talkId)
            self.mContentWidth = 128
            self.mContentHeight = 128
        end
        local bgWidth, bgHeight = self:__getBgSize()
        gs.TransQuick:SizeDelta(self.mRectLeftBg, bgWidth, bgHeight)

        self.mHeight = math.max(bgHeight + 2 * 30, 120)
        if self.mChatVo.type == 4 then
            self.mHeight = 180
        end
        gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), self.mHeight)
        self.mTextNameLeft.gameObject:SetActive(true)
        self.mInputting:SetActive(false)
    end
    if self.mSegId == newestSegId and newestTalkId == self.mChatVo.talkId and (index == 1) and self.mChatVo.reward == 0 and
        (index ~= #newestMsgVo:getTalkList(newestSegId)) and
        not braceletsCommunicate.BraceletsCommunicateManager:getNewestHasRead(self.mNowTargetId) then
        self.mTextNameLeft.gameObject:SetActive(false)
        self.mLeftContent.gameObject:SetActive(false)
        self.mImgBgLeft.gameObject:SetActive(false)
        self.mGroupContentLeftEmoji:SetActive(false)
        self.mInputting:SetActive(true)
        self.mContentWidth = 128
        self.mContentHeight = 22
        local bgWidth, bgHeight = self:__getBgSize()
        gs.TransQuick:SizeDelta(self.mRectLeftBg, bgWidth, bgHeight)

        self.mHeight = math.max(bgHeight + 2 * 30, 120)
        gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), self.mHeight)
    else
        infoDelay()
    end
end

function __updateRightInfo(self)
    if self.mChatVo.type == 2 or self.mChatVo.type == 3 then
        self.mGroupRight:SetActive(false)
        self.mHeight = 1
        gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), self.mHeight)
        -- self.mContentHeight = 0
    else
        self.mContentWidth = 128
        self.mGroupRight:SetActive(true)
        self.ImgBgRight:SetActive(true)
        local content = self.mChatVo.msg
        self.mTxtServer.gameObject:SetActive(false)
        if self.mChatVo.type == 5 then
            self.mGroupContentRightEmoji:SetActive(true)
            self.mGroupContentRightText.gameObject:SetActive(false)
            self.ImgBgRight:SetActive(false)
            self.mImgEmojiRight:SetImg(self.mChatVo.msg)
            gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), 150)
        elseif self.mChatVo.type == 6 then
            self.mTxtServer.text = self.mChatVo.msg
            self.mTxtServer.gameObject:SetActive(true)
            self.ImgBgRight:SetActive(false)
            self.mGroupContentRightEmoji:SetActive(false)
            self.mGroupContentRightText.gameObject:SetActive(false)
            gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), 40)
        else
            self.mLeftContent.text = ""
            self.mRightContent.text = content
            local textWidth = math.min(self.mRightContent.preferredWidth or
                                           gs.LayoutUtility.GetPreferredSize(self.mRightContentRect, 0), 385)
            gs.TransQuick:SizeDelta01(self.mRightContentRect, textWidth)
            local textHeight = self.mRightContent.preferredHeight or
                                   gs.LayoutUtility.GetPreferredSize(self.mRightContentRect, 1)
            gs.TransQuick:SizeDelta02(self.mRightContentRect, textHeight)
            self.mContentWidth = textWidth
            self.mContentHeight = textHeight
            local bgWidth, bgHeight = self:__getBgSize()
            gs.TransQuick:SizeDelta(self.mRectRightBg, bgWidth, bgHeight)

            self.mHeight = math.max(bgHeight + 30, 72)
            gs.TransQuick:SizeDelta02(self.UIObject.gameObject:GetComponent(ty.RectTransform), self.mHeight)
        end
    end
end

-- 获取气泡背景宽高
function __getBgSize(self)
    local left = 0 -- 文本左边x坐标距离气泡背景图左边距离
    local right = 30 -- 文本右边x坐标距离气泡背景图右边距离
    local bgWidth = left + self.mContentWidth + right
    local bgHeight = self.mContentHeight + 2 * self:__getBgPadTopBottom()
    if (bgWidth >= 410) then
        bgWidth = 410
    end
    return bgWidth, bgHeight
end

function getHeight(self)
    if (not self.mHeight) then
        self.mHeight = 2 * self:__getBgPadTopBottom() + self.mContentHeight
    end
    return self.mHeight
end

function setPosY(self, y)
    if (self.mPosY ~= y) then
        self.mPosY = y
    end
end

function getPosY(self)
    return self.mPosY and self.mPosY or 0
end

function __getBgPadTopBottom(self)
    return 15
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
