local UINChatGroupItemBase = {}
local UINChatGroupItemBase = class("UINChatGroupItemBase", UIBaseNode)
local base = UIBaseNode
local UINChatBoardEntryFriend = require("Game.ChatSystem.UI.ChatBoardEntry.UINChatBoardEntryFriend")

function UINChatGroupItemBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Page, self, self.OnClickPage)
end

function UINChatGroupItemBase:InitChatGroupItem(pageId, pageMsg, resloader, startState, onClickPageCallback, onOpenGroupItemCallback, onClickChatEntryCallback, onClickChatEntryImageCallback)
  self.pageId = pageId
  self.pageMsg = pageMsg
  self.resloader = resloader
  self.onClickPageCallback = onClickPageCallback
  self.onOpenGroupItemCallback = onOpenGroupItemCallback
  self.onClickChatEntryCallback = onClickChatEntryCallback
  self.onClickChatEntryImageCallback = onClickChatEntryImageCallback
  self.ui.tex_GroupName.text = LanguageUtil.GetLocaleText(ConfigData.new_chat_type[pageId].name)
  self._isOpen = nil
  self:ChangeChatGroupPageState(startState)
  self:RefreshGroupItemRedDot()
end

function UINChatGroupItemBase:SetRecycleCallback(callback)
  self.recycleCallback = callback
end

function UINChatGroupItemBase:GetNewChatEntryItem(index)
end

function UINChatGroupItemBase:OnRecycleGroupItem()
  if self.recycleCallback ~= nil then
    self.recycleCallback(self)
  end
end

function UINChatGroupItemBase:SetEntryItemCallback(getCallback, recycleCallback)
  self.getChatEntryItemCallback = getCallback
  self.recycleChatEntryItemCallback = recycleCallback
end

function UINChatGroupItemBase:RefreshGroupItemRedDot()
end

function UINChatGroupItemBase:GetChatEntryCount()
  return 0
end

function UINChatGroupItemBase:OnRecycleEntryItem(entryItem)
end

function UINChatGroupItemBase:GetChatGroupItemIsOpen()
  return self._isOpen
end

function UINChatGroupItemBase:ChangeChatGroupPageState(_isOpen)
  if self._isOpen == _isOpen then
    return
  end
  self._isOpen = _isOpen
  self.ui.obj_Arrow_down:SetActive(_isOpen)
  self.ui.obj_Arrow_up:SetActive(not _isOpen)
end

function UINChatGroupItemBase:OnClickPage()
  local selfIsOpen = self._isOpen
  if self.onClickPageCallback ~= nil then
    self.onClickPageCallback()
  end
  if not selfIsOpen and self.onOpenGroupItemCallback ~= nil then
    self.onOpenGroupItemCallback(self.pageId)
  end
end

return UINChatGroupItemBase
