local var_0_0 = class("PosterDlcTimelineState", PosterCommonTimelineState)

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = string.format("%d_%s", arg_1_0, arg_1_1)

	return nullable(HeroInteractActionCfg, var_1_0) or {
		action = "default",
		type = 0,
		embed_list = {}
	}
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	var_0_0.super.Ctor(arg_2_0, arg_2_1)
end

function var_0_0.Enter(arg_3_0)
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
	var_0_0.super.Enter(arg_3_0)
end

function var_0_0.PlayAni(arg_4_0, arg_4_1)
	local var_4_0 = var_0_1(arg_4_0.actor:GetSkinId(), arg_4_1)

	if var_4_0.type == 1 then
		arg_4_0.playingSeq_ = var_4_0.embed_list

		arg_4_0:PlaySequence(1)
	else
		local var_4_1 = var_4_0.embed_list[1] or arg_4_1
		local var_4_2 = arg_4_0:GetHeroTimelineMgr()

		var_4_2:PlayAction(var_4_1, {
			fadeSecond = 0,
			talking = arg_4_0.talking_,
			isLoop = string.find(arg_4_1, "^action1_") ~= nil and true or nil
		})
		var_4_2:SetCallbackStopped(function(arg_5_0)
			if arg_4_0.forceExiting_ then
				arg_4_0.forceExiting_ = nil
				arg_5_0.time = arg_5_0.duration

				arg_5_0:Evaluate()
			end

			arg_4_0:TimelineStopCallback()
		end)
	end
end

function var_0_0.TimelineStopCallback(arg_6_0)
	arg_6_0:PlayNextAni()
end

function var_0_0.Exit(arg_7_0, arg_7_1)
	arg_7_0.playingSeq_ = nil
	arg_7_0.playingSeqIdx_ = nil
	arg_7_0.forceExiting_ = arg_7_1

	var_0_0.super.Exit(arg_7_0, arg_7_1)
	manager.ui:SetMainCameraCom("CinemachineBrain", false)
end

function var_0_0.PlayNextAni(arg_8_0)
	if arg_8_0.playingSeq_ and #arg_8_0.playingSeq_ > arg_8_0.playingSeqIdx_ then
		arg_8_0:GetHeroTimelineMgr():SetCallbackStopped(nil)
		arg_8_0:PlaySequence(arg_8_0.playingSeqIdx_ + 1)

		return
	end

	arg_8_0.actor:ChangeState(PosterGirlConst.StateKay.init)
end

function var_0_0.CanPlayNextAni(arg_9_0)
	if arg_9_0.playingSeq_ then
		local var_9_0 = var_0_1(arg_9_0.actor:GetSkinId(), arg_9_0.playingSeq_[arg_9_0.playingSeqIdx_])

		if var_9_0.click_to_skip == 1 or var_9_0.click_to_skip == true then
			return true
		end
	end

	return false
end

function var_0_0.PlaySequence(arg_10_0, arg_10_1)
	arg_10_0.playingSeqIdx_ = arg_10_1

	arg_10_0:PlayAni(arg_10_0.playingSeq_[arg_10_1])
end

function var_0_0.PlayAniWithParams(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.actor:GetSceneID()
	local var_11_1 = HomeSceneSettingCfg[var_11_0]
	local var_11_2 = var_11_1 and var_11_1.action_suffix

	if string.isNullOrEmpty(var_11_2) then
		arg_11_0:PlayAni(arg_11_1)
	else
		arg_11_0:PlayAni(string.format("%s__%s", arg_11_1, var_11_2))
	end
end

return var_0_0
