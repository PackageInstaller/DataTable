local var_0_0 = class("DanceGameTaskRunner", DormTaskRunner)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.offset = 0
end

function var_0_0.SetPlayback(arg_2_0, arg_2_1)
	arg_2_0.playSrc = arg_2_1
	arg_2_0.offset = 0
end

function var_0_0.Time(arg_3_0)
	if arg_3_0.playSrc == nil then
		return 0
	end

	local var_3_0
	local var_3_1
	local var_3_2, var_3_3 = int64.tonum2(arg_3_0.playSrc:GetTimeSyncedWithAudio())
	local var_3_4 = var_3_3
	local var_3_5 = var_3_2 + arg_3_0.offset

	if arg_3_0.lastUpdate and var_3_5 < arg_3_0.lastUpdate then
		local var_3_6, var_3_7 = int64.tonum2(arg_3_0.playSrc:GetTime())

		arg_3_0.offset, var_3_5 = var_3_6 - var_3_5, var_3_6
	end

	return var_3_5 / 1000
end

function var_0_0.Reset(arg_4_0)
	arg_4_0.playSrc = nil
	arg_4_0.offset = 0

	var_0_0.super.Reset(arg_4_0)
end

return var_0_0
