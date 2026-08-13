class = var_0_10000

local var_0_0 = var_0_10000("ShipProfileCVLoader")

pg = var_1

local var_0_1 = var_1.ship_skin_words

function var_0_0.Ctor(arg_1_0)
	arg_1_0.loadedCVBankName = nil
	arg_1_0.loadedCVBattleBankName = nil
	arg_1_0.playbackInfo = nil
	arg_1_0.timers = {}

	return
end

function var_0_0.Load(arg_2_0, arg_2_1)
	arg_2_0:ClearSound()

	ShipWordHelper = var_2

	if var_2.ExistVoiceKey(arg_2_1) then
		ShipWordHelper = var_2

		local var_2_0 = var_2.RawGetCVKey(arg_2_1)

		arg_2_0:SetUp(var_2_0)
	end

	return
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	local function var_3_0()
		pg = var_2_10000

		local var_4_0 = var_2_10000.CriMgr.GetCVBankName(arg_3_1)

		pg = var_1

		local var_4_1 = var_1.CriMgr.GetBattleCVBankName(arg_3_1)

		if arg_3_0.exited then
			pg = var_2

			var_2.CriMgr.UnloadCVBank(var_4_0)

			pg = var_2

			var_2.CriMgr.UnloadCVBank(var_4_1)
		else
			arg_3_0.loadedCVBankName = var_4_0
			arg_3_0.loadedCVBattleBankName = var_4_1
		end

		return
	end

	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_5_0)
			pg = var_2_10001

			local var_5_0 = var_2_10001.CriMgr.GetInstance()

			var_1.LoadCV(var_5_0, arg_3_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			pg = var_2_10001

			local var_6_0 = var_2_10001.CriMgr.GetInstance()

			var_1.LoadBattleCV(var_6_0, arg_3_1, arg_6_0)

			return
		end
	}, var_3_0)

	return
end

function var_0_0.PlaySound(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.playbackInfo or arg_7_1 ~= arg_7_0.prevCvPath or arg_7_0.playbackInfo.channelPlayer == nil then
		arg_7_0:StopSound()

		pg = var_3

		local var_7_0 = var_3.CriMgr.GetInstance()

		var_3.PlaySoundEffect_V3(var_7_0, arg_7_1, function(arg_8_0)
			if arg_8_0 then
				arg_7_0.playbackInfo = arg_8_0

				local var_8_0 = arg_7_0.playbackInfo

				var_1.SetIgnoreAutoUnload(var_8_0, true)

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
		local var_7_1 = arg_7_0.playbackInfo

		var_3.PlaybackStop(var_7_1)

		local var_7_2 = arg_7_0.playbackInfo

		var_3.SetStartTimeAndPlay(var_7_2)

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
	local var_9_0 = arg_9_0

	arg_9_0.RemoveTimer(var_9_0, arg_9_1)

	if arg_9_2 > 0 then
		local var_9_1 = arg_9_0.timers

		Timer = var_9_0
		var_9_1[arg_9_1] = var_9_0.New(function()
			local var_10_0 = arg_9_0
			local var_10_1 = var_0.PlaySound(var_10_0, arg_9_1, function(arg_11_0)
				if arg_9_3 then
					arg_9_3(arg_11_0)
				end

				return
			end)

			return
		end, arg_9_2, 1)

		local var_9_2 = arg_9_0.timers[arg_9_1]

		var_4.Start(var_9_2)
	else
		local var_9_3 = arg_9_0:PlaySound(arg_9_1, function(arg_12_0)
			if arg_9_3 then
				arg_9_3(arg_12_0)
			end

			return
		end)
	end

	return
end

function var_0_0.RawPlaySound(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0

	arg_13_0.RemoveTimer(var_13_0, arg_13_1)

	local var_13_1

	if 0 < arg_13_2 then
		var_13_1 = arg_13_0.timers
		Timer = var_13_0
		var_13_1[arg_13_1] = var_13_0.New(function()
			pg = var_2_10000

			local var_14_0 = var_2_10000.CriMgr.GetInstance()

			var_0.PlaySoundEffect_V3(var_14_0, arg_13_1)

			return
		end, arg_13_2, 1)

		local var_13_2 = arg_13_0.timers[arg_13_1]

		var_13_1.Start(var_13_2)
	else
		pg = var_13_1

		local var_13_3 = var_13_1.CriMgr.GetInstance()

		var_3.PlaySoundEffect_V3(var_13_3, arg_13_1)
	end

	return
end

function var_0_0.RemoveTimer(arg_15_0, arg_15_1)
	if arg_15_0.timers[arg_15_1] then
		local var_15_0 = arg_15_0.timers[arg_15_1]

		var_2.Stop(var_15_0)

		arg_15_0.timers[arg_15_1] = nil
	end

	return
end

function var_0_0.StopSound(arg_16_0)
	if arg_16_0.playbackInfo then
		pg = var_1

		local var_16_0 = var_1.CriMgr.GetInstance()

		var_1.StopPlaybackInfoForce(var_16_0, arg_16_0.playbackInfo)

		local var_16_1 = arg_16_0.playbackInfo

		var_1.SetIgnoreAutoUnload(var_16_1, false)
	end

	return
end

function var_0_0.Unload(arg_17_0)
	if arg_17_0.loadedCVBankName then
		pg = var_1

		var_1.CriMgr.UnloadCVBank(arg_17_0.loadedCVBankName)

		arg_17_0.loadedCVBankName = nil
	end

	if arg_17_0.loadedCVBattleBankName then
		pg = var_1

		var_1.CriMgr.UnloadCVBank(arg_17_0.loadedCVBattleBankName)

		arg_17_0.loadedCVBattleBankName = nil
	end

	return
end

function var_0_0.ClearSound(arg_18_0)
	arg_18_0:StopSound()
	arg_18_0:Unload()

	if arg_18_0.playbackInfo then
		local var_18_0 = arg_18_0.playbackInfo

		var_1.Dispose(var_18_0)

		arg_18_0.playbackInfo = nil
	end

	return
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:ClearSound()

	arg_19_0.exited = true
	pairs = var_1

	for iter_19_0, iter_19_1 in var_1(arg_19_0.timers) do
		iter_19_1:Stop()
	end

	arg_19_0.timers = nil

	return
end

return var_0_0
