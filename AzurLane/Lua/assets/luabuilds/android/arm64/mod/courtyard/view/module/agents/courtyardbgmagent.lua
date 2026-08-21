local var_0_0 = class("CourtYardBGMAgent", import(".CourtYardAgent"))
local var_0_1 = 0
local var_0_2 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.recoders = {}
	arg_1_0.playName = nil
	arg_1_0.waitForStop = false
	arg_1_0.defaultBgm = arg_1_0:GetDefaultBgm()

	arg_1_0:PlayVoice(arg_1_0.defaultBgm)

	return
end

function var_0_0.Play(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_1 or arg_2_1 == "" then
		return
	end

	arg_2_2 = arg_2_2 or var_0_1

	if not arg_2_0.recoders[arg_2_1] then
		arg_2_0.recoders = {}

		arg_2_0:PlayVoice(arg_2_1, function(arg_3_0)
			if arg_2_2 == var_0_2 then
				arg_2_0:HandlePlayOnce(arg_3_0)
			end

			return
		end)
	end

	local var_2_0 = arg_2_0.recoders
	local var_2_1 = arg_2_0.recoders[arg_2_1] or 0

	var_2_0[arg_2_1] = var_2_1 + 1

	return
end

function var_0_0.HandlePlayOnce(arg_4_0, arg_4_1)
	arg_4_0:AddTimerToStopBgm(long2int(arg_4_1.length) * 0.001)

	return
end

function var_0_0.AddTimerToStopBgm(arg_5_0, arg_5_1)
	arg_5_0.waitForStop = true
	arg_5_0.timer = Timer.New(function()
		arg_5_0:Reset()

		arg_5_0.waitForStop = false

		return
	end, arg_5_1, 1)

	arg_5_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		arg_7_0.timer:Stop()

		arg_7_0.timer = nil
	end

	return
end

function var_0_0.Stop(arg_8_0, arg_8_1)
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

function var_0_0.Reset(arg_9_0)
	arg_9_0.recoders = {}

	arg_9_0:PlayVoice(arg_9_0.defaultBgm)

	return
end

function var_0_0.PlayVoice(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.playName == arg_10_1 then
		return
	end

	CriWareMgr.Inst:PlayBGM("bgm-" .. arg_10_1, CriWareMgr.CRI_FADE_TYPE.FADE_INOUT, function(arg_11_0)
		if arg_11_0 == nil then
			local var_11_0 = arg_10_1 or "NIL"

			warning("Missing BGM :" .. var_11_0)
		elseif arg_10_2 then
			arg_10_2(arg_11_0.cueInfo)
		end

		return
	end)

	arg_10_0.playName = arg_10_1

	return
end

function var_0_0.Clear(arg_12_0)
	arg_12_0:RemoveTimer()

	arg_12_0.recoders = {}
	arg_12_0.playName = nil
	arg_12_0.waitForStop = false

	pg.CriMgr.GetInstance():StopBGM()

	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:Clear()

	arg_13_0.recoders = nil

	arg_13_0:RemoveTimer()

	return
end

return var_0_0
