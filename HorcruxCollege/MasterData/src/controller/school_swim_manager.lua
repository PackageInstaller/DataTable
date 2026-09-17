local var_0_0 = {}
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local swim_contestants_data = require("data.summer.swim_contestants_data")
local swim_team_buff_data = require("data.summer.swim_team_buff_data")
local swim_other_param_data = require("data.summer.swim_other_param_data")
local swim_schedule_data = require("data.summer.swim_schedule_data")
local swim_reward_data = require("data.summer.swim_reward_data")
local swim_track_random_data = require("data.summer.swim_track_random_data")
local swim_track_data = require("data.summer.swim_track_data")
local swim_round_data = require("data.summer.swim_round_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local L2Swimmer = require("view.Sprite.L2Swimmer")
local network = require("network.network")
local var_0_18 = 1
local var_0_19 = 2

function var_0_0.get_swim_info(arg_1_0)
	network:rpc("get_swim_info", {}, function(arg_2_0)
		arg_1_0.teamList = arg_2_0.teams
		arg_1_0.curSwimId = arg_2_0.match or -1

		activity_manager:fireEvent(activity_manager.activityEventId.SWIM_TEAM_INFO_UPDATE)
	end)
end

function var_0_0.check_swim_vote_reward(arg_3_0)
	network:rpc("check_swim_vote_reward", {}, function(arg_4_0)
		local var_4_0

		if arg_4_0.rewards and next(arg_4_0.rewards) then
			for iter_4_0, iter_4_1 in pairs(arg_4_0.rewards) do
				if iter_4_1.type == var_0_18 then
					arg_3_0.dialyRewards = iter_4_1.num
					var_4_0 = arg_3_0.dialyRewards
				elseif iter_4_1.type == var_0_19 then
					arg_3_0.weekRewards = iter_4_1.num
				end
			end
		end

		var_4_0 = var_4_0 or arg_3_0.curSwimId

		if arg_3_0.weekRewards then
			activity_manager:fireEvent(activity_manager.activityEventId.SWIM_COMPETITION_STATE_UPDATE, {
				showType = "week",
				id = var_4_0
			})

			return
		end

		if arg_3_0:isCanAutoPop() or arg_3_0.dialyRewards then
			activity_manager:fireEvent(activity_manager.activityEventId.SWIM_COMPETITION_STATE_UPDATE, {
				showType = "daily",
				id = var_4_0
			})
		end
	end)
end

function var_0_0.get_swim_daily_vote_info(arg_5_0)
	network:rpc("get_swim_vote_info", {
		type = 1
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			arg_5_0.rates = arg_6_0.rates
			arg_5_0.dailyRankList = arg_6_0.ranklist
		else
			arg_5_0.rates = nil
			arg_5_0.dailyRankList = nil
		end

		activity_manager:fireEvent(activity_manager.activityEventId.SWIM_DAILY_VOTE_UPDATE)
	end)
end

function var_0_0.get_swim_week_vote_info(arg_7_0)
	network:rpc("get_swim_vote_info", {
		type = 2
	}, function(arg_8_0)
		arg_7_0.weekRankList = arg_8_0.ranklist

		activity_manager:fireEvent(activity_manager.activityEventId.SWIM_WEEK_VOTE_UPDATE, arg_8_0)
	end)
end

function var_0_0:get_specific_swim_match(arg_9_1)
	self.voteData = self.voteData or {}
	self.trackData = self.trackData or {}

	network:rpc("get_specific_swim_match", {
		match = arg_9_1 or self.curSwimId
	}, function(arg_10_0)
		local var_10_0 = arg_9_1 or self.curSwimId

		self.needShowSwimData = arg_10_0

		if arg_10_0.ranklist then
			self.voteData[var_10_0] = arg_10_0.ranklist[1] or nil
		end

		self.trackData[var_10_0] = arg_10_0.trackid

		activity_manager:fireEvent(activity_manager.activityEventId.SWIM_COMPETITION_LIST_UPDATE)
	end)
end

function var_0_0:get_swim_vote_reward(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1 == 2 then
		arg_11_2 = self.weekRewards
	end

	if arg_11_1 == 1 then
		arg_11_2 = arg_11_2 or self.dialyRewards
	end

	network:rpc("get_swim_vote_reward", {
		type = arg_11_1,
		num = arg_11_2
	}, function(arg_12_0)
		local var_12_0, var_12_1, var_12_2, var_12_3, var_12_4 = global_get(arg_12_0)

		if arg_11_1 == 2 then
			self.weekRewards = nil
		end

		if arg_11_1 == 1 then
			self.dialyRewards = nil
		end

		if arg_11_3 then
			arg_11_3({
				items = var_12_4,
				reward = arg_12_0.reward
			})
		end
	end)
end

function var_0_0:swim_vote_daily(arg_13_1)
	network:rpc("swim_vote", {
		type = 1,
		num = self.curSwimId + 1,
		ranklist = {
			arg_13_1
		}
	}, function(arg_14_0)
		if arg_14_0.result == 1 then
			global_ShowBlockWords(L_SWIM_VOTE_SUCC)
			self:get_swim_daily_vote_info()
		end
	end)
end

function var_0_0.swim_vote_week(arg_15_0, arg_15_1, arg_15_2)
	network:rpc("swim_vote", {
		type = 2,
		num = arg_15_2,
		ranklist = arg_15_1
	}, function(arg_16_0)
		if arg_16_0.result == 1 then
			global_ShowBlockWords(L_SWIM_VOTE_SUCC)
			arg_15_0:get_swim_week_vote_info()
		end
	end)
end

function var_0_0.get_swim_record(arg_17_0)
	network:rpc("get_swim_record", {}, function(arg_18_0)
		activity_manager:fireEvent(activity_manager.activityEventId.SWIM_RECORD_LIST_UPDATE, {
			voteList = arg_18_0.data
		})
	end)
end

function var_0_0:get_swim_round_rank(arg_19_1, arg_19_2)
	network:rpc("get_swim_round_rank", {
		round = self.weekRewards
	}, function(arg_20_0)
		if arg_19_2 then
			arg_19_2(arg_20_0.ranklist)
		end
	end)
end

function var_0_0:getTeamList()
	if not self.teamList or not next(self.teamList) then
		return
	end

	for iter_21_0, iter_21_1 in pairs(self.teamList) do
		self.teamList[iter_21_0].name = swim_contestants_data[iter_21_1.id].name
		self.teamList[iter_21_0].captain = swim_contestants_data[iter_21_1.id].captain
		self.teamList[iter_21_0].buffDes = swim_team_buff_data[iter_21_1.buff].description
		self.teamList[iter_21_0].buffName = swim_team_buff_data[iter_21_1.buff].name
	end

	table.sort(self.teamList, function(arg_22_0, arg_22_1)
		return arg_22_0.score > arg_22_1.score
	end)

	return self.teamList
end

function var_0_0:getTeamListSortById()
	if not self.teamList or not next(self.teamList) then
		return
	end

	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.teamList) do
		var_23_0[iter_23_0] = {}
		var_23_0[iter_23_0].name = swim_contestants_data[iter_23_1.id].name
		var_23_0[iter_23_0].captain = swim_contestants_data[iter_23_1.id].captain
		var_23_0[iter_23_0].buffDes = swim_team_buff_data[iter_23_1.buff].description
		var_23_0[iter_23_0].buffName = swim_team_buff_data[iter_23_1.buff].name
		var_23_0[iter_23_0].id = iter_23_1.id
		var_23_0[iter_23_0].score = iter_23_1.score
		var_23_0[iter_23_0].rank = iter_23_1.rank
		var_23_0[iter_23_0].buff = iter_23_1.buff
		var_23_0[iter_23_0].ranklist = iter_23_1.ranklist
	end

	table.sort(var_23_0, function(arg_24_0, arg_24_1)
		return arg_24_0.id < arg_24_1.id
	end)

	return var_23_0
end

function var_0_0.getModelByTeamId(arg_25_0, arg_25_1)
	local var_25_0 = {}

	while swim_contestants_data[arg_25_1]["model_" .. 1] do
		table.insert(var_25_0, swim_contestants_data[arg_25_1]["model_" .. 1])
	end

	return var_25_0
end

function var_0_0.getVoteModelDrop(arg_26_0)
	local var_26_0 = drop_manager:getAllDrops(swim_other_param_data.vote_daily_reward.value)

	if drop_manager:getGold(swim_other_param_data.vote_daily_reward.value) > 0 then
		table.insert(var_26_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(swim_other_param_data.vote_daily_reward.value)
		})
	end

	if drop_manager:getDiamond(swim_other_param_data.vote_daily_reward.value) > 0 then
		table.insert(var_26_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(swim_other_param_data.vote_daily_reward.value)
		})
	end

	return var_26_0
