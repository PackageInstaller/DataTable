local OtakuMainSceneCameraDirector =
    BaseClass("OtakuMainSceneCameraDirector", require("Camera.CameraDirector.BaseCameraDirector"))
local M = OtakuMainSceneCameraDirector

function M:__init()
end

function M:Dispose()
    M.super.Dispose(self)
end

return OtakuMainSceneCameraDirector
