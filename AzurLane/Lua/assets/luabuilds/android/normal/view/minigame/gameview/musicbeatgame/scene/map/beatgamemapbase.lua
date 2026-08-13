class = var_0_10000

local var_0_0 = var_0_10000("BeatGameMapBase")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._data = arg_1_3
	arg_1_0._trackDic = {}

	arg_1_0:onInit()

	return
end

function var_0_0.addScore(arg_2_0, arg_2_1)
	if arg_2_1 > 0 then
		local var_2_0 = arg_2_0._event
		local var_2_1 = var_2.emit

		MusicBeatGameEvent = var_1_10004

		var_2_1(var_2_0, var_1_10004.ADD_SCORE, {
			num = arg_2_1
		})
	end

	return
end

function var_0_0.startTrack(arg_3_0, arg_3_1)
	arg_3_0:onStartTrack(arg_3_1)

	return
end

function var_0_0.setGameVo(arg_4_0, arg_4_1)
	arg_4_0._gameVo = arg_4_1

	return
end

function var_0_0.setSelect(arg_5_0, arg_5_1)
	arg_5_0._selectFlag = arg_5_1
	setActive = var_1_10002

	var_1_10002(arg_5_0._tf, arg_5_1)
	arg_5_0:onSelectChange()

	return
end

function var_0_0.clear(arg_6_0)
	arg_6_0._trackDic = {}

	arg_6_0:onClear()

	return
end

function var_0_0.dispose(arg_7_0)
	arg_7_0:onDispose()

	arg_7_0._tf = nil
	arg_7_0._data = nil
	arg_7_0._event = nil

	return
end

function var_0_0.step(arg_8_0)
	arg_8_0:onStep()

	return
end

function var_0_0.start(arg_9_0)
	arg_9_0:onStart()

	return
end

function var_0_0.stop(arg_10_0)
	arg_10_0:onStop()

	return
end

function var_0_0.resume(arg_11_0)
	arg_11_0:onResume()

	return
end

function var_0_0.onInit(arg_12_0)
	return
end

function var_0_0.onStart(arg_13_0)
	return
end

function var_0_0.onStop(arg_14_0)
	return
end

function var_0_0.onResume(arg_15_0)
	return
end

function var_0_0.onStartTrack(arg_16_0, arg_16_1)
	return
end

function var_0_0.onSelectChange(arg_17_0)
	return
end

function var_0_0.onClear(arg_18_0)
	return
end

function var_0_0.onDispose(arg_19_0)
	return
end

function var_0_0.onStep(arg_20_0)
	return
end

return var_0_0
