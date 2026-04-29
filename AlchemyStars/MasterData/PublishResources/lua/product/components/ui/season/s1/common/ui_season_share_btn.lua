_class("UISeasonShareBtn", UICustomWidget)
UISeasonShareBtn = UISeasonShareBtn

function UISeasonShareBtn:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonShareBtn:InitWidget()
  self.icon = self:GetUIComponent("Image", "Icon")
  self.count = self:GetUIComponent("UILocalizationText", "Count")
  self.award = self:GetGameObject("Award")
end

function UISeasonShareBtn:SetData(count, onClick)
  self._onClick = onClick
  if count and 0 < count then
    self.count:SetText(count)
    self.award:SetActive(true)
  else
    self.award:SetActive(false)
  end
end

function UISeasonShareBtn:ShareBtnOnClick(go)
  self._onClick()
end
