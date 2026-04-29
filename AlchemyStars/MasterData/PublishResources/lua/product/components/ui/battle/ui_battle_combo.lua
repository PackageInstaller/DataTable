_class("UIBattleCombo", UICustomWidget)
UIBattleCombo = UIBattleCombo

function UIBattleCombo:OnShow()
  self._comboGO = self:GetGameObject("Combo")
  self._comboTxt = self:GetUIComponent("UILocalizationText", "ComboNumberText")
  self:HideCombo()
  self:AttachEvent(GameEventType.DisplayCombo, self.OnDisplayCombo)
end

function UIBattleCombo:OnDisplayCombo(comboNum)
  if 0 < comboNum then
    self._comboTxt:SetText(comboNum)
    self._comboGO:SetActive(true)
    self._comboGO.transform:DOKill(true)
    self._comboGO.transform:DOShakePosition(0.3, Vector3(5, 20, 0), 200, 0, false, false)
  else
    self:HideCombo()
  end
end

function UIBattleCombo:HideCombo()
  self._comboTxt:SetText("")
  self._comboGO:SetActive(false)
end
