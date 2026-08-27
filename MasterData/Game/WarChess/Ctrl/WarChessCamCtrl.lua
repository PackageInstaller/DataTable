local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessCamCtrl = class("WarChessCamCtrl", base)
local util = require("XLua.Common.xlua_util")
local CS_CmCoreState = CS.Cinemachine.CinemachineCore.Stage
local CS_LeanGesture = CS.Lean.Touch.LeanGesture
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_RenderManager = CS.RenderManager
local CS_Collider = CS.UnityEngine.Collider
local v3Temp = Vector3.New()
local QtnTemp = Quaternion.New()
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function WarChessCamCtrl:ctor(wcCtrl)
  self.__onGesture = BindCallback(self, self.__OnGesture)
  self.__couldNormalMoveCamera = true
  self._allowCamDragBreak = true
  self.__onCamerMoveCallbcak = BindCallback(self, self.OnCamerMoveCallbcak)
  self.__updateHandle = BindCallback(self, self._OnUpdate)
  self.__lastCamView = nil
  self._EnableWcCamFollowDeadZone = true
  self.__distanceRange = {0, 0}
  self.__useLuaConfiner = false
  self.__luaConfinerOutLine = nil
end

function WarChessCamCtrl:OnSceneLoadOver(isInit, isReconnected)
  self.bind = {}
  UIUtil.LuaUIBindingTable(self.wcCtrl.bind.cameraRoot, self.bind)
  self._deadZoneRangeV2 = self.bind.deadZoneRange
  self._deadZoneRangeV2.x = math.clamp(self._deadZoneRangeV2.x, 0, 1)
  self._deadZoneRangeV2.y = math.clamp(self._deadZoneRangeV2.y, 0, 1)
  self:RefreshWCMapCamCustomMoveConstrint()
  self.vcamMapBody = self.bind.vcam_map:GetCinemachineComponent(CS_CmCoreState.Body)
  self._curCamDistance = self.__distanceRange[2]
  self:GetCameraViewOnPlaneRect()
  self:__TryInitWCRainFX()
  CS_LeanTouch.OnGesture("+", self.__onGesture)
  self.bind.mainCamera.OnCameraMove = self.__onCamerMoveCallbcak
  self.bind.mainCamera.ConfinerV4 = self.wcCtrl.mapCtrl:GetWcMapSizeV4() + self.bind.mapSizeExtra
  self:RecorverCamPos()
  self._mainCam = UIManager:GetMainCamera()
  UpdateManager:AddUpdate(self.__updateHandle)
  self:_UpdCamFollowOffset(self._curCamDistance)
  if isInit then
    self:_InitCamPos(isReconnected)
  end
end

function WarChessCamCtrl:_InitCamPos(isReconnected)
  if isReconnected then
    local posV2 = self.wcCtrl.teamCtrl:GetFirstAliveTeamPosV2()
    if posV2 ~= nil then
      self:SetWcCamFollowPos(Vector3.Temp(posV2.x, 0, posV2.y), true)
      return
    end
  end
  local wcLvCfg = WarChessManager:GetWCLevelCfg()
  self:SetWcCamFollowPos(Vector3.Temp(wcLvCfg.Initial_coord[1], 0, wcLvCfg.Initial_coord[2]), true)
end

function WarChessCamCtrl:_UpdCamFollowOffset(camDistance)
  local offset = Quaternion.MulVec3(self._mainCam.transform.rotation, Vector3.back * camDistance)
  self.bind.mapCamFollowOffset.localPosition = offset
end

