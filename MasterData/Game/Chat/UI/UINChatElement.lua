local UINChatElement = class("UINChatElement", UIBaseNode)
local base = UIBaseNode
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UINChatElement:OnInit()
  self.chatItem = nil
  self.chatData = nil
  self.indexInList = nil
end

function UINChatElement:InitChatElement(myPool, otherPool)
  self.myPool = myPool
  self.otherPool = otherPool
end

function UINChatElement:RefreshChatItem(chatData, index)
  self:OnRecycle()
  self.chatData = chatData
  self.indexInList = index
  if chatData.isSelf then
    self.chatItem = self.myPool:GetOne()
  else
    self.chatItem = self.otherPool:GetOne()
  end
  self.chatItem.transform:SetParent(self.transform, false)
  self.chatItem:SetChatData(chatData)
end

function UINChatElement:OnRecycle()
  if self.chatItem ~= nil then
    if self.chatData.isSelf then
      self.myPool:HideOne(self.chatItem)
    else
      self.otherPool:HideOne(self.chatItem)
    end
    self.chatItem = nil
  end
end

function UINChatElement:OnDelete()
  base.OnDelete(self)
end

return UINChatElement
