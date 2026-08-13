class = var_0_10000

local var_0_0 = "DailyLevelProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.ELITE_QUOTA_UPDATE = "DailyLevelProxy:ELITE_QUOTA_UPDATE"

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.eliteCount = 0
	arg_1_0.chapterCountList = {}
	arg_1_0.quickStages = {}

	arg_1_0:on(13201, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_2_0.data = {}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.count_list) do
			arg_1_0.data[iter_2_1.id] = iter_2_1.count
		end

		local var_2_1 = arg_1_0

		var_2_1.eliteCount = arg_2_0.elite_expedition_count
		getProxy = var_2_1
		ChapterProxy = var_3
		var_2_1(var_3).escortChallengeTimes = arg_2_0.escort_expedition_count
		ipairs = var_2

		for iter_2_2, iter_2_3 in var_2(arg_2_0.chapter_count_list) do
			table = var_2_10007

			var_2_10007.insert(arg_1_0.chapterCountList, {
				id = iter_2_3.id,
				count = iter_2_3.count
			})
		end

		ipairs = var_2

		for iter_2_4, iter_2_5 in var_2(arg_2_0.quick_expedition_list) do
			local var_2_2 = arg_1_0

			var_7.AddQuickStage(var_2_2, iter_2_5)
		end

		pg = var_2

		local var_2_3 = var_2.expedition_daily_template
		local var_2_4 = arg_1_0

		_ = var_4

		local var_2_5 = var_4.reverse

		Clone = iter_2_5
		var_2_4.dailyList = var_2_5(iter_2_5(var_2_3.all))

		for iter_2_6 = #arg_1_0.dailyList, 1, -1 do
			local var_2_6 = var_2_3[arg_1_0.dailyList[iter_2_6]].limit_period
			local var_2_7 = var_2_3[arg_1_0.dailyList[iter_2_6]].id
			local var_2_8 = var_2_3[arg_1_0.dailyList[iter_2_6]].limit_time

			if var_2_6 then
				type = var_2_10010

				if var_2_10010(var_2_6) == "table" then
					pg = var_2_10010

					local var_2_9 = var_2_10010.TimeMgr.GetInstance()

					if var_2_10010.inTime(var_2_9, var_2_6) then
						local var_2_10

						if not arg_1_0.data[var_2_7] then
							var_2_10 = 0
						end

						if var_2_10 < var_2_8 then
							arg_1_0.dailyTip = true
						end
					end
				end
			end
		end

		return
	end)

	return
end

function var_0_1.timeCall(arg_3_0)
	local var_3_0 = {}

	ProxyRegister = var_1_10002
	var_3_0[var_1_10002.DayCall] = function(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.resetDailyCount(var_4_0)

		local var_4_1 = arg_3_0

		var_1.clearChaptersDefeatCount(var_4_1)

		return
	end

	return var_3_0
end

function var_0_1.AddQuickStage(arg_5_0, arg_5_1)
	arg_5_0.quickStages[arg_5_1] = true

	return
end

function var_0_1.CanQuickBattle(arg_6_0, arg_6_1)
	return arg_6_0.quickStages[arg_6_1] == true
end

function var_0_1.clearChaptersDefeatCount(arg_7_0)
	arg_7_0.chapterCountList = {}

	return
end

function var_0_1.ifShowDailyTip(arg_8_0)
	return arg_8_0.dailyTip
end

function var_0_1.setDailyTip(arg_9_0, arg_9_1)
	arg_9_0.dailyTip = arg_9_1

	return
end

function var_0_1.getChapterDefeatCount(arg_10_0, arg_10_1)
	_ = var_1_10002

	local var_10_0

	if not var_1_10002.detect(arg_10_0.chapterCountList, function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end) or not var_2.count then
		var_10_0 = 0
	end

	return var_10_0
end

function var_0_1.updateChapterDefeatCount(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.getChapterDefeatCount(var_12_0, arg_12_1) + 1

	_ = var_1_10003

	if var_1_10003.detect(arg_12_0.chapterCountList, function(arg_13_0)
		return arg_13_0.id == arg_12_1
	end) then
		var_3.count = var_12_1
	else
		table = var_12_0

		var_12_0.insert(arg_12_0.chapterCountList, {
			id = arg_12_1,
			count = var_12_1
		})
	end

	return
end

function var_0_1.resetDailyCount(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.expedition_daily_template

	pg = var_1_10002

	local var_14_1 = var_1_10002.TimeMgr.GetInstance()
	local var_14_2 = var_2.GetServerWeek(var_14_1) == 1

	pairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0.data) do
		if var_14_0[iter_14_0].limit_type == 1 or var_14_0[iter_14_0].limit_type == 2 and var_14_2 then
			arg_14_0.data[iter_14_0] = 0
		end
	end

	arg_14_0.eliteCount = 0

	arg_14_0:sendNotification(var_0_1.ELITE_QUOTA_UPDATE)

	return
end

function var_0_1.GetRestEliteCount(arg_15_0)
	math = var_1_10001

	local var_15_0 = var_1_10001.max
	local var_15_1 = 0

	pg = var_1_10004

	return var_15_0(var_15_1, var_1_10004.gameset.elite_quota.key_value - arg_15_0.eliteCount)
end

function var_0_1.IsEliteEnabled(arg_16_0)
	return arg_16_0:GetRestEliteCount() > 0
end

function var_0_1.EliteCountPlus(arg_17_0)
	math = var_1_10001

	local var_17_0 = var_1_10001.min
	local var_17_1 = arg_17_0.eliteCount + 1

	pg = var_1_10004
	arg_17_0.eliteCount = var_17_0(var_17_1, var_1_10004.gameset.elite_quota.key_value)

	arg_17_0:sendNotification(var_0_1.ELITE_QUOTA_UPDATE)

	return
end

return var_0_1
