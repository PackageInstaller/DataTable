_class("UIDiscoveryUnlock", UIController)
UIDiscoveryUnlock = UIDiscoveryUnlock

function UIDiscoveryUnlock:OnShow(uiParams)
  self._goOffset = self:GetGameObject("offset")
  self._goOffset.transform.localScale = Vector3(1, 0, 1)
  self._goOffset.transform:DOScale(Vector3.one, 0.4)
end

function UIDiscoveryUnlock:OnHide()
  self._goOffset = nil
end
