-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/roleshow/BattlePhotoModelCache.lua

module("logic.extensions.battle.viewmain.roleshow.BattlePhotoModelCache", package.seeall)

local M = class("BattlePhotoModelCache")
local kMaxPreloadCount = 5

function M:ctor()
	self._loadedHandler = Handler.New()
	self._cacheList = {}
	self._multiLoader = MultiResLoader.New()
	self._resPath = false
end

function M:setLoadHandler(callback, callbackObj)
	self._loadedHandler:setListener(callback, callbackObj)
end

function M:load(resPath)
	self._multiLoader:addResPath(resPath, true)

	self._resPath = resPath

	self._multiLoader:load(self._onAllResLoaded, false, self)
end

function M:_onAllResLoaded()
	local resource = self._multiLoader:getResource(self._resPath)

	if not resource then
		return
	end

	if #self._cacheList >= kMaxPreloadCount then
		local oldResource = table.remove(self._cacheList, 1)

		oldResource:Release()
	end

	resource:Retain()
	table.insert(self._cacheList, resource)
	self._multiLoader:clear()
	self._loadedHandler:call(resource)
end

function M:clear()
	for _, resource in ipairs(self._cacheList) do
		resource:Release()
	end

	self._multiLoader:clear()
	self._loadedHandler:clear()
	BattleTableUtil.clearTable(self._cacheList)
end

function M:destroy()
	self:clear()
end

return M
