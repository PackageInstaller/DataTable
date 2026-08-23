local LotteryConst = require("app.view.module.lottery.const.LotteryConst")
local LotteryData = class("LotteryData")

function LotteryData:ctor()
	self:initData()
end

function LotteryData:initData()
	self._baseDic = {}
	self._taskInfoDic = {}
	self._poolInfoDic = {}
	self._mapDic = {}
	self._dropDic = {}
	self._curBaseId = 0
	self._curPool = 0
	self._rareId = 0
	self._turnFlag = false
	self._lastCacheTime = -1
	self._isFirstReq = true
end

function LotteryData:_initMapGridList(arg_3_1)
	local var_3_0 = {}

	for iter_3_0 = 1, LotteryConst.MAP_GRID_COUNT do
		local var_3_1 = g.core.config.lottery_poolmap_info.get(iter_3_0, arg_3_1)
		local var_3_2 = {
			id = var_3_1.id,
			type = var_3_1.grid_type
		}

		if var_3_1.grid_type ~= 0 then
			var_3_2.state = LotteryConst.GRID_STATE.MASK or LotteryConst.GRID_STATE.NONE
		end

		var_3_2.rewardInfo = {}
		var_3_2.cfg = var_3_1
		var_3_0[iter_3_0] = var_3_2
	end

	self._mapDic[arg_3_1] = var_3_0
end

function LotteryData:_resetMapInfo(arg_4_1)
	local var_4_0 = self:getMapInfo(arg_4_1)

	if not var_4_0 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1.cfg.grid_type ~= 0 then
			iter_4_1.state = LotteryConst.GRID_STATE.MASK or LotteryConst.GRID_STATE.NONE
		end

		iter_4_1.rewardInfo = {}
	end
end

function LotteryData:getMapInfo(arg_5_1)
	if not self._mapDic[arg_5_1] then
		self:_initMapGridList(arg_5_1)
	end

	return self._mapDic[arg_5_1]
end

function LotteryData:_initPoolInfo(arg_6_1)
	local var_6_0 = g.core.config.lottery_pool_info.get(arg_6_1)

	self._poolInfoDic[arg_6_1] = {
		cfg = var_6_0,
		mapInfo = self:getMapInfo(var_6_0.map_id),
		dropInfo = self:getDropInfo(var_6_0.pool_id)
	}
end

function LotteryData:_getPoolInfo(arg_7_1)
	if not arg_7_1 or arg_7_1 == 0 then
		return
	end

	if not self._poolInfoDic[arg_7_1] then
		self:_initPoolInfo(arg_7_1)
	end

	return self._poolInfoDic[arg_7_1]
end

function LotteryData:_initTaskInfoList(arg_8_1)
	local var_8_0 = {}

	for iter_8_0 = 1, g.core.config.lottery_task_info.getLength() do
		local var_8_1 = g.core.config.lottery_task_info.indexOf(iter_8_0)

		if var_8_1.group == arg_8_1 then
			var_8_0[#var_8_0 + 1] = {
				curValue = 0,
				receiveNum = 0,
				cfg = var_8_1,
				receiveLimit = var_8_1.frequency
			}
		end
	end

	self._taskInfoDic[arg_8_1] = var_8_0
end

function LotteryData:getTaskInfoList(arg_9_1)
	if not self._taskInfoDic[arg_9_1] then
		self:_initTaskInfoList(arg_9_1)
	end

	return self._taskInfoDic[arg_9_1]
end

function LotteryData:_updateTaskValue(arg_10_1)
	local var_10_0 = self:getCurBaseInfo()

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_1

		for iter_10_2, iter_10_3 in ipairs(var_10_0.taskInfoList) do
			if iter_10_3.cfg.id == iter_10_1.id then
				var_10_1 = iter_10_3

				break
			end
		end

		var_10_1.curValue = iter_10_1.status
	end

	self:_sortTaskInfoList(var_10_0.taskInfoList)
end

