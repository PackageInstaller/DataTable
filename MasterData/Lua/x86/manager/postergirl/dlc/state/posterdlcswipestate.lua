local PosterDlcMid2LeftState = class("PosterDlcMid2LeftState", PosterDlcTimelineState)

function PosterDlcMid2LeftState:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.oldDirect = arg_1_2
	self.newDiect = arg_1_3
	self.clipName = self:GetAnimaName(arg_1_2, arg_1_3)

	PosterDlcMid2LeftState.super.Ctor(self, arg_1_1)
end

function PosterDlcMid2LeftState:GetAnimaName(arg_2_1, arg_2_2)
	if PosterGirlConst.ViewDirect.center == arg_2_1 and PosterGirlConst.ViewDirect.left == arg_2_2 then
		return "enter2"
	elseif PosterGirlConst.ViewDirect.center == arg_2_1 and PosterGirlConst.ViewDirect.right == arg_2_2 then
		return "enter3"
	elseif PosterGirlConst.ViewDirect.left == arg_2_1 and PosterGirlConst.ViewDirect.center == arg_2_2 then
		return "return2"
	else
		return "return3"
	end
end

function PosterDlcMid2LeftState:Enter()
	PosterDlcMid2LeftState.super.Enter(self)
	self:PlayAniWithParams(self.clipName)
	self.actor:MuteCamera(true)

	local var_3_0, var_3_1, var_3_2 = PosterGirlTools.GetLoadLightEffect(self.oldDirect, self.newDiect)

	if var_3_0 then
		if var_3_2 and var_3_2 > 0 then
			self.loadEffectTimer_ = Timer.New(function()
				manager.ui:SetSceneLightEffect(var_3_1)
			end, var_3_2)

			self.loadEffectTimer_:Start()
		else
			manager.ui:SetSceneLightEffect(var_3_1)
		end
	else
		manager.ui:SetSceneLightEffect(nil)
	end

	PlayerAction.TouchPosterGirl()
end

function PosterDlcMid2LeftState:Exit(arg_5_1)
	self.actor:MuteCamera(false)

	if self.loadEffectTimer_ then
		self.loadEffectTimer_:Stop()

		self.loadEffectTimer_ = nil
	end

	PosterDlcMid2LeftState.super.Exit(self, arg_5_1)
	self.actor:UpdateCameraParams()
end

return PosterDlcMid2LeftState
