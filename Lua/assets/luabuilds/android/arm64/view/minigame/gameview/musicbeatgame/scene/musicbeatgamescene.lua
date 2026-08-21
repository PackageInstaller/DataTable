local var_0_0 = class("MusicBeatGameScene")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3
	arg_1_0.sceneMask = findTF(arg_1_0._tf, "sceneMask")
	arg_1_0.sceneContainer = findTF(arg_1_0._tf, "sceneMask/sceneContainer")

	arg_1_0:showContainer(false)

	arg_1_0.bgmController = MusicBeatBgmCtrl.New(arg_1_0._event)
	arg_1_0.mapController = MusicBeatMapCtrl.New(arg_1_0.sceneContainer, arg_1_0._event)
	arg_1_0.noteController = MusicBeatNoteCtrl.New(arg_1_0.sceneContainer, arg_1_0._event)

	arg_1_0.bgmController:setGameVo(arg_1_0._gameVo)
	arg_1_0.mapController:setGameVo(arg_1_0._gameVo)
	arg_1_0.noteController:setGameVo(arg_1_0._gameVo)

	return
end

function var_0_0.readyStart(arg_2_0)
	arg_2_0:showContainer(true)
	arg_2_0.bgmController:readyStart()
	arg_2_0.mapController:readyStart()
	arg_2_0.noteController:readyStart()

	return
end

function var_0_0.start(arg_3_0)
	arg_3_0.bgmController:start()
	arg_3_0.mapController:start()
	arg_3_0.noteController:start()

	return
end

function var_0_0.step(arg_4_0, arg_4_1)
	arg_4_0.bgmController:step(arg_4_1)
	arg_4_0.mapController:step(arg_4_1)
	arg_4_0.noteController:step(arg_4_1)

	return
end

function var_0_0.clear(arg_5_0)
	arg_5_0.bgmController:clear()
	arg_5_0.mapController:clear()
	arg_5_0.noteController:clear()

	return
end

function var_0_0.stop(arg_6_0)
	arg_6_0.bgmController:stop()
	arg_6_0.mapController:stop()
	arg_6_0.noteController:stop()

	return
end

function var_0_0.resume(arg_7_0)
	arg_7_0.bgmController:resume()
	arg_7_0.mapController:resume()
	arg_7_0.noteController:resume()

	return
end

function var_0_0.dispose(arg_8_0)
	arg_8_0.bgmController:dispose()
	arg_8_0.mapController:dispose()
	arg_8_0.noteController:dispose()

	return
end

function var_0_0.showContainer(arg_9_0, arg_9_1)
	setActive(arg_9_0.sceneMask, arg_9_1)

	return
end

return var_0_0
