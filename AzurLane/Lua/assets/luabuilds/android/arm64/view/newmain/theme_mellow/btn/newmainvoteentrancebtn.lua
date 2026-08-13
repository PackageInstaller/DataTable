class = var_0_10000

local var_0_0 = var_0_10000("NewMainVoteEntranceBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0.event = arg_1_2

	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tf

	arg_2_0.tip = var_2.Find(var_2_0, "tip")
	setActive = var_2

	local var_2_1 = arg_2_0.tip
	local var_2_2 = arg_2_0

	var_2(var_2_1, arg_2_0.IsShowTip(var_2_2))

	onButton = var_2

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0._tf

	local function var_2_5()
		local var_3_0 = arg_2_0.event
		local var_3_1 = var_0.emit

		NewMainMediator = var_2_10003

		local var_3_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.VOTEENTRANCE)

		return
	end

	SFX_MAIN = var_2_2

	var_2(var_2_3, var_2_4, var_2_5, var_2_2)

	getProxy = var_2
	VoteProxy = var_2_3

	local var_2_6 = var_2(var_2_3)
	local var_2_7 = var_2.IsAllRaceEnd(var_2_6)
	local var_2_8 = arg_2_0:AnyVoteActIsOpening()

	setActive = var_2_6

	local var_2_9 = arg_2_0._tf

	var_2_6(var_6.Find(var_2_9, "unopen"), not var_2_7 and var_2_8)

	setActive = var_2_6

	local var_2_10 = arg_2_0._tf

	var_2_6(var_6.Find(var_2_10, "end"), var_2_7)

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_4.GetComponent

	typeof = var_7
	Image = var_9
	var_2_12(var_2_11, var_7(var_9)).enabled = not var_2_7 and not var_2_8

	return
end

function var_0_0.InShowTime(arg_4_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	return var_4_1(var_4_0, var_1_10004.VOTE_ENTRANCE_ACT_ID) and not var_1:isEnd()
end

function var_0_0.AnyVoteActIsOpening(arg_5_0)
	getProxy = var_1_10001
	VoteProxy = var_1_10003

	local var_5_0 = var_1_10001(var_1_10003)

	return var_1.AnyVoteActIsOpening(var_5_0)
end

function var_0_0.IsShowTip(arg_6_0)
	NewMainVoteEntranceBtn = var_1_10001

	local var_6_0

	if not var_1_10001.ShouldTipNewRace() then
		NewMainVoteEntranceBtn = var_6_0

		if not var_6_0.ShouldTipVotes() then
			NewMainVoteEntranceBtn = var_6_0

			if not var_6_0.ShouldTipAward() then
				NewMainVoteEntranceBtn = var_6_0
				var_6_0 = var_6_0.ShouldTipFinalAward()
			end
		end
	end

	return var_6_0
end

function var_0_0.ShouldTipFinalAward()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_7_0 = var_1_10000(var_1_10002)
	local var_7_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	if not var_7_1(var_7_0, var_1_10003.VOTE_ENTRANCE_ACT_ID) or var_0:isEnd() then
		return false
	end

	local var_7_2

	if not var_0:getConfig("config_client")[2] then
		var_7_2 = -1
	end

	getProxy = var_7_0
	TaskProxy = var_4

	local var_7_3 = var_7_0(var_4)
	local var_7_5

	if not var_2.getTaskById(var_7_3, var_7_2) then
		getProxy = var_7_5
		TaskProxy = var_7_3

		local var_7_4 = var_7_5(var_7_3)

		var_7_5 = var_7_5.getFinishTaskById(var_7_4, var_7_2)
	end

	local var_7_6

	if var_7_5 and var_7_5:isFinish() then
		var_7_6 = not var_7_5:isReceive()
	end

	return var_7_6
end

function var_0_0.ShouldTipNewRace()
	getProxy = var_1_10000
	VoteProxy = var_1_10002

	local var_8_0 = var_1_10000(var_1_10002)
	local var_8_1 = var_0.GetVoteGroupList(var_8_0)

	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_8_2 = var_1_10001(var_1_10003)
	local var_8_3 = var_1.getRawData(var_8_2).id

	ipairs = var_8_0

	for iter_8_0, iter_8_1 in var_8_0(var_8_1) do
		if iter_8_1 then
			local var_8_4 = iter_8_1

			if iter_8_1.IsOpening(var_8_4) then
				getProxy = var_7
				VoteProxy = var_8_4

				local var_8_5 = var_7(var_8_4)

				if var_7.IsNewRace(var_8_5, iter_8_1) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.ShouldTipVotes()
	getProxy = var_1_10000
	VoteProxy = var_1_10002

	local var_9_0 = var_1_10000(var_1_10002)
	local var_9_1 = var_0.GetVoteGroupList(var_9_0)

	ipairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(var_9_1) do
		getProxy = var_1_10006
		VoteProxy = var_1_10008
		var_1_10008 = var_1_10006(var_1_10008)

		if var_1_10006.GetVotesByConfigId(var_1_10008, iter_9_1.configId) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.ShouldTipAward()
	getProxy = var_1_10000
	VoteProxy = var_1_10002

	local var_10_0 = var_1_10000(var_1_10002)

	return var_0.ExistPastVoteAward(var_10_0)
end

function var_0_0.Hide(arg_11_0)
	if arg_11_0._tf then
		setActive = var_1

		var_1(arg_11_0._tf, false)
	end

	return
end

function var_0_0.IsShowTip()
	NewMainVoteEntranceBtn = var_1_10000

	local var_12_0

	if not var_1_10000.ShouldTipNewRace() then
		NewMainVoteEntranceBtn = var_12_0

		if not var_12_0.ShouldTipVotes() then
			NewMainVoteEntranceBtn = var_12_0

			if not var_12_0.ShouldTipAward() then
				NewMainVoteEntranceBtn = var_12_0
				var_12_0 = var_12_0.ShouldTipFinalAward()
			end
		end
	end

	return var_12_0
end

function var_0_0.Dispose(arg_13_0)
	return
end

return var_0_0
