local IslandMiniGameSceneLoader = class("IslandMiniGameSceneLoader")

function IslandMiniGameSceneLoader:Load(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.sceneIndex = arg_1_4 or 1

	pg.UIMgr.GetInstance():LoadingOn(false)

	local var_1_0 = {
		function(arg_2_0)
			self:LoadScene(arg_1_1, arg_2_0)

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
	}

	for iter_1_0 = 1, #arg_1_3 do
		table.insert(var_1_0, #var_1_0, arg_1_3[iter_1_0])
	end

	seriesAsync(var_1_0, function()
		gcAll(true)
		pg.UIMgr.GetInstance():LoadingOff()

		return
	end)

	return
end

function IslandMiniGameSceneLoader:LoadSceneWithProgress(arg_7_1, arg_7_2)
	local var_7_0 = string.lower(arg_7_1)
	local var_7_1 = string.match(var_7_0, "[^/]+$")

	self.scenePath = var_7_0 .. "_scene"
	self.sceneName = var_7_1

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

function IslandMiniGameSceneLoader:LoadScene(arg_11_1, arg_11_2)
	self:LoadSceneWithProgress(arg_11_1, function(arg_12_0)
		if arg_12_0 == 1 then
			existCall(arg_11_2)
		end

		return
	end)

	return
end

function IslandMiniGameSceneLoader:UnLoad(arg_13_1)
	if not self.scenePath or not self.sceneName then
		return
	end

	if not arg_13_1 then
		pg.UIMgr.GetInstance():LoadingOn()
		SceneOpMgr.Inst:UnloadSceneAsync(self.scenePath, self.sceneName, function()
			pg.UIMgr.GetInstance():LoadingOff()

			return
		end)
	else
		SceneOpMgr.Inst:UnloadSceneAsync(self.scenePath, self.sceneName, function()
			return
		end)
	end

	self.scenePath = nil
	self.sceneName = nil

	return
end

function IslandMiniGameSceneLoader:ActivatePendingScene()
	return
end

function IslandMiniGameSceneLoader:Dispose(arg_17_1)
	self:UnLoad(arg_17_1)

	return
end

return IslandMiniGameSceneLoader
