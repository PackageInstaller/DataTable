local UINChatEmojiNode = class("UINChatEmojiNode", UIBaseNode)
local base = UIBaseNode
local UINEmojiPageItem = require("Game.ChatSystem.UI.EmojiNode.UINEmojiPageItem")
local UINEmojiItem = require("Game.ChatSystem.UI.EmojiNode.UINEmojiItem")

function UINChatEmojiNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.pageItemPool = UIItemPool.New(UINEmojiPageItem, self.ui.obj_PageItem, false)
  self.emojiItemPool = UIItemPool.New(UINEmojiItem, self.ui.obj_EmojiItem, false)
  self.__OnClickPageItemCallback = BindCallback(self, self.OnClickPageItem)
  self.__OnSendEmojiSuccCallback = BindCallback(self, self.OnSendEmojiSucc)
end

function UINChatEmojiNode:InitChatEmojiNode(chatBoard, resloader)
  self.currentEmojiPageId = nil
  self.chatBoard = chatBoard
  self.resloader = resloader
  self:Show()
  if self.stateChangeCallback ~= nil then
    self.stateChangeCallback(true)
  end
  self:OnClickPageItem(0)
end

function UINChatEmojiNode:RefreshChatEmojiPages()
  self.pageItemPool:HideAll()
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  for _, pageId in ipairs(userChatCtrl:GetChatSystemEmojiPageIds()) do
    if userChatCtrl:GetEmojiPage(pageId) ~= nil then
      local pageItem = self.pageItemPool:GetOne()
      local isSelecting = self.currentEmojiPageId == pageId
      pageItem:InitEmojiPageItem(pageId, self.__OnClickPageItemCallback, self.resloader, isSelecting)
    end
  end
end

function UINChatEmojiNode:HideChatEmojiNode()
  self:Hide()
  if self.stateChangeCallback ~= nil then
    self.stateChangeCallback(false)
  end
end

function UINChatEmojiNode:OnClickPageItem(pageId)
  self.currentEmojiPageId = pageId
  self:RefreshChatEmojiPages()
  self.emojiItemPool:HideAll()
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  local page = userChatCtrl:GetEmojiPage(pageId)
  if page == nil then
    return
  end
  for _, emojiId in ipairs(page) do
    local emojiCfg = userChatCtrl:GetEmojiCfg(emojiId)
    if emojiCfg ~= nil then
      local emojiItem = self.emojiItemPool:GetOne()
      emojiItem:InitEmojiItem(self.chatBoard, emojiCfg, self.__OnSendEmojiSuccCallback)
    end
  end
end

function UINChatEmojiNode:SetStateChangeCallback(stateChangeCallback)
  self.stateChangeCallback = stateChangeCallback
end

function UINChatEmojiNode:OnSendEmojiSucc()
  self:HideChatEmojiNode()
end

return UINChatEmojiNode
