module("CameraUtil", Class.impl())

function createCamera(self)
    self.customCamera = CustomCamera:getSceneCamera()
    return self.customCamera
end

function createMainCamera(self)
    self.customCamera = CustomCamera:getSceneCamera()
    CustomCamera:setXPosEnable(true, 0.05, -15, 15)
    CustomCamera:setYPosEnable(true, 0.05, -10, 5)
    CustomCamera:setFOVScaleEnable(false, 1, 40, 60)
    CustomCamera:enableCamera(true)
    return self.customCamera
end

return _M
