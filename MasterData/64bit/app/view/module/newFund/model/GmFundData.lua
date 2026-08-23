local var_0_0 = g.core.config.gm_fund_info
local var_0_1 = g.core.config.gm_fund_level_info
local var_0_2 = g.core.common.Drops
local GmFundConst = require("app.view.module.newFund.const.GmFundConst")
local GmFundData = class("GmFundData")

function GmFundData:ctor()
	self:initData()
end

function GmFundData:initData()
	self._actCfgIdMap = {}
	self._typeFundMap = {}
	self._svrIdToIdMap = {}
	self._IdToSvrIdMap = {}
	self._fundIdMap = {}
	self._fundActionMap = {}
	self._fundRechargeMap = {}
	self._fundFreeAwardLv = {}
	self._fundPayAwardLv = {}
	self._fundLvMap = {}
	self._svrRedMap = {}
	self._hasServerData = false
end

function GmFundData:onS2CRedPoint(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self:updateFundActivity(iter_3_1.activity)

		self._svrRedMap[iter_3_1.activity.id] = iter_3_1.award
	end
end

function GmFundData:updateFundRecharge(arg_4_1)
	self._fundRechargeMap[arg_4_1.activity_id] = true
end

function GmFundData:updateFundActivity(arg_5_1)
	self._svrIdToIdMap[arg_5_1.id] = arg_5_1.sub_id
	self._IdToSvrIdMap[arg_5_1.sub_id] = arg_5_1.id
	self._typeFundMap[var_0_0.get(arg_5_1.sub_id).type] = arg_5_1.id

	self:fundActOpen(arg_5_1.sub_id)

	self._actCfgIdMap[arg_5_1.sub_id] = arg_5_1
end

function GmFundData:getCfgByType(arg_6_1)
	return var_0_0.get((self:getActivityIdBySid(self:getSvrIdByType(arg_6_1))))
end

function GmFundData:getSvrIdByType(arg_7_1)
	if not self._typeFundMap[arg_7_1] then
		return 0
	end

	return self._typeFundMap[arg_7_1]
end

function GmFundData:getActivityIdBySid(arg_8_1)
	if not self._svrIdToIdMap[arg_8_1] then
		return 0
	end

	return self._svrIdToIdMap[arg_8_1]
end

function GmFundData:getSidByActivityId(arg_9_1)
	if not self._IdToSvrIdMap[arg_9_1] then
		return 0
	end

	return self._IdToSvrIdMap[arg_9_1]
end

function GmFundData:updateFundActivityData(arg_10_1)
	self._fundActionMap[arg_10_1.activity_id] = self._fundActionMap[arg_10_1.activity_id] or {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.actions or {}) do
		self._fundActionMap[arg_10_1.activity_id][iter_10_1.type .. "_" .. iter_10_1.key] = iter_10_1.value
	end

	self._fundRechargeMap[arg_10_1.activity_id] = arg_10_1.pay

	local var_10_0 = {}

	for iter_10_2, iter_10_3 in ipairs(arg_10_1.free_award_lvs or {}) do
		var_10_0[iter_10_3] = true
	end

	self._hasServerData = true
	self._fundFreeAwardLv[arg_10_1.activity_id] = var_10_0

	local var_10_1 = {}

	for iter_10_4, iter_10_5 in ipairs(arg_10_1.pay_award_lvs or {}) do
		var_10_1[iter_10_5] = true
	end

	self._fundPayAwardLv[arg_10_1.activity_id] = var_10_1

	self:updateFundLevel(arg_10_1.activity_id)
end

function GmFundData:isActivityRecharge(arg_11_1)
	return self._fundRechargeMap[self:getSvrIdByType(arg_11_1)]
end

function GmFundData:onGetLvReward(arg_12_1)
	self._fundFreeAwardLv[arg_12_1.activity_id] = self._fundFreeAwardLv[arg_12_1.activity_id] or {}
	self._fundPayAwardLv[arg_12_1.activity_id] = self._fundPayAwardLv[arg_12_1.activity_id] or {}

	if arg_12_1.lv == 0 then
		for iter_12_0 = 1, self:updateFundLevel(arg_12_1.activity_id) do
			self._fundFreeAwardLv[arg_12_1.activity_id][iter_12_0] = true

			if self._fundRechargeMap[arg_12_1.activity_id] then
				self._fundPayAwardLv[arg_12_1.activity_id][iter_12_0] = true
			end
		end
	elseif arg_12_1.type == 1 then
		self._fundFreeAwardLv[arg_12_1.activity_id][arg_12_1.lv] = true
	else
		self._fundPayAwardLv[arg_12_1.activity_id][arg_12_1.lv] = true
	end
end

function GmFundData:getCurFundValue(arg_13_1)
	local var_13_0 = self:getSvrIdByType(arg_13_1)
	local var_13_1 = self._fundIdMap[self:getActivityIdBySid(var_13_0)][1]

	if self._fundActionMap[var_13_0] then
		return self._fundActionMap[var_13_0][var_13_1.action .. "_" .. var_13_1.key] or 0
	end

	return 0
end

function GmFundData:getAllGetAwardNums(arg_14_1)
	local var_14_0 = self:getSvrIdByType(arg_14_1)
	local var_14_1 = self:getActivityIdBySid(var_14_0)
	local var_14_2 = self:getFundLevel(var_14_1)
	local var_14_3 = #self._fundIdMap[var_14_1]
	local var_14_4 = 0

	self._fundFreeAwardLv[var_14_0] = self._fundFreeAwardLv[var_14_0] or {}
	self._fundPayAwardLv[var_14_0] = self._fundPayAwardLv[var_14_0] or {}

	for iter_14_0 = 1, var_14_2 do
		if not self._fundFreeAwardLv[var_14_0][iter_14_0] then
			var_14_4 = var_14_4 + 1
		end

		if self._fundRechargeMap[var_14_0] and not self._fundPayAwardLv[var_14_0][iter_14_0] then
			var_14_4 = var_14_4 + 1
		end
	end

	return var_14_4, var_14_3 <= var_14_2 and var_14_4 == 0
end

function GmFundData:getFirstCanRewardIndex(arg_15_1)
	local var_15_0 = self:getSvrIdByType(arg_15_1)
	local var_15_2 = self:getFundLevel((self:getActivityIdBySid(var_15_0)))

	self._fundFreeAwardLv[var_15_0] = self._fundFreeAwardLv[var_15_0] or {}
	self._fundPayAwardLv[var_15_0] = self._fundPayAwardLv[var_15_0] or {}

	for iter_15_0 = 1, var_15_2 do
		if not self._fundFreeAwardLv[var_15_0][iter_15_0] then
			return iter_15_0
		end

		if self._fundRechargeMap[var_15_0] and not self._fundPayAwardLv[var_15_0][iter_15_0] then
			return iter_15_0
		end
	end

	return var_15_2
end

function GmFundData:onActionUpdate(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1.actions) do
		self._fundActionMap[iter_16_1.activity_id] = self._fundActionMap[iter_16_1.activity_id] or {}
		self._fundActionMap[iter_16_1.activity_id][iter_16_1.action.type .. "_" .. iter_16_1.action.key] = iter_16_1.action.value

		self:updateFundLevel(iter_16_1.activity_id)
	end
end

function GmFundData:isFundInOpenTime(arg_17_1)
	local var_17_0 = self._actCfgIdMap[arg_17_1]

	if not self._actCfgIdMap[arg_17_1] then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.FUND_NEW) then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(self:getCfgByType(var_17_0.sub_id).function_id) then
		return false
	end

	local var_17_1 = g.core.model.User:getLevel()

	if var_17_1 < var_17_0.min_level or var_17_1 > var_17_0.max_level then
		return false
	end

	local var_17_2 = g.core.common.ServerTime:getTime()

	return var_17_2 >= var_17_0.start_time and var_17_2 <= var_17_0.end_time
