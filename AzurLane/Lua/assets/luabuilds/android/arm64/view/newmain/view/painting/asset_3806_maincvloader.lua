class = var_0_10000

local var_0_0 = var_0_10000("MainCVLoader")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	return
end

function var_0_0.Load(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_0.preCvCueSheetName == arg_2_1 then
		arg_2_0:Play(arg_2_2, arg_2_3, arg_2_4)
	else
		arg_2_0:Unload()

		pg = var_5

		local var_2_0 = var_5.CriMgr.GetInstance()

		var_5.LoadCueSheet(var_2_0, arg_2_1, function(arg_3_0)
			arg_2_0.preCvCueSheetName = arg_2_1

			if arg_3_0 then
				local var_3_0 = arg_2_0

				var_1.Play(var_3_0, arg_2_2, arg_2_3, arg_2_4)
			else
				arg_2_4(-1)
			end

			return
		end)
	end

	return
end

function var_0_0.preloadCv(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	local var_4_0 = var_1_10003.CriMgr.GetInstance()

	var_3.LoadCueSheet(var_4_0, arg_4_1, function(arg_5_0)
		if arg_4_2 then
			arg_4_2()
		end

		return
	end)

	return
end

function var_0_0.Play(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:Stop()

	local function var_6_0()
		pg = var_2_10000

		local var_7_0 = var_2_10000.CriMgr.GetInstance()

		var_0.PlaySoundEffect_V3(var_7_0, arg_6_1, function(arg_8_0)
			if arg_8_0 then
				arg_6_0._currentVoice = arg_8_0.playback

				local var_8_0 = arg_8_0:GetLength() * 0.001

				arg_6_3(var_8_0)
			else
				arg_6_3(-1)
			end

			return
		end)

		return
	end

	if (arg_6_2 or 0) <= 0 then
		var_6_0()
	else
		Timer = var_5
		arg_6_0.timer = var_5.New(var_6_0, arg_6_2, 1)

		local var_6_1 = arg_6_0.timer

		var_5.Start(var_6_1)
	end

	return
end

function var_0_0.Stop(arg_9_0)
	arg_9_0:RemoveTimer()

	if arg_9_0._currentVoice then
		local var_9_0 = arg_9_0._currentVoice

		var_1.Stop(var_9_0, true)
	end

	return
end

function var_0_0.Unload(arg_10_0)
	arg_10_0:Stop()

	if arg_10_0.preCvCueSheetName then
		pg = var_1

		local var_10_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadCueSheet(var_10_0, arg_10_0.preCvCueSheetName)

		arg_10_0.preCvCueSheetName = nil
	end

	return
end

function var_0_0.RemoveTimer(arg_11_0)
	if arg_11_0.timer then
		local var_11_0 = arg_11_0.timer

		var_1.Stop(var_11_0)

		arg_11_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:Unload()

	return
end

return var_0_0
