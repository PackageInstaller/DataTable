local VoteStoryUtil = class("VoteStoryUtil")

VoteStoryUtil.ENTER_SCENE = 1
VoteStoryUtil.ENTER_MAIN_STAGE = 2
VoteStoryUtil.ENTER_SUB_STAGE = 3
VoteStoryUtil.ENTER_SCHEDULE = 4
VoteStoryUtil.ENTER_HALL = 5
VoteStoryUtil.ENTER_EXCHANGE = 6
VoteStoryUtil.END = 7

function VoteStoryUtil:GetStoryNameByType()
	local var_1_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	if not var_1_0 or var_1_0:isEnd() then
		return nil
	end

	return var_1_0:getConfig("config_client")[self + 2]
end

function VoteStoryUtil.FinalRaceIsEnd()
	for iter_2_0 = #pg.activity_vote.all, 1, -1 do
		if pg.activity_vote[pg.activity_vote.all[iter_2_0]].type == VoteConst.RACE_TYPE_FINAL then
			return pg.TimeMgr.GetInstance():GetServerTime() >= pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_vote[pg.activity_vote.all[iter_2_0]].time_vote[2])
		end
	end

	return true
end

function VoteStoryUtil.AllPreheatStoriesPlayed()
	if VoteStoryUtil.FinalRaceIsEnd() then
		return true
	end

	return _.all(_.map({
		VoteStoryUtil.ENTER_SCENE,
		VoteStoryUtil.ENTER_MAIN_STAGE,
		VoteStoryUtil.ENTER_SUB_STAGE,
		VoteStoryUtil.ENTER_SCHEDULE,
		VoteStoryUtil.ENTER_HALL,
		VoteStoryUtil.ENTER_EXCHANGE
	}, function(arg_4_0)
		return VoteStoryUtil.GetStoryNameByType(arg_4_0)
	end), function(arg_5_0)
		return pg.NewStoryMgr.GetInstance():IsPlayed(arg_5_0)
	end)
end

function VoteStoryUtil:Notify()
	local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VOTE)

	if not var_6_0 or var_6_0:isEnd() then
		VoteStoryUtil.HandleEndStory()

		return
	end

	local var_6_1 = pg.activity_vote[var_6_0:getConfig("config_id")].type == VoteConst.RACE_TYPE_PRE
	local var_6_2 = {}
	local var_6_3 = {}

	if self == VoteStoryUtil.ENTER_SCENE then
		VoteStoryUtil.CollectEnterStory(var_6_1, var_6_2)
		VoteStoryUtil.CollectEnterGuide(var_6_1, var_6_3)
	elseif var_6_1 and self == VoteStoryUtil.ENTER_MAIN_STAGE then
		VoteStoryUtil.CollectEnterMainStory(var_6_2)
	elseif var_6_1 and self == VoteStoryUtil.ENTER_SUB_STAGE then
		VoteStoryUtil.CollectEnterSubStory(var_6_2)
	elseif var_6_1 and self == VoteStoryUtil.ENTER_SCHEDULE then
		VoteStoryUtil.CollectEnterScheduleStory(var_6_2)
	elseif var_6_1 and self == VoteStoryUtil.ENTER_HALL then
		VoteStoryUtil.CollectEnterHallStory(var_6_2)
	elseif var_6_1 and self == VoteStoryUtil.ENTER_EXCHANGE then
		VoteStoryUtil.CollectEnterExchangeStory(var_6_2)
	end

	seriesAsync({
		function(arg_7_0)
			VoteStoryUtil.Play(var_6_2, arg_7_0)

			return
		end,
		function(arg_8_0)
			VoteStoryUtil.HandleCurrActStory(var_6_0, arg_8_0)

			return
		end,
		function(arg_9_0)
			VoteStoryUtil.HandleGuide(var_6_3, arg_9_0)

			return
		end
	})

	return
end

function VoteStoryUtil:HandleGuide(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self) do
		table.insert(var_10_0, function(arg_11_0)
			pg.NewGuideMgr.GetInstance():Play(iter_10_1, nil, arg_11_0)

			return
		end)
	end

	seriesAsync(var_10_0, arg_10_1)

	return
end

function VoteStoryUtil:HandleCurrActStory(arg_12_1)
	if VoteStoryUtil.AllPreheatStoriesPlayed() then
		VoteStoryUtil.Play({
			self:getConfig("config_client")[1]
		}, arg_12_1)
	else
		arg_12_1()
	end

	return
