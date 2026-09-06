-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/BootstrapResPreLoad.lua

module("bootstrap.BootstrapResPreLoad", package.seeall)

local BootstrapResPreLoad = _M

BootstrapResPreLoad.bootstrapBackground = BootstrapUtil.getPlatformId() == 5 and checknumber(BootstrapUtil.getGameVersionCode()) > 615 and "ui/bigbg/gamestarterbg/game_starter_bghuawei620.png" or "ui/bigbg/gamestarterbg/game_starter_bg.png"
BootstrapResPreLoad.bootstraploading = "ui/views/bootstrap/bootstraploading.prefab"
BootstrapResPreLoad.bootstrapmsgboxview = "ui/views/bootstrap/bootstrapmsgboxview.prefab"
BootstrapResPreLoad.bootstrapInGameConsole = "ui/views/bootstrap/ingame_console_canvas.prefab"
BootstrapResPreLoad.animTakeName = "storyconfig/animations/loginviewanimation.txt"
BootstrapResPreLoad.gameUIRootUrl = "UIROOT/TOP"
BootstrapResPreLoad.gameUIRoot = UnityEngine.GameObject.Find(BootstrapResPreLoad.gameUIRootUrl)
BootstrapResPreLoad.bootstrapPrefab = {
	BootstrapResPreLoad.bootstraploading,
	BootstrapResPreLoad.bootstrapmsgboxview
}

function BootstrapResPreLoad.loadUI()
	local IS_UNITY_CACHE_ENABLE_KEY = "IS_UNITY_CACHE_ENABLE_KEY"

	Framework.LocalStorage.Instance:SetInt(IS_UNITY_CACHE_ENABLE_KEY, 0)
	Framework.ResourceCache.Instance:EnableUnityCachingSystem(false)

	local value = Framework.LocalStorage.Instance:GetInt(IS_UNITY_CACHE_ENABLE_KEY, -1)

	forcePrint("什么值va", value)

	local gameStartImage = UnityEngine.GameObject.Find("UIROOT/GameStartBg/Image")

	BootstrapResPreLoad.gameStartImage = Framework.ImageBigBG.Get(gameStartImage)

	gameStartImage:SetActive(false)
	getres(BootstrapResPreLoad.bootstraploading, BootstrapResPreLoad._loadBootstrapUIFinish, nil, 0, false)
	getres(BootstrapResPreLoad.bootstrapmsgboxview, BootstrapResPreLoad._loadBootstrapUIFinish, nil, 0, false)
	getres(BootstrapResPreLoad.bootstrapBackground, BootstrapResPreLoad._loadBackgroundFinish, nil, 0, false)

	if enableDebug and not Framework.OSDef.isEditor then
		getres(BootstrapResPreLoad.bootstrapInGameConsole, BootstrapResPreLoad._loadInGameConsoleUIFinish, nil, 0, false)
	end
end

function BootstrapResPreLoad._loadInGameConsoleUIFinish(res)
	if res and res.IsSuccess then
		UnityEngine.GameObject.Instantiate(res:GetMainAsset())
	end
end

function BootstrapResPreLoad._loadBootstrapUIFinish(res)
	if res and res.IsSuccess then
		BootstrapResPreLoad.bootstrapPrefab[res.ResPath] = UnityEngine.GameObject.Instantiate(res:GetMainAsset())

		BootstrapResPreLoad.bootstrapPrefab[res.ResPath]:SetActive(false)
		BootstrapResPreLoad.bootstrapPrefab[res.ResPath].transform:SetParent(BootstrapResPreLoad.gameUIRoot.transform, false)
		BootstrapResPreLoad._allUIPrefabFinish()
	else
		BootstrapLauncher.instance:showUITipByState(BootstrapConstdef.EBootstrapState.LoadUIPrefabError)
		printError(LogTag.BOOTSTRAP, res.ResPath, "load error")
	end
end

function BootstrapResPreLoad._loadBackgroundFinish(res)
	BootstrapAdaptationoverlayview.buildUI()

	BootstrapResPreLoad.backgroundImageLoaded = true

	BootstrapResPreLoad.gameStartImage.gameObject:SetActive(true)

	if res and res.IsSuccess then
		BootstrapResPreLoad.gameStartImage:SetImage(BootstrapResPreLoad.bootstrapBackground)
	else
		BootstrapLauncher.instance:showUITipByState(BootstrapConstdef.EBootstrapState.LoadUIPrefabError)
		printError(LogTag.BOOTSTRAP, res.ResPath, "load error")
	end

	BootstrapResPreLoad._allUIPrefabFinish()
end

function BootstrapResPreLoad._allUIPrefabFinish()
	if BootstrapResPreLoad.backgroundImageLoaded and BootstrapResPreLoad.bootstrapPrefab[BootstrapResPreLoad.bootstraploading] and BootstrapResPreLoad.bootstrapPrefab[BootstrapResPreLoad.bootstrapmsgboxview] then
		BootstrapLauncher.instance:showUITipByState(BootstrapConstdef.EBootstrapState.LoadUIPrefabSuccess)
		BootstrapLauncher.instance:onLoadUIFinish()
	end
end

return BootstrapResPreLoad
