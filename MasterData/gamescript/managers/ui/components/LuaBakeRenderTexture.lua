local LuaBakeRenderTexture = NewClass("LuaBakeRenderTexture")
local Vector3 = CS.UnityEngine.Vector3
local zero_Vector3 = CS.UnityEngine.Vector3.zero
local one_Vector3 = CS.UnityEngine.Vector3.one
local RTCameraLayer = CS.UnityEngine.LayerMask.NameToLayer("RTCamera")
local TypeRawImage = typeof(CS.UnityEngine.UI.RawImage)
local _SetLocalPos = CS.Framework.TransformUtil.SetLocalPos
local _SetLocalScale = CS.Framework.TransformUtil.SetLocalScale
local GameObject = CS.UnityEngine.GameObject
local TypeUniversalAdditionalCameraData = typeof(CS.UnityEngine.Rendering.Universal.UniversalAdditionalCameraData)
local ColorZero = CS.UnityEngine.Color(0, 0, 0, 0)
local textScaleReset = 1

function LuaBakeRenderTexture:ctor(container)
  self.container = container
  self.cameraPos = Vector3(0, 25, -50)
  self.targetImgPos = zero_Vector3
  self.targetImgScale = zero_Vector3
  self.orthographicSize = 1.0
  self.aspect = 1.0
  self.s_rtCamera = nil
  self._renderTexture = nil
  self.target = nil
  self._lastMainTexWidth = 0
  self._lastMainTexHeight = 0
  self.targetRawImage = nil
  self.defaultLayer = 0
  self.defaultScale = one_Vector3
  self.forceScale = one_Vector3
  self.bForceScale = false
end

function LuaBakeRenderTexture:OnEnable()
  self.defaultLayer = RTCameraLayer
  self.container.gameObject.layer = RTCameraLayer
end

function LuaBakeRenderTexture:ResetAniPortraitPos(vec)
  self.container.transform.localScale = vec
  self.defaultScale = self.container.transform.lossyScale
end

function LuaBakeRenderTexture:ForceScale(state)
  self.bForceScale = state
end

function LuaBakeRenderTexture:SetForceScaleValue(vec)
  self.forceScale = vec
  self.container.transform.localScale = vec
end

function LuaBakeRenderTexture:SetTarget(target)
  self.target = target
  if self.target ~= nil then
    self.target.gameObject:SetActive(false)
  end
end

function LuaBakeRenderTexture:SetTargetImageInfo(targetImgPos, targetImgScale, cameraPos, orthographicSize)
  self.targetImgPos = targetImgPos
  self.targetImgScale = targetImgScale
  self.cameraPos = cameraPos
  self.orthographicSize = orthographicSize
end

function LuaBakeRenderTexture:LateUpdate()
  if self.target and self.targetRawImage == nil then
    self.targetRawImage = self.target:GetComponent(TypeRawImage)
    local imgPos = self.targetImgPos
    local imgScale = self.targetImgScale
    _SetLocalPos(self.targetRawImage.transform, imgPos.x, imgPos.y, imgPos.z)
    _SetLocalScale(self.targetRawImage.transform, imgScale.x, imgScale.y, imgScale.z)
    self.targetRawImage.gameObject:SetActive(true)
    self.defaultScale = self.container.transform.lossyScale
    self.cameraPos = self.cameraPos
    self.orthographicSize = self.orthographicSize
  end
  if self.container.gameObject.layer ~= self.defaultLayer then
    self.container.gameObject.layer = self.defaultLayer
  end
  if nil ~= self.s_rtCamera then
    local width = math.modf(self.targetRawImage.rectTransform.sizeDelta.x / textScaleReset)
    if self._lastMainTexWidth ~= width then
      self:ReleaseRenderture()
    end
    self:SetGlobalScale(self.container.gameObject, self.defaultScale.x, self.defaultScale.y, self.defaultScale.z)
  end
  self:TakePhoto()
end

