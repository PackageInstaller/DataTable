local UINChatElementOtherItem = class("UINChatElementOtherItem", UIBaseNode)
local base = UIBaseNode

function UINChatElementOtherItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINChatElementOtherItem:SetChatData(chatData)
  local isSinglePic = chatData:GetIsSinglePicture()
  self.ui.tex_Chat.gameObject:SetActive(not isSinglePic)
  self.ui.img_Pic.gameObject:SetActive(isSinglePic)
  if isSinglePic then
  else
    self.ui.tex_Chat.text = chatData:GetContent()
  end
end

function UINChatElementOtherItem:OnDelete()
  base.OnDelete(self)
end

return UINChatElementOtherItem
