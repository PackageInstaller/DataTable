local var_0_0 = g.core.config.monopoly_grid_info
local var_0_1 = g.core.config.monopoly_info
local var_0_2 = g.core.config.cultivate_activity_info
local var_0_3 = g.core.config.monopoly_node_info
local MonopolyConst = require("app.view.module.monopoly.const.MonopolyConst")
local MonopolyData = class("MonopolyData")

function MonopolyData:ctor(arg_1_1)
	self:initData()

	if arg_1_1 then
		self:updateMapData(arg_1_1)
	end
end

function MonopolyData:initData()
	self._activityCfg = nil
	self._mapGroup = 0
	self._rewardGroup = 0
	self._gridEventMap = {}
	self._activityId = 0
	self._curIndex = 1
	self._nextDiceNum = 0
	self._specialGridId = 0
	self._curScore = 0
	self._sumDiceNum = 0
	self._rewardIds = {}
	self._rewardNodes = {}
	self._nodeIndex = {}
	self._gridData = {}
end

function MonopolyData:onGetMonopolyInfo(arg_3_1)
	self:updateMapData(arg_3_1)

	self._isSvrData = true
end

function MonopolyData:onMonopolyRollDice(arg_4_1)
	if arg_4_1.map_data then
		self:updateMapData(arg_4_1.map_data)
	end
end

function MonopolyData:getOneStepMoveSize(arg_5_1, arg_5_2)
	local var_5_0 = 0 + arg_5_1.dice

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.events) do
		if iter_5_1.tp == 0 then
			local var_5_1 = var_0_0.get(iter_5_1.grid_id)

			if var_5_1.type == MonopolyConst.EVENT_TYPE.FRONT_GRIDS or var_5_1.type == MonopolyConst.EVENT_TYPE.BEHIND_GRIDS then
				if self._gridEventMap[var_5_1.type] then
					var_5_0 = self._gridEventMap[var_5_1.type][iter_5_1.level].type == MonopolyConst.EVENT_TYPE.FRONT_GRIDS and var_5_0 + self._gridEventMap[var_5_1.type][iter_5_1.level].value or var_5_0 - self._gridEventMap[var_5_1.type][iter_5_1.level].value
				end

				if arg_5_2 then
					self:updateGrid(iter_5_1.grid_id, iter_5_1.exp, iter_5_1.level)
				end
			end
		end
	end

	return var_5_0
end

function MonopolyData:onMonopolyNodeAward(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.node_ids or {}) do
		self._rewardIds[iter_6_1] = true
	end
end

function MonopolyData:onMonopolyUseFixedDice(arg_7_1)
	self:setNextDice(arg_7_1.dice)
end

function MonopolyData:onS2CRedPoint(arg_8_1)
	self._isSvrRedPoint = arg_8_1.is_hint
	self._isSvrData = false
end

function MonopolyData:isIgnoreChangeAnim()
	self._ignoreChangeAnim = false

	return self._ignoreChangeAnim
end

function MonopolyData:updateMapData(arg_10_1)
	self._activityId = arg_10_1.activity_id
	self._curIndex = arg_10_1.grid_id
	self._nextDiceNum = arg_10_1.fixed_dice or 0
	self._specialGridId = arg_10_1.box_grid_id or 0
	self._curScore = arg_10_1.node_score or 0
	self._sumDiceNum = arg_10_1.roll_count or 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.award_node_ids or {}) do
		self._rewardIds[iter_10_1] = true
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_1.grids or {}) do
		self._gridData[iter_10_3.id] = iter_10_3
	end

	self:initActivityInfo()
end

function MonopolyData:getBoxGridId()
	return self._specialGridId
end

function MonopolyData:initActivityInfo()
	if self._activityCfg then
		return
	end

	local var_12_0 = var_0_2.get(self._activityId)

	self._activityCfg = var_12_0
	self._mapGroup = var_12_0.monopoly_group
	self._rewardGroup = var_12_0.node_group
	self._monopolyIndexMap = {}
	self._monopolyPos2CfgMap = {}

	for iter_12_0, iter_12_1 in var_0_0.ipairs() do
		if iter_12_1.group == self._mapGroup then
			self._monopolyIndexMap[iter_12_1.id] = {
				x = iter_12_1.x,
				y = iter_12_1.y
			}
			self._monopolyPos2CfgMap[iter_12_1.x .. "_" .. iter_12_1.y] = iter_12_1
		end
	end

	for iter_12_2, iter_12_3 in var_0_1.ipairs() do
		if iter_12_3.group == self._mapGroup then
			self._gridEventMap[iter_12_3.type] = self._gridEventMap[iter_12_3.type] or {}
			self._gridEventMap[iter_12_3.type][iter_12_3.level] = iter_12_3
		end
	end

	for iter_12_4, iter_12_5 in var_0_3.ipairs() do
		if iter_12_5.group == self._rewardGroup then
			self._rewardNodes[iter_12_5.id] = iter_12_5

			table.insert(self._nodeIndex, iter_12_5.id)
		end
	end
