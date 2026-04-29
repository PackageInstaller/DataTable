_class("UIShopCurrency1To2", UIController)
UIShopCurrency1To2 = UIShopCurrency1To2

function UIShopCurrency1To2:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._data = self.clientShop:GetRechargeShopData()
  self._rateYJ2GP = self.clientShop:GetDiamondExchangeGlowRate()
  self._curCount = 1
end

function UIShopCurrency1To2:LoadDataOnEnter(TT, res, uiParams)
  GameGlobal.GetModule(PayModule):RequestGetBalanceNormal()
end

function UIShopCurrency1To2:OnShow(uiParams)
  self._txtExchange = self:GetUIComponent("UILocalizationText", "txtExchange")
  self._txtGuangpo = self:GetUIComponent("UILocalizationText", "txtGuangpo")
  self._txtYaojing = self:GetUIComponent("UILocalizationText", "txtYaojing")
  self._txtBuyCount = self:GetUIComponent("UILocalizationText", "txtBuyCount")
  self._btnBottom = self:GetUIComponent("Button", "btnBottom")
  self._btnMinus = self:GetUIComponent("Button", "btnMinus")
  self._btnAdd = self:GetUIComponent("Button", "btnAdd")
  self._btnTop = self:GetUIComponent("Button", "btnTop")
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    self._btnRecharge = self:GetGameObject("btnRecharge")
    self._btnRecharge:SetActive(false)
  end
  local count1, _ = self.shopModule:GetDiamondCount()
  local diff = uiParams[1]
  if diff and diff > self._rateYJ2GP then
    local ceil = math.ceil(diff / self._rateYJ2GP)
    local max = count1
    if max < 1 then
      max = 1
    end
    self._curCount = Mathf.Clamp(ceil, 1, max)
  end
  self:Flush()
  self:AttachEvent(GameEventType.DiamondCountChanged, self.Flush)
end

function UIShopCurrency1To2:OnHide()
end

function UIShopCurrency1To2:Flush()
  self:FlushBtns()
  self:FlushCurCount()
end

function UIShopCurrency1To2:FlushBtns()
  local count1, _ = self.shopModule:GetDiamondCount()
  local interactable = 0 < count1
  self._btnBottom.interactable = interactable
  self._btnMinus.interactable = interactable
  self._btnAdd.interactable = interactable
  self._btnTop.interactable = interactable
end

function UIShopCurrency1To2:FlushCurCount()
  local count1, _ = self.shopModule:GetDiamondCount()
  local guangpo = self._curCount * self._rateYJ2GP
  self._txtGuangpo:SetText(guangpo)
  self._txtYaojing:SetText(string.format(self._curCount .. "/" .. count1))
  if count1 <= 0 then
    self._txtExchange:SetText(StringTable.Get("str_pay_yj_not_enough_cant_exchange"))
    self._txtBuyCount:SetText(0)
  else
    self._txtExchange:SetText(string.format(StringTable.Get("str_pay_cost_n_yj_exchange_m_gp", self._curCount, guangpo)))
    self._txtBuyCount:SetText(self._curCount)
  end
end

function UIShopCurrency1To2:bgOnClick(go)
  self:CloseDialog()
end

function UIShopCurrency1To2:btnCancelOnClick(go)
  self:CloseDialog()
end

function UIShopCurrency1To2:btnEnsureOnClick(go)
  local count1, freeCount1 = self.shopModule:GetDiamondCount()
  if EngineGameHelper.EnableAppleVerifyBulletin() and count1 <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_pay_yj_not_enough_cant_exchange"))
    return
  end
  if count1 <= 0 then
    ToastManager.ShowToast(StringTable.Get("str_common_stop_pay"))
    return
  end
  local mShop = self:GetModule(ShopModule)
  self:StartTask(function(TT)
    self:Lock("ApplyDiamondExchangeGlow")
    local guangpo = self._curCount * self._rateYJ2GP
    local ret = mShop:ApplyDiamondExchangeGlow(TT, self._curCount, guangpo)
    if ClientShop.CheckShopCode(ret:GetResult()) then
      local toast = string.format(StringTable.Get("str_pay_cost_n_yj_exchange_m_gp_success", self._curCount, guangpo))
      ToastManager.ShowToast(toast)
      self:CloseDialog()
    end
    self:UnLock("ApplyDiamondExchangeGlow")
  end, self)
end

function UIShopCurrency1To2:btnRechargeOnClick(go)
end

function UIShopCurrency1To2:btnBottomOnClick(go)
  local count1, _ = self.shopModule:GetDiamondCount()
  if count1 <= 0 then
    return
  end
  self._curCount = 1
  self:FlushCurCount()
end

function UIShopCurrency1To2:btnTopOnClick(go)
  local count1, _ = self.shopModule:GetDiamondCount()
  if count1 <= 0 then
    return
  end
  self._curCount = count1
  self:FlushCurCount()
end

function UIShopCurrency1To2:btnMinusOnClick(go)
  local count1, _ = self.shopModule:GetDiamondCount()
  if count1 <= 0 then
    return
  end
  if self._curCount <= 1 then
    self._curCount = 1
    self:FlushCurCount()
    return
  end
  self._curCount = self._curCount - 1
  self:FlushCurCount()
end

function UIShopCurrency1To2:btnAddOnClick(go)
  local count1, _ = self.shopModule:GetDiamondCount()
  if count1 <= 0 then
    return
  end
  if count1 <= self._curCount then
    self._curCount = count1
    self:FlushCurCount()
    return
  end
  self._curCount = self._curCount + 1
  self:FlushCurCount()
end
