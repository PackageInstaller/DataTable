local PosterDlcViewPointState = class("PosterDlcViewPointState", PosterDlcTimelineState)

function PosterDlcViewPointState:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.newDiect = arg_1_2
	self.clipName = self:GetAnimaNameByViewPoint(arg_1_2)

	PosterDlcViewPointState.super.Ctor(self, arg_1_1)
end

function PosterDlcViewPointState:GetAnimaNameByViewPoint(arg_2_1)
	if PosterGirlConst.ViewDirect.left == arg_2_1 then
		return "action1_1"
	elseif PosterGirlConst.ViewDirect.right == arg_2_1 then
		return "action1_2"
	elseif PosterGirlConst.ViewDirect.center == arg_2_1 then
		return "action1_3"
	else
		return "action1_1"
	end
end

function PosterDlcViewPointState:Enter()
	PosterDlcViewPointState.super.Enter(self)
	self:PlayAniWithParams(self.clipName)
	self.actor:MuteCamera(true)
end

function PosterDlcViewPointState:Exit(arg_4_1)
	self.actor:MuteCamera(false)
	self.actor:UpdateCameraParams()
end

return PosterDlcViewPointState