end

function MonopolyData:getRewardItems()
	local var_13_0 = {}
	local var_13_1 = 0
	local var_13_2 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MONOPOLY_NODE_SHOW_NUM).parameter

	for iter_13_0, iter_13_1 in ipairs(self._rewardNodes) do
		if iter_13_1.num > self._curScore then
			var_13_1 = var_13_1 + 1

			table.insert(var_13_0, iter_13_1)

			if var_13_2 <= var_13_1 then
				break
			end
		else
			table.insert(var_13_0, iter_13_1)
		end
	end

	return var_13_0
end

function MonopolyData:getMonopolyTypeMap()
	return self._monopolyPos2CfgMap
end

function MonopolyData:getActData()
	if self._activityId ~= 0 then
		return g.core.model.User.cultivateDataMgr:getCultivateData(self._activityId)
	end
end

function MonopolyData:getGridType(arg_16_1)
	return (self._monopolyPos2CfgMap[self._monopolyIndexMap[arg_16_1].x .. "_" .. self._monopolyIndexMap[arg_16_1].y] or nil) and (self._monopolyPos2CfgMap[self._monopolyIndexMap[arg_16_1].x .. "_" .. self._monopolyIndexMap[arg_16_1].y].type or 0)
end

function MonopolyData:getGridTypeByPos(arg_17_1)
	return (self._monopolyPos2CfgMap[arg_17_1.x .. "_" .. arg_17_1.y] or nil) and (self._monopolyPos2CfgMap[arg_17_1.x .. "_" .. arg_17_1.y].type or 0)
end

function MonopolyData:updateGrid(arg_18_1, arg_18_2, arg_18_3)
	self._gridData[arg_18_1] = self._gridData[arg_18_1] or {
		id = self._gridData[arg_18_1]
	}
	self._gridData[arg_18_1].exp = arg_18_2
	self._gridData[arg_18_1].level = arg_18_3
end

function MonopolyData:getCurrentIndex()
	return self._curIndex
end

function MonopolyData:getRoleIndexPos(arg_20_1)
	return self._monopolyIndexMap[self:formatStepFinishIndex(arg_20_1)]
end

function MonopolyData:formatStepFinishIndex(arg_21_1)
	local var_21_0 = #self._monopolyIndexMap

	while arg_21_1 <= 0 do
		arg_21_1 = arg_21_1 + var_21_0
	end

	return var_21_0 == arg_21_1 and var_21_0 or arg_21_1 % var_21_0
end

function MonopolyData:isNeedPauseWaitAnim(arg_22_1)
	return false
end

function MonopolyData:mergeRunPath(arg_23_1)
	local var_23_0 = arg_23_1[1].x == arg_23_1[2].x and 0 or 1
	local var_23_1 = arg_23_1[1]
	local var_23_2 = {}
	local var_23_3 = 2
	local var_23_4 = {}

	while var_23_3 <= #arg_23_1 do
		local var_23_5 = var_23_0

		var_23_0 = arg_23_1[var_23_3].x == arg_23_1[var_23_3 - 1].x and 0 or 1

		local var_23_6 = false
		local var_23_7

		if not var_23_4[var_23_3] and var_23_3 - 1 > 1 then
			var_23_6, var_23_7 = self:isNeedPauseWaitAnim(arg_23_1[var_23_3 - 1])
		end

		var_23_4[var_23_3] = true

		if var_23_5 ~= var_23_0 or var_23_6 then
			table.insert(var_23_2, {
				startPos = var_23_1,
				endPos = arg_23_1[var_23_3 - 1],
				pauseEvent = var_23_7
			})

			var_23_1 = arg_23_1[var_23_3 - 1]
		else
			var_23_3 = var_23_3 + 1

			if var_23_3 > #arg_23_1 then
				local var_23_8, var_23_9 = self:isNeedPauseWaitAnim(arg_23_1[var_23_3 - 1])

				table.insert(var_23_2, {
					startPos = var_23_1,
					endPos = arg_23_1[var_23_3 - 1],
					pauseEvent = var_23_9
				})
			end
		end
	end

	return var_23_2
