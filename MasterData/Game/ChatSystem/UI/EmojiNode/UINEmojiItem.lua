local UINEmojiItem = class("UINEmojiItem", UIBaseNode)
local base = UIBaseNode
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")

function UINEmojiItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Emoji, self, self.OnClickEmoji)
end

function UINEmojiItem:InitEmojiItem(chatBoard, emojiCfg, onSendEmojiSuccCallback)
  self.chatBoard = chatBoard
  self.emojiCfg = emojiCfg
  self.onSendEmojiSuccCallback = onSendEmojiSuccCallback
  self.ui.img_Sprite.sprite = CRH:GetSprite(emojiCfg.emoticon_icon)
end

function UINEmojiItem:OnClickEmoji()
  if self.emojiCfg == nil then
    return
  end
  local chatSystemCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  chatSystemCtrl:ReqSendChatMsg(self.chatBoard:GetChatBoardType(), self.chatBoard:GetChatBoardId(), ChatSystemEnum.EChatContentType.Emoji, self.emojiCfg.id, self.onSendEmojiSuccCallback)
end

return UINEmojiItem
