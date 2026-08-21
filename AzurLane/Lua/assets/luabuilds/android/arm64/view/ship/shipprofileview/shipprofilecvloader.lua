local var_0_0 = class("ShipProfileCVLoader")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.loadedCVBankName = nil
	arg_1_0.loadedCVBattleBankName = nil
	arg_1_0.playbackInfo = nil
	arg_1_0.timers = {}

	return
end

function var_0_0.Load(arg_2_0, arg_2_1)
	arg_2_0:ClearSound()

	if ShipWordHelper.ExistVoiceKey(arg_2_1) then
		arg_2_0:SetUp((ShipWordHelper.RawGetCVKey(arg_2_1)))
	end

	return
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	seriesAsync({
		function(arg_5_0)
			pg.CriMgr.GetInstance():LoadCV(arg_3_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			pg.CriMgr.GetInstance():LoadBattleCV(arg_3_1, arg_6_0)

			return
		end
	}, function()
		local var_4_0 = pg.CriMgr.GetCVBankName(arg_3_1)
		local var_4_1 = pg.CriMgr.GetBattleCVBankName(arg_3_1)

		if arg_3_0.exited then
			pg.CriMgr.UnloadCVBank(var_4_0)
			pg.CriMgr.UnloadCVBank(var_4_1)
		else
			arg_3_0.loadedCVBankName = var_4_0
			arg_3_0.loadedCVBattleBankName = var_4_1
		end

		return
	end)

	return
end

function var_0_0.PlaySound(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.playbackInfo or arg_7_1 ~= arg_7_0.prevCvPath or arg_7_0.playbackInfo.channelPlayer == nil then
		arg_7_0:StopSound()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_7_1, function(arg_8_0)
			if arg_8_0 then
				arg_7_0.playbackInfo = arg_8_0

				arg_7_0.playbackInfo:SetIgnoreAutoUnload(true)

				if arg_7_2 then
					arg_7_2(arg_7_0.playbackInfo.cueInfo)
				end
			elseif arg_7_2 then
				arg_7_2()
			end

			return
		end)

		arg_7_0.prevCvPath = arg_7_1

		if arg_7_0.playbackInfo == nil then
			return nil
		end

		return arg_7_0.playbackInfo.cueInfo
	elseif arg_7_0.playbackInfo then
		arg_7_0.playbackInfo:PlaybackStop()
		arg_7_0.playbackInfo:SetStartTimeAndPlay()

		if arg_7_2 then
			arg_7_2(arg_7_0.playbackInfo.cueInfo)
		end

		return arg_7_0.playbackInfo.cueInfo
	elseif arg_7_2 then
		arg_7_2()
	end

	return nil
end

function var_0_0.DelayPlaySound(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0:RemoveTimer(arg_9_1)

	if arg_9_2 > 0 then
		arg_9_0.timers[arg_9_1] = Timer.New(function()
			local var_10_0 = arg_9_0:PlaySound(arg_9_1, function(arg_11_0)
				if arg_9_3 then
					arg_9_3(arg_11_0)
				end

				return
			end)

			return
		end, arg_9_2, 1)

		arg_9_0.timers[arg_9_1]:Start()
	else
		local var_9_0 = arg_9_0:PlaySound(arg_9_1, function(arg_12_0)
			if arg_9_3 then
				arg_9_3(arg_12_0)
			end

			return
		end)
	end

	return
end

function var_0_0.RawPlaySound(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:RemoveTimer(arg_13_1)

	if arg_13_2 > 0 then
		arg_13_0.timers[arg_13_1] = Timer.New(function()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_13_1)

			return
		end, arg_13_2, 1)

		arg_13_0.timers[arg_13_1]:Start()
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_13_1)
	end

	return
end

function var_0_0.RemoveTimer(arg_15_0, arg_15_1)
	if arg_15_0.timers[arg_15_1] then
		arg_15_0.timers[arg_15_1]:Stop()

		arg_15_0.timers[arg_15_1] = nil
	end

	return
end

function var_0_0.StopSound(arg_16_0)
	if arg_16_0.playbackInfo then
		pg.CriMgr.GetInstance():StopPlaybackInfoForce(arg_16_0.playbackInfo)
		arg_16_0.playbackInfo:SetIgnoreAutoUnload(false)
	end

	return
end

function var_0_0.Unload(arg_17_0)
	if arg_17_0.loadedCVBankName then
		pg.CriMgr.UnloadCVBank(arg_17_0.loadedCVBankName)

		arg_17_0.loadedCVBankName = nil
	end

	if arg_17_0.loadedCVBattleBankName then
		pg.CriMgr.UnloadCVBank(arg_17_0.loadedCVBattleBankName)

		arg_17_0.loadedCVBattleBankName = nil
	end

	return
end

function var_0_0.ClearSound(arg_18_0)
	arg_18_0:StopSound()
	arg_18_0:Unload()

	if arg_18_0.playbackInfo then
		arg_18_0.playbackInfo:Dispose()

		arg_18_0.playbackInfo = nil
	end

	return
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:ClearSound()

	arg_19_0.exited = true

	for iter_19_0, iter_19_1 in pairs(arg_19_0.timers) do
		iter_19_1:Stop()
	end

	arg_19_0.timers = nil

	return
end

return var_0_0
