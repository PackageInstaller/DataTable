local var_0_0 = class("T0LuaSubtitleData")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.formID = arg_1_1
	arg_1_0.file = arg_1_2
	arg_1_0.displayStartTime = arg_1_3
	arg_1_0.displayEndTime = arg_1_4
	arg_1_0.onEndDisplayCallback = arg_1_5
end

function var_0_0.IsShow(arg_2_0)
	local var_2_0 = Time.time

	return not arg_2_0:IsWaiting() and var_2_0 < arg_2_0.displayEndTime
end

function var_0_0.IsWaiting(arg_3_0)
	return Time.time < arg_3_0.displayStartTime
end

function var_0_0.OnEndDisplay(arg_4_0)
	if arg_4_0.onEndDisplayCallback then
		LuaExchangeHelper.ActionInvoke(arg_4_0.onEndDisplayCallback)
	end
end

function var_0_0.OnDispose(arg_5_0)
	arg_5_0.onEndDisplayCallback = nil
end

function var_0_0.GetContent(arg_6_0)
	local var_6_0 = HeroTools.FindMatchSkinVoiceID(arg_6_0.formID, arg_6_0.file)

	return HeroVoiceDescCfg.Get(arg_6_0.formID, var_6_0)
end

function var_0_0.GetKey(arg_7_0)
	return T0WorldTools.GetCharacterShowName(arg_7_0.formID)
end

return var_0_0