end

function GmFundData:getFundActivityTime(arg_18_1)
	if not self._actCfgIdMap[arg_18_1] then
		return
	end

	return self._actCfgIdMap[arg_18_1].start_time, self._actCfgIdMap[arg_18_1].end_time
end

function GmFundData:fundActOpen(arg_19_1)
	if self._fundIdMap[arg_19_1] then
		return
	end

	self._fundIdMap[arg_19_1] = {}

	for iter_19_0, iter_19_1 in var_0_1.ipairs() do
		if iter_19_1.fund_id == arg_19_1 then
			self._fundIdMap[arg_19_1][iter_19_1.level] = iter_19_1
		end
	end
end

function GmFundData:getFundRewardItems(arg_20_1)
	return self._fundIdMap[self:getActivityIdBySid(self:getSvrIdByType(arg_20_1))]
end

function GmFundData:updateFundLevel(arg_21_1)
	local var_21_0 = self:getActivityIdBySid(arg_21_1)

	if not self._fundIdMap[var_21_0] then
		return
	end

	local var_21_1 = self._fundActionMap[arg_21_1] or {}
	local var_21_2 = 0

	for iter_21_0, iter_21_1 in ipairs(self._fundIdMap[var_21_0]) do
		if (var_21_1[iter_21_1.action .. "_" .. iter_21_1.key] or 0) >= iter_21_1.num then
			var_21_2 = iter_21_1.level
		else
			break
		end
	end

	self._fundLvMap[var_21_0] = var_21_2

	return var_21_2