end

function MonopolyData:getNextMoveDir()
	local var_24_0 = self._monopolyIndexMap[self:formatStepFinishIndex(self._curIndex)]
	local var_24_1 = self._monopolyIndexMap[self:formatStepFinishIndex(self._curIndex + 1)]

	if var_24_1.y ~= var_24_0.y then
		return var_24_1.y > var_24_0.y and -1 or 1
	else
		return var_24_1.x > var_24_0.x and 1 or -1
	end
end

function MonopolyData:getAnimListByRollResult(arg_25_1)
	local var_25_0 = {}
	local var_25_1 = 0

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		var_25_1 = var_25_1 + self:getOneStepMoveSize(iter_25_1, false)
	end

	local var_25_2 = self:formatStepFinishIndex(self._curIndex - var_25_1)

	for iter_25_2, iter_25_3 in ipairs(arg_25_1) do
		local var_25_3 = 0

		for iter_25_4 = var_25_2 + 1, var_25_2 + iter_25_3.dice do
			local var_25_4 = self._monopolyIndexMap[self:formatStepFinishIndex(iter_25_4)]

			if self._monopolyPos2CfgMap[var_25_4.x .. "_" .. var_25_4.y].type == 0 then
				var_25_3 = iter_25_3.dice - (iter_25_4 - var_25_2)

				break
			end
		end

		local var_25_5 = false

		if var_25_3 == 0 then
			table.insert(var_25_0, {
				type = "runDice",
				step = iter_25_3.dice,
				startPos = var_25_2,
				fullNum = #arg_25_1,
				index = iter_25_2,
				moveStep = iter_25_3.dice
			})

			var_25_2 = self:formatStepFinishIndex(var_25_2 + iter_25_3.dice)
		else
			local var_25_6 = iter_25_3.dice - var_25_3

			table.insert(var_25_0, {
				type = "runDice",
				step = iter_25_3.dice,
				startPos = var_25_2,
				fullNum = #arg_25_1,
				index = iter_25_2,
				moveStep = iter_25_3.dice - var_25_3
			})

			var_25_2 = self:formatStepFinishIndex(var_25_2 + var_25_6)
			var_25_5 = true
		end

		for iter_25_5, iter_25_6 in ipairs(iter_25_3.events) do
			if iter_25_6.tp ~= 1 and not var_25_5 and var_25_3 > 0 then
				table.insert(var_25_0, {
					type = "exMove",
					step = var_25_3,
					startPos = var_25_2
				})

				var_25_2 = self:formatStepFinishIndex(var_25_2 + var_25_3)
				var_25_3 = 0
			end

			var_25_5 = false

			table.insert(var_25_0, {
				type = "addExp",
				exp = iter_25_6.exp,
				level = iter_25_6.level,
				grid = iter_25_6.grid_id
			})

			if iter_25_6.tp == 0 then
				local var_25_7 = var_0_0.get(iter_25_6.grid_id)

				if (var_25_7.type == MonopolyConst.EVENT_TYPE.FRONT_GRIDS or var_25_7.type == MonopolyConst.EVENT_TYPE.BEHIND_GRIDS) and self._gridEventMap[var_25_7.type] then
					if self._gridEventMap[var_25_7.type][iter_25_6.level].type == MonopolyConst.EVENT_TYPE.FRONT_GRIDS then
						for iter_25_7 = var_25_2 + 1, var_25_2 + self._gridEventMap[var_25_7.type][iter_25_6.level].value do
							local var_25_8 = self._monopolyIndexMap[self:formatStepFinishIndex(iter_25_7)]

							if self._monopolyPos2CfgMap[var_25_8.x .. "_" .. var_25_8.y].type == 0 then
								var_25_3 = self._gridEventMap[var_25_7.type][iter_25_6.level].value - (iter_25_7 - var_25_2)

								break
							end
						end

						if var_25_3 == 0 then
							table.insert(var_25_0, {
								isEvent = true,
								type = "exMove",
								step = self._gridEventMap[var_25_7.type][iter_25_6.level].value,
								startPos = var_25_2
							})

							var_25_2 = self:formatStepFinishIndex(var_25_2 + self._gridEventMap[var_25_7.type][iter_25_6.level].value)
						else
							local var_25_9 = self._gridEventMap[var_25_7.type][iter_25_6.level].value - var_25_3

							table.insert(var_25_0, {
								type = "exMove",
								isEvent = true,
								step = self._gridEventMap[var_25_7.type][iter_25_6.level].value - var_25_3,
								startPos = var_25_2,
								finalPos = var_25_2 + self._gridEventMap[var_25_7.type][iter_25_6.level].value
							})

							var_25_2 = self:formatStepFinishIndex(var_25_2 + var_25_9)
							var_25_5 = true
						end
					else
						table.insert(var_25_0, {
							isEvent = true,
							type = "exMove",
							step = -self._gridEventMap[var_25_7.type][iter_25_6.level].value,
							startPos = var_25_2
						})

						var_25_2 = self:formatStepFinishIndex(var_25_2 - self._gridEventMap[var_25_7.type][iter_25_6.level].value)
					end
				end
			elseif iter_25_6.tp == 1 then
				table.insert(var_25_0, {
					type = "animStartPos",
					exp = iter_25_6.exp,
					level = iter_25_6.level,
					grid = iter_25_6.grid_id
				})
			elseif iter_25_6.tp == 2 then
				table.insert(var_25_0, {
					type = "boxRefresh",
					nextId = iter_25_6.value,
					grid = iter_25_6.grid_id
				})
			end

			if iter_25_6.awards then
				local var_25_10 = {
					type = "reward",
					awards = iter_25_6.awards,
					grid = iter_25_6.grid_id,
					exValue = iter_25_6.value
				}

				if iter_25_6.tp == 2 then
					var_25_10.boxValue = iter_25_6.value
				end

				table.insert(var_25_0, var_25_10)
			end
		end
	end

	table.insert(var_25_0, {
		type = "animEnd"
	})

	return var_25_0
