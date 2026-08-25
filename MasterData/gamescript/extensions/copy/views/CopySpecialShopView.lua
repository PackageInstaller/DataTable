local notEnoughColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop3)
local MAX_GOODS_NUM = 4
local GoodsType2ClsDict = {
  [CommonDefine.WorldStageShopItemType.Relic] = CopySpecialShopRelicItem,
  [CommonDefine.WorldStageShopItemType.Enchant] = CopySpecialShopEnchantItem
}
local CopySpecialShopView, Super = NewClass("CopySpecialShopView", BaseView)
CopySpecialShopView.uiResCls = UI_Dbgcopy_Panel_ShopResource

function CopySpecialShopView:ctor(viewData)
  Super.ctor(self)
  self:InitViewData(viewData)
end

function CopySpecialShopView:OnEnterView()
  Super.OnEnterView(self)
  self:RefreshView()
end

function CopySpecialShopView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_RelicStrengthen, System.fn(self, self._OnClickRelicStrengthen))
  self:AddButtonClickListener(self.ui.Btn_Blackseal, System.fn(self, self._OnClickCustomSlot))
  self:AddButtonClickListener(self.ui.Btn_Flushed, System.fn(self, self._OnClickBtnFlushed))
  self:BindEvent(EventMgr.Instance.OnDMoneyGoldChange, System.fn(self, self._OnDMoneyGoldChange))
  self:BindEvent(EventMgr.Instance.OnWorldStageShopPurchased, System.fn(self, self._OnShopPurchased))
  self:BindEvent(EventMgr.Instance.OnSpecialShopGoodsRefresh, System.fn(self, self.RefreshView))
end

function CopySpecialShopView:_OnDMoneyGoldChange()
  self:_RefreshShopRefreshInfo()
  self:_RefreshGoods()
end

function CopySpecialShopView:_OnShopPurchased()
  self:RefreshViewData()
  self:_RefreshGoods()
end

function CopySpecialShopView:_OnClickBtnFlushed()
  if self.shopData.refreshCount >= self.shopData.maxRefreshCount then
    Alert.ShowStr(LT.Text("StoreReleaseTimesOut"))
    return
  end
  WorldstageReqUtils.ReqOnShopRefresh({})
end

function CopySpecialShopView:_OnClickRelicStrengthen()
  local relicList = RelicDataUtils.GetStrengthRelictList()
  if not table.next(relicList) then
    Alert.ShowStr(LT.Text("SpecialShopNoStrengthRelicTips"))
    return
  end
  UIManager.Instance:Show(Urls.CopyRelicStrengthView, self.shopUid)
end

function CopySpecialShopView:_OnClickCustomSlot()
  if self:CheckCustomSoldOut() then
    Alert.ShowStr(LT.Text("SpecialShopCustomSoldOutTips"))
    return
  end
  Alert.ShowWithParams(20142, self.shopData.customCmdArgs, nil, function()
    WorldstageReqUtils.ReqOnShopCustomCmd()
  end)
end

function CopySpecialShopView:InitViewData(viewData)
  self.viewData = viewData
  self.shopUid = viewData.shopUid
  self.closeCb = viewData.closeCb
  self:RefreshViewData()
end

function CopySpecialShopView:RefreshViewData()
  self.shopData = ShopDataUtils.GetShopData(self.shopUid)
  self.goodsList = self:_GetGoodsList()
  self.specialShopCfgInfo = MapNodeCfgUtils.ParseEffectField(self.viewData.mapNodeTid)
end

function CopySpecialShopView:_GetGoodsList()
  local rst = {}
  for _, goodsData in pairs(self.shopData.ShopArray or {}) do
    if GoodsType2ClsDict[goodsData.type] then
      table.insert(rst, goodsData)
    end
  end
  return rst
end

function CopySpecialShopView:CheckCustomSoldOut()
  local useTimes = self.shopData.customCmdUseTimes or 0
  local useLimit = self.specialShopCfgInfo.customLimit or 0
  return useTimes >= useLimit
end

