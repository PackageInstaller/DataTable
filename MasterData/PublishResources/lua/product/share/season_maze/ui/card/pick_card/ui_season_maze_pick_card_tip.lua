_class("UISeasonMazePickCardTip", UICustomWidget)
UISeasonMazePickCardTip = UISeasonMazePickCardTip

function UISeasonMazePickCardTip:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazePickCardTip:InitWidget()
  self.root = self:GetUIComponent("RectTransform", "Root")
  self.steps = self:GetUIComponent("UILocalizationText", "Steps")
  self.asset = self:GetUIComponent("UILocalizationText", "Asset")
  self.effect = self:GetUIComponent("UILocalizationText", "Effect")
  self._anchor = self:GetUIComponent("RectTransform", "Anchor")
  self._stepRoot = self:GetGameObject("StepRoot")
  self._assetRoot = self:GetGameObject("AssetRoot")
  self._effectRoot = self:GetGameObject("EffectRoot")
end

function UISeasonMazePickCardTip:CloseMaskOnClick(go)
  self:DoHide()
end

function UISeasonMazePickCardTip:DoShow(cfg_id, pos)
  self._anchor.position = pos
  self:GetGameObject():SetActive(true)
  local stepDes, eftDes, exteaEftDes = SeasonMazeTool:GetInstance():GetCardDesc(cfg_id)
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

function UISeasonMazePickCardTip:DoHide()
  self:GetGameObject():SetActive(false)
end
