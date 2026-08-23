local DoubleElevenData = class("DoubleElevenData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.limit_sale_info
local var_0_2 = g.core.common.ServerTime

function DoubleElevenData:ctor()
	self:initData()
end

function DoubleElevenData:initData()
	self._buyTimes = {}
	self._activityTime = {}
	self._curActivity = 0

	for iter_2_0 = 1, var_0_1.getLength() do
		local var_2_0 = var_0_1.indexOf(iter_2_0)

		if not self._activityTime[var_2_0.activity] and var_2_0.version == g.core.platform.PlatformProxy:getGameId() then
			local var_2_1 = tonumber(var_2_0.begin_time)
			local var_2_3 = tonumber(var_2_0.end_time)

			self._activityTime[var_2_0.activity] = {
				startTime = var_0_2:getTimeStampByParams({
					year = math.floor(var_2_1 / 10000000000),
					month = math.floor(var_2_1 % 10000000000 / 100000000),
					day = math.floor(var_2_1 % 10000000000 % 100000000 / 1000000)
				}),
				endTime = var_0_2:getTimeStampByParams({
					year = math.floor(var_2_3 / 10000000000),
					month = math.floor(var_2_3 % 10000000000 / 100000000),
					day = math.floor(var_2_3 % 10000000000 % 100000000 / 1000000)
				}),
				displayType = var_2_0.display_type
			}
		end
	end
end

function DoubleElevenData:getGiftArr()
	local var_3_0 = {}

	for iter_3_0 = 1, var_0_1.getLength() do
		local var_3_1 = var_0_1.indexOf(iter_3_0)

		if var_3_1.activity == self._curActivity then
			table.insert(var_3_0, var_3_1)
		end
	end

	return var_3_0
end

function DoubleElevenData:getCurActivityType()
	return self._curDisplayType or 0
end

function DoubleElevenData:getBuyTimesById(arg_5_1)
	return self._buyTimes[arg_5_1] or 0
end

function DoubleElevenData:updateBuyTimes(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		self._buyTimes[iter_6_1.id] = iter_6_1.buy_times
	end
end

function DoubleElevenData:checkActivityOpen()
	local var_7_0 = var_0_2:getTime()

	for iter_7_0, iter_7_1 in pairs(self._activityTime) do
		if var_7_0 >= iter_7_1.startTime and var_7_0 < iter_7_1.endTime then
			self._curActivity = iter_7_0
			self._curDisplayType = iter_7_1.displayType

			return true
		end
	end
end

function DoubleElevenData:getEndTime()
	return self._activityTime[self._curActivity].endTime
end

return DoubleElevenData
