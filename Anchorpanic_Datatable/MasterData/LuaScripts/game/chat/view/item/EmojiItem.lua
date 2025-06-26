module("chat.EmojiItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    -- self.m_richText = self.m_childGos["RichText"]:GetComponent(ty.RichText)
    self.mGoEmoji = self.m_childGos["ImgEmoji"]
    self.mImgEmoji = self.mGoEmoji:GetComponent(ty.AutoRefImage)
    self.mFrameEmoji = self.mGoEmoji:GetComponent(ty.ImageFrame)
    self:addOnClick(self.mGoEmoji, self.__clickCallBack)
end

function setData(self, param)
    super.setData(self, param)

    local emojiDataRo = self.data
    local emojiIndex = emojiDataRo:getData()
    local emojiType = emojiDataRo:getType()
    if(emojiType == chat.ContentType.STATIC_EMOJI)then
        self.mFrameEmoji.enabled = false
        self.mImgEmoji:SetImg(chat.getEmojiUrl(emojiType, emojiIndex), false)
    elseif(emojiType == chat.ContentType.DYNAMIC_EMOJI)then
        self.mFrameEmoji.enabled = true
        self.mFrameEmoji:SetSpriteList(unpack(chat.getEmojiUrl(emojiType, emojiIndex)))
    end

    -- self.m_richText.text = RichTextUtil:emote(emojiIndex, RichTextUtil.m_defaultEmojiSize, "link_" .. emojiIndex)
    -- self.m_richText:SetEventCall(self, self.__clickCallBack)
end

-- function __clickCallBack(self, screenPos, localPos, hrefName)
--     local emojiIndex = string.split(hrefName, "_")[2]
--     local emojiContent = RichTextUtil:emote(emojiIndex, RichTextUtil.m_defaultEmojiSize)
--     GameDispatcher:dispatchEvent(EventName.CHAT_SELECT_EMOJI, {emojiContent = emojiContent})
-- end

function __clickCallBack(self)
    local emojiDataRo = self.data
    local emojiIndex = emojiDataRo:getData()
    local emojiType = emojiDataRo:getType()
    GameDispatcher:dispatchEvent(EventName.CHAT_SELECT_EMOJI, {emojiType = emojiType, emojiContent = emojiIndex})
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
