local LoginPanel = class("LoginPanel", BasePanel)
LoginPanel._bAddToBackHistory = false
LoginPanel._tbDefine = {
  {
    sPrefabPath = "Login/LoginUI.prefab",
    sCtrlName = "Game.UI.Login.LoginCtrl"
  },
  {
    sPrefabPath = "Announcement/UIAnnouncementPanel.prefab",
    sCtrlName = "Game.UI.GameAnnouncement.AnnouncementCtrl"
  }
}
return LoginPanel
