local PosterDlcInitState = class("PosterDlcInitState", PosterDlcTimelineState)

function PosterDlcInitState:Ctor(arg_1_1)
	PosterDlcInitState.super.Ctor(self, arg_1_1)
end

function PosterDlcInitState:Enter()
	PosterDlcInitState.super.Enter(self)
	self.actor:StopHeroTalk()
	self.actor:EnableEyeController(true)

	local var_2_0 = self.actor:GetViewDirect()

	self:PlayAniWithParams("action1_" .. var_2_0 + 1)

	local var_2_1 = self.actor:GetInteractionCfg()
	local var_2_2

	if PosterGirlConst.ViewDirect.center == var_2_0 then
		var_2_2 = var_2_1[PosterGirlConst.InteractionKey.idle]
	elseif PosterGirlConst.ViewDirect.left == var_2_0 then
		var_2_2 = var_2_1[PosterGirlConst.InteractionKey.idle2]
	elseif PosterGirlConst.ViewDirect.right == var_2_0 then
		var_2_2 = var_2_1[PosterGirlConst.InteractionKey.idle3]
	end

	if type(var_2_2) == "table" and #var_2_2 > 0 then
		self.idleTimer = Timer.New(function()
			self:OnlyMainActorDo(function()
				manager.posterGirl:DoIdle()
			end)
		end, 60, -1)

		self.idleTimer:Start()
	end

	if SettingData:GetHomeSceneSettingData().home_scene_sound_effect == 1 and self.actor:GetSceneID() == 6018 and self.actor:GetSkinId() == 109502 then
		if PosterGirlConst.ViewDirect.left == var_2_0 then
			manager.audio:PlayEffect("ui_scene_109502ui", "ui_scene_109502ui_ambience_left", "")
		elseif PosterGirlConst.ViewDirect.right == var_2_0 then
			manager.audio:PlayEffect("ui_scene_109502ui", "ui_scene_109502ui_ambience_right", "")
		else
			manager.audio:PlayEffect("ui_scene_109502ui", "ui_scene_109502ui_ambience_mid", "")
		end
	end
end

function PosterDlcInitState:TimelineStopCallback()
	return
end

function PosterDlcInitState:Exit(arg_6_1)
	PosterDlcInitState.super.Exit(self, arg_6_1)

	if self.idleTimer then
		self.idleTimer:Stop()

		self.idleTimer = nil
	end
end

return PosterDlcInitState
