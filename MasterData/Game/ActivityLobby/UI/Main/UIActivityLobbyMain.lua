local base = UIBaseWindow
local UIActivityLobbyMain = class("UIActivityLobbyMain", base)
local UINActLbInteract = require("Game.ActivityLobby.UI.Main.Interact.UINActLbInteract")
local UINActLbQuickEntrance = require("Game.ActivityLobby.UI.Main.QuickEntrance.UINActLbQuickEntrance")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")
local UINActivityTimer = require("Game.ActivityFrame.UI.UINActivityTimer")
local CS_ResLoader = CS.ResLoader
local needShowActTime = {
  [ActLbEnum.LobbyMainType.Common] = false,
  [ActLbEnum.LobbyMainType.SteinsGate] = true
}
local interactName = {
  [ActLbEnum.LobbyMainType.Common] = "CommonInteract",
  [ActLbEnum.LobbyMainType.SteinsGate] = "SteinsGateInteract"
}
local interactRequireName = {
  [ActLbEnum.LobbyMainType.Common] = "Game.ActivityLobby.UI.Main.Interact.UINActLbInteract",
  [ActLbEnum.LobbyMainType.SteinsGate] = "Game.ActivityLobby.UI.Main.Interact.SteinsGate23.UINActSGLbInteract"
}
local quickCheckName = {
  [ActLbEnum.LobbyMainType.Common] = "CommonQuickCheck",
  [ActLbEnum.LobbyMainType.SteinsGate] = "SteinsGateQuickCheck"
}
local quickCheckRequireName = {
  [ActLbEnum.LobbyMainType.Common] = "Game.ActivityLobby.UI.Main.QuickEntrance.QuickCheck.UINCommonQuickCheck",
  [ActLbEnum.LobbyMainType.SteinsGate] = "Game.ActivityLobby.UI.Main.QuickEntrance.QuickCheck.UINSteinsGateQuickCheck"
}
local quickEntranceListName = {
  [ActLbEnum.LobbyMainType.Common] = "CommonQuickEntranceList",
  [ActLbEnum.LobbyMainType.SteinsGate] = "SteinsGateQuickEntranceList"
}
local quickEntranceRequireName = {
  [ActLbEnum.LobbyMainType.Common] = "Game.ActivityLobby.UI.Main.QuickEntrance.UINActLbQuickEntrance",
  [ActLbEnum.LobbyMainType.SteinsGate] = "Game.ActivityLobby.UI.Main.QuickEntrance.UINActSGLbQuickEntrance"
}
local joystickPathDic = {
  [ActLbEnum.LobbyMainType.Common] = "Res/UIPrefabs/Common/UINJoystick.prefab",
  [ActLbEnum.LobbyMainType.SteinsGate] = "Res/UIPrefabs/Common/UI_SteinsGateJoystick.prefab"
}

function UIActivityLobbyMain:OnInit()
  self._resLoader = CS_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.btn_View, self, self._OnClickHideUI)
  self.OnClickQuickEntrance = BindCallback(self, self._OnClickQuickEntrance)
  self._resourceGroup = UINResourceGroup.New()
  self._resourceGroup:Init(self.ui.gameResourceGroup)
  self._actTimerNode = UINActivityTimer.New()
  self._actTimerNode:Init(self.ui.obj_time)
  self._actTimerNode:Hide()
end

function UIActivityLobbyMain:InitActLobbyMain(actLbCtrl)
  self._actLbCtrl = actLbCtrl
  self.mainType = actLbCtrl:GetMainType()
  local actLbCfg = actLbCtrl:GetActLbCfg()
  self._actLbCfg = actLbCfg
  local topData = UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._OnClickReturn):SetTopStatusVisible(true)
  if actLbCfg.guide_id > 0 then
    topData:SetTopStatusInfoFunc(function()
      GuidePicture.OpenGuidePicture(actLbCfg.guide_id, nil)
    end)
  end
  topData:PushTopStatusDataToBackStack(true)
  local actId = ConfigData.activity_lobby_index.lobbyToActDic[actLbCfg.lobby_id]
  self._actFrameData = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true):GetActivityFrameData(actId)
  if self._actFrameData then
    TimerManager:StopTimer(self._timerId)
    self._timerId = TimerManager:StartTimer(1, self.__TimerCountdown, self)
    self:__TimerCountdown()
  end
  self:UpdActLbTopRes()
  self:LodeActLbMainNode()
end

