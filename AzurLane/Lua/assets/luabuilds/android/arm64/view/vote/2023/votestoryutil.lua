class = var_0_10000

local var_0_0 = var_0_10000("VoteStoryUtil")

var_0_0.ENTER_SCENE = 1
var_0_0.ENTER_MAIN_STAGE = 2
var_0_0.ENTER_SUB_STAGE = 3
var_0_0.ENTER_SCHEDULE = 4
var_0_0.ENTER_HALL = 5
var_0_0.ENTER_EXCHANGE = 6
var_0_0.END = 7

function var_0_0.GetStoryNameByType(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	if not var_1_1(var_1_0, var_1_10004.VOTE_ENTRANCE_ACT_ID) or var_1:isEnd() then
		return nil
	end

	return var_1:getConfig("config_client")[arg_1_0 + 2]
end

function var_0_0.FinalRaceIsEnd()
	pg = var_1_10000

	for iter_2_0 = #var_1_10000.activity_vote.all, 1, -1 do
		local var_2_0 = var_0[iter_2_0]

		pg = var_1_10006

		local var_2_1 = var_1_10006.activity_vote[var_2_0].type

		VoteConst = var_1_10008

		if var_2_1 == var_1_10008.RACE_TYPE_FINAL then
			pg = var_2_1

			local var_2_2 = var_2_1.TimeMgr.GetInstance()
			local var_2_3 = var_7.GetServerTime(var_2_2)

			pg = var_1_10008

			local var_2_4 = var_1_10008.TimeMgr.GetInstance()

			var_1_10008 = var_1_10008.parseTimeFromConfig(var_2_4, var_1_10006.time_vote[2]) <= var_2_3

			return var_1_10008
		end
	end

	return true
end

function var_0_0.AllPreheatStoriesPlayed()
	if var_0_0.FinalRaceIsEnd() then
		return true
	end

	local var_3_0 = {
		var_0_0.ENTER_SCENE,
		var_0_0.ENTER_MAIN_STAGE,
		var_0_0.ENTER_SUB_STAGE,
		var_0_0.ENTER_SCHEDULE,
		var_0_0.ENTER_HALL,
		var_0_0.ENTER_EXCHANGE
	}

	_ = var_1

	local var_3_1 = var_1.map(var_3_0, function(arg_4_0)
		return var_0_0.GetStoryNameByType(arg_4_0)
	end)

	_ = var_1_10002

	return var_1_10002.all(var_3_1, function(arg_5_0)
		pg = var_2_10001

		local var_5_0 = var_2_10001.NewStoryMgr.GetInstance()

		return var_1.IsPlayed(var_5_0, arg_5_0)
	end)
end

function var_0_0.Notify(arg_6_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	if not var_6_1(var_6_0, var_1_10004.ACTIVITY_TYPE_VOTE) or var_1:isEnd() then
		var_0_0.HandleEndStory()

		return
	end

	local var_6_2 = var_1:getConfig("config_id")

	pg = var_6_0

	local var_6_3 = var_6_0.activity_vote[var_6_2].type

	VoteConst = var_5

	local var_6_4 = var_6_3 == var_5.RACE_TYPE_PRE
	local var_6_5 = {}
	local var_6_6 = {}

	if arg_6_0 == var_0_0.ENTER_SCENE then
		var_0_0.CollectEnterStory(var_6_4, var_6_5)
		var_0_0.CollectEnterGuide(var_6_4, var_6_6)
	elseif var_6_4 and arg_6_0 == var_0_0.ENTER_MAIN_STAGE then
		var_0_0.CollectEnterMainStory(var_6_5)
	elseif var_6_4 and arg_6_0 == var_0_0.ENTER_SUB_STAGE then
		var_0_0.CollectEnterSubStory(var_6_5)
	elseif var_6_4 and arg_6_0 == var_0_0.ENTER_SCHEDULE then
		var_0_0.CollectEnterScheduleStory(var_6_5)
	elseif var_6_4 and arg_6_0 == var_0_0.ENTER_HALL then
		var_0_0.CollectEnterHallStory(var_6_5)
	elseif var_6_4 and arg_6_0 == var_0_0.ENTER_EXCHANGE then
		var_0_0.CollectEnterExchangeStory(var_6_5)
	end

	seriesAsync = var_7

	var_7({
		function(arg_7_0)
			var_0_0.Play(var_6_5, arg_7_0)

			return
		end,
		function(arg_8_0)
			var_0_0.HandleCurrActStory(var_0, arg_8_0)

			return
		end,
		function(arg_9_0)
			var_0_0.HandleGuide(var_6_6, arg_9_0)

			return
		end
	})

	return
end

function var_0_0.HandleGuide(arg_10_0, arg_10_1)
	local var_10_0 = {}

	ipairs = var_1_10003

	for iter_10_0, iter_10_1 in var_1_10003(arg_10_0) do
		table = var_1_10008

		var_1_10008.insert(var_10_0, function(arg_11_0)
			pg = var_2_10001

			local var_11_0 = var_2_10001.NewGuideMgr.GetInstance()

			var_1.Play(var_11_0, iter_10_1, nil, arg_11_0)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_10_0, arg_10_1)

	return
end

function var_0_0.HandleCurrActStory(arg_12_0, arg_12_1)
	if var_0_0.AllPreheatStoriesPlayed() then
		local var_12_0 = arg_12_0:getConfig("config_client")[1]

		var_0_0.Play({
			var_12_0
		}, arg_12_1)
	else
		arg_12_1()
	end

	return
end

function var_0_0.PreRaceIsEnd()
	local var_13_0

	ipairs = var_1_10001
	pg = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10001(var_1_10003.activity_vote.all) do
		pg = var_1_10006

		local var_13_1 = var_1_10006.activity_vote[iter_13_1].type

		VoteConst = var_1_10008

		if var_13_1 == var_1_10008.RACE_TYPE_PRE then
			var_13_0 = iter_13_1

			break
		end
	end

	if not var_13_0 then
		return false
	end

	pg = var_1

	local var_13_2 = var_1.activity_vote[var_13_0]

	pg = var_2

	local var_13_3 = var_2.TimeMgr.GetInstance()
	local var_13_4 = var_2.GetServerTime(var_13_3)

	pg = var_3

	local var_13_5 = var_3.TimeMgr.GetInstance()

	return var_13_4 >= var_3.parseTimeFromConfig(var_13_5, var_13_2.time_vote[2])
end

function var_0_0.HandleEndStory()
	getProxy = var_1_10000
	VoteProxy = var_1_10002

	local var_14_0 = var_1_10000(var_1_10002)

	if var_0.IsAllRaceEnd(var_14_0) then
		local var_14_1 = var_0_0.GetStoryNameByType(var_0_0.END)

		var_0_0.Play({
			var_14_1
		})
	elseif var_0_0.PreRaceIsEnd() then
		local var_14_2 = {
			var_0_0.ENTER_SCENE,
			var_0_0.ENTER_MAIN_STAGE,
			var_0_0.ENTER_SUB_STAGE,
			var_0_0.ENTER_SCHEDULE,
			var_0_0.ENTER_HALL,
			var_0_0.ENTER_EXCHANGE
		}

		_ = var_1

		local var_14_3 = var_1.map(var_14_2, function(arg_15_0)
			return var_0_0.GetStoryNameByType(arg_15_0)
		end)

		var_0_0.Play(var_14_3)
	end

	return
end

function var_0_0.CollectEnterGuide(arg_16_0, arg_16_1)
	if arg_16_0 then
		local var_16_0 = var_0_0.GetStoryNameByType(var_0_0.ENTER_SCENE)

		pg = var_1_10003

		local var_16_1 = var_1_10003.NewStoryMgr.GetInstance()

		if not var_3.IsPlayed(var_16_1, var_16_0) then
			table = var_3

			var_3.insert(arg_16_1, "NG0042")
		end
	end

	return
end

function var_0_0.CollectEnterStory(arg_17_0, arg_17_1)
	if arg_17_0 then
		local var_17_0 = var_0_0.GetStoryNameByType(var_0_0.ENTER_SCENE)

		table = var_1_10003

		var_1_10003.insert(arg_17_1, var_17_0)
	else
		local var_17_1 = {
			var_0_0.ENTER_SCENE,
			var_0_0.ENTER_MAIN_STAGE,
			var_0_0.ENTER_SUB_STAGE,
			var_0_0.ENTER_SCHEDULE,
			var_0_0.ENTER_HALL,
			var_0_0.ENTER_EXCHANGE
		}

		_ = var_3

		local var_17_2 = var_3.map(var_17_1, function(arg_18_0)
			return var_0_0.GetStoryNameByType(arg_18_0)
		end)

		ipairs = var_1_10004

		for iter_17_0, iter_17_1 in var_1_10004(var_17_2) do
			table = var_1_10009

			var_1_10009.insert(arg_17_1, iter_17_1)
		end

		local var_17_3 = var_0_0.GetPrevRaceStories()

		ipairs = var_5

		for iter_17_2, iter_17_3 in var_5(var_17_3) do
			table = var_1_10010

			var_1_10010.insert(arg_17_1, iter_17_3)
		end
	end

	return
end

function var_0_0.GetPrevRaceStories()
	local var_19_0 = {}

	pg = var_1_10001

	local var_19_1 = var_1_10001.TimeMgr.GetInstance()
	local var_19_2 = var_1.GetServerTime(var_19_1)

	ipairs = var_1_10002
	pg = var_1_10004

	for iter_19_0, iter_19_1 in var_1_10002(var_1_10004.activity_template.all) do
		pg = var_1_10007

		local var_19_3 = var_1_10007.activity_template[iter_19_1].type

		ActivityConst = var_1_10009

		if var_19_3 == var_1_10009.ACTIVITY_TYPE_VOTE then
			pg = var_19_3

			local var_19_4 = var_19_3.TimeMgr.GetInstance()

			if var_8.parseTimeFromConfig(var_19_4, var_1_10007.time[3]) < var_19_2 then
				table = var_8

				var_8.insert(var_19_0, var_1_10007.config_client[1])
			end
		end
	end

	return var_19_0
end

function var_0_0.CollectEnterMainStory(arg_20_0)
	local var_20_0 = var_0_0.GetStoryNameByType(var_0_0.ENTER_MAIN_STAGE)

	table = var_1_10002

	var_1_10002.insert(arg_20_0, var_20_0)

	return
end

function var_0_0.CollectEnterSubStory(arg_21_0)
	local var_21_0 = var_0_0.GetStoryNameByType(var_0_0.ENTER_SUB_STAGE)

	table = var_1_10002

	var_1_10002.insert(arg_21_0, var_21_0)

	return
end

function var_0_0.CollectEnterScheduleStory(arg_22_0)
	local var_22_0 = var_0_0.GetStoryNameByType(var_0_0.ENTER_SCHEDULE)

	table = var_1_10002

	var_1_10002.insert(arg_22_0, var_22_0)

	return
end

function var_0_0.CollectEnterHallStory(arg_23_0)
	local var_23_0 = var_0_0.GetStoryNameByType(var_0_0.ENTER_HALL)

	table = var_1_10002

	var_1_10002.insert(arg_23_0, var_23_0)

	return
end

function var_0_0.CollectEnterExchangeStory(arg_24_0)
	local var_24_0 = var_0_0.GetStoryNameByType(var_0_0.ENTER_EXCHANGE)

	table = var_1_10002

	var_1_10002.insert(arg_24_0, var_24_0)

	return
end

function var_0_0.Play(arg_25_0, arg_25_1)
	_ = var_1_10002

	local var_25_0 = var_1_10002.select(arg_25_0, function(arg_26_0)
		pg = var_2_10001

		local var_26_0 = var_2_10001.NewStoryMgr.GetInstance()

		return not var_1.IsPlayed(var_26_0, arg_26_0)
	end)
	local var_25_1 = {}

	ipairs = var_4

	for iter_25_0, iter_25_1 in var_4(var_25_0) do
		table = var_1_10009

		var_1_10009.insert(var_25_1, function(arg_27_0)
			pg = var_2_10001

			local var_27_0 = var_2_10001.NewStoryMgr.GetInstance()

			var_1.Play(var_27_0, iter_25_1, arg_27_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_25_1, arg_25_1)

	return
end

return var_0_0
