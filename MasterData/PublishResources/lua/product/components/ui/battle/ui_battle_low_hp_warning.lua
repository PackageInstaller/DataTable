_class("UIBattleLowHPWarning", UICustomWidget)
UIBattleLowHPWarning = UIBattleLowHPWarning

function UIBattleLowHPWarning:OnShow()
  self._lowHpWarning = self:GetGameObject("LowHpWarning")
  self._lowHpWarning:SetActive(false)
  self:AttachEvent(GameEventType.ShowHideLowHpWarning, self.ShowHideLowHpWarning)
end

function UIBattleLowHPWarning:ShowHideLowHpWarning(b)
  self._lowHpWarning:SetActive(b)
end
