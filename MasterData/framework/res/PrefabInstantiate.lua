-- chunkname: @framework/res/PrefabInstantiate.lua

module("framework.res.PrefabInstantiate", package.seeall)

local PrefabInstantiate = class("PrefabInstantiate", LuaCompBase)

function PrefabInstantiate.Create(containerGO)
	return MonoHelper.addNoUpdateLuaComOnceToGo(containerGO, PrefabInstantiate)
end

function PrefabInstantiate:init(containerGO)
	self._containerGO = containerGO
	self._path = nil
	self._assetItem = nil
	self._instGO = nil
	self._finishCallback = nil
	self._callbackTarget = nil
end

function PrefabInstantiate:startLoad(path, finishCallback, callbackTarget)
	if gohelper.isNil(self._containerGO) then
		logError("self._containerGO is nil, but startLoad:" .. tostring(path))

		return
	end

	self._path = path
	self._finishCallback = finishCallback
	self._callbackTarget = callbackTarget

	loadAbAsset(path, false, self._onLoadCallback, self)
end

function PrefabInstantiate:getPath()
	return self._path
end

function PrefabInstantiate:getAssetItem()
	return self._assetItem
end

function PrefabInstantiate:getInstGO()
	return self._instGO
end

function PrefabInstantiate:dispose()
	if self._path then
		removeAssetLoadCb(self._path, self._onLoadCallback, self)
	end

	if self._assetItem then
		self._assetItem:Release()
	end

	gohelper.destroy(self._instGO)

	self._path = nil
	self._assetItem = nil
	self._instGO = nil
	self._finishCallback = nil
	self._callbackTarget = nil
end

function PrefabInstantiate:onDestroy()
	self:dispose()
	self:__onDispose()
end

function PrefabInstantiate:_onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		if gohelper.isNil(self._containerGO) then
			logError("self._containerGO is nil, but _onLoadCallback:" .. tostring(self._path))

			return
		end

		self._assetItem = assetItem

		self._assetItem:Retain()

		self._instGO = gohelper.clone(self._assetItem:GetResource(self._path), self._containerGO)

		if self._finishCallback then
			if self._callbackTarget then
				self._finishCallback(self._callbackTarget, self)
			else
				self:_finishCallback()
			end
		end
	end
end

return PrefabInstantiate
