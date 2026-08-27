local UINChatItem = class("UINChatItem", UIBaseNode)
local base = UIBaseNode

function UINChatItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.chatItem = nil
  self.chatMsg = nil
  self.indexInList = nil
end

function UINChatItem:InitChatItem(myPool, friendPool, resloader, onClickChatEntryImageCallback)
  self.myPool = myPool
  self.friendPool = friendPool
  self.resloader = resloader
  self.onClickChatEntryImageCallback = onClickChatEntryImageCallback
end

function UINChatItem:RefreshChatItem(chatMsg, index, prefChatMsg)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  self:OnRecycleChatItem()
  self.chatMsg = chatMsg
  self.indexInList = index
  if userChatData:IsChatMsgSendBySelf(chatMsg) then
    self.chatItem = self.myPool:GetOne()
  else
    self.chatItem = self.friendPool:GetOne()
  end
  self.chatItem.transform:SetParent(self.transform, false)
  self.chatItem:SetChatMsg(chatMsg, self.resloader)
  self.chatItem:SetSenderHeadClickCallback(self.onClickChatEntryImageCallback)
  if prefChatMsg == nil or chatMsg.sendTime - prefChatMsg.sendTime > 600000 then
    self.ui.obj_Time:SetActive(true)
    local selfTimeTable = TimeUtil:TimestampToDate(chatMsg.sendTime, true, true)
    local currentTimeTable = TimeUtil:TimestampToDate(math.floor(PlayerDataCenter.timestamp), false, true)
    if selfTimeTable.year ~= currentTimeTable.year then
      self.ui.tex_Time.text = TimeUtil:TimestampToDateString(chatMsg.sendTime, true, true, ConfigData:GetTipContent(6112))
    else
      self.ui.tex_Time.text = TimeUtil:TimestampToDateString(chatMsg.sendTime, true, true, ConfigData:GetTipContent(6113))
    end
  else
    self.ui.obj_Time:SetActive(false)
  end
end

function UINChatItem:OnRecycleChatItem()
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  if self.chatItem ~= nil then
    if userChatData:IsChatMsgSendBySelf(self.chatMsg) then
      self.myPool:HideOne(self.chatItem)
    else
      self.friendPool:HideOne(self.chatItem)
    end
    self.chatItem = nil
  end
end

function UINChatItem:OnDelete()
  base.OnDelete(self)
end

return UINChatItem