function WarChessCamCtrl:__OnGesture(fingerList)
  if fingerList.Count == 0 or GuideManager.inGuide then
    return
  end
  if self._CanDragStopFollow and self._allowCamDragBreak then
  elseif fingerList[0].StartedOverGui or not self.__couldNormalMoveCamera then
    return
  end
  local screenDelta = CS_LeanGesture.GetScreenDelta(fingerList) * CS_RenderManager.Instance.ScreenScaleRatio
  if screenDelta.x ~= 0 or screenDelta.y ~= 0 then
    if self._CanDragStopFollow then
      self._customFollowTarget = nil
    end
    local deltaX = screenDelta.x * self.bind.camMoveSpeed.x
    local deltaY = screenDelta.y * self.bind.camMoveSpeed.y
    local pos = self.bind.vcam_mapFollow.transform.position
    pos = pos - QtnTemp:SetEuler(0, self.bind.vcam_map.transform.eulerAngles.y, 0):MulVec3(v3Temp:Set(deltaX, 0, deltaY))
    self:SetWcCamFollowPos(pos)
  end
  local delta = 1 - CS_LeanGesture.GetPinchScale(fingerList)
  if delta ~= 0 then
    if self._CanDragStopFollow then
      self._customFollowTarget = nil
    end
    local distance = self._curCamDistance + delta * self.bind.camScaleSpeed
    distance = math.clamp(distance, self.__distanceRange[1], self.__distanceRange[2])
    self._curCamDistance = distance
    self:_UpdCamFollowOffset(self._curCamDistance)
  end
  self:_FollowCamParamChange(false)
end

function WarChessCamCtrl:_OnUpdate()
  self:_FollowRange()
  self:__UpdateConfiner()
end

function WarChessCamCtrl:_FollowRange()
  if IsNull(self._customFollowTarget) then
    return
  end
  local tarPos = self._customFollowTarget.position
  if not self._EnableWcCamFollowDeadZone or self._deadZoneRangeV2.x == 0 or self._deadZoneRangeV2.y == 0 then
    self:SetWcCamFollowPos(tarPos)
    return
  end
  local tarViewPos = self._mainCam:WorldToViewportPoint(tarPos)
  local xLeft = 0.5 - self._deadZoneRangeV2.x / 2
  local xRight = 0.5 + self._deadZoneRangeV2.x / 2
  local yTop = 0.5 + self._deadZoneRangeV2.y / 2
  local yBottom = 0.5 - self._deadZoneRangeV2.y / 2
  if xRight >= tarViewPos.x and xLeft <= tarViewPos.x and yTop >= tarViewPos.y and yBottom <= tarViewPos.y then
    return
  end
  local intrPos = self:_GenDeadZoneInterPoint(xLeft, xRight, yTop, yBottom, tarViewPos)
  if intrPos == nil then
    return
  end
  local intrWorldPos = self._mainCam:ViewportToWorldPoint(v3Temp:Set(intrPos.x, intrPos.y, 1))
  local camPos = self._mainCam.transform.position
  local direct = intrWorldPos - camPos
  local planePoint = MathUtil:GetIntersectWithLineAndPlane(camPos, direct, Vector3.up, Vector3.zero)
  if planePoint == nil then
    return
  end
  local offset = tarPos - planePoint
  self:SetWcCamFollowPos(self.bind.vcam_mapFollow.transform.position + offset / self.bind.deadZoneMoveDamp)
end

local dzV1, dzV2, dzV3, dzV4 = Vector2.New(), Vector2.New(), Vector2.New(), Vector2.New()
local screenCenterV2 = Vector2.New(0.5, 0.5)

function WarChessCamCtrl:_GenDeadZoneInterPoint(xLeft, xRight, yTop, yBottom, tarViewPos)
  dzV1:Set(xLeft, yTop)
  dzV2:Set(xRight, yTop)
  dzV3:Set(xRight, yBottom)
  dzV4:Set(xLeft, yBottom)
  local ok, IntrPos = MathUtil:SegmentsInterPointV2(dzV1, dzV2, screenCenterV2, tarViewPos)
  if ok then
    return IntrPos
  end
  ok, IntrPos = MathUtil:SegmentsInterPointV2(dzV2, dzV3, screenCenterV2, tarViewPos)
  if ok then
    return IntrPos
  end
  ok, IntrPos = MathUtil:SegmentsInterPointV2(dzV3, dzV4, screenCenterV2, tarViewPos)
  if ok then
    return IntrPos
  end
  ok, IntrPos = MathUtil:SegmentsInterPointV2(dzV4, dzV1, screenCenterV2, tarViewPos)
  if ok then
    return IntrPos
  end
end

function WarChessCamCtrl:EnableWcCamFollowDeadZone(enable)
  self._EnableWcCamFollowDeadZone = enable
end

