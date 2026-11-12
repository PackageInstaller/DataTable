local StarTowerAutoDecisionHUDCtrl = class("StarTowerAutoDecisionHUDCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local Time = CS.UnityEngine.Time
local TimerManager = require("GameCore.Timer.TimerManager")
local StarTowerSettingGate = require("Game.Adventure.StarTower.StarTowerSettingGate")
local StarTowerAutoDecision = require("Game.Adventure.StarTower.StarTowerAutoDecision")
local AUTO_INPUT_LAYER = "StarTowerAutoDecisionHUDCtrl"
local LOCKED_TIPS_INTERVAL = 0.8
local AUTO_SWITCH_COOLDOWN = 0.25
local mapPauseKeyboardInput = {
  enter = true,
  numpadEnter = true,
  space = true
}
StarTowerAutoDecisionHUDCtrl._mapNodeConfig = {
  rtAutoOpen = {
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerAutoDecisionPhoneCtrl"
  },
  animAutoOpen = {sNodeName = "rtAutoOpen", sComponentName = "Animator"},
  rtAutoBattle = {
    sCtrlName = "Game.UI.StarTowerFastBattle.StarTowerAutoDecisionPhoneCtrl"
  },
  animAutoBattle = {
    sNodeName = "rtAutoBattle",
    sComponentName = "Animator"
  },
  rtAutoBattleShortcut = {
    sNodeName = "rtAutoBattle",
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Stop"
  },
  goAutoInputBlock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_InputBlock"
  },
  btnAutoOn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AutoOn"
  },
  btnStop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Stop"
  },
  txtAutoOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_Enable"
  },
  btnOpenSetting = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenSetting"
  },
  txtAutoSearch = {
    sComponentName = "TMP_Text",
    sLanguageId = "AutoDecision_Ongoing"
  }
}
StarTowerAutoDecisionHUDCtrl._mapEventConfig = {
  StarTowerAutoDecisionStateChanged = "OnEvent_AutoDecisionStateChanged",
  StarTowerAutoDecisionSettingStateChanged = "OnEvent_AutoDecisionSettingStateChanged",
  OpenStarTowerDepot = "OnEvent_OpenStarTowerDepot",
  CloseStarTowerDepot = "OnEvent_CloseStarTowerDepot",
  LuaEventName_KeyboardButtonPress = "OnEvent_KeyboardButtonPress",
  LuaEventName_MouseButtonPress = "OnEvent_MouseButtonPress",
  LuaEventName_GamepadButtonPress = "OnEvent_GamepadButtonPress"
}

function StarTowerAutoDecisionHUDCtrl:Awake()
  self._bInputLocked = false
  self._bDepotOpen = false
  self._nNextLockedTipsTime = 0
  self._nNextSettingBusyTipsTime = 0
end

function StarTowerAutoDecisionHUDCtrl:OnEnable()
  self._bSettingOpen = PanelManager.CheckPanelOpen(PanelId.StarTowerAutoDecisionSettingPanel)
  self.canvas = self.gameObject.transform:GetComponent("Canvas")
  NovaAPI.SetCanvasOverrideSorting(self.canvas, true)
  NovaAPI.SetCanvasSortingName(self.canvas, AllEnum.SortingLayerName.UI_Top)
  NovaAPI.SetCanvasSortingOrder(self.canvas, AllEnum.UI_SORTING_ORDER.StarTowerAutoDecisionHUD)
  self:Refresh()
end

function StarTowerAutoDecisionHUDCtrl:OnDisable()
  TimerManager.Remove(self._timerAutoOpenHide, false)
  TimerManager.Remove(self._timerAutoBattleHide, false)
  TimerManager.Remove(self._timerAutoSwitch, false)
  self._timerAutoOpenHide = nil
  self._timerAutoBattleHide = nil
  self._timerAutoSwitch = nil
  self._mapNode.rtAutoOpen.gameObject:SetActive(false)
  self._mapNode.rtAutoBattle.gameObject:SetActive(false)
  self:SetInputLocked(false)
end

