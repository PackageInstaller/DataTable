local ChangeGenderPanel = class("ChangeGenderPanel", BasePanel)
ChangeGenderPanel._bAddToBackHistory = false
ChangeGenderPanel._tbDefine = {
  {
    sPrefabPath = "ChangeGender/ChangeGender.prefab",
    sCtrlName = "Game.UI.ChangeGender.ChangeGenderCtrl"
  }
}
return ChangeGenderPanel