function WarChessCamCtrl:SetWcCamFollowPos(pos, immediately)
  self.bind.vcam_mapFollow.transform.position = pos
  if immediately then
    self.vcamMapBody:ForceCameraPosition(self.bind.mapCamFollowOffset.position, self.vcamMapBody.transform.rotation)
  else
    self:_FollowCamParamChange(true)
  end
end

function WarChessCamCtrl:GetWcCamFollowTarget()
  return self.bind.vcam_mapFollow.transform
end

function WarChessCamCtrl:WcCamCustomFollow(transform, inScreenNotMove)
  self._customFollowTarget = transform
  local isCancel = IsNull(transform)
  self:SetIsCouldNormalMoveCamera(isCancel)
  if isCancel then
    self:CloseWcCamCanUIClickBlock()
  else
    self:_FollowCamParamChange(true)
    self:ShowWcCamCanUIClickBlock()
  end
  if inScreenNotMove and not isCancel then
    local tarViewPos = self._mainCam:WorldToViewportPoint(transform.position)
    if tarViewPos.x < 1 and tarViewPos.x > 0 and 0 < tarViewPos.y and 1 > tarViewPos.y then
      self._customFollowTarget = nil
    end
  end
end

function WarChessCamCtrl:WcCamMainFadeBttomUI(isFade)
  local wcMain = UIManager:GetWindow(UIWindowTypeID.WarChessMain)
  if wcMain ~= nil then
    wcMain:WcMainFadeBttomUI(isFade)
  end
end

function WarChessCamCtrl:SetWcCamCanDragStopFollow(isCan)
  self._CanDragStopFollow = isCan
end

function WarChessCamCtrl:ShowWcCamCanUIClickBlock()
  UIUtil.AddOneCover("WcCam")
  self:WcCamMainFadeBttomUI(true)
end

function WarChessCamCtrl:CloseWcCamCanUIClickBlock()
  UIUtil.CloseOneCover("WcCam")
  self:WcCamMainFadeBttomUI(false)
end

function WarChessCamCtrl:_FollowCamParamChange(isFollow)
  if isFollow then
    self.vcamMapBody.m_XDamping = 1
    self.vcamMapBody.m_YDamping = 1
    self.vcamMapBody.m_ZDamping = 1
  else
    self.vcamMapBody.m_XDamping = 0.2
    self.vcamMapBody.m_YDamping = 0.2
    self.vcamMapBody.m_ZDamping = 0.2
  end
end

function WarChessCamCtrl:WcCamShake(shakeId, position)
  local shakeCfg = ConfigData.warchess_cam_shake[shakeId]
  local definition = self.bind.vcam_mapFollow.m_ImpulseDefinition
  definition.m_AmplitudeGain = shakeCfg.amplitude_gain
  definition.m_FrequencyGain = shakeCfg.frequency_gain
  local timeEnvelope = definition.m_TimeEnvelope
  timeEnvelope.m_SustainTime = shakeCfg.sustain_time
  timeEnvelope.m_DecayTime = shakeCfg.decay
  definition.m_TimeEnvelope = timeEnvelope
  self.bind.vcam_mapFollow:GenerateImpulseAt(position, Vector3.down)
end

function WarChessCamCtrl:SetIsCouldNormalMoveCamera(bool)
  self.__couldNormalMoveCamera = bool
end

function WarChessCamCtrl:AllowWcCamDrag(bool)
  self._allowCamDragBreak = bool
end

function WarChessCamCtrl:OnSceneUnload()
  if self.bind == nil then
    return
  end
  CS_LeanTouch.OnGesture("-", self.__onGesture)
  self.bind.mainCamera.OnCameraMove = nil
  self.rainFX = nil
  self._mainCam = nil
  UpdateManager:RemoveUpdate(self.__updateHandle)
  self:__DestoryWCRainFX()
  self:RecordCamCurPos()
  self.__lastCamView = nil
  self.bind = nil
  self:CloseWcCamCanUIClickBlock()
end

function WarChessCamCtrl:OnCamerMoveCallbcak()
  local ok, camView = self.wcCtrl.wcCamCtrl:GetCameraViewOnPlaneRect()
  local curView
  if ok then
    curView = {
      xMin = camView[0],
      yMin = camView[1],
      xMax = camView[2],
      yMax = camView[3]
    }
  end
  MsgCenter:Broadcast(eMsgEventId.WC_CameraMove, ok, curView, self.__lastCamView)
  if ok then
    if self.__lastCamView == nil then
      self.__lastCamView = {}
    end
    self.__lastCamView.xMin = camView[0]
    self.__lastCamView.yMin = camView[1]
    self.__lastCamView.xMax = camView[2]
    self.__lastCamView.yMax = camView[3]
  end
