local var_0_0 = class("VoteProxy", import(".NetProxy"))

var_0_0.VOTE_ORDER_BOOK_UPDATE = "VoteProxy:VOTE_ORDER_BOOK_UPDATE"
var_0_0.VOTE_ORDER_BOOK_DELETE = "VoteProxy:VOTE_ORDER_BOOK_DELETE"
var_0_0.VOTES_COUNT_UPDATE = "VoteProxy:VOTES_COUNT_UPDATE"

function var_0_0.register(arg_1_0)
	arg_1_0.voteGroupList = {}
	arg_1_0.tempVoteGroup = {}

	return
end

function var_0_0.AddTempVoteGroup(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.tempVoteGroup[arg_2_2] = VoteGroup.New({
		id = arg_2_2,
		list = _.map(arg_2_1.list, function(arg_3_0)
			return arg_2_0:Data2VoteShip(arg_3_0, arg_2_2)
		end)
	})

	return
end

function var_0_0.RawGetTempVoteGroup(arg_4_0, arg_4_1)
	return arg_4_0.tempVoteGroup[arg_4_1]
end

function var_0_0.RawGetVoteGroupByConfigId(arg_5_0, arg_5_1)
	return arg_5_0.voteGroupList[arg_5_1]
end

function var_0_0.GetVoteActivityByConfigId(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE))) do
		if iter_6_1:getDataConfig("is_in_game") == 1 and iter_6_1:getConfig("config_id") == arg_6_1 and not iter_6_1:isEnd() then
			return iter_6_1
		end
	end

	return nil
end

function var_0_0.GetVotesByConfigId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetVoteActivityByConfigId(arg_7_1)

	if var_7_0 and not var_7_0:isEnd() then
		return var_7_0.data1
	end

	return 0
end

function var_0_0.AddVoteGroup(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.voteGroupList[arg_8_2] = VoteGroup.New({
		id = arg_8_2,
		list = _.map(arg_8_1.list, function(arg_9_0)
			return arg_8_0:Data2VoteShip(arg_9_0, arg_8_2)
		end)
	})

	return
end

function var_0_0.Data2VoteShip(arg_10_0, arg_10_1, arg_10_2)
	if pg.activity_vote_virtual_ship_data[arg_10_1.key] then
		return VirtualVoteShip.New(arg_10_1, arg_10_2)
	elseif ShipGroup.GetGroupConfig(arg_10_1.key) ~= nil then
		return VoteShip.New(arg_10_1, arg_10_2)
	else
		assert(false, arg_10_1.key)
	end

	return
end

function var_0_0.AnyVoteActIsOpening(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE))) do
		if iter_11_1:getDataConfig("is_in_game") == 1 and not iter_11_1:isEnd() then
			return true
		end
	end

	return false
end

function var_0_0.GetVoteGroupList(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.voteGroupList) do
		table.insert({}, iter_12_1)
	end

	return {}
end

function var_0_0.GetOpeningFunVoteGroup(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.voteGroupList) do
		if iter_13_1:IsFunRace() and iter_13_1:IsOpening() then
			return iter_13_1
		end
	end

	return nil
end

function var_0_0.GetOpeningNonFunVoteGroup(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.voteGroupList) do
		if not iter_14_1:IsFunRace() and iter_14_1:IsOpening() then
			return iter_14_1
		end
	end

	return nil
end

function var_0_0.IsAllRaceEnd(arg_15_0)
	local var_15_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return _.all(pg.activity_vote.all, function(arg_16_0)
		if pg.activity_vote[arg_16_0].is_in_game == 1 then
			local var_16_0 = var_15_0 >= pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_vote[arg_16_0].time_vote[2])

			return var_16_0
		end
	end)
end

function var_0_0.GetPastVoteData(arg_17_0)
	arg_17_0.pastVoteData = arg_17_0.pastVoteData or pg.vote_champion.get_id_list_by_group

	return arg_17_0.pastVoteData
end

function var_0_0.ExistPastVoteAward(arg_18_0)
	local var_18_0 = getProxy(AttireProxy)

	for iter_18_0, iter_18_1 in pairs((arg_18_0:GetPastVoteData())) do
		if _.any(iter_18_1, function(arg_19_0)
			local var_19_0 = getProxy(TaskProxy):getTaskById(pg.vote_champion[arg_19_0].task)
			local var_19_1 = var_18_0:getAttireFrame(AttireConst.TYPE_ICON_FRAME, pg.task_data_template[pg.vote_champion[arg_19_0].task].award_display[1][2])

			return var_19_0 and var_19_0:isFinish() and not var_19_0:isReceive() and (var_19_1 == nil or not var_19_1:isOwned())
		end) then
			return true
		end
	end

	return false
end

function var_0_0.IsNewRace(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return false
	end

	local var_20_0 = getProxy(PlayerProxy)

	return PlayerPrefs.GetInt(arg_20_1.configId .. "_vote__tip_" .. var_20_0:getRawData().id, 0) == 0
end

function var_0_0.MarkRaceNonNew(arg_21_0, arg_21_1)
	if not arg_21_1 or not arg_21_0:IsNewRace(arg_21_1) then
		return
	end

	local var_21_0 = getProxy(PlayerProxy)
	local var_21_1 = PlayerPrefs.SetInt(arg_21_1.configId .. "_vote__tip_" .. var_21_0:getRawData().id, 1)

	PlayerPrefs.Save()

	return
end

return var_0_0
