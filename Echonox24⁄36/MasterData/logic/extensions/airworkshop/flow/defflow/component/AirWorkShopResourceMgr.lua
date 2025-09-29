-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopResourceMgr.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopResourceMgr", package.seeall)

local M = class("AirWorkShopResourceMgr", IAirWorkShopFlowComp)

M._cacheResources = {}

function M:onInit()
	self._resLoader = MultiResLoader.New()
	self._handler = Handler.New()
end

function M:onStart()
	self._boardModel = self.flow.boardModel
end

function M:onClear()
	self._boardModel = false

	self._handler:clear()
	self._resLoader:clear()
end

function M:addResourcePathList(resPathList)
	for _, respath in ipairs(resPathList) do
		self._resLoader:addResPath(respath)
	end
end

function M:load(callback, callbackSelf)
	self:_collectResource()
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(self._onAllLoaded, false, self)
end

function M:getAllResourcePath()
	return self._resLoader._resPaths
end

function M:getResource(resPath)
	return self._resLoader:getResource(resPath)
end

function M:getMainAsset(resPath)
	local res = self._resLoader:getResource(resPath)

	return res and res:GetMainAsset() or false
end

function M:getPrefab(resPath)
	local res = self._resLoader:getResource(resPath)

	return res and res:GetMainAsset() or false
end

function M:getInst(resPath)
	local prefab = self:getPrefab(resPath)

	return prefab and goutil.clone(prefab) or false
end

function M:removeListener()
	self._handler:clear()
end

function M:cacheResources()
	self:clearCacheResources()

	local resourceTable = self._resLoader:getResources()

	for _, resource in pairs(resourceTable) do
		resource:Retain()
		table.insert(self._cacheResources, resource)
	end
end

function M:clearCacheResources()
	if #self._cacheResources > 0 then
		for _, resource in pairs(self._cacheResources) do
			resource:Release()
		end

		BattleTableUtil.clearTable(self._cacheResources)
	end
end

function M:_onAllLoaded()
	if not self._resLoader:isAllSuccess() then
		if enableErrorLog then
			printError("load resource failed!")
		end

		self._handler:call(false)

		return
	end

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Battle)
	self._handler:call(true)
end

function M:_collectResource()
	for _, respath in pairs(AirWorkShopResourceName.basic) do
		self._resLoader:addResPath(respath)
	end
end

return M
