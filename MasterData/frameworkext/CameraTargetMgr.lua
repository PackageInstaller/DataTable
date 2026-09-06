-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/camera/CameraTargetMgr.lua

module("frameworkext.camera.CameraTargetMgr", package.seeall)

local CameraTargetMgr = class("CameraTargetMgr")

function CameraTargetMgr:ctor()
	self._targets = {}
	self._taggedTargets = {}
	self._mainCameraTag = "MainCamera"
	self._uiCameraTag = "UICamera"
	self._mainCameraTarget = nil
	self._uiCameraTarget = nil
end

function CameraTargetMgr:setMainCameraTag(tag)
	self._mainCameraTag = tag
end

function CameraTargetMgr:setUICameraTag(tag)
	self._uiCameraTag = tag
end

function CameraTargetMgr:getMainCameraTarget()
	return self._mainCameraTarget
end

function CameraTargetMgr:getUICameraTarget()
	return self._uiCameraTarget
end

function CameraTargetMgr:getTargetByTag(tag)
	return self._taggedTargets[tag]
end

function CameraTargetMgr:addTarget(target)
	if table.indexof(self._targets, target) == false then
		table.insert(self._targets, target)

		local tag = target:getGO().tag

		if tag ~= "Untagged" then
			if self._taggedTargets[tag] then
				printWarn("Camera target with same tag=", tag)
			end

			self._taggedTargets[tag] = target

			if tag == self._mainCameraTag then
				self._mainCameraTarget = target
			elseif tag == self._uiCameraTag then
				self._uiCameraTarget = target
			end
		end
	end

	return target
end

function CameraTargetMgr:removeTarget(target)
	local tag = target:getGO().tag

	if tag ~= "Untagged" then
		self._taggedTargets[tag] = nil
	end

	if self._mainCameraTarget == target then
		self._mainCameraTarget = nil
	elseif self._uiCameraTarget == target then
		self._uiCameraTarget = nil
	end

	table.removebyvalue(self._targets, target)
end

CameraTargetMgr.instance = CameraTargetMgr.New()

return CameraTargetMgr
