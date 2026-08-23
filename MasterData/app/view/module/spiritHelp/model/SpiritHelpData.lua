local var_0_0 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_1 = g.core.config.parameter_info
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_4 = g.core.config.spirit_help_info
local var_0_5 = g.core.common.ModuleUnlock
local SpiritHelpData = class("SpiritHelpData")
local var_0_7 = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_SPEED1] = 5,
	[g.core.const.ConstMgr.FUNCTION_TYPE.BATTLE_SPEED2] = 10
}

function SpiritHelpData:ctor()
	self:initData()
end

function SpiritHelpData:initData()
	self._curBattleSpeed = 1
	self._maxBattleSpeed = 1
	self._hasBattleSpeed = false
	self._battleSpeedParamValue = var_0_1.get(var_0_0.SPIRIT_HELP_BATTLE_PARAM).parameter
	self._allDoDict = {}
	self._allDoList = {}
	self._openDoList = {}
	self._battleDelta = 0.03333333333333333
	self._allDoBtn = false
	self._allLog = {}
	self._isLoadJson = false
	self._doJsonData = {}
	self._maxHistoryLogLength = var_0_1.get(var_0_0.SPIRIT_HELP_MAX_LOG_COUNT).parameter

	self:initDoing()
end

function SpiritHelpData:getMaxBattleSpeed()
	return self._maxBattleSpeed
end

function SpiritHelpData:getMaxHistoryLogLength()
	return self._maxHistoryLogLength
end

function SpiritHelpData:initDoing()
	for iter_5_0, iter_5_1 in var_0_4.ipairs() do
		local var_5_1 = require("app.view.module.spiritHelp.view.helps." .. (var_0_3.SCRIPT_DICT[iter_5_1.id] or "SpiritHelpDoingBase"))

		if var_5_1 then
			local var_5_2 = var_5_1.new(iter_5_1)

			self._allDoDict[iter_5_1.id] = var_5_2

			table.insert(self._allDoList, var_5_2)
		end
	end
end

function SpiritHelpData:onS2CGetInfo(arg_6_1)
	self:_updateStateByGetInfo(arg_6_1)

	self._openDoList = {}

	for iter_6_0, iter_6_1 in ipairs(self._allDoList) do
		if var_0_5:isFunctionUnlock(iter_6_1:getInfo().function_id) then
			iter_6_1:refreshState()
			table.insert(self._openDoList, iter_6_1)
		end
	end

	table.sort(self._openDoList, self:getDoSortFunc())

	if not self._isLoadJson then
		self._isLoadJson = true

		self:loadJsonData()
	end

	self:refreshAllDoBtnState()
	self:updateBattleSpeed()
end

function SpiritHelpData:_updateStateByGetInfo(arg_7_1)
	local var_7_0 = self:getDoById(var_0_3.HELP_ID.WUSH_TOWER)

	if var_7_0 then
		var_7_0:setServerCanDoState(arg_7_1.dead_tower_state or var_0_3.SERVER_STATE.FINISH)
	end

	local var_7_2 = self:getDoById(var_0_3.HELP_ID.WUSH)

	if var_7_2 then
		var_7_2:setServerCanDoState(arg_7_1.deadBattle_state or var_0_3.SERVER_STATE.FINISH)
	end

	local var_7_4 = self:getDoById(var_0_3.HELP_ID.GUILD_STATUE)

	if var_7_4 then
		var_7_4:setServerCanDoState(arg_7_1.guildStatue_state or var_0_3.SERVER_STATE.FINISH)
	end

	local var_7_6 = self:getDoById(var_0_3.HELP_ID.GUILD_TASK_GIFT)

	if var_7_6 then
		if arg_7_1.guildSendGift_state then
			var_7_6:setServerCanDoState(var_0_3.SERVER_STATE.NORMAL)
		else
			var_7_6:setServerCanDoState(var_0_3.SERVER_STATE.FINISH)
		end
	end

	local var_7_7 = self:getDoById(var_0_3.HELP_ID.GUILD_TASK_BOX)

	if var_7_7 then
		var_7_7:setServerCanDoState(arg_7_1.guild_worship_process_state or var_0_3.SERVER_STATE.FINISH)
	end
end

function SpiritHelpData:updateBattleSpeed()
	if var_0_5:isFunctionUnlock(var_0_2.BATTLE_SPEED2) then
		self._maxBattleSpeed = var_0_7[var_0_2.BATTLE_SPEED2]

		self:loadBattleSpeedJsonData()
	elseif var_0_5:isFunctionUnlock(var_0_2.BATTLE_SPEED1) then
		self._maxBattleSpeed = var_0_7[var_0_2.BATTLE_SPEED1]

		self:loadBattleSpeedJsonData()
	else
		self._hasBattleSpeed = true
		self._maxBattleSpeed = 1
		self._curBattleSpeed = 1
	end
end

function SpiritHelpData:loadBattleSpeedJsonData()
	local var_9_0 = g.core.common.Storage:load(var_0_3.SPIRIT_BATTLE_SPEED, true) or {}

	self._hasBattleSpeed = var_9_0.hasBattleSpeed ~= nil and var_9_0.hasBattleSpeed or true
	self._curBattleSpeed = var_9_0.curBattleSpeed or 1
end

function SpiritHelpData:loadJsonData()
	for iter_10_0, iter_10_1 in pairs(g.core.common.Storage:load(var_0_3.DO_JSON_NAME, true) or {}) do
		local var_10_0 = self:getDoById(tonumber(iter_10_0))

		if var_10_0 then
			var_10_0:setSelect(iter_10_1.isSelect)
			var_10_0:setMind(iter_10_1.isMind)

			if var_10_0:isLoadCount() then
				var_10_0:setCurCount(iter_10_1.curCount or 0)
			end
		end
	end

	self._allLog = self:getShowHistoryList(g.core.common.Storage:load(var_0_3.LOG_JSON_NAME, true) or {}, self:getMaxHistoryLogLength())
