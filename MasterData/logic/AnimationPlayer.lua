-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/controller/AnimationPlayer.lua

module("logic.extensions.story.controller.AnimationPlayer", package.seeall)

local AnimationPlayer = class("AnimationPlayer")

function AnimationPlayer.play(path, onAnimPlayFinish, onAnimPlayStart, handleObject, speed, autoClear, needPrepareResources, targets)
	local anim = AnimationPlayer.New()

	anim:setFinishCallback(onAnimPlayFinish, handleObject)
	anim:setStartCallback(onAnimPlayStart, handleObject)
	anim:PlayAnim(path, speed, autoClear, targets, needPrepareResources == nil and true or needPrepareResources)

	return anim
end

function AnimationPlayer.playWithSceneObjects(go, path, onAnimPlayFinish, onAnimPlayStart, handleObject, speed, autoClear, needPrepareResources, targets)
	local anim = AnimationPlayer.New()

	anim:setFinishCallback(onAnimPlayFinish, handleObject)
	anim:setStartCallback(onAnimPlayStart, handleObject)
	anim:PlayAnimWithSceneObjects(go, path, speed, autoClear, targets, needPrepareResources == nil and true or needPrepareResources)

	return anim
end

function AnimationPlayer.playWithGameObject(go, path, onAnimPlayFinish, onAnimPlayStart, handleObject, speed, autoClear, needPrepareResources, targets)
	local anim = AnimationPlayer.New()

	anim:setFinishCallback(onAnimPlayFinish, handleObject)
	anim:setStartCallback(onAnimPlayStart, handleObject)
	anim:PlayAnimWithObject(go, path, speed, autoClear, targets, needPrepareResources == nil and true or needPrepareResources)

	return anim
end

function AnimationPlayer:ctor()
	self._amPlayer = nil
	self._stopHandler = nil
	self._stopHandlerObj = nil
	self._onStartHandler = nil
	self._onStartHandlerObj = nil
	self._isPlayingAnim = nil
end

function AnimationPlayer:PlayAnim(path, speed, autoClear, targets, needPrepareResources)
	if not path then
		return
	end

	speed = speed or 1

	if autoClear == nil then
		autoClear = true
	end

	if needPrepareResources == nil then
		needPrepareResources = true
	end

	AMPlayer.ClearSkillTargets()

	if targets then
		for i = 1, #targets do
			AMPlayer.AddSkillTarget(targets[i])
		end
	end

	self._isPlayingAnim = true
	self._unHandlerStarted = nil
	self._amPlayer = AMPlayer.Play(path, autoClear, self.handlePlayerEvent, self.handlerEvent, self, self, speed, needPrepareResources)
	self._amPlayer.autoClearRes = true

	if self._unHandlerStarted then
		self._unHandlerStarted = nil

		self:_onStart()
	end
end

function AnimationPlayer:PlayAnimWithSceneObjects(go, path, speed, autoClear, targets, needPrepareResources)
	if not path then
		return
	end

	speed = speed or 1

	if autoClear == nil then
		autoClear = true
	end

	if needPrepareResources == nil then
		needPrepareResources = true
	end

	AMPlayer.ClearTargets(go)

	if targets then
		for i = 1, #targets do
			AMPlayer.AddSkillTarget(targets[i])
		end
	end

	self._isPlayingAnim = true
	self._unHandlerStarted = nil
	self._amPlayer = AMPlayer.PlayUseSceneObjects(go, path, autoClear, self.handlePlayerEvent, self.handlerEvent, self, self, speed, needPrepareResources)
	self._amPlayer.autoClearRes = true

	if self._unHandlerStarted then
		self._unHandlerStarted = nil

		self:_onStart()
	end
end

function AnimationPlayer:PlayAnimWithObject(go, path, speed, autoClear, targets, needPrepareResources)
	if not path then
		return
	end

	speed = speed or 1

	if autoClear == nil then
		autoClear = true
	end

	if needPrepareResources == nil then
		needPrepareResources = true
	end

	AMPlayer.ClearTargets(go)

	if targets then
		for i = 1, #targets do
			AMPlayer.AddSkillTarget(go, targets[i])
		end
	end

	self._isPlayingAnim = true
	self._unHandlerStarted = nil
	self._amPlayer = AMPlayer.PlayWithObject(go, path, autoClear, self.handlePlayerEvent, self.handlerEvent, self, self, speed, needPrepareResources)
	self._amPlayer.autoClearRes = true

	if self._unHandlerStarted then
		self._unHandlerStarted = nil

		self:_onStart()
	end
end

function AnimationPlayer:getPlayer()
	return self._amPlayer
end

function AnimationPlayer:isPlayingAnim()
	return self._isPlayingAnim
end

