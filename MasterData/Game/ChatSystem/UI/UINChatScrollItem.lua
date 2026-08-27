local UINChatScrollItem = class("UINChatScrollItem", UIBaseNode)

function UINChatScrollItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINChatScrollItem:InitChatScrollItem(chatGroupItem, isGroup, index, entryIndexOffset)
  self.isGroup = isGroup
  self.index = index
  self.entryIndexOffset = entryIndexOffset
  self:OnRecycleChatGroupItem()
  self:OnRecycleChatEntryItem()
  if isGroup then
    self:SetChatGroupItem(chatGroupItem)
  else
    self:SetChatEntryItem(chatGroupItem:GetNewChatEntryItem(index - entryIndexOffset + 1))
  end
end

function UINChatScrollItem:SetChatGroupItem(chatGroupItem)
  if chatGroupItem == nil then
    return
  end
  chatGroupItem.transform:SetParent(self.transform, false)
  self.chatGroupItem = chatGroupItem
end

function UINChatScrollItem:OnRecycleChatGroupItem()
  if self.chatGroupItem ~= nil then
    self.chatGroupItem:OnRecycleGroupItem()
    self.chatGroupItem = nil
  end
end

function UINChatScrollItem:SetChatEntryItem(chatEntryItem)
  if chatEntryItem == nil then
    return
  end
  chatEntryItem.transform:SetParent(self.transform, false)
  self.chatEntryItem = chatEntryItem
end

function UINChatScrollItem:OnRecycleChatEntryItem()
  if self.chatEntryItem ~= nil then
    self.chatEntryItem:OnRecycleEntryItem()
    self.chatEntryItem = nil
  end
end

function UINChatScrollItem:OnRecycleChatScrollItem()
  self.isGroup = nil
  self:OnRecycleChatGroupItem()
  self:OnRecycleChatEntryItem()
end

return UINChatScrollItem
