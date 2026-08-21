_class("UIN13BuildScore", UICustomWidget)
UIN13BuildScore = UIN13BuildScore

function UIN13BuildScore:OnShow()
end

function UIN13BuildScore:SetData(type)
  local url = UIActivityN13Helper.GetCoinItemIconName(type)
  local count = UIActivityN13Helper.GetCoinItemCount(type)
  self:_SetRawImage("_icon", url)
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, count)
  local fmtStr = string.format("<color=#5e5e5e>%s</color><color=#f2c641>%s</color>", preZero, tostring(count))
  self:_SetText("_txt", fmtStr)
end

function UIN13BuildScore:_SetRawImage(widgetName, url)
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(url)
end

function UIN13BuildScore:_SetText(widgetName, txt)
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(txt)
end
