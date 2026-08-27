local UINActivityCollectFortuneFriendGiftItem = class("UINActivityCollectFortuneFriendGiftItem", UIBaseNode)
local base = UIBaseNode

function UINActivityCollectFortuneFriendGiftItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if self.ui.Btn_GiftItem then
    UIUtil.AddButtonListener(self.ui.Btn_GiftItem, self, self.OnClickBtnGiftItem)
  end
end

function UINActivityCollectFortuneFriendGiftItem:InitActCollectFortuneFriendGiftItem(data)
  self._index = data.index
  self._itemId = data.itemId
  self._count = data.count
  self.ui.Img_Pic:SetIndex(self._index - 1)
  self.ui.Tex_FriendOwnNum.text = tostring(self._count)
end

function UINActivityCollectFortuneFriendGiftItem:OnClickBtnGiftItem()
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  window:InitCommonItemDetail(ConfigData.item[self._itemId])
end

function UINActivityCollectFortuneFriendGiftItem:OnDelete()
  base.OnDelete(self)
end

return UINActivityCollectFortuneFriendGiftItem
