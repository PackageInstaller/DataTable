local RobTreasureData = class("RobTreasureData", require("app.core.model.BaseData"))

function RobTreasureData:ctor()
	self:initData()
end

function RobTreasureData:initData()
	RobTreasureData.super.ctor(self)

	self._lastFreshTime = 0
	self._treasureList = {}
	self._isRobSuccess = false
	self._hasDta = false
	self._redTotal = 0
	self._isCompose = false
end

function RobTreasureData:recordComposeFlag()
	self._isCompose = true
end

function RobTreasureData:clearComposeFlag()
	self._isCompose = false
end

function RobTreasureData:getComposeFlag()
	return self._isCompose
end

function RobTreasureData:setSkipBattle(arg_6_1)
	g.core.common.Storage:save("rob_config.json", {
		isSkip = arg_6_1
	})
end

function RobTreasureData:getSkipBattle()
	local var_7_0 = g.core.common.Storage:load("rob_config.json") or {}

	if var_7_0.isSkip then
		return var_7_0.isSkip
	else
		if var_7_0.isSkip == false then
			return false
		end

		return true
	end
end

function RobTreasureData:setAutoUse(arg_8_1)
	g.core.common.Storage:save("rob_auto_use_config.json", {
		isAutoUse = arg_8_1
	})
end

function RobTreasureData:getAutoUse()
	local var_9_0 = g.core.common.Storage:load("rob_auto_use_config.json") or {}

	if var_9_0.isAutoUse ~= nil then
		return var_9_0.isAutoUse
	else
		return true
	end
end

function RobTreasureData:setFirstEnter(arg_10_1)
	g.core.common.Storage:save("rob_list_config.json", {
		isEnter = arg_10_1
	})
end

function RobTreasureData:getFirstEnter()
	return not checkbool((g.core.common.Storage:load("rob_list_config.json") or {}).isEnter)
end

function RobTreasureData:setFreshTime(arg_12_1)
	self._lastFreshTime = arg_12_1
end

function RobTreasureData:getFreshTime()
	return self._lastFreshTime
end

function RobTreasureData:setTreasureList(arg_14_1)
	self._treasureList = arg_14_1
end

function RobTreasureData:getTreasureList()
	return self._treasureList
end

function RobTreasureData:setRobFlag(arg_16_1)
	self._isRobSuccess = arg_16_1
end

function RobTreasureData:getRobFlag()
	return self._isRobSuccess
end

function RobTreasureData:getScoreShopInfoById(arg_18_1)
	for iter_18_0 = 1, g.core.config.shop_score_info.getLength() do
		local var_18_0 = g.core.config.shop_score_info.indexOf(iter_18_0)

		if var_18_0.type == 3 and var_18_0.value == arg_18_1 then
			return var_18_0
		end
	end
end

function RobTreasureData:getComposeRedTotal()
	return self._redTotal
end

function RobTreasureData:updateComposeRedTotal(arg_20_1)
	self._redTotal = arg_20_1
end

function RobTreasureData:getCanRobTreasureCount()
	return #g.core.config.treasure_info.match(function(arg_22_0)
		return arg_22_0.contend_type ~= 0
	end)
end

function RobTreasureData:setBattleData(arg_23_1)
	self._battleData = arg_23_1
end

function RobTreasureData:getBattleData()
	return self._battleData
end

function RobTreasureData:isTaskAwardCanGet()
	local var_25_0 = g.core.model.User.taskData:getTaskInfoByModuleId(g.core.const.ConstMgr.TaskConst.MODULE_ID.ROB)

	for iter_25_0, iter_25_1 in ipairs((g.core.config.action_task_info.match(function(arg_26_0)
		return arg_26_0.module == 2
	end))) do
		if iter_25_1.reset_time == 2 and not var_25_0.dailyAwards[iter_25_1.id] and (var_25_0.dailyTasks[iter_25_1.require_type] or 0) >= iter_25_1.require_value then
			return true
		end
	end

	return false
end

return RobTreasureData
