local var_0_0 = class("PosterDlcInitState", PosterDlcTimelineState)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
end

function var_0_0.Enter(arg_2_0)
	var_0_0.super.Enter(arg_2_0)
	arg_2_0.actor:StopHeroTalk()
	arg_2_0.actor:EnableEyeController(true)

	local var_2_0 = arg_2_0.actor:GetViewDirect()
	local var_2_1 = var_2_0 + 1
	local var_2_2 = "action1_" .. var_2_1

	arg_2_0:PlayAniWithParams(var_2_2)

	local var_2_3 = arg_2_0.actor:GetInteractionCfg()
	local var_2_4

	if PosterGirlConst.ViewDirect.center == var_2_0 then
		var_2_4 = var_2_3[PosterGirlConst.InteractionKey.idle]
	elseif PosterGirlConst.ViewDirect.left == var_2_0 then
		var_2_4 = var_2_3[PosterGirlConst.InteractionKey.idle2]
	elseif PosterGirlConst.ViewDirect.right == var_2_0 then
		var_2_4 = var_2_3[PosterGirlConst.InteractionKey.idle3]
	end

	if type(var_2_4) == "table" and #var_2_4 > 0 then
		arg_2_0.idleTimer = Timer.New(function()
			arg_2_0:OnlyMainActorDo(function()
				manager.posterGirl:DoIdle()
			end)
		end, 60, -1)

		arg_2_0.idleTimer:Start()
	end

	if SettingData:GetHomeSceneSettingData().home_scene_sound_effect == 1 and arg_2_0.actor:GetSceneID() == 6018 and arg_2_0.actor:GetSkinId() == 109502 then
		if PosterGirlConst.ViewDirect.left == var_2_0 then
			manager.audio:PlayEffect("ui_scene_109502ui", "ui_scene_109502ui_ambience_left", "")
		elseif PosterGirlConst.ViewDirect.right == var_2_0 then
			manager.audio:PlayEffect("ui_scene_109502ui", "ui_scene_109502ui_ambience_right", "")
		else
			manager.audio:PlayEffect("ui_scene_109502ui", "ui_scene_109502ui_ambience_mid", "")
		end
	end
end

function var_0_0.TimelineStopCallback(arg_5_0)
	return
end

function var_0_0.Exit(arg_6_0, arg_6_1)
	var_0_0.super.Exit(arg_6_0, arg_6_1)

	if arg_6_0.idleTimer then
		arg_6_0.idleTimer:Stop()

		arg_6_0.idleTimer = nil
	end
end

return var_0_0
