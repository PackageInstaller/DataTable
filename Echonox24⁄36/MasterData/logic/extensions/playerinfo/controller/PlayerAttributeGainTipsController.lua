-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/controller/PlayerAttributeGainTipsController.lua

module("logic.extensions.playerinfo.controller.PlayerAttributeGainTipsController", package.seeall)

local M = class("PlayerAttributeGainTipsController", BaseController)

function M:onReset()
	self:onInit()
end

function M:onInit()
	self._needShowTimes = 0
	self._frozenInfo = {}

	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._checkDelayShowTips, self)
end

function M:freeze(content)
	if content then
		self._frozenInfo[content] = true
	end

	if ViewMgr.instance:isOpen(ViewName.PlayerGainAttributeTips) then
		ViewMgr.instance:close(ViewName.PlayerGainAttributeTips)
	end
end

function M:unfreeze(content, delayTime)
	if content then
		self._frozenInfo[content] = false
	end

	if delayTime and delayTime > 0 then
		settimer(delayTime, self.tryShowTips, self, false)
	else
		self:tryShowTips()
	end
end

function M:forceUnfreezeAll()
	table.clear(self._frozenInfo)
	self:tryShowTips()
end

function M:onGainAttribute()
	self._needShowTimes = self._needShowTimes + 1

	self:tryShowTips()
end

function M:_checkDelayShowTips(_, viewName)
	if viewName == ViewName.PlayerGainAttributeTips then
		settimer(0.2, self.tryShowTips, self, false)
	end
end

function M:tryShowTips()
	if self._needShowTimes < 1 then
		return
	end

	local isAllUnfreeze = true

	for k, v in pairs(self._frozenInfo) do
		if v then
			isAllUnfreeze = false

			break
		end
	end

	if not isAllUnfreeze then
		return
	end

	table.clear(self._frozenInfo)

	self._needShowTimes = self._needShowTimes - 1
end

M.instance = M.New()

return M
