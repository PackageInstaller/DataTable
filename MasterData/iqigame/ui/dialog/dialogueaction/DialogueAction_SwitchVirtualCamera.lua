-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_SwitchVirtualCamera.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	if self.isComplete then
		return
	end

	local manager = HomeModule.GetVirtualCameraManager()

	if not manager then
		logError("【RPG】没有找到虚拟相机管理器")

		return
	end

	manager:SetCurrentEnableCameraWithID(self.args.cameraId)

	self.isComplete = true
end

function m:OnSkip()
	local manager = HomeModule.GetVirtualCameraManager()

	if not manager then
		logError("【RPG】没有找到虚拟相机管理器")

		return
	end

	manager:SetCurrentEnableCameraWithIDImmediately(self.args.cameraId)

	self.isComplete = true
end

return m