function StarTowerAutoDecisionHUDCtrl:RefreshAutoNode(sNodeName, sAnimatorName, sAnimationPrefix, sTimerName, bVisible)
  local objCtrl = self._mapNode[sNodeName]
  local animator = self._mapNode[sAnimatorName]
  if self._bSettingOpen then
    TimerManager.Remove(self[sTimerName], false)
    self[sTimerName] = nil
    objCtrl.gameObject:SetActive(false)
    return
  end
  if bVisible then
    local bPlayIn = self[sTimerName] ~= nil or not objCtrl.gameObject.activeSelf
    TimerManager.Remove(self[sTimerName], false)
    self[sTimerName] = nil
    objCtrl.gameObject:SetActive(true)
    if bPlayIn then
      animator:Play(sAnimationPrefix .. "_in", 0, 0)
    end
    objCtrl:Refresh()
  elseif objCtrl.gameObject.activeSelf and self[sTimerName] == nil then
    animator:Play(sAnimationPrefix .. "_out", 0, 0)
    self[sTimerName] = self:AddTimer(1, 0.2, function()
      self[sTimerName] = nil
      objCtrl.gameObject:SetActive(false)
    end, true, true, true)
    if self[sTimerName] == nil then
      objCtrl.gameObject:SetActive(false)
    end
  end
end

function StarTowerAutoDecisionHUDCtrl:CanUseAutoOpenButtons(bSetting)
  local objLevelData = self._panel.LevelData
  return self._timerAutoSwitch == nil and not self._bDepotOpen and not self._bSettingOpen and not self._bInputLocked and objLevelData ~= nil and objLevelData.bEnd ~= true and not objLevelData:IsAutoDecisionEnabled() and (bSetting or not objLevelData:IsAutoDecisionBusy())
end

function StarTowerAutoDecisionHUDCtrl:RefreshButtonInteractable()
  local bInteractable = self._timerAutoSwitch == nil and not self._bDepotOpen
  local bAutoOpenInteractable = self:CanUseAutoOpenButtons()
  self._mapNode.btnAutoOn.interactable = bAutoOpenInteractable
  self._mapNode.btnOpenSetting.interactable = self:CanUseAutoOpenButtons(true)
  self._mapNode.btnStop.interactable = bInteractable and self._bInputLocked
  self._mapNode.rtAutoBattleShortcut.interactable = bInteractable and self._bInputLocked
end

function StarTowerAutoDecisionHUDCtrl:StartSwitchCooldown()
  self._timerAutoSwitch = self:AddTimer(1, AUTO_SWITCH_COOLDOWN, function()
    self._timerAutoSwitch = nil
    self:RefreshButtonInteractable()
  end, true, true, true)
  self:RefreshButtonInteractable()
end

function StarTowerAutoDecisionHUDCtrl:Refresh(bEnabled)
  if type(bEnabled) ~= "boolean" then
    bEnabled = self._panel.LevelData ~= nil and self._panel.LevelData:IsAutoDecisionEnabled()
  end
  local bOpen = not self._bDepotOpen and not bEnabled
  local bBattle = not self._bDepotOpen and bEnabled
  if not bEnabled then
    self:SetInputLocked(false)
  end
  self:RefreshAutoNode("rtAutoOpen", "animAutoOpen", "StarTowerAutoOpen", "_timerAutoOpenHide", bOpen)
  self:RefreshAutoNode("rtAutoBattle", "animAutoBattle", "StarTowerAutoBattle", "_timerAutoBattleHide", bBattle)
  if bEnabled then
    self:SetInputLocked(true)
  end
  self:RefreshButtonInteractable()
end

function StarTowerAutoDecisionHUDCtrl:SetInputLocked(bLocked)
  bLocked = bLocked == true
  self._mapNode.goAutoInputBlock.gameObject:SetActive(bLocked)
  if self._bInputLocked == bLocked then
    return
  end
  self._bInputLocked = bLocked
  if bLocked then
    GamepadUIManager.EnableGamepadUI(AUTO_INPUT_LAYER, {
      {
        mapNode = self._mapNode.rtAutoBattleShortcut,
        sComponentName = "NaviButton",
        sAction = "buttonSouth"
      }
    }, self._mapNode.rtAutoBattleShortcut.gameObject, false, false, AllEnum.UI_SORTING_ORDER.StarTowerAutoDecisionHUD)
  else
    GamepadUIManager.DisableGamepadUI(AUTO_INPUT_LAYER)
  end
end

function StarTowerAutoDecisionHUDCtrl:ShowInputLockedTips()
  if not self._bInputLocked then
    return
  end
  local nNow = Time.realtimeSinceStartup
  if nNow < self._nNextLockedTipsTime then
    return
  end
  self._nNextLockedTipsTime = nNow + LOCKED_TIPS_INTERVAL
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("AutoDecision_InputLocked"))
end

