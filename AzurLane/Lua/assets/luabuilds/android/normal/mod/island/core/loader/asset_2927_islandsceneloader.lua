class = var_0_10000

local var_0_0 = var_0_10000("IslandSceneLoader")

function var_0_0.Load(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.sceneIndex = arg_1_4 or 1
	pg = var_5

	local var_1_0 = var_5.UIMgr.GetInstance()

	var_5.LoadingOn(var_1_0, false)

	local var_1_1 = {
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.LoadProgressUI(var_2_0, arg_1_2, arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick = var_2_10001

			var_2_10001(arg_3_0)

			return
		end,
		function(arg_4_0)
			IslandHelper = var_2_10001

			var_2_10001.RunGC(true)

			onNextTick = var_1

			var_1(arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_1_0

			var_1.LoadScene(var_5_0, arg_1_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			onNextTick = var_2_10001

			var_2_10001(arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_1_0

			var_1.LoadNavigationMesh(var_7_0, arg_1_2, arg_7_0)

			return
		end,
		function(arg_8_0)
			onNextTick = var_2_10001

			var_2_10001(arg_8_0)

			return
		end,
		function(arg_9_0)
			onNextTick = var_2_10001

			var_2_10001(arg_9_0)

			return
		end
	}

	for iter_1_0 = 1, #arg_1_3 do
		table = var_1_10010

		var_1_10010.insert(var_1_1, #var_1_1, arg_1_3[iter_1_0])
	end

	seriesAsync = var_6

	var_6(var_1_1, function()
		local var_10_0 = arg_1_0

		var_0.UnloadProgressUI(var_10_0)

		pg = var_0

		local var_10_1 = var_0.UIMgr.GetInstance()

		var_0.LoadingOff(var_10_1)

		return
	end)

	return
end

function var_0_0.LoadProgressUI(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = "Dorm3DLoading"

	if var_0_0.lastMapId and arg_11_1 then
		pg = var_4

		if var_4.island_map[var_0_0.lastMapId].loading ~= 1 then
			pg = var_4

			if var_4.island_map[arg_11_1].loading == 1 then
				var_11_0 = "IslandplaneLoading"
			else
				var_11_0 = "IslandcarLoading"
			end

			local var_11_1 = var_0_0

			var_11_1.lastMapId = arg_11_1
			pg = var_11_1

			local var_11_2 = var_11_1.SceneAnimMgr.GetInstance()

			var_4.CommonSceneChange(var_11_2, var_11_0, function(arg_12_0)
				arg_11_0.resumeCallback = arg_12_0

				return arg_11_2()
			end)

			return
		end
	end
end

function var_0_0.UnloadProgressUI(arg_13_0)
	local var_13_0 = arg_13_0.resumeCallback

	arg_13_0.resumeCallback = nil
	existCall = var_2

	var_2(var_13_0)

	return
end

function var_0_0.LoadSceneWithProgress(arg_14_0, arg_14_1, arg_14_2)
	string = var_1_10003

	local var_14_0 = var_1_10003.lower(arg_14_1)

	string = var_4

	local var_14_1 = var_4.match(var_14_0, "[^/]+$")

	arg_14_0.scenePath = var_14_0 .. "_scene"
	arg_14_0.sceneName = var_14_1
	SceneOpMgr = var_6

	local var_14_2 = var_6.Inst
	local var_14_3 = var_6.LoadSceneAsyncWithProgress
	local var_14_4 = var_5
	local var_14_5 = var_14_1

	LoadSceneMode = var_1_10010

	var_14_3(var_14_2, var_14_4, var_14_5, var_1_10010.Additive, function(arg_15_0)
		if arg_15_0 == 1 then
			SceneOpMgr = var_2_10001

			local var_15_0 = var_2_10001.Inst

			var_1.SetActiveSceneByIndex(var_15_0, arg_14_0.sceneIndex)
		end

		arg_14_2(arg_15_0)

		return
	end)

	return
end

function var_0_0.LoadScene(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:LoadSceneWithProgress(arg_16_1, function(arg_17_0)
		if arg_17_0 == 1 then
			existCall = var_2_10001

			var_2_10001(arg_16_2)
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

	IslandConst = var_1_10003

	if arg_18_1 == var_1_10003.CheaterTavernMapId then
		arg_18_2()

		return
	end

	IslandAssetLoadDispatcher = var_3

	local var_18_0 = var_3.Instance
	local var_18_1 = var_3.Enqueue
	local var_18_2 = "island/Navmesh/" .. arg_18_1
	local var_18_3 = ""

	typeof = var_1_10007
	GameObject = var_1_10008

	local var_18_4 = var_1_10007(var_1_10008)

	UnityEngine = var_1_10008
	arg_18_0.navMeshLoadingId = var_18_1(var_18_0, var_18_2, var_18_3, var_18_4, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_19_0)
		assert = var_2_10001

		var_2_10001(arg_19_0, "导航网格不能为空>>>>>" .. arg_18_1)

		local var_19_0 = arg_18_0

		FrameAsyncInstantiateManager = var_2

		local var_19_1 = var_2.Instance

		var_19_0.navMeshInstId = var_2.EnqueueInstantiate(var_19_1, arg_19_0, function(arg_20_0)
			arg_18_2()

			return
		end)

		return
	end), true, true)

	return
end

function var_0_0.UnLoad(arg_21_0, arg_21_1)
	arg_21_0:UnloadProgressUI()

	local var_21_0 = arg_21_0.scenePath
	local var_21_1 = arg_21_0.sceneName

	if not var_21_0 or not var_21_1 then
		return
	end

	SceneOpMgr = var_1_10004

	local var_21_2 = var_1_10004.Inst

	var_4.UnloadSceneAsync(var_21_2, var_21_0, var_21_1, function()
		return
	end)

	arg_21_0.scenePath = nil
	arg_21_0.sceneName = nil

	return
end

function var_0_0.Dispose(arg_23_0, arg_23_1)
	arg_23_0:UnLoad(arg_23_1)

	if arg_23_0.navMeshInstId then
		FrameAsyncInstantiateManager = var_2

		local var_23_0 = var_2.Instance

		var_2.Cancel(var_23_0, arg_23_0.navMeshInstId)

		arg_23_0.navMeshInstId = nil
	end

	if arg_23_0.navMeshLoadingId then
		IslandAssetLoadDispatcher = var_2

		local var_23_1 = var_2.Instance

		var_2.Cancel(var_23_1, arg_23_0.navMeshLoadingId)

		arg_23_0.navMeshLoadingId = nil
	end

	return
end

return var_0_0
