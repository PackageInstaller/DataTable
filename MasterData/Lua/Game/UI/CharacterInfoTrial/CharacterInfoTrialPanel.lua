local CharacterInfoTrialPanel = class("CharacterInfoTrialPanel", BasePanel)
CharacterInfoTrialPanel._nFADEINTYPE = 1
CharacterInfoTrialPanel._nFadeInType = 0
CharacterInfoTrialPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoTrial/CharacterInfoTrialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoTrial.CharacterInfoTrialCtrl"
  }
}
return CharacterInfoTrialPanel
