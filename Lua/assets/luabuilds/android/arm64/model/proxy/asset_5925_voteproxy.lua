local VoteProxy = class("VoteProxy", import(".NetProxy"))

VoteProxy.VOTE_ORDER_BOOK_UPDATE = "VoteProxy:VOTE_ORDER_BOOK_UPDATE"
VoteProxy.VOTE_ORDER_BOOK_DELETE = "VoteProxy:VOTE_ORDER_BOOK_DELETE"
VoteProxy.VOTES_COUNT_UPDATE = "VoteProxy:VOTES_COUNT_UPDATE"

function VoteProxy:register()
	self.voteGroupList = {}
	self.tempVoteGroup = {}

	return
end

function VoteProxy:AddTempVoteGroup(arg_2_1, arg_2_2)
	self.tempVoteGroup[arg_2_2] = VoteGroup.New({
		id = arg_2_2,
		list = _.map(arg_2_1.list, function(arg_3_0)
			return self:Data2VoteShip(arg_3_0, arg_2_2)
		end)
	})

	return
end

function VoteProxy:RawGetTempVoteGroup(arg_4_1)
	return self.tempVoteGroup[arg_4_1]
end

function VoteProxy:RawGetVoteGroupByConfigId(arg_5_1)
	return self.voteGroupList[arg_5_1]
end

function VoteProxy:GetVoteActivityByConfigId(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE))) do
		if iter_6_1:getDataConfig("is_in_game") == 1 and iter_6_1:getConfig("config_id") == arg_6_1 and not iter_6_1:isEnd() then
			return iter_6_1
		end
	end

	return nil
end

function VoteProxy:GetVotesByConfigId(arg_7_1)
	local var_7_0 = self:GetVoteActivityByConfigId(arg_7_1)

	if var_7_0 and not var_7_0:isEnd() then
		return var_7_0.data1
	end

	return 0
end

function VoteProxy:AddVoteGroup(arg_8_1, arg_8_2)
	self.voteGroupList[arg_8_2] = VoteGroup.New({
		id = arg_8_2,
		list = _.map(arg_8_1.list, function(arg_9_0)
			return self:Data2VoteShip(arg_9_0, arg_8_2)
		end)
	})

	return
end

function VoteProxy:Data2VoteShip(arg_10_1, arg_10_2)
	if pg.activity_vote_virtual_ship_data[arg_10_1.key] then
		return VirtualVoteShip.New(arg_10_1, arg_10_2)
	elseif ShipGroup.GetGroupConfig(arg_10_1.key) ~= nil then
		return VoteShip.New(arg_10_1, arg_10_2)
	else
		assert(false, arg_10_1.key)
	end

	return
end

function VoteProxy:AnyVoteActIsOpening()
	for iter_11_0, iter_11_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE))) do
		if iter_11_1:getDataConfig("is_in_game") == 1 and not iter_11_1:isEnd() then
			return true
		end
	end

	return false
end

function VoteProxy:GetVoteGroupList()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.voteGroupList) do
		table.insert(var_12_0, iter_12_1)
	end

	return var_12_0
end

function VoteProxy:GetOpeningFunVoteGroup()
	for iter_13_0, iter_13_1 in pairs(self.voteGroupList) do
		if iter_13_1:IsFunRace() and iter_13_1:IsOpening() then
			return iter_13_1
		end
	end

	return nil
end

function VoteProxy:GetOpeningNonFunVoteGroup()
	for iter_14_0, iter_14_1 in pairs(self.voteGroupList) do
		if not iter_14_1:IsFunRace() and iter_14_1:IsOpening() then
			return iter_14_1
		end
	end

	return nil
end

function VoteProxy:IsAllRaceEnd()
	local var_15_0 = pg.TimeMgr.GetInstance():GetServerTime()

	return _.all(pg.activity_vote.all, function(arg_16_0)
		local var_16_0

		if pg.activity_vote[arg_16_0].is_in_game == 1 then
			if var_15_0 < pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_vote[arg_16_0].time_vote[2]) then
				var_16_0 = false

				goto label_16_0
			end
		end

		::label_16_0::

		return true
	end)
end

function VoteProxy:GetPastVoteData()
	self.pastVoteData = self.pastVoteData or pg.vote_champion.get_id_list_by_group

	return self.pastVoteData
end

function VoteProxy:ExistPastVoteAward()
	local var_18_0 = getProxy(AttireProxy)

	for iter_18_0, iter_18_1 in pairs((self:GetPastVoteData())) do
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

function VoteProxy:IsNewRace(arg_20_1)
	if not arg_20_1 then
		return false
	end

	return PlayerPrefs.GetInt(arg_20_1.configId .. "_vote__tip_" .. getProxy(PlayerProxy):getRawData().id, 0) == 0
end

function VoteProxy:MarkRaceNonNew(arg_21_1)
	if not arg_21_1 or not self:IsNewRace(arg_21_1) then
		return
	end

	local var_21_0 = PlayerPrefs.SetInt(arg_21_1.configId .. "_vote__tip_" .. getProxy(PlayerProxy):getRawData().id, 1)

	PlayerPrefs.Save()

	return
end

return VoteProxy
