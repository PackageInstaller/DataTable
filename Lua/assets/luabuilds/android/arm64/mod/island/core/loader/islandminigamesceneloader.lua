local var_0_0 = class("IslandMiniGameSceneLoader")

function var_0_0.Load(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.sceneIndex = arg_1_4 or 1

	pg.UIMgr.GetInstance():LoadingOn(false)

	for iter_1_0 = 1, #arg_1_3 do
		table.insert({
			function(arg_2_0)
				arg_1_0:LoadScene(arg_1_1, arg_2_0)

				return
			end,
			function(arg_3_0)
				onNextTick(arg_3_0)

				return
			end,
			function(arg_4_0)
				onNextTick(arg_4_0)

				return
			end,
			function(arg_5_0)
				onNextTick(arg_5_0)

				return
			end
		}, #{
			function(arg_2_0)
				arg_1_0:LoadScene(arg_1_1, arg_2_0)

				return
			end,
			function(arg_3_0)
				onNextTick(arg_3_0)

				return
			end,
			function(arg_4_0)
				onNextTick(arg_4_0)

				return
			end,
			function(arg_5_0)
				onNextTick(arg_5_0)

				return
			end
		}, arg_1_3[iter_1_0])
	end

	seriesAsync({
		function(arg_2_0)
			arg_1_0:LoadScene(arg_1_1, arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick(arg_3_0)

			return
		end,
		function(arg_4_0)
			onNextTick(arg_4_0)

			return
		end,
		function(arg_5_0)
			onNextTick(arg_5_0)

			return
		end
	}, function()
		gcAll(true)
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function var_0_0.LoadSceneWithProgress(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = string.lower(arg_7_1)
	local var_7_1 = string.match(var_7_0, "[^/]+$")

	arg_7_0.scenePath = var_7_0 .. "_scene"
	arg_7_0.sceneName = var_7_1

	SceneOpBackgroundMgr.Inst:LoadSceneAsyncWithProgress(var_7_0 .. "_scene", var_7_1, LoadSceneMode.Additive, function(arg_8_0)
		if arg_8_0 == 1 then
			onNextTick(function()
				SceneOpBackgroundMgr.Inst:ActivatePendingScene()
				onNextTick(function()
					if CheatTavernCameraMgr.instance then
						CheatTavernCameraMgr.instance._mainCamera.enabled = false
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
			existCall(arg_11_2)
		end

		return
	end)

	return
end

function var_0_0.UnLoad(arg_13_0, arg_13_1)
	if not arg_13_0.scenePath or not arg_13_0.sceneName then
		return
	end

	if not arg_13_1 then
		pg.UIMgr.GetInstance():LoadingOn()
		SceneOpMgr.Inst:UnloadSceneAsync(arg_13_0.scenePath, arg_13_0.sceneName, function()
			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)
	else
		SceneOpMgr.Inst:UnloadSceneAsync(arg_13_0.scenePath, arg_13_0.sceneName, function()
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
