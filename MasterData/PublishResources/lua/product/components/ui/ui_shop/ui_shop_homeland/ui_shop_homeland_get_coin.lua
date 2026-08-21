_class("UIShopHomelandGetCoin", UIController)
UIShopHomelandGetCoin = UIShopHomelandGetCoin

function UIShopHomelandGetCoin:Constructor()
  self._itemModule = self:GetModule(ItemModule)
  self._shopModule = self:GetModule(ShopModule)
  self._clientShop = self._shopModule:GetClientShop()
  self._rate = self._clientShop:GetGlowExchangeFurnitureCoinRate()
  self._type = RoleAssetID.RoleAssetGlow
end

function UIShopHomelandGetCoin:OnShow(uiParams)
  self._txtExchange = self:GetUIComponent("UILocalizationText", "txtExchange")
  self._txtHomelandCoin = self:GetUIComponent("UILocalizationText", "txtHomelandCoin")
  self._txtGlow = self:GetUIComponent("UILocalizationText", "txtGlow")
  self._txtBuyCount = self:GetUIComponent("UILocalizationText", "txtBuyCount")
  self._btnBottom = self:GetUIComponent("Button", "btnBottom")
  self._btnMinus = self:GetUIComponent("Button", "btnMinus")
  self._btnAdd = self:GetUIComponent("Button", "btnAdd")
  self._btnTop = self:GetUIComponent("Button", "btnTop")
  self._totalGlowCount = self._itemModule:GetItemCount(self._type)
  self._defaultClowCount = 0
  if self._totalGlowCount and self._totalGlowCount > self._rate then
    local count = math.ceil(self._totalGlowCount / self._rate)
    local max = self._totalGlowCount
    if max < 1 then
      max = 1
    end
    self._defaultClowCount = math.min(1, max)
  end
  self._curGlowCount = self._defaultClowCount
  self:Flush()
end

function UIShopHomelandGetCoin:OnHide()
end

function UIShopHomelandGetCoin:Flush()
  self:FlushBtns()
  self:FlushCurCount()
end

function UIShopHomelandGetCoin:FlushBtns()
  local interactable = self._totalGlowCount > 0
  self._btnBottom.interactable = interactable
  self._btnMinus.interactable = interactable
  self._btnAdd.interactable = interactable
  self._btnTop.interactable = interactable
end

function UIShopHomelandGetCoin:FlushCurCount()
  local homelandCoinCount = self._curGlowCount * self._rate
  self._txtHomelandCoin:SetText(homelandCoinCount)
  self._txtGlow:SetText(string.format(self._curGlowCount .. "/" .. self._totalGlowCount))
  if self._totalGlowCount <= 0 then
    self._txtExchange:SetText(StringTable.Get("str_shop_homeland_glow_notenough"))
    self._txtBuyCount:SetText(0)
  else
    self._txtExchange:SetText(StringTable.Get("str_shop_homeland_get_coin", self._curGlowCount, homelandCoinCount))
    self._txtBuyCount:SetText(self._curGlowCount)
  end
end

function UIShopHomelandGetCoin:bgOnClick(go)
  self:CloseDialog()
end

function UIShopHomelandGetCoin:btnCancelOnClick(go)
  self:CloseDialog()
end

function UIShopHomelandGetCoin:btnEnsureOnClick(go)
  if self._curGlowCount <= 0 then
    return
  end
  if 0 >= self._totalGlowCount then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_shop_homeland_glow_notenough"), function(param)
      self._clientShop:OpenRechargeShop()
      self:CloseDialog()
    end, nil, function(param)
    end, nil)
  else
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_shop_homeland_get_coin", self._curGlowCount, self._curGlowCount * self._rate), function(param)
      local mShop = self:GetModule(ShopModule)
      self:StartTask(function(TT)
        self:Lock("UIShopHomelandGetCoin")
        local homelandCoinCount = self._curGlowCount * self._rate
        local ret = mShop:ApplyGlowExchangeFurnitureCoin(TT, self._curGlowCount, homelandCoinCount)
        if ClientShop.CheckShopCode(ret:GetResult()) then
          ToastManager.ShowToast(StringTable.Get("str_shop_homeland_success", self._curGlowCount, homelandCoinCount))
          self:CloseDialog()
        end
        self:UnLock("UIShopHomelandGetCoin")
      end, self)
    end, nil, function(param)
    end, nil)
  end
end

function UIShopHomelandGetCoin:btnRechargeOnClick(go)
  if not UIShopController.CheckIsOpen(ShopMainTabType.Recharge) then
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIShopCurrency1To2", 0)
  self:CloseDialog()
end

function UIShopHomelandGetCoin:btnBottomOnClick(go)
  if self._curGlowCount <= 0 then
    return
  end
  self._curGlowCount = self._curGlowCount - 100
  if self._curGlowCount <= 0 then
    self._curGlowCount = 0
  end
  self:FlushCurCount()
end

function UIShopHomelandGetCoin:btnTopOnClick(go)
  if self._totalGlowCount <= 0 then
    return
  end
  self._curGlowCount = self._curGlowCount + 100
  if self._curGlowCount >= self._totalGlowCount then
    self._curGlowCount = self._totalGlowCount
  end
  self:FlushCurCount()
end

function UIShopHomelandGetCoin:btnMinusOnClick(go)
  if self._totalGlowCount <= 0 then
    return
  end
  if self._curGlowCount <= 1 then
    self._curGlowCount = 1
    self:FlushCurCount()
    return
  end
  self._curGlowCount = self._curGlowCount - 1
  self:FlushCurCount()
end

function UIShopHomelandGetCoin:btnAddOnClick(go)
  if self._totalGlowCount <= 0 then
    return
  end
  if self._curGlowCount >= self._totalGlowCount then
    self._curGlowCount = self._totalGlowCount
    self:FlushCurCount()
    return
  end
  self._curGlowCount = self._curGlowCount + 1
  self:FlushCurCount()
end
