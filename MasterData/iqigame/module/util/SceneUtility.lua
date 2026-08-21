-- chunkname: @IQIGame\\Module\\Util\\SceneUtility.lua

SceneUtility = {
	loadSceneAdditivelyCallbackList = {},
	loadSceneCallbackList = {}
}

function SceneUtility.Init()
	GameEntry.LuaEvent:Subscribe(AddAdditiveSceneSuccessEventArgs.EventId, SceneUtility.OnLoadSceneAddtivelySuccess)
	GameEntry.LuaEvent:Subscribe(BattleLoadSceneSuccessEventArgs.EventId, SceneUtility.OnLoadSceneSuccess)
end

function SceneUtility.LoadSceneAdditively(sceneId, callback)
	SceneUtility.loadSceneAdditivelyCallbackList[sceneId] = callback

	IQIGame.Onigao.Game.SceneManager.getInstance():AddScene(sceneId)
end

function SceneUtility.UnloadSceneAdditively(sceneID)
	IQIGame.Onigao.Game.SceneManager.getInstance():RemoveScene(sceneID)

	if CfgSceneListTable[1].RenderConfig then
		CoroutineUtility.StartCoroutine(WaitLoadAsset(BattleView, BattleApi:GetSceneRenderConfigUrl(1), function(assetName, asset, duration, userData)
			SceneRenderConfigManager.ApplyConfig(asset)
		end))
	end
end

function SceneUtility.LoadScene(sceneId, callback)
	SceneUtility.loadSceneCallbackList[sceneId] = callback

	GameEntry.LuaEvent:FireNow(nil, ChangeSceneEventArgs():Fill(sceneId))
end

function SceneUtility.OnLoadSceneAddtivelySuccess(sender, args)
	local callback = SceneUtility.loadSceneAdditivelyCallbackList[args.SceneID]

	if callback then
		callback(args.SceneID, args.SceneName)

		SceneUtility.loadSceneAdditivelyCallbackList[args.SceneID] = nil
	end
end

function SceneUtility.OnLoadSceneSuccess(sender, args)
	local callback = SceneUtility.loadSceneCallbackList[args.SceneID]

	if callback then
		callback(args.SceneID, args.SceneName)

		SceneUtility.loadSceneCallbackList[args.SceneID] = nil
	end
end

function SceneUtility.Dispose()
	GameEntry.LuaEvent:Unsubscribe(AddAdditiveSceneSuccessEventArgs.EventId, SceneUtility.OnLoadSceneAddtivelySuccess)
	GameEntry.LuaEvent:Unsubscribe(BattleLoadSceneSuccessEventArgs.EventId, SceneUtility.OnLoadSceneSuccess)

	SceneUtility.loadSceneCallbackList = nil
end
