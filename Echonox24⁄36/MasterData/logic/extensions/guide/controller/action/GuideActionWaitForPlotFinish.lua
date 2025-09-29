-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionWaitForPlotFinish.lua

module("logic.extensions.guide.controller.action.GuideActionWaitForPlotFinish", package.seeall)

local M = class("GuideActionWaitForPlotFinish", BaseGuideAction)

function M:ctor(guideId, stepId, guideStepCO)
	M.super.ctor(self, guideId, stepId, guideStepCO)

	local paramstr = guideStepCO.guideControlParam
	local paramArray = string.split(paramstr, "#")

	self._targetPlotId = paramArray[1]

	if paramArray[2] then
		self._stayUI = tonumber(paramArray[2]) == 1
	else
		self._stayUI = true
	end

	if paramArray[3] then
		self._resetUI = tonumber(paramArray[3])
	else
		self._resetUI = 1
	end

	if enableLog then
		print("story id can stay ui , reset ui ", self._stayUI, self._resetUI)
	end
end

function M:onEnter(context)
	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		ViewMgr.instance:close(ViewName.GuideView)
	end

	if ViewMgr.instance:isOpen(ViewName.ImageGuide) then
		ViewMgr.instance:close(ViewName.ImageGuide)
	end

	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onWaitStoryUIOpen, self)
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Guide)

	if not string.nilorempty(self._targetPlotId) then
		StoryMgr.instance:startSingle(tonumber(self._targetPlotId), false, self._onPlotFinish, self, self._stayUI, false, self._resetUI)
	else
		self:_onPlotFinish()
	end

	M.super.onEnter(self, context)
end

function M:_onPlotFinish(storyId)
	if not string.nilorempty(self._targetPlotId) and tonumber(self._targetPlotId) == storyId then
		self._targetPlotId = false

		self:onDone(WorkResult.Succeed)
	end
end

function M:onExit()
	M.super.onExit(self)
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPENING_EVENT, self._onWaitStoryUIOpen, self)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Guide)
end

function M:_onWaitStoryUIOpen(evt, viewName)
	if viewName == ViewName.StoryViewViewPresentor then
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Guide)
	end
end

return M
