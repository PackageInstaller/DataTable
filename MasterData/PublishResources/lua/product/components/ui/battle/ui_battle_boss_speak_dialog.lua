_class("UIBattleBossSpeakDialog", UIController)
UIBattleBossSpeakDialog = UIBattleBossSpeakDialog

function UIBattleBossSpeakDialog:OnShow(uiParams)
  self._bossSpeakGen = self:GetUIComponent("UISelectObjectPath", "UIBattleBossSpeak")
  self._uiBattleBossSpeak = self._bossSpeakGen:SpawnObject("UIBattleBossSpeak")
  self:StartTask(self._HandleBossSpeakShow, self, uiParams)
end

function UIBattleBossSpeakDialog:_HandleBossSpeakShow(TT, uiParams)
  local animNames = uiParams[1]
  local bossImage = uiParams[2]
  local bossName = uiParams[3]
  local bossSpeak = uiParams[4]
  self._uiBattleBossSpeak:UIShowBossSpeak(animNames, bossImage, bossName, bossSpeak)
  local intervalTime = uiParams[5]
  YIELD(TT, intervalTime)
  local outAnimName = uiParams[6]
  self._uiBattleBossSpeak:PlayOutAnimation(outAnimName)
  YIELD(TT, 300)
  self:CloseDialog()
end
