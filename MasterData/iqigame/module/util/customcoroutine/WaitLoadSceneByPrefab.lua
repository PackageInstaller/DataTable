-- chunkname: @IQIGame\\Module\\Util\\CustomCoroutine\\WaitLoadSceneByPrefab.lua

WaitLoadSceneByPrefab = class({
	waitType = "WaitLoadSceneByPrefab"
}, CustomWait)
WaitLoadSceneByPrefab.IsLog = true

function WaitLoadSceneByPrefab:ctor(owner, sceneID, callback)
	local sceneListConfig = CfgSceneListTable[sceneID]

	if sceneListConfig == nil then
		logError(string.format("SceneList表找不到sceneID为%d的场景配置", sceneID))

		return
	end

	local sceneName = sceneListConfig.SceneFile
	local path = AssetPath.Get(GlobalKey.ScenePrefabPath, sceneName)

	AssetUtil.LoadAsset(owner, path, function(_, assetUrl, asset, duration, userData)
		local sceneObj = GameObject.Instantiate(asset)

		if type(callback) == "function" then
			callback(sceneObj)
		end

		if WaitLoadSceneByPrefab.IsLog then
			logDebug("加载场景" .. sceneID .. "完成")
		end

		self.result = sceneObj
		self.isComplete = true
	end)
end

function WaitLoadSceneByPrefab:Dispose()
	self.result = nil
end

return WaitLoadSceneByPrefab
