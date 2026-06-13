local DormCameraDirector = BaseClass("DormCameraDirector", require("Camera.CameraDirector.BaseCameraDirector"))
local M = DormCameraDirector

function M:__init()
    self._config = CS.GameX.CameraConst:LuaGetVittualCameraActiveConfig(CS.GameX.ModuleName.Dorm)
    local config = {}
    for k, v in pairs(self._config) do
        config[v] = true
    end
    local allVirtualCameras = self._cameraContent:GetAllVirtualCameras()
    for i = 0, allVirtualCameras.Length - 1 do
        local active = config[allVirtualCameras[i].name]
        if active == nil then
            active = false
        end
        allVirtualCameras[i].gameObject:SetActive(active)
    end
    --IGameEventMgr:RegisterEventHandleByTypeName("UIVisbleEvent", self._OnWindowChangeHandler)
    --self._onTouchStart = Bind(self, self._OnTouchStart)
    --UpdateManager:GetInstance():AddUpdate()
end


function M:Dispose()
    M.super.Dispose(self)
end

return DormCameraDirector