end

function var_0_0.getVoteWeekDrop(arg_27_0)
	local var_27_0 = drop_manager:getAllDrops(swim_other_param_data.vote_week_reward.value)

	if drop_manager:getGold(swim_other_param_data.vote_week_reward.value) > 0 then
		table.insert(var_27_0, {
			dropid = "gold",
			dropNum = drop_manager:getGold(swim_other_param_data.vote_week_reward.value)
		})
	end

	if drop_manager:getDiamond(swim_other_param_data.vote_week_reward.value) > 0 then
		table.insert(var_27_0, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(swim_other_param_data.vote_week_reward.value)
		})
	end

	return var_27_0
end

function var_0_0.getLastSwimId(arg_28_0)
	local var_28_0 = time_check_manager:getCurTime()
	local var_28_1 = global_get_time_by_date(swim_other_param_data.swim_start_time.value)

	for iter_28_0, iter_28_1 in ipairs(swim_schedule_data) do
		local var_28_2 = string.split(iter_28_1.settle_time, ":")

		if var_28_0 < var_28_1 + (iter_28_1.day - 1) * 86400 + var_28_2[1] * 3600 + var_28_2[2] * 60 + var_28_2[3] then
			return iter_28_0 - 1
		end
	end
end

function var_0_0:getshowSwimData()
	local var_29_0 = {
		teams = {}
	}

	for iter_29_0, iter_29_1 in pairs(self.needShowSwimData.teams) do
		table.insert(var_29_0.teams, {
			id = iter_29_1.id,
			buff = iter_29_1.buff,
			player = iter_29_1.player,
			rank = iter_29_0
		})
	end

	table.sort(var_29_0.teams, function(arg_30_0, arg_30_1)
		return arg_30_0.id < arg_30_1.id
	end)

	return var_29_0
