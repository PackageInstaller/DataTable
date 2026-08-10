local var_0_0 = class("OathVoiceContent", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

local var_0_1 = {
	awb = "vo_sys_%d.awb",
	name = "v_s_%d_%s",
	sheet = "vo_sys_%d"
}

function var_0_0.OnTalk(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = OathToLuaBridge:GetUseOathCharacterID()

	if HeroTools.FindMatchSkinVoiceCfg(skinID, arg_2_2) then
		HeroTools.PlayTalkBySkinID(var_2_0, arg_2_2, nil, arg_2_1)
	else
		local var_2_1 = string.format(var_0_1.sheet, var_2_0)
		local var_2_2 = string.format(var_0_1.name, var_2_0, arg_2_2)
		local var_2_3 = string.format(var_0_1.awb, var_2_0)

		LuaForUtil.PlayVoiceWithCriLipsync(arg_2_1, var_2_1, var_2_2, var_2_3)
		manager.notify:Invoke(HERO_SOUND_PLAY, skinID, arg_2_2, 1)
	end

	local var_2_4 = manager.audio:GetVoiceLength(string.format("vo_sys_%d", var_2_0), string.format("v_s_%d_%s", var_2_0, arg_2_2), string.format("vo_sys_%d.awb", var_2_0))
	local var_2_5 = HeroVoiceCfg.get_id_list_by_file[arg_2_2]
	local var_2_6 = -1

	for iter_2_0, iter_2_1 in pairs(var_2_5 or {}) do
		local var_2_7 = HeroVoiceCfg[iter_2_1]

		if var_2_7 and var_2_7.use_skin_id == var_2_0 then
			var_2_6 = iter_2_1
		end
	end

	arg_2_0:ShowVoiceContent(var_2_0, var_2_6, var_2_4, arg_2_3, arg_2_4)
end

function var_0_0.ShowVoiceContent(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = tonumber(arg_3_1)
	local var_3_1 = false

	if arg_3_2 and arg_3_2 > 0 then
		local var_3_2 = HeroVoiceDescCfg.Get(var_3_0, arg_3_2)

		if var_3_2 then
			var_3_1 = true
			arg_3_0.voiceText_.text = var_3_2
		end
	end

	if var_3_1 then
		if arg_3_4 > 0 then
			if arg_3_0.talkBubbleShowTimer_ then
				arg_3_0.talkBubbleShowTimer_:Stop()

				arg_3_0.talkBubbleShowTimer_ = nil
			end

			arg_3_0.talkBubbleShowTimer_ = TimeTools.StartAfterSeconds(arg_3_4 / 1000, function()
				if var_3_1 and not isNil(arg_3_0.gameObject_) then
					SetActive(arg_3_0.gameObject_, true)
				end

				if arg_3_0.talkBubbleShowTimer_ then
					arg_3_0.talkBubbleShowTimer_:Stop()

					arg_3_0.talkBubbleShowTimer_ = nil
				end
			end, {})
		else
			SetActive(arg_3_0.gameObject_, true)
		end
	end

	if arg_3_0.talkBubbleHiderTimer_ then
		arg_3_0.talkBubbleHiderTimer_:Stop()

		arg_3_0.talkBubbleHiderTimer_ = nil
	end

	arg_3_0.talkBubbleHiderTimer_ = TimeTools.StartAfterSeconds(arg_3_3 / 1000, function()
		if var_3_1 and not isNil(arg_3_0.gameObject_) then
			SetActive(arg_3_0.gameObject_, false)
		end

		if arg_3_0.talkBubbleHiderTimer_ then
			arg_3_0.talkBubbleHiderTimer_:Stop()

			arg_3_0.talkBubbleHiderTimer_ = nil
		end

		if arg_3_5 then
			LuaExchangeHelper.ActionInvoke(arg_3_5)
		end
	end, {})
end

function var_0_0.HideVoiceContent(arg_6_0)
	if not isNil(arg_6_0.gameObject_) then
		SetActive(arg_6_0.gameObject_, false)
	end

	if arg_6_0.talkBubbleShowTimer_ then
		arg_6_0.talkBubbleShowTimer_:Stop()

		arg_6_0.talkBubbleShowTimer_ = nil
	end

	if arg_6_0.talkBubbleHiderTimer_ then
		arg_6_0.talkBubbleHiderTimer_:Stop()

		arg_6_0.talkBubbleHiderTimer_ = nil
	end
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.talkBubbleHiderTimer_ then
		arg_7_0.talkBubbleHiderTimer_:Stop()

		arg_7_0.talkBubbleHiderTimer_ = nil
	end

	if arg_7_0.talkBubbleShowTimer_ then
		arg_7_0.talkBubbleShowTimer_:Stop()

		arg_7_0.talkBubbleShowTimer_ = nil
	end

	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
