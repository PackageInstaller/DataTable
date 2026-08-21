_class("UIWidgetFeatureAlchemyInfo", UICustomWidget)
UIWidgetFeatureAlchemyInfo = UIWidgetFeatureAlchemyInfo

function UIWidgetFeatureAlchemyInfo:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureAlchemyInfo:InitWidget()
  self._sliderAP = self:GetUIComponent("Slider", "APSlider")
  self._txtLevel = self:GetUIComponent("UILocalizationText", "Level")
  self:RegisterEvent()
end

function UIWidgetFeatureAlchemyInfo:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureAddAlchemyAP, self.AddAlchemyAP)
end

function UIWidgetFeatureAlchemyInfo:AddAlchemyAP(ap, level, addAP)
  self._curAP = ap
  self._txtLevel.text = level
end

function UIWidgetFeatureAlchemyInfo:SetData(initData)
  self._alchemyParam = initData
  self._curAP = 0
  self._txtLevel.text = 0
end

function UIWidgetFeatureAlchemyInfo:UIWidgetFeatureAlchemyInfoOnClick(go)
  self:ShowDialog("UIFeatureAlchemyInfo", self._alchemyParam, self._curAP)
end
