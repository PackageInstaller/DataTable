local var_0_0 = g.core.const.ConstMgr.DailyReportConst
local DailyReportData = class("DailyReportData")

function DailyReportData:ctor()
	self:initData()
end

function DailyReportData:initData()
	self._dailyType = -1
	self._configData = {}
	self._columnLikes = {}
	self._reportColumnData = {}

	self:_initCfgData()
end

function DailyReportData:_initCfgData()
	for iter_3_0 = 1, g.core.config.daily_report_info.getLength() do
		local var_3_0 = g.core.config.daily_report_info.indexOf(iter_3_0)

		self._configData[var_3_0.id] = {
			info = var_3_0,
			style = var_3_0.style,
			column = var_3_0.column
		}
	end
end

function DailyReportData:onUpdateServerReport(arg_4_1)
	self._dailyType = arg_4_1.daily_type
	self._columnLikes = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.award or {}) do
		self._columnLikes[iter_4_1.column_id] = iter_4_1
	end

	self._reportColumnData = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.activated_list or {}) do
		if self._configData[iter_4_3.report_id] then
			local var_4_0 = self._configData[iter_4_3.report_id].info

			if not self._reportColumnData[self._configData[iter_4_3.report_id].info.column] then
				self._reportColumnData[var_4_0.column] = {}
			end

			local var_4_1 = iter_4_3.string_data or {}
			local var_4_2 = {}

			for iter_4_4, iter_4_5 in ipairs(var_4_1) do
				var_4_2["content" .. iter_4_4] = string.match(iter_4_5, "%d.*_%d.*_.*") and g.core.lang:get(iter_4_5) or iter_4_5
			end

			local var_4_3 = iter_4_3.furniture_room or {}
			local var_4_5 = iter_4_3.rank_units
			local var_4_6, var_4_7

			if not iter_4_3.rank_units then
				var_4_5 = {}
				var_4_6 = self._reportColumnData[var_4_0.column]
				var_4_7 = {
					cfgData = self._configData[iter_4_3.report_id],
					reportId = iter_4_3.report_id,
					stringData = var_4_2,
					svrStringData = var_4_1
				}
			end

			var_4_7.playerData = (next(var_4_5) or nil) and var_4_5
			var_4_7.roomData = next(var_4_3) and var_4_3 or nil

			table.insert(var_4_6, var_4_7)
		end
	end
end

function DailyReportData:onLikeUpdate(arg_5_1)
	if self._columnLikes[arg_5_1.column_id] then
		self._columnLikes[arg_5_1.column_id].award_num = self._columnLikes[arg_5_1.column_id].award_num + 1
		self._columnLikes[arg_5_1.column_id].award = true
	else
		self._columnLikes[arg_5_1.column_id] = {}
		self._columnLikes[arg_5_1.column_id].award_num = 1
		self._columnLikes[arg_5_1.column_id].award = true
	end
end

function DailyReportData:getReportData()
	return self._reportColumnData
end

function DailyReportData:getReportDataByColumn(arg_7_1)
	return self._reportColumnData[arg_7_1]
end

function DailyReportData:getLikeData(arg_8_1)
	return self._columnLikes[arg_8_1] or {
		award_num = 0,
		award = false
	}
end

function DailyReportData:getCanLikeColumnIdListByType(arg_9_1)
	local var_9_0 = {}

	if arg_9_1 == var_0_0.REPORT_TYPE.DAILY then
		for iter_9_0 = var_0_0.DAILY_COLUMNS[1], var_0_0.DAILY_COLUMNS[2] do
			if self._columnLikes[iter_9_0] and not self._columnLikes[iter_9_0].award then
				table.insert(var_9_0, iter_9_0)
			elseif not self._columnLikes[iter_9_0] then
				if self._reportColumnData[iter_9_0] and table.nums(self._reportColumnData[iter_9_0]) > 0 then
					table.insert(var_9_0, iter_9_0)
				end
			end
		end
	elseif arg_9_1 == var_0_0.REPORT_TYPE.WEEK then
		for iter_9_1 = var_0_0.WEEK_COLUMNS[1], var_0_0.WEEK_COLUMNS[2] do
			if self._columnLikes[iter_9_1] and not self._columnLikes[iter_9_1].award then
				table.insert(var_9_0, iter_9_1)
			elseif not self._columnLikes[iter_9_1] then
				if self._reportColumnData[iter_9_1] and table.nums(self._reportColumnData[iter_9_1]) > 0 then
					table.insert(var_9_0, iter_9_1)
				end
			end
		end
	end

	return var_9_0
end

function DailyReportData:getReportType()
	return self._dailyType
end

function DailyReportData:setTodayNotPop(arg_11_1)
	local var_11_0 = os.date("*t", g.core.common.ServerTime:getTime())

	g.core.common.Storage:save("daily_report_today_pop.json", {
		[var_11_0.year .. "_" .. var_11_0.month .. "_" .. var_11_0.day] = arg_11_1
	})
end

function DailyReportData:isToDayPop()
	local var_12_0 = g.core.common.Storage:load("daily_report_today_pop.json")

	if not var_12_0 then
		return true
	end

	local var_12_1 = os.date("*t", g.core.common.ServerTime:getTime())

	return not var_12_0[var_12_1.year .. "_" .. var_12_1.month .. "_" .. var_12_1.day]
end

function DailyReportData:isShowOpen()
	if g.core.common.ServerTime:getOpenDays() <= 1 then
		return false
	end

	if g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.DAILY_REPORT_SHOW_TIME).parameter > g.core.common.ServerTime:getTime() then
		return false
	end

	return true
end

return DailyReportData
