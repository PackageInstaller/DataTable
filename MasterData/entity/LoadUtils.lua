-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Entity\\LoadUtils.lua

local LoaderUtils = Framework.Tools.LoaderUtils
local LoadUtils = {}
local self = LoadUtils

function LoadUtils:ctor()
	return
end

function LoadUtils.test()
	local path = "Scenes/Battles/Test.prefab"

	self.testPre = {}

	for i = 1, 3 do
		self.testPre[i] = self.loadPrefabByTypeSync(path, "test")
	end
end

function LoadUtils.unLoadTest()
	if not self.testPre then
		return
	end

	self.UnLoadPrefabByType("test")

	self.testPre = nil
end

function LoadUtils.loadPrefabSync(path, cb)
	local loaderId = LoaderUtils.LoadPrefabSync(path)

	if cb and loaderId then
		local obj = LoaderUtils.GetGoByLoadId(loaderId)

		if obj then
			cb(obj)
		end
	end

	return loaderId
end

function LoadUtils.loadPrefabByTypeSync(path, typeName)
	local loaderId = LoaderUtils.LoadPrefabByTypeSync(path, typeName)

	return loaderId
end

function LoadUtils.loadPrefabAsync(path, cb)
	local loaderId = LoaderUtils.LoadPrefabAsync(path, Slot(self._onGameObjectLoaded, cb))

	return loaderId
end

function LoadUtils.loadPrefabByTypeAsync(path, cb, typeName)
	local loaderId = LoaderUtils.LoadPrefabByTypeAsync(path, Slot(self._onGameObjectLoaded, cb), typeName)

	return loaderId
end

function LoadUtils._onGameObjectLoaded(cb, obj)
	if not obj then
		return
	end

	if cb then
		cb(obj)
	end
end

function LoadUtils.UnLoadPrefab(loaderIdx)
	if loaderIdx then
		LoaderUtils.unLoadPrefab(loaderIdx)
	end
end

function LoadUtils.UnLoadPrefabByType(typeName)
	LoaderUtils.UnloadPrefabByType(typeName)
end

return LoadUtils
