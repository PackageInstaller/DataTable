_class("UIFeatureAlchemyLevelInfo", UICustomWidget)
UIFeatureAlchemyLevelInfo = UIFeatureAlchemyLevelInfo

function UIFeatureAlchemyLevelInfo:OnShow(uiParams)
  self:InitWidget()
end

function UIFeatureAlchemyLevelInfo:InitWidget()
  self._icon = self:GetGameObject("Icon")
  self._levelDesc = self:GetUIComponent("UILocalizationText", "LevelDesc")
  self._apCount = self:GetUIComponent("UILocalizationText", "APCount")
  self._apCountGO = self:GetGameObject("APCount")
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
  self._textLevel = self:GetUIComponent("UILocalizationText", "TextLevel")
end

function UIFeatureAlchemyLevelInfo:SetData(level, ap, desc, curAP)
  local show = ap <= curAP
  self._icon:SetActive(show)
  self._apCountGO:SetActive(not show)
  local strKey = "str_battle_n49_tlv_" .. 1 + level * 3
  self._apCount:SetText(StringTable.Get(strKey))
  self._desc:SetText(StringTable.Get(desc))
  self._textLevel:SetText(level)
  local enableColor = Color(0.3843137254901961, 0.26666666666666666, 0.054901960784313725)
  local disableColor = Color(0.5176470588235295, 0.5176470588235295, 0.5176470588235295)
  self._desc.color = show and enableColor or disableColor
end
