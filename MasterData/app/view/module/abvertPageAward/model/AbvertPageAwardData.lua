local var_0_0 = g.core.config.openscreen_gift_info
local var_0_2 = g.core.common.ServerTime
local AbvertPageAwardData = class("AbvertPageAwardData")

function AbvertPageAwardData:ctor()
	self:initData()
end

function AbvertPageAwardData:initData()
	self._svrAbvertData = {}
end

function AbvertPageAwardData:onS2CAbvertPageAwardGetInfo(arg_3_1)
	if arg_3_1.award_pages then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.award_pages) do
			if not self._svrAbvertData[iter_3_1.sub_id] then
				self._svrAbvertData[iter_3_1.sub_id] = {}
				iter_3_1.cfg = {}
			end

			iter_3_1.cfg = var_0_0.get(iter_3_1.sub_id)
			self._svrAbvertData[iter_3_1.sub_id] = iter_3_1
		end
	end
end

function AbvertPageAwardData:onS2CAbvertPageAwardNotify(arg_4_1)
	if arg_4_1.update then
		if not self._svrAbvertData[arg_4_1.update.sub_id] then
			self._svrAbvertData[arg_4_1.update.sub_id] = {}
			arg_4_1.update.cfg = {}
		end

		arg_4_1.update.cfg = var_0_0.get(arg_4_1.update.sub_id)
		self._svrAbvertData[arg_4_1.update.sub_id] = arg_4_1.update
	end

	if arg_4_1.del_id then
		for iter_4_0, iter_4_1 in pairs(self._svrAbvertData) do
			if iter_4_1.id == arg_4_1.del_id then
				self._svrAbvertData[iter_4_1.sub_id] = nil
			end
		end
	end
end

function AbvertPageAwardData:onS2CAbvertPageAward(arg_5_1)
	if arg_5_1.sub_id and self._svrAbvertData[arg_5_1.sub_id] then
		self._svrAbvertData[arg_5_1.sub_id].is_awarded = true
		self._svrAbvertData[arg_5_1.sub_id].award_time = var_0_2:getTime()
	end
end

function AbvertPageAwardData:getAbvertPageAwardServerData(arg_6_1)
	return self._svrAbvertData[arg_6_1]
end

function AbvertPageAwardData:getAbvertPageAwardArray(arg_7_1)
	local var_7_0 = self:getAbvertPageAwardServerData(arg_7_1)

	if var_7_0 then
		local var_7_1 = {}

		while var_0_0.hasKey("gift_type_" .. 1) do
			if var_7_0.cfg["gift_type_" .. 1] > 0 then
				table.insert(var_7_1, {
					type = var_7_0.cfg["gift_type_" .. 1],
					value = var_7_0.cfg["gift_value_" .. 1],
					size = var_7_0.cfg["gift_size_" .. 1]
				})
			end
		end

		return var_7_1
	end

	return {}
end

function AbvertPageAwardData:getCurActId()
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(self._svrAbvertData) do
		if self:isActivityInShow(iter_8_0) then
			var_8_0 = iter_8_0
		end
	end

	return var_8_0
end

function AbvertPageAwardData:getOpenScreenTemplate(arg_9_1)
	local var_9_0 = self:getAbvertPageAwardServerData(arg_9_1)

	if var_9_0 then
		return var_9_0.cfg.template
	end

	return 0
end

function AbvertPageAwardData:isActivityInShow(arg_10_1)
	local var_10_0 = self:getAbvertPageAwardServerData(arg_10_1)

	if var_10_0 then
		local var_10_1 = var_0_2:getTime()
		local var_10_2 = var_10_0.end_time

		if var_10_0.is_awarded then
			var_10_2 = math.min(var_10_2, (var_10_0.award_time or 0) + var_10_0.cfg.time)
		end

		if var_10_0.start_time <= var_10_1 and var_10_1 < var_10_2 then
			return true
		end
	end

	return false
end

function AbvertPageAwardData:isCanGetAward()
	local var_11_0 = self:getAbvertPageAwardServerData((self:getCurActId()))

	if var_11_0 then
		local var_11_1 = var_0_2:getTime()

		return not var_11_0.is_awarded and var_11_0.start_time <= var_11_1 and var_11_1 < var_11_0.end_time
	end

	return false
end

return AbvertPageAwardData
