local base = require("Game.ActivityLobby.Ctrl.ActLobbyCtrlBase")
local ActLbCamCtrl = class("ActLbCamCtrl", base)
local CS_RenderManager = CS.RenderManager
local CS_LeanGesture = CS.Lean.Touch.LeanGesture
local CS_CmCoreState = CS.Cinemachine.CinemachineCore.Stage
local CS_Camera = CS.UnityEngine.Camera
local CS_CameraSetup = CS.CameraSetup
local util = require("XLua.Common.xlua_util")
local MoviePlayer = require("Game.ActivityLobby.UI.Main.UIMoviePlayer")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")

function ActLbCamCtrl:ctor(actLbCtrl)
  self._hideableEnttDic = {}
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.resloader = CS.ResLoader.Create()
end

function ActLbCamCtrl:OnActLbSceneEnter(bind)
  base.OnActLbSceneEnter(self, bind)
  self._camMain = UIManager:GetMainCamera()
  self._camBind = {}
  UIUtil.LuaUIBindingTable(bind.cam, self._camBind)
  self._sceneBind = {}
  UIUtil.LuaUIBindingTable(self._camBind.sceneBind, self._sceneBind)
  self._vcamMapBody = self._camBind.vcam_map:GetCinemachineComponent(CS_CmCoreState.Body)
  self._distance = 0.5
  self._camBind.collider_camRigidbody.center = Vector3.Temp(0, 0, self._camMain.nearClipPlane)
  self._camBind.camRigidbody:SetParent(self._camMain.transform, false)
  local listener = CS.ColliderEventListener.Get(self._camBind.camRigidbody.gameObject)
  self.__movieCloseCallback = BindCallback(self, self._MovieCloseCallback)
  listener:TriggerEnterEvent("+", BindCallback(self, self._OnTriggerEnter))
  listener:TriggerExitEvent("+", BindCallback(self, self._OnTriggerExit))
  self._UpdFollowUIFunc = BindCallback(self, self._UpdFollowUI)
  MsgCenter:AddListener(eMsgEventId.UpdActLbFollowUI, self._UpdFollowUIFunc)
end

function ActLbCamCtrl:ActLbCamOnGesture(fingerList)
  local screenDelta = CS_LeanGesture.GetScreenDelta(fingerList) * CS_RenderManager.Instance.ScreenScaleRatio
  if screenDelta.x ~= 0 or screenDelta.y ~= 0 then
    local deltaX = screenDelta.x * self._camBind.camMoveSpeed.x
    local deltaY = screenDelta.y * self._camBind.camMoveSpeed.y
    local pos = self._camBind.camTarget.position
    pos = pos - Quaternion.TempEuler(0, self._camBind.vcam_map.transform.eulerAngles.y, 0):MulVec3(Vector3.Temp(deltaX, 0, deltaY))
    self._camBind.camTarget.position = pos
    self:SetActLbCamFollowTarget(nil)
  end
  local delta = 1 - CS_LeanGesture.GetPinchScale(fingerList)
  if delta ~= 0 then
    self._distance = self._vcamMapBody.m_PathPosition + delta * self._camBind.camScaleSpeed
    self._distance = math.clamp(self._distance, self._camBind.camDistanceRange.x, self._camBind.camDistanceRange.y)
    self._vcamMapBody.m_PathPosition = self._distance
    self:_UpdHideUIByCamScale()
  end
end

function ActLbCamCtrl:GetAcbLbFollowUIPosOffset()
  return math.max(0, self._camBind.followUIOffsetFactor * (1 - self._distance - 0.5))
end

