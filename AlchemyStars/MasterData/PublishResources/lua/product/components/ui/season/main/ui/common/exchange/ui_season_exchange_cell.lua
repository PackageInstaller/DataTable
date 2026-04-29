_class("UISeasonExchangeCell", UICustomWidget)
UISeasonExchangeCell = UISeasonExchangeCell

function UISeasonExchangeCell:SetData(index, info, seasonId, component, tipsCallback)
  self._index = index
  self._info = info
  self._seasonId = seasonId
  self._component = component
  self._tipsCallback = tipsCallback
  self._uiCfg = UISeasonHelper.GetCurExchangeCfg()
  local type = self:_GetType()
  self:_SetBg(type)
  self:_SetRemain(type)
  self:_SetDiscount()
  self:_SetItem(type)
  self:_SetCoin()
  self:_SetSoldout(type)
end

function UISeasonExchangeCell:PlayAnimationInSequence(index)
  local tb = {
    {
      animName = "uieff_UIS5Exchange_Cell_Large_in",
      duration = 600
    },
    {
      animName = "uieff_UIS5Exchange_Cell_Small_in",
      duration = 600
    },
    {
      animName = "uieff_UIS5Exchange_Cell_Small_in",
      duration = 600
    }
  }
  local type = self:_GetType()
  local animName, duration = tb[type].animName, tb[type].duration
  local delay = index * 40
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", animName, delay, duration)
end

function UISeasonExchangeCell:_GetType()
  local special = self._info.m_is_special
  local bold = UISeasonExchangeHelper.GetBold(self._component, self._info.m_id)
  local type = special and 1 or bold and 2 or 3
  return type
end

function UISeasonExchangeCell:_SetBg(type)
  local tb = {
    [1] = "exp_s5_shop_btn01",
    [2] = "exp_s5_shop_btn02",
    [3] = "exp_s5_shop_btn03"
  }
  local atlasName = "UISeasonExchange.spriteatlas"
  local spriteName = tb[type]
  UIWidgetHelper.SetImageSprite(self, "_bg", atlasName, spriteName)
end

function UISeasonExchangeCell:_SetRemain(type)
  local constHide = 0
  local remain = self._component:GetCanExchangeCount(self._info, constHide)
  local str = StringTable.Get("str_season_s1_exchange_remain", remain)
  UIWidgetHelper.SetLocalizationText(self, "_remainText", str)
  self:GetGameObject("_remainBg"):SetActive(remain ~= 0)
end

function UISeasonExchangeCell:_SetDiscount()
  local discount = UISeasonExchangeHelper.GetDiscount(self._component, self._info.m_id)
  local str = "-" .. discount .. "%"
  UIWidgetHelper.SetLocalizationText(self, "_discountText", str)
  local bActive = discount ~= 0
  self:GetGameObject("_discountBg"):SetActive(bActive)
  if bActive and self._uiCfg then
    local bgImage = self:GetUIComponent("Image", "_discountBg")
    bgImage.color = self._uiCfg.DiscountBgColor
  end
end

function UISeasonExchangeCell:_SetItem(type)
  local roleAsset = self._info.m_reward
  UIWidgetHelper.SetItemIcon(self, roleAsset.assetid, "_icon")
  UIWidgetHelper.SetLocalizationText(self, "_count", roleAsset.count)
  UIWidgetHelper.SetItemText(self, roleAsset.assetid, "_title")
end

function UISeasonExchangeCell:_SetCoin()
  local itemId = self._component:GetCostItemId(self._info.m_is_special)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, "_coin", atlasName, spriteName)
  local price1 = UISeasonExchangeHelper.GetPrice(self._component, self._info.m_id)
  UIWidgetHelper.SetLocalizationText(self, "_price1", price1)
  self:GetGameObject("_price1"):SetActive(price1 ~= 0)
  local price2 = self._info.m_cost_count
  local itemModule = GameGlobal.GetModule(ItemModule)
  local curCount = itemModule:GetItemCount(itemId)
  if price2 > curCount then
    price2 = "<color=#ff4a57>" .. price2 .. "</color>"
  end
  UIWidgetHelper.SetLocalizationText(self, "_price2", price2)
end

function UISeasonExchangeCell:_SetSoldout(type)
  local tb = {
    [1] = "exp_s5_shop_mask01",
    [2] = "exp_s5_shop_mask02",
    [3] = "exp_s5_shop_mask02"
  }
  local atlasName = "UISeasonExchange.spriteatlas"
  local spriteName = tb[type]
  UIWidgetHelper.SetImageSprite(self, "_soldout", atlasName, spriteName)
  local isSoldout = self._component:IsExchangeItemSoldout(self._info)
  self:GetGameObject("_soldout"):SetActive(isSoldout)
end

function UISeasonExchangeCell:BtnOnClick()
  Log.info("UISeasonExchangeCell:BtnOnClick index = ", self._index)
  local isSoldout = self._component:IsExchangeItemSoldout(self._info)
  if isSoldout then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_shop_sold_out_msg"))
  elseif self._info.m_reward.assetid >= RoleAssetID.RoleAssetPetSkinBegin and self._info.m_reward.assetid <= RoleAssetID.RoleAssetPetSkinEnd then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_SEASON_SKIN, self._info.m_reward.assetid - 4000000, self._seasonId, self._component, self._info)
  else
    self:ShowDialog("UISeasonExchangeConfirm", self._seasonId, self._component, self._info)
  end
end

function UISeasonExchangeCell:SetBigBg(goodsBgName)
  local bgLoader = self:GetUIComponent("RawImageLoader", "bigBg")
  if bgLoader then
    bgLoader:LoadImage(goodsBgName)
  end
end
