_class("UISeasonTalentTreeInfoDesc", UICustomWidget)
UISeasonTalentTreeInfoDesc = UISeasonTalentTreeInfoDesc

function UISeasonTalentTreeInfoDesc:OnShow()
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
end

function UISeasonTalentTreeInfoDesc:SetData(desc)
  self._desc:SetText(desc)
end
