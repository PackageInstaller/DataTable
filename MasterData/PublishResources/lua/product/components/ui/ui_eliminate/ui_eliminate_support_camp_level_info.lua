_class("UIEliminateSupportCampLevelInfo", UICustomWidget)
UIEliminateSupportCampLevelInfo = UIEliminateSupportCampLevelInfo

function UIEliminateSupportCampLevelInfo:OnShow(uiParams)
  self:_GetComponents()
end

function UIEliminateSupportCampLevelInfo:_GetComponents()
  self._infoTxt = self:GetUIComponent("UILocalizationText", "infoTxt")
  self._lvTxt = self:GetUIComponent("UILocalizationText", "LvTxt")
end

function UIEliminateSupportCampLevelInfo:SetData(cfg)
  self._cfg = cfg
  self._infoTxt:SetText(StringTable.Get(self._cfg.Content))
  self._lvTxt:SetText("LV." .. self._cfg.Level)
end
