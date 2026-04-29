_class("UIActivityN21CCAffixDetailItem", UICustomWidget)
UIActivityN21CCAffixDetailItem = UIActivityN21CCAffixDetailItem

function UIActivityN21CCAffixDetailItem:OnShow()
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._categoryIconLoader = self:GetUIComponent("RawImageLoader", "CategoryIcon")
  self._go = self:GetGameObject()
end

function UIActivityN21CCAffixDetailItem:OnHide()
end

function UIActivityN21CCAffixDetailItem:Refresh(affixData)
  if affixData == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  local score = affixData:GetScroe()
  local scoreStr = ""
  if 0 <= score then
    scoreStr = "<color=#ffbf14>+" .. score .. "</color>"
  else
    scoreStr = "<color=#b3f12d>" .. score .. "</color>"
  end
  self._nameLabel:SetText(affixData:GetDes())
  self._scoreLabel:SetText(scoreStr)
  self._categoryIconLoader:LoadImage(UIActivityN21CCConst.GetAffixCategoryIcon(affixData:GetCategoryType()))
end
