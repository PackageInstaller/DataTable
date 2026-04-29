_class("UIHomelandMainBtnsCampaignItem", UICustomWidget)
UIHomelandMainBtnsCampaignItem = UIHomelandMainBtnsCampaignItem

function UIHomelandMainBtnsCampaignItem:SetData(campaign, cfg, callback)
  self._campaign = campaign
  self._cfg = cfg
  self._enter = _createInstance(cfg.ClassName, campaign, cfg)
  if not self._enter then
    Log.exception("UIHomelandMainBtnsCampaignItem:SetData() self._enter = nil, cfg.ID = ", cfg.ID)
  end
  UIWidgetHelper.SetRawImage(self, "_bg", cfg.Bg)
  UIWidgetHelper.SetRawImage(self, "_head", cfg.Head)
  UIWidgetHelper.SetRawImage(self, "_left", cfg.Left)
  UIWidgetHelper.SetRawImage(self, "_icon", cfg.Icon)
  UIWidgetHelper.SetLocalizationText(self, "_title", StringTable.Get(cfg.Title))
end

function UIHomelandMainBtnsCampaignItem:SetNewAndReds()
  local new = self._enter:GetNew()
  if type(new) == "boolean" then
    new = new and 1 or 0
  end
  local red = self._enter:GetRedCount()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", nil, "_redCount", "_redCountTxt")
  return new, red
end

function UIHomelandMainBtnsCampaignItem:BtnOnClick(go)
  self._enter:OpenUI()
end
