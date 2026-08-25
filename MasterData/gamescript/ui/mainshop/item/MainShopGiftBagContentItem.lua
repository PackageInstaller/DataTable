local MainShopGiftBagContentItem, Super = System.NewComponent("MainShopGiftBagContentItem")

function MainShopGiftBagContentItem:ctor(uiNode, itemData)
  Super.ctor(self)
  self.ui = UI_Recharge_Goods_ItemResource(uiNode)
  self.itemData = itemData
  self.itemTid = itemData.itemTid
  self.itemCount = itemData.itemCount
  self.bgType = itemData.bgType
  self.desc = itemData.desc
end

function MainShopGiftBagContentItem:OnBind(binder)
  local itemCfg = DT.Item[self.itemTid]
  binder:SetText(self.ui.Text_Name, LT.Text(itemCfg.Name))
  binder:SetText(self.ui.Text_Quantity, ItemNumUtils.GetStr(self.itemCount))
  local gameObject = self.ui.UI_Common_Item_WuPin_Type2
  binder:BindComponent(CommonIconItemType2(gameObject, self.itemData))
  binder:BindToText(self.ui.Text_Immediately, function()
    return self.desc
  end)
  binder:BindToText(self.ui.Text_Daily, function()
    return self.desc
  end)
  binder:BindToVisible(self.ui.Image_Immediately, function()
    return self.bgType == CommonDefine.MainShopContentItemDescBgType.Blue
  end)
  binder:BindToVisible(self.ui.Image_Daily, function()
    return self.bgType == CommonDefine.MainShopContentItemDescBgType.Yellow
  end)
end

return MainShopGiftBagContentItem
