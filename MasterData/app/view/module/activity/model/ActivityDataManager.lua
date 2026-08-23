local var_0_0 = g.core.const.ConstMgr.ActivityConst
local ActivityData = require("app.view.module.activity.model.ActivityData")
local ActivityDataManager = class("ActivityDataManager")

function ActivityDataManager:ctor()
	self:initData()
end

function ActivityDataManager:initData()
	self._configTableActivityDataMap = {}
	self._customActivityDataMap = {}
	self._independentCustomActivityDataMap = {}
	self._refConfigCustomActivityDataMap = {}
	self._hideCustomActivityDataMap = {}

	self:_initConfigTableActivityDataMap()
end

function ActivityDataManager:onRcvCustomActivityGetInfo(arg_3_1)
	self._customActivityDataMap = {}
	self._refConfigCustomActivityDataMap = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1.infos or {}) do
		if not self._customActivityDataMap[iter_3_1.type] then
			self._customActivityDataMap[iter_3_1.type] = {}
			self._refConfigCustomActivityDataMap[iter_3_1.type] = {}
		end

		local var_3_0 = self:_createActivityData({
			activitySourceType = var_0_0.ACTIVITY_SOURCE_TYPE.CUSTOM,
			activityType = iter_3_1.type,
			activityValue = iter_3_1.id,
			info = iter_3_1
		})

		self._customActivityDataMap[iter_3_1.type][iter_3_1.id] = var_3_0
		self._refConfigCustomActivityDataMap[iter_3_1.type][var_3_0:getConfigActivityValue()] = var_3_0
	end

	self._hideCustomActivityDataMap = {}

	for iter_3_2, iter_3_3 in pairs(arg_3_1.hides or {}) do
		self._hideCustomActivityDataMap[iter_3_3.id] = self:_createActivityData({
			activitySourceType = var_0_0.ACTIVITY_SOURCE_TYPE.CUSTOM,
			activityValue = iter_3_3.id,
			info = iter_3_3
		})
	end
end

function ActivityDataManager:onRcvActivityCommonGetInfoServer(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self._configTableActivityDataMap) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			iter_4_3:updateTimes()
			iter_4_3:setOpenedInServer(false)
		end
	end

	for iter_4_4, iter_4_5 in pairs((self:_createMapForSetOpenedInServer(arg_4_1.activityInfo or {}))) do
		if self._configTableActivityDataMap[iter_4_4] then
			for iter_4_6, iter_4_7 in pairs(iter_4_5) do
				if self._configTableActivityDataMap[iter_4_4][iter_4_6] then
					self._configTableActivityDataMap[iter_4_4][iter_4_6]:setOpenedInServer(true)
				end
			end
		end
	end

	g.core.model.User.giftData:refreshInTime()
end

