local DailyLevelProxy = class("DailyLevelProxy", import(".NetProxy"))

DailyLevelProxy.ELITE_QUOTA_UPDATE = "DailyLevelProxy:ELITE_QUOTA_UPDATE"

function DailyLevelProxy:register()
	self.data = {}
	self.eliteCount = 0
	self.chapterCountList = {}
	self.quickStages = {}

	self:on(13201, function(arg_2_0)
		self.data = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.count_list) do
			self.data[iter_2_1.id] = iter_2_1.count
		end

		self.eliteCount = arg_2_0.elite_expedition_count
		getProxy(ChapterProxy).escortChallengeTimes = arg_2_0.escort_expedition_count

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.chapter_count_list) do
			table.insert(self.chapterCountList, {
				id = iter_2_3.id,
				count = iter_2_3.count
			})
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.quick_expedition_list) do
			self:AddQuickStage(iter_2_5)
		end

		self.dailyList = _.reverse(Clone(pg.expedition_daily_template.all))

		for iter_2_6 = #self.dailyList, 1, -1 do
			if pg.expedition_daily_template[self.dailyList[iter_2_6]].limit_period and type(pg.expedition_daily_template[self.dailyList[iter_2_6]].limit_period) == "table" then
				if pg.TimeMgr.GetInstance():inTime(pg.expedition_daily_template[self.dailyList[iter_2_6]].limit_period) then
					if (self.data[pg.expedition_daily_template[self.dailyList[iter_2_6]].id] or 0) < pg.expedition_daily_template[self.dailyList[iter_2_6]].limit_time then
						self.dailyTip = true
					end
				end
			end
		end

		return
	end)

	return
end

function DailyLevelProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_4_0)
			self:resetDailyCount()
			self:clearChaptersDefeatCount()

			return
		end
	}
end

function DailyLevelProxy:AddQuickStage(arg_5_1)
	self.quickStages[arg_5_1] = true

	return
end

function DailyLevelProxy:CanQuickBattle(arg_6_1)
	return self.quickStages[arg_6_1] == true
end

function DailyLevelProxy:clearChaptersDefeatCount()
	self.chapterCountList = {}

	return
end

function DailyLevelProxy:ifShowDailyTip()
	return self.dailyTip
end

function DailyLevelProxy:setDailyTip(arg_9_1)
	self.dailyTip = arg_9_1

	return
end

function DailyLevelProxy:getChapterDefeatCount(arg_10_1)
	local var_10_0 = _.detect(self.chapterCountList, function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)

	return (var_10_0 or nil) and (var_10_0.count or 0)
end

function DailyLevelProxy:updateChapterDefeatCount(arg_12_1)
	local var_12_0 = self:getChapterDefeatCount(arg_12_1) + 1
	local var_12_1 = _.detect(self.chapterCountList, function(arg_13_0)
		return arg_13_0.id == arg_12_1
	end)

	if var_12_1 then
		var_12_1.count = var_12_0
	else
		table.insert(self.chapterCountList, {
			id = arg_12_1,
			count = var_12_0
		})
	end

	return
end

function DailyLevelProxy:resetDailyCount()
	local var_14_0 = pg.expedition_daily_template
	local var_14_1 = pg.TimeMgr.GetInstance():GetServerWeek() == 1

	for iter_14_0, iter_14_1 in pairs(self.data) do
		if var_14_0[iter_14_0].limit_type == 1 or var_14_0[iter_14_0].limit_type == 2 and var_14_1 then
			self.data[iter_14_0] = 0
		end
	end

	self.eliteCount = 0

	self:sendNotification(DailyLevelProxy.ELITE_QUOTA_UPDATE)

	return
end

function DailyLevelProxy:GetRestEliteCount()
	return math.max(0, pg.gameset.elite_quota.key_value - self.eliteCount)
end

function DailyLevelProxy:IsEliteEnabled()
	return self:GetRestEliteCount() > 0
end

function DailyLevelProxy:EliteCountPlus()
	self.eliteCount = math.min(self.eliteCount + 1, pg.gameset.elite_quota.key_value)

	self:sendNotification(DailyLevelProxy.ELITE_QUOTA_UPDATE)

	return
end

return DailyLevelProxy
