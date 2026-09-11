local HeroUITimeline = class("HeroUITimeline")

local function var_0_1(arg_1_0)
	if arg_1_0 == nil or HeroUITimelineBrain == nil then
		return nil
	end

	local var_1_0 = typeof(HeroUITimelineBrain)
	local var_1_1 = arg_1_0:GetComponent(var_1_0)

	if var_1_1 == nil then
		var_1_1 = arg_1_0:AddComponent(var_1_0)
	end

	return var_1_1
end

local function var_0_2(arg_2_0)
	if arg_2_0 == nil then
		return nil
	end

	return arg_2_0:GetComponentInChildren(typeof(Animator))
end

local var_0_3 = {
	fadeSecond = 0.5,
	isUniqueBlending = true
}

function HeroUITimeline:Ctor()
	self.stopped_ = handler(self, self._OnTimelineStopped)
	self.stoppedCallbacks_ = {}
	self.blendSignalCallbacks_ = {}
	self.playTimelineCallbacksForTimes_ = {}
	self.playInfo_ = var_0_3
end

function HeroUITimeline:BindHero(arg_4_1, arg_4_2, arg_4_3)
	self.skinId_ = arg_4_1
	self.modelId_ = arg_4_2
	self.modelGo_ = arg_4_3

	if not isNil(self.animator_) then
		self.animator_.runtimeAnimatorController = self.controller_
	end

	self.animator_ = var_0_2(arg_4_3)

	if self.animator_ then
		self.controller_ = self.animator_.runtimeAnimatorController
	end
end

function HeroUITimeline:Unbind()
	self:TryJumpToEnd()
	self:Stop()
	self:BindHero(nil, nil, nil)
end

function HeroUITimeline:TryJumpToEnd()
	if not isNil(self.playableDirector_) then
		self:JumpToTime(self.playableDirector_.duration, true)
	end
end

function HeroUITimeline:AddCallback(arg_7_1, arg_7_2)
	if arg_7_1 then
		table.insert(self.stoppedCallbacks_, arg_7_1)
	end

	if arg_7_2 then
		table.insert(self.blendSignalCallbacks_, arg_7_2)
	end
end

function HeroUITimeline:RemoveCallback(arg_8_1, arg_8_2)
	if arg_8_1 then
		table.removebyvalue(self.stoppedCallbacks_, arg_8_1)
	end

	if arg_8_2 then
		table.removebyvalue(self.blendSignalCallbacks_, arg_8_2)
	end
end

function HeroUITimeline:AddTimeCallback(arg_9_1, arg_9_2, arg_9_3)
	self.playTimelineCallbacksForTimes_ = self.playTimelineCallbacksForTimes_ or {}

	if arg_9_1 then
		self.playTimelineCallbacksForTimes_[arg_9_1] = {
			startTime = arg_9_2,
			callBack = arg_9_3
		}
	end
end

function HeroUITimeline:RemoveTimeCallback(arg_10_1)
	self.playTimelineCallbacksForTimes_[arg_10_1] = nil
end

function HeroUITimeline:PlayAction(arg_11_1, arg_11_2)
	if self.skinId_ == nil or self.modelId_ == nil then
		return
	end

	local var_11_0 = var_0_1(self.modelGo_)

	if var_11_0 == nil then
		Debug.LogError(string.format("无法播放Timeline %s, 找不到brain", arg_11_1))

		return
	end

	self.brain_ = var_11_0

	if arg_11_2 then
		self.playInfo_ = clone(var_0_3)

		table.merge(self.playInfo_, arg_11_2)
	else
		self.playInfo_ = var_0_3
	end

	self.needSignal_ = not self.playInfo_.isLoop

	local var_11_1, var_11_2 = manager.heroUiTimelinePool:GetTimelineAction(self.skinId_, self.modelId_, arg_11_1)

	if isNil(var_11_1) or isNil(var_11_2) then
		return
	end

	SetActive(var_11_2, true)
	var_11_2.transform:SetParent(self.modelGo_.transform)

	var_11_2.transform.localPosition = Vector3.zero
	var_11_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
	var_11_2.transform.localScale = Vector3.one

	self:_BindPlayable(var_11_1)

	if self.playInfo_.isLoop ~= nil then
		if self.playInfo_.isLoop then
			var_11_1.extrapolationMode = UnityEngine.Playables.DirectorWrapMode.Loop or UnityEngine.Playables.DirectorWrapMode.None
		end
	end

	if self.animator_ then
		self.animator_.runtimeAnimatorController = nil
	end

	self.brain_:RebuildPlayableDirector(var_11_1)
	self:_TransitionTimeline(arg_11_1, var_11_2, var_11_1)
	var_11_1:Evaluate()
end

function HeroUITimeline:Stop()
	self:_StopTimer()

	if not isNil(self.playableDirector_) then
		self.playableDirector_:Stop()

		self.playableDirector_.stopped = self.playableDirector_.stopped - self.stopped_
		self.playableDirector_ = nil
		self.directorTime_ = 0
	end

	if self.timelineGo_ then
		self:_SwitchGroup(nil)

		self.timelineGo_ = nil
	end

	if self.animator_ then
		self.animator_.runtimeAnimatorController = self.controller_

		local var_12_0 = self.animator_:GetCurrentAnimatorClipInfo(0)

		if var_12_0.Length > 0 then
			self.animator_:Play(var_12_0[0].clip.name, -1, 0)
		end
	end

	self.actionName_ = nil
	self.lastBlendTime_ = nil
	self.needSignal_ = nil
