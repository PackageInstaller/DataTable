local var_0_0 = class("MusicBeatMapCtrl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2

	arg_1_0._event:bind(MusicBeatGameEvent.TRACK_TRIGGER, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0.selectScene:startTrack(arg_2_1)

		return
	end)
	arg_1_0._event:bind(MusicBeatGameEvent.TRACK_REMOVE, function(arg_3_0, arg_3_1, arg_3_2)
		return
	end)

	return
end

function var_0_0.setGameVo(arg_4_0, arg_4_1)
	arg_4_0._gameVo = arg_4_1

	return
end

function var_0_0.readyStart(arg_5_0)
	arg_5_0:clear()

	arg_5_0.mapData = arg_5_0._gameVo:getMapData()

	arg_5_0:loadMapScene(arg_5_0.mapData.map_scene)
	arg_5_0:setSelectScene(1)

	for iter_5_0 = 1, #arg_5_0.mapScenes do
		arg_5_0.mapScenes[iter_5_0]:start()
	end

	return
end

function var_0_0.start(arg_6_0)
	return
end

function var_0_0.step(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0.mapScenes do
		arg_7_0.mapScenes[iter_7_0]:step()
	end

	return
end

function var_0_0.clear(arg_8_0)
	arg_8_0:clearMapScene()

	arg_8_0.curMapScene = nil

	return
end

function var_0_0.stop(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.mapScenes do
		arg_9_0.mapScenes[iter_9_0]:stop()
	end

	return
end

function var_0_0.resume(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.mapScenes do
		arg_10_0.mapScenes[iter_10_0]:resume()
	end

	return
end

function var_0_0.dispose(arg_11_0)
	for iter_11_0 = 1, #arg_11_0.mapScenes do
		arg_11_0.mapScenes[iter_11_0]:dispose()
	end

	return
end

function var_0_0.loadMapScene(arg_12_0, arg_12_1)
	arg_12_0:clearMapScene()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_0 = findTF(arg_12_0._tf, iter_12_1.name)
		local var_12_1

		if iter_12_1.type == MusicBeatGameConst.map_type_plane then
			var_12_1 = BeatGameMapPlane.New(var_12_0, arg_12_0._event, iter_12_1)
		end

		if var_12_1 then
			var_12_1:setGameVo(arg_12_0._gameVo)
			table.insert(arg_12_0.mapScenes, var_12_1)
		end
	end

	return
end

function var_0_0.clearMapScene(arg_13_0)
	if arg_13_0.mapScenes then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.mapScenes) do
			if iter_13_1 then
				iter_13_1:clear()
			end
		end
	end

	arg_13_0.mapScenes = {}

	return
end

function var_0_0.setSelectScene(arg_14_0, arg_14_1)
	if arg_14_0.selectScene then
		arg_14_0.selectScene:setSelect(false)
	end

	arg_14_0.selectScene = arg_14_0.mapScenes[arg_14_1]

	arg_14_0.selectScene:setSelect(true)

	return
end

return var_0_0
