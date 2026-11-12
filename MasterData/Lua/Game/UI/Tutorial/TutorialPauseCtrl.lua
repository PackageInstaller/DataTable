local TutorialPauseCtrl = class("TutorialPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TutorialPauseCtrl._mapNodeConfig = {
  Blur = {
    sNodeName = "t_fullscreen_blur_black"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_black",
    sComponentName = "Animator"
  },
  PausePanel = {},
  Pause_animator = {sNodeName = "PausePanel", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Title"
  },
  txtContent = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_ExitTips"
  },
  btnContinue = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Continue",
    sAction = "Back",
    sActionIconType = "Dark"
  },
  txtContinue = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_Continue"
  },
  btnExit = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Exit",
    sAction = "Giveup",
    sActionIconType = "Dark"
  },
  txtExit = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Tutorial_Exit"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Continue"
  }
}
TutorialPauseCtrl._mapEventConfig = {TutorialPause = "Pause"}
TutorialPauseCtrl._mapRedDotConfig = {}

function TutorialPauseCtrl:Awake()
  self._mapNode.Blur:SetActive(false)
  self._mapNode.PausePanel:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function TutorialPauseCtrl:PauseLogic()
  EventManager.Hit("BattlePause")
  PanelManager.InputDisable()
end

function TutorialPauseCtrl:ResumeLogic()
  PanelManager.InputEnable()
end

function TutorialPauseCtrl:Pause()
  self:PauseLogic()
  self._mapNode.Blur:SetActive(true)
  self._mapNode.PausePanel:SetActive(true)
  self._mapNode.Pause_animator:Play("t_window_04_t_in")
  self._mapNode.aniBlur:Play("t_in")
  GamepadUIManager.EnableGamepadUI("TutorialPauseCtrl", self.tbGamepadUINode)
end

function TutorialPauseCtrl:OnBtnClick_Continue()
  self._mapNode.Pause_animator:Play("t_window_04_t_out")
  self._mapNode.aniBlur:Play("t_out")
  self:AddTimer(1, 0.16, function()
    self:ResumeLogic()
    self._mapNode.Blur:SetActive(false)
    self._mapNode.PausePanel:SetActive(false)
    self.bIsPause = false
    GamepadUIManager.DisableGamepadUI("TutorialPauseCtrl")
  end, true, true, true)
end

function TutorialPauseCtrl:OnBtnClick_Exit()
  self._mapNode.Pause_animator:Play("t_window_04_t_out")
  self._mapNode.aniBlur:Play("t_out")
  self:AddTimer(1, 0.16, function()
    self:ResumeLogic()
    PlayerData.TutorialData:FinishLevel(false)
    self._mapNode.Blur:SetActive(false)
    self._mapNode.PausePanel:SetActive(false)
    GamepadUIManager.DisableGamepadUI("TutorialPauseCtrl")
  end, true, true, true)
end

return TutorialPauseCtrl
