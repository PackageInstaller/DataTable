local BreakOutPauseCtrl = class("BreakOutPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
BreakOutPauseCtrl._mapNodeConfig = {
  blur = {},
  txt_title = {
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Text_Pause"
  },
  txt_exit = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Button_Leave"
  },
  txt_restart = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Button_Re"
  },
  txt_continue = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Button_Back"
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
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  }
}
BreakOutPauseCtrl._mapEventConfig = {Open_BattlePause = "Open", Close_BattlePause = "Close"}
BreakOutPauseCtrl._mapRedDotConfig = {}

function BreakOutPauseCtrl:Awake()
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.bInOpen = false
end

function BreakOutPauseCtrl:Open()
  if self.bInOpen == true then
    return
  end
  self._mapNode.safeAreaRoot:SetActive(true)
  self.bInOpen = true
  EventManager.Hit("Event_SetPopPlayTips", false)
  PanelManager.InputDisable()
  EventManager.Hit("SetBreakOutPlaySkill_Visible", false)
  GamepadUIManager.EnableGamepadUI("BreakOutPauseCtrl", self.tbGamepadUINode)
end

function BreakOutPauseCtrl:Close()
  if self.bInOpen == false then
    return
  end
  self.bInOpen = false
  GamepadUIManager.DisableGamepadUI("BreakOutPauseCtrl")
  EventManager.Hit("Event_SetPopPlayTips", true)
  self._mapNode.safeAreaRoot:SetActive(false)
  PanelManager.InputEnable()
  EventManager.Hit("SetBreakOutPlaySkill_Visible", true)
end

function BreakOutPauseCtrl:OnBtnClick_Exit()
  EventManager.Hit("BreakOut_Exit_OnClick")
end

function BreakOutPauseCtrl:OnBtnClick_Restart()
  EventManager.Hit("BreakOut_Restart_OnClick")
end

function BreakOutPauseCtrl:OnBtnClick_Continue()
  EventManager.Hit("BreakOut_Continue_OnClick")
end

return BreakOutPauseCtrl
