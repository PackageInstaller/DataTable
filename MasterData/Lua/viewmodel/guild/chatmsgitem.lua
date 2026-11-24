require("ViewModel/Common/PlayerAvatarFrameTool")

ChatMsgItem = {};

ChatMsgItem.__index = ChatMsgItem;

local objs = {
    avatarImg={path="headInfo/avatar",type="RawImage"},
    avatarFrameSprite={path="headInfo/avatarFrame",type="Image"},
    msgRect={path="msg",type="RectTransform"},
    nameText={path="msg/namebg/msgName",type="Text"},
    nameBgRect={path="msg/namebg",type="RectTransform"},
    msgText={path="msg/msgText",type="Text"},
    faceSprite={path="msg/face",type="Image"},
    animator={path="msg",type="Animator"},
    playerTitle = {path="msg/namebg/PlayerTitle",type="Image"},
    playerTitleText = {path="msg/namebg/PlayerTitle/Text",type="Text"},
    titleTextPos = {path="msg/namebg/PlayerTitle/Text",type="RectTransform"},
}

function ChatMsgItem.New()
    local self = {};
    setmetatable(self, ChatMsgItem);
    return self;
end

function ChatMsgItem:Init()
    UITool.Parse(self.gameObject, self, objs);

end

function ChatMsgItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        return
    end
    self.nameText.text = self.data.chName or ""
    self.msgText.text = self.data.msg or ""
    SetActive(self.avatarImg.gameObject,false)
    if not IsNullOrEmpty(self.data.avatarPath) then
        local tex = LuaMgr.GetTexture(self.data.avatarPath)
        if tex ~= nil then
            self.avatarImg.texture = tex
            SetActive(self.avatarImg.gameObject,true)
        end
    end
    if IsNullOrEmpty(self.data.avatarFrame) then
        PlayerAvatarFrameTool.ClearImage(self.avatarFrameSprite)
        SetActive(self.avatarFrameSprite.gameObject, false)
    else
        SetActive(self.avatarFrameSprite.gameObject, true)
        PlayerAvatarFrameTool.SetAvatarFrame(self.avatarFrameSprite, self.data.avatarFrame)
    end

    local title = ConfigHelper.GetTitleConfig(self.data.title)
    SetActive(self.playerTitle.gameObject, not TableIsNull(title))
    if not TableIsNull(title) then
        self.playerTitle.sprite = LuaMgr.GetSprite("PlayerTitle", title.img)
        self.playerTitleText.text = LuaMgr.GetLangText(title.namelan)
        if title.img == "Title_40001" then
            self.titleTextPos.anchoredPosition = Vector2(2, 1)
        else
            self.titleTextPos.anchoredPosition = Vector2(10, 1)
        end
    end

    if self.data.txtWidth - 13 < self.data.txtNameWidth then
        self.data.txtWidth = self.data.txtNameWidth + 26
    end
    self.msgRect.sizeDelta = Vector2(self.data.txtWidth, self.data.txtHeight)
    self.nameBgRect.sizeDelta = Vector2(self.data.txtNameWidth, 28)
    if string.starts(self.data.msg, "<face>&") then
        self.msgText.text = ""
        SetActive(self.faceSprite.gameObject, true)
        local faceNames = NumTool.split(self.data.msg, "&")
        self.faceSprite.sprite = LuaMgr.GetSprite("FriendChatFace", faceNames[2])
    else
        self.msgText.text = self.data.msg
        SetActive(self.faceSprite.gameObject, false)
    end
end

function ChatMsgItem:Clear()
    if self.avatarFrameSprite ~= nil then
        PlayerAvatarFrameTool.ClearImage(self.avatarFrameSprite)
    end
    self.data=nil;
end


function ChatMsgItem:Destroy()
    if self.avatarFrameSprite ~= nil then
        PlayerAvatarFrameTool.ClearImage(self.avatarFrameSprite)
    end
    self.gameObject = nil
    self.avatarImg = nil
    self.avatarFrameSprite = nil
    self.msgRect = nil
    self.nameText = nil
    self.nameBgRect = nil
    self.msgText = nil
    self.faceSprite = nil
    self.animator = nil
    self.playerTitle = nil
    self.playerTitleText = nil
    self.titleTextPos = nil

end

GuildChatMyMsgItem = ChatMsgItem
GuildChatOtherMsgItem = ChatMsgItem