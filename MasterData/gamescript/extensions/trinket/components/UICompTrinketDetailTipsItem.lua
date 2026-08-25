local UICompTrinketDetailTipsItem, Super = NewViewComponent("UICompTrinketDetailTipsItem", UICompItemDetailTipsItemBase)

function UICompTrinketDetailTipsItem:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Item_DetailResource(uiNode)
  self.trinketSuitdesc = UI_Awaker_Item_Trinket_SuitdescResource(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
end

function UICompTrinketDetailTipsItem:_GetItemData()
  if self.itemTid and 0 ~= self.itemTid then
    do return ItemDataUtils.GetItemByTid end
    return ItemDataUtils.GetItemByTid, self.itemTid
  end
  if not self.itemUid or 0 == self.itemUid then
    return nil
  end
  do return ItemDataUtils.GetItemByUid end
  return ItemDataUtils.GetItemByUid, self.itemUid
end

function UICompTrinketDetailTipsItem:OnEnterComponent()
end

function UICompTrinketDetailTipsItem:SetItemTid(tid)
  if self.itemTid ~= tid then
    self.itemTid = tid
    self:Refresh()
    self:_ResetScrollPosition()
  end
end

function UICompTrinketDetailTipsItem:SetItemUid(uid)
  if self.itemUid ~= uid then
    self.itemUid = uid
    self:Refresh()
    self:_ResetScrollPosition()
  end
end

return UICompTrinketDetailTipsItem
