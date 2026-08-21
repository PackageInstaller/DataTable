--[[
-----------------------------------------------------
@filename       : PrivateChatTalkItem
@Description    : 私聊对话列表
@date           : 2020-08-07 11:00:18
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.friend.view.item.PrivateChatTalkItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("friend/PrivateChatTalkItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)

end

function configUI(self)
    self.mLeftGroup = self:getChildGO("mLeftGroup")
    self.mLeftHead = self:getChildTrans("mLeftHead")
    -- self.mLeftTalkGroup = self:getChildTrans("mLeftTalkGroup")
    self.mLeftName = self:getChildGO("mLeftName"):GetComponent(ty.Text)
    self.mLeftTitle = self:getChildGO("mLeftTitle"):GetComponent(ty.AutoRefImage)
    self.mLeftContent = self:getChildGO("mLeftContent"):GetComponent(ty.RichText)
    self.mLeftContent:SetForceEmojiSize(RichTextUtil.m_defaultEmojiSize)
    RichTextUtil:registerCallBack(self.mLeftContent)

    self.mImgEmojiLeft = self:getChildGO("mImgEmojiLeft"):GetComponent(ty.AutoRefImage)
    self.mFrameEmojiLeft = self:getChildGO("mImgEmojiLeft"):GetComponent(ty.ImageFrame)

    self.mRightGroup = self:getChildGO("mRightGroup")
    self.mRightHead = self:getChildTrans("mRightHead")
    -- self.mRightTalkGroup = self:getChildTrans("mRightTalkGroup")
    self.mRightName = self:getChildGO("mRightName"):GetComponent(ty.Text)
    self.mRightTitle = self:getChildGO("mRightTitle"):GetComponent(ty.AutoRefImage)
    self.mRightContent = self:getChildGO("mRightContent"):GetComponent(ty.RichText)
    self.mRightContent:SetForceEmojiSize(RichTextUtil.m_defaultEmojiSize)
    RichTextUtil:registerCallBack(self.mRightContent)

    self.mImgEmojiRight = self:getChildGO("mImgEmojiRight"):GetComponent(ty.AutoRefImage)
    self.mFrameEmojiRight = self:getChildGO("mImgEmojiRight"):GetComponent(ty.ImageFrame)

    self.mImgBgLeft = self:getChildTrans("mImgBgLeft")
    self.mImgBgRight = self:getChildTrans("mImgBgRight")

    self.mGiftGroup = self:getChildGO("mGiftGroup")
    self.mBtnSendGfit = self:getChildGO("mBtnSendGfit")
    self.mTxtGift = self:getChildGO("mTxtGift"):GetComponent(ty.Text)

    self.mTimeGroup = self:getChildGO("mTimeGroup")
    self.mTxtTime = self:getChildGO("mTxtTime"):GetComponent(ty.Text)

end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
    if self.mPlayerHeadGrid then
        self.mPlayerHeadGrid:poolRecover()
        self.mPlayerHeadGrid = nil
    end
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSendGfit, self.onHrefEventCallHandler)
end

function setData(self, cusParent, privateChatVo, mPreVo)
    self:setParentTrans(cusParent)
    self.mChatVo = privateChatVo
    self.mPreVo = mPreVo

    self:updateData()
end

function updateData(self)
    self.mFriendVo = friend.FriendManager:getFriendVo(self.mChatVo.friendId)
    if self.mFriendVo == nil then return end

    local avatarId = 0
    local lvl = 0

    self.mBtnSendGfit:SetActive(false)
    if self.mChatVo.tid > 0 then
        local propsConfigVo = props.PropsManager:getPropsConfigVo(self.mChatVo.tid)
        local langId = ""
        if self.mChatVo.state == 1 then

            self.mChatVo.content = RichTextUtil:customImage(UrlManager:getIconPath(propsConfigVo.icon), 90, 90, "props")
            if self.mChatVo.sender == 1 then
                langId = 25129--"你给{0}送了{1}"
                self:myChatInfo()
            else
                langId = 25130--"%s送给了你%s"
                self:friendChatInfo()
                self.mBtnSendGfit:SetActive(true)
            end
        else
            -- langId = self.mChatVo.sender == 1 and "领取了%s给你的%s" or "%s领取了你送的%s"
            langId = self.mChatVo.sender == 1 and 25131 or 25132
            self.mLeftGroup:SetActive(false)
            self.mRightGroup:SetActive(false)
        end

        -- 赠送礼物
        self.mGiftGroup:SetActive(true)

        self.mTxtGift.text = _TT(langId, self.mFriendVo.name, propsConfigVo:getName())

    else
        if self.mChatVo.sender == 1 then
            -- 自己发言
            self:myChatInfo()
        else
            -- 好友的发言
            self:friendChatInfo()
        end
    end

    -- 时间
    self.mTimeGroup:SetActive(false)
    if self.mPreVo then
        local pt = os.date('*t', self.mPreVo.time)
        local nt = os.date('*t', self.mChatVo.time)
        if (nt.day - pt.day > 1) or (self.mChatVo.time - self.mPreVo.time > 5 * 60) then
            self.mTimeGroup:SetActive(true)
            self.mTxtTime.text = "---" .. TimeUtil.getChatTime(self.mChatVo.time) .. "---"
        end
    end
end

function onHrefEventCallHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_FRIEND_GIFT_SEND, self.mFriendVo.id)
end

-- 我方发言
function myChatInfo(self)
    self.mLeftGroup:SetActive(false)
    self.mRightGroup:SetActive(true)
    self.mGiftGroup:SetActive(false)
    self.mHeadGroup = self.mRightHead
    self.mTxtTalk = self.mRightContent
    -- self.mTalkGroup = self.mRightTalkGroup
    self.mImgTitle = self.mRightTitle
    self.mImgEmoji = self.mImgEmojiRight
    self.mFrameEmoji = self.mFrameEmojiRight

    local roleVo = role.RoleManager:getRoleVo()

    self.mRightName.text = roleVo:getPlayerName()

    self:setPlayerHead(roleVo:getAvatarId(), roleVo:getAvatarFrameId(), roleVo:getPlayerLvl())
    self:updateTitle(roleVo:getTitleId())
    self:setContent()
end
-- 好友发言
function friendChatInfo(self, content)
    self.mLeftGroup:SetActive(true)
    self.mRightGroup:SetActive(false)
    self.mGiftGroup:SetActive(false)
    self.mHeadGroup = self.mLeftHead
    self.mTxtTalk = self.mLeftContent
    -- self.mTalkGroup = self.mLeftTalkGroup
    self.mImgTitle = self.mLeftTitle
    self.mImgEmoji = self.mImgEmojiLeft
    self.mFrameEmoji = self.mFrameEmojiLeft

    self.mLeftName.text = self.mFriendVo.name

    local avatarId = self.mFriendVo.playerAvatarId
    local frameId = self.mFriendVo.frameId
    local lvl = self.mFriendVo.lvl
    self:setPlayerHead(avatarId, frameId, lvl)
    self:updateTitle(self.mFriendVo.designation)
    self:setContent()
end
-- 设置头像
function setPlayerHead(self, avatarId, frameId, lvl)
    if not self.mPlayerHeadGrid then
        self.mPlayerHeadGrid = PlayerHeadGrid:poolGet()
    else
    end
    self.mPlayerHeadGrid:setData(avatarId)
    self.mPlayerHeadGrid:setHeadFrame(frameId)
    self.mPlayerHeadGrid:setParent(self.mHeadGroup)
    self.mPlayerHeadGrid:setScale(0.7)
    self.mPlayerHeadGrid:setLvl(lvl)
    self.mPlayerHeadGrid:setClickEnable(true)
    self.mPlayerHeadGrid:setCallBack(self, self.__onClickHeadHandler)
end
-- 更新称号
function updateTitle(self, cusTitle)
    local titleDataRo = decorate.DecorateManager:getPlayerTitleConfigVo(cusTitle)
    if (titleDataRo) then
        self.mImgTitle.gameObject:SetActive(true)
        self.mImgTitle:SetImg(UrlManager:getPlayerTitleUrl(titleDataRo:getIcon()), false)
    else
        self.mImgTitle.gameObject:SetActive(false)
    end
end
-- 设置聊天内容
function setContent(self)
    local bubbleConfig = decorate.DecorateManager:getChatBubbleConfig(self.mChatVo.chatBubbleId)
    if bubbleConfig then
        -- if bubbleConfig.unlock_type == 0 then
        --     self.mImgBgLeft:SetImg("arts/ui/icon/chat5/chat_bg_00.png", false) -- 根据解锁气泡类型设置
        --     self.mImgBgRight:SetImg("arts/ui/icon/chat5/chat_bg_00.png", false) -- 根据解锁气泡类型设置
        -- else
        --     self.mImgBgLeft:SetImg(bubbleConfig:getIcon(), false) -- 根据解锁气泡类型设置
        --     self.mImgBgRight:SetImg(bubbleConfig:getIcon(), false) -- 根据解锁气泡类型设置
        -- end

        local leftChatBubbleGo = gs.GOPoolMgr:Get(bubbleConfig:getPrefabPath())
        self.mLeftChatBubbleTrans = leftChatBubbleGo.transform
        gs.TransQuick:SetParentOrg(self.mLeftChatBubbleTrans, self.mImgBgLeft)
        gs.TransQuick:UIPos(self.mLeftChatBubbleTrans:GetComponent(ty.RectTransform), 0, 0)

        local rightChatBubbleGo = gs.GOPoolMgr:Get(bubbleConfig:getPrefabPath())
        self.mRightChatBubbleTrans = rightChatBubbleGo.transform
        gs.TransQuick:SetParentOrg(self.mRightChatBubbleTrans, self.mImgBgRight)
        gs.TransQuick:UIPos(self.mRightChatBubbleTrans:GetComponent(ty.RectTransform), 0, 0)

        if (self.mChatVo.contentType == chat.ContentType.JUST_TEXT) then
            self.mImgEmoji.gameObject:SetActive(false)
            self.mTxtTalk.gameObject:SetActive(true)
            local content = self.mChatVo.content
            self.mTxtTalk.text = bubbleConfig:getColorContent(content)
            -- gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mTxtTalk.transform)

            -- local realTextW = self.mTxtTalk.preferredWidth
            -- local contentSizeFitter = self.mTalkGroup:GetComponent(ty.ContentSizeFitter)

            -- if realTextW > 400 then
            --     contentSizeFitter.horizontalFit = gs.ContentSizeFitter.FitMode.Unconstrained
            --     contentSizeFitter.verticalFit = gs.ContentSizeFitter.FitMode.PreferredSize
            -- else
            --     contentSizeFitter.horizontalFit = gs.ContentSizeFitter.FitMode.PreferredSize
            --     contentSizeFitter.verticalFit = gs.ContentSizeFitter.FitMode.Unconstrained
            -- end

        else
            self.mImgEmoji.gameObject:SetActive(true)
            self.mTxtTalk.gameObject:SetActive(false)

            if (self.mChatVo.contentType == chat.ContentType.STATIC_EMOJI) then
                self.mFrameEmoji.enabled = false
                -- 先清理下服用到的之前的帧相关
                self.mImgEmoji:SetImg(nil, true)
                self.mImgEmoji:SetImg(chat.getEmojiUrl(self.mChatVo.contentType, self.mChatVo.content), true)
            elseif (self.mChatVo.contentType == chat.ContentType.DYNAMIC_EMOJI) then
                self.mFrameEmoji.enabled = true
                self.mFrameEmoji:SetSpriteList(unpack(chat.getEmojiUrl(self.mChatVo.contentType, self.mChatVo.content)))
            end

            -- local contentSizeFitter = self.mTalkGroup:GetComponent(ty.ContentSizeFitter)
            -- contentSizeFitter.horizontalFit = gs.ContentSizeFitter.FitMode.PreferredSize
            -- contentSizeFitter.verticalFit = gs.ContentSizeFitter.FitMode.Unconstrained
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
