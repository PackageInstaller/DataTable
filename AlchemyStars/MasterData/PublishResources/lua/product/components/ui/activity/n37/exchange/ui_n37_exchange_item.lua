_class("UIN37ExchangeItem", UICustomWidget)
UIN37ExchangeItem = UIN37ExchangeItem

function UIN37ExchangeItem:SetData(index, data, component, tipsCallback, isShowBg)
  self._index = index
  self._data = data
  self._component = component
  self._tipsCallback = tipsCallback
  self:_SetRemainCount()
  self:_SetReward()
  self:_SetCost()
  self:GetGameObject("_bg"):SetActive(isShowBg)
end

function UIN37ExchangeItem:PlayAnimationInSequence(index, type, wait)
  local tb = {
    Big = {
      animName = "uieff_UIN37Exchange_ItemBig_in",
      duration = 1800
    },
    Small = {
      animName = "uieff_UIN37Exchange_ItemSmall_in",
      duration = 333
    }
  }
  local animName, duration = tb[type].animName, tb[type].duration
  local delay = wait + (index - 1) * 66
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_root", animName, delay, duration, nil, true)
end

function UIN37ExchangeItem:_SetRemainCount()
  local isLimit = self._data.m_exchange_limit_count ~= -1
  local count = self._data.m_can_exchange_count
  local limitText = StringTable.Get("str_n37_item_remain_title") .. count
  local unlimitText = StringTable.Get("str_n31_item_unlimit_count")
  local text = isLimit and limitText or unlimitText
  if isLimit and count == 0 then
    text = UIActivityHelper.GetColorText("#9C4343", text)
  end
  UIWidgetHelper.SetLocalizationText(self, "RemainCount", text)
  self:GetGameObject("_soldout"):SetActive(isLimit and count == 0)
end

function UIN37ExchangeItem:_SetReward()
  local data = self._data
  local itemId = data.m_reward.assetid
  local count = data.m_reward.count
  local isSpecial = data.m_id == 1
  self:GetGameObject("SpecialIcon"):SetActive(isSpecial)
  self:GetGameObject("RewardIcon"):SetActive(not isSpecial)
  if isSpecial then
    local cfg = Cfg.cfg_activity_shop_special_item_icon_client[itemId]
    local url = (cfg or {}).SpecialIcon or ""
    UIWidgetHelper.SetRawImage(self, "SpecialIcon", url)
  else
    UIWidgetHelper.SetItemIcon(self, itemId, "RewardIcon")
  end
  UIWidgetHelper.SetItemIconColor(self, itemId, "_color", "UIN37Main.spriteatlas", "n37_shop_pinzhi0")
  UIWidgetHelper.SetItemText(self, itemId, "Title")
  UIWidgetHelper.SetLocalizationText(self, "RewardCount", count)
end

function UIN37ExchangeItem:_SetCost()
  local icon, count = self._component:GetCostItemIconText()
  local need = self._data.m_cost_count
  local colorRed = "#F84757"
  local colorNormal = "#F9F4F6"
  local color = count < need and colorRed or colorNormal
  local str = UIActivityHelper.GetColorText(color, tostring(need))
  UIWidgetHelper.SetLocalizationText(self, "CostCount", str)
end

function UIN37ExchangeItem:BtnOnClick(go)
  local uiItemData = DCampaignShopItemBase:New()
  uiItemData:Refresh(self._data, self._component)
  local useNormalDlg = false
  if not uiItemData:IsUnLimit() then
    local remainCount = uiItemData:GetRemainCount()
    if remainCount <= 0 then
      ToastManager.ShowToast(StringTable.Get("str_n31_item_has_empty_tips"))
      return
    end
    if remainCount == 1 then
      useNormalDlg = true
    end
  end
  local tb = {
    [true] = "UICampaignShopConfirmNormalController",
    [false] = "UICampaignShopConfirmDetailController"
  }
  self:ShowDialog(tb[useNormalDlg], uiItemData)
end
