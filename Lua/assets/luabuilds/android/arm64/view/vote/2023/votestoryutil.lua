local var_0_0 = class("VoteStoryUtil")

var_0_0.ENTER_SCENE = 1
var_0_0.ENTER_MAIN_STAGE = 2
var_0_0.ENTER_SUB_STAGE = 3
var_0_0.ENTER_SCHEDULE = 4
var_0_0.ENTER_HALL = 5
var_0_0.ENTER_EXCHANGE = 6
var_0_0.END = 7

function var_0_0.GetStoryNameByType(arg_1_0)
	local var_1_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	if not var_1_0 or var_1_0:isEnd() then
		return nil
	end

	return var_1_0:getConfig("config_client")[arg_1_0 + 2]
end

function var_0_0.FinalRaceIsEnd()
	for iter_2_0 = #pg.activity_vote.all, 1, -1 do
		local var_2_0 = pg.activity_vote[pg.activity_vote.all[iter_2_0]]

		if pg.activity_vote[pg.activity_vote.all[iter_2_0]].type == VoteConst.RACE_TYPE_FINAL then
			local var_2_1 = pg.TimeMgr.GetInstance()
			local var_2_2 = pg.TimeMgr.GetInstance()

			return var_2_1:GetServerTime() >= var_2_2:parseTimeFromConfig(var_2_0.time_vote[2])
		end
	end

	return true
end

function var_0_0.AllPreheatStoriesPlayed()
	if var_0_0.FinalRaceIsEnd() then
		return true
	end

	return _.all(_.map({
		var_0_0.ENTER_SCENE,
		var_0_0.ENTER_MAIN_STAGE,
		var_0_0.ENTER_SUB_STAGE,
		var_0_0.ENTER_SCHEDULE,
		var_0_0.ENTER_HALL,
		var_0_0.ENTER_EXCHANGE
	}, function(arg_4_0)
		return var_0_0.GetStoryNameByType(arg_4_0)
	end), function(arg_5_0)
		return pg.NewStoryMgr.GetInstance():IsPlayed(arg_5_0)
	end)
end

function var_0_0.Notify(arg_6_0)
	local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VOTE)

	if not var_6_0 or var_6_0:isEnd() then
		var_0_0.HandleEndStory()

		return
	end

	local var_6_1 = pg.activity_vote[var_6_0:getConfig("config_id")].type == VoteConst.RACE_TYPE_PRE
	local var_6_2 = {}
	local var_6_3 = {}

	if arg_6_0 == var_0_0.ENTER_SCENE then
		var_0_0.CollectEnterStory(var_6_1, var_6_2)
		var_0_0.CollectEnterGuide(var_6_1, {})
	elseif var_6_1 and arg_6_0 == var_0_0.ENTER_MAIN_STAGE then
		var_0_0.CollectEnterMainStory(var_6_2)
	elseif var_6_1 and arg_6_0 == var_0_0.ENTER_SUB_STAGE then
		var_0_0.CollectEnterSubStory(var_6_2)
	elseif var_6_1 and arg_6_0 == var_0_0.ENTER_SCHEDULE then
		var_0_0.CollectEnterScheduleStory(var_6_2)
	elseif var_6_1 and arg_6_0 == var_0_0.ENTER_HALL then
		var_0_0.CollectEnterHallStory(var_6_2)
	elseif var_6_1 and arg_6_0 == var_0_0.ENTER_EXCHANGE then
		var_0_0.CollectEnterExchangeStory(var_6_2)
	end

	seriesAsync({
		function(arg_7_0)
			var_0_0.Play(var_6_2, arg_7_0)

			return
		end,
		function(arg_8_0)
			var_0_0.HandleCurrActStory(var_6_0, arg_8_0)

			return
		end,
		function(arg_9_0)
			var_0_0.HandleGuide(var_6_3, arg_9_0)

			return
		end
	})

	return
end

function var_0_0.HandleGuide(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0) do
		table.insert({}, function(arg_11_0)
			pg.NewGuideMgr.GetInstance():Play(iter_10_1, nil, arg_11_0)

			return
		end)
	end

	seriesAsync({}, arg_10_1)

	return
end

function var_0_0.HandleCurrActStory(arg_12_0, arg_12_1)
	if var_0_0.AllPreheatStoriesPlayed() then
		var_0_0.Play({
			arg_12_0:getConfig("config_client")[1]
		}, arg_12_1)
	else
		arg_12_1()
	end

	return
end

