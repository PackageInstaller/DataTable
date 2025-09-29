-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/display/WorkMapRoleAnimation.lua

module("logic.extensions.roguelike.flow.work.display.WorkMapRoleAnimation", package.seeall)

local M = class("WorkMapRoleAnimation", WorkBase)

function M:onEnter(context)
	local aniTime = 0.4

	self._context = context

	if context.isRoleLeave then
		local mapMgr = RogueMgr.instance:getMapMgr()

		if mapMgr then
			local mapRole = mapMgr:getMapRole()

			self._mapRole = mapRole

			if mapRole then
				mapRole.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.ARISE)
			end
		end
	else
		local roleRoot = RogueMapGenerator.getRoleRoot()

		goutil.setActive(roleRoot, true)

		local mapMgr = RogueMgr.instance:getMapMgr()

		if mapMgr then
			local mapRole = mapMgr:getMapRole()

			self._mapRole = mapRole

			if mapRole then
				mapRole.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.FALL)
			end
		end
	end

	settimer(aniTime, self.delayOnDone, self, false)
end

function M:delayOnDone()
	if self._context.isRoleLeave and self._mapRole then
		local roleRoot = RogueMapGenerator.getRoleRoot()

		goutil.setActive(roleRoot, false)
	end

	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