function ActivityDataManager:_createMapForSetOpenedInServer(arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		var_5_0[iter_5_1.type] = var_5_0[iter_5_1.type] or {}
		var_5_0[iter_5_1.type][iter_5_1.value] = true
	end

	return var_5_0
end

function ActivityDataManager:onRcvCustomActivityReqInfo(arg_6_1)
	if arg_6_1.shows then
		for iter_6_0, iter_6_1 in pairs(arg_6_1.shows) do
			if not self._customActivityDataMap[iter_6_1.type] then
				self._customActivityDataMap[iter_6_1.type] = {}
				self._refConfigCustomActivityDataMap[iter_6_1.type] = {}
			end

			local var_6_0 = self:_createActivityData({
				activitySourceType = var_0_0.ACTIVITY_SOURCE_TYPE.CUSTOM,
				activityType = iter_6_1.type,
				activityValue = iter_6_1.id,
				info = iter_6_1
			})

			self._customActivityDataMap[iter_6_1.type][iter_6_1.id] = var_6_0
			self._refConfigCustomActivityDataMap[iter_6_1.type][var_6_0:getConfigActivityValue()] = var_6_0
			self._hideCustomActivityDataMap[iter_6_1.id] = nil
		end
	elseif arg_6_1.ids then
		for iter_6_2, iter_6_3 in pairs(arg_6_1.ids) do
			self:_clearCustomActivityDataById(iter_6_3)
		end
	end
end

function ActivityDataManager:onRcvCustomActivityUpdateInfo(arg_7_1)
	if arg_7_1.updates then
		for iter_7_0, iter_7_1 in pairs(arg_7_1.updates) do
			self._hideCustomActivityDataMap[iter_7_1.id] = self:_createActivityData({
				activitySourceType = var_0_0.ACTIVITY_SOURCE_TYPE.CUSTOM,
				activityValue = iter_7_1.id,
				info = iter_7_1
			})

			self:_clearCustomActivityDataByActValue(iter_7_1.id)
		end
	end

	if arg_7_1.deletes then
		for iter_7_2, iter_7_3 in pairs(arg_7_1.deletes) do
			self:_clearCustomActivityDataById(iter_7_3)
		end
	end
end

function ActivityDataManager:_initConfigTableActivityDataMap()
	local function var_8_0(arg_9_0)
		for iter_9_0, iter_9_1 in arg_9_0.ipairs() do
			self._configTableActivityDataMap[iter_9_1.activity_type] = self._configTableActivityDataMap[iter_9_1.activity_type] or {}
			self._configTableActivityDataMap[iter_9_1.activity_type][iter_9_1.activity_value] = self:_createActivityData({
				activitySourceType = var_0_0.ACTIVITY_SOURCE_TYPE.CONFIG_TABLE,
				activityType = iter_9_1.activity_type,
				activityValue = iter_9_1.activity_value,
				info = iter_9_1
			})
		end
	end

	var_8_0(g.core.config.activity_open_info)
	var_8_0(g.core.config.activity_resident_info)
end

function ActivityDataManager:_clearCustomActivityDataById(arg_10_1)
	self:_clearCustomActivityDataByActValue(arg_10_1)
end

function ActivityDataManager:_clearCustomActivityDataByActValue(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self._customActivityDataMap) do
		if iter_11_1[arg_11_1] then
			if self._refConfigCustomActivityDataMap[iter_11_0] then
				self._refConfigCustomActivityDataMap[iter_11_0][arg_11_1] = nil
			end

			iter_11_1[arg_11_1] = nil

			return
		end
	end

	for iter_11_2, iter_11_3 in pairs(self._independentCustomActivityDataMap) do
		if iter_11_3[arg_11_1] then
			if self._refConfigCustomActivityDataMap[iter_11_2] then
				self._refConfigCustomActivityDataMap[iter_11_2][arg_11_1] = nil
			end

			iter_11_3[arg_11_1] = nil

			break
		end
	end
end

function ActivityDataManager:_createActivityData(arg_12_1)
	return ActivityData.new(arg_12_1)
end

function ActivityDataManager:getCustomActivityDataMap()
	return self._customActivityDataMap
end

function ActivityDataManager:getIndependentCustomActivityDataMap()
	return self._independentCustomActivityDataMap
end

function ActivityDataManager:getHideCustomActivityDataMap()
	return self._hideCustomActivityDataMap
end

function ActivityDataManager:getActivityData(arg_16_1, arg_16_2)
	return self:getConfigTableActivityData(arg_16_1, arg_16_2) or self:getCustomActivityData(arg_16_1, arg_16_2)
end

function ActivityDataManager:getShowActivityDataByCfg(arg_17_1, arg_17_2)
	local var_17_0 = self:getConfigTableActivityData(arg_17_1, arg_17_2)

	if var_17_0 and var_17_0:isShow() then
		return var_17_0
	else
		local var_17_1 = self:getCustomActivityDataByConfigVal(arg_17_1, arg_17_2)

		if var_17_1 and var_17_1:isShow() then
			return var_17_1
		end
	end

	return nil
end

function ActivityDataManager:getConfigTableActivityData(arg_18_1, arg_18_2)
	if self._configTableActivityDataMap[arg_18_1] then
		return self._configTableActivityDataMap[arg_18_1][arg_18_2]
	end

	return nil
end

function ActivityDataManager:getConfigTableActDataByFilter(arg_19_1)
	for iter_19_0, iter_19_1 in pairs(self._configTableActivityDataMap) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			if arg_19_1(iter_19_3) then
				return iter_19_3
			end
		end
	end

	return nil
end

function ActivityDataManager:getCustomActivityDataByType(arg_20_1)
	if self._customActivityDataMap[arg_20_1] then
		return self._customActivityDataMap[arg_20_1]
	elseif self._independentCustomActivityDataMap[arg_20_1] then
		return self._independentCustomActivityDataMap[arg_20_1]
	end
end

function ActivityDataManager:getCustomActivityData(arg_21_1, arg_21_2)
	if self._customActivityDataMap[arg_21_1] then
		return self._customActivityDataMap[arg_21_1][arg_21_2]
	elseif self._independentCustomActivityDataMap[arg_21_1] then
		return self._independentCustomActivityDataMap[arg_21_1][arg_21_2]
	end

	return nil
end

function ActivityDataManager:getCustomActivityDataByConfigVal(arg_22_1, arg_22_2)
	if self._refConfigCustomActivityDataMap[arg_22_1] then
		return self._refConfigCustomActivityDataMap[arg_22_1][arg_22_2]
	end

	return nil
end

function ActivityDataManager:getActivityDataDuringDisplay(arg_23_1, arg_23_2)
	local var_23_0

	if arg_23_1 == var_0_0.ACTIVITY_SOURCE_TYPE.CONFIG_TABLE then
		var_23_0 = self._configTableActivityDataMap[arg_23_2]
	elseif arg_23_1 == var_0_0.ACTIVITY_SOURCE_TYPE.CUSTOM then
		var_23_0 = self._customActivityDataMap[arg_23_2] or self._independentCustomActivityDataMap[arg_23_2]
	end

	if var_23_0 then
		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			if iter_23_1:isShow() then
				return iter_23_1
			end
		end
	end
end

function ActivityDataManager:getActivityDataListByFilter(arg_24_1)
	if type(arg_24_1) ~= "function" then
		return {}
	end

	local function var_24_0(arg_25_0, arg_25_1)
		for iter_25_0, iter_25_1 in pairs(arg_25_0) do
			for iter_25_2, iter_25_3 in pairs(iter_25_1) do
				if arg_24_1(iter_25_3) then
					table.insert(arg_25_1, iter_25_3)
				end
			end
		end
	end

	local var_24_1 = {}

	var_24_0(self._configTableActivityDataMap, var_24_1)
	var_24_0(self._customActivityDataMap, var_24_1)
	var_24_0(self._independentCustomActivityDataMap, var_24_1)

	return var_24_1
end

function ActivityDataManager:getActivityDataListByFunctionId(arg_26_1)
	return (self:getActivityDataListByFilter(function(arg_27_0)
		if arg_27_0:getFunctionId() == arg_26_1 then
			return arg_27_0:isShow()
		end
	end))
end

function ActivityDataManager:addIndependentCustomActivity(arg_28_1)
	arg_28_1 = arg_28_1 or {}

	local var_28_0 = arg_28_1.type or 0
	local var_28_1 = arg_28_1.id or 0
	local var_28_2 = arg_28_1.sub_activity_id or 0

	if var_28_0 * var_28_1 * var_28_2 == 0 then
		local var_28_3 = string.format("Error! AddIndependentCustomActivity invalid activityType = %s, activityValue = %s, activitySubId = %s ", tostring(var_28_0), tostring(var_28_1), tostring(var_28_2))

		g.core.log:info(var_28_3)
		g.core.platform.BuglyProxy:error(var_28_3)

		return
	end

	arg_28_1.time_type = arg_28_1.time_type or var_0_0.TIME_TYPE.CLEAN_TIME_STAMP

	local var_28_4 = {
		activitySourceType = var_0_0.ACTIVITY_SOURCE_TYPE.CUSTOM,
		activityType = var_28_0,
		activityValue = var_28_1,
		info = arg_28_1
	}
	local var_28_5 = self._independentCustomActivityDataMap[var_28_0]

	if not self._independentCustomActivityDataMap[var_28_0] then
		var_28_5 = {}
		self._independentCustomActivityDataMap[var_28_0] = var_28_5
	end

	if var_28_5[var_28_1] then
		var_28_5[var_28_1]:initParams(var_28_4)
	else
		local var_28_6 = self:_createActivityData(var_28_4)

		self._independentCustomActivityDataMap[var_28_0][var_28_1] = var_28_6
		self._refConfigCustomActivityDataMap[var_28_0] = self._refConfigCustomActivityDataMap[var_28_0] or {}
		self._refConfigCustomActivityDataMap[var_28_0][var_28_6:getConfigActivityValue()] = var_28_6
	end
end

return ActivityDataManager
