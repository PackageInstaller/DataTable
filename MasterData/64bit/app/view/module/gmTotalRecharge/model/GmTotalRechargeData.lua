local GmTotalRechargeConst = require("app.view.module.gmTotalRecharge.const.GmTotalRechargeConst")
local var_0_1 = GmTotalRechargeConst.ActType
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.config.recharge_total_info
local var_0_4 = g.core.config.recharge_total_group_info
local GmTotalRechargeData = class("GmTotalRechargeData")

function GmTotalRechargeData:ctor()
	self:initData()
end

function GmTotalRechargeData:initData()
	self._startTime = 0
	self._endTime = 0
	self._activityId = 0
	self._rechargeId = 0
	self._rechargeMoney = 0
	self._rechargeGroupInfo = {}
	self._gmRechargeTotalInfoDict = {}
	self._taskInfoDict = {}
	self._gmTotalRechargeGotAwardIdArr = {}
end

function GmTotalRechargeData:onS2CGetGMTotalRechargeInfo(arg_3_1)
	if not arg_3_1.infos then
		return
	end

	local var_3_0 = arg_3_1.infos[1] or {}

	self._activityId = var_3_0.activity_id or 0
	self._rechargeId = var_3_0.recharge_id or 0
	self._startTime = var_3_0.start_time or 0
	self._endTime = var_3_0.end_time or 0
	self._rechargeGroupInfo = {}

	for iter_3_0, iter_3_1 in var_0_4.ipairs() do
		if iter_3_1.recharge_id == self._rechargeId then
			self._rechargeGroupInfo = iter_3_1

			break
		end
	end

	self._gmRechargeTotalInfoDict = {}

	for iter_3_2, iter_3_3 in ipairs((var_0_3.match("recharge_id", self._rechargeId))) do
		self._gmRechargeTotalInfoDict[iter_3_3.id] = {
			curValue = 0,
			info = iter_3_3,
			awardState = GmTotalRechargeConst.AwardState.NOT_REACH,
			awardInfoArr = self:_getTVSAwardInfoArr(var_0_3, iter_3_3)
		}
	end

	self:_updateGmTotalRechargeAwardState()

	self._taskInfoDict = {}

	local var_3_1 = self:getTotalRechargeActType()

	if var_3_1 == var_0_1.DRAW_CARD or var_3_1 == var_0_1.RECHARGE_AND_DRAW_CARD then
		local var_3_2 = g.core.config.recharge_total_group_task_info

		for iter_3_4, iter_3_5 in ipairs((g.core.config.recharge_total_group_task_info.match("recharge_id", self._rechargeId))) do
			self._taskInfoDict[iter_3_5.id] = {
				curValue = 0,
				info = iter_3_5,
				awardState = GmTotalRechargeConst.AwardState.NOT_REACH,
				awardInfoArr = self:_getTVSAwardInfoArr(var_3_2, iter_3_5)
			}
		end

		g.core.network.GameNetProxy:send_C2S_Recharge_GetGMTotalRechargeTaskData({})
	end
end

function GmTotalRechargeData:onS2CGetGMTotalRechargeTaskData(arg_4_1)
	if self._activityId ~= arg_4_1.activity_id then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.infos or {}) do
		local var_4_0 = self._taskInfoDict[iter_4_1.task_id]

		if self._taskInfoDict[iter_4_1.task_id] then
			local var_4_1 = GmTotalRechargeConst.AwardState.NOT_REACH

			if iter_4_1.is_award then
				var_4_1 = GmTotalRechargeConst.AwardState.GOT
			elseif iter_4_1.task_value >= var_4_0.info.task_value then
				var_4_1 = GmTotalRechargeConst.AwardState.CAN_GET
			end

			var_4_0.awardState = var_4_1
			var_4_0.curValue = iter_4_1.task_value
		else
			g.core.log:info("---------   RcvTaskData ==》   Task not found with id: ", iter_4_1.task_id)
		end
	end
end

function GmTotalRechargeData:onS2CGetRecharge(arg_5_1)
	if self._activityId ~= arg_5_1.activity_id then
		return
	end

	self._gmTotalRechargeGotAwardIdArr = arg_5_1.ids or {}
	self._rechargeMoney = arg_5_1.recharge_money or 0

	self:_updateGmTotalRechargeAwardState()
end

function GmTotalRechargeData:onS2CGetGMTotalRechargeAward(arg_6_1)
	if self._activityId == arg_6_1.activity_id then
		if self._gmRechargeTotalInfoDict[arg_6_1.id] then
			self._gmRechargeTotalInfoDict[arg_6_1.id].awardState = GmTotalRechargeConst.AwardState.GOT
		end
	end
end

function GmTotalRechargeData:onS2CGetGMTotalRechargeTaskAward(arg_7_1)
	if self._activityId == arg_7_1.activity_id then
		if self._taskInfoDict[arg_7_1.task_id] then
			self._taskInfoDict[arg_7_1.task_id].awardState = GmTotalRechargeConst.AwardState.GOT
		else
			g.core.log:info("---------   GetTaskAward ==》   Task not found with id: ", arg_7_1.task_id)
		end
	end
end

function GmTotalRechargeData:onS2CActionStatusFlush(arg_8_1)
	local var_8_0 = arg_8_1.status or 0

	for iter_8_0, iter_8_1 in pairs(self._taskInfoDict) do
		if iter_8_1.info.task_type == arg_8_1.id then
			if iter_8_1.awardState ~= GmTotalRechargeConst.AwardState.GOT then
				iter_8_1.awardState = var_8_0 < iter_8_1.info.task_value and GmTotalRechargeConst.AwardState.NOT_REACH or GmTotalRechargeConst.AwardState.CAN_GET
			end

			iter_8_1.curValue = var_8_0
		end
	end
