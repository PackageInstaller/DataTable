local GotoActivityBase = class("GotoActivityBase")

function GotoActivityBase:GetId()
	return self.activityId
end

function GotoActivityBase:Ctor(arg_2_1)
	self.activityId = arg_2_1
end

function GotoActivityBase:OnInit()
	return
end

function GotoActivityBase:OnEnter(arg_4_1, arg_4_2)
	return
end

function GotoActivityBase:EnableCamera(arg_5_1)
	QWorldMgr:EnableCustomCamera(arg_5_1[1], arg_5_1[2] or 1, QWorldCameraLayer.Activity)
end

function GotoActivityBase:TryTeleport()
	return
end

return GotoActivityBase