end

function VoteStoryUtil.PreRaceIsEnd()
	local var_13_0

	for iter_13_0, iter_13_1 in ipairs(pg.activity_vote.all) do
		if pg.activity_vote[iter_13_1].type == VoteConst.RACE_TYPE_PRE then
			var_13_0 = iter_13_1

			break
		end
	end

	local var_13_2
	local var_13_1

	if not var_13_0 then
		do return false end

		var_13_1 = pg.TimeMgr.GetInstance():GetServerTime()
		var_13_2 = pg.TimeMgr.GetInstance()
	end

	return var_13_1 >= var_13_2:parseTimeFromConfig(pg.activity_vote[var_13_0].time_vote[2])
end

function VoteStoryUtil.HandleEndStory()
	if getProxy(VoteProxy):IsAllRaceEnd() then
		VoteStoryUtil.Play({
			(VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.END))
		})
	elseif VoteStoryUtil.PreRaceIsEnd() then
		VoteStoryUtil.Play((_.map({
			VoteStoryUtil.ENTER_SCENE,
			VoteStoryUtil.ENTER_MAIN_STAGE,
			VoteStoryUtil.ENTER_SUB_STAGE,
			VoteStoryUtil.ENTER_SCHEDULE,
			VoteStoryUtil.ENTER_HALL,
			VoteStoryUtil.ENTER_EXCHANGE
		}, function(arg_15_0)
			return VoteStoryUtil.GetStoryNameByType(arg_15_0)
		end)))
	end

	return
end

function VoteStoryUtil:CollectEnterGuide(arg_16_1)
	if self then
		if not pg.NewStoryMgr.GetInstance():IsPlayed((VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_SCENE))) then
			table.insert(arg_16_1, "NG0042")
		end
	end

	return
end

function VoteStoryUtil:CollectEnterStory(arg_17_1)
	if self then
		table.insert(arg_17_1, (VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_SCENE)))
	else
		for iter_17_0, iter_17_1 in ipairs((_.map({
			VoteStoryUtil.ENTER_SCENE,
			VoteStoryUtil.ENTER_MAIN_STAGE,
			VoteStoryUtil.ENTER_SUB_STAGE,
			VoteStoryUtil.ENTER_SCHEDULE,
			VoteStoryUtil.ENTER_HALL,
			VoteStoryUtil.ENTER_EXCHANGE
		}, function(arg_18_0)
			return VoteStoryUtil.GetStoryNameByType(arg_18_0)
		end))) do
			table.insert(arg_17_1, iter_17_1)
		end

		for iter_17_2, iter_17_3 in ipairs((VoteStoryUtil.GetPrevRaceStories())) do
			table.insert(arg_17_1, iter_17_3)
		end
	end

	return
end

function VoteStoryUtil.GetPrevRaceStories()
	local var_19_0 = {}
	local var_19_1 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_19_0, iter_19_1 in ipairs(pg.activity_template.all) do
		if pg.activity_template[iter_19_1].type == ActivityConst.ACTIVITY_TYPE_VOTE then
			if var_19_1 > pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.activity_template[iter_19_1].time[3]) then
				table.insert(var_19_0, pg.activity_template[iter_19_1].config_client[1])
			end
		end
	end

	return var_19_0
end

function VoteStoryUtil:CollectEnterMainStory()
	table.insert(self, (VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_MAIN_STAGE)))

	return
end

function VoteStoryUtil:CollectEnterSubStory()
	table.insert(self, (VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_SUB_STAGE)))

	return
end

function VoteStoryUtil:CollectEnterScheduleStory()
	table.insert(self, (VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_SCHEDULE)))

	return
end

function VoteStoryUtil:CollectEnterHallStory()
	table.insert(self, (VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_HALL)))

	return
end

function VoteStoryUtil:CollectEnterExchangeStory()
	table.insert(self, (VoteStoryUtil.GetStoryNameByType(VoteStoryUtil.ENTER_EXCHANGE)))

	return
end

function VoteStoryUtil:Play(arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs((_.select(self, function(arg_26_0)
		return not pg.NewStoryMgr.GetInstance():IsPlayed(arg_26_0)
	end))) do
		table.insert(var_25_0, function(arg_27_0)
			pg.NewStoryMgr.GetInstance():Play(iter_25_1, arg_27_0)

			return
		end)
	end

	seriesAsync(var_25_0, arg_25_1)

	return
end

return VoteStoryUtil
