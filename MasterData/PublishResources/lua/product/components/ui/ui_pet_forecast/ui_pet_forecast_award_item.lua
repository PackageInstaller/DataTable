_class("UIPetForecastAwardItem", UICustomWidget)
UIPetForecastAwardItem = UIPetForecastAwardItem

function UIPetForecastAwardItem:OnShow()
  self._trans = self:GetGameObject()
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UIPetForecastAwardItem:Flush(tplId, count, callback)
  self.tplId = tplId
  local cfgv = Cfg.cfg_item[tplId]
  self.icon:LoadImage(cfgv.Icon)
  self.txtCount:SetText(count)
  self.callback = callback
end

function UIPetForecastAwardItem:Trans()
  return self._trans
end

function UIPetForecastAwardItem:bgOnClick(go)
  if self.callback then
    self.callback()
  end
end
