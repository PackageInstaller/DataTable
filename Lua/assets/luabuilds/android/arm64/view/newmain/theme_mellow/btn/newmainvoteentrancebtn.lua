local var_0_0 = class("NewMainVoteEntranceBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0.event = arg_1_2

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.tip = arg_2_0._tf:Find("tip")

	setActive(arg_2_0.tip, arg_2_0:IsShowTip())
	onButton(arg_2_0, arg_2_0._tf, function()
		arg_2_0.event:emit(NewMainMediator.GO_SCENE, SCENE.VOTEENTRANCE)

		return
	end, SFX_MAIN)

	local var_2_0 = getProxy(VoteProxy):IsAllRaceEnd()
	local var_2_1 = arg_2_0:AnyVoteActIsOpening()

	setActive(arg_2_0._tf:Find("unopen"), not var_2_0 and var_2_1)
	setActive(arg_2_0._tf:Find("end"), var_2_0)

	arg_2_0._tf:GetComponent(typeof(Image)).enabled = not var_2_0 and not var_2_1

	return
end

function var_0_0.InShowTime(arg_4_0)
	local var_4_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	return var_4_0 and not var_4_0:isEnd()
end

function var_0_0.AnyVoteActIsOpening(arg_5_0)
	return getProxy(VoteProxy):AnyVoteActIsOpening()
end

function var_0_0.IsShowTip(arg_6_0)
	return NewMainVoteEntranceBtn.ShouldTipNewRace() or NewMainVoteEntranceBtn.ShouldTipVotes() or NewMainVoteEntranceBtn.ShouldTipAward() or NewMainVoteEntranceBtn.ShouldTipFinalAward()
end

function var_0_0.ShouldTipFinalAward()
	local var_7_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	if not var_7_0 or var_7_0:isEnd() then
		return false
	end

	local var_7_1 = var_7_0:getConfig("config_client")[2] or -1
	local var_7_2 = getProxy(TaskProxy):getTaskById(var_7_1)

	var_7_2 = var_7_2 or getProxy(TaskProxy):getFinishTaskById(var_7_1)

	return var_7_2 and var_7_2:isFinish() and not var_7_2:isReceive()
end

function var_0_0.ShouldTipNewRace()
	local var_8_0 = getProxy(PlayerProxy):getRawData().id

	for iter_8_0, iter_8_1 in ipairs((getProxy(VoteProxy):GetVoteGroupList())) do
		if iter_8_1 and iter_8_1:IsOpening() then
			local var_8_1 = getProxy(VoteProxy)

			if var_8_1:IsNewRace(iter_8_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0.ShouldTipVotes()
	for iter_9_0, iter_9_1 in ipairs((getProxy(VoteProxy):GetVoteGroupList())) do
		local var_9_0 = getProxy(VoteProxy)

		if var_9_0:GetVotesByConfigId(iter_9_1.configId) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.ShouldTipAward()
	return getProxy(VoteProxy):ExistPastVoteAward()
end

function var_0_0.Hide(arg_11_0)
	if arg_11_0._tf then
		setActive(arg_11_0._tf, false)
	end

	return
end

function var_0_0.IsShowTip()
	return NewMainVoteEntranceBtn.ShouldTipNewRace() or NewMainVoteEntranceBtn.ShouldTipVotes() or NewMainVoteEntranceBtn.ShouldTipAward() or NewMainVoteEntranceBtn.ShouldTipFinalAward()
end

function var_0_0.Dispose(arg_13_0)
	return
end

return var_0_0
