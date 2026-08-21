local var_0_0 = class("IslandSceneLoader")

function var_0_0.Load(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.sceneIndex = arg_1_4 or 1

	pg.UIMgr.GetInstance():LoadingOn(false)

	for iter_1_0 = 1, #arg_1_3 do
		table.insert({
			function(arg_2_0)
				arg_1_0:LoadProgressUI(arg_1_2, arg_2_0)

				return
			end,
			function(arg_3_0)
				onNextTick(arg_3_0)

				return
			end,
			function(arg_4_0)
				IslandHelper.RunGC(true)
				onNextTick(arg_4_0)

				return
			end,
			function(arg_5_0)
				arg_1_0:LoadScene(arg_1_1, arg_5_0)

				return
			end,
			function(arg_6_0)
				onNextTick(arg_6_0)

				return
			end,
			function(arg_7_0)
				arg_1_0:LoadNavigationMesh(arg_1_2, arg_7_0)

				return
			end,
			function(arg_8_0)
				onNextTick(arg_8_0)

				return
			end,
			function(arg_9_0)
				onNextTick(arg_9_0)

				return
			end
		}, #{
			function(arg_2_0)
				arg_1_0:LoadProgressUI(arg_1_2, arg_2_0)

				return
			end,
			function(arg_3_0)
				onNextTick(arg_3_0)

				return
			end,
			function(arg_4_0)
				IslandHelper.RunGC(true)
				onNextTick(arg_4_0)

				return
			end,
			function(arg_5_0)
				arg_1_0:LoadScene(arg_1_1, arg_5_0)

				return
			end,
			function(arg_6_0)
				onNextTick(arg_6_0)

				return
			end,
			function(arg_7_0)
				arg_1_0:LoadNavigationMesh(arg_1_2, arg_7_0)

				return
			end,
			function(arg_8_0)
				onNextTick(arg_8_0)

				return
			end,
			function(arg_9_0)
				onNextTick(arg_9_0)

				return
			end
		}, arg_1_3[iter_1_0])
	end

	seriesAsync({
		function(arg_2_0)
			arg_1_0:LoadProgressUI(arg_1_2, arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick(arg_3_0)

			return
		end,
		function(arg_4_0)
			IslandHelper.RunGC(true)
			onNextTick(arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_1_0:LoadScene(arg_1_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			onNextTick(arg_6_0)

			return
		end,
		function(arg_7_0)
			arg_1_0:LoadNavigationMesh(arg_1_2, arg_7_0)

			return
		end,
		function(arg_8_0)
			onNextTick(arg_8_0)

			return
		end,
		function(arg_9_0)
			onNextTick(arg_9_0)

			return
		end
	}, function()
		arg_1_0:UnloadProgressUI()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function var_0_0.LoadProgressUI(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = "Dorm3DLoading"

	if var_0_0.lastMapId and arg_11_1 then
		var_11_0 = (pg.island_map[var_0_0.lastMapId].loading == 1 or pg.island_map[arg_11_1].loading == 1) and "IslandplaneLoading" or "IslandcarLoading"
	end

	var_0_0.lastMapId = arg_11_1

	pg.SceneAnimMgr.GetInstance():CommonSceneChange(var_11_0, function(arg_12_0)
		arg_11_0.resumeCallback = arg_12_0

		return arg_11_2()
	end)

	return
end

function var_0_0.UnloadProgressUI(arg_13_0)
	arg_13_0.resumeCallback = nil

	existCall(arg_13_0.resumeCallback)

	return
end

function var_0_0.LoadSceneWithProgress(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = string.lower(arg_14_1)
	local var_14_1 = string.match(var_14_0, "[^/]+$")

	arg_14_0.scenePath = var_14_0 .. "_scene"
	arg_14_0.sceneName = var_14_1

	SceneOpMgr.Inst:LoadSceneAsyncWithProgress(var_14_0 .. "_scene", var_14_1, LoadSceneMode.Additive, function(arg_15_0)
		if arg_15_0 == 1 then
			SceneOpMgr.Inst:SetActiveSceneByIndex(arg_14_0.sceneIndex)
		end

		arg_14_2(arg_15_0)

		return
	end)

	return
end

function var_0_0.LoadScene(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:LoadSceneWithProgress(arg_16_1, function(arg_17_0)
		if arg_17_0 == 1 then
			existCall(arg_16_2)
		end

		return
	end)

	return
end

function var_0_0.LoadNavigationMesh(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		arg_18_2()

		return
	end

	if arg_18_1 == IslandConst.CheaterTavernMapId then
		arg_18_2()

		return
	end

	arg_18_0.navMeshLoadingId = IslandAssetLoadDispatcher.Instance:Enqueue("island/Navmesh/" .. arg_18_1, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_19_0)
		assert(arg_19_0, "导航网格不能为空>>>>>" .. arg_18_1)

		arg_18_0.navMeshInstId = FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(arg_19_0, function(arg_20_0)
			arg_18_2()

			return
		end)

		return
	end), true, true)

	return
end

function var_0_0.UnLoad(arg_21_0, arg_21_1)
	arg_21_0:UnloadProgressUI()

	if not arg_21_0.scenePath or not arg_21_0.sceneName then
		return
	end

	SceneOpMgr.Inst:UnloadSceneAsync(arg_21_0.scenePath, arg_21_0.sceneName, function()
		return
	end)

	arg_21_0.scenePath = nil
	arg_21_0.sceneName = nil

	return
end

function var_0_0.Dispose(arg_23_0, arg_23_1)
	arg_23_0:UnLoad(arg_23_1)

	if arg_23_0.navMeshInstId then
		FrameAsyncInstantiateManager.Instance:Cancel(arg_23_0.navMeshInstId)

		arg_23_0.navMeshInstId = nil
	end

	if arg_23_0.navMeshLoadingId then
		IslandAssetLoadDispatcher.Instance:Cancel(arg_23_0.navMeshLoadingId)

		arg_23_0.navMeshLoadingId = nil
	end

	return
end

return var_0_0
