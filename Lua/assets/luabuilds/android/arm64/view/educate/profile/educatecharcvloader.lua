local var_0_0 = class("EducateCharCvLoader")

function var_0_0.Play(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:Stop()

	if (arg_1_3 or 0) <= 0 then
		(function()
			pg.CriMgr.GetInstance():PlayCV_V3(arg_1_2, arg_1_1, function(arg_3_0)
				if arg_3_0 then
					arg_1_0._currentVoice = arg_3_0.playback

					arg_1_4(arg_3_0:GetLength() * 0.001)
				else
					arg_1_4(-1)
				end

				return
			end)

			return
		end)()
	else
		arg_1_0.timer = Timer.New(function()
			pg.CriMgr.GetInstance():PlayCV_V3(arg_1_2, arg_1_1, function(arg_3_0)
				if arg_3_0 then
					arg_1_0._currentVoice = arg_3_0.playback

					arg_1_4(arg_3_0:GetLength() * 0.001)
				else
					arg_1_4(-1)
				end

				return
			end)

			return
		end, arg_1_3, 1)

		arg_1_0.timer:Start()
	end

	return
end

function var_0_0.Stop(arg_4_0)
	arg_4_0:RemoveTimer()

	if arg_4_0._currentVoice then
		arg_4_0._currentVoice:Stop(true)
	end

	return
end

function var_0_0.Unload(arg_5_0)
	arg_5_0:Stop()

	return
end

function var_0_0.RemoveTimer(arg_6_0)
	if arg_6_0.timer then
		arg_6_0.timer:Stop()

		arg_6_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:Unload()

	return
end

return var_0_0
