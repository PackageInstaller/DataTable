-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/GuideStepController.lua

module("logic.extensions.guide.controller.GuideStepController", package.seeall)

local GuideStepController = class("GuideStepController", BaseController)

function GuideStepController:onInit()
	self._guideId = nil
	self._stepId = nil
	self._workingWork = false
	self._actionBuilder = GuideActionBuilder.New()
	self._startTime = 0
end

function GuideStepController:onReset()
	self:clearStep()
end

function GuideStepController:execStep(guideId, stepId)
	self._guideId = guideId
	self._stepId = stepId

	if not self._workingWork then
		self:_reallyStartGuide()
	end
end

function GuideStepController:clearStep()
	self:_destroyWork()
end

function GuideStepController:_reallyStartGuide()
	self._workingWork = WorkFlow.New()

	local actionFlow = self._actionBuilder:buildActionFlow(self._guideId, self._stepId)

	if actionFlow then
		self._workingWork:setDoneCaller(self._onWorkFinish, self)
		self._workingWork:addChild(actionFlow)
		self._workingWork:start(self)
	else
		printInfo(string.format("<color=#FFA500>guide_%d_%d</color> has no action", self._guideId, self._stepId))
	end
end

function GuideStepController:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

function GuideStepController:_onWorkFinish()
	GuideController.instance:finishStep(self._guideId, self._stepId)
end

GuideStepController.instance = GuideStepController.New()

return GuideStepController
