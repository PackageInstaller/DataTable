class = var_0_10000

local var_0_0 = "CourtYardBGMAgent"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardAgent"))
local var_0_2 = 0
local var_0_3 = 1

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.recoders = {}
	arg_1_0.playName = nil
	arg_1_0.waitForStop = false
	arg_1_0.defaultBgm = arg_1_0:GetDefaultBgm()

	arg_1_0:PlayVoice(arg_1_0.defaultBgm)

	return
end

function var_0_1.Play(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_1 or arg_2_1 == "" then
		return
	end

	arg_2_2 = arg_2_2 or var_0_2

	if not arg_2_0.recoders[arg_2_1] then
		arg_2_0.recoders = {}

		arg_2_0:PlayVoice(arg_2_1, function(arg_3_0)
			if arg_2_2 == var_0_3 then
				local var_3_0 = arg_2_0

				var_1.HandlePlayOnce(var_3_0, arg_3_0)
			end

			return
		end)
	end

	local var_2_0 = arg_2_0.recoders
	local var_2_1

	if not arg_2_0.recoders[arg_2_1] then
		var_2_1 = 0
	end

	var_2_0[arg_2_1] = var_2_1 + 1

	return
end

function var_0_1.HandlePlayOnce(arg_4_0, arg_4_1)
	long2int = var_1_10002

	local var_4_0 = var_1_10002(arg_4_1.length) * 0.001

	arg_4_0:AddTimerToStopBgm(var_4_0)

	return
end

function var_0_1.AddTimerToStopBgm(arg_5_0, arg_5_1)
	arg_5_0.waitForStop = true
	Timer = var_2
	arg_5_0.timer = var_2.New(function()
		local var_6_0 = arg_5_0

		var_0.Reset(var_6_0)

		arg_5_0.waitForStop = false

		return
	end, arg_5_1, 1)

	local var_5_0 = arg_5_0.timer

	var_2.Start(var_5_0)

	return
end

function var_0_1.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		local var_7_0 = arg_7_0.timer

		var_1.Stop(var_7_0)

		arg_7_0.timer = nil
	end

	return
end

function var_0_1.Stop(arg_8_0, arg_8_1)
	if arg_8_0.waitForStop then
		return
	end

	if not arg_8_0.recoders[arg_8_1] then
		return
	end

	arg_8_0.recoders[arg_8_1] = arg_8_0.recoders[arg_8_1] - 1

	if arg_8_0.recoders[arg_8_1] == 0 then
		arg_8_0:Reset()
	end

	return
end

function var_0_1.Reset(arg_9_0)
	arg_9_0.recoders = {}

	arg_9_0:PlayVoice(arg_9_0.defaultBgm)

	return
end

function var_0_1.PlayVoice(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.playName == arg_10_1 then
		return
	end

	local var_10_0 = "bgm-" .. arg_10_1

	CriWareMgr = var_4

	local var_10_1 = var_4.Inst
	local var_10_2 = var_4.PlayBGM
	local var_10_3 = var_10_0

	CriWareMgr = var_1_10008

	var_10_2(var_10_1, var_10_3, var_1_10008.CRI_FADE_TYPE.FADE_INOUT, function(arg_11_0)
		if arg_11_0 == nil then
			warning = var_2_10001

			local var_11_0 = "Missing BGM :"
			local var_11_1

			if not arg_10_1 then
				var_11_1 = "NIL"
			end

			var_2_10001(var_11_0 .. var_11_1)
		elseif arg_10_2 then
			arg_10_2(arg_11_0.cueInfo)
		end

		return
	end)

	arg_10_0.playName = arg_10_1

	return
end

function var_0_1.Clear(arg_12_0)
	arg_12_0:RemoveTimer()

	arg_12_0.recoders = {}
	arg_12_0.playName = nil
	arg_12_0.waitForStop = false
	pg = var_1

	local var_12_0 = var_1.CriMgr.GetInstance()

	var_1.StopBGM(var_12_0)

	return
end

function var_0_1.Dispose(arg_13_0)
	arg_13_0:Clear()

	arg_13_0.recoders = nil

	arg_13_0:RemoveTimer()

	return
end

return var_0_1