end

function var_0_0.getShowSwimDes(arg_31_0, arg_31_1)
	local var_31_0 = string.split(string.split(swim_other_param_data.swim_start_time.value, " ")[1], "-")

	var_31_0[3] = var_31_0[3] + swim_schedule_data[arg_31_1].day - 1

	if var_31_0[3] > 31 then
		var_31_0[3] = var_31_0[3] - 31
		var_31_0[2] = var_31_0[2] + 1
	end

	return string.format(L_SWIM_REWARD_TITLE, var_31_0[1] .. ":" .. var_31_0[2] .. ":" .. var_31_0[3], L_SWIM_SCHEDULE[swim_schedule_data[arg_31_1].session_distinguish])
end

function var_0_0:getSwimVoteDropList()
	if not self.dialyRewards then
		return
	end

	if not self.needShowSwimData.ranklist then
		return
	end

	local var_32_0

	for iter_32_0, iter_32_1 in pairs(self.needShowSwimData.teams) do
		if self.needShowSwimData.ranklist[1] == iter_32_1.id then
			var_32_0 = swim_reward_data[iter_32_1.rank].drop_normal

			break
		end
	end

	local var_32_1 = drop_manager:getAllDrops(var_32_0)

	if drop_manager:getGold(var_32_0) > 0 then
		table.insert(var_32_1, {
			dropid = "gold",
			dropNum = drop_manager:getGold(var_32_0)
		})
	end

	if drop_manager:getDiamond(var_32_0) > 0 then
		table.insert(var_32_1, {
			dropid = "diamond",
			dropNum = drop_manager:getDiamond(var_32_0)
		})
	end

	return var_32_1
end

function var_0_0:isHasDailyReward()
	return self.dialyRewards ~= nil
end

function var_0_0:isHasWeekReward()
	return self.weekRewards ~= nil
end

function var_0_0:isCanAutoPop()
	if RoleDefault:getInstance():getIntegerForKey("swimAutoPop", 0) >= self.curSwimId then
		return false
	end

	RoleDefault:getInstance():setIntegerForKey("swimAutoPop", self.curSwimId)

	return true
end

function var_0_0:getVoteList()
	if not swim_schedule_data[self.curSwimId + 1] then
		return
	end

	local var_36_0 = {}

	while swim_schedule_data[self.curSwimId + 1]["team_player_" .. 1] do
		local var_36_2 = not not (self.dailyRankList and 1 == self.dailyRankList[1])

		table.insert(var_36_0, {
			model = swim_schedule_data[self.curSwimId + 1]["team_player_" .. 1],
			rates = (self.rates or nil) and self.rates[1],
			modelName = model_data[swim_schedule_data[self.curSwimId + 1]["team_player_" .. 1]].main_name,
			vote = var_36_2
		})
	end

	return var_36_0
end

function var_0_0:isTimeToVoteDaily()
	local var_37_0 = time_check_manager:getCurTime()
	local var_37_1 = self.curSwimId or self:getLastSwimId()

	if not var_37_1 then
		return false
	end

	local var_37_2 = swim_schedule_data[var_37_1 + 1]

	if not swim_schedule_data[var_37_1 + 1] then
		return false
	end

	local var_37_3 = global_get_time_by_date(swim_other_param_data.swim_start_time.value)
	local var_37_4 = string.split(var_37_2.vote_start_time, ":")
	local var_37_5 = var_37_3 + (var_37_2.day - 1) * 86400 + var_37_4[1] * 3600 + var_37_4[2] * 60 + var_37_4[3]
	local var_37_6 = string.split(var_37_2.vote_finish_time, ":")

	return var_37_0 < var_37_3 + (var_37_2.day - 1) * 86400 + var_37_6[1] * 3600 + var_37_6[2] * 60 + var_37_6[3] and var_37_5 < var_37_0