end

function SpiritHelpData:saveDoJsonData()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self._allDoList) do
		var_11_0[tostring(iter_11_1:getInfo().id)] = {
			isSelect = iter_11_1:isSelect(),
			isMind = iter_11_1:isMind(),
			curCount = iter_11_1:getCurCount()
		}
	end

	g.core.common.Storage:save(var_0_3.DO_JSON_NAME, var_11_0)
end

function SpiritHelpData:saveSpeedJsonData()
	g.core.common.Storage:save(var_0_3.SPIRIT_BATTLE_SPEED, {
		hasBattleSpeed = self._hasBattleSpeed,
		curBattleSpeed = self._curBattleSpeed
	})
end

function SpiritHelpData:saveLogJsonData()
	g.core.common.Storage:save(var_0_3.LOG_JSON_NAME, (self:getShowHistoryList(self._allLog, self:getMaxHistoryLogLength())))
end

function SpiritHelpData:getShowHistoryList(arg_14_1, arg_14_2)
	table.sort(arg_14_1, function(arg_15_0, arg_15_1)
		return (arg_15_0.time or 0) < (arg_15_1.time or 0)
	end)

	if arg_14_2 >= #arg_14_1 then
		return arg_14_1
	end

	return self:updateListLength(arg_14_1, #arg_14_1 - arg_14_2 + 1, #arg_14_1)
end

function SpiritHelpData:updateListLength(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if arg_16_2 <= iter_16_0 and iter_16_0 <= arg_16_3 then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function SpiritHelpData:hasBattleSpeed()
	return self._hasBattleSpeed
end

function SpiritHelpData:setHasBattleSpeed(arg_18_1)
	self._hasBattleSpeed = arg_18_1 == true
end

function SpiritHelpData:getBattleSpeedParamValue()
	return self._battleSpeedParamValue * 0.01
end

function SpiritHelpData:getBattleSpeed()
	return math.clamp(self._curBattleSpeed, 1, self._maxBattleSpeed)
end

function SpiritHelpData:setBattleSpeed(arg_21_1)
	self._curBattleSpeed = arg_21_1
end

function SpiritHelpData:getDoById(arg_22_1)
	return self._allDoDict[arg_22_1]
end

function SpiritHelpData:getAllOpenDoList()
	return self._openDoList
end

function SpiritHelpData:getAllCostList()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs((self:getAllOpenDoList())) do
		if iter_24_1:isSelect() and iter_24_1:getState() == var_0_3.STATE.NORMAL then
			local var_24_1 = iter_24_1:getCountCostItem()

			if var_24_1 and next(var_24_1) and var_24_1.size > 0 then
				table.insert(var_24_0, iter_24_1:getCountCostItem())
			end
		end
	end

	return self:mergeSameItem(var_24_0)
end

function SpiritHelpData:getAllDoBtn()
	return self._allDoBtn
end

function SpiritHelpData:setAllDoIsSelect(arg_26_1)
	self._allDoBtn = arg_26_1

	for iter_26_0, iter_26_1 in ipairs(self:getAllOpenDoList()) do
		if iter_26_1:getState() == var_0_3.STATE.NORMAL then
			iter_26_1:setSelect(arg_26_1)
		end
	end
end

function SpiritHelpData:getDoSortFunc()
	return function(arg_28_0, arg_28_1)
		return arg_28_0:getInfo().id < arg_28_1:getInfo().id
	end
end

function SpiritHelpData:getCurDoingList()
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in ipairs(self._openDoList) do
		if iter_29_1:isSelect() and iter_29_1:getState() == var_0_3.STATE.NORMAL then
			table.insert(var_29_0, iter_29_1)
		end
	end

	return var_29_0
end

function SpiritHelpData:addLogByLog(arg_30_1)
	table.insert(self._allLog, arg_30_1)

	if #self._allLog >= self._maxHistoryLogLength * 2 then
		self._allLog = self:updateListLength(self._allLog, self._maxHistoryLogLength, #self._allLog)
	end
end

function SpiritHelpData:getAllLogList()
	return self._allLog
end

function SpiritHelpData:mergeSameItem(arg_32_1)
	if not arg_32_1 then
		return
	end

	local var_32_0 = {}
	local var_32_1 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		if iter_32_1.size and iter_32_1.size > 0 then
			if var_32_1[iter_32_1.type .. "_" .. iter_32_1.value] then
				var_32_0[var_32_1[iter_32_1.type .. "_" .. iter_32_1.value]].size = var_32_0[var_32_1[iter_32_1.type .. "_" .. iter_32_1.value]].size + iter_32_1.size
			else
				table.insert(var_32_0, {
					type = iter_32_1.type,
					value = iter_32_1.value,
					size = iter_32_1.size
				})

				var_32_1[iter_32_1.type .. "_" .. iter_32_1.value] = #var_32_0
			end
		end
	end

	return var_32_0
end

function SpiritHelpData:getBattleDeltaValue()
	return self._battleDelta
end

function SpiritHelpData:setBattleDeltaValue(arg_34_1)
	self._battleDelta = arg_34_1
end

function SpiritHelpData:refreshAllDoBtnState()
	local var_35_0 = false
	local var_35_1 = true

	for iter_35_0, iter_35_1 in ipairs(self._openDoList) do
		if iter_35_1:getState() == var_0_3.STATE.NORMAL then
			var_35_0 = true

			if not iter_35_1:isSelect() then
				var_35_1 = false

				break
			end
		end
	end

	self._allDoBtn = var_35_0 and var_35_1
end

return SpiritHelpData
