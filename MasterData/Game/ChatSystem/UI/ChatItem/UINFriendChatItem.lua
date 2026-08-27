local UINFriendChatItem = class("UINFriendChatItem", UIBaseNode)
local base = UINFriendChatItem
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local UINUserTitle = require("Game.CommonUI.Title.UINNormalTitleItem")
local SetChatFuncs = {
  [ChatSystemEnum.EChatContentType.Emoji] = function(self, msg)
    self.ui.obj_Emoji:SetActive(true)
    local emojiCfg = ConfigData.new_chat_emoticon[msg.message.content.emojiId]
    if emojiCfg ~= nil then
      self.ui.img_Pic.sprite = CRH:GetSprite(emojiCfg.emoticon_icon)
    end
  end,
  [ChatSystemEnum.EChatContentType.Text] = function(self, msg)
    self.ui.obj_Word:SetActive(true)
    self.ui.tex_Message.text = msg.message.content.text
  end
}

function UINFriendChatItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.uINUserHead)
  self.userTitleNode = UINUserTitle.New()
  self.userTitleNode:Init(self.ui.uINAppellation)
  UIUtil.AddButtonListener(self.ui.btn_SenderHead, self, self.OnSenderHeadClick)
end

function UINFriendChatItem:SetChatMsg(chatMsg, resloader)
  self.chatMsg = chatMsg
  PlayerDataCenter:GetUserInfoByUID(chatMsg.sender.uid, function(userInfoData)
    if IsNull(self.transform) then
      return
    end
    self.ui.tex_FriendName.text = userInfoData:GetAlias()
    self.userHeadNode:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), resloader)
    self.ui.obj_AppellationHolder:SetActive(false)
    self.ui.uINAppellation:SetActive(false)
    local title = userInfoData:GetAvatarTitleId()
    if title and title.titlePrefix ~= 0 then
      self.ui.obj_AppellationHolder:SetActive(true)
      local atlasPath = PathConsts:GetSpriteAtlasPath("TitleIcon")
      resloader:LoadABAssetAsync(atlasPath, function(atlas)
        self.ui.uINAppellation:SetActive(true)
        self.userTitleNode:InitNormalTitleItem(title.titlePrefix, title.titlePostfix, title.titleBackGround, resloader, atlas)
      end)
    end
  end)
  self.ui.obj_Word:SetActive(false)
  self.ui.obj_Emoji:SetActive(false)
  if chatMsg.message.content.emojiId ~= nil then
    SetChatFuncs[ChatSystemEnum.EChatContentType.Emoji](self, chatMsg)
  else
    SetChatFuncs[ChatSystemEnum.EChatContentType.Text](self, chatMsg)
  end
end

function UINFriendChatItem:SetSenderHeadClickCallback(onClickChatEntryImageCallback)
  self.onClickChatEntryImageCallback = onClickChatEntryImageCallback
end

function UINFriendChatItem:OnSenderHeadClick()
  if self.chatMsg.sender.uid == PlayerDataCenter.inforData:GetUserUID() then
    return
  end
  if self.onClickChatEntryImageCallback ~= nil then
    self.onClickChatEntryImageCallback(self.chatMsg.sender.uid)
  end
end

return UINFriendChatItem
