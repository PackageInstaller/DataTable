local var_0_0 = class("MainVoteEntranceBtn", import(".MainBaseSpcailActBtn"))

function var_0_0.GetContainer(arg_1_0)
	return arg_1_0.root.parent:Find("eventPanel")
end

function var_0_0.InShowTime(arg_2_0)
	local var_2_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	return var_2_0 and not var_2_0:isEnd()
end

function var_0_0.GetUIName(arg_3_0)
	return "MainUIVoteActBtn"
end

function var_0_0.OnClick(arg_4_0)
	arg_4_0.event:emit(NewMainMediator.GO_SCENE, SCENE.VOTEENTRANCE)

	return
end

function var_0_0.OnInit(arg_5_0)
	local var_5_0 = arg_5_0:ShouldTipNewRace() or arg_5_0:ShouldTipVotes() or arg_5_0:ShouldTipAward() or arg_5_0:ShouldTipFinalAward()

	setActive(arg_5_0._tf:Find("tip"), var_5_0)

	local var_5_1 = getProxy(VoteProxy):IsAllRaceEnd()
	local var_5_2 = arg_5_0:AnyVoteActIsOpening()

	setActive(arg_5_0._tf:Find("unopen"), not var_5_1 and var_5_2)
	setActive(arg_5_0._tf:Find("end"), var_5_1)

	arg_5_0._tf:GetComponent(typeof(Image)).enabled = not var_5_1 and not var_5_2

	return
end

function var_0_0.AnyVoteActIsOpening(arg_6_0)
	return getProxy(VoteProxy):AnyVoteActIsOpening()
end

function var_0_0.ShouldTipFinalAward(arg_7_0)
	local var_7_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	if not var_7_0 or var_7_0:isEnd() then
		return false
	end

	local var_7_1 = var_7_0:getConfig("config_client")[2] or -1
	local var_7_2 = getProxy(TaskProxy):getTaskById(var_7_1)

	var_7_2 = var_7_2 or getProxy(TaskProxy):getFinishTaskById(var_7_1)

	return var_7_2 and var_7_2:isFinish() and not var_7_2:isReceive()
end

function var_0_0.ShouldTipNewRace(arg_8_0)
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

function var_0_0.ShouldTipVotes(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs((getProxy(VoteProxy):GetVoteGroupList())) do
		local var_9_0 = getProxy(VoteProxy)

		if var_9_0:GetVotesByConfigId(iter_9_1.configId) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.ShouldTipAward(arg_10_0)
	return getProxy(VoteProxy):ExistPastVoteAward()
end

return var_0_0