function ActLbCamCtrl:_UpdHideUIByCamScale()
  local hideUI = self._vcamMapBody.m_PathPosition <= self._camBind.hideUICamDistance
  if self._isHideUI == hideUI then
    return
  end
  self._isHideUI = hideUI
  local uiRootCanvasGroup = UIManager:GetUIRootCanvasGroup()
  uiRootCanvasGroup.interactable = not hideUI
  if self._hideAllUITween == nil then
    self._hideAllUITween = uiRootCanvasGroup:DOFade(0, 1):SetAutoKill(false):OnComplete(function()
      UIManager.UICanvas.gameObject:SetActive(false)
    end)
  end
  if hideUI then
    self._hideAllUITween:PlayForward()
  else
    UIManager.UICanvas.gameObject:SetActive(true)
    self._hideAllUITween:PlayBackwards()
  end
end

function ActLbCamCtrl:SetActLbCamFollowTarget(tarTransform)
  self._camTargetParent = tarTransform
  self:_UpdCamTargetPos()
end

function ActLbCamCtrl:_UpdCamTargetPos()
  if self._camBind == nil then
    return
  end
  local curPos = self._camBind.camTarget.position
  if not IsNull(self._camTargetParent) then
    curPos = self._camTargetParent.position
  end
  if curPos ~= self._lastCamTargetPos then
    local bound
    if self.actLbCtrl.GetCameraBound ~= nil then
      bound = self.actLbCtrl:GetCameraBound()
    else
      bound = self.actLbCtrl:GetActLbCfg().cam_bound
    end
    curPos.x = math.clamp(curPos.x, bound[1], bound[3])
    curPos.z = math.clamp(curPos.z, bound[2], bound[4])
    self._camBind.camTarget.position = curPos
  end
  self._lastCamTargetPos = curPos
end

function ActLbCamCtrl:_OnCamChange()
  if self._camMain == nil then
    return
  end
  local curCamPos = self._camMain.transform.position
  if self._lastCamPos == curCamPos then
    return
  end
  self._lastCamPos = curCamPos
  self:_UpdFollowUI()
end

function ActLbCamCtrl:_UpdFollowUI()
  if self.actLbCtrl.actLbIntrctCtrl ~= nil then
    self.actLbCtrl.actLbIntrctCtrl:InvokeActLbCamChange()
  end
  local lbFollowInfoWin = UIManager:GetWindow(UIWindowTypeID.ActLbFollowInfo)
  if lbFollowInfoWin then
    lbFollowInfoWin:UpdActLbFollowInfo()
  end
end

function ActLbCamCtrl:OnLbCamUpdate()
  self:_UpdCamTargetPos()
end

function ActLbCamCtrl:OnLbCamLateUpdate()
  self:_OnCamChange()
end

function ActLbCamCtrl:ActLbPlayStartShowTimeLine(skipTlImediate)
  if IsNull(self._sceneBind.tl_Start) then
    self:_OnStartShowEnd()
    return
  end
  if skipTlImediate then
    self:_EndStartShowTl()
    self:_OnStartShowEnd()
    return
  end
  local continueWindow = UIManager:ShowWindow(UIWindowTypeID.ClickContinue)
  continueWindow:InitContinue(function()
    self:_SkipStartShowTl()
  end)
  local uiRootCanvasGroup = UIManager:GetUIRootCanvasGroup()
  uiRootCanvasGroup.alpha = 1
  self._startTlCo = TimelineUtil.Play(self._sceneBind.tl_Start, function()
    self._startTlCo = nil
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    self:_OnStartShowEnd()
  end, false, true)
end

function ActLbCamCtrl:PlayOpeningMovie(moviePath, fadeStartTime, fadeKeepTime)
  if not string.IsNullOrEmpty(moviePath) then
    local moviePath = PathConsts:GetActivityOpenVedio(moviePath)
    self.moviePlayer = UIManager:ShowWindow(UIWindowTypeID.MoviePlayer)
    self.moviePlayer:PlayMovie(moviePath, nil, 1, false, self.__movieCloseCallback)
    self.moviePlayer:SetMovieFade(fadeStartTime, fadeKeepTime)
  end
end

function ActLbCamCtrl:_SkipStartShowTl()
  if self._startTlCo then
    self._startTlCo = nil
    self:_EndStartShowTl()
  end
end

