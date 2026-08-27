local base = require("Game.Sector.Ctrl.SectorCtrlBase")
local SectorCameraCtrl = class("SectorCameraCtrl", base)
local CS_LeanTouch = CS.Lean.Touch.LeanTouch
local CS_LeanGesture = CS.Lean.Touch.LeanGesture
local CS_CmCoreState = CS.Cinemachine.CinemachineCore.Stage
local CS_RenderManager = CS.RenderManager

function SectorCameraCtrl:ctor()
  self.__onGesture = BindCallback(self, self.OnGesture)
  self.__onFingerInactive = BindCallback(self, self.OnFingerInactive)
end

function SectorCameraCtrl:OnSctCamEnterScene(rootGo)
  self._bind = {}
  UIUtil.LuaUIBindingTable(rootGo.transform, self._bind)
  self.cmFramingTransposer = self._bind.cMvcam_SectorMain:GetCinemachineComponent(CS_CmCoreState.Body)
  self.defaultCamDistance = self.cmFramingTransposer.m_CameraDistance
end

function SectorCameraCtrl:InitSectorCameraCtrl()
  CS_LeanTouch.OnGesture("+", self.__onGesture)
  CS_LeanTouch.OnFingerInactive("+", self.__onFingerInactive)
end

function SectorCameraCtrl:OnGesture(fingerList)
  if not self.sctCtrl:EnableSectorCamDrag() or fingerList.Count == 0 or fingerList[0].StartedOverGui then
    return
  end
  if GuideManager.inGuide then
    return
  end
  if IsNull(self.cmFramingTransposer) then
    return
  end
  local camDistanceScale = self.cmFramingTransposer.m_CameraDistance / self.defaultCamDistance
  local screenDelta = CS_LeanGesture.GetScreenDelta(fingerList) * CS_RenderManager.Instance.ScreenScaleRatio * camDistanceScale
  if screenDelta.x ~= 0 or screenDelta.y ~= 0 then
    local pos = self._bind.camTarget.transform.position
    pos.x = pos.x + screenDelta.x * self._bind.camSpeed.x
    pos.z = pos.z + screenDelta.y * self._bind.camSpeed.y
    pos.x = math.clamp(pos.x, self._bind.camRangeX.x, self._bind.camRangeX.y)
    pos.z = math.clamp(pos.z, self._bind.camRangeY.x, self._bind.camRangeY.y)
    self._bind.camTarget.transform.position = pos
    if screenDelta.magnitude > ConfigData.buildinConfig.DragInSectorMapThreshold then
      self.inCamMove = true
    end
  end
  local delta = 1 - CS_LeanGesture.GetPinchScale(fingerList)
  if delta ~= 0 then
    local distance = self.cmFramingTransposer.m_CameraDistance + delta * self._bind.camScaleSpeed
    distance = math.clamp(distance, self._bind.camDistanceRange.x, self._bind.camDistanceRange.y)
    self.cmFramingTransposer.m_CameraDistance = distance
    self.inCamScale = true
    MsgCenter:Broadcast(eMsgEventId.OnSectorCamSacle)
  end
end

function SectorCameraCtrl:OnFingerInactive(leanFinger)
  if CS_LeanTouch.Fingers.Count == 0 then
    self.inCamMove = false
    self.inCamScale = false
  end
end

function SectorCameraCtrl:InSctCamDrag()
  return self.inCamMove or self.inCamScale
end

function SectorCameraCtrl:SetForceFocus(moduelId)
  self._bind.camTarget:SetPosType(moduelId)
end

function SectorCameraCtrl:GetSctCamPdHome2Sector()
  return self._bind.pd_homeToSector
end

function SectorCameraCtrl:GetSctCamPdSector2Home()
  return self._bind.pd_sectorToHome
end

function SectorCameraCtrl:GetSctCamScaleRate()
  local x = self.cmFramingTransposer.m_CameraDistance
  local min = self._bind.camDistanceRange.x
  local max = self._bind.camDistanceRange.y
  return 1 - (x - min) / (max - min)
end

function SectorCameraCtrl:OnSctCamExitScene()
  CS_LeanTouch.OnGesture("-", self.__onGesture)
  CS_LeanTouch.OnFingerInactive("-", self.__onFingerInactive)
end

function SectorCameraCtrl:OnDelete()
  self:OnSctCamExitScene()
  base.OnDelete(self)
end

return SectorCameraCtrl