function CopySpecialShopView:RefreshView()
  self:RefreshViewData()
  self:_RefreshPopupTips()
  self:_RefreshGoods()
  self:_RefreshRelicStrenthSlot()
  self:_RefreshCustomSlot()
  self:_RefreshShopRefreshInfo()
end

function CopySpecialShopView:_RefreshShopRefreshInfo()
  if self.specialShopCfgInfo.refreshType == CommonDefine.WorldStageSpecialShopRefreshType.RefreshAll then
    self:SetActive(self.ui.Group_Flush, true)
    CS.Framework.TransformUtil.SetLocalPos(self.ui.Group_Goods.transform, 0, 95, 0)
    local price = self.shopData.refreshPrice or 0
    local have = WorldstageDMoneyDataUtils.GetGold() or 0
    self:SetText(self.ui.Text_IconNum, self.shopData.refreshPrice or 0)
    self:SetTextColorByHtml(self.ui.Text_IconNum, price <= have and "#FFFFFF" or notEnoughColor)
    self:SetActive(self.ui.Image_Currency, (self.shopData.refreshPrice or 0) > 0 and self.shopData.maxRefreshCount > 0)
    self:SetActive(self.ui.Btn_Flushed, self.shopData.maxRefreshCount > 0)
    self:SetText(self.ui.Text_Spend, LT.Text("SpecialShopRefreshCostLabel"))
    self:SetText(self.ui.Text_Flushed, LT.Textf("StoreRenewButton", self.shopData.maxRefreshCount - self.shopData.refreshCount, self.shopData.maxRefreshCount or 1))
  elseif self.specialShopCfgInfo.refreshType == CommonDefine.WorldStageSpecialShopRefreshType.RefreshByColumn then
    self:SetActive(self.ui.Group_Flush, false)
    CS.Framework.TransformUtil.SetLocalPos(self.ui.Group_Goods.transform, 0, 135, 0)
  end
end

function CopySpecialShopView:_RefreshGoods()
  for idx = 1, MAX_GOODS_NUM do
    local goodsGO = self.ui["Goods_" .. idx]
    local goodsData = self.goodsList[idx]
    if not goodsData then
      goodsGO:SetActive(false)
    else
      local cls = GoodsType2ClsDict[goodsData.type]
      if not cls then
      else
        goodsGO:SetActive(true)
        local viewData = {
          goodsData = goodsData,
          shopData = self.shopData,
          specialShopCfgInfo = self.specialShopCfgInfo,
          slot = idx
        }
        self:AddViewComponentOnce(goodsGO, GoodsType2ClsDict[goodsData.type], viewData)
      end
    end
  end
end

function CopySpecialShopView:_RefreshPopupTips()
  local commonPopupConfirmTipsData = {
    textTitleCN = LT.Text("SpecialShopName"),
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.Close)
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_L, CompPublicPopupTips, commonPopupConfirmTipsData)
end

function CopySpecialShopView:_RefreshRelicStrenthSlot()
  self:SetText(self.ui.Text_RelicTitle, LT.Text("WorldstageShopRelicStrengthTitle"))
  self:SetText(self.ui.Text_Relic, LT.Text("WorldstageShopRelicStrength"))
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Relic)
  if comp and self.ui.Btn_RelicStrengthen then
    comp:SetBtn(self.ui.Btn_RelicStrengthen)
  end
  self:SetActive(self.ui.Text_Number, false)
end

function CopySpecialShopView:_RefreshCustomSlot()
  local showText = LT.Textf(self.specialShopCfgInfo.customTitleLang, table.unpack(self.shopData.customCmdArgs or {}))
  self:SetText(self.ui.Text_BlackseaTitle, LT.Text("StoreGiveBloodTitle"))
  self:SetText(self.ui.Text_Sell, showText)
  self:SetImage(self.ui.Image_Seal_Icon, self.specialShopCfgInfo.customIcon)
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Sell)
  if comp and self.ui.Btn_Blackseal then
    comp:SetBtn(self.ui.Btn_Blackseal)
  end
  self:SetActive(self.ui.Group_Custom_Sellout, self:CheckCustomSoldOut())
end

function CopySpecialShopView:Close()
  if self.closeCb then
    self.closeCb()
  end
  Super.Close(self)
end

return CopySpecialShopView
