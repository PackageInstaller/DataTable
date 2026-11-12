local TowerDefensePauseCtrl = class("TowerDefensePauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TowerDefensePauseCtrl._mapNodeConfig = {
  blur = {},
  txt_title = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Text_Pause"
  },
  txt_exit = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Button_Leave"
  },
  txt_restart = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Button_Re"
  },
  txt_continue = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Button_Back"
  },
  btn_exit = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Exit",
    sAction = "Giveup",
    sActionIconType = "Dark"
  },
  btn_restart = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Restart",
    sAction = "Retry",
    sActionIconType = "Dark"
  },
  btn_continue = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Continue",
    sAction = "Back",
    sActionIconType = "Dark"
  }
}
TowerDefensePauseCtrl._mapEventConfig = {}
TowerDefensePauseCtrl._mapRedDotConfig = {}

function TowerDefensePauseCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function TowerDefensePauseCtrl:Open()
  self.gameObject:SetActive(true)
  GamepadUIManager.EnableGamepadUI("TowerDefensePauseCtrl", self.tbGamepadUINode)
end

function TowerDefensePauseCtrl:Close()
  GamepadUIManager.DisableGamepadUI("TowerDefensePauseCtrl")
  self.gameObject:SetActive(false)
end

function TowerDefensePauseCtrl:OnBtnClick_Exit()
  EventManager.Hit("TowerDefense_Exit_OnClick")
end

function TowerDefensePauseCtrl:OnBtnClick_Restart()
  EventManager.Hit("TowerDefense_Restart_OnClick")
end

function TowerDefensePauseCtrl:OnBtnClick_Continue()
  EventManager.Hit("TowerDefense_Continue_OnClick")
end

return TowerDefensePauseCtrl
