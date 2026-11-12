local JointDrillBattleMenuCtrl = class("JointDrillBattleMenuCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
JointDrillBattleMenuCtrl._mapNodeConfig = {
  canvas_group = {
    sComponentName = "CanvasGroup",
    sNodeName = "----SafeAreaRoot----"
  },
  btnPause = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Pause"
  },
  BtnBg = {}
}
JointDrillBattleMenuCtrl._mapEventConfig = {
  InputEnable = "OnEvent_InputEnable",
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  JointDrill_StopTime = "OnEvent_JointDrill_StopTime",
  JointDrill_ShowPauseBnt_Editor = "OnEvent_ShowPauseBntEditor",
  JointDrill_Level_TimeOut = "OnEvent_LevelTimeOut"
}

function JointDrillBattleMenuCtrl:OnEnable()
  self._mapNode.BtnBg.gameObject:SetActive(false)
  GamepadUIManager.AddGamepadUINode("BattleMenu", self:GetGamepadUINode())
end

function JointDrillBattleMenuCtrl:OnDisable()
end

function JointDrillBattleMenuCtrl:OnBtn_Pause()
  EventManager.Hit("BattlePause")
end

function JointDrillBattleMenuCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvas_group, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvas_group, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvas_group, bEnable == true)
  self._mapNode.btnPause.interactable = bEnable == true
end

function JointDrillBattleMenuCtrl:OnEvent_LoadLevelRefresh()
  self._mapNode.BtnBg.gameObject:SetActive(true)
end

function JointDrillBattleMenuCtrl:OnEvent_JointDrill_StopTime()
  self._mapNode.BtnBg.gameObject:SetActive(false)
end

function JointDrillBattleMenuCtrl:OnEvent_LevelTimeOut()
  self._mapNode.BtnBg.gameObject:SetActive(false)
end

function JointDrillBattleMenuCtrl:OnEvent_ShowPauseBntEditor()
  self._mapNode.BtnBg.gameObject:SetActive(true)
  self._mapNode.btnPause.gameObject:GetComponent("NaviButton").enabled = true
end

return JointDrillBattleMenuCtrl