end

function MonopolyData:gotoPath(arg_26_1, arg_26_2)
	local var_26_0 = {}
	local var_26_1 = self:formatStepFinishIndex(arg_26_1)

	table.insert(var_26_0, self._monopolyIndexMap[self:formatStepFinishIndex(var_26_1)])

	local var_26_2 = 1

	if arg_26_2 < 0 then
		var_26_2 = -1
	end

	for iter_26_0 = var_26_2, arg_26_2, var_26_2 do
		table.insert(var_26_0, self._monopolyIndexMap[self:formatStepFinishIndex(var_26_1 + iter_26_0)])
	end

	return self:mergeRunPath(var_26_0)
end

function MonopolyData:addStep(arg_27_1)
	self._curIndex = self:formatStepFinishIndex(self._curIndex + arg_27_1)
end

function MonopolyData:setNextDice(arg_28_1)
	self._nextDiceNum = arg_28_1
end

function MonopolyData:getNextDice()
	return self._nextDiceNum
end

function MonopolyData:setInDiceAnim(arg_30_1)
	self._inDiceAnim = arg_30_1
end

function MonopolyData:isInDiceAnim()
	return self._inDiceAnim
end

function MonopolyData:getActivityId()
	return self._activityId
end

function MonopolyData:getGridData(arg_33_1)
	return self._gridData[arg_33_1]
end

function MonopolyData:getCurScore()
	return self._curScore
end

function MonopolyData:isNodeReward(arg_35_1)
	return self._rewardIds[arg_35_1]
end

function MonopolyData:getGridLvCfg(arg_36_1, arg_36_2)
	if self._gridEventMap[arg_36_1] then
		return self._gridEventMap[arg_36_1][arg_36_2]
	end
end

function MonopolyData:isShowFiftyBtn()
	return self._sumDiceNum >= g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.MONOPOLY_FIFTY_SHOW_NUM).parameter
end

function MonopolyData:isHasPointRewardCanGet()
	local var_38_0 = self:getCurScore()

	for iter_38_0, iter_38_1 in ipairs(self._rewardNodes) do
		if var_38_0 >= iter_38_1.num and not self._rewardIds[iter_38_1.id] then
			return true
		end
	end

	return false
end

return MonopolyData
