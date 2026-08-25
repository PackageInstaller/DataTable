local UICompBagItemDetailTipsItem, Super = NewViewComponent("UICompBagItemDetailTipsItem", UICompItemDetailTipsItemBase)

function UICompBagItemDetailTipsItem:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Bag_Item_Detail_OptimizedResource(uiNode)
  self.trinketSuitdesc = UI_Awaker_Item_Trinket_SuitdescResource(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
end

function UICompBagItemDetailTipsItem:_GetItemData()
  local curUid = BagItemDetailsModel.Instance:GetItemUid()
  if 0 == curUid then
    return
  end
  do return ItemDataUtils.GetItemByUid end
  return ItemDataUtils.GetItemByUid, curUid
end

return UICompBagItemDetailTipsItem