function ActLbCamCtrl:_EndStartShowTl()
  if IsNull(self._sceneBind.tl_Start) then
    return
  end
  self._sceneBind.tl_Start.time = self._sceneBind.tl_Start.duration
  self._sceneBind.tl_Start:Evaluate()
  if self.moviePlayer ~= nil then
    self.moviePlayer:CloseMoviePlayer()
    self.moviePlayer = nil
  end
end

function ActLbCamCtrl:_MovieCloseCallback()
  local cameraSetup = CS_Camera.main:GetComponent(typeof(CS_CameraSetup))
  if not IsNull(cameraSetup) and not cameraSetup.enabled and not cameraSetup:IsOriginResolution() then
    cameraSetup.enabled = true
  end
  self.moviePlayer = nil
end

function ActLbCamCtrl:_OnStartShowEnd()
  if not IsNull(self._sceneBind.tl_Start) then
    self._sceneBind.tl_Start.enabled = false
    if not IsNull(self._sceneBind.tl_Start.transform.parent) then
      local Vcam_Start = self._sceneBind.tl_Start.transform.parent:Find("Vcam/Vcam_Start")
      if not IsNull(Vcam_Start) then
        Vcam_Start.gameObject:SetActive(false)
      end
    end
  end
  self._startShowCo = GR.StartCoroutine(util.cs_generator(BindCallback(self, self._CoOnStartShowEnd)))
end

function ActLbCamCtrl:_CoOnStartShowEnd()
  self._startShowCo = nil
  local mainWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  while mainWin == nil do
    coroutine.yield(nil)
    mainWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
  end
  while not mainWin:IsLodeCompleted() do
    coroutine.yield(nil)
  end
  while UIManager:GetWindow(UIWindowTypeID.MoviePlayer) do
    coroutine.yield(nil)
  end
  mainWin:TryActLbGuide(function()
    GuideManager:TryTriggerGuide(eGuideCondition.InActLobby)
  end)
  self.actLbCtrl.actLbIntrctCtrl:InvokeActLbRedDotFunc()
  self.actLbCtrl.actLbIntrctCtrl:InvokeActLbStartShowEndCoFunc()
  self.actLbCtrl.actLbIntrctCtrl:UpdLbCurInteractAction()
  ActLbUtil.PlayLbUIAnimation()
  self:_UpdHideUIByCamScale()
end

function ActLbCamCtrl:AddLbCamHideableEntt(gameObject, entt)
  self._hideableEnttDic[gameObject] = entt
end

function ActLbCamCtrl:_OnTriggerEnter(collider)
  local entt = self._hideableEnttDic[collider.gameObject]
  if entt == nil then
    return
  end
  entt:HideLbEnttRenderer(true)
end

function ActLbCamCtrl:_OnTriggerExit(collider)
  local entt = self._hideableEnttDic[collider.gameObject]
  if entt == nil then
    return
  end
  entt:HideLbEnttRenderer(false)
end

function ActLbCamCtrl:Delete()
  if self._UpdFollowUIFunc then
    MsgCenter:RemoveListener(eMsgEventId.UpdActLbFollowUI, self._UpdFollowUIFunc)
  end
  self._camBind = nil
  self._camMain = nil
  table.removeall(self._hideableEnttDic)
  if self._startTlCo then
    TimelineUtil.StopTlCo(self._startTlCo)
    self._startTlCo = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.moviePlayer ~= nil then
    self.moviePlayer:CloseMoviePlayer()
    self.moviePlayer = nil
  end
  if self._startShowCo ~= nil then
    GR.StopCoroutine(self._startShowCo)
    self._startShowCo = nil
  end
  if self._hideAllUITween ~= nil then
    self._hideAllUITween:Kill()
  end
  self.__movieCloseCallback = nil
  local uiRootCanvasGroup = UIManager:GetUIRootCanvasGroup()
  uiRootCanvasGroup.interactable = true
  uiRootCanvasGroup.alpha = 1
  UIManager.UICanvas.gameObject:SetActive(true)
end

return ActLbCamCtrl
