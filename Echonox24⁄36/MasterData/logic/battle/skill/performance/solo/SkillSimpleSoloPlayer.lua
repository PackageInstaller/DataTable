-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/solo/SkillSimpleSoloPlayer.lua

module("logic.battle.skill.performance.solo.SkillSimpleSoloPlayer", package.seeall)

local SkillSimpleSoloPlayer = class("SkillSimpleSoloPlayer", AbstractGlobalReusable)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function SkillSimpleSoloPlayer:ctor()
	self._resLoader = SingleResLoader.New()
	self._eventListener = Handler.New()
	self._finishHander = Handler.New()
	self._buildResourceHandler = Handler.New()
	self._directorSetter = PlayableDirectorSetter.New()
	self._timeWaiter = TimeWaiter.New()
	self._diffPosition = Vector3.New()
	self._goTimeline = false
	self._timelineListener = false
	self._unit = false
	self._skillAudioName = false
	self._timelineResPath = false
end

function SkillSimpleSoloPlayer:reuse()
	return
end

function SkillSimpleSoloPlayer:reset()
	if self._goTimeline then
		goutil.destroy(self._goTimeline)

		self._goTimeline = false
	end

	if self._timelineListener then
		self._timelineListener:RemoveListener()

		self._timelineListener = false
	end

	self._unit = false
	self._skillAudioName = false
	self._timelineResPath = false

	self._diffPosition:Set(0, 0, 0)
	self._directorSetter:Clear()
	self._eventListener:clear()
	self._buildResourceHandler:clear()
	self._finishHander:clear()
	self._resLoader:clear()
end

function SkillSimpleSoloPlayer:destroy()
	self:reset()

	self._directorSetter = false
end

function SkillSimpleSoloPlayer:setUnit(unit)
	self._unit = unit
end

function SkillSimpleSoloPlayer:setDiffPositionXYZ(x, y, z)
	self._diffPosition:Set(x, y, z)
end

function SkillSimpleSoloPlayer:setFinishListener(callback, callbackSelf)
	self._finishHander:setListener(callback, callbackSelf)
end

function SkillSimpleSoloPlayer:setEventListener(callback, callbackSelf)
	self._eventListener:setListener(callback, callbackSelf)
end

function SkillSimpleSoloPlayer:setBuildResourceListener(callback, callbackSelf)
	self._buildResourceHandler:setListener(callback, callbackSelf)
end

function SkillSimpleSoloPlayer:setupAudioName(audioName)
	self._skillAudioName = audioName
end

function SkillSimpleSoloPlayer:setTimelineResPath(timelineResPath)
	self._timelineResPath = timelineResPath
end

function SkillSimpleSoloPlayer:play(url)
	self._resLoader:load(url, self._onResLoaded, self)
end

function SkillSimpleSoloPlayer:_onResLoaded()
	self:_buildTimelineInstance()
	self:_setTimelineBindings()
	self._buildResourceHandler:call(self._directorSetter, self._goTimeline)
	self:_startTimeline()
end

function SkillSimpleSoloPlayer:_buildTimelineInstance()
	local resource = self._resLoader:getResource()
	local asset = resource:GetAsset(nil, nil)
	local goTimeline = goutil.clone(asset)
	local goAvatar = self._unit.mountRoot:getAvatarRoot()
	local x, y, z = TransformUtils.GetPosition(goAvatar.transform, 0, 0, 0)
	local dx, dy, dz = self._diffPosition:Get()

	goutil.addChildToParent(goTimeline, kSceneRoot)
	goutil.setActive(goTimeline, true)
	Astral.TransformUtil.SetPos(goTimeline.transform, x + dx, y + dy, z + dz)

	self._goTimeline = goTimeline

	self._directorSetter:Build(goTimeline)
	self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)

	self._timelineListener = TimelineEventListener.Get(goTimeline)

	self._timelineListener:AddListener(self._onTimelineEvent, self)
end

function SkillSimpleSoloPlayer:_setTimelineBindings()
	local unit = self._unit
	local directorSetter = self._directorSetter

	directorSetter:SetGenericBinding(SkillTimelineContext.AttackerAnimationTrack, unit.meshModel:getAnimationPlayer())
	directorSetter:SetGenericBinding(SkillTimelineContext.AttackerFaceAnimationTrack, unit.meshModel:getAnimationPlayer())

	local activeCamera = VirtualCameraMgr.instance:getActiveCamera()

	directorSetter:SetGenericBinding(SkillTimelineContext.NormalRelativeVirtualCameraTrack, activeCamera:getVirtualCameraAnimator())

	local goAttackerSynchronizerRoot = GameObjectUtils.FindChildRecursively(self._goTimeline, 2, SkillTimelineContext.AttackerSynchronizerRoot)

	if goAttackerSynchronizerRoot then
		local synchronizer = ModelSynchronizer.Get(goAttackerSynchronizerRoot)
		local animationPlayer = unit.meshModel:getAnimationPlayer()

		synchronizer:SetSource(animationPlayer.gameObject)
		SkillPerformanceAssistant:setupModelFeatureSynchronizerTarget(goAttackerSynchronizerRoot, animationPlayer.gameObject)
	end

	local goVictimSynchronizerRoot = GameObjectUtils.FindChildRecursively(self._goTimeline, 2, SkillTimelineContext.VictimSynchronizerRoot)

	if goVictimSynchronizerRoot then
		local goVictimRoot = GameObjectUtils.FindChildRecursively(self._goTimeline, 10, SkillTimelineContext.VictimRoot)

		if goVictimRoot then
			SkillPerformanceAssistant:setupModelFeatureSynchronizerTarget(goVictimSynchronizerRoot, goVictimRoot)
		end
	end
end

function SkillSimpleSoloPlayer:_cleanTimelineBindings()
	local activeCamera = VirtualCameraMgr.instance:getActiveCamera()

	activeCamera:clearRelativeComponent()
end

function SkillSimpleSoloPlayer:_startTimeline()
	self._directorSetter:Play()
	self._directorSetter:SetPlaySpeed(BattleTime.timeScale)
	SkillPerformanceAssistant:playSkillAudio(self._unit, self._skillAudioName)
	SkillPerformanceAssistant:playSkillSpeech(self._unit, self._timelineResPath)
end

function SkillSimpleSoloPlayer:_onTimelineEvent(eventName, param)
	if eventName == BattleTimelineEventName.Stopped then
		self._finishHander:call()
	else
		self._eventListener:call(eventName, param)
	end
end

return SkillSimpleSoloPlayer
