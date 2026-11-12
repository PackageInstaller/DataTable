local TrialMenuCtrl = class("TrialMenuCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TrialMenuCtrl._mapNodeConfig = {
  canvas_group = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "CanvasGroup"
  },
  btnPause = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Pause"
  },
  btnBag = {sComponentName = "NaviButton", callback = "OnBtn_Bag"}
}
TrialMenuCtrl._mapEventConfig = {
  TrialSetButtonEnable = "OnEvent_TrialSetButtonEnable",
  InputEnable = "OnEvent_InputEnable"
}

function TrialMenuCtrl:OnEnable()
  GamepadUIManager.AddGamepadUINode("BattleMenu", self:GetGamepadUINode())
end

function TrialMenuCtrl:OnDisable()
end

function TrialMenuCtrl:OnBtn_Pause()
  EventManager.Hit("BattlePause")
  EventManager.Hit(EventId.PasueAvgBubble, true)
end

function TrialMenuCtrl:OnBtn_Bag()
  EventManager.Hit("TrialDepot")
end

function TrialMenuCtrl:OnEvent_TrialSetButtonEnable(bShow, bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvas_group, bShow == true and 1 or 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvas_group, bShow == true)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvas_group, bShow == true)
  self._mapNode.btnPause.interactable = bEnable == true
  self._mapNode.btnBag.interactable = bEnable == true
end

function TrialMenuCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvas_group, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvas_group, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvas_group, bEnable == true)
  self._mapNode.btnPause.interactable = bEnable == true
  self._mapNode.btnBag.interactable = bEnable == true
end

return TrialMenuCtrl
