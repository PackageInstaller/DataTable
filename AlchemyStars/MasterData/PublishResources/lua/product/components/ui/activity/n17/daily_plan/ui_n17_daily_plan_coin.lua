_class("UIN17DailyPlanCoin", UICustomWidget)
UIN17DailyPlanCoin = UIN17DailyPlanCoin

function UIN17DailyPlanCoin:OnShow(uiParams)
  self._isOpen = true
end

function UIN17DailyPlanCoin:OnHide()
  self._isOpen = false
end

function UIN17DailyPlanCoin:SetData(component)
  local url = component:GetKeyRewardIcon()
  UIWidgetHelper.SetRawImage(self, "_coinIcon", url)
  local cur, max = component:GetKeyRewardCount()
  local c1 = "#faaa28"
  local c2 = "#ffffff"
  local text = UIActivityHelper.GetColorText(c1, cur, c2, "/" .. max)
  UIWidgetHelper.SetLocalizationText(self, "_coinNum", text)
end

function UIN17DailyPlanCoin:AddCoinBtnOnClick(go)
end

function UIN17DailyPlanCoin:CoinIconOnClick(go)
end