function AnimationPlayer:Pause()
	if self._amPlayer then
		self._amPlayer:Pause()
	end
end

function AnimationPlayer:Resume()
	if self._amPlayer then
		self._amPlayer:Resume()
	end
end

function AnimationPlayer:Resume()
	if self._amPlayer then
		self._amPlayer:Resume()
	end
end

function AnimationPlayer:PauseAll()
	if self._amPlayer then
		self._amPlayer:PauseAll()
	end
end

function AnimationPlayer:ResumeAll()
	if self._amPlayer then
		self._amPlayer:ResumeAll()
	end
end

function AnimationPlayer:Stop()
	self._isPlayingAnim = nil

	if self._amPlayer then
		self._amPlayer:Stop()
	end
end

function AnimationPlayer:EnabledClickSkip(enabled)
	if self._amPlayer then
		self._amPlayer:EnabledClickSkip(enabled or false)
	end
end

function AnimationPlayer:NotifyBulletHitFinished(idx)
	if self._amPlayer then
		self._amPlayer:NotifyBulletHitFinished(idx)
	end
end

function AnimationPlayer:setFinishCallback(handler, obj)
	self._stopHandler = handler
	self._stopHandlerObj = obj
end

function AnimationPlayer:setOnPlayCallback(handler, obj)
	self._onPlayHandler = handler
	self._onPlayHandlerObj = obj
end

function AnimationPlayer:setStartCallback(handler, obj)
	self._onStartHandler = handler
	self._onStartHandlerObj = obj
end

function AnimationPlayer:setEvtHandler(handler, obj)
	self._onEvtHandler = handler
	self._onEvtHandlerObj = obj
end

function AnimationPlayer:handlePlayerEvent(evtName, player)
	if evtName == "play" then
		self:_onPlay(player)
	elseif evtName == "start" then
		self:_onStart(player)
	elseif evtName == "stop" then
		self:_onStop(player)
	end
end

function AnimationPlayer:_onPlay(player)
	if self._onPlayHandler then
		self._onPlayHandler(self._onPlayHandlerObj)

		self._onPlayHandler = nil
		self._onPlayHandler = nil
	end
end

function AnimationPlayer:_onStart(player)
	if self._amPlayer then
		self._savePlayAnimGo = nil
		self._savePlayAnim = nil
		self._savePlayAnimFadeTime = nil

		GlobalDispatcher:dispatch(GlobalNotify.StartAnimation, self)

		if self._onStartHandler then
			self._onStartHandler(self._onStartHandlerObj)

			self._onStartHandler = nil
			self._onStartHandler = nil
		end

		SceneMgr.instance:enabledSceneQuery(false)
	else
		self._unHandlerStarted = true
	end
end

function AnimationPlayer:_onStop(player)
	GlobalDispatcher:dispatch(GlobalNotify.EndAnimation, self)
	SceneMgr.instance:enabledSceneQuery(true)

	self._isPlayingAnim = nil
	self._amPlayer = nil
	self._playingStoryId = nil
	self._savePlayAnimGo = nil
	self._savePlayAnim = nil
	self._onEvtHandler = nil
	self._onEvtHandlerObj = nil
	self._savePlayAnimFadeTime = nil

	if self._stopHandler then
		local stopHandler = self._stopHandler
		local handlerTarget = self._stopHandlerObj

		self._stopHandler = nil
		self._stopHandlerObj = nil

		if stopHandler then
			self._stopHandler(handlerTarget)
		end
	end
end

function AnimationPlayer:handlerEvent(evtName, go, param1, param2, param3, param4, param5)
	if self._onEvtHandler then
		if self._onEvtHandlerObj then
			if self._onEvtHandler(self._onEvtHandlerObj, evtName, go, param1, param2, param3, param4, param5) then
				return
			end
		elseif self._onEvtHandler(evtName, go, param1, param2, param3, param4, param5) then
			return
		end
	end

	if evtName == "Move" then
		self:_onMove(go, param1)
	elseif evtName == "playSpinAnimation" then
		self:_onPlaySpineAnimation(go, param1, param2, param3, param4, param5)
	elseif evtName == "ActiveEffect" then
		self:_onActiveEffect(go, param1)
	elseif evtName == "DeActiveEffect" then
		self:_onDeActiveEffect(go)
	elseif evtName == "SetMainPlayerPosition" then
		self:_onSetMainPlayerPosition(go, param1, param2, param3)
	elseif evtName == "DestroyNpc" then
		self:_onDestroyNpc(go, param1)
	elseif evtName == "CreateElement" then
		self:_onCreateElement(go, param1, param2)
	elseif evtName == "DestroyElement" then
		self:_onDestroyElement(go, param1)
	elseif evtName == "LockMainPlayer" then
		self:_onLockMainPlayer(go)
	elseif evtName == "playanimator" then
		self:_onPlayanimator(go, param1, param2)
	elseif evtName == "playfmodaudio" then
		return (self:_onFmodAudioPlay(go, param1, param2))
	elseif evtName == "PlayStory" then
		self:_onPlayStory(go, param1)
	elseif evtName == "ShowUI" then
		self:_onShowUI(param1, param2)
	elseif evtName == "storytext" then
		self:_onUIText(go, param1)
	elseif evtName == "ShowAllNpcs" then
		self:_onShowAllNpcs()
	elseif evtName == "ShowAllElements" then
		self:_onShowAllElements(go)
	end
