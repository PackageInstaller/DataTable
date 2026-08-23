local var_0_0 = g.core.const.ConstMgr.ActivityConst
local var_0_1 = g.core.model.User.activityDataManager
local var_0_2 = g.core.config.recharge_total_info
local var_0_3 = require("app.view.module.totalRecharge.model.TotalRechargeConst").AWARD_STATE
local TotalRechargeData = class("TotalRechargeData")

function TotalRechargeData:ctor()
	self:initData()
end

function TotalRechargeData:initData()
	self._totalActivityCharge = 0

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in var_0_2.ipairs() do
		if iter_2_1.recharge_id == 0 then
			table.insert(var_2_0, {
				info = iter_2_1,
				drawState = var_0_3.CAN_NOT_GET
			})
		end
	end

	self._rechargeTotalInfo = var_2_0
end

function TotalRechargeData:updateInfo(arg_3_1)
	local var_3_0 = arg_3_1.recharge_money or 0

	self._totalActivityCharge = var_3_0

	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.ids or {}) do
		var_3_1[iter_3_1] = true
	end

	for iter_3_2, iter_3_3 in ipairs(self._rechargeTotalInfo) do
		if var_3_0 >= iter_3_3.info.num then
			iter_3_3.drawState = var_3_1[iter_3_3.info.id] and var_0_3.HAS_GET or var_0_3.CAN_GET
		end
	end

	self:_sortData()
end

function TotalRechargeData:updateOpInfo(arg_4_1)
	if arg_4_1 and arg_4_1.insert and arg_4_1.insert.recharge_money then
		self:updateInfo(arg_4_1.insert)
	end
end

function TotalRechargeData:onS2CGetTotalRechargeAward(arg_5_1)
	if arg_5_1 and arg_5_1.id then
		for iter_5_0, iter_5_1 in ipairs(self._rechargeTotalInfo) do
			if iter_5_1.info.id == arg_5_1.id then
				iter_5_1.drawState = var_0_3.HAS_GET

				break
			end
		end

		self:_sortData()
	end
end

function TotalRechargeData:getActivityData(arg_6_1)
	if arg_6_1 then
		local var_6_0 = var_0_1:getConfigTableActivityData(var_0_0.ACTIVITY_TYPE.TOTAL_RECHARGE, arg_6_1)

		if var_6_0 and var_6_0:isOpen() then
			return var_6_0
		end
	else
		return var_0_1:getConfigTableActDataByFilter(handler(self, self._activityDataFilter))
	end
end

function TotalRechargeData:_activityDataFilter(arg_7_1)
	if arg_7_1:getActivityType() ~= var_0_0.ACTIVITY_TYPE.TOTAL_RECHARGE then
		return false
	elseif not arg_7_1:isOpen() then
		return false
	else
		return true
	end
end

function TotalRechargeData:getInfoArr()
	return self._rechargeTotalInfo
end

function TotalRechargeData:isHasRewardCanGet()
	if self:getActivityData() then
		for iter_9_0, iter_9_1 in ipairs(self._rechargeTotalInfo) do
			if iter_9_1.drawState == var_0_3.CAN_GET then
				return true
			end
		end
	end

	return false
end

function TotalRechargeData:_sortData()
	table.sort(self._rechargeTotalInfo, function(arg_11_0, arg_11_1)
		if arg_11_0.drawState ~= arg_11_1.drawState then
			return arg_11_0.drawState < arg_11_1.drawState
		end

		return arg_11_0.info.id < arg_11_1.info.id
	end)
end

function TotalRechargeData:getActivityTotalRecharge()
	return self._totalActivityCharge
end

function TotalRechargeData:isTotalChargeCanShow(arg_13_1)
	if self:getActivityData(arg_13_1) then
		for iter_13_0, iter_13_1 in ipairs(self._rechargeTotalInfo) do
			if iter_13_1.drawState ~= var_0_3.HAS_GET then
				return true
			end
		end
	end

	return false
end

function TotalRechargeData:isTotalChargeOpen()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.TOTAL_RECHARGE) then
		return false
	end

	local var_14_0 = false

	for iter_14_0, iter_14_1 in ipairs(self._rechargeTotalInfo) do
		if iter_14_1.drawState ~= var_0_3.HAS_GET then
			var_14_0 = true

			break
		end
	end

	if not var_14_0 then
		return false
	end

	return checkbool((var_0_1:getConfigTableActDataByFilter(function(arg_15_0)
		if arg_15_0:getActivityType() == var_0_0.ACTIVITY_TYPE.TOTAL_RECHARGE then
			return arg_15_0:isDuringOpening()
		end
	end)))
end

return TotalRechargeData
