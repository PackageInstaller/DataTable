local var_0_0 = class("CryptolaliaSoundPlayer")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	return
end

function var_0_0.Load(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_0.preCvCueSheetName == arg_2_1 then
		arg_2_0:Play(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	else
		arg_2_0:Unload()
		pg.CriMgr.GetInstance():LoadCueSheet(arg_2_1, function(arg_3_0)
			arg_2_0.preCvCueSheetName = arg_2_1

			if arg_3_0 then
				arg_2_0:Play(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
			else
				arg_2_4(-1)
			end

			return
		end)
	end

	return
end

function var_0_0.Play(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0:Stop()

	if (arg_4_3 or 0) <= 0 then
		(function()
			pg.CriMgr.GetInstance():PlayCV_V3(arg_4_1, arg_4_2, function(arg_6_0)
				if arg_6_0 then
					arg_4_0._currentVoice = arg_6_0.playback

					arg_4_4(arg_6_0:GetLength() * 0.001)
				else
					arg_4_4(-1)
				end

				return
			end)

			return
		end)()
	else
		arg_4_0.timer = Timer.New(function()
			pg.CriMgr.GetInstance():PlayCV_V3(arg_4_1, arg_4_2, function(arg_6_0)
				if arg_6_0 then
					arg_4_0._currentVoice = arg_6_0.playback

					arg_4_4(arg_6_0:GetLength() * 0.001)
				else
					arg_4_4(-1)
				end

				return
			end)

			return
		end, arg_4_3, 1)

		arg_4_0.timer:Start()
	end

	return
end

function var_0_0.Stop(arg_7_0)
	arg_7_0:RemoveTimer()

	if arg_7_0._currentVoice then
		arg_7_0._currentVoice:Stop(true)
	end

	return
end

function var_0_0.Unload(arg_8_0)
	arg_8_0:Stop()

	if arg_8_0.preCvCueSheetName then
		pg.CriMgr.GetInstance():UnloadCueSheet(arg_8_0.preCvCueSheetName)

		arg_8_0.preCvCueSheetName = nil
	end

	return
end

function var_0_0.RemoveTimer(arg_9_0)
	if arg_9_0.timer then
		arg_9_0.timer:Stop()

		arg_9_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:Unload()

	return
end

return var_0_0
