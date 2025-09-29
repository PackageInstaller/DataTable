-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/display/WorkMapUIAnimation.lua

module("logic.extensions.roguelike.flow.work.display.WorkMapUIAnimation", package.seeall)

local M = class("WorkMapUIAnimation", WorkBase)

function M:onEnter(context)
	local mapMgr = RogueMgr.instance:getMapMgr()

	if mapMgr then
		mapMgr:switchToSecondScene(RoguelikeModel.instance:getIsInSecondRoom())
		mapMgr:setActive(not context.isDown)
	end

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_SET_MAP_ICON_ACTIVE, not context.isDown)
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