function UIActivityLobbyMain:LodeActLbMainNode()
  local quickCheckPrefabName = quickCheckName[self.mainType]
  local quickCheckPrefabPath = PathConsts:GetActivityLobbyMainUIPrefab(quickCheckPrefabName)
  self._resLoader:LoadABAssetAsync(quickCheckPrefabPath, BindCallback(self, self._OnLoadedQuickCheckPrefabs))
  local quickEntrancePrefabName = quickEntranceListName[self.mainType]
  local quickEntrancePrefabPath = PathConsts:GetActivityLobbyMainUIPrefab(quickEntrancePrefabName)
  self._resLoader:LoadABAssetAsync(quickEntrancePrefabPath, BindCallback(self, self._OnLoadedQuickEntrancePrefabs))
  local joystickPath = joystickPathDic[self.mainType]
  if joystickPath == nil then
    error("cant get joystickPathDic, type = " .. tostring(self.mainType))
  else
    self._resLoader:LoadABAssetAsync(joystickPath, BindCallback(self, self._OnLoadedJoystick))
  end
  local interactPrefabName = interactName[self.mainType]
  local interactPrefabPath = PathConsts:GetActivityLobbyMainUIPrefab(interactPrefabName)
  self._resLoader:LoadABAssetAsync(interactPrefabPath, BindCallback(self, self._OnLoadedInteractPrefabs))
end

function UIActivityLobbyMain:_OnLoadedInteractPrefabs(prefabGo)
  if IsNull(self.transform) then
    return
  end
  local go = prefabGo:Instantiate(self.ui.interactNode.transform)
  go.transform.anchoredPosition = Vector2.zero
  local objReq = require(interactRequireName[self.mainType])
  self.actLbIntrctNode = objReq.New()
  self.actLbIntrctNode:Init(go)
end

function UIActivityLobbyMain:_OnLoadedQuickCheckPrefabs(prefabGo)
  if IsNull(self.transform) then
    return
  end
  local go = prefabGo:Instantiate(self.ui.obj_quickCheckNode.transform)
  go.transform.anchoredPosition = Vector2.zero
  local objReq = require(quickCheckRequireName[self.mainType])
  self.quickCheck = objReq.New()
  self.quickCheck:Init(go)
  self.quickCheck:InitUINQuickCheck(self._actLbCtrl, self.OnClickQuickEntrance)
  if not self._aniCompleteFlag then
    self.quickCheck:Hide()
  end
end

function UIActivityLobbyMain:_OnLoadedQuickEntrancePrefabs(prefabGo)
  if IsNull(self.transform) then
    return
  end
  local go = prefabGo:Instantiate(self.ui.obj_quickEntranceListNode.transform)
  go.transform.anchoredPosition = Vector2.zero
  local objReq = require(quickEntranceRequireName[self.mainType])
  self.quickEntranceNode = objReq.New()
  self.quickEntranceNode:Init(go)
  self.quickEntranceNode:SetActivityShareId(self._actLbCfg.share_id)
  self.quickEntranceNode:Hide()
end

function UIActivityLobbyMain:_OnLoadedJoystick(prefabGo)
  if IsNull(self.transform) then
    return
  end
  self.ui.joystickHolder.gameObject:SetActive(false)
  local go = prefabGo:Instantiate(self.ui.joystickHolder)
  go.transform.anchoredPosition = Vector2.zero
  go.transform.pivot = Vector2.Temp(0.5, 0.5)
  go.transform.anchorMax = Vector2.Temp(0.5, 0.5)
  go.transform.anchorMin = Vector2.Temp(0.5, 0.5)
  go.transform.sizeDelta = self.ui.joystickHolder.sizeDelta
  local joystick = go:GetComponent(typeof(CS.Joystick))
  joystick:onTouchMove("+", BindCallback(self, self._OnJoyStickMove))
  joystick:onTouchUp("+", BindCallback(self, self._OnJoyStickUp))
  self.ui.joystickHolder.gameObject:SetActive(true)
end

function UIActivityLobbyMain:IsLodeCompleted()
  return self.quickCheck ~= nil and self.quickEntranceNode ~= nil and self.actLbIntrctNode ~= nil
end

function UIActivityLobbyMain:GetQuickCheckItem()
  return self.quickCheck
end

function UIActivityLobbyMain:UpdActLbTopRes()
  local resList = self._actLbCfg.top_res
  if #self._actLbCfg.end_top_tes > 0 and self._actFrameData and self._actFrameData:GetActivityEndTime() <= PlayerDataCenter.timestamp then
    resList = self._actLbCfg.end_top_tes
  end
  self._resourceGroup:SetResourceIds(resList, true)
end

function UIActivityLobbyMain:TryActLbGuide(callback)
  if not self._actLbCtrl:IsFirstEnterActLb() then
    if callback ~= nil then
      callback()
    end
    return
  end
  local actLbCfg = self._actLbCtrl:GetActLbCfg()
  if actLbCfg.guide_id > 0 then
    GuidePicture.OpenGuidePicture(actLbCfg.guide_id, callback)
  elseif callback ~= nil then
    callback()
  end
end

function UIActivityLobbyMain:PlayQuickAni()
  if self.quickCheck then
    self.quickCheck:Show()
  end
  self.ui.ani_quick:Play()
  self._aniCompleteFlag = true
  self:__ShowLobbyShareTip()
end

