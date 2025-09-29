-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/GuideActionMoveCamera.lua

module("logic.extensions.guide.controller.action.GuideActionMoveCamera", package.seeall)

local GuideActionMoveCamera = class("GuideActionMoveCamera", BaseGuideAction)

function GuideActionMoveCamera:ctor(guideId, stepId, guideStepCO)
	GuideActionMoveCamera.super.ctor(self, guideId, stepId, guideStepCO)

	self._targetPos = Vector3.New(0, 0, 0)
	self._moveTime = 0.5

	if guideStepCO and guideStepCO.guideControlParam then
		local vectorParams = string.split(guideStepCO.guideControlParam, ",")
		local len = #vectorParams

		if len ~= 3 then
			if enableErrorLog then
				printError("GuideStep==>params invalid in move camera action , step id" .. tostring(stepId) .. " _ params:" .. guideStepCO.guideControlParam)
			end

			return
		end

		self._targetPos = Vector3.New(vectorParams[1], vectorParams[2], vectorParams[3])
	end
end

function GuideActionMoveCamera:onEnter(context)
	GuideActionMoveCamera.super.onEnter(self, context)
	GuideController.instance:openGuideView(self.guideStepCO)
	VirtualCameraMgr.instance:doFollowPosition(self._targetPos.x, self._targetPos.y, self._targetPos.z, self._moveTime):OnComplete(self._moveCameraFinish, self, nil)

	local moveTime = 0.7

	if BattleMgr.instance:isInBattle() then
		moveTime = BattleTime.getScaledTime(moveTime)
	end

	settimer(moveTime, self._onWaitComplete, self, false)
end

function GuideActionMoveCamera:_onWaitComplete()
	removetimer(self._onWaitComplete, self)
	self:onDone(WorkResult.Succeed)
end

function GuideActionMoveCamera:onExit()
	GuideActionMoveCamera.super.onExit(self)
end

function GuideActionMoveCamera:_moveCameraFinish()
	removetimer(self._onWaitComplete, self)
	self:onDone(WorkResult.Succeed)
end

return GuideActionMoveCamera
