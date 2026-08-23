local WushData = class("WushData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.dead_battle_floor_info
local var_0_3 = g.core.config.dead_battle_buff_info
local var_0_4 = g.core.config.parameter_info
local var_0_5 = g.core.config.talent_skill_info

function WushData:ctor()
	self:initData()
end

function WushData:initData()
	WushData.super.ctor(self)

	self._floorId = 0
	self._failTimes = 0
	self._totalStar = 0
	self._leftStar = 0
	self._maxStar = 0
	self._weekStar = 0
	self._curStar = {}
	self._addedStar = 0
	self._curBuff = {}
	self._totalBuff = {}
	self._boxState = 0
	self._boxIsGet = false
	self._oldMaxFloor = 0
	self._isFailed = false
	self._allBuffDes = {}
	self._knightBuffDes = {}
	self._tokenBuffDes = {}
	self._newStageIndex = -1
	self._deadLineArr = {}
	self._wushInfo = {}
	self._shopInfo = {}
	self._historyStar = {}
	self._hasDta = false
	self._isFreshWeekStar = false
	self._selfWeekRank = 0
	self._blitzStageIndex = 0
	self._isBussinessNew = (g.core.common.Storage:load("wush.json") or {}).bussinessNew
	self._displayVersion = 1
end

function WushData:recordBlitzStageIndex()
	self._blitzStageIndex = self:getCurStageIndex()
end

function WushData:getBlitzStageIndex()
	return self._blitzStageIndex
end

function WushData:hasData()
	return self._hasDta
end

function WushData:updateWushData(arg_6_1, arg_6_2)
	if arg_6_2 then
		self._shopInfo = arg_6_1.shops or {}

		self:_updateWushShopId()
	end

	self:updateWushInfo(arg_6_1)

	self._hasDta = true
end

function WushData:updateWushInfo(arg_7_1, arg_7_2)
	if arg_7_1.shop then
		self:updateShopInfo(arg_7_1.shop)

		self._isFailed = true
	end

	local var_7_0 = self._leftStar
	local var_7_1 = clone(arg_7_1.dbattle)

	self._floorId = var_7_1.floor
	self._failTimes = var_7_1.fail
	self._totalStar = var_7_1.total_star
	self._leftStar = var_7_1.buff_star
	self._curStar = var_7_1.floor_star
	self._curBuff = var_7_1.floor_buff
	self._maxStar = var_7_1.record_star
	self._oldMaxFloor = var_7_1.old_max_floor
	self._boxIsGet = var_7_1.is_award

	if var_7_1.history_id then
		for iter_7_0, iter_7_1 in ipairs(var_7_1.history_id) do
			self._historyStar[iter_7_1] = var_7_1.history_star[iter_7_0]
		end
	end

	if self._hasDta and var_7_1.week_star > self._weekStar then
		self._isFreshWeekStar = true
	end

	self._weekStar = var_7_1.week_star
	self._addedStar = self._leftStar - var_7_0

	self:_generateAllBuff(var_7_1.buffs)
	self:_updateBoxState()
end

function WushData:updateRedPoint(arg_8_1)
	if not arg_8_1.dead_battle_hint then
		return
	end

	if arg_8_1.dead_battle_hint.fail then
		self._failTimes = arg_8_1.dead_battle_hint.fail
	end

	if arg_8_1.dead_battle_hint.record_star then
		self._maxStar = arg_8_1.dead_battle_hint.record_star
	end

	if arg_8_1.dead_battle_hint.old_max_floor then
		self._oldMaxFloor = arg_8_1.dead_battle_hint.old_max_floor
	end

	if arg_8_1.dead_battle_hint.floor then
		self._floorId = arg_8_1.dead_battle_hint.floor
	end
end

function WushData:_generateAllBuff(arg_9_1)
	if not arg_9_1 then
		return
	end

	self._totalBuff = {}

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_1 = var_0_5.get(var_0_3.get(iter_9_1).talent_id)

		if not var_9_0[var_9_1.affect_type_1] then
			var_9_0[var_9_1.affect_type_1] = {}
			var_9_0[var_9_1.affect_type_1] = var_9_1.affect_value_1
		else
			var_9_0[var_9_1.affect_type_1] = var_9_0[var_9_1.affect_type_1] + var_9_1.affect_value_1
		end
	end

	for iter_9_2, iter_9_3 in pairs(var_9_0) do
		table.insert(self._totalBuff, {
			id = iter_9_2,
			value = iter_9_3
		})
	end

	self:_updateTotalAttrDes()
end

function WushData:updateShopInfo(arg_10_1)
	if not arg_10_1 or not self._shopInfo then
		return
	end

	local var_10_0 = arg_10_1.items

	if next(self._shopInfo) then
		for iter_10_0, iter_10_1 in ipairs(self._shopInfo) do
			if iter_10_1.id == arg_10_1.id then
				iter_10_1.items = var_10_0

				return
			end
		end
	end

	table.insert(self._shopInfo, arg_10_1)
	self:_updateWushShopId()
end

function WushData:_updateWushShopId()
	self._deadLineArr = {}

	if not self._shopInfo then
		self:saveBussinessNew(false)

		return
	end

	if #self._shopInfo == 0 then
		self:saveBussinessNew(false)
	end

	for iter_11_0 = 1, table.nums(self._shopInfo) do
		table.insert(self._deadLineArr, {
			time = self._shopInfo[iter_11_0].due_time,
			id = self._shopInfo[iter_11_0].id
		})
	end

	table.sort(self._deadLineArr, function(arg_12_0, arg_12_1)
		if arg_12_0.time ~= arg_12_1.time then
			return arg_12_0.time < arg_12_1.time
		end

		return false
	end)
end

function WushData:_updateBoxState()
	if self._boxIsGet then
		self._boxState = 3
	elseif var_0_1.get((math.min(var_0_1.getLength(), self._floorId))).type == 2 then
		self._boxState = self._curStar[1] > 0 and 2 or 1
	else
		self._boxState = 2

		for iter_13_0 = 1, #self._curStar do
			if self._curStar[iter_13_0] == 0 then
				self._boxState = 1

				break
			end
		end
	end
end

function WushData:getStarCount()
	for iter_14_0 = 1, #self._curStar do
		if self._curStar[iter_14_0] ~= 0 then
			-- block empty
		end
	end

	return 0
end

function WushData:checkBuffIsEmpty()
	local var_15_0 = 0

	for iter_15_0 = 1, #self._curBuff do
		if self._curBuff[iter_15_0] == 0 then
			var_15_0 = var_15_0 + 1
		end
	end

	if var_15_0 == #self._curBuff then
		return true
	else
		return false
	end
end

function WushData:updateBoxState()
	self._boxState = 3
end

function WushData:resetBoxState()
	self._boxState = 1
end

function WushData:updateChallengeResult(arg_18_1)
	self:updateWushInfo(arg_18_1)
	self:updateSelfWeekRank(arg_18_1.origin_rank, arg_18_1.new_rank)

	if arg_18_1.is_win then
		self._newStageIndex = self:getCurStageIndex()
	else
		self:updateShopInfo(arg_18_1.shop)

		self._isFailed = true
	end
end

function WushData:updateSelfWeekRank(arg_19_1, arg_19_2)
	self._selfWeekRank = arg_19_2 and arg_19_2 > 0 and arg_19_2 or arg_19_1 or self._selfWeekRank
end

function WushData:resetFailState()
	self._isFailed = false
end

function WushData:resetNewStageIndex()
	self._newStageIndex = -1
end

function WushData:getFloorIdByStage(arg_22_1)
	for iter_22_0 = 1, var_0_1.getLength() do
		local var_22_0 = var_0_1.indexOf(iter_22_0)

		for iter_22_1 = 1, 3 do
			if var_22_0["stage" .. iter_22_1] == arg_22_1 then
				return iter_22_0
			end
		end
	end

	return 0
end

function WushData:getCurFloorStar()
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in ipairs(self._curStar) do
		var_23_0 = var_23_0 + iter_23_1
	end

	return var_23_0
end

function WushData:getCurStageIndex()
	local var_24_0 = var_0_1.get((math.min(var_0_1.getLength(), self._floorId))).type == 2

	if self._boxIsGet then
		if var_24_0 then
			return 2
		else
			return 4
		end
	else
		for iter_24_0 = 1, table.nums(self._curStar) do
			if self._curStar[iter_24_0] == 0 then
				return iter_24_0 - 1
			end
		end

		if self._boxState == 2 then
			if var_24_0 then
				return 1
			else
				return 3
			end
		end
	end
end

function WushData:isNeedReceiveBuff()
	for iter_25_0 = 1, table.nums(self._curBuff) do
		if self._curBuff[iter_25_0] > 0 then
			return true
		end
	end

	return false
end

function WushData:isNeedReceiveBox(arg_26_1)
	if self._boxIsGet then
		return false
	end

	if arg_26_1 and self._curStar[1] and self._curStar[1] > 0 and self._curBuff[1] and self._curBuff[1] == 0 then
		return true
	end

	for iter_26_0 = 1, table.nums(self._curStar) do
		if self._curStar[iter_26_0] <= 0 then
			return false
		end
	end

	if self._curBuff[1] == 0 then
		return true
	end

	return false
end

function WushData:getLeftFailTimes()
	return (math.max(0, tonumber(var_0_4.get(g.core.const.ConstMgr.PARAMETER_CONST.WUSH_FAIL_TIMES).parameter) - self._failTimes))
end

function WushData:getAttrInfoByTalentId(arg_28_1)
	local var_28_0 = var_0_5.get(arg_28_1)
	local var_28_1 = {}

	for iter_28_0 = 1, 3 do
		if var_28_0["affect_type_" .. iter_28_0] > 0 then
			local var_28_2, var_28_3 = g.core.lang:getAttr(var_28_0["affect_type_" .. iter_28_0], var_28_0["affect_value_" .. iter_28_0], false)

			table.insert(var_28_1, {
				name = var_28_2,
				value = var_28_3
			})
		end
	end

	return var_28_1
end

function WushData:_updateTotalAttrDes()
	self._allBuffDes = {}
	self._tokenBuffDes = {}
	self._knightBuffDes = {}

	for iter_29_0, iter_29_1 in pairs(self._totalBuff) do
		local var_29_0, var_29_1 = g.core.lang:getAttr(iter_29_1.id, iter_29_1.value)
		local var_29_2 = g.core.config.attribute_info.get(iter_29_1.id)

		table.insert(self._allBuffDes, {
			name = var_29_0,
			value = var_29_1
		})

		if var_29_2.type == 7 then
			table.insert(self._tokenBuffDes, {
				name = var_29_0,
				value = var_29_1
			})
		else
			table.insert(self._knightBuffDes, {
				name = var_29_0,
				value = var_29_1
			})
		end
	end
end

function WushData:isExistWushShop()
	return checkbool(self._shopInfo and next(self._shopInfo))
end

function WushData:isFinish()
	return self:isPassFinish() or self:getLeftFailTimes() == 0
end

function WushData:isPassFinish()
	return var_0_1.getLength() < self._floorId
end

function WushData:getStageStarByStageIndex(arg_33_1)
	return self:getFloorStarArray()[arg_33_1 + 1]
end

function WushData:isUnRestOrHasLeftCount()
	if not g.core.const.ConstMgr.FUNCTION_TYPE.WUSH_TRIAL then
		return false
	end

	local var_34_0

	if self:isPassFinish() then
		do return false end

		var_34_0 = self:getLeftFailTimes()
	end

	return g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.ShopConst.PLAY_TYPE.WUSH) > 0 or var_34_0 > 0
