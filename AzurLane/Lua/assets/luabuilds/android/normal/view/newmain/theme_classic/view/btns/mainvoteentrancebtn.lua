class = var_0_10000

local var_0_0 = "MainVoteEntranceBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseSpcailActBtn"))

function var_0_1.GetContainer(arg_1_0)
	local var_1_0 = arg_1_0.root.parent

	return var_1.Find(var_1_0, "eventPanel")
end

function var_0_1.InShowTime(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_2_2

	var_2_2 = var_2_1(var_2_0, var_1_10003.VOTE_ENTRANCE_ACT_ID) and not var_1:isEnd()

	return var_2_2
end

function var_0_1.GetUIName(arg_3_0)
	return "MainUIVoteActBtn"
end

function var_0_1.OnClick(arg_4_0)
	local var_4_0 = arg_4_0.event
	local var_4_1 = var_1.emit

	NewMainMediator = var_1_10003

	local var_4_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_4_1(var_4_0, var_4_2, var_1_10004.VOTEENTRANCE)

	return
end

function var_0_1.OnInit(arg_5_0)
	setActive = var_1_10001

	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_2.Find(var_5_0, "tip")
	local var_5_2

	if not arg_5_0:ShouldTipNewRace() and not arg_5_0:ShouldTipVotes() and not arg_5_0:ShouldTipAward() then
		var_5_2 = arg_5_0:ShouldTipFinalAward()
	end

	var_1_10001(var_5_1, var_5_2)

	getProxy = var_1_10001
	VoteProxy = var_5_1

	local var_5_3 = var_1_10001(var_5_1)
	local var_5_4 = var_1.IsAllRaceEnd(var_5_3)
	local var_5_5 = arg_5_0
	local var_5_6 = arg_5_0.AnyVoteActIsOpening(var_5_5)

	setActive = var_5_5

	local var_5_7 = arg_5_0._tf

	var_5_5(var_4.Find(var_5_7, "unopen"), not var_5_4 and var_5_6)

	setActive = var_5_5

	local var_5_8 = arg_5_0._tf

	var_5_5(var_4.Find(var_5_8, "end"), var_5_4)

	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_3.GetComponent

	typeof = var_5
	Image = var_6
	var_5_10(var_5_9, var_5(var_6)).enabled = not var_5_4 and not var_5_6

	return
end

function var_0_1.AnyVoteActIsOpening(arg_6_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)

	return var_1.AnyVoteActIsOpening(var_6_0)
end

function var_0_1.ShouldTipFinalAward(arg_7_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)
	local var_7_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	if not var_7_1(var_7_0, var_1_10003.VOTE_ENTRANCE_ACT_ID) or var_1:isEnd() then
		return false
	end

	local var_7_2 = var_1
	local var_7_3

	if not var_1.getConfig(var_7_2, "config_client")[2] then
		var_7_3 = -1
	end

	getProxy = var_7_2
	TaskProxy = var_4

	local var_7_4 = var_7_2(var_4)
	local var_7_6

	if not var_3.getTaskById(var_7_4, var_7_3) then
		getProxy = var_7_6
		TaskProxy = var_7_4

		local var_7_5 = var_7_6(var_7_4)

		var_7_6 = var_7_6.getFinishTaskById(var_7_5, var_7_3)
	end

	local var_7_7

	if var_7_6 and var_7_6:isFinish() then
		var_7_7 = not var_7_6:isReceive()
	end

	return var_7_7
end

function var_0_1.ShouldTipNewRace(arg_8_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1 = var_1.GetVoteGroupList(var_8_0)

	getProxy = var_8_0
	PlayerProxy = var_1_10003

	local var_8_2 = var_8_0(var_1_10003)
	local var_8_3 = var_2.getRawData(var_8_2).id

	ipairs = var_8_2

	for iter_8_0, iter_8_1 in var_8_2(var_8_1) do
		if iter_8_1 then
			local var_8_4 = iter_8_1

			if iter_8_1.IsOpening(var_8_4) then
				getProxy = var_8
				VoteProxy = var_8_4

				local var_8_5 = var_8(var_8_4)

				if var_8.IsNewRace(var_8_5, iter_8_1) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_1.ShouldTipVotes(arg_9_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)
	local var_9_1 = var_1.GetVoteGroupList(var_9_0)

	ipairs = var_9_0

	for iter_9_0, iter_9_1 in var_9_0(var_9_1) do
		getProxy = var_1_10007
		VoteProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)
		var_1_10007 = var_1_10007.GetVotesByConfigId(var_1_10008, iter_9_1.configId)

		if 0 < var_1_10007 then
			return true
		end
	end

	return false
end

function var_0_1.ShouldTipAward(arg_10_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)

	return var_1.ExistPastVoteAward(var_10_0)
end

return var_0_1
