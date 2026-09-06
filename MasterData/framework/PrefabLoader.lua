-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/resource/loader/PrefabLoader.lua

module("framework.resource.loader.PrefabLoader", package.seeall)

local PrefabLoader = class("PrefabLoader")

function PrefabLoader.Get(go)
	return Framework.LuaComponentContainer.Add(go, PrefabLoader)
end

function PrefabLoader:ctor(container)
	self._go = container.gameObject
	self._url = nil
	self._prefabRes = nil
	self._prefabInst = nil
	self._loadedHandler = nil
	self._loadedHandlerObj = nil
end

function PrefabLoader:getUrl()
	return self._url
end

function PrefabLoader:getGO()
	return self._go
end

function PrefabLoader:getRes()
	return self._prefabRes
end

function PrefabLoader:getInst()
	return self._prefabInst
end

function PrefabLoader:OnDestroy()
	self:clear()

	self._go = nil
end

function PrefabLoader:load(url, loadedHandler, loadedHandlerObj, needPreloadAsset)
	if self._url == url then
		return
	end

	self:clear()

	if url == nil then
		return
	end

	self._url = url
	self._loadedHandler = loadedHandler
	self._loadedHandlerObj = loadedHandlerObj
	needPreloadAsset = needPreloadAsset or false

	getres(self._url, self._onPrefabLoaded, self, nil, needPreloadAsset)
end

function PrefabLoader:_onPrefabLoaded(res)
	if res.IsSuccess and self._go and not goutil.isNil(self._go) then
		self._prefabRes = res

		self._prefabRes:Retain()

		local asset = res:GetAsset(nil, nil)

		if not asset then
			asset = UnityEngine.GameObject.New()

			printError("PrefabLoader资源预制是null:" .. (res.IsDestroy and "资源已经销毁，" or "资源还没销毁") .. "  资源路径=" .. res.ResPath)
		end

		self._prefabInst = UnityEngine.GameObject.Instantiate(asset)

		goutil.addChildToParent(self._prefabInst, self._go)

		self._prefabInst.layer = self._go.layer

		local tempHandler = self._loadedHandler
		local tempHandlerObj = self._loadedHandlerObj

		self._loadedHandler = nil
		self._loadedHandlerObj = nil

		if tempHandler ~= nil then
			if tempHandlerObj == nil then
				self:_loadedHandler()
			else
				self._loadedHandler(tempHandlerObj, self)
			end
		end
	else
		self._loadedHandler = nil
		self._loadedHandlerObj = nil
	end
end

function PrefabLoader:clear()
	if self._url == nil then
		return
	end

	goutil.destroy(self._prefabInst)

	self._prefabInst = nil

	if self._prefabRes ~= nil then
		self._prefabRes:Release()
	else
		removeresl(self._url, self._onPrefabLoaded, self)
	end

	self._prefabRes = nil
	self._url = nil
	self._loadedHandler = nil
	self._loadedHandlerObj = nil
end

return PrefabLoader
