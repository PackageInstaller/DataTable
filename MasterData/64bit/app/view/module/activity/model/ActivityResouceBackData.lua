local var_0_0 = g.core.config.resource_recovery_info
local var_0_1 = g.core.const.ConstMgr.ResourceBackConst
local ActivityResouceBackData = class("ActivityResouceBackData")

function ActivityResouceBackData:ctor()
	self:initData()
end

function ActivityResouceBackData:initData()
	self._retrieveResMap = {}
	self._retrieveResList = {}
	self._debugMaps = {}
	self._isShowBuyTip = true
end

function ActivityResouceBackData:onS2CRetrieveGetInfo(arg_3_1)
	if arg_3_1.res_list then
		self:_updateRetrieveInfo(arg_3_1.res_list)
	end
end

function ActivityResouceBackData:onS2CRetrieveOpRetrieveRes(arg_4_1)
	if arg_4_1.retrieve and arg_4_1.retrieve.update then
		self:_updateOpRetrieveRes(arg_4_1.retrieve.update)
	end
end

function ActivityResouceBackData:_updateRetrieveInfo(arg_5_1)
	self._retrieveResMap = {}
	self._debugMaps = {}

	if arg_5_1 then
		for iter_5_0, iter_5_1 in pairs(arg_5_1) do
			if iter_5_1.receive == 0 and iter_5_1.day_res then
				local var_5_0 = {}

				var_5_0.remainder_times = 0
				var_5_0.awards = {}
				var_5_0.retrieveDays = #iter_5_1.day_res

				for iter_5_2, iter_5_3 in ipairs(iter_5_1.day_res) do
					if iter_5_3.remainder_times > 0 then
						var_5_0.remainder_times = var_5_0.remainder_times + iter_5_3.remainder_times

						for iter_5_4, iter_5_5 in ipairs(iter_5_3.awards) do
							table.insert(var_5_0.awards, iter_5_5)
						end
					end
				end

				self._retrieveResMap[iter_5_1.id] = var_5_0
			end

			self._debugMaps[iter_5_1.id] = self._debugMaps[iter_5_1.id] or {}
			self._debugMaps[iter_5_1.id] = iter_5_1
		end
	end

	self:_updateRetrieveResList()
end

function ActivityResouceBackData:_updateOpRetrieveRes(arg_6_1)
	if arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			if iter_6_1.receive == 1 and self._retrieveResMap[iter_6_1.id] then
				self._retrieveResMap[iter_6_1.id] = nil

				if self._debugMaps[iter_6_1.id] then
					self._debugMaps[iter_6_1.id] = nil
				end
			end
		end
	end

	self:_updateRetrieveResList()
end

function ActivityResouceBackData:_updateRetrieveResList()
	self._retrieveResList = {}

	for iter_7_0, iter_7_1 in pairs(self._retrieveResMap) do
		local var_7_0 = var_0_0.fetch(iter_7_0)

		if var_7_0 then
			table.insert(self._retrieveResList, {
				cfg = var_7_0,
				svrData = iter_7_1
			})
		end
	end
end

function ActivityResouceBackData:getRetrieveResList(arg_8_1)
	if arg_8_1 then
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(self._retrieveResList) do
			if arg_8_1 == var_0_1.NORMAL_TYPE and iter_8_1.cfg.cost_type == var_0_1.RETRIEVE_TYPE.COIN or iter_8_1.cfg.cost_type == var_0_1.RETRIEVE_TYPE.ALL then
				table.insert(var_8_0, iter_8_1)
			elseif arg_8_1 == var_0_1.GOLD_TYPE and iter_8_1.cfg.cost_type == var_0_1.RETRIEVE_TYPE.GOLD or iter_8_1.cfg.cost_type == var_0_1.RETRIEVE_TYPE.ALL then
				table.insert(var_8_0, iter_8_1)
			end
		end

		return var_8_0
	else
		return self._retrieveResList
	end
end

function ActivityResouceBackData:getRetrieveResDebugData(arg_9_1)
	return self._debugMaps[arg_9_1]
end

function ActivityResouceBackData:getRetrieveResIds(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs((self:getRetrieveResList(arg_10_1))) do
		table.insert(var_10_0, iter_10_1.cfg.id)
	end

	return var_10_0
end

function ActivityResouceBackData:onS2CRetrieveResOneKey(arg_11_1)
	if arg_11_1 and arg_11_1.awards and arg_11_1.ids then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1.ids) do
			if self._retrieveResMap[iter_11_1] then
				self._retrieveResMap[iter_11_1] = nil
			end

			if self._debugMaps[iter_11_1] then
				self._debugMaps[iter_11_1] = nil
			end
		end

		self:_updateRetrieveResList()
	end
end

function ActivityResouceBackData:getAllRetrieveCostByType(arg_12_1)
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs((self:getRetrieveResList(arg_12_1))) do
		var_12_0 = arg_12_1 == var_0_1.NORMAL_TYPE and var_12_0 + iter_12_1.cfg.normal_cost * iter_12_1.svrData.retrieveDays or var_12_0 + iter_12_1.cfg.buy_cost * iter_12_1.svrData.retrieveDays
	end

	return var_12_0
end

function ActivityResouceBackData:getRetrieveAwards(arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2 == var_0_1.NORMAL_TYPE and 0.5 or 1
	local var_13_1 = {}
	local var_13_2 = {}

	if self._retrieveResMap[arg_13_1] then
		for iter_13_0, iter_13_1 in pairs(self._retrieveResMap[arg_13_1].awards) do
			var_13_2[iter_13_1.type] = var_13_2[iter_13_1.type] or {}
			var_13_2[iter_13_1.type][iter_13_1.value] = var_13_2[iter_13_1.type][iter_13_1.value] or 0
			var_13_2[iter_13_1.type][iter_13_1.value] = var_13_2[iter_13_1.type][iter_13_1.value] + iter_13_1.size
		end
	end

	for iter_13_2, iter_13_3 in pairs(var_13_2) do
		for iter_13_4, iter_13_5 in pairs(iter_13_3) do
			if math.floor(iter_13_5 * var_13_0) > 0 then
				table.insert(var_13_1, {
					type = iter_13_2,
					value = iter_13_4,
					size = math.floor(iter_13_5 * var_13_0)
				})
			end
		end
	end

	return var_13_1
end

function ActivityResouceBackData:setIsShowBuyTip(arg_14_1)
	self._isShowBuyTip = arg_14_1
end

function ActivityResouceBackData:getIsShowBuyTip()
	return self._isShowBuyTip
end

function ActivityResouceBackData:isTodayUnEnter()
	if #self._retrieveResList > 0 then
		return not g.core.common.GlobalFunc.isTodayRecord(var_0_1.FRIST_ENTER_RECORD)
	end

	return false
end

return ActivityResouceBackData