end

function GmTotalRechargeData:_updateGmTotalRechargeAwardState()
	for iter_9_0, iter_9_1 in ipairs(self._gmTotalRechargeGotAwardIdArr) do
		if self._gmRechargeTotalInfoDict[iter_9_1] then
			self._gmRechargeTotalInfoDict[iter_9_1].awardState = GmTotalRechargeConst.AwardState.GOT
		else
			g.core.log:info("---------   onS2CGetRecharge ==》   RechargeTotalInfo not found with id: ", iter_9_1)
		end
	end

	for iter_9_2, iter_9_3 in pairs(self._gmRechargeTotalInfoDict) do
		if iter_9_3.awardState ~= GmTotalRechargeConst.AwardState.GOT then
			iter_9_3.awardState = self._rechargeMoney < iter_9_3.info.num and GmTotalRechargeConst.AwardState.NOT_REACH or GmTotalRechargeConst.AwardState.CAN_GET
		end

		iter_9_3.curValue = self._rechargeMoney
	end
end

function GmTotalRechargeData:isExistTaskNotFinish()
	for iter_10_0, iter_10_1 in pairs(self._gmRechargeTotalInfoDict) do
		if iter_10_1.awardState ~= GmTotalRechargeConst.AwardState.GOT then
			return true
		end
	end

	local var_10_0 = self:getTotalRechargeActType()

	if var_10_0 == var_0_1.DRAW_CARD or var_10_0 == var_0_1.RECHARGE_AND_DRAW_CARD then
		for iter_10_2, iter_10_3 in pairs(self._taskInfoDict) do
			if iter_10_3.awardState ~= GmTotalRechargeConst.AwardState.GOT then
				return true
			end
		end
	end

	return false
end

function GmTotalRechargeData:isExistTotalRechargeAwardCanGet()
	for iter_11_0, iter_11_1 in pairs(self._gmRechargeTotalInfoDict) do
		if iter_11_1.awardState == GmTotalRechargeConst.AwardState.CAN_GET then
			return true
		end
	end

	return false
end

function GmTotalRechargeData:isExistTaskAwardCanGet()
	for iter_12_0, iter_12_1 in pairs(self._taskInfoDict) do
		if iter_12_1.awardState == GmTotalRechargeConst.AwardState.CAN_GET then
			return true
		end
	end

	return false
end

function GmTotalRechargeData:isNewGmTotalRechargeActivity()
	return not table.indexof(g.core.common.Storage:load(GmTotalRechargeConst.JSON_NAME, true) or {}, self._activityId)
end

function GmTotalRechargeData:saveNewGmTotalRechargeActivity()
	local var_14_0 = g.core.common.Storage:load(GmTotalRechargeConst.JSON_NAME, true) or {}

	if not table.indexof(var_14_0, self._activityId) then
		table.insert(var_14_0, self._activityId)
		g.core.common.Storage:save(GmTotalRechargeConst.JSON_NAME, var_14_0, true)
	end
end

function GmTotalRechargeData:isGmTotalRechargeOpen(arg_15_1)
	if arg_15_1 ~= self._rechargeId then
		return false
	elseif not g.core.common.ModuleUnlock:isModuleUnlock(var_0_2.GM_TOTAL_RECHARGE) then
		return false
	end

	if g.core.model.User.totalRechargeData:isTotalChargeOpen() then
		local var_15_0 = self:getTotalRechargeActType()

		if var_15_0 == var_0_1.RECHARGE or var_15_0 == var_0_1.RECHARGE_AND_DRAW_CARD then
			return false
		end
	end

	local var_15_1 = g.core.common.ServerTime:getTime()

	if var_15_1 < self._startTime or var_15_1 > self._endTime then
		return false
	else
		return self:isExistTaskNotFinish()
	end
end

function GmTotalRechargeData:getGmRechargeTotalInfoArr()
	return table.values(self._gmRechargeTotalInfoDict)
end

function GmTotalRechargeData:getTaskInfoArr()
	return table.values(self._taskInfoDict)
end

function GmTotalRechargeData:getSortFunc()
	return function(arg_19_0, arg_19_1)
		if arg_19_0.awardState ~= arg_19_1.awardState then
			return arg_19_0.awardState < arg_19_1.awardState
		else
			return arg_19_0.info.id < arg_19_1.info.id
		end
	end
end

function GmTotalRechargeData:getGmTotalRechargeId()
	return self._rechargeId
end

function GmTotalRechargeData:getGmTotalRechargeActivityId()
	return self._activityId
end

function GmTotalRechargeData:getGmTotalRechargeEndTime()
	return self._endTime
end

function GmTotalRechargeData:getGmTotalRechargeGroupInfo()
	return self._rechargeGroupInfo
end

function GmTotalRechargeData:getTotalRechargeActType()
	return self._rechargeGroupInfo.activity_type or var_0_1.RECHARGE
end

function GmTotalRechargeData:getTopBarTitle()
	return g.core.model.User.homeData:getActivityTopBarTitle(g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.GMTOTAL_RECHARGE, self._rechargeId)
end

function GmTotalRechargeData:_getTVSAwardInfoArr(arg_26_1, arg_26_2)
	local var_26_0 = {}
	local var_26_1 = 1

	while arg_26_1.hasKey("reward_type_" .. 1) do
		if arg_26_2["reward_type_" .. 1] > 0 then
			table.insert(var_26_0, {
				type = arg_26_2["reward_type_" .. 1],
				value = arg_26_2["reward_value_" .. var_26_1],
				size = arg_26_2["reward_size_" .. var_26_1]
			})
		end

		var_26_1 = var_26_1 + 1
	end

	return var_26_0
end

return GmTotalRechargeData
