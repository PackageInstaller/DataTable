-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionShowFunctionAnim.lua

module("logic.extensions.guide.controller.action.GuideActionShowFunctionAnim", package.seeall)

local M = class("GuideActionShowFunctionAnim", BaseGuideAction)

function M:ctor(guideId, stepId, guideStepCO)
	M.super.ctor(self, guideId, stepId, guideStepCO)

	self._uiId = false

	if not string.nilorempty(guideStepCO.guideControlParam) then
		self._uiId = tonumber(guideStepCO.guideControlParam)
	end
end

function M:onEnter(context)
	M.super.onEnter(self, context)

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		ViewMgr.instance:close(ViewName.GuideView)
	end

	if ViewMgr.instance:isOpen(ViewName.ImageGuide) then
		ViewMgr.instance:close(ViewName.ImageGuide)
	end

	if self._uiId then
		ToolTipsMgr.showOpenFunctionsHintTips(self._uiId, false, self._animationFinish, self)
	else
		self:onDone(WorkResult.Succeed)
	end
end

function M:_animationFinish()
	self:onDone(WorkResult.Succeed)
end

function M:onExit()
	M.super.onExit(self)
end

return M
