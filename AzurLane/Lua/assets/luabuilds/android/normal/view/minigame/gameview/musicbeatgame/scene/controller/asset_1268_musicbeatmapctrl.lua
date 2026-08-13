class = var_0_10000

local var_0_0 = var_0_10000("MusicBeatMapCtrl")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2

	local var_1_0 = arg_1_0._event
	local var_1_1 = var_3.bind

	MusicBeatGameEvent = var_1_10005

	var_1_1(var_1_0, var_1_10005.TRACK_TRIGGER, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0.selectScene

		var_3.startTrack(var_2_0, arg_2_1)

		return
	end)

	local var_1_2 = arg_1_0._event
	local var_1_3 = var_3.bind

	MusicBeatGameEvent = var_5

	var_1_3(var_1_2, var_5.TRACK_REMOVE, function(arg_3_0, arg_3_1, arg_3_2)
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

	local var_5_0 = arg_5_0._gameVo

	arg_5_0.mapData = var_1.getMapData(var_5_0)

	arg_5_0:loadMapScene(arg_5_0.mapData.map_scene)
	arg_5_0:setSelectScene(1)

	for iter_5_0 = 1, #arg_5_0.mapScenes do
		local var_5_1 = arg_5_0.mapScenes[iter_5_0]

		var_5.start(var_5_1)
	end

	return
end

function var_0_0.start(arg_6_0)
	return
end

function var_0_0.step(arg_7_0, arg_7_1)
	for iter_7_0 = 1, #arg_7_0.mapScenes do
		local var_7_0 = arg_7_0.mapScenes[iter_7_0]

		var_6.step(var_7_0)
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
		local var_9_0 = arg_9_0.mapScenes[iter_9_0]

		var_5.stop(var_9_0)
	end

	return
end

function var_0_0.resume(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.mapScenes do
		local var_10_0 = arg_10_0.mapScenes[iter_10_0]

		var_5.resume(var_10_0)
	end

	return
end

function var_0_0.dispose(arg_11_0)
	for iter_11_0 = 1, #arg_11_0.mapScenes do
		local var_11_0 = arg_11_0.mapScenes[iter_11_0]

		var_5.dispose(var_11_0)
	end

	return
end

function var_0_0.loadMapScene(arg_12_0, arg_12_1)
	arg_12_0:clearMapScene()

	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(arg_12_1) do
		local var_12_0 = iter_12_1.type
		local var_12_1 = iter_12_1.name

		findTF = var_1_10009
		var_1_10009 = var_1_10009(arg_12_0._tf, var_12_1)

		local var_12_2

		MusicBeatGameConst = var_11

		if var_12_0 == var_11.map_type_plane then
			BeatGameMapPlane = var_11
			var_12_2 = var_11.New(var_1_10009, arg_12_0._event, iter_12_1)
		end

		if var_12_2 then
			var_12_2:setGameVo(arg_12_0._gameVo)

			table = var_11

			var_11.insert(arg_12_0.mapScenes, var_12_2)
		end
	end

	return
end

function var_0_0.clearMapScene(arg_13_0)
	if arg_13_0.mapScenes then
		ipairs = var_1

		for iter_13_0, iter_13_1 in var_1(arg_13_0.mapScenes) do
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
		local var_14_0 = arg_14_0.selectScene

		var_2.setSelect(var_14_0, false)
	end

	arg_14_0.selectScene = arg_14_0.mapScenes[arg_14_1]

	local var_14_1 = arg_14_0.selectScene

	var_2.setSelect(var_14_1, true)

	return
end

return var_0_0