function LotteryData:_updateTaskReceive(arg_11_1, arg_11_2)
	local var_11_0 = self:getCurBaseInfo()

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_1

		for iter_11_2, iter_11_3 in ipairs(var_11_0.taskInfoList) do
			if iter_11_3.cfg.id == iter_11_1.id then
				var_11_1 = iter_11_3

				break
			end
		end

		var_11_1.receiveNum = arg_11_2 and var_11_1.receiveNum + iter_11_1.num or iter_11_1.num
	end

	self:_sortTaskInfoList(var_11_0.taskInfoList)
end

function LotteryData:_resetTaskInfoList(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		iter_12_1.curValue = 0
		iter_12_1.receiveNum = 0
	end
end

function LotteryData:_sortTaskInfoList(arg_13_1)
	table.sort(arg_13_1, function(arg_14_0, arg_14_1)
		if arg_14_0.receiveNum >= arg_14_0.receiveLimit ~= (arg_14_1.receiveNum >= arg_14_1.receiveLimit) then
			return arg_14_0.receiveNum < arg_14_0.receiveLimit
		end

		return arg_14_0.cfg.order < arg_14_1.cfg.order
	end)
end

function LotteryData:_initBaseInfo(arg_15_1)
	local var_15_0 = g.core.config.lottery_info.get(arg_15_1)

	self._baseDic[arg_15_1] = {
		cfg = var_15_0,
		activityInfo = {},
		taskInfoList = self:getTaskInfoList(var_15_0.task_group)
	}
end

function LotteryData:_updateBaseInfoByActivityInfo(arg_16_1, arg_16_2)
	self:getBaseInfo(arg_16_1).activityInfo = arg_16_2
end

function LotteryData:getBaseInfo(arg_17_1)
	if not arg_17_1 or arg_17_1 == 0 then
		return
	end

	if not self._baseDic[arg_17_1] then
		self:_initBaseInfo(arg_17_1)
	end

	return self._baseDic[arg_17_1]
end

function LotteryData:getCurBaseInfo()
	return self:getBaseInfo(self._curBaseId)
end

function LotteryData:_initDropInfo(arg_19_1)
	local var_19_0 = {
		list = {}
	}

	for iter_19_0 = 1, g.core.config.lottery_drop_info.getLength() do
		local var_19_1 = g.core.config.lottery_drop_info.indexOf(iter_19_0)

		if var_19_1.pool_id == arg_19_1 then
			local var_19_2 = g.core.common.Drops:getGoodsArray(var_19_1.drop_id)

			for iter_19_1, iter_19_2 in ipairs(var_19_2) do
				if var_19_1.rare == 1 then
					table.insert(var_19_0.list, 1, iter_19_2)
				else
					table.insert(var_19_0.list, iter_19_2)
				end
			end

			if var_19_1.rare == 1 then
				var_19_0.rareAward = var_19_2[1]
			end
		end
	end

	self._dropDic[arg_19_1] = var_19_0
end

function LotteryData:getDropInfo(arg_20_1)
	if not self._dropDic[arg_20_1] then
		self:_initDropInfo(arg_20_1)
	end

	return self._dropDic[arg_20_1]
end

function LotteryData:getCurPoolInfo()
	return self:_getPoolInfo(self._curPool)
end

function LotteryData:getRandomGridId()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(self:_getPoolInfo(self._curPool).mapInfo) do
		if iter_22_1.state == LotteryConst.GRID_STATE.MASK then
			table.insert(var_22_0, iter_22_0)
		end
	end

	if #var_22_0 > 0 then
		return var_22_0[math.random(1, #var_22_0)]
	else
		return 0
	end
end

function LotteryData:getRareGridID()
	return self._rareId
end

function LotteryData:hasLotteryActivity()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.LOTTERY) then
		return false
	end

	local var_24_0 = self:getCurBaseInfo()
	local var_24_1

	if not var_24_0 or not var_24_0.activityInfo then
		do return false end

		var_24_1 = g.core.common.ServerTime:getTime()
	end

	return var_24_1 < var_24_0.activityInfo.end_time
end

function LotteryData:_updateGridInfoByDropInfo(arg_25_1)
	local var_25_0 = self:getCurPoolInfo().mapInfo[arg_25_1.grid_id]

	var_25_0.rewardInfo = arg_25_1.awards
	var_25_0.state = LotteryConst.GRID_STATE.REWARDED
end

function LotteryData:canReceiveTaskReward()
	local var_26_0

	if not self:hasLotteryActivity() then
		do return end

		var_26_0 = false
	end

	for iter_26_0, iter_26_1 in ipairs(self:getCurBaseInfo().taskInfoList) do
		if iter_26_1.receiveNum < iter_26_1.receiveLimit and iter_26_1.curValue >= (iter_26_1.receiveNum + 1) * iter_26_1.cfg.value then
			var_26_0 = true

			break
		end
	end

	return var_26_0
end

function LotteryData:canDraw()
	if not self:hasLotteryActivity() then
		return
	end

	return g.core.model.User.resourceData:getResourceById(LotteryConst.COST_ID) > 0
end

function LotteryData:setTurnTipFlag(arg_28_1)
	self._turnFlag = arg_28_1
end

function LotteryData:getTurnTipFlag()
	return self._turnFlag
end

function LotteryData:isNewActivity()
	if not self:hasLotteryActivity() then
		return false
	end

	if self._lastCacheTime < 0 then
		self:checkAndLoadActivityCache()
	end

	return self:getCurBaseInfo().activityInfo.end_time ~= self._lastCacheTime
end

function LotteryData:saveNewActivity()
	local var_31_0 = self:getCurBaseInfo().activityInfo

	if var_31_0.end_time ~= self._lastCacheTime then
		g.core.common.Storage:save("new_lottery.json", {
			lastFinishTime = var_31_0.end_time
		}, true)

		self._lastCacheTime = var_31_0.end_time
	end
end

function LotteryData:checkAndLoadActivityCache()
	self._lastCacheTime = (g.core.common.Storage:load("new_lottery.json", true) or {
		lastFinishTime = 0
	}).lastFinishTime
end

function LotteryData:hasReqInfo()
	return not self._isFirstReq
end

function LotteryData:onS2CLotteryGetInfo(arg_34_1)
	self._isFirstReq = false

	if arg_34_1.lottery == nil then
		return
	end

	self._curBaseId = arg_34_1.activity_info.sub_id

	self:_initBaseInfo(self._curBaseId)
	self:_resetTaskInfoList(self:getCurBaseInfo().taskInfoList)
	self:_updateBaseInfoByActivityInfo(self._curBaseId, arg_34_1.activity_info)

	self._curPool = arg_34_1.lottery.pool_id
	self._rareId = arg_34_1.lottery.rare_grid_id

	for iter_34_0, iter_34_1 in ipairs(arg_34_1.lottery.lottery_drops or {}) do
		self:_updateGridInfoByDropInfo(iter_34_1)
	end

	self:_updateTaskValue(arg_34_1.tasks or {})
	self:_updateTaskReceive(arg_34_1.task_awarded or {})
end

function LotteryData:onS2CLotteryDraw(arg_35_1)
	self:_updateGridInfoByDropInfo(arg_35_1)

	if arg_35_1.is_rare then
		self._rareId = arg_35_1.grid_id
	end
end

function LotteryData:onS2CLotteryNextPool(arg_36_1)
	self._curPool = arg_36_1.pool_id
	self._rareId = 0

	self:_resetMapInfo(g.core.config.lottery_pool_info.get(self._curPool).map_id)
end

function LotteryData:onS2CLotteryTaskAward(arg_37_1)
	self:_updateTaskReceive({
		{
			id = arg_37_1.task_id,
			num = arg_37_1.num
		}
	}, true)
end

function LotteryData:onS2CActionStatusFlush(arg_38_1)
	if not self:hasLotteryActivity() then
		return
	end

	self:_updateTaskValue({
		arg_38_1.status
	})
end

return LotteryData
