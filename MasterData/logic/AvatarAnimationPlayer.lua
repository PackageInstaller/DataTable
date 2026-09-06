-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/controller/AvatarAnimationPlayer.lua

module("logic.extensions.story.controller.AvatarAnimationPlayer", package.seeall)

local AvatarAnimationPlayer = class("AvatarAnimationPlayer", AnimationPlayer)

function AvatarAnimationPlayer.playWithUnit(unit, path, onAnimPlayFinish, onAnimPlayStart, handleObject, speed, autoClear, needPrepareResources, targets)
	local anim = AvatarAnimationPlayer.New()

	anim.unit = unit

	anim:setFinishCallback(onAnimPlayFinish, handleObject)
	anim:setStartCallback(onAnimPlayStart, handleObject)
	anim:PlayAnimWithObject(unit.go, path, speed, autoClear, targets, needPrepareResources == nil and true or needPrepareResources)

	return anim
end

function AvatarAnimationPlayer:_onStart(player)
	if self._amPlayer then
		if self._onStartHandler then
			self._onStartHandler(self._onStartHandlerObj)

			self._onStartHandler = nil
			self._onStartHandler = nil
		end
	else
		self._unHandlerStarted = true
	end
end

function AvatarAnimationPlayer:_onStop(player)
	self._amPlayer = nil
	self._onEvtHandler = nil
	self._onEvtHandlerObj = nil

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

function AvatarAnimationPlayer:_onActiveEffect(go, loop)
	go:SetActive(true)

	local avatarRoot = self.unit.mountRoot:getAvatarRoot()

	if avatarRoot then
		go.transform.eulerAngles = avatarRoot.transform.eulerAngles
		go.transform.localScale = avatarRoot.transform.lossyScale
	end
end

function AvatarAnimationPlayer:_onDeActiveEffect(go)
	go:SetActive(false)
end

function AvatarAnimationPlayer:_onPlayanimator(go, animName, fadeTime)
	self.unit.spine:play(animName)
end

return AvatarAnimationPlayer