end

function WushData:reset()
	self._allBuffDes = {}
	self._knightBuffDes = {}
	self._tokenBuffDes = {}
	self._isFreshWeekStar = false
end

function WushData:getShopInfo()
	local var_36_0 = clone(self._shopInfo)

	self._shopInfo = {}

	if var_36_0 then
		local var_36_1 = g.core.common.ServerTime:getTime()

		for iter_36_0 = 1, #var_36_0 do
			if var_36_1 < var_36_0[iter_36_0].due_time then
				table.insert(self._shopInfo, var_36_0[iter_36_0])
			end
		end

		table.sort(self._shopInfo, function(arg_37_0, arg_37_1)
			local var_37_1 = arg_37_1.items or {}
			local var_37_2 = true
			local var_37_3 = true

			for iter_37_0, iter_37_1 in ipairs(arg_37_0.items or {}) do
				if iter_37_1.status == 0 then
					var_37_2 = false
				end
			end

			for iter_37_2, iter_37_3 in ipairs(var_37_1) do
				if iter_37_3.status == 0 then
					var_37_3 = false
				end
			end

			if var_37_2 ~= var_37_3 then
				return not var_37_2
			end

			if arg_37_0.due_time ~= arg_37_1.due_time then
				return arg_37_0.due_time < arg_37_1.due_time
			end

			return false
		end)
	end

	return self._shopInfo
