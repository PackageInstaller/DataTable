local VampireMenuCtrl = class("VampireMenuCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local AdventureModuleHelper = CS.AdventureModuleHelper
VampireMenuCtrl._mapNodeConfig = {
  canvas_group = {
    sComponentName = "CanvasGroup",
    sNodeName = "----SafeAreaRoot----"
  },
  btnPause = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Pause"
  },
  btnBag = {sComponentName = "NaviButton", callback = "OnBtn_Bag"}
}
VampireMenuCtrl._mapEventConfig = {
  InputEnable = "OnEvent_InputEnable",
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh"
}
local bOpenMiniMap = false

function VampireMenuCtrl:OnEnable()
  self._mapNode.btnPause.gameObject:SetActive(false)
  self._mapNode.btnBag.gameObject:SetActive(false)
  GamepadUIManager.AddGamepadUINode("BattleMenu", self:GetGamepadUINode())
end

function VampireMenuCtrl:OnEvent_LoadLevelRefresh()
  self._mapNode.btnBag.gameObject:SetActive(true)
  self._mapNode.btnPause.gameObject:SetActive(true)
end

function VampireMenuCtrl:OnDisable()
end

function VampireMenuCtrl:OnBtn_Pause()
  EventManager.Hit("BattlePause")
end

function VampireMenuCtrl:OnBtn_Bag()
  EventManager.Hit("BattleDepot")
end

function VampireMenuCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvas_group, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvas_group, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvas_group, bEnable == true)
  self._mapNode.btnPause.interactable = bEnable == true
  self._mapNode.btnBag.interactable = bEnable == true
end

return VampireMenuCtrl
