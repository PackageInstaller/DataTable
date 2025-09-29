-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/RogueResourceMgr.lua

module("logic.extensions.roguelike.scene.RogueResourceMgr", package.seeall)

local M = class("RogueResourceMgr", ISceneFlowComp)

function M:onInit()
	self._resLoader = MultiResLoader.New()
	self._handler = Handler.New()
end

function M:onEnter()
	self:_setEvent(true)
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

function M:_insertToResList(resPath)
	if not table.indexof(self._resList, resPath) then
		table.insert(self._resList, resPath)
	end
end

function M:onExit()
	self:_setEvent(false)
	self._handler:clear()
	self._resLoader:clear()
end

function M:load(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(self._onAllLoaded, false, self)
end

function M:getResource(resPath)
	return self._resLoader:getResource(resPath)
end

function M:getInst(resPath)
	local res = self._resLoader:getResource(resPath)

	if res then
		return goutil.clone(res:GetMainAsset())
	end
end

function M:removeListener()
	self._handler:clear()
end

function M:_onAllLoaded()
	if not self._resLoader:isAllSuccess() then
		if enableErrorLog then
			printError("load resource failed!")
		end

		self._handler:call(false)

		return
	end

	self._handler:call(true)
end

return M
