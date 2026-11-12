local CharSystemPresetPotentialPanel = class("CharSystemPresetPotentialPanel", BasePanel)
CharSystemPresetPotentialPanel._bIsMainPanel = false
CharSystemPresetPotentialPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
CharSystemPresetPotentialPanel._tbDefine = {
  {
    sPrefabPath = "CharacterInfoEx/CharSystemPresetPotentialPanel.prefab",
    sCtrlName = "Game.UI.CharacterInfoEx.CharPotentialPresetCtrl"
  }
}
return CharSystemPresetPotentialPanel
