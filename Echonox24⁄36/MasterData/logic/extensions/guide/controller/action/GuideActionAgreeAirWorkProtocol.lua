-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionAgreeAirWorkProtocol.lua

module("logic.extensions.guide.controller.action.GuideActionAgreeAirWorkProtocol", package.seeall)

local GuideActionAgreeAirWorkProtocol = class("GuideActionAgreeAirWorkProtocol", BaseGuideAction)

function GuideActionAgreeAirWorkProtocol:ctor(guideId, stepId, guideStepCO)
	GuideActionAgreeAirWorkProtocol.super.ctor(self, guideId, stepId, guideStepCO)
end

function GuideActionAgreeAirWorkProtocol:onEnter(context)
	GlobalDispatcher:addEventListener(EventType.AGREE_AIRWORK_PROTOCOL_EVENT, self._onAgreeProtocol, self)
	GuideActionAgreeAirWorkProtocol.super.onEnter(self, context)

	if AirWorkShopModel.instance:hasAgreeProtocol() then
		self:onDone(WorkResult.Succeed)
	end
end

function GuideActionAgreeAirWorkProtocol:onExit()
	GlobalDispatcher:removeEventListener(EventType.AGREE_AIRWORK_PROTOCOL_EVENT, self._onAgreeProtocol, self)
	GuideActionAgreeAirWorkProtocol.super.onExit(self)
end

function GuideActionAgreeAirWorkProtocol:_onAgreeProtocol(evt, isAgree)
	if isAgree then
		self:onDone(WorkResult.Succeed)
	else
		GuideController.instance:oneKeyFinishGuide(self.guideId, true, false, false)
	end
end

return GuideActionAgreeAirWorkProtocol
