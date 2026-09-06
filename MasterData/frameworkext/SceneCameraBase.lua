-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/camera/SceneCameraBase.lua

module("frameworkext.scene.camera.SceneCameraBase", package.seeall)

local SceneCameraBase = class("SceneCameraBase", SceneComponentBase)

function SceneCameraBase:ctor(scene)
	SceneCameraBase.super.ctor(self, scene)

	self._mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	self._follower = self:_initCameraFollow()
	self._followToArg = self._follower.toArg
	self._followCurArg = self._follower.curArg
end

function SceneCameraBase:getCurArg()
	return self._followCurArg
end

function SceneCameraBase:getToArg()
	return self._followToArg
end

function SceneCameraBase:setAutoFocusTransfrom(trs)
	self._follower:SetAutoFocusTransfrom(trs)
end

function SceneCameraBase:clearAutoFocusTransfrom()
	self._follower:ClearAutoFocusTransfrom()
end

function SceneCameraBase:setFocus(x, y, z)
	self._followToArg:SetFocusPos(x, y, z)
end

function SceneCameraBase:setYaw(yawAngle)
	self._followToArg.yawAngle = yawAngle
end

function SceneCameraBase:setPitch(pitchAngle)
	self._followToArg.pitchAngle = pitchAngle
end

function SceneCameraBase:setDist(dist)
	self._followToArg.dist = dist
end

function SceneCameraBase:setFov(fov)
	self._followToArg.fov = fov
end

function SceneCameraBase:applyDirectly()
	self._follower:ApplyDirectly()
end

function SceneCameraBase:_initCameraFollow()
	return nil
end

return SceneCameraBase