function var_0_0.PreRaceIsEnd()
	local var_13_0

	for iter_13_0, iter_13_1 in ipairs(pg.activity_vote.all) do
		if pg.activity_vote[iter_13_1].type == VoteConst.RACE_TYPE_PRE then
			var_13_0 = iter_13_1

			break
		end
	end

	local var_13_1, var_13_2, var_13_3, var_13_4

	if not var_13_0 then
		do return false end

		var_13_1 = pg.TimeMgr.GetInstance():GetServerTime()
		var_13_2 = pg.TimeMgr.GetInstance()
		var_13_3 = var_13_2
		var_13_4 = var_13_2.parseTimeFromConfig
	end

	return var_13_1 >= var_13_4(var_13_3, pg.activity_vote[var_13_0].time_vote[2])
end

function var_0_0.HandleEndStory()
	if getProxy(VoteProxy):IsAllRaceEnd() then
		var_0_0.Play({
			(var_0_0.GetStoryNameByType(var_0_0.END))
		})
	elseif var_0_0.PreRaceIsEnd() then
		var_0_0.Play((_.map({
			var_0_0.ENTER_SCENE,
			var_0_0.ENTER_MAIN_STAGE,
			var_0_0.ENTER_SUB_STAGE,
			var_0_0.ENTER_SCHEDULE,
			var_0_0.ENTER_HALL,
			var_0_0.ENTER_EXCHANGE
		}, function(arg_15_0)
			return var_0_0.GetStoryNameByType(arg_15_0)
		end)))
	end

	return
end

function var_0_0.CollectEnterGuide(arg_16_0, arg_16_1)
	if arg_16_0 then
		if not pg.NewStoryMgr.GetInstance():IsPlayed((var_0_0.GetStoryNameByType(var_0_0.ENTER_SCENE))) then
			table.insert(arg_16_1, "NG0042")
		end
	end

	return
end

function var_0_0.CollectEnterStory(arg_17_0, arg_17_1)
	if arg_17_0 then
		table.insert(arg_17_1, (var_0_0.GetStoryNameByType(var_0_0.ENTER_SCENE)))
	else
		for iter_17_0, iter_17_1 in ipairs((_.map({
			var_0_0.ENTER_SCENE,
			var_0_0.ENTER_MAIN_STAGE,
			var_0_0.ENTER_SUB_STAGE,
			var_0_0.ENTER_SCHEDULE,
			var_0_0.ENTER_HALL,
			var_0_0.ENTER_EXCHANGE
		}, function(arg_18_0)
			return var_0_0.GetStoryNameByType(arg_18_0)
		end))) do
			table.insert(arg_17_1, iter_17_1)
		end

		for iter_17_2, iter_17_3 in ipairs((var_0_0.GetPrevRaceStories())) do
			table.insert(arg_17_1, iter_17_3)
		end
	end

	return
end

function var_0_0.GetPrevRaceStories()
	local var_19_0 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_19_0, iter_19_1 in ipairs(pg.activity_template.all) do
		if pg.activity_template[iter_19_1].type == ActivityConst.ACTIVITY_TYPE_VOTE then
			local var_19_1 = pg.TimeMgr.GetInstance()

			if var_19_0 > var_19_1:parseTimeFromConfig(pg.activity_template[iter_19_1].time[3]) then
				table.insert({}, pg.activity_template[iter_19_1].config_client[1])
			end
		end
	end

	return {}
end

function var_0_0.CollectEnterMainStory(arg_20_0)
	table.insert(arg_20_0, (var_0_0.GetStoryNameByType(var_0_0.ENTER_MAIN_STAGE)))

	return
end

function var_0_0.CollectEnterSubStory(arg_21_0)
	table.insert(arg_21_0, (var_0_0.GetStoryNameByType(var_0_0.ENTER_SUB_STAGE)))

	return
end

function var_0_0.CollectEnterScheduleStory(arg_22_0)
	table.insert(arg_22_0, (var_0_0.GetStoryNameByType(var_0_0.ENTER_SCHEDULE)))

	return
end

function var_0_0.CollectEnterHallStory(arg_23_0)
	table.insert(arg_23_0, (var_0_0.GetStoryNameByType(var_0_0.ENTER_HALL)))

	return
end

function var_0_0.CollectEnterExchangeStory(arg_24_0)
	table.insert(arg_24_0, (var_0_0.GetStoryNameByType(var_0_0.ENTER_EXCHANGE)))

	return
end

function var_0_0.Play(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs((_.select(arg_25_0, function(arg_26_0)
		return not pg.NewStoryMgr.GetInstance():IsPlayed(arg_26_0)
	end))) do
		table.insert({}, function(arg_27_0)
			pg.NewStoryMgr.GetInstance():Play(iter_25_1, arg_27_0)

			return
		end)
	end

	seriesAsync({}, arg_25_1)

	return
end

return var_0_0
