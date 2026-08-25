local CompFixedItemDetailTipsItem, Super = NewViewComponent("CompFixedItemDetailTipsItem", UICompItemDetailTipsItemBase)

function CompFixedItemDetailTipsItem:ctor(uiNode, view)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Bag_Item_Detail_OptimizedResource(uiNode)
  self.trinketSuitdesc = UI_Awaker_Item_Trinket_SuitdescResource(self.ui.UI_Awaker_Item_Trinket_Suitdesc)
end

function CompFixedItemDetailTipsItem:_GetItemData()
  if not self.itemUid or 0 == self.itemUid then
    return nil
  end
  do return ItemDataUtils.GetItemByUid end
  return ItemDataUtils.GetItemByUid, self.itemUid
end

function CompFixedItemDetailTipsItem:OnEnterComponent()
end

function CompFixedItemDetailTipsItem:SetItemUid(uid)
  if self.itemUid ~= uid then
    self.itemUid = uid
    self:Refresh()
    self:_ResetScrollPosition()
  end
end

function CompFixedItemDetailTipsItem:RefreshLayout()
  local contentUI = self.ui.Group_Prop.transform.parent.gameObject
  if self.refreshLayoutImmediate then
    CS.Framework.UIUtilTool.RefreshLayoutImmediate(contentUI)
    return
  end
end

return CompFixedItemDetailTipsItem
