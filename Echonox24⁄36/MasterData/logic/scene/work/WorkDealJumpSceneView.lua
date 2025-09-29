-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkDealJumpSceneView.lua

module("logic.scene.work.WorkDealJumpSceneView", package.seeall)

local M = class("WorkDealJumpSceneView", WorkBase)

function M:ctor(sceneType)
	M.super.ctor(self)

	self._sceneType = sceneType
end

function M:onEnter(context)
	settimer(0, function()
		SystemJumpController.instance:dealCrossSceneJumpInfo(self._sceneType)
		self:onDone(WorkResult.Succeed)
	end, self, false)
end

function M:onExit(isInterrupt)
	return
end

return M
