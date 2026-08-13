class = var_0_10000

local var_0_0 = "VoteProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.VOTE_ORDER_BOOK_UPDATE = "VoteProxy:VOTE_ORDER_BOOK_UPDATE"
var_0_1.VOTE_ORDER_BOOK_DELETE = "VoteProxy:VOTE_ORDER_BOOK_DELETE"
var_0_1.VOTES_COUNT_UPDATE = "VoteProxy:VOTES_COUNT_UPDATE"

function var_0_1.register(arg_1_0)
	arg_1_0.voteGroupList = {}
	arg_1_0.tempVoteGroup = {}

	return
end

function var_0_1.AddTempVoteGroup(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1.list

	_ = var_1_10004

	local var_2_1 = var_1_10004.map(var_2_0, function(arg_3_0)
		local var_3_0 = arg_2_0

		return var_1.Data2VoteShip(var_3_0, arg_3_0, arg_2_2)
	end)
	local var_2_2 = arg_2_0.tempVoteGroup

	VoteGroup = var_6
	var_2_2[arg_2_2] = var_6.New({
		id = arg_2_2,
		list = var_2_1
	})

	return
end

function var_0_1.RawGetTempVoteGroup(arg_4_0, arg_4_1)
	return arg_4_0.tempVoteGroup[arg_4_1]
end

function var_0_1.RawGetVoteGroupByConfigId(arg_5_0, arg_5_1)
	return arg_5_0.voteGroupList[arg_5_1]
end

function var_0_1.GetVoteActivityByConfigId(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_6_0 = var_1_10002(var_1_10004)
	local var_6_1 = var_2.getActivitiesByType

	ActivityConst = var_1_10006

	local var_6_2 = var_6_1(var_6_0, var_1_10006.ACTIVITY_TYPE_VOTE)

	ipairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(var_6_2) do
		if iter_6_1:getDataConfig("is_in_game") == 1 and iter_6_1:getConfig("config_id") == arg_6_1 and not iter_6_1:isEnd() then
			return iter_6_1
		end
	end

	return nil
end

function var_0_1.GetVotesByConfigId(arg_7_0, arg_7_1)
	if arg_7_0:GetVoteActivityByConfigId(arg_7_1) and not var_2:isEnd() then
		return var_2.data1
	end

	return 0
end

function var_0_1.AddVoteGroup(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.list

	_ = var_1_10004

	local var_8_1 = var_1_10004.map(var_8_0, function(arg_9_0)
		local var_9_0 = arg_8_0

		return var_1.Data2VoteShip(var_9_0, arg_9_0, arg_8_2)
	end)
	local var_8_2 = arg_8_0.voteGroupList

	VoteGroup = var_6
	var_8_2[arg_8_2] = var_6.New({
		id = arg_8_2,
		list = var_8_1
	})

	return
end

function var_0_1.Data2VoteShip(arg_10_0, arg_10_1, arg_10_2)
	pg = var_1_10003

	if var_1_10003.activity_vote_virtual_ship_data[arg_10_1.key] then
		VirtualVoteShip = var_3

		return var_3.New(arg_10_1, arg_10_2)
	else
		ShipGroup = var_3

		if var_3.GetGroupConfig(arg_10_1.key) ~= nil then
			VoteShip = var_3

			return var_3.New(arg_10_1, arg_10_2)
		else
			assert = var_3

			var_3(false, arg_10_1.key)
		end
	end

	return
end

function var_0_1.AnyVoteActIsOpening(arg_11_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1 = var_1.getActivitiesByType

	ActivityConst = var_1_10005

	local var_11_2 = var_11_1(var_11_0, var_1_10005.ACTIVITY_TYPE_VOTE)

	ipairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(var_11_2) do
		if iter_11_1:getDataConfig("is_in_game") == 1 and not iter_11_1:isEnd() then
			return true
		end
	end

	return false
end

function var_0_1.GetVoteGroupList(arg_12_0)
	local var_12_0 = {}

	pairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.voteGroupList) do
		table = var_1_10007

		var_1_10007.insert(var_12_0, iter_12_1)
	end

	return var_12_0
end

function var_0_1.GetOpeningFunVoteGroup(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.voteGroupList) do
		if iter_13_1:IsFunRace() and iter_13_1:IsOpening() then
			return iter_13_1
		end
	end

	return nil
end

function var_0_1.GetOpeningNonFunVoteGroup(arg_14_0)
	pairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.voteGroupList) do
		if not iter_14_1:IsFunRace() and iter_14_1:IsOpening() then
			return iter_14_1
		end
	end

	return nil
end

function var_0_1.IsAllRaceEnd(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.TimeMgr.GetInstance()
	local var_15_1 = var_1.GetServerTime(var_15_0)

	_ = var_1_10002

	local var_15_2 = var_1_10002.all

	pg = var_1_10004

	return var_15_2(var_1_10004.activity_vote.all, function(arg_16_0)
		pg = var_2_10001

		local var_16_0 = var_2_10001.activity_vote[arg_16_0].time_vote

		if var_1.is_in_game == 1 then
			local var_16_1 = var_15_1

			pg = var_2_10004

			local var_16_2 = var_2_10004.TimeMgr.GetInstance()
			local var_16_3

			if not (var_16_1 >= var_4.parseTimeFromConfig(var_16_2, var_16_0[2])) then
				var_16_3 = false
			else
				var_16_3 = true
			end

			return var_16_3
		end
	end)
end

function var_0_1.GetPastVoteData(arg_17_0)
	if not arg_17_0.pastVoteData then
		pg = var_1
		arg_17_0.pastVoteData = var_1.vote_champion.get_id_list_by_group
	end

	return arg_17_0.pastVoteData
end

function var_0_1.ExistPastVoteAward(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.GetPastVoteData(var_18_0)

	getProxy = var_1_10002
	AttireProxy = var_1_10004

	local var_18_2 = var_1_10002(var_1_10004)

	pairs = var_18_0

	for iter_18_0, iter_18_1 in var_18_0(var_18_1) do
		_ = var_1_10008

		if var_1_10008.any(iter_18_1, function(arg_19_0)
			pg = var_2_10001

			local var_19_0 = var_2_10001.vote_champion[arg_19_0]

			getProxy = var_2_10002
			TaskProxy = var_2_10004

			local var_19_1 = var_2_10002(var_2_10004)
			local var_19_2 = var_2.getTaskById(var_19_1, var_19_0.task)

			pg = var_2_10003

			local var_19_3 = var_2_10003.task_data_template[var_19_0.task].award_display[1]
			local var_19_4 = var_18_2
			local var_19_5 = var_4.getAttireFrame

			AttireConst = var_2_10007

			local var_19_6 = var_19_5(var_19_4, var_2_10007.TYPE_ICON_FRAME, var_19_3[2])
			local var_19_7

			if var_19_2 and var_19_2:isFinish() then
				var_19_7 = not var_19_2:isReceive() and (var_19_6 == nil or not var_19_6:isOwned())
			end

			return var_19_7
		end) then
			return true
		end
	end

	return false
end

function var_0_1.IsNewRace(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return false
	end

	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_20_0 = var_1_10002(var_1_10004)
	local var_20_1 = var_2.getRawData(var_20_0).id

	PlayerPrefs = var_1_10003

	return var_1_10003.GetInt(arg_20_1.configId .. "_vote__tip_" .. var_20_1, 0) == 0
end

function var_0_1.MarkRaceNonNew(arg_21_0, arg_21_1)
	if arg_21_1 then
		var_1_10004 = arg_21_0

		if not arg_21_0.IsNewRace(var_1_10004, arg_21_1) then
			return
		end

		getProxy = var_1_10002
		PlayerProxy = var_1_10004

		local var_21_0 = var_1_10002(var_1_10004)
		local var_21_1 = var_2.getRawData(var_21_0).id

		PlayerPrefs = var_1_10003

		local var_21_2 = var_1_10003.SetInt(arg_21_1.configId .. "_vote__tip_" .. var_21_1, 1)

		PlayerPrefs = var_21_0

		var_21_0.Save()

		return
	end
end

return var_0_1
