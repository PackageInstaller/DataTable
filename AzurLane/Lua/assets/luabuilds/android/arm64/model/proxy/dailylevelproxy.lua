local var_0_0 = class("DailyLevelProxy", import(".NetProxy"))

var_0_0.ELITE_QUOTA_UPDATE = "DailyLevelProxy:ELITE_QUOTA_UPDATE"

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.eliteCount = 0
	arg_1_0.chapterCountList = {}
	arg_1_0.quickStages = {}

	arg_1_0:on(13201, function(arg_2_0)
		arg_1_0.data = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.count_list) do
			arg_1_0.data[iter_2_1.id] = iter_2_1.count
		end

		arg_1_0.eliteCount = arg_2_0.elite_expedition_count
		getProxy(ChapterProxy).escortChallengeTimes = arg_2_0.escort_expedition_count

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.chapter_count_list) do
			table.insert(arg_1_0.chapterCountList, {
				id = iter_2_3.id,
				count = iter_2_3.count
			})
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.quick_expedition_list) do
			arg_1_0:AddQuickStage(iter_2_5)
		end

		arg_1_0.dailyList = _.reverse(Clone(pg.expedition_daily_template.all))

		for iter_2_6 = #arg_1_0.dailyList, 1, -1 do
			if pg.expedition_daily_template[arg_1_0.dailyList[iter_2_6]].limit_period and type(pg.expedition_daily_template[arg_1_0.dailyList[iter_2_6]].limit_period) == "table" then
				local var_2_0 = pg.TimeMgr.GetInstance()

				if var_2_0:inTime(pg.expedition_daily_template[arg_1_0.dailyList[iter_2_6]].limit_period) then
					local var_2_1 = arg_1_0.data[pg.expedition_daily_template[arg_1_0.dailyList[iter_2_6]].id] or 0

					if var_2_1 < pg.expedition_daily_template[arg_1_0.dailyList[iter_2_6]].limit_time then
						arg_1_0.dailyTip = true
					end
				end
			end
		end

		return
	end)

	return
end

function var_0_0.timeCall(arg_3_0)
	return {
		[ProxyRegister.DayCall] = function(arg_4_0)
			arg_3_0:resetDailyCount()
			arg_3_0:clearChaptersDefeatCount()

			return
		end
	}
end

function var_0_0.AddQuickStage(arg_5_0, arg_5_1)
	arg_5_0.quickStages[arg_5_1] = true

	return
end

function var_0_0.CanQuickBattle(arg_6_0, arg_6_1)
	return arg_6_0.quickStages[arg_6_1] == true
end

function var_0_0.clearChaptersDefeatCount(arg_7_0)
	arg_7_0.chapterCountList = {}

	return
end

function var_0_0.ifShowDailyTip(arg_8_0)
	return arg_8_0.dailyTip
end

function var_0_0.setDailyTip(arg_9_0, arg_9_1)
	arg_9_0.dailyTip = arg_9_1

	return
end

function var_0_0.getChapterDefeatCount(arg_10_0, arg_10_1)
	local var_10_0 = _.detect(arg_10_0.chapterCountList, function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)

	if var_10_0 then
		return var_10_0.count or 0
	end
end

function var_0_0.updateChapterDefeatCount(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getChapterDefeatCount(arg_12_1) + 1
	local var_12_1 = _.detect(arg_12_0.chapterCountList, function(arg_13_0)
		return arg_13_0.id == arg_12_1
	end)

	if var_12_1 then
		var_12_1.count = var_12_0
	else
		table.insert(arg_12_0.chapterCountList, {
			id = arg_12_1,
			count = var_12_0
		})
	end

	return
end

function var_0_0.resetDailyCount(arg_14_0)
	local var_14_0 = pg.expedition_daily_template
	local var_14_1 = pg.TimeMgr.GetInstance():GetServerWeek() == 1

	for iter_14_0, iter_14_1 in pairs(arg_14_0.data) do
		if var_14_0[iter_14_0].limit_type == 1 or var_14_0[iter_14_0].limit_type == 2 and var_14_1 then
			arg_14_0.data[iter_14_0] = 0
		end
	end

	arg_14_0.eliteCount = 0

	arg_14_0:sendNotification(var_0_0.ELITE_QUOTA_UPDATE)

	return
end

function var_0_0.GetRestEliteCount(arg_15_0)
	return math.max(0, pg.gameset.elite_quota.key_value - arg_15_0.eliteCount)
end

function var_0_0.IsEliteEnabled(arg_16_0)
	return arg_16_0:GetRestEliteCount() > 0
end

function var_0_0.EliteCountPlus(arg_17_0)
	arg_17_0.eliteCount = math.min(arg_17_0.eliteCount + 1, pg.gameset.elite_quota.key_value)

	arg_17_0:sendNotification(var_0_0.ELITE_QUOTA_UPDATE)

	return
end

return var_0_0
