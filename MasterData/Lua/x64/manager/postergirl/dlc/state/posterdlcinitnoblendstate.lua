local PosterDlcInitNoblendState = class("PosterDlcInitNoblendState", PosterDlcTimelineState)

function PosterDlcInitNoblendState:Ctor(arg_1_1)
	PosterDlcInitNoblendState.super.Ctor(self, arg_1_1)
end

function PosterDlcInitNoblendState:Enter()
	PosterDlcInitNoblendState.super.Enter(self)

	LuaForUtil.IsManualAnimatorBlend = false

	self.actor:EnableEyeController(true)
	self.actor:StopHeroTalk()
	self:PlayInitAni()

	local var_2_0 = self.actor:GetInteractionCfg()
	local var_2_1
	local var_2_2 = self.actor:GetViewDirect()

	if PosterGirlConst.ViewDirect.center == var_2_2 then
		var_2_1 = var_2_0[PosterGirlConst.InteractionKey.idle]
	elseif PosterGirlConst.ViewDirect.left == var_2_2 then
		var_2_1 = var_2_0[PosterGirlConst.InteractionKey.idle2]
	elseif PosterGirlConst.ViewDirect.right == var_2_2 then
		var_2_1 = var_2_0[PosterGirlConst.InteractionKey.idle3]
	end

	if type(var_2_1) == "table" and #var_2_1 > 0 then
		self.idleTimer = Timer.New(function()
			self:OnlyMainActorDo(function()
				manager.posterGirl:DoIdle()
			end)
		end, 60, -1)

		self.idleTimer:Start()
	end
end

function PosterDlcInitNoblendState:Update()
	PosterDlcInitNoblendState.super.Update(self)
	self:PlayInitAni()
end

function PosterDlcInitNoblendState:PlayInitAni()
	self:PlayAniWithParams("action1_" .. self.actor:GetViewDirect() + 1)
end

function PosterDlcInitNoblendState:PlayNextAni()
	return
end

function PosterDlcInitNoblendState:Exit(arg_8_1)
	PosterDlcInitNoblendState.super.Exit(self, arg_8_1)

	LuaForUtil.IsManualAnimatorBlend = true

	if self.idleTimer then
		self.idleTimer:Stop()

		self.idleTimer = nil
	end
end

return PosterDlcInitNoblendState