function LuaBakeRenderTexture:SetGlobalScale(obj, x, y, z)
  if not self.LogOnce then
    self.LogOnce = true
  end
  local parent = obj.transform.parent.parent
  local parentGlobalScale = nil ~= parent and parent.lossyScale or one_Vector3
  local newScaleX = x / parentGlobalScale.x
  local newScaleY = y / parentGlobalScale.y
  local newScaleZ = z / parentGlobalScale.z
  if self.bForceScale then
    _SetLocalScale(obj.transform, self.forceScale.x, self.forceScale.y, self.forceScale.z)
  else
    _SetLocalScale(obj.transform, newScaleX, newScaleY, newScaleZ)
  end
end

function LuaBakeRenderTexture:OnDestroy()
  self:ReleaseRenderture()
  GameObject.Destroy(self.s_rtCamera)
  self.s_rtCamera = nil
end

function LuaBakeRenderTexture:PhotoRenderTexture()
  local width = math.modf(self.targetRawImage.rectTransform.sizeDelta.x / textScaleReset)
  local height = math.modf(self.targetRawImage.rectTransform.sizeDelta.y / textScaleReset)
  if not self._renderTexture and self.targetRawImage ~= nil then
    self._lastMainTexWidth = width
    self._lastMainTexHeight = height
    self.s_rtCamera.aspect = self._lastMainTexWidth / self._lastMainTexHeight
    self._renderTexture = PortraitRTProducer.Instance:ActivePortrait(self.container.gameObject, self.s_rtCamera.gameObject, width, height)
    self.hasChange = true
  end
  return self._renderTexture
end

function LuaBakeRenderTexture:ReleaseRenderture()
  if self._renderTexture == nil then
    return
  end
  PortraitRTProducer.Instance:RemovePortrait(self.container.gameObject, self.s_rtCamera.gameObject)
  self._renderTexture = nil
  self.hasChange = true
end

function LuaBakeRenderTexture:TakePhoto()
  self:SetupCamera()
  if self.hasChange == true or self.hasChange == nil then
    self.s_rtCamera.targetTexture = self:PhotoRenderTexture()
    self.targetRawImage.texture = self:PhotoRenderTexture()
    self.hasChange = false
  end
end

function LuaBakeRenderTexture:SetupCamera()
  if self.s_rtCamera ~= nil then
    return
  end
  local cameraObj = GameObject("PhotoCamera")
  local TypeCamera = typeof(CS.UnityEngine.Camera)
  self.s_rtCamera = cameraObj:AddComponent(TypeCamera)
  self.s_rtCamera.transform:SetParent(self.container.gameObject.transform, false)
  self.s_rtCamera.useOcclusionCulling = false
  self.s_rtCamera.enabled = true
  self.s_rtCamera.clearFlags = CS.UnityEngine.CameraClearFlags.SolidColor
  self.s_rtCamera.backgroundColor = ColorZero
  self.s_rtCamera.cullingMask = 1 << RTCameraLayer
  self.s_rtCamera.nearClipPlane = 0.3
  self.s_rtCamera.farClipPlane = 1000
  self.s_rtCamera.allowHDR = false
  self.s_rtCamera.allowMSAA = false
  self.s_rtCamera.orthographic = true
  local cameraData = cameraObj:GetComponent(TypeUniversalAdditionalCameraData)
  cameraData = cameraData or cameraObj:AddComponent(TypeUniversalAdditionalCameraData)
  if cameraData then
    cameraData.requiresDepthTexture = false
    cameraData.requiresColorOption = 0
  end
  self.s_rtCamera.transform.eulerAngles = zero_Vector3
  self.s_rtCamera.gameObject:SetActive(true)
  self.s_rtCamera.orthographicSize = self.orthographicSize
  _SetLocalPos(self.s_rtCamera.transform, self.cameraPos.x, self.cameraPos.y, self.cameraPos.z)
  _SetLocalScale(self.s_rtCamera.transform, 1, 1, 1)
end

return LuaBakeRenderTexture
