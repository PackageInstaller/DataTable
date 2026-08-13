class = var_0_10000

local var_0_0 = var_0_10000("IslandMiniGameSceneLoader")

function var_0_0.Load(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.sceneIndex = arg_1_4 or 1
	pg = var_5

	local var_1_0 = var_5.UIMgr.GetInstance()

	var_5.LoadingOn(var_1_0, false)

	local var_1_1 = {
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.LoadScene(var_2_0, arg_1_1, arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick = var_2_10001

			var_2_10001(arg_3_0)

			return
		end,
		function(arg_4_0)
			onNextTick = var_2_10001

			var_2_10001(arg_4_0)

			return
		end,
		function(arg_5_0)
			onNextTick = var_2_10001

			var_2_10001(arg_5_0)

			return
		end
	}

	for iter_1_0 = 1, #arg_1_3 do
		table = var_1_10010

		var_1_10010.insert(var_1_1, #var_1_1, arg_1_3[iter_1_0])
	end

	seriesAsync = var_6

	var_6(var_1_1, function()
		gcAll = var_2_10000

		var_2_10000(true)

		pg = var_2_10000

		local var_6_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_6_0)

		return
	end)

	return
end

function var_0_0.LoadSceneWithProgress(arg_7_0, arg_7_1, arg_7_2)
	string = var_1_10003

	local var_7_0 = var_1_10003.lower(arg_7_1)

	string = var_1_10004

	local var_7_1 = var_1_10004.match(var_7_0, "[^/]+$")

	arg_7_0.scenePath = var_7_0 .. "_scene"
	arg_7_0.sceneName = var_7_1
	SceneOpBackgroundMgr = var_6

	local var_7_2 = var_6.Inst
	local var_7_3 = var_6.LoadSceneAsyncWithProgress
	local var_7_4 = var_5
	local var_7_5 = var_7_1

	LoadSceneMode = var_1_10011

	var_7_3(var_7_2, var_7_4, var_7_5, var_1_10011.Additive, function(arg_8_0)
		if arg_8_0 == 1 then
			onNextTick = var_2_10001

			var_2_10001(function()
				SceneOpBackgroundMgr = var_3_10000

				local var_9_0 = var_3_10000.Inst

				var_0.ActivatePendingScene(var_9_0)

				onNextTick = var_0

				var_0(function()
					CheatTavernCameraMgr = var_4_10000

					if var_4_10000.instance then
						CheatTavernCameraMgr = var_0
						var_0.instance._mainCamera.enabled = false
					end

					return
				end)

				return
			end)
		end

		arg_7_2(arg_8_0)

		return
	end)

	return
end

function var_0_0.LoadScene(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:LoadSceneWithProgress(arg_11_1, function(arg_12_0)
		if arg_12_0 == 1 then
			existCall = var_2_10001

			var_2_10001(arg_11_2)
		end

		return
	end)

	return
end

function var_0_0.UnLoad(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.scenePath
	local var_13_1 = arg_13_0.sceneName

	if not var_13_0 or not var_13_1 then
		return
	end

	if not arg_13_1 then
		pg = var_1_10004

		local var_13_2 = var_1_10004.UIMgr.GetInstance()

		var_1_10004.LoadingOn(var_13_2)

		SceneOpMgr = var_1_10004

		local var_13_3 = var_1_10004.Inst

		var_1_10004.UnloadSceneAsync(var_13_3, var_13_0, var_13_1, function()
			pg = var_2_10000

			local var_14_0 = var_2_10000.UIMgr.GetInstance()

			var_0.LoadingOff(var_14_0)

			return
		end)
	else
		SceneOpMgr = var_1_10004

		local var_13_4 = var_1_10004.Inst

		var_4.UnloadSceneAsync(var_13_4, var_13_0, var_13_1, function()
			return
		end)
	end

	arg_13_0.scenePath = nil
	arg_13_0.sceneName = nil

	return
end

function var_0_0.ActivatePendingScene(arg_16_0)
	return
end

function var_0_0.Dispose(arg_17_0, arg_17_1)
	arg_17_0:UnLoad(arg_17_1)

	return
end

return var_0_0
