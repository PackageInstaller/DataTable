class = var_0_10000

local var_0_0 = var_0_10000("EducateCharCvLoader")

function var_0_0.Play(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:Stop()

	local function var_1_0()
		pg = var_2_10000

		local var_2_0 = var_2_10000.CriMgr.GetInstance()

		var_0.PlayCV_V3(var_2_0, arg_1_2, arg_1_1, function(arg_3_0)
			if arg_3_0 then
				local var_3_0 = arg_3_0:GetLength() * 0.001

				arg_1_0._currentVoice = arg_3_0.playback

				arg_1_4(var_3_0)
			else
				arg_1_4(-1)
			end

			return
		end)

		return
	end

	if (arg_1_3 or 0) <= 0 then
		var_1_0()
	else
		Timer = var_6
		arg_1_0.timer = var_6.New(var_1_0, arg_1_3, 1)

		local var_1_1 = arg_1_0.timer

		var_6.Start(var_1_1)
	end

	return
end

function var_0_0.Stop(arg_4_0)
	arg_4_0:RemoveTimer()

	if arg_4_0._currentVoice then
		local var_4_0 = arg_4_0._currentVoice

		var_1.Stop(var_4_0, true)
	end

	return
end

function var_0_0.Unload(arg_5_0)
	arg_5_0:Stop()

	return
end

function var_0_0.RemoveTimer(arg_6_0)
	if arg_6_0.timer then
		local var_6_0 = arg_6_0.timer

		var_1.Stop(var_6_0)

		arg_6_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:Unload()

	return
end

return var_0_0
