class = var_0_10000

local var_0_0 = var_0_10000("MusicBeatGameScene")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	findTF = var_1_10004
	arg_1_0.sceneMask = var_1_10004(arg_1_0._tf, "sceneMask")
	findTF = var_4
	arg_1_0.sceneContainer = var_4(arg_1_0._tf, "sceneMask/sceneContainer")

	arg_1_0:showContainer(false)

	MusicBeatBgmCtrl = var_4
	arg_1_0.bgmController = var_4.New(arg_1_0._event)
	MusicBeatMapCtrl = var_4
	arg_1_0.mapController = var_4.New(arg_1_0.sceneContainer, arg_1_0._event)
	MusicBeatNoteCtrl = var_4
	arg_1_0.noteController = var_4.New(arg_1_0.sceneContainer, arg_1_0._event)

	local var_1_0 = arg_1_0.bgmController

	var_4.setGameVo(var_1_0, arg_1_0._gameVo)

	local var_1_1 = arg_1_0.mapController

	var_4.setGameVo(var_1_1, arg_1_0._gameVo)

	local var_1_2 = arg_1_0.noteController

	var_4.setGameVo(var_1_2, arg_1_0._gameVo)

	return
end

function var_0_0.readyStart(arg_2_0)
	arg_2_0:showContainer(true)

	local var_2_0 = arg_2_0.bgmController

	var_1.readyStart(var_2_0)

	local var_2_1 = arg_2_0.mapController

	var_1.readyStart(var_2_1)

	local var_2_2 = arg_2_0.noteController

	var_1.readyStart(var_2_2)

	return
end

function var_0_0.start(arg_3_0)
	local var_3_0 = arg_3_0.bgmController

	var_1.start(var_3_0)

	local var_3_1 = arg_3_0.mapController

	var_1.start(var_3_1)

	local var_3_2 = arg_3_0.noteController

	var_1.start(var_3_2)

	return
end

function var_0_0.step(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.bgmController

	var_2.step(var_4_0, arg_4_1)

	local var_4_1 = arg_4_0.mapController

	var_2.step(var_4_1, arg_4_1)

	local var_4_2 = arg_4_0.noteController

	var_2.step(var_4_2, arg_4_1)

	return
end

function var_0_0.clear(arg_5_0)
	local var_5_0 = arg_5_0.bgmController

	var_1.clear(var_5_0)

	local var_5_1 = arg_5_0.mapController

	var_1.clear(var_5_1)

	local var_5_2 = arg_5_0.noteController

	var_1.clear(var_5_2)

	return
end

function var_0_0.stop(arg_6_0)
	local var_6_0 = arg_6_0.bgmController

	var_1.stop(var_6_0)

	local var_6_1 = arg_6_0.mapController

	var_1.stop(var_6_1)

	local var_6_2 = arg_6_0.noteController

	var_1.stop(var_6_2)

	return
end

function var_0_0.resume(arg_7_0)
	local var_7_0 = arg_7_0.bgmController

	var_1.resume(var_7_0)

	local var_7_1 = arg_7_0.mapController

	var_1.resume(var_7_1)

	local var_7_2 = arg_7_0.noteController

	var_1.resume(var_7_2)

	return
end

function var_0_0.dispose(arg_8_0)
	local var_8_0 = arg_8_0.bgmController

	var_1.dispose(var_8_0)

	local var_8_1 = arg_8_0.mapController

	var_1.dispose(var_8_1)

	local var_8_2 = arg_8_0.noteController

	var_1.dispose(var_8_2)

	return
end

function var_0_0.showContainer(arg_9_0, arg_9_1)
	setActive = var_1_10002

	var_1_10002(arg_9_0.sceneMask, arg_9_1)

	return
end

return var_0_0
