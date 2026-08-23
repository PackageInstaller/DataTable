local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostBuildBaseStruct = class("OutpostBuildBaseStruct")

OutpostBuildBaseStruct.CHECK_FROM = {
	MAIN_TASK_CHANGED = "mainTaskChange",
	OTHER_LEVEL_CHANGED = "otherLevelChange",
	BOSS_KILLED = "BOSS_KILLED",
	MINE_LEVEL_CHANGED = "mineLevelChange"
}

function OutpostBuildBaseStruct:ctor(arg_1_1, arg_1_2)
	local var_1_0 = g.core.config.outpost_build_info.get(arg_1_2)

	self._type = arg_1_1
	self._level = 0
	self._limitLevel = 0
	self._pos = cc.p(var_1_0.x, var_1_0.y)
	self._size = cc.size(var_1_0.x_length, var_1_0.y_length)
	self._name = var_1_0.name
	self._uid = ""

	self:_updateUid()

	self._unlockConditionDic = {}
	self._levelUpConditionDic = {}
	self._levelToIdDic = {}
	self._levelUpCostDic = {}
	self._knightSidDic = {}
	self._maxKnightCnt = 1
	self._buildCfg = var_1_0
	self._tab = nil
	self._cfg = nil
	self._orderDic = {}
	self._orderList = {}

	self:_initBuild()
	self:_checkAndInitCurCondition(self._unlockConditionDic)
end

function OutpostBuildBaseStruct:_initBuild()
	for iter_2_0 = 1, self._tab.getLength() do
		local var_2_0 = self._tab.indexOf(iter_2_0)

		if not self._tab.hasKey("building_type") then
			self._levelToIdDic[var_2_0.level] = var_2_0.id
		elseif var_2_0.building_type == self._type then
			self._levelToIdDic[var_2_0.level] = var_2_0.id
		end

		self:_onOneCfgGot(var_2_0)
	end

	self:_inputInfoToInfoDic(self._tab.get(self._levelToIdDic[1]), self._unlockConditionDic, {
		{
			key = "unlock_type_",
			unexpectedValue = 0,
			toKey = "type"
		},
		{
			key = "unlock_key_",
			toKey = "key"
		},
		{
			key = "unlock_value_",
			unexpectedValue = 0,
			toKey = "value"
		}
	}, self._tab, true)
end

function OutpostBuildBaseStruct:_onOneCfgGot(arg_3_1)
	return
end

function OutpostBuildBaseStruct:getUid()
	return self._uid
end

function OutpostBuildBaseStruct:_updateUid()
	self._uid = table.concat({
		self._type,
		self._pos.x,
		self._pos.y
	}, "_")
end

