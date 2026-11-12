local ReceiveSpecialRewardPanel = class("ReceiveSpecialRewardPanel", BasePanel)
ReceiveSpecialRewardPanel._bIsMainPanel = false
ReceiveSpecialRewardPanel._tbDefine = {
  {
    sPrefabPath = "CharacterSkin/ReceiveSpecialRewardPanel.prefab",
    sCtrlName = "Game.UI.CharacterSkin.ReceiveSpecialRewardCtrl"
  }
}
return ReceiveSpecialRewardPanel
