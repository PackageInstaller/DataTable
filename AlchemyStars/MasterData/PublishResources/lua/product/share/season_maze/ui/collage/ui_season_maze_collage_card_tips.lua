_class("UISeasonMazeCollageCardTips", UICustomWidget)
UISeasonMazeCollageCardTips = UISeasonMazeCollageCardTips

function UISeasonMazeCollageCardTips:OnShow()
  self:InitWidgets()
end

function UISeasonMazeCollageCardTips:InitWidgets()
  self.root = self:GetUIComponent("RectTransform", "Root")
  self._rootGo = self:GetGameObject("Root")
  self.steps = self:GetUIComponent("UILocalizationText", "Steps")
  self.asset = self:GetUIComponent("UILocalizationText", "Asset")
  self.effect = self:GetUIComponent("UILocalizationText", "Effect")
  self._stepRoot = self:GetGameObject("StepRoot")
  self._assetRoot = self:GetGameObject("AssetRoot")
  self._effectRoot = self:GetGameObject("EffectRoot")
end

function UISeasonMazeCollageCardTips:SetData(itemId)
  self._rootGo:SetActive(true)
  local stepDes, eftDes, exteaEftDes = SeasonMazeTool:GetInstance():GetCardDesc(itemId)
  if stepDes then
    self.steps:SetText(stepDes)
    self._stepRoot:SetActive(true)
  else
    self._stepRoot:SetActive(false)
  end
  if eftDes then
    self.asset:SetText(eftDes)
    self._assetRoot:SetActive(true)
  else
    self._assetRoot:SetActive(false)
  end
  if exteaEftDes then
    self.effect:SetText(exteaEftDes)
    self._effectRoot:SetActive(true)
  else
    self._effectRoot:SetActive(false)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.root)
end