function StarTowerAutoDecisionHUDCtrl:OnEvent_AutoDecisionStateChanged(mapState)
  if type(mapState) ~= "table" then
    self:Refresh()
    return
  end
  local bEnabled = mapState.bEnabled == true and mapState.bPaused ~= true
  self:Refresh(bEnabled)
  if mapState.nFailReason == StarTowerAutoDecision.FailReason.TokenNotEnough then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("AutoDecision_InsufficientToken"))
  end
end

function StarTowerAutoDecisionHUDCtrl:OnEvent_OpenStarTowerDepot()
  self._bDepotOpen = true
  self:Refresh()
end

function StarTowerAutoDecisionHUDCtrl:OnEvent_CloseStarTowerDepot()
  self._bDepotOpen = false
  self:Refresh()
end

function StarTowerAutoDecisionHUDCtrl:OnEvent_AutoDecisionSettingStateChanged(bOpen)
  self._bSettingOpen = bOpen == true
  self:Refresh()
end

function StarTowerAutoDecisionHUDCtrl:OnBtnClick_AutoOn()
  if not (self._mapNode.btnAutoOn.interactable and self:CanUseAutoOpenButtons()) or PanelManager.CheckPanelOpen(PanelId.StarTowerAutoDecisionSettingPanel) then
    return
  end
  self:StartSwitchCooldown()
  if PlayerData.StarTowerAutoPlan:GetTokenCount() <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("AutoDecision_InsufficientToken"))
    return
  end
  local bSuccess = self._panel.LevelData:SetAutoDecisionEnabled(true)
  if not bSuccess then
    TimerManager.Remove(self._timerAutoSwitch, false)
    self._timerAutoSwitch = nil
    self:RefreshButtonInteractable()
    self:OnBtnClick_OpenSetting()
  elseif self._panel.LevelData:IsAutoDecisionEnabled() then
    local nCurPlanId = PlayerData.StarTowerAutoPlan:GetSelectedPlanId()
    local sPlanName = PlayerData.StarTowerAutoPlan:GetPlanById(nCurPlanId).sName
    local sTip = orderedFormat(ConfigTable.GetUIText("AutoDecision_PlanActivatedTip"), sPlanName)
    EventManager.Hit(EventId.OpenMessageBox, sTip)
  end
end

function StarTowerAutoDecisionHUDCtrl:OnBtnClick_Stop()
  if not self._mapNode.btnStop.interactable then
    return
  end
  self:StartSwitchCooldown()
  self:SetInputLocked(false)
  if self._panel.LevelData ~= nil then
    self._panel.LevelData:SetAutoDecisionEnabled(false, true)
  end
end

function StarTowerAutoDecisionHUDCtrl:OnBtnClick_InputBlock()
  self:ShowInputLockedTips()
end

function StarTowerAutoDecisionHUDCtrl:OnBtnClick_OpenSetting()
  if not (self._mapNode.btnOpenSetting.interactable and self:CanUseAutoOpenButtons(true)) or PanelManager.CheckPanelOpen(PanelId.StarTowerAutoDecisionSettingPanel) then
    return
  end
  if not StarTowerSettingGate.CanOpen(self._panel.LevelData) or PanelManager.CheckPanelOpen(PanelId.StarTowerFastBattleLog) or PanelManager.CheckPanelOpen(PanelId.StarTowerShop) or PanelManager.CheckPanelOpen(PanelId.NoteSkillInfo) then
    local nNow = Time.realtimeSinceStartup
    if nNow >= self._nNextSettingBusyTipsTime then
      self._nNextSettingBusyTipsTime = nNow + LOCKED_TIPS_INTERVAL
      local sTips = ConfigTable.GetUIText("AutoDecision_SettingBusy")
      EventManager.Hit(EventId.OpenMessageBox, sTips)
    end
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerAutoDecisionSettingPanel)
end

function StarTowerAutoDecisionHUDCtrl:OnEvent_KeyboardButtonPress(mapInput)
  if not self._bInputLocked or mapPauseKeyboardInput[mapInput.name] then
    return
  end
  self:ShowInputLockedTips()
end

function StarTowerAutoDecisionHUDCtrl:OnEvent_MouseButtonPress(mapInput)
  if not self._bInputLocked or mapInput.name == "leftButton" or mapInput.name == "rightButton" then
    return
  end
  self:ShowInputLockedTips()
end

function StarTowerAutoDecisionHUDCtrl:OnEvent_GamepadButtonPress(mapInput)
  if not self._bInputLocked or mapInput.name == "buttonSouth" then
    return
  end
  self:ShowInputLockedTips()
end

return StarTowerAutoDecisionHUDCtrl
