-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionOpenImageHelp.lua

module("logic.extensions.guide.controller.action.GuideActionOpenImageHelp", package.seeall)

local GuideActionOpenImageHelp = class("GuideActionOpenImageHelp", BaseGuideAction)

function GuideActionOpenImageHelp:ctor(guideId, stepId, guideStepCO)
	GuideActionOpenImageHelp.super.ctor(self, guideId, stepId, guideStepCO)

	if guideStepCO and guideStepCO.guideControlParam then
		self._params = string.split(guideStepCO.guideControlParam, ",")
	end
end

function GuideActionOpenImageHelp:onEnter(context)
	GuideActionOpenImageHelp.super.onEnter(self, context)
	GlobalDispatcher:addEventListener(EventType.CLOSE_IMAGE_GUIDE_VIEW, self._onClseImageGuide, self)
	ViewMgr.instance:open(ViewName.ImageGuide, self._params)
end

function GuideActionOpenImageHelp:onExit()
	GuideActionOpenImageHelp.super.onExit(self)
	GlobalDispatcher:removeEventListener(EventType.CLOSE_IMAGE_GUIDE_VIEW, self._onClseImageGuide, self)
end

function GuideActionOpenImageHelp:_onClseImageGuide()
	self:onDone(WorkResult.Succeed)
end

return GuideActionOpenImageHelp
