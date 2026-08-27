local UISkinVoiceISelectItem = class("UISkinVoiceISelectItem", UIBaseNode)
local base = UIBaseNode

function UISkinVoiceISelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickSeleteSkinVoice)
end

function UISkinVoiceISelectItem:InitVoiceSelectItem(skinName, skinId, index, selectEvent)
  self.skinId = skinId
  self.index = index
  self.ui.text.text = skinName
  self.selectEvent = selectEvent
end

function UISkinVoiceISelectItem:OnClickSeleteSkinVoice()
  if self.selectEvent ~= nil then
    self.selectEvent(self.skinId, self.index)
  end
end

return UISkinVoiceISelectItem
