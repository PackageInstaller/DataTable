_class("UIActivityN4CCAffixDetailItem", UICustomWidget)
UIActivityN4CCAffixDetailItem = UIActivityN4CCAffixDetailItem

function UIActivityN4CCAffixDetailItem:OnShow()
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._go = self:GetGameObject()
  self._anim = self:GetGameObject():GetComponent("Animation")
  self._btnGo = self:GetGameObject("Btn")
  self._btnGo:SetActive(false)
end

function UIActivityN4CCAffixDetailItem:OnHide()
end

function UIActivityN4CCAffixDetailItem:Refresh(descStr)
  if descStr == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._nameLabel:SetText(descStr)
end

function UIActivityN4CCAffixDetailItem:PlayInAni(delayMs)
  self:StartTask(function(TT)
    YIELD(TT, delayMs)
    self._btnGo:SetActive(true)
    self._anim:Play("uianim_UIActivityN4CCAffixDetailItem_in")
  end)
end

function UIActivityN4CCAffixDetailItem:PlayOutAni()
  self._anim:Play("uianim_UIActivityN4CCAffixDetailItem_out")
end
