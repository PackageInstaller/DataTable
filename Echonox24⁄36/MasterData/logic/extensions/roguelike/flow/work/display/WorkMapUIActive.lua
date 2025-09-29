-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/display/WorkMapUIActive.lua

module("logic.extensions.roguelike.flow.work.display.WorkMapUIActive", package.seeall)

local M = class("WorkMapUIActive", WorkBase)

function M:onEnter(context)
	local mapMgr = RogueMgr.instance:getMapMgr()

	if mapMgr then
		if context.isEnterSecondaryScene then
			local mapRoot = RogueMapGenerator.getMapsRoot()

			if not goutil.isNil(mapRoot) then
				goutil.setActive(mapRoot, context.isShowMapUI)
			end
		elseif context.isInSecondRoom then
			local mapRoot = RogueMapGenerator.getMapsRoot2()

			if not goutil.isNil(mapRoot) then
				goutil.setActive(mapRoot, context.isShowMapUI)
			end
		elseif context.ignoreModel then
			local idx2Unit = mapMgr:getCurMapUnits()

			if context.isShowMapUI then
				for k, v in pairs(idx2Unit) do
					v.mapItem:setLineActive(true)
				end
			else
				for k, v in pairs(idx2Unit) do
					v.mapItem:setLineActive(false, true)
					v.mapItem:setModelActive(false)
				end
			end

			context.mapItem:setModelActive(not context.isActive)
		else
			local mapRoot = RogueMapGenerator.getMapsRoot()

			if not goutil.isNil(mapRoot) then
				goutil.setActive(mapRoot, context.isShowMapUI)
			end
		end
	end

	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
