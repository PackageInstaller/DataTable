-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainSceneAirtightMgr.lua

module("logic.extensions.mainui.scene.component.MainSceneAirtightMgr", package.seeall)

local M = class("MainSceneAirtightMgr", SceneComponentBase)
local ANI = {
	ToAirtight = "sx-s001_mainscene_env_to_airtight",
	Airtight = "sx-s001_mainscene_env_airtight",
	ToNormal = "sx-s001_mainscene_env_to_normal",
	Normal = "sx-s001_mainscene_env_normal"
}

function M:ctor(scene)
	M.super.ctor(self, scene)
end

function M:onInit()
	return
end

function M:onEnterScene(sceneId, bornX, bornZ)
	AirtightRoomController.instance:setPreviewState(nil)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self:setEnvStatusDirectly()
	self:setEvent(true)
end

function M:onExitScene()
	self:setEvent(false)

	self._envAnimation = nil

	if not goutil.isNil(self._envAnimListener) then
		self._envAnimListener:RemoveListener()

		self._envAnimListener = nil
	end

	VirtualCameraMgr.instance:stopShake()

	self._lastInTime = nil

	AirtightRoomController.instance:setPreviewState(nil)
end

function M:onLeaveScene()
	self._envAnimation = nil

	self:onExitScene()
end

function M:onReturnScene()
	self:setEvent(true)
end

function M:onReturnSceneFinished()
	self:_timerCtrl(true)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._handleShowMainViewFinish, self)
		GlobalDispatcher:addEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._handleAirtightExitTimeChange, self)
		GlobalDispatcher:addEventListener(EventType.START_GUIDE_STEP, self._handleStartGuideStep, self)
		GlobalDispatcher:addEventListener(EventType.GUIDE_FINISH_STEP, self._handleGuideFinishStep, self)
		GlobalDispatcher:addEventListener(EventType.SCENE_FLOW_ENTER_FINISH, self._handleSceneFlowEnterFinish, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_PREVIEW, self._handleAritightStatePreview, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CHECK_TO_AIRTIGHT_ANI, self._handleCheckToAirtightAni, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._handleShowMainViewFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._handleAirtightExitTimeChange, self)
		GlobalDispatcher:removeEventListener(EventType.START_GUIDE_STEP, self._handleStartGuideStep, self)
		GlobalDispatcher:removeEventListener(EventType.GUIDE_FINISH_STEP, self._handleGuideFinishStep, self)
		GlobalDispatcher:removeEventListener(EventType.SCENE_FLOW_ENTER_FINISH, self._handleSceneFlowEnterFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_PREVIEW, self._handleAritightStatePreview, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CHECK_TO_AIRTIGHT_ANI, self._handleCheckToAirtightAni, self)
		self:_timerCtrl(false)
	end
end

function M:_handleAritightStatePreview(e, isInAirtightTime)
	if isInAirtightTime ~= nil then
		self:playEnvAni(isInAirtightTime, true)
	else
		self:_updateAirtightTime()
	end
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

	if inSpTime then
		return
	end

	self:playEnvAni(isInAirtightTime, true)
end

function M:_handleShowMainViewFinish(e, isEnter)
	if isEnter then
		local guideId = AirtightRoomUtil.getNormalTimerGuideId()

		if GuideController.instance:isGuiding() and guideId > 0 and GuideController.instance:getCurGuideId() == guideId then
			return
		end

		guideId = AirtightRoomUtil.getAirtightTimeGuideId()

		if GuideController.instance:isGuiding() and guideId > 0 and GuideController.instance:getCurGuideId() == guideId then
			return
		end

		self:checkPlayEnvAni()
	end
end

function M:_handleAirtightExitTimeChange()
	self:_updateAirtightTime()
end

function M:_handleStartGuideStep(e, code)
	if code == AirtightRoomUtil.getAirtightTimeGuideId() then
		AirtightRoomController.instance:setLastAirtightState(true, AirtightRoomModel.instance:getServerTime())
		self:playEnvAni(true, true)
	elseif code == AirtightRoomUtil.getNormalTimerGuideId() then
		-- block empty
	end
end

function M:_handleGuideFinishStep(e, code)
	return
end

function M:_handleSceneFlowEnterFinish(e, info)
	local isCurScene = SceneFace.instance:isCurScene(SceneType.Room)

	if not isCurScene then
		return
	end

	self:_timerCtrl(true)
end

function M:_handleCheckToAirtightAni(e)
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inTime, playAni = AirtightRoomUtil.getNextEnvAnim(nowTime)

	if inTime and playAni then
		self:checkPlayEnvAni()
	end
end

function M:_timerCtrl(startTimer)
	GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKSECOND, self._updateAirtightTime, self)

	if startTimer then
		self:_updateAirtightTime()
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._updateAirtightTime, self)
	end
end

function M:_updateAirtightTime()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nowTime, true, true, false)
	local cacheState = AirtightRoomModel.instance:getCacheTimeStatus()

	if cacheState ~= nil and cacheState ~= inAirtightTime then
		GlobalDispatcher:dispatchEvent(EventType.ON_ARITIGHT_STATE_CHANGE, inAirtightTime, airtightEndTS)
	end

	AirtightRoomModel.instance:setCacheTimeStatus(inAirtightTime)
end

function M:_tryGetEnvAnimation()
	if not self._envAnimation then
		self._envAnimation = self._scene.stage:getSceneEnviromentAnimation()
		self._envAnimListener = Astral.AnimationEventListener.Get(self._envAnimation.gameObject)

		self._envAnimListener:AddListener(self._onAnimEvent, self)
	end
end

function M:checkPlayEnvAni()
	self:_tryGetEnvAnimation()

	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inTime, playAni = AirtightRoomUtil.getNextEnvAnim(nowTime)

	self:playEnvAni(inTime, playAni)
	AirtightRoomController.instance:setLastAirtightState(inTime, nowTime)
end

function M:setEnvStatusDirectly()
	self:_tryGetEnvAnimation()

	local inTime = false
	local cacheInTime = AirtightRoomModel.instance:getCacheTimeStatus()

	if cacheInTime == nil then
		local playAni = false

		inTime, playAni = AirtightRoomUtil.getNextEnvAnim()

		if playAni then
			inTime = not inTime
		end
	else
		inTime = cacheInTime
	end

	local inSpTime, inSpNormal, inSpAirtight = AirtightRoomUtil.getSpTimeInfo()

	if inSpTime and inSpNormal then
		inTime = false
	elseif inSpTime and inSpAirtight then
		inTime = true
	end

	self:playEnvAni(inTime, false)
end

function M:playEnvAni(inAirtight, playAni)
	local name

	if inAirtight then
		name = playAni and ANI.ToAirtight or ANI.Airtight
	else
		name = playAni and ANI.ToNormal or ANI.Normal
	end

	if self._lastInTime == inAirtight then
		return
	end

	if playAni then
		CriwareAudioFacade.instance:playSEById(inAirtight and CriwareAudioEnum.ui_main_into_echotime or CriwareAudioEnum.ui_main_into_realtime)
	end

	self._lastInTime = inAirtight

	self:_tryGetEnvAnimation()

	if self._envAnimation then
		self._envAnimation:Stop()
		self._envAnimation:Play(name)
	end
end

function M:_onAnimEvent(animationEvent)
	if animationEvent.stringParameter == "shake_cam" then
		local camUnit = self._scene.camera:getCamUnit()

		camUnit:shake(1, 0.3, 0, 0.1, 0.2)
	elseif animationEvent.stringParameter == "to_airtight" then
		GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_TO_AIRTIGHT_ANI_FINISHED)
	end
end

return M
