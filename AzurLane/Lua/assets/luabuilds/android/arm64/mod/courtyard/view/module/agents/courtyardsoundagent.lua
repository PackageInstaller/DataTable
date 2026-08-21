local var_0_0 = class("CourtYardSoundAgent", import(".CourtYardAgent"))

function var_0_0.Play(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	arg_1_0:Stop()

	arg_1_0.curVoiceKey = arg_1_1

	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_1_0.curVoiceKey)

	return
end

function var_0_0.Stop(arg_2_0)
	if arg_2_0.curVoiceKey ~= nil then
		pg.CriMgr.GetInstance():UnloadSoundEffect_V3(arg_2_0.curVoiceKey)
	end

	arg_2_0.curVoiceKey = nil

	return
end

function var_0_0.Clear(arg_3_0)
	arg_3_0:Stop()

	return
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0:Stop()

	return
end

return var_0_0
