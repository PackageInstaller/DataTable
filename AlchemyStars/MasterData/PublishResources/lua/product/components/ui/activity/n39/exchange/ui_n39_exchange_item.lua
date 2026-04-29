_class("UIN39ExchangeItem", UICustomWidget)
UIN39ExchangeItem = UIN39ExchangeItem

function UIN39ExchangeItem:SetData(data, component, tipsCallback, animIdx, planAnim)
  self._data = data
  self._component = component
  self._tipsCallback = tipsCallback
  self._animIdx = animIdx
  self._planAnim = planAnim
  self:_SetRemainCount()
  self:_SetReward()
  self:_SetCost()
  self:PlayAnim()
end

function UIN39ExchangeItem:PlayAnim()
  local alpha = self:GetUIComponent("CanvasGroup", "_root")
  if not self._planAnim then
    alpha.alpha = 1
    return
  end
  local anim = self:GetUIComponent("Animation", "_anim")
  local yieldTime = (self._animIdx - 1) * 60
  if yieldTime == 0 then
    anim:Play()
  else
    if self._animTimer then
      GameGlobal.Timer():CancelEvent(self._animTimer)
    end
    alpha.alpha = 0
    self._animTimer = GameGlobal.Timer():AddEvent(yieldTime, function()
      anim:Play()
    end)
  end
end

function UIN39ExchangeItem:OnHide()
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
  end
end

function UIN39ExchangeItem:PlayAnimationInSequencetmp(index, type, wait)
  local tb = {
    Big = {
      animName = "uieff_UIN39Exchange_ItemBig_in",
      duration = 1800
    },
    Small = {
      animName = "uieff_UIN39Exchange_ItemSmall_in",
      duration = 333
    }
  }
  local animName, duration = tb[type].animName, tb[type].duration
  local delay = wait + (index - 1) * 66
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_root", animName, delay, duration, nil, true)
end

function UIN39ExchangeItem:_SetRemainCount()
  local isLimit = self._data.m_exchange_limit_count ~= -1
  local count = self._data.m_can_exchange_count
  local limitText = StringTable.Get("str_n39_item_remain_title") .. count
  local unlimitText = StringTable.Get("str_n31_item_unlimit_count")
  local text = isLimit and limitText or unlimitText
  if not isLimit or count == 0 then
  end
  UIWidgetHelper.SetLocalizationText(self, "RemainCount", text)
  self:GetGameObject("_soldout"):SetActive(isLimit and count == 0)
end

function UIN39ExchangeItem:_SetReward()
  local data = self._data
  local itemId = data.m_reward.assetid
  local count = data.m_reward.count
  local iconRect = self:GetUIComponent("RectTransform", "SpecialIcon")
  iconRect.sizeDelta = Vector2(276, 276)
  local isSpecial = data.m_is_special
  self:GetGameObject("SpecialIconGo"):SetActive(isSpecial)
  self:GetGameObject("RewardIconGo"):SetActive(not isSpecial)
  if isSpecial then
    local cfg = Cfg.cfg_activity_shop_special_item_icon_client[itemId]
    if cfg and cfg.SpecialIcon then
      UIWidgetHelper.SetRawImage(self, "SpecialIcon", cfg.SpecialIcon)
      if cfg.SizeInBigCell then
        local b = string.split(cfg.SizeInBigCell, "|")
        local w = tonumber(b[1])
        local h = tonumber(b[2])
        iconRect.sizeDelta = Vector2(w, h)
      end
    else
      UIWidgetHelper.SetItemIcon(self, itemId, "SpecialIcon")
    end
  else
    UIWidgetHelper.SetItemIcon(self, itemId, "RewardIcon")
  end
  UIWidgetHelper.SetItemText(self, itemId, "Title")
  UIWidgetHelper.SetLocalizationText(self, "RewardCount", "x" .. count)
end

function UIN39ExchangeItem:_SetCost()
  local costid = self._data.m_cost_item_id
  local count = GameGlobal.GetModule(ItemModule):GetItemCount(costid)
  local need = self._data.m_cost_count
  local colorRed = "#fa5144"
  local colorNormal = "#faf6fd"
  local color = count < need and colorRed or colorNormal
  local str = UIActivityHelper.GetColorText(color, tostring(need))
  UIWidgetHelper.SetLocalizationText(self, "CostCount", str)
end

function UIN39ExchangeItem:BtnOnClick(go)
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