end

function WushData:getWushShopIdArr()
	local var_38_0 = clone(self._deadLineArr)

	self._deadLineArr = {}

	if var_38_0 then
		local var_38_1 = g.core.common.ServerTime:getTime()

		for iter_38_0 = 1, #var_38_0 do
			if var_38_1 < var_38_0[iter_38_0].time then
				table.insert(self._deadLineArr, var_38_0[iter_38_0])
			end
		end

		table.sort(self._deadLineArr, function(arg_39_0, arg_39_1)
			if arg_39_0.time ~= arg_39_1.time then
				return arg_39_0.time < arg_39_1.time
			end

			return false
		end)
	end

	return self._deadLineArr
end

function WushData:isWushCanSwapeLevel(arg_40_1, arg_40_2)
	if self._historyStar[arg_40_1] then
		if arg_40_2 then
			if self._historyStar[arg_40_1] == 9 then
				return true
			end
		elseif self._historyStar[arg_40_1] == 3 then
			return true
		end
	end

	return false
end

function WushData:getHistoryStar(arg_41_1)
	return self._historyStar[arg_41_1] or 0
end

function WushData:saveBussinessNew(arg_42_1)
	self._isBussinessNew = arg_42_1

	local var_42_0 = g.core.common.Storage:load("wush.json") or {}

	var_42_0.bussinessNew = arg_42_1

	g.core.common.Storage:save("wush.json", var_42_0)
