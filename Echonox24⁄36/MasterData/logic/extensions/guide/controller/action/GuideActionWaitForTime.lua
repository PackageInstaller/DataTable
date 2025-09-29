-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionWaitForTime.lua

module("logic.extensions.guide.controller.action.GuideActionWaitForTime", package.seeall)

local M = class("GuideActionWaitForTime", BaseGuideAction)

function M:ctor(guideId, stepId, guideStepCO)
	M.super.ctor(self, guideId, stepId, guideStepCO)

	if not string.nilorempty(guideStepCO.guideControlParam) then
		self._delayTime = tonumber(guideStepCO.guideControlParam)
	else
		self._delayTime = 1
	end
end

function M:onEnter(context)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		ViewMgr.instance:close(ViewName.GuideView)
	end

	if ViewMgr.instance:isOpen(ViewName.ImageGuide) then
		ViewMgr.instance:close(ViewName.ImageGuide)
	end

	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Guide)
	M.super.onEnter(self, context)

	if BattleMgr.instance:isInBattle() then
		self._delayTime = BattleTime.getScaledTime(self._delayTime)
	end

	settimer(self._delayTime, self._onWaitComplete, self, false)
end

function M:onExit()
	removetimer(self._onWaitComplete, self)
	M.super.onExit(self)
end

function M:_onWaitComplete()
	removetimer(self._onWaitComplete, self)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Guide)

	self._delayTime = false

	self:onDone(WorkResult.Succeed)
end

return M
