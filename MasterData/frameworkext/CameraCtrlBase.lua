-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/camera/CameraCtrlBase.lua

module("frameworkext.camera.CameraCtrlBase", package.seeall)

local CameraCtrlBase = class("CameraCtrlBase")

function CameraCtrlBase:ctor(cameraTarget)
	self._target = cameraTarget
	self._isActive = false
end

function CameraCtrlBase:isActive()
	return self._isActive
end

function CameraCtrlBase:getGroup()
	return 0
end

function CameraCtrlBase:onActive()
	self._isActive = true
end

function CameraCtrlBase:onInactive()
	self._isActive = false
end

function CameraCtrlBase:onDestroy()
	self._target = nil
end

return CameraCtrlBase
