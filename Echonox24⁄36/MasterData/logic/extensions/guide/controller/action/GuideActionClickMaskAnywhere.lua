-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionClickMaskAnywhere.lua

module("logic.extensions.guide.controller.action.GuideActionClickMaskAnywhere", package.seeall)

local GuideActionClickMaskAnywhere = class("GuideActionClickMaskAnywhere", BaseGuideAction)

function GuideActionClickMaskAnywhere:ctor(guideId, stepId, guideStepCO)
	GuideActionClickMaskAnywhere.super.ctor(self, guideId, stepId, guideStepCO)
end

function GuideActionClickMaskAnywhere:onEnter(context)
	GuideActionClickMaskAnywhere.super.onEnter(self, context)
	self:_setScenePickerEnable(false)
	GlobalDispatcher:addEventListener(EventType.TRIGGER_NEXT_STEP, self._onTriggerNextStep, self)
	GuideController.instance:openGuideView(self.guideStepCO, self._onClickTarget, self)
end

function GuideActionClickMaskAnywhere:_setScenePickerEnable(state)
	if SceneMgr.instance:getCurSceneType() == SceneType.Room then
		local scenePickerView = ScenePickerViewFacade.instance:getScenePickerView()

		if scenePickerView then
			scenePickerView:setEnable(state)
		end
	end
end

function GuideActionClickMaskAnywhere:onExit()
	GuideActionClickMaskAnywhere.super.onExit(self)
	self:_setScenePickerEnable(true)
	GlobalDispatcher:removeEventListener(EventType.TRIGGER_NEXT_STEP, self._onTriggerNextStep, self)
end

function GuideActionClickMaskAnywhere:_onClickTarget()
	settimer(0.01, self._onDelayDone, self, false)
end

function GuideActionClickMaskAnywhere:_onTriggerNextStep()
	self:_onDelayDone()
end

function GuideActionClickMaskAnywhere:_onDelayDone()
	removetimer(self._onDelayDone, self)
	self:onDone(WorkResult.Succeed)
	GlobalDispatcher:dispatchEvent(EventType.FINISH_GUIDE_STEP)
end

return GuideActionClickMaskAnywhere
