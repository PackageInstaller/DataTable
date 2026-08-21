_class("UIBattleInfoConditionItem", UICustomWidget)
UIBattleInfoConditionItem = UIBattleInfoConditionItem

function UIBattleInfoConditionItem:OnShow()
  self._txtCond = self:GetUIComponent("UILocalizationText", "ConditionText")
  self._goStarGrey = self:GetGameObject("imgStarGrey")
  self._goStar = self:GetGameObject("imgStar")
  self._goStar:SetActive(false)
end

function UIBattleInfoConditionItem:Flush(str, showStar)
  self._txtCond.text = str
  self._goStar:SetActive(showStar)
end