end

function var_0_0:getNextVoteTime()
	local var_38_0

	if not swim_schedule_data[self.curSwimId + 1] then
		do return 0 end

		var_38_0 = string.split(swim_schedule_data[self.curSwimId + 1].vote_start_time, ":")
	end

	return math.abs(time_check_manager:getCurTime() - (global_get_time_by_date(swim_other_param_data.swim_start_time.value) + (swim_schedule_data[self.curSwimId + 1].day - 1) * 86400 + var_38_0[1] * 3600 + var_38_0[2] * 60 + var_38_0[3]))
end

function var_0_0:getVoteEndTime()
	local var_39_0

	if not swim_schedule_data[self.curSwimId] then
		do return 0 end

		var_39_0 = string.split(swim_schedule_data[self.curSwimId].vote_finish_time, ":")
	end

	return math.abs(global_get_time_by_date(swim_other_param_data.swim_start_time.value) + (swim_schedule_data[self.curSwimId].day - 1) * 86400 + var_39_0[1] * 3600 + var_39_0[2] * 60 + var_39_0[3] - time_check_manager:getCurTime())
end

function var_0_0:getNextSwimStartTime()
	local var_40_1 = (self.curSwimId or self:getLastSwimId()) + 1
	local var_40_2

	if not swim_schedule_data[self.curSwimId + 1] then
		do return end

		var_40_2 = string.split(swim_schedule_data[self.curSwimId + 1].settle_time, ":")
	end

	return math.abs(global_get_time_by_date(swim_other_param_data.swim_start_time.value) + (swim_schedule_data[self.curSwimId + 1].day - 1) * 86400 + var_40_2[1] * 3600 + var_40_2[2] * 60 + var_40_2[3] - time_check_manager:getCurTime())
end

function var_0_0.canWeekVote(arg_41_0)
	local var_41_0 = time_check_manager:getCurTime()

	for iter_41_0, iter_41_1 in pairs(swim_round_data) do
		if var_41_0 > global_get_time_by_date(iter_41_1.vote_start_time) and var_41_0 < global_get_time_by_date(iter_41_1.vote_finish_time) then
			return true
		end
	end

	return false
end

local function var_0_20(arg_42_0, arg_42_1)
	for iter_42_0 = 1, 4 do
		if swim_track_data[arg_42_0["track_" .. iter_42_0]].rank == arg_42_1 then
			return swim_track_data[arg_42_0["track_" .. iter_42_0]]
		end
	end
end

function var_0_0:getSwimDataById()
	local var_44_0 = swim_track_random_data[self.needShowSwimData.trackid]
	local var_44_1 = {
		record = {}
	}

	print(dump(self.needShowSwimData.teams))

	if self.needShowSwimData.ranklist then
		var_44_1.vote = self.needShowSwimData.ranklist[1] or nil
	end

	for iter_44_0, iter_44_1 in pairs(self.needShowSwimData.teams) do
		table.insert(var_44_1.record, {
			id = iter_44_1.id,
			model = iter_44_1.player,
			proceed = var_0_20(var_44_0, iter_44_0)
		})
	end

	table.sort(var_44_1.record, function(arg_45_0, arg_45_1)
		return arg_45_0.id < arg_45_1.id
	end)

	return var_44_1
end

function var_0_0.craeteCompetitionSwimer(arg_46_0, arg_46_1)
	local var_46_1 = L2Swimmer:create(ROLE_SPINE_PATH .. model_data[arg_46_1].spine_model .. ".json", ROLE_SPINE_PATH .. model_data[arg_46_1].spine_model .. ".atlas", (model_data[arg_46_1].clothes_model or nil) and (CLOTHES_SPINE_PATH .. model_data[arg_46_1].clothes_model .. ".atlas" or nil))

	var_46_1:setName("swimmer")
	var_46_1:setModel(arg_46_1)
	var_46_1:setScale(0.3, 0.3)
	var_46_1:setPosition(cc.p(105, 80))
	var_46_1:initNodeEvent()

	return var_46_1
end

function var_0_0:canVote()
	if (not self.dailyRankList or not self.dailyRankList[1]) and self:isTimeToVoteDaily() then
		return true
	end

	if (not self.weekRankList or #self.weekRankList <= 0) and self:canWeekVote() then
		return true
	end

	return false
end

return var_0_0
