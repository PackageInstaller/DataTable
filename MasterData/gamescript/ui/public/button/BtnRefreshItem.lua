local BtnRefreshItem, Super = System.NewComponent("BtnRefreshItem")

function BtnRefreshItem:ctor(res, num, refreshCallback, isShowZero)
  Super.ctor(self)
  self.ui = Btn_RefreshResource(res)
  self.num = num
  self.refreshCallback = refreshCallback
  self.isShowZero = isShowZero or false
end

function BtnRefreshItem:OnBind(binder)
  binder:BindButtonClick(self.ui.uiNode, System.fn(self, self.OnRefresh))
  binder:BindToRaw(function(o, n)
    n = tonumber(n) or 0
    binder:SetText(self.ui.Text_Count, LT.Textf("Event_Shop_Btn_Renew", n))
    self.ui.uiNode:SetActive(n > 0 or self.isShowZero)
    local originColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop1)
    local discountColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop2)
    local notEnoughColor = StrUtils.GetWordsEffectColor(DT.WordsEffectConfig.Shop3)
    binder:SetTextColorByHtml(self.ui.Text_Count, n <= 0 and notEnoughColor or originColor)
  end, function()
    do return self.GetNum end
    return self.GetNum, self
  end)
end

function BtnRefreshItem:GetNum()
  if type(self.num) == "function" then
    do return end
    return self.num, self.num
  end
  if self.num.value then
    return self.num.value
  end
  return self.num or 0
end

function BtnRefreshItem:OnRefresh()
  local num = self:GetNum()
  if num <= 0 then
    Alert.Show(10194)
    return
  end
  if self.refreshCallback then
    self.refreshCallback()
  end
end

return BtnRefreshItem
