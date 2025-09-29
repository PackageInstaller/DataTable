-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/skip/SkillTrumpSkip.lua

module("logic.battle.skill.performance.skip.SkillTrumpSkip", package.seeall)

local SkillTrumpSkip = class("SkillTrumpSkip", ISkillPerformance)
local kSceneRoot = SceneMgr.instance:getSceneRoot()
local kMainCamera = MainCameraMgr.instance:getMainCamera()
local kUrl = GameUrl.get3dEffectUrl("skip/skip_common")

function SkillTrumpSkip:ctor()
	self._resLoader = BattleMultiResLoaderIncludeModel.New()
	self._directorSetter = PlayableDirectorSetter.New()
	self._handler = Handler.New()
	self._goTimeline = false
	self._camera = false
	self._timelineListener = false
	self._attackInfo = false
	self._modelUrl = false
end

function SkillTrumpSkip:clear()
	if self._goTimeline then
		URPCameraUtils.RemoveOverlayCamera(kMainCamera, self._camera)
		goutil.destroy(self._goTimeline)

		self._goTimeline = false
		self._camera = false
	end

	if self._timelineListener then
		self._timelineListener:RemoveListener()

		self._timelineListener = false
	end

	self._directorSetter:Clear()
	self._handler:clear()
	self._resLoader:clear()

	self._attackInfo = false
	self._modelUrl = false
end

function SkillTrumpSkip:loadResource(attackInfo, callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)

	local attacker = attackInfo:getAttacker()
	local modelId = attacker.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	self._modelUrl = ModelCOUtil.getHighModelUrl(modelCO)

	self._resLoader:addNormalRes(kUrl)
	self._resLoader:addModelRes(self._modelUrl)
	self._resLoader:load(self._onResLoaded, self, true)
end

function SkillTrumpSkip:isResourceLoaded()
	return self._resLoader:isAllSuccess()
end

function SkillTrumpSkip:start(attackInfo, callback, callbackSelf)
	if self._resLoader:getTotalCount() <= 0 then
		Handler:executeCallback(callback, callbackSelf)

		return
	end

	VolumeMgr.instance:setUICameraPostProcessingEnable(true)

	self._attackInfo = attackInfo

	self._handler:setListener(callback, callbackSelf)
	self:_buildTimelineInstance()
end

function SkillTrumpSkip:stop()
	VolumeMgr.instance:setUICameraPostProcessingEnable(false)
end

function SkillTrumpSkip:_buildTimelineInstance()
	local resource = self._resLoader:getResource(kUrl)
	local asset = resource:GetAsset(nil, nil)
	local goTimeline = goutil.clone(asset)

	goutil.addChildToParent(goTimeline, kSceneRoot)

	self._goTimeline = goTimeline

	self._directorSetter:Build(goTimeline)
	self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)

	self._timelineListener = TimelineEventListener.Get(goTimeline)

	self._timelineListener:AddListener(self._onTimelineEvent, self)

	self._camera = goutil.findChildComponent(goTimeline, "Camera", ComponentType.Camera)

	URPCameraUtils.InsertOverlayCamera(kMainCamera, self._camera, -1)

	local goCharacterRoot = goutil.findChild(goTimeline, "Content/CharacterRoot")

	resource = self._resLoader:getResource(self._modelUrl)
	asset = resource:GetAsset(nil, nil)

	local goCharacter = goutil.clone(asset)

	goutil.addChildToParent(goCharacter, goCharacterRoot)
	Astral.GameObjectUtil.SetLayerRecursively(goCharacter, SceneLayer.UI_Value)

	local avatarSynchronizer = SpaceX.SkillSkipAvatarSynchronizer.Get(goCharacterRoot)

	avatarSynchronizer:SetMainGameObject(goCharacter)

	local animationPlayer = AnimationPlayer.Get(goCharacter)

	self._directorSetter:SetGenericBinding(SkillTimelineContext.AttackerAnimationTrack, animationPlayer)
	self._directorSetter:SetGenericBinding(SkillTimelineContext.AttackerFaceAnimationTrack, animationPlayer)

	local attacker = self._attackInfo:getAttacker()

	if attacker then
		local skillCueName = string.format("skill_%s_cutin", attacker.property:getModelCode())

		BattleUnitUtil.play3dAudio(attacker, skillCueName)
	end
end

function SkillTrumpSkip:_onResLoaded()
	self._handler:callAndClear()
end

function SkillTrumpSkip:_onTimelineEvent(eventName, param)
	if eventName == BattleTimelineEventName.Stopped then
		self:_onTimelineFinishPoint()
		self:_onTimelineStop()
	elseif eventName == BattleTimelineEventName.SanityConsume and not self._attackInfo:isStrengthening() then
		BattleDispatcher:dispatchEvent(BattleEventType.PlaySanityConsumeAnim, self._attackInfo)
	end
end

function SkillTrumpSkip:_onTimelineFinishPoint()
	self._handler:callAndClear()
end

function SkillTrumpSkip:_onTimelineStop()
	self:stop()
	self:clear()
end

return SkillTrumpSkip
