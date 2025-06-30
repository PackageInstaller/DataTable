module("AssetLoader", Class.impl())

-- 进行资源的预加载
function PreLoad(cusPath, cusCB, cusCBObj)
	gs.ResMgr:PreLoad(cusPath, cusCB, cusCBObj)
end

-- 进行资源列表的预加载
function PreLoadList(cusPaths, cusCB, cusCBObj)
	gs.ResMgr:PreLoadList(cusPaths, cusCB, cusCBObj)
end

-- 异步进行资源的预加载
function PreLoadAsyn(cusPath, cusCB, cusCBObj)
	return gs.ResMgr:PreLoadAsyn(cusPath, cusCB, cusCBObj)
end

-- 异步进行资源列表的预加载
function PreLoadListAsyn(cusPaths, cusCB, cusCBObj)
	gs.ResMgr:PreLoadListAsyn(cusPaths, cusCB, cusCBObj)
end

-- 异步进行资源列表的预加载（返回进度）
function PreLoadListAsyn01(cusPaths, cusCB, cusCBObj)
	gs.ResMgr:PreLoadListAsyn01(cusPaths, cusCB, cusCBObj)
end

-- 加载具体的资源
function GetAsset(cusPath)
	return gs.ResMgr:Load(cusPath)
end

-- 加载具体的GameObject
function GetGO(cusPath)
	return gs.ResMgr:LoadGO(cusPath)
end

function LoadScene(sceneName, scenePath)
	gs.ResMgr:LoadScene(sceneName, scenePath)
end

function LoadSceneAsync(scenename, scenePath, cusCB)
	gs.ResMgr:LoadSceneAsync(scenename, scenePath, cusCB)
end

-- 释放资源引用
function ReleaseAsset(cusPath)
	gs.ResMgr:UnLoad(cusPath)
end

return _M