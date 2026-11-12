local MainBattleMenuCtrl = class("MainBattleMenuCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local AdventureModuleHelper = CS.AdventureModuleHelper
MainBattleMenuCtrl._mapNodeConfig = {
  canvas_group = {
    sComponentName = "CanvasGroup"
  },
  trMiniMapBg = {sComponentName = "Transform"},
  btnMiniMap = {
    sComponentName = "ButtonEx",
    callback = "OnBtn_MiniMap"
  },
  rawImgMiniMap = {sComponentName = "RawImage"},
  btnPause = {
    sComponentName = "NaviButton",
    callback = "OnBtn_Pause"
  },
  btnFullMap = {
    sComponentName = "ButtonEx",
    callback = "OnBtn_FullMap"
  },
  trFullMap = {sNodeName = "btnFullMap", sComponentName = "Transform"},
  rawImgFullMap = {sComponentName = "RawImage"}
}
MainBattleMenuCtrl._mapEventConfig = {
  InputEnable = "OnEvent_InputEnable",
  MainBattleMenuBtnPauseActive = "OnEvent_MainBattleMenuBtnPauseActive",
  RegionBoss_Success = "OnEvent_RegionBossSuccess",
  Region_Boss_PlayerDied = "OnEvent_RegionBossPlayerDied"
}
local bOpenMiniMap = false

function MainBattleMenuCtrl:OnEnable()
  if bOpenMiniMap == true then
    AdventureModuleHelper.SetMiniMapFeatureActive(true)
    self._mapNode.trMiniMapBg.localScale = Vector3.one
    self._mapNode.trFullMap.localScale = Vector3.zero
    NovaAPI.SetTexture(self._mapNode.rawImgMiniMap, AdventureModuleHelper.GetMiniMapRenderTexture())
    NovaAPI.SetTexture(self._mapNode.rawImgFullMap, AdventureModuleHelper.GetMapRenderTexture())
    AdventureModuleHelper.SetMapCameraActive(false)
  end
  GamepadUIManager.AddGamepadUINode("BattleMenu", self:GetGamepadUINode())
end

function MainBattleMenuCtrl:OnDisable()
  if bOpenMiniMap == true then
    NovaAPI.SetTexture(self._mapNode.rawImgMiniMap, nil)
    NovaAPI.SetTexture(self._mapNode.rawImgFullMap, nil)
  end
end

function MainBattleMenuCtrl:OnBtn_Pause()
  EventManager.Hit("BattlePause")
  EventManager.Hit(EventId.PasueAvgBubble, true)
end

function MainBattleMenuCtrl:OnBtn_MiniMap()
  if bOpenMiniMap == true then
    EventManager.Hit(EventId.BattleDashboardVisible, false)
    self._mapNode.trMiniMapBg.localScale = Vector3.zero
    self._mapNode.trFullMap.localScale = Vector3.one
    AdventureModuleHelper.SetMapCameraActive(true)
  end
end

function MainBattleMenuCtrl:OnBtn_FullMap()
  if bOpenMiniMap == true then
    EventManager.Hit(EventId.BattleDashboardVisible, true)
    self._mapNode.trMiniMapBg.localScale = Vector3.one
    self._mapNode.trFullMap.localScale = Vector3.zero
    AdventureModuleHelper.SetMapCameraActive(false)
  end
end

function MainBattleMenuCtrl:OnEvent_InputEnable(bEnable, bEnableByTrans)
  if bEnableByTrans == true then
    if bEnable == true and self.ENABLE == false then
      return
    end
  else
    self.ENABLE = bEnable
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvas_group, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvas_group, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvas_group, bEnable == true)
  self._mapNode.btnPause.interactable = bEnable == true
end

function MainBattleMenuCtrl:OnEvent_MainBattleMenuBtnPauseActive(bActive)
  self._mapNode.btnPause.gameObject:SetActive(bActive)
end

function MainBattleMenuCtrl:OnEvent_RegionBossSuccess()
  self._mapNode.btnPause.gameObject:SetActive(false)
end

function MainBattleMenuCtrl:OnEvent_RegionBossPlayerDied()
  self._mapNode.btnPause.gameObject:SetActive(false)
end

return MainBattleMenuCtrl
