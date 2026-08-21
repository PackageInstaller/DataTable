_class("UIBattleBossSpeak", UICustomWidget)
UIBattleBossSpeak = UIBattleBossSpeak

function UIBattleBossSpeak:OnShow(uiParams)
  self:InitWidget()
end

function UIBattleBossSpeak:InitWidget()
  self._bossSpeakGO = self:GetGameObject("UIBattleBossSpeak")
  self._imgBossCard = self:GetUIComponent("RawImageLoader", "BossCardImage")
  self._txtBossName = self:GetUIComponent("UILocalizationText", "txtBossName")
  self._txtBossSpeak = self:GetUIComponent("UILocalizationText", "txtBossSpeak")
  self._animation = self:GetUIComponent("Animation", "UIBattleBossSpeak")
end

function UIBattleBossSpeak:UIShowBossSpeak(animNames, imageRes, strName, strSpeak)
  self._bossSpeakGO:SetActive(true)
  self._imgBossCard:LoadImage(imageRes)
  self._txtBossName:SetText(StringTable.Get(strName))
  self._txtBossSpeak:SetText(StringTable.Get(strSpeak))
  for i = 1, #animNames do
    self._animation:PlayQueued(animNames[i])
  end
end

function UIBattleBossSpeak:PlayOutAnimation(animName)
  self._animation:Play(animName)
end
