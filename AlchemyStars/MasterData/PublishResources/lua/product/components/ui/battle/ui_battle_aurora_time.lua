_class("UIBattleAuroraTime", UICustomWidget)
UIBattleAuroraTime = UIBattleAuroraTime

function UIBattleAuroraTime:OnShow()
  self._auroraTimeEff = self:GetGameObject("uieff_jgsk")
  self._leftText = self:GetUIComponent("UILocalizationText", "txt_left")
  self._rightText = self:GetUIComponent("UILocalizationText", "txt_right")
  self._leftTextLayoutElement = self:GetUIComponent("LayoutElement", "txt_left")
  self._rightTextLayoutElement = self:GetUIComponent("LayoutElement", "txt_right")
  self._auroraTimeEff:SetActive(false)
  self:AttachEvent(GameEventType.ShowHideAuroraTime, self.ShowHideAuroraTime)
end

function UIBattleAuroraTime:ShowHideAuroraTime(isShow)
  self._auroraTimeEff:SetActive(isShow)
  if isShow then
    self._leftText:SetText(StringTable.Get("str_battle_aurora_time_str_aurora"))
    self._rightText:SetText(StringTable.Get("str_battle_aurora_time_str_time"))
    local leftWidth = self._leftText.preferredWidth
    local rightWidth = self._rightText.preferredWidth
    if leftWidth > rightWidth then
      self._rightTextLayoutElement.minWidth = leftWidth
    else
      self._leftTextLayoutElement.minWidth = rightWidth
    end
  end
  if isShow then
    AudioHelperController.SetBGMMixerGroup(AudioConstValue.AuroralTimeMixerGroupName, AudioConstValue.AuroralTimeMixerValue)
  else
    AudioHelperController.SetBGMMixerGroup(AudioConstValue.AuroralTimeMixerGroupName, AudioConstValue.DefaultMixerValue)
  end
end