end

function AnimationPlayer:_onFmodAudioPlay(evtStr, accable, isCV)
	return BattleAnimEvevts.onFmodAudioPlay(evtStr, accable, isCV)
end

function AnimationPlayer:_onPlaySpineAnimation(go, animName, loop, flipX, speed)
	GoUtil.PlaySpineAnim(go, animName, flipX, loop, true, speed)
end

function AnimationPlayer:_onActiveEffect(go, loop)
	CameraRectSetter.CalcRect(go)
	go:SetActive(true)
end

function AnimationPlayer:_onDeActiveEffect(go)
	go:SetActive(false)
end

function AnimationPlayer:_onSetMainPlayerPosition(go, x, y, z)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		mainPlayer.transform:setPos(x, y)
	end
end

function AnimationPlayer:_onDestroyNpc(go, npcId)
	local scene = SceneMgr.instance:getCurScene()

	scene.unitFactory:destroyNpcById(npcId)
end

function AnimationPlayer:_onCreateElement(sceneId, elementId, layer)
	SceneElemsMgr.instance:createElem(sceneId, elementId, layer)
end

function AnimationPlayer:_onDestroyElement(sceneId, elementId)
	SceneElemsMgr.instance:removeElem(sceneId, elementId)
end

function AnimationPlayer:_onLockMainPlayer(lock)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene.joystick then
		scene.joystick:setEnable(not lock)
	end

	if scene and scene.picker then
		scene.picker:enabled(not lock)
	end

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		if lock then
			TaskController.instance:pause()
			mainPlayer:pauseAllActions()
		else
			TaskController.instance:resume()
			mainPlayer:resumeAllActions()

			if self._needResumeMount then
				SceneMainPlayer.instance:updateVariablesView()
			end
		end
	end

	if lock then
		SceneMainPlayer.instance:forceMainPlayerIdle()

		if self._savePlayAnim then
			self:_onPlayanimator(self._savePlayAnimGo, self._savePlayAnim, self._savePlayAnimFadeTime)
		end
	end

	self._savePlayAnimGo = nil
	self._savePlayAnim = nil
	self._savePlayAnimFadeTime = nil
	self._needResumeMount = nil
end

function AnimationPlayer:_onPlayanimator(go, animName, fadeTime)
	self._savePlayAnimGo = go
	self._savePlayAnim = animName
	self._savePlayAnimFadeTime = fadeTime
	self._needResumeMount = nil

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer and go == mainPlayer.go then
		local avatarMo = mainPlayer.spine:getAvatarMo()

		if avatarMo and avatarMo.mount == DressModel.EscortMountId then
			self._needResumeMount = true
		end

		SceneMainPlayer.instance:forceSyncMountState()
		mainPlayer:dismount()
	end

	GoUtil.PlayAnimator(go, animName, fadeTime)
end

function AnimationPlayer:_onPlayStory(go, storyId)
	self._playingStoryId = storyId

	GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onStoryPlayFinished, self)
	GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
end

function AnimationPlayer:_onMove(go, position)
	go.transform.position = position
end

function AnimationPlayer:_onStoryPlayFinished(storyId)
	if self._playingStoryId == storyId then
		GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStoryPlayFinished, self)

		if self._amPlayer then
			self._amPlayer:NotifyStoryPlayFinished()
		end
	end
end

function AnimationPlayer:_onShowUI(nodeName, show)
	GlobalModel.instance:showUI(show)
end

function AnimationPlayer:_onUIText(label, textId)
	label.text = StoryConfig.instance:getStortText(textId)
end

function AnimationPlayer:_onShowAllNpcs()
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() ~= SceneType.Battle then
		scene:visibleNpcs(true)
	end
end

function AnimationPlayer:_onShowAllElements(show)
	local scene = SceneMgr.instance:getCurScene()

	if scene and scene:getSceneType() ~= SceneType.Battle then
		scene.stage.wholeScene:ShowAllElements(show)
	end
end

AnimationPlayer.instance = AnimationPlayer.New()

return AnimationPlayer