function UIActivityLobbyMain:__TimerCountdown()
  local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self._actFrameData)
  local dayStr, diff = ActivityFrameUtil.GetCountdownTimeStr(expireTime)
  if diff < 0 then
    TimerManager:StopTimer(self._timerId)
  end
  local followWin = UIManager:GetWindow(UIWindowTypeID.ActLbFollowInfo)
  if followWin then
    local infoItem = followWin:GetActLbFollowInfoItem(self._actLbCfg.time_obj)
    if infoItem then
      infoItem:UpdActLbEntiInfoItemActTimer(title, timeStr, dayStr)
    end
  end
  if self.quickEntranceNode then
    self.quickEntranceNode:UpdActLbQuickEntranceActTimer(title, timeStr, dayStr)
  end
  if needShowActTime[self.mainType] then
    self._actTimerNode:Show()
    self._actTimerNode:UpdActTimer(title, timeStr, dayStr)
  end
end

function UIActivityLobbyMain:__ShowLobbyShareTip()
  local shareId = self._actLbCfg.share_id
  if shareId == nil or shareId == 0 then
    return
  end
  local shareCfg = ConfigData.share[shareId]
  if shareCfg == nil then
    error("Cant get shareCfg, id:" .. tostring(shareId))
    return
  end
  if not ControllerManager:GetController(ControllerTypeId.Share, true):CanGetShareReward(shareId) then
    return
  end
  for itemId, itemNum in pairs(shareCfg.reward) do
    if self.quickCheck then
      self.quickCheck:SetShareItem(itemId, itemNum)
      self.quickCheck:ShowShareTip(true)
    end
    self._hideTipsTimer = TimerManager:StartTimer(self.ui.hideTipsTime, function()
      if IsNull(self.transform) then
        return
      end
      if self.quickCheck then
        self.quickCheck:ShowShareTip(false)
      end
    end)
    break
  end
end

function UIActivityLobbyMain:__HideLobbyShareTip()
  if self.quickCheck then
    self.quickCheck:ShowShareTip(false)
  end
  TimerManager:StopTimer(self._hideTipsTimer)
end

function UIActivityLobbyMain:SetActLbMainJoyStickFunc(joystickMoveAction, joystickUpAction)
  self.__joyStickMoveAction = joystickMoveAction
  self.__joystickUpAction = joystickUpAction
end

function UIActivityLobbyMain:_OnJoyStickMove(moveData)
  if self.__joyStickMoveAction ~= nil then
    self.__joyStickMoveAction(moveData)
  end
end

function UIActivityLobbyMain:_OnJoyStickUp()
  if self.__joystickUpAction ~= nil then
    self.__joystickUpAction()
  end
end

function UIActivityLobbyMain:ShowQuickEntranceBlueDot(isShow)
  if self.quickCheck then
    self.quickCheck:ShowQuickEntranceBlueDot(isShow)
  end
end

function UIActivityLobbyMain:_OnClickQuickEntrance()
  self:__HideLobbyShareTip()
  local actionList = self._actLbCtrl.actLbIntrctCtrl:GetActLbQuickEntranceActionList()
  self.quickEntranceNode:InitLbQuickEntrance(actionList, BindCallback(self, self.QuickEntranceEnterAndExitAction))
end

function UIActivityLobbyMain:QuickEntranceEnterAndExitAction(bool)
  self.ui.gameResourceGroup:SetActive(not bool)
  self.ui.btn_View.gameObject:SetActive(not bool)
  self.ui.obj_time:SetActive(not bool)
  if self.quickCheck == nil then
    return
  end
  if bool then
    self.quickCheck:Hide()
  else
    self.quickCheck:Show()
  end
end

function UIActivityLobbyMain:_OnClickHideUI()
  self._actLbCtrl:ShowActLbUI(false)
end

function UIActivityLobbyMain:SetBlackAdapterShow(bool)
  self.ui.obj_adapter:SetActive(bool)
end

function UIActivityLobbyMain:_OnClickReturn(toHome)
  ActLbUtil.ExitActivityLobby(toHome)
end

function UIActivityLobbyMain:OnShow()
  if self._aniCompleteFlag then
    local aniLength = self.ui.ani_quick.clip.length
    local item = self.ui.ani_quick:get_Item("UI_ActivityLobbyMainQuickCheck")
    item.enabled = true
    item.time = aniLength
    self.ui.ani_quick:Sample()
    self._aniCompleteFlag = false
  end
end

function UIActivityLobbyMain:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  if self.quickCheck then
    self.quickCheck:Delete()
    self.quickCheck = nil
  end
  TimerManager:StopTimer(self._timerId)
  self:__HideLobbyShareTip()
  if self.actLbIntrctNode then
    self.actLbIntrctNode:Delete()
    self.actLbIntrctNode = nil
  end
  if self.quickEntranceNode then
    self.quickEntranceNode:Delete()
    self.quickEntranceNode = nil
  end
  self._resourceGroup:Delete()
  base.OnDelete(self)
end

return UIActivityLobbyMain
