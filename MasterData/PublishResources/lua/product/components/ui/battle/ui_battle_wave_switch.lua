_class("UIBattleWaveSwitch", UIController)
UIBattleWaveSwitch = UIBattleWaveSwitch

function UIBattleWaveSwitch:OnShow(uiParams)
  local waveIndex = uiParams[1]
  self._num = self:GetUIComponent("UILocalizationText", "wavenum")
  local tex = StringTable.Get("str_battle_wave_switch", waveIndex)
  self._num:SetText(tex)
end

function UIBattleWaveSwitch:OnHide()
end
