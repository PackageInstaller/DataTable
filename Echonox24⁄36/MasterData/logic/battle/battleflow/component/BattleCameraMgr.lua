-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleCameraMgr.lua

module("logic.battle.battleflow.component.BattleCameraMgr", package.seeall)

local BattleCameraMgr = class("BattleCameraMgr", IBattleFlowComp)
local kAnimationName = "random_anim_1"

function BattleCameraMgr:onInit()
	return
end

function BattleCameraMgr:onStart()
	self._resMgr = self.flow.resMgr or false
	self._goRandomAnimation = false
	self._directorProxy = false
	self._directorSetter = false
	self._timelineCurveDuration = false
end

function BattleCameraMgr:onClear()
	self:_resetVirtualCamera()

	if self._goRandomAnimation then
		goutil.destroy(self._goRandomAnimation)

		self._goRandomAnimation = false
		self._directorSetter = false

		if self._directorProxy then
			self._directorProxy = false
		end

		self._timelineCurveDuration = false
	end

	self._resMgr = false
end

function BattleCameraMgr:onResourceLoaded()
	self._goRandomAnimation = self._resMgr:getInst(BattleResourceName.RandomCameraAnimation)
	self._directorProxy = Timeline.PlayableDirectorProxy.Get(self._goRandomAnimation)

	self._directorProxy:AddListener(self._onTimelineFinished, self)

	local goScene = SceneMgr.instance:getSceneRoot()

	goutil.addChildToParent(self._goRandomAnimation, goScene)
	goutil.setActive(self._goRandomAnimation, false)
end

function BattleCameraMgr:playRandomAnimation(duration)
	if duration <= 0 then
		return
	end

	self:_playCameraAnimation(kAnimationName, duration)
end

function BattleCameraMgr:playRandomPushAnimation(duration)
	if duration <= 0 then
		return
	end

	self:_playCameraAnimation("random_push", duration)
end

function BattleCameraMgr:playRandomPullAnimation(duration)
	if duration <= 0 then
		return
	end

	self:_playCameraAnimation("random_pull", duration)
end

function BattleCameraMgr:_onTimelineFinished()
	goutil.setActive(self._goRandomAnimation, false)

	local activeCamera = VirtualCameraMgr.instance:getActiveCamera()

	activeCamera:clearRelativeComponent()
end

function BattleCameraMgr:_playCameraAnimation(animationName, duration)
	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()

	self._directorProxy:SetGenericBinding(animationName, virtualCamera:getVirtualCameraAnimator())
	goutil.setActive(self._goRandomAnimation, true)
	self._directorProxy:Play()
end

function BattleCameraMgr:_resetVirtualCamera()
	local virutalCamera = VirtualCameraMgr.instance:getActiveCamera()

	if virutalCamera then
		virutalCamera:resetTransform()
	end

	virutalCamera = VirtualCameraMgr.instance:getTemporaryCamera(BattleConst.START_CAMERA_CODE)

	if virutalCamera then
		virutalCamera:resetTransform()
	end
end

return BattleCameraMgr