end

function GmFundData:getFundLevel(arg_22_1)
	return self._fundLvMap[arg_22_1] or 0
end

function GmFundData:hasActivityFund(arg_23_1)
	local var_23_0 = self._actCfgIdMap[self:getActivityIdBySid((self:getSvrIdByType(arg_23_1)))]

	if var_23_0 then
		local var_23_1 = g.core.model.User:getLevel()

		if var_23_1 < var_23_0.min_level or var_23_1 > var_23_0.max_level then
			return false
		end

		local var_23_2 = g.core.common.ServerTime:getTime()

		if var_23_2 >= var_23_0.start_time and var_23_2 <= var_23_0.end_time then
			return true
		end

		return true
	end

	return false
end

function GmFundData:getActivityEndTime(arg_24_1)
	return self._actCfgIdMap[self:getActivityIdBySid((self:getSvrIdByType(arg_24_1)))].end_time
end

function GmFundData:getFundCfg(arg_25_1, arg_25_2)
	if not self._fundIdMap[arg_25_1] then
		return
	end

	return self._fundIdMap[arg_25_1][arg_25_2]
end

function GmFundData:getFundAwardState(arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = self:getSidByActivityId(arg_26_1)
	local var_26_1

	if arg_26_3 then
		var_26_1 = self._fundFreeAwardLv[var_26_0] or self._fundPayAwardLv[var_26_0]

		if not arg_26_3 and not self._fundRechargeMap[var_26_0] then
			return GmFundConst.FUND_AWARD_STATE.LOCKED
		end
	end

	local var_26_2 = GmFundConst.FUND_AWARD_STATE.CANNOT_GET

	if var_26_1 and var_26_1[arg_26_2] then
		var_26_2 = GmFundConst.FUND_AWARD_STATE.GETTED
	elseif arg_26_2 <= (self._fundLvMap[arg_26_1] or 0) then
		var_26_2 = GmFundConst.FUND_AWARD_STATE.CAN_GET
	end

	return var_26_2
end

function GmFundData:getFundAward(arg_27_1, arg_27_2)
	local var_27_0 = self:getFundCfg(arg_27_1, arg_27_2)

	return var_0_2:getGoodsArray(var_27_0.free_drop), var_0_2:getGoodsArray(var_27_0.pay_drop)
end

function GmFundData:getFundAwardByCfg(arg_28_1)
	return var_0_2:getGoodsArray(arg_28_1.free_drop), var_0_2:getGoodsArray(arg_28_1.pay_drop)
end

function GmFundData:hasForestFundReward()
	return self:hasFundReward(GmFundConst.FUND_TYPE.FOREST)
end

function GmFundData:hasGveFundReward()
	return self:hasFundReward(GmFundConst.FUND_TYPE.GVE)
end

function GmFundData:hasFogFundReward()
	return self:hasFundReward(GmFundConst.FUND_TYPE.FOG_NIGHTMARE)
end

function GmFundData:hasFundReward(arg_32_1)
	local var_32_0 = self:getSvrIdByType(arg_32_1)

	if not self._hasServerData then
		return self._svrRedMap[var_32_0]
	end

	self._fundFreeAwardLv[var_32_0] = self._fundFreeAwardLv[var_32_0] or {}
	self._fundPayAwardLv[var_32_0] = self._fundPayAwardLv[var_32_0] or {}

	for iter_32_0 = 1, self._fundLvMap[self:getActivityIdBySid(var_32_0)] or 0 do
		if self._fundFreeAwardLv[var_32_0] and not self._fundFreeAwardLv[var_32_0][iter_32_0] then
			return true
		end

		if self._fundRechargeMap[var_32_0] and self._fundPayAwardLv[var_32_0] and not self._fundPayAwardLv[var_32_0][iter_32_0] then
			return true
		end
	end

	return false
end

return GmFundData