function OutpostBuildBaseStruct:_inputInfoToInfoDic(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_4 = arg_6_4 or self._tab

	local var_6_0 = 1
	local var_6_1 = {
		arg_6_3[1].key
	}

	var_6_1[2] = 1

	local var_6_2 = table.concat(var_6_1)

	while arg_6_4.hasKey(var_6_2) do
		local var_6_3 = {}
		local var_6_4 = arg_6_1[var_6_2]
		local var_6_5 = arg_6_3[1].toKey

		if arg_6_3[1].toKey then
			var_6_3[var_6_5] = var_6_4
		else
			var_6_3 = var_6_4
		end

		if var_6_4 ~= arg_6_3[1].unexpectedValue then
			for iter_6_0 = 2, #arg_6_3 do
				local var_6_6 = 0
				local var_6_7 = arg_6_1[table.concat({
					arg_6_3[iter_6_0].key,
					var_6_0
				})]

				if arg_6_3[iter_6_0].toKey then
					if arg_6_2[var_6_4] and arg_6_2[var_6_4][arg_6_3[iter_6_0].toKey] then
						var_6_6 = arg_6_2[var_6_4][arg_6_3[iter_6_0].toKey]
					end

					var_6_3[arg_6_3[iter_6_0].toKey] = var_6_7 == arg_6_3[iter_6_0].unexpectedValue and var_6_6 or var_6_6 + var_6_7
				end
			end

			if not arg_6_2[var_6_4] and arg_6_5 then
				var_6_3.idx = var_6_0
			end

			if var_6_5 then
				arg_6_2[var_6_4] = var_6_3
			else
				arg_6_2[var_6_0] = var_6_3
			end
		end

		var_6_0 = var_6_0 + 1
		var_6_2 = table.concat({
			arg_6_3[1].key,
			var_6_0
		})
	end
end

function OutpostBuildBaseStruct:_checkAndInitCurCondition(arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 or {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		iter_7_1.cur = arg_7_2[iter_7_0] and arg_7_2.cur and arg_7_2.cur ~= 0 and (arg_7_2.cur or 0) or self:_getConditionProcess(iter_7_1.type, iter_7_1.key)
	end
end

function OutpostBuildBaseStruct:_getConditionProcess(arg_8_1, arg_8_2)
	local var_8_0 = 0

	if var_0_0.BuildUnlockType.USER_LEVEL == arg_8_1 then
		var_8_0 = g.core.model.User:getLevel()
	elseif var_0_0.BuildUnlockType.KILL_BOSS == arg_8_1 then
		local var_8_1 = g.core.model.User.outpostData:getStatusByIdAndKey(arg_8_1, arg_8_2)

		if var_8_1 then
			var_8_0 = var_8_1.status
		end
	elseif var_0_0.BuildUnlockType.BUILD_LEVEL == arg_8_1 then
		local var_8_2 = g.core.model.User.outpostData:getBuildData():getBuild({
			type = arg_8_2
		})

		if var_8_2 then
			var_8_0 = var_8_2:getLevel()
		end
	elseif var_0_0.BuildUnlockType.MAIN_TASK == arg_8_1 then
		local var_8_3 = g.core.model.User.outpostData:getTaskData()

		if var_8_3:getTaskIdx(var_8_3:getCurTask().cfg.id) > var_8_3:getTaskIdx(arg_8_2) then
			var_8_0 = 1
		end
	end

	return var_8_0
end

function OutpostBuildBaseStruct:isMaxBuildLevel()
	return self._levelToIdDic[self._level + 1] == nil
end

function OutpostBuildBaseStruct:canLevelUp()
	if self._limitLevel <= self._level then
		return false
	end

	local var_10_0 = not self:isMaxBuildLevel()

	for iter_10_0, iter_10_1 in pairs(self._levelUpConditionDic) do
		if iter_10_1.value > iter_10_1.cur then
			var_10_0 = false

			break
		end
	end

	return var_10_0
end

function OutpostBuildBaseStruct:levelUp()
	if self:isLockBuild() then
		return
	end

	self:setLevel(self._level + 1)
end

function OutpostBuildBaseStruct:setLevel(arg_12_1, arg_12_2)
	self._levelUpConditionDic = {}
	self._levelUpCostDic = {}

	local var_12_0 = self._level or 0

	self._level = arg_12_1

	local var_12_1 = var_12_0 - self._level

	self:_updateByLevel(var_12_0 - self._level ~= 0)
	self:_checkAndInitCurCondition(self._levelUpConditionDic, self._levelUpConditionDic)

	if not var_12_1 ~= 0 then
		if self:_checkNeedDoEffect({
			from = OutpostBuildBaseStruct.CHECK_FROM.MINE_LEVEL_CHANGED
		}) then
			self:onEffect()
		end

		local var_12_2 = 0

		if not self._cfg then
			release_print("not cfg, build type is : " .. self._type)
		else
			var_12_2 = self._cfg.id
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_BUILD_LEVEL_CHANGED, false, {
			type = self._type,
			level = arg_12_1,
			id = var_12_2,
			uid = self:getUid()
		})
	end
end

function OutpostBuildBaseStruct:setLimitLevel(arg_13_1)
	self._limitLevel = arg_13_1
end

function OutpostBuildBaseStruct:getLimitLevel()
	return self._limitLevel
end

function OutpostBuildBaseStruct:_updateByLevel(arg_15_1)
	self._cfg = self._tab.get(self._levelToIdDic[self._level])

	if self._levelToIdDic[self._level + 1] then
		local var_15_0 = self._tab.get(self._levelToIdDic[self._level + 1])

		self:_inputInfoToInfoDic(var_15_0, self._levelUpConditionDic, {
			{
				key = "unlock_type_",
				unexpectedValue = 0,
				toKey = "type"
			},
			{
				key = "unlock_key_",
				toKey = "key"
			},
			{
				key = "unlock_value_",
				unexpectedValue = 0,
				toKey = "value"
			}
		}, self._tab, true)
		self:_inputInfoToInfoDic(var_15_0, self._levelUpCostDic, {
			{
				key = "level_upgrade_type_",
				unexpectedValue = 0,
				toKey = "type"
			},
			{
				key = "level_upgrade_value_",
				unexpectedValue = 0,
				toKey = "value"
			},
			{
				key = "level_upgrade_size_",
				unexpectedValue = 0,
				toKey = "size"
			}
		})
	end
end

function OutpostBuildBaseStruct:getLevel()
	return self._level
end

function OutpostBuildBaseStruct:getUnlockDes()
	self._unlockConditionDic = self._unlockConditionDic or {}

	return self:_getUnMatchConditionDes(self._unlockConditionDic)
end

function OutpostBuildBaseStruct:getLevelUpDes()
	self._levelUpConditionDic = self._levelUpConditionDic or {}

	return self:_getUnMatchConditionDes(self._levelUpConditionDic)
end

function OutpostBuildBaseStruct:canPayLevelUpCost(arg_19_1)
	local var_19_0

	if not arg_19_1 then
		arg_19_1 = self._level
		var_19_0 = {}
	end

	self:_inputInfoToInfoDic(self._tab.get(self._levelToIdDic[arg_19_1]), var_19_0, {
		{
			key = "level_upgrade_type_",
			unexpectedValue = 0,
			toKey = "type"
		},
		{
			key = "level_upgrade_value_",
			unexpectedValue = 0,
			toKey = "value"
		},
		{
			key = "level_upgrade_size_",
			unexpectedValue = 0,
			toKey = "size"
		}
	})

	local var_19_1 = g.core.model.User.outpostData:getBagData()
	local var_19_2 = true
	local var_19_3

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		if var_19_1:getOwnNum(iter_19_1.value) < iter_19_1.size then
			var_19_2 = false
			var_19_3 = iter_19_1

			break
		end
	end

	return var_19_2, var_19_3
end

function OutpostBuildBaseStruct:_getUnMatchConditionDes(arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		local var_20_1

		if iter_20_1.value > iter_20_1.cur and 9999 > iter_20_1.idx then
			var_20_1 = iter_20_1.idx
			var_20_0 = iter_20_1
		end
	end

	local var_20_2 = ""
	local var_20_3

	if var_0_0.BuildUnlockType.USER_LEVEL == var_20_0.type then
		var_20_2 = g.core.lang:get(432618, {
			level = var_20_0.value
		})

		function var_20_3()
			g.core.module.ModuleManager:pushModule(g.view.entrance.DUNGEON_STAGE)
		end
	elseif var_0_0.BuildUnlockType.KILL_BOSS == var_20_0.type then
		var_20_2 = g.core.lang:get(432619, {
			name = g.core.config.outpost_monster_info.get(var_20_0.key).name
		})

		function var_20_3()
			g.view.entrance.ModuleGotoProxy:gotoModule(var_0_0.BuildJumpId[var_0_0.BuildType.Boss])
		end
	elseif var_0_0.BuildUnlockType.BUILD_LEVEL == var_20_0.type then
		local var_20_4 = var_20_0.key

		function var_20_3()
			g.core.module.ModuleManager:popComponent()
			g.core.common.Scheduler:newScheduleOnce(function()
				g.view.entrance.ModuleGotoProxy:gotoModule(var_0_0.BuildJumpId[var_20_4])
			end, 0.25)
		end

		var_20_2 = g.core.lang:get(432608, {
			name = g.core.model.User.outpostData:getBuildData():getBuild({
				type = var_20_0.key
			}):getBuildName(),
			level = var_20_0.value
		})
	elseif var_0_0.BuildUnlockType.MAIN_TASK == var_20_0.type then
		var_20_2 = g.core.lang:get(432648)

		function var_20_3()
			g.core.module.ModuleManager:popComponent()
		end
	end

	return var_20_2, var_20_3
end

function OutpostBuildBaseStruct:canUnlock()
	local var_26_0 = true

	for iter_26_0, iter_26_1 in pairs(self._unlockConditionDic) do
		if iter_26_1.value > iter_26_1.cur then
			var_26_0 = false

			break
		end
	end

	return var_26_0
end

function OutpostBuildBaseStruct:unlockBuild()
	if not self:isLockBuild() then
		return
	end

	self:setLevel(1)

	self._unlockConditionDic = {}
end

function OutpostBuildBaseStruct:isLockBuild()
	return self._level == 0
end

function OutpostBuildBaseStruct:canChangePos()
	return true
end

function OutpostBuildBaseStruct:isSamePos(arg_30_1)
	return cc.pDistanceSQ(self._pos, arg_30_1) == 0
end

function OutpostBuildBaseStruct:setBuildPos(arg_31_1)
	if not self:canChangePos() then
		return
	end

	self._pos = arg_31_1

	if not self:isSamePos(self._pos) then
		self:_updateUid()
	end
end

function OutpostBuildBaseStruct:getBuildType()
	return self._type
end

function OutpostBuildBaseStruct:getBuildPos()
	return self._pos
end

function OutpostBuildBaseStruct:getBuildSize()
	return self._size
end

function OutpostBuildBaseStruct:getCfg()
	return self._cfg
end

function OutpostBuildBaseStruct:getLevelUpCostDic()
	return self._levelUpCostDic
end

function OutpostBuildBaseStruct:getBuildInfo()
	return
end

function OutpostBuildBaseStruct:onReceivedLevelChangeNotice(arg_38_1)
	local var_38_1 = {
		type = var_0_0.BuildUnlockType.BUILD_LEVEL,
		key = arg_38_1.type,
		value = arg_38_1.level
	}

	if not self:_onCheckConditionsByParam(var_38_1) then
		return
	end

	if self:_checkNeedDoEffect({
		from = OutpostBuildBaseStruct.CHECK_FROM.OTHER_LEVEL_CHANGED
	}) then
		self:onEffect(var_38_1)
	end
end

function OutpostBuildBaseStruct:_onCheckConditionsByParam(arg_39_1)
	if not self._levelUpConditionDic[arg_39_1.type] and not self._unlockConditionDic[arg_39_1.type] then
		return false
	end

	local var_39_0 = arg_39_1.key

	if self._levelUpConditionDic[arg_39_1.type] and self._levelUpConditionDic[arg_39_1.type].key == var_39_0 then
		self._levelUpConditionDic[arg_39_1.type].cur = arg_39_1.value
	end

	if self:isLockBuild() then
		if self._unlockConditionDic[arg_39_1.type] and self._unlockConditionDic[arg_39_1.type].key == var_39_0 then
			self._unlockConditionDic[arg_39_1.type].cur = arg_39_1.value
		end
	elseif self:canLevelUp() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_BUILD_CAN_LEVEL_UP, false, {
			buildType = self._type
		})
	end
end

function OutpostBuildBaseStruct:onBossDead(arg_40_1, arg_40_2)
	local var_40_0 = {
		type = var_0_0.BuildUnlockType.KILL_BOSS,
		key = arg_40_1,
		value = arg_40_2
	}

	if not self:_onCheckConditionsByParam(var_40_0) then
		return
	end

	if self:_checkNeedDoEffect({
		from = OutpostBuildBaseStruct.CHECK_FROM.BOSS_KILLED
	}) then
		self:onEffect(var_40_0)
	end
end

function OutpostBuildBaseStruct:onTaskChanged(arg_41_1)
	local var_41_0 = {
		type = var_0_0.BuildUnlockType.MAIN_TASK,
		key = arg_41_1.task_id,
		value = self:_getConditionProcess(var_0_0.BuildUnlockType.MAIN_TASK, arg_41_1.task_id)
	}

	if not self:_onCheckConditionsByParam(var_41_0) then
		return
	end

	if self:_checkNeedDoEffect({
		from = OutpostBuildBaseStruct.CHECK_FROM.MAIN_TASK_CHANGED
	}) then
		self:onEffect(var_41_0)
	end
end

function OutpostBuildBaseStruct:getBuildName()
	return self._name
end

function OutpostBuildBaseStruct:getBuildDes()
	return self._buildCfg.des
end

function OutpostBuildBaseStruct:updateBuildBySvr(arg_44_1, arg_44_2)
	if not arg_44_2 then
		self._knightSidDic = {}
	end

	for iter_44_0, iter_44_1 in ipairs(arg_44_1.knight_ids or {}) do
		if not self:isInBuilding(iter_44_1) then
			self:addHoldKnightBySid(iter_44_1)
		end
	end

	self:setLevel(arg_44_1.level)

	self._orderList = arg_44_1.orders or {}
	self._orderDic = {}

	for iter_44_2, iter_44_3 in ipairs(self._orderList) do
		self._orderDic[iter_44_3.id] = iter_44_3
	end
end

function OutpostBuildBaseStruct:_checkNeedDoEffect(arg_45_1)
	return false
end

function OutpostBuildBaseStruct:onEffect(arg_46_1)
	if not arg_46_1 then
		return
	end

	if arg_46_1.knightId and self:canAddKnight(arg_46_1.knightId) == var_0_0.REJECT_IN_BUILD_REASON.NONE then
		self:addHoldKnightBySid(arg_46_1.knightId, true)
	end
end

function OutpostBuildBaseStruct:isInBuilding(arg_47_1)
	local var_47_0 = self._knightSidDic[arg_47_1]

	if not self._knightSidDic[arg_47_1] then
		return false
	end

	local var_47_1 = var_47_0.time < 0 or var_47_0.time >= g.core.common.ServerTime:getTime()

	if var_47_1 == false then
		if var_0_0.BUILD_SP_KNIGHT_TIME.FOREVER == var_47_0.time then
			self:onKnightOutFromBuild(arg_47_1)
		else
			var_47_1 = true

			if not var_47_0.scheduler and not var_47_0.request then
				var_47_0.request = true

				self:_doOutFromBuildByKnightSid(arg_47_1)
			end
		end
	end

	return var_47_1
end

function OutpostBuildBaseStruct:getBuildCfg()
	return self._buildCfg
end

function OutpostBuildBaseStruct:canAddKnight(arg_49_1)
	if self:isLockBuild() then
		return var_0_0.REJECT_IN_BUILD_REASON.UNLOCK_BUILD
	end

	local var_49_0 = 0

	for iter_49_0, iter_49_1 in pairs(self._knightSidDic) do
		if self:isInBuilding(iter_49_0) then
			var_49_0 = var_49_0 + 1
		end
	end

	if not arg_49_1 then
		if var_49_0 < self._maxKnightCnt then
			return var_0_0.REJECT_IN_BUILD_REASON.NONE
		else
			return var_0_0.REJECT_IN_BUILD_REASON.KNIGHT_LIMIT
		end
	end

	if self:isInBuilding(arg_49_1) then
		return var_0_0.REJECT_IN_BUILD_REASON.IS_IN_BUILDING
	end

	if var_49_0 < self._maxKnightCnt then
		return var_0_0.REJECT_IN_BUILD_REASON.NONE
	else
		return var_0_0.REJECT_IN_BUILD_REASON.KNIGHT_LIMIT
	end
end

function OutpostBuildBaseStruct:addHoldKnightBySid(arg_50_1, arg_50_2)
	self._knightSidDic[arg_50_1] = {
		time = var_0_0.BUILD_SP_KNIGHT_TIME.FOREVER,
		inTime = g.core.common.ServerTime:getTime(),
		leftTime = var_0_0.BUILD_SP_KNIGHT_TIME.FOREVER,
		sid = arg_50_1
	}
end

function OutpostBuildBaseStruct:_tickKnightLeftTime(arg_51_1, arg_51_2)
	local var_51_0 = false

	if self._knightSidDic[arg_51_1] then
		self._knightSidDic[arg_51_1].leftTime = self._knightSidDic[arg_51_1].leftTime - arg_51_2

		if self._knightSidDic[arg_51_1].leftTime <= 0 then
			self._knightSidDic[arg_51_1].leftTime = 0

			if not self._knightSidDic[arg_51_1].request then
				self._knightSidDic[arg_51_1].request = true

				self:_doOutFromBuildByKnightSid(arg_51_1)
			end
		else
			var_51_0 = true
		end
	end

	return var_51_0
end

function OutpostBuildBaseStruct:_doOutFromBuildByKnightSid(arg_52_1)
	if self._knightSidDic[arg_52_1] then
		g.core.network.GameNetProxy:send_C2S_Outpost_Build_Use_Leave({
			build_tp = self._type,
			knight_id = arg_52_1
		})
	end
end

function OutpostBuildBaseStruct:onKnightOutFromBuild(arg_53_1)
	self._knightSidDic[arg_53_1] = nil

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_KNIGHT_OUT_BUILD, false, {
		buildType = self._type,
		sid = arg_53_1
	})
end

function OutpostBuildBaseStruct:getMaxKnightNum()
	return self._maxKnightCnt
end

function OutpostBuildBaseStruct:getInBuildKnight(arg_55_1)
	if arg_55_1 then
		for iter_55_0, iter_55_1 in pairs(self._knightSidDic) do
			self:isInBuilding(iter_55_1.sid)
		end
	end

	return self._knightSidDic
end

function OutpostBuildBaseStruct:updateBuildOrder(arg_56_1, arg_56_2, arg_56_3)
	local var_56_0 = self:getOrderInfo(arg_56_1) or self:_createOrderInfo(arg_56_1)

	var_56_0.num = var_56_0.num or 0

	local var_56_1 = 1

	if arg_56_2.order_tp then
		var_56_0.orderType = arg_56_2.order_tp

		if arg_56_2.order_tp == var_0_0.EXCHANGE_TYPE.SELL then
			var_56_1 = -1
		end
	end

	local var_56_2 = 0

	if arg_56_3 then
		var_56_2 = arg_56_2.target_num - var_56_0.num
		var_56_0.num = arg_56_2.target_num
	else
		var_56_2 = arg_56_2.target_num * var_56_1
		var_56_0.num = var_56_0.num + arg_56_2.target_num * var_56_1
	end

	var_56_0.knightId = arg_56_2.knight and arg_56_2.knight.knight_id or arg_56_2.knight_id

	if var_56_0.num == 0 then
		self:_removeOrderInfo(arg_56_1)
	end

	var_56_0.isTemp = false
	var_56_0.tempNum = nil

	self:_onOrderChanged({
		id = arg_56_1,
		target_id = var_56_0.target_id,
		knightSid = var_56_0.knightId,
		num = var_56_2,
		absNum = math.abs(var_56_2),
		order_tp = arg_56_2.order_tp
	})
end

function OutpostBuildBaseStruct:_onOrderChanged(arg_57_1)
	if arg_57_1 then
		-- block empty
	end
end

function OutpostBuildBaseStruct:_removeOrderInfo(arg_58_1)
	local var_58_0 = self:getOrderInfo(arg_58_1)

	for iter_58_0, iter_58_1 in ipairs(self._orderList) do
		if iter_58_1 == var_58_0 then
			table.remove(self._orderList, iter_58_0)

			break
		end
	end

	self._orderDic[arg_58_1] = nil
end

function OutpostBuildBaseStruct:_createOrderInfo(arg_59_1, arg_59_2)
	local var_59_0 = {
		num = 0,
		id = arg_59_1,
		isTemp = arg_59_2
	}

	self._orderList[#self._orderList + 1] = var_59_0
	self._orderDic[arg_59_1] = var_59_0

	return var_59_0
end

function OutpostBuildBaseStruct:getOrderInfo(arg_60_1)
	return self._orderDic[arg_60_1]
end

function OutpostBuildBaseStruct:getOrders()
	return self._orderList
end

return OutpostBuildBaseStruct
