local CopySpecialShopEnchantItem, Super = NewViewComponent("CopySpecialShopEnchantItem", CopySpecialShopBaseItem)

function CopySpecialShopEnchantItem:_RefreshGoodsInfo()
  local tid = self.goodsData.tid
  local cfg = DT.EnchantConfig[tid]
  local enchantTypeMap = CommonDefine.GetEnchantTypeNameMap()
  self:SetImage(self.ui.Image_Icon, cfg.Icon)
  self:SetText(self.ui.Text_State, LT.Text(enchantTypeMap[cfg.Quality]))
  self:SetText(self.ui.Text_Title, LT.Text(cfg.Name))
end

function CopySpecialShopEnchantItem:_OnBtnBuy()
  WorldStageShopUtils.OnClickEnchantGoods(self.goodsData.uid)
end

return CopySpecialShopEnchantItem
