local var_0_0 = class("HeroUITimeline")

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

function var_0_0.Ctor(arg_3_0)
	arg_3_0.stopped_ = handler(arg_3_0, arg_3_0._OnTimelineStopped)
	arg_3_0.stoppedCallbacks_ = {}
	arg_3_0.blendSignalCallbacks_ = {}
	arg_3_0.playTimelineCallbacksForTimes_ = {}
	arg_3_0.playInfo_ = var_0_3
end

function var_0_0.BindHero(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.skinId_ = arg_4_1
	arg_4_0.modelId_ = arg_4_2
	arg_4_0.modelGo_ = arg_4_3

	if not isNil(arg_4_0.animator_) then
		arg_4_0.animator_.runtimeAnimatorController = arg_4_0.controller_
	end

	arg_4_0.animator_ = var_0_2(arg_4_3)

	if arg_4_0.animator_ then
		arg_4_0.controller_ = arg_4_0.animator_.runtimeAnimatorController
	end
end

function var_0_0.Unbind(arg_5_0)
	arg_5_0:TryJumpToEnd()
	arg_5_0:Stop()
	arg_5_0:BindHero(nil, nil, nil)
end

function var_0_0.TryJumpToEnd(arg_6_0)
	if not isNil(arg_6_0.playableDirector_) then
		arg_6_0:JumpToTime(arg_6_0.playableDirector_.duration, true)
	end
end

function var_0_0.AddCallback(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		table.insert(arg_7_0.stoppedCallbacks_, arg_7_1)
	end

	if arg_7_2 then
		table.insert(arg_7_0.blendSignalCallbacks_, arg_7_2)
	end
end

function var_0_0.RemoveCallback(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		table.removebyvalue(arg_8_0.stoppedCallbacks_, arg_8_1)
	end

	if arg_8_2 then
		table.removebyvalue(arg_8_0.blendSignalCallbacks_, arg_8_2)
	end
end

function var_0_0.AddTimeCallback(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0.playTimelineCallbacksForTimes_ then
		arg_9_0.playTimelineCallbacksForTimes_ = {}
	end

	if arg_9_1 then
		arg_9_0.playTimelineCallbacksForTimes_[arg_9_1] = {
			startTime = arg_9_2,
			callBack = arg_9_3
		}
	end
end

function var_0_0.RemoveTimeCallback(arg_10_0, arg_10_1)
	arg_10_0.playTimelineCallbacksForTimes_[arg_10_1] = nil
end

function var_0_0.PlayAction(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.skinId_ == nil or arg_11_0.modelId_ == nil then
		return
	end

	local var_11_0 = var_0_1(arg_11_0.modelGo_)

	if var_11_0 == nil then
		Debug.LogError(string.format("无法播放Timeline %s, 找不到brain", arg_11_1))

		return
	end

	arg_11_0.brain_ = var_11_0

	if arg_11_2 then
		arg_11_0.playInfo_ = clone(var_0_3)

		table.merge(arg_11_0.playInfo_, arg_11_2)
	else
		arg_11_0.playInfo_ = var_0_3
	end

	arg_11_0.needSignal_ = not arg_11_0.playInfo_.isLoop

	local var_11_1, var_11_2 = manager.heroUiTimelinePool:GetTimelineAction(arg_11_0.skinId_, arg_11_0.modelId_, arg_11_1)

	if isNil(var_11_1) or isNil(var_11_2) then
		return
	end

	SetActive(var_11_2, true)
	var_11_2.transform:SetParent(arg_11_0.modelGo_.transform)

	var_11_2.transform.localPosition = Vector3.zero
	var_11_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
	var_11_2.transform.localScale = Vector3.one

	arg_11_0:_BindPlayable(var_11_1)

	if arg_11_0.playInfo_.isLoop ~= nil then
		var_11_1.extrapolationMode = arg_11_0.playInfo_.isLoop and UnityEngine.Playables.DirectorWrapMode.Loop or UnityEngine.Playables.DirectorWrapMode.None
	end

	if arg_11_0.animator_ then
		arg_11_0.animator_.runtimeAnimatorController = nil
	end

	arg_11_0.brain_:RebuildPlayableDirector(var_11_1)
	arg_11_0:_TransitionTimeline(arg_11_1, var_11_2, var_11_1)
	var_11_1:Evaluate()
end

function var_0_0.Stop(arg_12_0)
	arg_12_0:_StopTimer()

	if not isNil(arg_12_0.playableDirector_) then
		arg_12_0.playableDirector_:Stop()

		arg_12_0.playableDirector_.stopped = arg_12_0.playableDirector_.stopped - arg_12_0.stopped_
		arg_12_0.playableDirector_ = nil
		arg_12_0.directorTime_ = 0
	end

	if arg_12_0.timelineGo_ then
		arg_12_0:_SwitchGroup(nil)

		arg_12_0.timelineGo_ = nil
	end

	if arg_12_0.animator_ then
		arg_12_0.animator_.runtimeAnimatorController = arg_12_0.controller_

		local var_12_0 = arg_12_0.animator_:GetCurrentAnimatorClipInfo(0)

		if var_12_0.Length > 0 then
			local var_12_1 = var_12_0[0].clip.name

			arg_12_0.animator_:Play(var_12_1, -1, 0)
		end
	end

	arg_12_0.actionName_ = nil
	arg_12_0.lastBlendTime_ = nil
	arg_12_0.needSignal_ = nil
end

function var_0_0.JumpToTime(arg_13_0, arg_13_1, arg_13_2)
	if not isNil(arg_13_0.playableDirector_) and arg_13_0.playableDirector_ then
		arg_13_0.playableDirector_.time = arg_13_1

		if arg_13_2 then
			arg_13_0.playableDirector_:Evaluate()
		end
	end
end

function var_0_0.PrepareAction(arg_14_0, arg_14_1)
	if arg_14_0.skinId_ == nil or arg_14_0.modelId_ == nil then
		return
	end

	local var_14_0, var_14_1 = manager.heroUiTimelinePool:GetTimelineAction(arg_14_0.skinId_, arg_14_0.modelId_, arg_14_1)

	if not isNil(var_14_1) then
		var_14_1.transform:SetParent(arg_14_0.modelGo_.transform)
		manager.heroUiTimelinePool:ReturnTimelineAction(var_14_1)
	end
end

function var_0_0._TransitionTimeline(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0:_StartTimer()

	if arg_15_0.playableDirector_ ~= arg_15_3 then
		arg_15_0.isTransitioning = true

		if not isNil(arg_15_0.playableDirector_) then
			arg_15_0.playableDirector_:Stop()

			arg_15_0.playableDirector_.stopped = arg_15_0.playableDirector_.stopped - arg_15_0.stopped_
			arg_15_0.playableDirector_ = nil
			arg_15_0.directorTime_ = 0

			if arg_15_3 then
				arg_15_0.lastBlendTime_ = arg_15_0.playInfo_.fadeSecond
			end
		end

		if arg_15_3 then
			arg_15_0.playableDirector_ = arg_15_3
			arg_15_0.playableDirector_.stopped = arg_15_0.playableDirector_.stopped + arg_15_0.stopped_

			arg_15_3:Play()
		end

		arg_15_0.isTransitioning = false
	end

	if arg_15_0.timelineGo_ ~= arg_15_2 then
		if arg_15_0.timelineGo_ then
			arg_15_0:_SwitchGroup(arg_15_0.playInfo_.group)

			arg_15_0.timelineGo_ = nil
		end

		arg_15_0.timelineGo_ = arg_15_2
	end

	arg_15_0.actionName_ = arg_15_1
end

function var_0_0._SwitchGroup(arg_16_0, arg_16_1)
	if arg_16_1 then
		if arg_16_1 ~= arg_16_0.lastGroup_ then
			arg_16_0:_ReleaseGroup()
		else
			arg_16_0.groupList_ = arg_16_0.groupList_ or {}

			table.insert(arg_16_0.groupList_, arg_16_0.timelineGo_)
		end
	else
		arg_16_0:_ReleaseGroup()
	end

	arg_16_0.lastGroup_ = arg_16_1
end

function var_0_0._ReleaseGroup(arg_17_0)
	if arg_17_0.groupList_ then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0.groupList_) do
			manager.heroUiTimelinePool:ReturnTimelineAction(iter_17_1)
		end
	end

	arg_17_0.groupList_ = nil

	manager.heroUiTimelinePool:ReturnTimelineAction(arg_17_0.timelineGo_)
end

function var_0_0._BindPlayable(arg_18_0, arg_18_1)
	arg_18_0.brain_.talking = arg_18_0.playInfo_.talking

	arg_18_0.brain_:BindPlayableDirector(arg_18_1)
end

function var_0_0.GetTimelineBrain(arg_19_0)
	return arg_19_0.brain_
end

function var_0_0._OnTimelineStopped(arg_20_0, arg_20_1)
	if not arg_20_0.isTransitioning and arg_20_0.needSignal_ then
		local var_20_0 = arg_20_0.playableDirector_.duration
		local var_20_1 = arg_20_0.directorTime_ or arg_20_0.playableDirector_.time

		if var_20_0 < var_20_1 + arg_20_0.playInfo_.fadeSecond and arg_20_0.playInfo_.isUniqueBlending and arg_20_0.lastBlendTime_ and var_20_1 < arg_20_0.lastBlendTime_ then
			arg_20_0.needSignal_ = false

			arg_20_0:_OnTimelineBlendSignal()
		end
	end

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.stoppedCallbacks_) do
		iter_20_1(arg_20_1)
	end
end

function var_0_0._OnTimelineBlendSignal(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.blendSignalCallbacks_) do
		iter_21_1()
	end
end

function var_0_0._Tick(arg_22_0)
	if isNil(arg_22_0.playableDirector_) then
		return
	end

	if arg_22_0.needSignal_ then
		local var_22_0 = arg_22_0.playableDirector_.duration
		local var_22_1 = arg_22_0.playableDirector_.time

		arg_22_0.directorTime_ = var_22_1

		if var_22_0 < var_22_1 + arg_22_0.playInfo_.fadeSecond then
			local var_22_2 = true

			if arg_22_0.playInfo_.isUniqueBlending and arg_22_0.lastBlendTime_ and var_22_1 < arg_22_0.lastBlendTime_ then
				var_22_2 = false
			end

			if var_22_2 then
				arg_22_0.needSignal_ = false

				arg_22_0:_OnTimelineBlendSignal()
			end
		end

		if arg_22_0.playTimelineCallbacksForTimes_ and arg_22_0.playTimelineCallbacksForTimes_[arg_22_0.actionName_] then
			local var_22_3 = arg_22_0.playTimelineCallbacksForTimes_[arg_22_0.actionName_]

			if var_22_1 >= var_22_3.startTime then
				if var_22_3.callBack then
					var_22_3.callBack()
				end

				arg_22_0:RemoveTimeCallback(arg_22_0.actionName_)
			end
		end
	end
end

function var_0_0._StartTimer(arg_23_0)
	if arg_23_0.timer_ == nil then
		arg_23_0.timer_ = Timer.New(function()
			arg_23_0:_Tick()
		end, 0.033, -1)

		arg_23_0.timer_:Start()
	end
end

function var_0_0._StopTimer(arg_25_0)
	if arg_25_0.timer_ ~= nil then
		arg_25_0.timer_:Stop()

		arg_25_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0:Stop()

	arg_26_0.skinId_ = nil
	arg_26_0.modelGo_ = nil
	arg_26_0.animator_ = nil
	arg_26_0.stoppedCallbacks_ = nil
	arg_26_0.playTimelineCallbacksForTimes_ = nil
	arg_26_0.stopped_ = nil
end

return var_0_0
