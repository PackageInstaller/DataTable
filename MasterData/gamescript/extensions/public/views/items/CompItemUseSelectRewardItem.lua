local CompItemUseSelectRewardItem, Super = NewViewComponent("CompItemUseSelectRewardItem")

function CompItemUseSelectRewardItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Passport_Choose_RewardResource(uiNode)
  self._tid = data.tid
  self._num = data.num
  self._isPreview = data.isPreview
end

function CompItemUseSelectRewardItem:OnEnterComponent()
  self:SetText(self.ui.Text_Name, LT.Text(ItemDataUtils.GetItemName(self._tid)))
  self:SetSelected(self.view:IsItemSelected(self._tid))
  local groupFullText
  if ItemCfgUtils.GetCfgField("Type", self._tid) == CommonDefine.ItemType.Weapon then
    if MainShopDataUtils.IsMaxPotencyByItemId(self._tid) then
      groupFullText = LT.Text("MaxLevelWeaponShopTips")
    elseif ItemDataUtils.GetItemByTid(self._tid) then
      groupFullText = LT.Text("Owned")
    end
  end
  local iconData = {
    itemTid = self._tid,
    itemCount = self._num,
    groupFullText = groupFullText,
    clickFunc = function()
      if self.view:IsItemSelected(self._tid) then
        ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.UI_Passport_Inventory_Item, nil, self._tid, true)
      end
      self.view:SelectItem(self._tid)
    end
  }
  self:AddViewComponent(self.ui.UI_Passport_Inventory_Item, CompPublicIconItemType2, iconData)
end

function CompItemUseSelectRewardItem:OnExitComponent()
  self:RemoveViewComponentOnce(self.ui.UI_Passport_Inventory_Item, CompPublicIconItemType2)
  Super.OnExitComponent(self)
end

function CompItemUseSelectRewardItem:SetSelected(selected)
  self.ui.Image_Select:SetActive(selected)
end

return CompItemUseSelectRewardItem
