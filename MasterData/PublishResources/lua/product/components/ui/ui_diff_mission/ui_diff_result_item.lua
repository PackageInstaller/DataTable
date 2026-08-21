_class("UIDiffResultItem", UICustomWidget)
UIDiffResultItem = UIDiffResultItem

function UIDiffResultItem:OnShow(uiParam)
end

function UIDiffResultItem:GetComponents()
  self._desc = self:GetUIComponent("RollingText", "desc")
  self._animGo = self:GetGameObject("finish")
  self._animGo:SetActive(false)
end

function UIDiffResultItem:SetData(tex, anim)
  self:GetComponents()
  self._desc:RefreshText(tex)
  if anim then
    self._animGo:SetActive(true)
  end
end
