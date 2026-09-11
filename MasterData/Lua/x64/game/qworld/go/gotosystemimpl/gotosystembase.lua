local GotoSystemBase = class("GotoSystemBase")

function GotoSystemBase:GetId()
	return self.systemId
end

function GotoSystemBase:Ctor(arg_2_1)
	self.systemId = arg_2_1
end

function GotoSystemBase:CustomEnable()
	return false
end

function GotoSystemBase:OnEnter(arg_4_1, arg_4_2)
	return
end

function GotoSystemBase:GetCamera()
	return
end

function GotoSystemBase:SetCameraParams(arg_6_1)
	self.cameraParams = arg_6_1
end

function GotoSystemBase:GetCameraParams()
	return self.cameraParams
end

function GotoSystemBase:EnableCamera()
	if not self:CustomEnable() and self.cameraParams then
		QWorldMgr:EnableCustomCamera(self.cameraParams[1], self.cameraParams[2] or 1, QWorldCameraLayer.System)
	end
end

return GotoSystemBase
