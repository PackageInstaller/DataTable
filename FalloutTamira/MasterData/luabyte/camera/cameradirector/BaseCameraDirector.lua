local BaseCameraDirector = BaseClass("BaseCameraDirector")
local M = BaseCameraDirector

function M:__init(cameraContent)
    self._csdirector = CS.GameX.Battle.LuaCameraDirector(cameraContent)
    self._cameraContent = cameraContent
end

function M:SetBlur(isBlur)
    -- body
    self._csdirector:SetBlur(isBlur)
end

function M:GetCsDirector()
    return self._csdirector
end

function M:GetIsBlending()
    return self._csdirector.isBlending
end

function M:GetBrain()
    return self._csdirector.brain
end

function M:GetCurrentVirtualCam()
    return self._csdirector.currentVirtualCam
end

function M:SetCurrentVirtualCam(cinemachine)
    self._csdirector.currentVirtualCam = cinemachine
end

function M:GetVirtualCameraByName(VCamName)
    return self._csdirector:GetVirtualCameraByName(VCamName)
end

function M:SwitchVirtualCamera(camName, fov)
    self._csdirector:SwitchVirtualCamera(camName, fov)
end

function M:ClearAllCameraShake()
    self._csdirector:ClearAllCameraShake()
end

function M:SetCameraTransform(camName,trans)
    self._csdirector:SetCameraTransform(camName, trans)
end

function M:SetCameraPosition(camName, x, y, z)
    self._csdirector:SetCameraPosition(camName, x, y, z)
end

function M:SetCameraRotation(camName, x, y, z)
    self._csdirector:SetCameraPosition(camName, x, y, z)
end

function M:SetBlend(fromCam, toCam, style, duration)
    self._csdirector:SetBlend(fromCam, toCam, style, duration)
end

function M:CameraTranslation(duration, x, y, z, rx, ry, rz,fov)
    if fov == nil then 
        fov = -1 
    end
    self._csdirector:CameraTranslation(duration, x, y, z, rx, ry, rz,fov)
end

function M:SetTargetAndLookAt(followTarget)
    self._csdirector:SetTargetAndLookAt(followTarget)
end

function M:Dispose()
    self._csdirector:Dispose()
    self._cameraContent:Dispose()
    self._cameraContent = nil
    self._csdirector = nil
end

return BaseCameraDirector
