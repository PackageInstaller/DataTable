class = var_0_10000

local var_0_0 = "CourtYardSoundAgent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardAgent"))

function var_0_1.Play(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	arg_1_0:Stop()

	arg_1_0.curVoiceKey = arg_1_1
	pg = var_2

	local var_1_0 = var_2.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_1_0, arg_1_0.curVoiceKey)

	return
end

function var_0_1.Stop(arg_2_0)
	if arg_2_0.curVoiceKey ~= nil then
		pg = var_1

		local var_2_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_2_0, arg_2_0.curVoiceKey)
	end

	arg_2_0.curVoiceKey = nil

	return
end

function var_0_1.Clear(arg_3_0)
	arg_3_0:Stop()

	return
end

function var_0_1.Dispose(arg_4_0)
	arg_4_0:Stop()

	return
end

return var_0_1