end

function WushData:getBoxState()
	return self._boxState
end

function WushData:getCurFloorId()
	return (math.min(var_0_1.getLength(), self._floorId))
end

function WushData:getTotalStar()
	return self._totalStar
end

function WushData:getCurLeftStar()
	return self._leftStar
end

function WushData:getMaxStar()
	return self._maxStar
end

function WushData:getOldMaxFloor()
	return self._oldMaxFloor
end

function WushData:getTotalBuff()
	return self._totalBuff
end

function WushData:getFloorStarArray()
	return self._curStar
end

function WushData:getFloorBuffArray()
	return self._curBuff
end

function WushData:getNewStageIndex()
	return self._newStageIndex
end

function WushData:getTotalAttrDes()
	return self._allBuffDes
end

function WushData:getKnightAttrDes()
	return self._knightBuffDes
end

function WushData:getTokenAttrDes()
	return self._tokenBuffDes
end

function WushData:getRecordMaxStar()
	return self._maxStar
end

function WushData:getWeekMaxStar()
	return self._weekStar
end

function WushData:getFailState()
	return self._isFailed
end

function WushData:getAddedStar()
	return self._addedStar
end

function WushData:isFreshWeekStar()
	return self._isFreshWeekStar
end

function WushData:isBussinessNew()
	return self._isBussinessNew
end

function WushData:getSelfWeekRank()
	return self._selfWeekRank
end

function WushData:setDisplayVersion(arg_63_1)
	self._displayVersion = arg_63_1
end

function WushData:getDisplayVersion()
	return self._displayVersion
end

return WushData
