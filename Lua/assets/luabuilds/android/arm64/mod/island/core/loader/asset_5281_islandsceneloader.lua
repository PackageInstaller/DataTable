local IslandSceneLoader = class("IslandSceneLoader")

function IslandSceneLoader:Load(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.sceneIndex = arg_1_4 or 1

	pg.UIMgr.GetInstance():LoadingOn(false)

	local var_1_0 = {
		function(arg_2_0)
			self:LoadProgressUI(arg_1_2, arg_2_0)

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
			self:LoadScene(arg_1_1, arg_5_0)

			return
		end,
		function(arg_6_0)
			onNextTick(arg_6_0)

			return
		end,
		function(arg_7_0)
			self:LoadNavigationMesh(arg_1_2, arg_7_0)

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
	}

	for iter_1_0 = 1, #arg_1_3 do
		table.insert(var_1_0, #var_1_0, arg_1_3[iter_1_0])
	end

	seriesAsync(var_1_0, function()
		self:UnloadProgressUI()
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function IslandSceneLoader:LoadProgressUI(arg_11_1, arg_11_2)
	local var_11_0 = "Dorm3DLoading"

	if IslandSceneLoader.lastMapId and arg_11_1 then
		var_11_0 = (pg.island_map[IslandSceneLoader.lastMapId].loading == 1 or pg.island_map[arg_11_1].loading == 1) and "IslandplaneLoading" or "IslandcarLoading"
	end

	IslandSceneLoader.lastMapId = arg_11_1

	pg.SceneAnimMgr.GetInstance():CommonSceneChange(var_11_0, function(arg_12_0)
		self.resumeCallback = arg_12_0

		return arg_11_2()
	end)

	return
end

function IslandSceneLoader:UnloadProgressUI()
	self.resumeCallback = nil

	existCall(self.resumeCallback)

	return
end

function IslandSceneLoader:LoadSceneWithProgress(arg_14_1, arg_14_2)
	local var_14_0 = string.lower(arg_14_1)
	local var_14_1 = string.match(var_14_0, "[^/]+$")

	self.scenePath = var_14_0 .. "_scene"
	self.sceneName = var_14_1

	SceneOpMgr.Inst:LoadSceneAsyncWithProgress(var_14_0 .. "_scene", var_14_1, LoadSceneMode.Additive, function(arg_15_0)
		if arg_15_0 == 1 then
			SceneOpMgr.Inst:SetActiveSceneByIndex(self.sceneIndex)
		end

		arg_14_2(arg_15_0)

		return
	end)

	return
end

function IslandSceneLoader:LoadScene(arg_16_1, arg_16_2)
	self:LoadSceneWithProgress(arg_16_1, function(arg_17_0)
		if arg_17_0 == 1 then
			existCall(arg_16_2)
		end

		return
	end)

	return
end

function IslandSceneLoader:LoadNavigationMesh(arg_18_1, arg_18_2)
	if not arg_18_1 then
		arg_18_2()

		return
	end

	if arg_18_1 == IslandConst.CheaterTavernMapId then
		arg_18_2()

		return
	end

	self.navMeshLoadingId = IslandAssetLoadDispatcher.Instance:Enqueue("island/Navmesh/" .. arg_18_1, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_19_0)
		assert(arg_19_0, "导航网格不能为空>>>>>" .. arg_18_1)

		self.navMeshInstId = FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(arg_19_0, function(arg_20_0)
			arg_18_2()

			return
		end)

		return
	end), true, true)

	return
end

function IslandSceneLoader:UnLoad(arg_21_1)
	self:UnloadProgressUI()

	if not self.scenePath or not self.sceneName then
		return
	end

	SceneOpMgr.Inst:UnloadSceneAsync(self.scenePath, self.sceneName, function()
		return
	end)

	self.scenePath = nil
	self.sceneName = nil

	return
end

function IslandSceneLoader:Dispose(arg_23_1)
	self:UnLoad(arg_23_1)

	if self.navMeshInstId then
		FrameAsyncInstantiateManager.Instance:Cancel(self.navMeshInstId)

		self.navMeshInstId = nil
	end

	if self.navMeshLoadingId then
		IslandAssetLoadDispatcher.Instance:Cancel(self.navMeshLoadingId)

		self.navMeshLoadingId = nil
	end

	return
end

return IslandSceneLoader
