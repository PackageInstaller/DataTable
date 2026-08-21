_class("UIHomelandShopSellConfirm", UIController)
UIHomelandShopSellConfirm = UIHomelandShopSellConfirm

function UIHomelandShopSellConfirm:OnShow(uiParams)
  self._itemId = uiParams[1]
  self._callback = uiParams[2]
  self.sldCount = self:GetUIComponent("Slider", "sldCount")
  
  function self.OnSldCountValueChange(value)
    self._count, _ = math.modf(value)
    self:_ChangeCount(0)
  end
  
  self.sldCount.onValueChanged:AddListener(self.OnSldCountValueChange)
  self._count = 1
  self:_ChangeCount(0)
  self:_Init(self._itemId)
end

function UIHomelandShopSellConfirm:OnHide()
  self.sldCount.onValueChanged:RemoveListener(self.OnSldCountValueChange)
end

function UIHomelandShopSellConfirm:_Init(itemId)
  UIWidgetHelper.SetItemIcon(self, itemId, "costIcon")
  UIWidgetHelper.SetItemText(self, itemId, "costName")
  local coinId = UIHomelandShopHelper.GetCoinItemId()
  UIWidgetHelper.SetItemIcon(self, coinId, "resultIconL")
  UIWidgetHelper.SetItemCount(self, coinId, "txtResultL", function(count)
    return HelperProxy:GetInstance():FormatItemCount(count)
  end)
  UIWidgetHelper.SetItemIcon(self, coinId, "resultIconR")
end

function UIHomelandShopSellConfirm:_ChangeCount(n)
  local max = UIHomelandShopHelper.GetItemCount_ForSale(self._itemId)
  local min = 1
  self._count = Mathf.Clamp(self._count + n, min, max)
  UIWidgetHelper.SetLocalizationText(self, "txtCostL", max)
  UIWidgetHelper.SetLocalizationText(self, "txtCostR", max - self._count)
  UIWidgetHelper.SetLocalizationText(self, "txtCount", self._count)
  local sellPrice = UIHomelandShopHelper.CalcItemSellPrice(self._itemId, self._count)
  UIWidgetHelper.SetItemCount(self, sellPrice.assetid, "txtResultR", function(count)
    return HelperProxy:GetInstance():FormatItemCount(count + sellPrice.count)
  end)
  UIWidgetHelper.SetSliderValue(self, "sldCount", self._count, max)
end

function UIHomelandShopSellConfirm:MinBtnOnClick(go)
  self._count = 1
  self:_ChangeCount(0)
end

function UIHomelandShopSellConfirm:DecBtnOnClick(go)
  self:_ChangeCount(-1)
end

function UIHomelandShopSellConfirm:AddBtnOnClick(go)
  self:_ChangeCount(1)
end

function UIHomelandShopSellConfirm:MaxBtnOnClick(go)
  local max = UIHomelandShopHelper.GetItemCount_ForSale(self:_GetMainItemId())
  self:_ChangeCount(max)
end

function UIHomelandShopSellConfirm:BgOnClick(go)
  self:CloseDialog()
end

function UIHomelandShopSellConfirm:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandShopSellConfirm:ConfirmBtnOnClick(go)
  if self._callback then
    self._callback(self._itemId, self._count)
  end
  self:CloseDialog()
end
