--- 该脚本挂在要复制UICamera parent 

------------ import ------------
local URPCameraController       = CS.Game.Native.URP.URPCameraController
------------ import ------------


------------ define ------------
local CameraType = typeof(CS.UnityEngine.Camera)
local BehaviorActionType = typeof(CS.Engine.Lib.BehaviourAction)
------------ define ------------

---@class CameraParamsController
local CameraParamsController = Class('CameraParamsController')

function CameraParamsController:__init()

end


function CameraParamsController:__delete()

end


function CameraParamsController:Awake()
    local gameObject        = self.controller.gameObject
    self._destinationCamera = URPCameraController.Instance.uiCamera
    -- self._behaviorAction    = gameObject:EnsureComponent(BehaviorActionType)
    self._sourceCamera      = gameObject:GetComponentInChildren(CameraType)
    self._sourceCamera.enabled = false

    self:InitDefaultCameraParams()
    -- self._behaviorAction.OnEnableAction = Bind(self, self.OnEnableAction)
    -- self._behaviorAction.OnDisableAction = Bind(self, self.OnDisableAction)
end


-- function CameraParamsController:Start()

-- end


function CameraParamsController:OnDestroy()
    -- if not isNull(self._behaviorAction) then
    --     self._behaviorAction.OnEnableAction = nil
    --     self._behaviorAction.OnDisableAction    = nil
    -- end
    
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CameraParamsController:InitDefaultCameraParams()
    self._dstCameraParams = self:GetCameraParamsByCamera(self._destinationCamera)
    self._srcCameraParams = self:GetCameraParamsByCamera(self._sourceCamera)
    
end

function CameraParamsController:CopyFrom(camera, params)
    if isNull(camera) then return end
    local transform = camera.transform
    camera.nearClipPlane = params.nearClipPlane
    camera.farClipPlane = params.farClipPlane
    camera.fieldOfView = params.fieldOfView
    camera.orthographicSize = params.orthographicSize
    camera.orthographic = params.orthographic
    camera.depth = params.depth
    camera.aspect = params.aspect
    transform.position = params.position
    transform.rotation = params.rotation
    transform.localScale = params.localScale
end

function CameraParamsController:OnEnable()
    self:OnEnableAction()
end

function CameraParamsController:OnDisable()
    self:OnDisableAction()
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CameraParamsController:GetCameraParamsByCamera(camera)
    local transform = camera.transform
    return {
        nearClipPlane    = camera.nearClipPlane,
        farClipPlane     = camera.farClipPlane,
        fieldOfView      = camera.fieldOfView,
        orthographicSize = camera.orthographicSize,
        orthographic     = camera.orthographic,
        depth            = camera.depth,
        aspect           = camera.aspect,
        position         = transform.position,
        rotation         = transform.rotation,
        localScale       = transform.localScale,
    }
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CameraParamsController:OnEnableAction()
    self:CopyFrom(self._destinationCamera, self._srcCameraParams)
end

function CameraParamsController:OnDisableAction()
    self:CopyFrom(self._destinationCamera, self._dstCameraParams)
end

---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CameraParamsController
