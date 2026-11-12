local GoldenSpyPauseCtrl = class("GoldenSpyPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
GoldenSpyPauseCtrl._mapNodeConfig = {
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
  txt_dic = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_DicTitle"
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
  },
  btn_dic = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_OpenDic",
    sAction = "Depot",
    sActionIconType = "Dark"
  }
}
GoldenSpyPauseCtrl._mapEventConfig = {}
GoldenSpyPauseCtrl._mapRedDotConfig = {}

function GoldenSpyPauseCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function GoldenSpyPauseCtrl:Open(needShowDic)
  self.gameObject:SetActive(true)
  self._mapNode.btn_dic.gameObject:SetActive(needShowDic)
  GamepadUIManager.EnableGamepadUI("GoldenSpyPauseCtrl", self.tbGamepadUINode)
end

function GoldenSpyPauseCtrl:Close()
  GamepadUIManager.DisableGamepadUI("GoldenSpyPauseCtrl")
  self.gameObject:SetActive(false)
end

function GoldenSpyPauseCtrl:OnBtnClick_Exit()
  EventManager.Hit("GoldenSpy_Exit_OnClick")
end

function GoldenSpyPauseCtrl:OnBtnClick_Restart()
  EventManager.Hit("GoldenSpy_Restart_OnClick")
end

function GoldenSpyPauseCtrl:OnBtnClick_Continue()
  EventManager.Hit("GoldenSpy_Continue_OnClick")
end

function GoldenSpyPauseCtrl:OnBtnClick_OpenDic()
  EventManager.Hit("GoldenSpy_OpenDic_OnClick")
end

return GoldenSpyPauseCtrl
