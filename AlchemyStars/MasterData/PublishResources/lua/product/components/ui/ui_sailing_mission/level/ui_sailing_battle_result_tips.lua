_class("UISailingBattleResultTips", UIController)
UISailingBattleResultTips = UISailingBattleResultTips

function UISailingBattleResultTips:OnShow(uiParams)
  local matchResult = uiParams[1]
  local sailingMissionModule = GameGlobal.GetModule(SailingMissionModule)
  self._layerLabel = self:GetUIComponent("UILocalizationText", "Layer")
  self._histroyLabel = self:GetUIComponent("UILocalizationText", "Histroy")
  self._currentLabel = self:GetUIComponent("UILocalizationText", "Current")
  self._historyMissionMaxValue = UISailingImageNumber:New(self, "n22_dhh_num2_%d")
  self._historyMissionMaxValue:AddDigitImage(self:GetUIComponent("Image", "historyMissionMaxValue0"))
  self._historyMissionMaxValue:AddDigitImage(self:GetUIComponent("Image", "historyMissionMaxValue1"))
  self._historyMissionMaxValue:AddDigitImage(self:GetUIComponent("Image", "historyMissionMaxValue2"))
  local layerId = matchResult.m_parent_mission_id
  self._layerLabel:SetText(StringTable.Get("str_sailing_mission_level_result_layer_tips", layerId))
  self._historyCount = sailingMissionModule:GetCacheHistoryMissionCount()
  self._currentCount = matchResult.history_exploration_progress
  self._histroyLabel:SetText(self._historyCount)
  self._currentLabel:SetText(self._currentCount)
  self._historyMissionMaxValue:SetValue(self._currentCount)
  self:StartTask(self.PlayAnim, self)
end

function UISailingBattleResultTips:PlayAnim(TT)
  self:Lock("UISailingBattleResultTips_PlayAnim")
  local number1 = UISailingImageNumber:New(self, "n22_dhh_num2_%d")
  number1:AddDigitImage(self:GetUIComponent("Image", "single_number_3"))
  number1:AddDigitImage(self:GetUIComponent("Image", "double_number_3"))
  number1:SetValue(self._historyCount)
  local number2 = UISailingImageNumber:New(self, "n22_dhh_num2_%d")
  number2:AddDigitImage(self:GetUIComponent("Image", "single_number_1"))
  number2:AddDigitImage(self:GetUIComponent("Image", "double_number_1"))
  number2:SetValue(self._historyCount)
  local number3 = UISailingImageNumber:New(self, "n22_dhh_num2_%d")
  number3:AddDigitImage(self:GetUIComponent("Image", "single_number_2"))
  number3:AddDigitImage(self:GetUIComponent("Image", "double_number_2"))
  number3:SetValue(self._currentCount)
  YIELD(TT, 900)
  local anim = self:GetUIComponent("Animation", "Anim")
  local cur = self._currentCount - self._currentCount % 10
  local his = self._historyCount - self._historyCount % 10
  if cur > his then
    anim:Play("uieff_UISailingBattleResultTips_number_double")
  else
    anim:Play("uieff_UISailingBattleResultTips_number_right")
  end
  self:UnLock("UISailingBattleResultTips_PlayAnim")
end

function UISailingBattleResultTips:MashOnClick()
  self:CloseDialog()
end