end

function WarChessCamCtrl:GetCameraViewOnPlaneRect()
  if self.bind == nil then
    return false
  end
  return self.bind.mainCamera:GetCameraViewOnPlaneRect(0)
end

function WarChessCamCtrl:RecordCamCurPos()
  self._lastVcamFollowPos = self.bind.vcam_mapFollow.transform.position
  self._lastVcamFollowDistace = self._curCamDistance
end

function WarChessCamCtrl:RecorverCamPos()
  if self._lastVcamFollowPos ~= nil then
    self.bind.vcam_mapFollow.transform.position = self._lastVcamFollowPos
    self._curCamDistance = self._lastVcamFollowDistace
    self._lastVcamFollowPos = nil
    self._lastVcamFollowDistace = nil
  end
end

function WarChessCamCtrl:RefreshWCMapCamCustomMoveConstrint()
  local levelId = WarChessManager:GetWCLevelId()
  local camOverraidCfg = ConfigData.warchess_level_cam[levelId]
  if camOverraidCfg == nil then
    self.__distanceRange[1] = self.bind.camDistanceRange.x
    self.__distanceRange[2] = self.bind.camDistanceRange.y
    return
  end
  local min_depth = camOverraidCfg.cam_height[1]
  local max_depth = camOverraidCfg.cam_height[2]
  local cameraDegree_x = camOverraidCfg.cam_angle
  self.bind.mainCamera.EnableWcCamConfiner = false
  self.__useLuaConfiner = true
  self.__distanceRange[1] = min_depth or self.bind.camDistanceRange.x
  self.__distanceRange[2] = max_depth or self.bind.camDistanceRange.y
  self.__luaConfinerOutLine = camOverraidCfg.cam_deviation
  self.bind.vcam_map.transform.localRotation = Quaternion.Euler(cameraDegree_x, 0, 0)
end

function WarChessCamCtrl:__TryInitWCRainFX()
  local wcLevelCfg = WarChessManager:GetWCLevelCfg()
  local resloader = self.wcCtrl.animaCtrl.resloader
  if wcLevelCfg.environment == eWarChessEnum.WCEnviromentType.Rain then
    if self.rainFX == nil then
      local rainPrefab = resloader:LoadABAsset(PathConsts:GetWarChessEffectPrefabPath("FXP_wansheng_rain_high"))
      self.rainFX = rainPrefab:Instantiate(self.bind.mainCamera.transform)
    end
  elseif wcLevelCfg.environment == eWarChessEnum.WCEnviromentType.Snow then
    if self.snowFX == nil then
      local snowPrefab = resloader:LoadABAsset(PathConsts:GetWarChessEffectPrefabPath("FXP_shengdan_snow_high"))
      self.snowFX = snowPrefab:Instantiate(self.bind.mainCamera.transform)
    end
  else
    self:__DestoryWCRainFX()
  end
end

function WarChessCamCtrl:__DestoryWCRainFX()
  if self.rainFX ~= nil then
    DestroyUnityObject(self.rainFX)
    self.rainFX = nil
  end
  if self.snowFX ~= nil then
    DestroyUnityObject(self.snowFX)
    self.snowFX = nil
  end
end

function WarChessCamCtrl:__UpdateConfiner()
  if not self.__useLuaConfiner then
    return
  end
  local curPos = self.bind.vcam_mapFollow.transform.position
  local x = curPos.x
  local y = curPos.z
  local new_x = math.clamp(x, self.__luaConfinerOutLine[1], self.__luaConfinerOutLine[3])
  local new_y = math.clamp(y, self.__luaConfinerOutLine[2], self.__luaConfinerOutLine[4])
  if new_x ~= x or new_y ~= y then
    self.bind.vcam_mapFollow.transform.position = Vector3.New(new_x, 0, new_y)
  end
end

function WarChessCamCtrl:Delete()
  self:__DestoryWCRainFX()
end

return WarChessCamCtrl
