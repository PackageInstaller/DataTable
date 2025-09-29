-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/standard/SimpleTimelinePlayer.lua

module("logic.battle.skill.performance.standard.SimpleTimelinePlayer", package.seeall)

local M = class("SimpleTimelinePlayer", AbstractGlobalReusable)

function M:ctor()
	self._directorSetter = PlayableDirectorSetter.New()
	self._handler = Handler.New()
	self._attackInfo = SkillAttackInfo.New()
end

function M:reset()
	if self._goTimeline then
		goutil.destroy(self._goTimeline)
		self:_cleanTimelineBindings()

		self._goTimeline = false
	end

	if self._timelineListener then
		self._timelineListener:RemoveListener()

		self._timelineListener = false
	end

	self._directorSetter:Clear()
	self._handler:clear()
	self._attackInfo:clear()
end

function M:destroy()
	self:reset()

	self._directorSetter = false
end

function M:setVisible(visible)
	if self._goTimeline then
		if visible then
			goutil.setActive(self._goTimeline, true)

			local time = self._directorSetter:GetMultiRoundSkillSeparationMarkerTime()

			self._directorSetter:JumpToTime(time)
		else
			goutil.setActive(self._goTimeline, false)
		end
	end
end

function M:buildTimelineInstance(goTimeline, callback, callbackSelf, attacker)
	self._isFinished = false
	self._goTimeline = goTimeline
	self._isFirstPiece = true

	self._directorSetter:Build(goTimeline)
	self._directorSetter:SetWrapMode(UnityEngine.Playables.DirectorWrapMode.None)
	self._directorSetter:Stop()

	self._timelineListener = TimelineEventListener.Get(goTimeline)

	self._timelineListener:AddListener(self._onTimelineEvent, self)

	if attacker then
		self._attackInfo:setAttacker(attacker)
	end

	self:_setTimelineBindings()

	if callback then
		self._handler:setListener(callback, callbackSelf)
	end

	goutil.setActive(self._goTimeline, true)
	self._directorSetter:Play()
end

function M:_setTimelineBindings()
	SkillPerformanceAssistant:setupTimelineBindings(self._directorSetter, self._goTimeline, self._attackInfo)
end

function M:_cleanTimelineBindings()
	SkillPerformanceAssistant:cleanupTimelineBindings(self._directorSetter, self._attackInfo)
end

function M:_onTimelineEvent(eventName, param)
	if eventName == BattleTimelineEventName.EventMultiRoundSkillSeparation then
		if self._isFirstPiece then
			self:_onFinishFirstPiece()
		end
	elseif eventName == BattleTimelineEventName.Stopped then
		self._isFinished = true

		self:_onTimelineStop()
	end
end

function M:isFinished()
	return self._isFinished
end

function M:playPart2Timeline(callback, callbackSelf, param)
	self._param = param

	if self._isFirstPiece then
		self._isFirstPiece = false

		self._directorSetter:Play()
		self._handler:setListener(callback, callbackSelf)
	else
		self._handler:executeCallback(callback, callbackSelf, param)
	end
end

function M:_onFinishFirstPiece()
	self._directorSetter:Pause()
	self._handler:call()
end

function M:_onTimelineStop()
	self._handler:call(self._param)
end

return M
