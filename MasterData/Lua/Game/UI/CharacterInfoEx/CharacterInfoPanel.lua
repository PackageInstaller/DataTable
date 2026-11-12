local CharacterInfoPanel = class("CharacterInfoPanel", BasePanel)
CharacterInfoPanel._nFADEINTYPE = 1
CharacterInfoPanel._nFadeInType = 0
CharacterInfoPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoEx/CharacterInfoPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharacterInfoCtrl"
  }
}
return CharacterInfoPanel