end

function HeroUITimeline:JumpToTime(arg_13_1, arg_13_2)
	if not isNil(self.playableDirector_) and self.playableDirector_ then
		self.playableDirector_.time = arg_13_1

		if arg_13_2 then
			self.playableDirector_:Evaluate()
		end
	end
end

function HeroUITimeline:PrepareAction(arg_14_1)
	if self.skinId_ == nil or self.modelId_ == nil then
		return
	end

	local var_14_0, var_14_1 = manager.heroUiTimelinePool:GetTimelineAction(self.skinId_, self.modelId_, arg_14_1)

	if not isNil(var_14_1) then
		var_14_1.transform:SetParent(self.modelGo_.transform)
		manager.heroUiTimelinePool:ReturnTimelineAction(var_14_1)
	end
end

function HeroUITimeline:_TransitionTimeline(arg_15_1, arg_15_2, arg_15_3)
	self:_StartTimer()

	if self.playableDirector_ ~= arg_15_3 then
		self.isTransitioning = true

		if not isNil(self.playableDirector_) then
			self.playableDirector_:Stop()

			self.playableDirector_.stopped = self.playableDirector_.stopped - self.stopped_
			self.playableDirector_ = nil
			self.directorTime_ = 0

			if arg_15_3 then
				self.lastBlendTime_ = self.playInfo_.fadeSecond
			end
		end

		if arg_15_3 then
			self.playableDirector_ = arg_15_3
			self.playableDirector_.stopped = self.playableDirector_.stopped + self.stopped_

			arg_15_3:Play()
		end

		self.isTransitioning = false
	end

	if self.timelineGo_ ~= arg_15_2 then
		if self.timelineGo_ then
			self:_SwitchGroup(self.playInfo_.group)

			self.timelineGo_ = nil
		end

		self.timelineGo_ = arg_15_2
	end

	self.actionName_ = arg_15_1
end

function HeroUITimeline:_SwitchGroup(arg_16_1)
	if arg_16_1 then
		if arg_16_1 ~= self.lastGroup_ then
			self:_ReleaseGroup()
		else
			self.groupList_ = self.groupList_ or {}

			table.insert(self.groupList_, self.timelineGo_)
		end
	else
		self:_ReleaseGroup()
	end

	self.lastGroup_ = arg_16_1
end

function HeroUITimeline:_ReleaseGroup()
	if self.groupList_ then
		for iter_17_0, iter_17_1 in ipairs(self.groupList_) do
			manager.heroUiTimelinePool:ReturnTimelineAction(iter_17_1)
		end
	end

	self.groupList_ = nil

	manager.heroUiTimelinePool:ReturnTimelineAction(self.timelineGo_)
end

function HeroUITimeline:_BindPlayable(arg_18_1)
	self.brain_.talking = self.playInfo_.talking

	self.brain_:BindPlayableDirector(arg_18_1)
end

function HeroUITimeline:GetTimelineBrain()
	return self.brain_
end

function HeroUITimeline:_OnTimelineStopped(arg_20_1)
	if not self.isTransitioning and self.needSignal_ then
		local var_20_0 = self.directorTime_ or self.playableDirector_.time

		if self.playableDirector_.duration < var_20_0 + self.playInfo_.fadeSecond and self.playInfo_.isUniqueBlending and self.lastBlendTime_ and var_20_0 < self.lastBlendTime_ then
			self.needSignal_ = false

			self:_OnTimelineBlendSignal()
		end
	end

	for iter_20_0, iter_20_1 in ipairs(self.stoppedCallbacks_) do
		iter_20_1(arg_20_1)
	end
end

function HeroUITimeline:_OnTimelineBlendSignal()
	for iter_21_0, iter_21_1 in ipairs(self.blendSignalCallbacks_) do
		iter_21_1()
	end
end

function HeroUITimeline:_Tick()
	if isNil(self.playableDirector_) then
		return
	end

	if self.needSignal_ then
		self.directorTime_ = self.playableDirector_.time

		if self.playableDirector_.duration < self.playableDirector_.time + self.playInfo_.fadeSecond then
			if not (self.playInfo_.isUniqueBlending and self.lastBlendTime_ and self.playableDirector_.time < self.lastBlendTime_) then
				self.needSignal_ = false

				self:_OnTimelineBlendSignal()
			end
		end

		if self.playTimelineCallbacksForTimes_ and self.playTimelineCallbacksForTimes_[self.actionName_] then
			if self.playableDirector_.time >= self.playTimelineCallbacksForTimes_[self.actionName_].startTime then
				if self.playTimelineCallbacksForTimes_[self.actionName_].callBack then
					self.playTimelineCallbacksForTimes_[self.actionName_].callBack()
				end

				self:RemoveTimeCallback(self.actionName_)
			end
		end
	end
end

function HeroUITimeline:_StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:_Tick()
		end, 0.033, -1)

		self.timer_:Start()
	end
end

function HeroUITimeline:_StopTimer()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function HeroUITimeline:Dispose()
	self:Stop()

	self.skinId_ = nil
	self.modelGo_ = nil
	self.animator_ = nil
	self.stoppedCallbacks_ = nil
	self.playTimelineCallbacksForTimes_ = nil
	self.stopped_ = nil
end

return HeroUITimeline
