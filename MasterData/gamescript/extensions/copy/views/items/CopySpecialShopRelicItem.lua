local CopySpecialShopRelicItem, Super = NewViewComponent("CopySpecialShopRelicItem", CopySpecialShopBaseItem)

function CopySpecialShopRelicItem:_RefreshGoodsInfo()
  local tid = self.goodsData.tid
  local cfg = DT.RelicConfig[tid]
  local relicTypeMap = CommonDefine.GetRelicTypeNameMap()
  self:SetImage(self.ui.Image_Icon, cfg.Icon)
  self:SetText(self.ui.Text_State, LT.Text(relicTypeMap[cfg.Quality]))
  self:SetText(self.ui.Text_Title, LT.Text(cfg.Name))
end

function CopySpecialShopRelicItem:_OnBtnBuy()
  WorldStageShopUtils.OnClickRelicGoods(self.goodsData.uid)
end

return CopySpecialShopRelicItem
