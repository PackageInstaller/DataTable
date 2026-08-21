_class("UIHomelandShopBuyConfirm", UIController)
UIHomelandShopBuyConfirm = UIHomelandShopBuyConfirm

function UIHomelandShopBuyConfirm:OnShow(uiParams)
  self._itemId = uiParams[1]
  self._cost = uiParams[2]
  self._limit = uiParams[3]
  self._limitOnce = uiParams[4]
  self._callback = uiParams[5]
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

function UIHomelandShopBuyConfirm:OnHide()
  self.sldCount.onValueChanged:RemoveListener(self.OnSldCountValueChange)
end

function UIHomelandShopBuyConfirm:_Init(itemId)
  UIWidgetHelper.SetItemIcon(self, itemId, "itemIcon")
  UIWidgetHelper.SetItemText(self, itemId, "itemName")
  local coinId = UIHomelandShopHelper.GetCoinItemId()
  UIWidgetHelper.SetItemIcon(self, coinId, "costIcon")
  UIWidgetHelper.SetItemText(self, coinId, "costName")
  self:GetGameObject("result"):SetActive(self._limit ~= 0)
end

function UIHomelandShopBuyConfirm:_ChangeCount(n)
  local have = UIHomelandShopHelper.GetCoinItemCount()
  local max = math.floor(have / self._cost)
  max = math.min(self._limitOnce, max)
  if self._limit ~= 0 then
    max = math.min(max, self._limit)
  end
  local min = 1
  self._count = Mathf.Clamp(self._count + n, min, max)
  if self._limit ~= 0 then
    UIWidgetHelper.SetLocalizationText(self, "txtResultL", self._limit)
    UIWidgetHelper.SetLocalizationText(self, "txtResultR", self._limit - self._count)
  end
  local formatL = HelperProxy:GetInstance():FormatItemCount(have)
  local formatR = HelperProxy:GetInstance():FormatItemCount(have - self._cost * self._count)
  UIWidgetHelper.SetLocalizationText(self, "txtCostL", formatL)
  UIWidgetHelper.SetLocalizationText(self, "txtCostR", formatR)
  UIWidgetHelper.SetLocalizationText(self, "txtCount", self._count)
  UIWidgetHelper.SetSliderValue(self, "sldCount", self._count, max)
end

function UIHomelandShopBuyConfirm:MinBtnOnClick(go)
  self._count = 1
  self:_ChangeCount(0)
end

function UIHomelandShopBuyConfirm:DecBtnOnClick(go)
  self:_ChangeCount(-1)
end

function UIHomelandShopBuyConfirm:AddBtnOnClick(go)
  self:_ChangeCount(1)
end

function UIHomelandShopBuyConfirm:MaxBtnOnClick(go)
  local max = UIHomelandShopHelper.GetItemCount(self:_GetMainItemId())
  self:_ChangeCount(max)
end

function UIHomelandShopBuyConfirm:BgOnClick(go)
  self:CloseDialog()
end

function UIHomelandShopBuyConfirm:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandShopBuyConfirm:ConfirmBtnOnClick(go)
  if self._callback then
    self._callback(self._itemId, self._count)
  end
  self:CloseDialog()
end
