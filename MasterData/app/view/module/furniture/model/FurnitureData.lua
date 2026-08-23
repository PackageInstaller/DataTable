local var_0_0 = g.core.config.furniture_info
local var_0_1 = g.core.config.dormroom_info
local var_0_2 = g.core.config.homeland_train_base_info
local var_0_3 = g.core.config.furniture_limit_info
local var_0_4 = g.core.const.ConstMgr
local RankAward = require("app.core.common.RankAward")
local var_0_6 = g.core.const.ConstMgr.FurnitureConst
local var_0_7 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_8 = g.core.config.parameter_info
local var_0_9 = g.core.model.User
local var_0_10 = g.core.model.User.itemsData
local var_0_11 = g.core.common.ServerTime
local FurnitureRoom = import(".FurnitureRoom")
local var_0_13 = g.core.model.User.furnitureHandBookData
local FurnitureData = class("FurnitureData", require("app.core.model.BaseData"))

function FurnitureData:ctor()
	self:initData()
end

function FurnitureData:initData()
	self._dormMaxNum = var_0_1.getLength()
	self._roomInfo = {}
	self._checkInKnightIdMap = {}
	self._svrCharmRankAward = {}
	self._friendRoomInfo = {}
	self._charm = 0
	self._sumCharm = 0
	self._friendCharm = 0
	self._friendSweep = {}
	self._friendPraise = {}
	self._praiseRecord = {}
	self._visitSweep = {}
	self._visitFriendSweep = {}
	self._suitList = {}
	self._suitIdList = {}
	self._friendRecordList = {}
end

function FurnitureData:checkExpired(arg_3_1)
	return var_0_11:getTime() - arg_3_1 >= var_0_6.DATA_EXPIRED_INTERVAL
end

function FurnitureData:onS2CFlushRedPoint(arg_4_1)
	if arg_4_1.furniture_room_hint then
		-- block empty
	end
end

function FurnitureData:onS2CFurnitureRoomGetInfo(arg_5_1)
	if not arg_5_1.furniture_room then
		return
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_1.furniture_room) do
		self:getRoomInfo(iter_5_1.room_id):setRoomServerData(iter_5_1)
	end

	self:_updateCheckInKnight()

	self._charm = arg_5_1.week_charm or 0
	self._sumCharm = arg_5_1.sum_charm or 0
	self._friendSweep = {}

	if arg_5_1.friend_sweep then
		for iter_5_2, iter_5_3 in ipairs(arg_5_1.friend_sweep) do
			self._friendSweep[iter_5_3.id] = iter_5_3.num
		end
	end

	self._visitSweep = {}

	if arg_5_1.friend_sweep_snap then
		for iter_5_4, iter_5_5 in ipairs(arg_5_1.friend_sweep_snap) do
			table.insert(self._visitSweep, {
				user = iter_5_5.snap,
				visitTime = iter_5_5.sweep_time
			})
		end
	end

	self._friendRecordList = arg_5_1.records or {}
end

function FurnitureData:onS2CFurnitureRoomUpgrade(arg_6_1)
	self:getRoomInfo(arg_6_1.room_id):setLevel(arg_6_1.room_lv)
end

function FurnitureData:onS2CFurnitureRoomBath(arg_7_1)
	self:getRoomInfo(arg_7_1.room_id):updateFurnitureData(arg_7_1.bathtub)
end

function FurnitureData:onS2CFurnitureRoomPlace(arg_8_1)
	local var_8_0 = self:getRoomInfo(arg_8_1.room_id)

	if arg_8_1.del_furniture then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1.del_furniture) do
			var_8_0:removeFurniture(iter_8_1)
		end
	end

	if arg_8_1.add_furniture then
		for iter_8_2, iter_8_3 in ipairs(arg_8_1.add_furniture) do
			var_8_0:addFurniture(iter_8_3)
		end
	end
end

function FurnitureData:onS2CFurnitureRoomPlaceKnight(arg_9_1)
	if not arg_9_1.knight_id then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.knight_id) do
		self:getRoomInfo(iter_9_1.room_id):setKnightIds(iter_9_1.knight_id)
	end

	self:_updateCheckInKnight()
end

function FurnitureData:onS2CHomeLandTrainDispatch(arg_10_1)
	if not arg_10_1.dispatch then
		return
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_1.dispatch) do
		if iter_10_1.knight_ids then
			for iter_10_2, iter_10_3 in ipairs(iter_10_1.knight_ids) do
				if self._checkInKnightIdMap[iter_10_3] then
					self:getRoomInfo(self._checkInKnightIdMap[iter_10_3]):removeKnightId(iter_10_3)
				end
			end
		end
	end

	self:_updateCheckInKnight()
end

function FurnitureData:onS2CFurnitureGetFriendInfo(arg_11_1)
	if not arg_11_1.furniture_room then
		return
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_1.furniture_room) do
		self:getFriendRoomInfo(iter_11_1.room_id):setRoomServerData(iter_11_1)
	end

	self._friendCharm = arg_11_1.week_charm or 0
	self._friendPraise[arg_11_1.friend_id] = self._friendPraise[arg_11_1.friend_id] or {}

	local var_11_0 = {}

	var_11_0.time = arg_11_1.praise or 0
	var_11_0.value = arg_11_1.week_charm or 0
	var_11_0.sumValue = arg_11_1.sum_charm or 0
	self._friendPraise[arg_11_1.friend_id] = var_11_0
	self._visitFriendSweep = {}

	if arg_11_1.friend_sweep_snap then
		for iter_11_2, iter_11_3 in ipairs(arg_11_1.friend_sweep_snap) do
			table.insert(self._visitFriendSweep, {
				user = iter_11_3.snap,
				visitTime = iter_11_3.sweep_time
			})
		end
	end
end

function FurnitureData:setDailyReportFurniture(arg_12_1)
	if not arg_12_1 then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		self:getFriendRoomInfo(iter_12_1.room_id):setRoomServerData(iter_12_1)
	end
end

function FurnitureData:onS2CFurnitureRoomSweep(arg_13_1)
	self._friendCharm = arg_13_1.charm
	self._friendSweep[arg_13_1.friend_id] = self._friendSweep[arg_13_1.friend_id] or {}
	self._friendSweep[arg_13_1.friend_id] = arg_13_1.num
end

function FurnitureData:onS2CFurnitureRoomSweepOneKey(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1.friend_charms or {}) do
		self._friendSweep[iter_14_1.id] = self._friendSweep[iter_14_1.id] or {}
		self._friendSweep[iter_14_1.id] = iter_14_1.num
	end
end

function FurnitureData:onS2CFurnitureRoomPraise(arg_15_1)
	self._friendPraise[arg_15_1.friend_id] = self._friendPraise[arg_15_1.friend_id] or {}

	local var_15_0 = {}

	var_15_0.time = arg_15_1.num or 0
	var_15_0.value = arg_15_1.week_charm or 0
	var_15_0.sumValue = arg_15_1.sum_charm or 0
	self._friendPraise[arg_15_1.friend_id] = var_15_0
	self._praiseRecord[arg_15_1.friend_id] = arg_15_1.num
end

function FurnitureData:onS2CFurnitureRoomGetPraiseUser(arg_16_1)
	if arg_16_1.user_praise_times then
		self._praiseRecord = {}

		local var_16_0 = arg_16_1.user_praise_times or {}

		for iter_16_0 = 1, #var_16_0 do
			self._praiseRecord[var_16_0[iter_16_0].id] = var_16_0[iter_16_0].num
		end
	end
end

function FurnitureData:getFriendPraiseData(arg_17_1)
	if self._friendPraise[arg_17_1] then
		return self._friendPraise[arg_17_1]
	end

	return nil
end

function FurnitureData:getPraiseTimeInfoById(arg_18_1)
	return (self._praiseRecord[arg_18_1] or nil) and self._praiseRecord[arg_18_1]
end

function FurnitureData:getPraiseRecord()
	return self._praiseRecord
end

function FurnitureData:getVisitData()
	local var_20_0 = g.core.common.ServerTime:getTime()
	local var_20_1 = var_0_8.get(var_0_7.FURNITURE_EXPIRE_TIME).parameter
	local var_20_2 = var_0_8.get(var_0_7.FURNITURE_VISIT_MAX).parameter

	table.sort(self._visitSweep, function(arg_21_0, arg_21_1)
		return arg_21_0.visitTime > arg_21_1.visitTime
	end)

	local var_20_3 = {}

	for iter_20_0, iter_20_1 in ipairs(self._visitSweep) do
		local var_20_4

		if var_20_0 < iter_20_1.visitTime + var_20_1 and 1 <= var_20_2 then
			var_20_4 = 1 + 1

			table.insert(var_20_3, iter_20_1)
		end
	end

	return var_20_3
end

function FurnitureData:getVisitFriendData()
	local var_22_0 = g.core.common.ServerTime:getTime()
	local var_22_1 = var_0_8.get(var_0_7.FURNITURE_EXPIRE_TIME).parameter
	local var_22_2 = var_0_8.get(var_0_7.FURNITURE_VISIT_MAX).parameter

	table.sort(self._visitFriendSweep, function(arg_23_0, arg_23_1)
		return arg_23_0.visitTime > arg_23_1.visitTime
	end)

	local var_22_3 = {}

	for iter_22_0, iter_22_1 in ipairs(self._visitFriendSweep) do
		local var_22_4

		if var_22_0 < iter_22_1.visitTime + var_22_1 and 1 <= var_22_2 and g.core.model.User:getId() ~= iter_22_1.user.id then
			var_22_4 = 1 + 1

			table.insert(var_22_3, iter_22_1)
		end
	end

	return var_22_3
end

function FurnitureData:getDormMaxNum()
	return self._dormMaxNum
end

function FurnitureData:getFurnitureBasalTypeById(arg_25_1)
	local var_25_0 = var_0_0.get(arg_25_1)

	return var_25_0 and var_25_0.basal_type
end

function FurnitureData:getCheckInCountLimit(arg_26_1)
	return self:getRoomInfo(arg_26_1):getCheckInCountLimit()
end

function FurnitureData:getUnlockLevelByCount(arg_27_1, arg_27_2)
	return self:getRoomInfo(arg_27_1):getUnlockLevelByCount(arg_27_2)
end

function FurnitureData:getCheckInKnightIdsWithDormId(arg_28_1)
	return self:getRoomInfo(arg_28_1):getCheckInKnightIds()
end

function FurnitureData:getFriendCheckInKnightIdsWithDormId(arg_29_1)
	return self:getFriendRoomInfo(arg_29_1):getCheckInKnightIds()
end

function FurnitureData:getFriendCheckInKnightDressIdsWithDormId(arg_30_1)
	return self:getFriendRoomInfo(arg_30_1):getCheckInKnightDressIds()
end

function FurnitureData:getCheckInKnightIds()
	local var_31_0 = {}

	for iter_31_0 = 1, self._dormMaxNum do
		var_31_0[iter_31_0] = self:getCheckInKnightIdsWithDormId(iter_31_0)
	end

	return var_31_0
end

function FurnitureData:getFurnitureListWithDormId(arg_32_1)
	return self:getRoomInfo(arg_32_1):getFurnitureList()
end

function FurnitureData:getFriendFurnitureListWithDormId(arg_33_1)
	return self:getFriendRoomInfo(arg_33_1):getFurnitureList()
end

function FurnitureData:getFurnitureInfo(arg_34_1, arg_34_2)
	return self:getRoomInfo(arg_34_1):getFurnitureInfoWithType(arg_34_2)
end

function FurnitureData:isThereBathCrock(arg_35_1)
	return checkbool((self:getFurnitureInfo(arg_35_1, var_0_6.FURNITURE_TYPE.BATH_CROCK)))
end

function FurnitureData:getFurnitureInfoWithDormIdFId(arg_36_1, arg_36_2)
	return self:getRoomInfo(arg_36_1):getFurnitureInfoWithId(arg_36_2)
end

function FurnitureData:getFurnitureItemDataByType(arg_37_1, arg_37_2)
	local var_37_0 = arg_37_2 and arg_37_2 or 0
	local var_37_1 = {}
	local var_37_2 = var_0_10:getFurnitureData()

	if var_37_2 then
		for iter_37_0 = 1, #var_37_2 do
			local var_37_3 = var_0_0.get(var_37_2[iter_37_0].id)

			if var_37_3 and var_37_3.type == arg_37_1 then
				if var_37_0 ~= 0 then
					if var_37_3.furniture_book == arg_37_2 then
						table.insert(var_37_1, {
							id = var_37_2[iter_37_0].id,
							num = var_37_2[iter_37_0].num
						})
					end
				else
					table.insert(var_37_1, {
						id = var_37_2[iter_37_0].id,
						num = var_37_2[iter_37_0].num
					})
				end
			end
		end
	end

	return var_37_1
end

function FurnitureData:getCanSellFurnitureIdArr()
	local var_38_0 = {}
	local var_38_1 = {
		[var_0_8.get(var_0_6.DEFAULT_FURNITURE_ID_KEY_FLOOR).parameter] = true,
		[var_0_8.get(var_0_6.DEFAULT_FURNITURE_ID_KEY_WALL).parameter] = true,
		[var_0_8.get(var_0_6.DEFAULT_FURNITURE_ID_KEY_BG).parameter] = true
	}

	for iter_38_0, iter_38_1 in ipairs((var_0_10:getFurnitureData())) do
		if not var_38_1[iter_38_1.id] then
			var_38_0[iter_38_1.id] = iter_38_1.num + (var_38_0[iter_38_1.id] or 0)
		end
	end

	local var_38_3 = {}

	for iter_38_2, iter_38_3 in pairs(self._roomInfo) do
		for iter_38_4, iter_38_5 in ipairs((iter_38_3:getFurnitureList())) do
			var_38_3[iter_38_5.furniture_id] = (var_38_3[iter_38_5.furniture_id] or 0) + 1
		end
	end

	for iter_38_6, iter_38_7 in pairs(var_38_0) do
		var_38_0[iter_38_6] = var_38_3[iter_38_6] and var_38_0[iter_38_6] - var_38_3[iter_38_6] or var_38_0[iter_38_6] - 1
	end

	local var_38_5 = table.keys(var_38_0)

	if #var_38_5 > 1 then
		table.sort(var_38_5, self:_getSortRuleInSellList())
	end

	local var_38_6 = {}

	for iter_38_8, iter_38_9 in ipairs(var_38_5) do
		for iter_38_10 = 1, var_38_0[iter_38_9] do
			table.insert(var_38_6, iter_38_9)
		end
	end

	return var_38_6
end

function FurnitureData:_getSortRuleInSellList()
	return function(arg_40_0, arg_40_1)
		local var_40_0 = var_0_0.get(arg_40_0)
		local var_40_1 = var_0_0.get(arg_40_1)

		if var_40_0.quality ~= var_40_1.quality then
			return var_40_0.quality < var_40_1.quality
		else
			return arg_40_0 < arg_40_1
		end
	end
end

function FurnitureData:isThereCDAttribute(arg_41_1)
	return var_0_3.get(arg_41_1).limit_time > 0
end

function FurnitureData:isThereCDAttributeWithId(arg_42_1)
	return self:isThereCDAttribute(var_0_0.get(arg_42_1).type)
end

function FurnitureData:getSubTypeFurnitureOwnCount(arg_43_1, arg_43_2)
	local var_43_0 = self:getFurnitureItemDataByType(arg_43_1, arg_43_2)
	local var_43_1 = 0

	if #var_43_0 > 0 then
		for iter_43_0 = 1, #var_43_0 do
			var_43_1 = var_43_1 + var_43_0[iter_43_0].num
		end
	end

	return var_43_1
end

function FurnitureData:getOtherFloorPlaceCountById(arg_44_1, arg_44_2)
	local var_44_0 = 0

	for iter_44_0, iter_44_1 in pairs(self._roomInfo) do
		if arg_44_1 ~= iter_44_0 then
			for iter_44_2, iter_44_3 in pairs((iter_44_1:getFurnitureList())) do
				if iter_44_3.furniture_id == arg_44_2 then
					var_44_0 = var_44_0 + 1
				end
			end
		end
	end

	return var_44_0
end

function FurnitureData:getAlreadyFurnitureCountByType(arg_45_1)
	local var_45_0 = 0

	for iter_45_0 = 1, self._dormMaxNum do
		for iter_45_1, iter_45_2 in pairs((self:getFurnitureListWithDormId(iter_45_0))) do
			if iter_45_2:getFurnitureType() == arg_45_1 then
				var_45_0 = var_45_0 + 1
			end
		end
	end

	return var_45_0
end

function FurnitureData:getFurnitureInOtherRoomCount(arg_46_1, arg_46_2)
	local var_46_0 = 0

	for iter_46_0 = 1, self._dormMaxNum do
		if iter_46_0 ~= arg_46_1 then
			local var_46_1 = self:getFurnitureListWithDormId(iter_46_0)

			if var_46_1 then
				for iter_46_1, iter_46_2 in pairs(var_46_1) do
					if iter_46_2.furniture_id == arg_46_2 then
						var_46_0 = var_46_0 + 1
					end
				end
			end
		end
	end

	return var_46_0
end

function FurnitureData:getFurnitureHaveCountById(arg_47_1)
	local var_47_0 = 0
	local var_47_1 = var_0_10:getFurnitureData()

	if var_47_1 then
		for iter_47_0 = 1, #var_47_1 do
			if var_47_1[iter_47_0].id == arg_47_1 then
				var_47_0 = var_47_1[iter_47_0].num
			end
		end
	end

	return var_47_0
end

function FurnitureData:getCanPlaceFurnitureCount(arg_48_1)
	return (math.max(self:getSubTypeFurnitureOwnCount(arg_48_1) - self:getAlreadyFurnitureCountByType(arg_48_1), 0))
end

function FurnitureData:isExistKnightCheckIn()
	for iter_49_0 = 1, self._dormMaxNum do
		if #self:getCheckInKnightIdsWithDormId(iter_49_0) > 0 then
			return true
		end
	end

	return false
end

function FurnitureData:getSvrDefLevelForNewFurniture(arg_50_1)
	local var_50_0 = var_0_0.get(arg_50_1).type

	if var_50_0 == var_0_6.FURNITURE_TYPE.GROUND_ADORNMENT then
		return var_0_6.SVR_DEFINITION_LEVEL.FLOOR_DECORATION
	elseif var_50_0 == var_0_6.FURNITURE_TYPE.WALL_DECORATION then
		return var_0_6.SVR_DEFINITION_LEVEL.WALL_DECORATION_LEFT
	elseif var_50_0 == var_0_6.FURNITURE_TYPE.FLOOR then
		return var_0_6.SVR_DEFINITION_LEVEL.FLOOR_LAND
	elseif var_50_0 == var_0_6.FURNITURE_TYPE.WALL then
		return var_0_6.SVR_DEFINITION_LEVEL.WALL_LAND_LEFT
	else
		return var_0_6.SVR_DEFINITION_LEVEL.FLOOR_FURNITURE
	end
end

function FurnitureData:checkIsNewFurniture(arg_51_1)
	if arg_51_1.all then
		return (self:checkAllFurnitureNew())
	elseif arg_51_1.furnitureType then
		return (self:checkFurnitureNewByType(arg_51_1.furnitureType))
	elseif arg_51_1.id then
		return (var_0_9.bagData:getNewData(var_0_4.BAG_TYPE.FURNISHING, arg_51_1.id))
	else
		return false
	end
end

function FurnitureData:checkAllFurnitureNew()
	for iter_52_0 = 1, table.nums(var_0_6.FURNITURE_TYPE) do
		if self:checkFurnitureNewByType(iter_52_0) then
			return true
		end
	end

	return false
end

function FurnitureData:checkFurnitureNewByType(arg_53_1)
	local var_53_0 = self:getFurnitureItemDataByType(arg_53_1)

	if #var_53_0 > 0 then
		for iter_53_0 = 1, #var_53_0 do
			if var_0_9.bagData:getNewData(var_0_4.BAG_TYPE.FURNISHING, var_53_0[iter_53_0].id) then
				return true
			end
		end
	else
		return false
	end
end

function FurnitureData:getRoomInfo(arg_54_1)
	self._roomInfo[arg_54_1] = self._roomInfo[arg_54_1] or FurnitureRoom.new(arg_54_1)

	return self._roomInfo[arg_54_1]
end

function FurnitureData:getFriendRoomInfo(arg_55_1)
	self._friendRoomInfo[arg_55_1] = self._friendRoomInfo[arg_55_1] or FurnitureRoom.new(arg_55_1)

	return self._friendRoomInfo[arg_55_1]
end

function FurnitureData:isDormUnlocked(arg_56_1, arg_56_2)
	local var_56_0 = var_0_1.get(arg_56_1)

	if var_56_0.unlock_type == var_0_6.UNLOCK_COND_TYPE.NONE then
		return true
	elseif var_56_0.unlock_type == var_0_6.UNLOCK_COND_TYPE.HL_TRAIN_ROOM_UNLOCKED then
		return var_0_9.hlTrainData:isRoomUnlocked(var_56_0.unlock_value)
	elseif var_56_0.unlock_type == var_0_6.UNLOCK_COND_TYPE.DORM_LEVEL then
		return (arg_56_2 and self:getFriendRoomInfo(var_56_0.unlock_value) or self:getRoomInfo(var_56_0.unlock_value)):getLevel() >= var_56_0.unlock_size
	else
		g.core.log:error("--------      Error! Unknown dorm unlock Type :", tostring(var_56_0.unlock_type))

		return false
	end
end

function FurnitureData:getDormUnlockConditionDesc(arg_57_1)
	local var_57_0 = var_0_1.get(arg_57_1)

	if var_57_0.unlock_type == var_0_6.UNLOCK_COND_TYPE.NONE then
		return ""
	elseif var_57_0.unlock_type == var_0_6.UNLOCK_COND_TYPE.HL_TRAIN_ROOM_UNLOCKED then
		return g.core.lang:get(112533, {
			name = var_0_2.get(var_57_0.unlock_value).name
		})
	elseif var_57_0.unlock_type == var_0_6.UNLOCK_COND_TYPE.DORM_LEVEL then
		return g.core.lang:get(112546, {
			floor = var_57_0.unlock_value,
			level = var_57_0.unlock_size
		})
	else
		g.core.log:error("--------      Error! Unknown dorm unlock Type :", tostring(var_57_0.unlock_type))

		return ""
	end
end

function FurnitureData:getBathCrockState(arg_58_1)
	if not arg_58_1 then
		return var_0_6.BATH_CROCK_STATE.NOT_PLACED
	else
		local var_58_0 = arg_58_1:getCDEndTime()

		if not var_58_0 or var_58_0 <= var_0_11:getTime() then
			return var_0_6.BATH_CROCK_STATE.CAN_USE
		else
			return var_0_6.BATH_CROCK_STATE.CD
		end
	end
end

function FurnitureData:isKnightCheckIn(arg_59_1)
	return checkbool(self._checkInKnightIdMap[arg_59_1])
end

function FurnitureData:getCheckInDormId(arg_60_1)
	return self._checkInKnightIdMap[arg_60_1]
end

function FurnitureData:_updateCheckInKnight()
	local var_61_0 = {}

	for iter_61_0 = 1, self._dormMaxNum do
		for iter_61_1, iter_61_2 in ipairs((self:getCheckInKnightIdsWithDormId(iter_61_0))) do
			var_61_0[iter_61_2] = iter_61_0
		end
	end

	self._checkInKnightIdMap = var_61_0
end

function FurnitureData:getMobilityRecoverBaseSpeedWithKnightId(arg_62_1)
	if self._checkInKnightIdMap[arg_62_1] then
		return self:getRoomInfo(self._checkInKnightIdMap[arg_62_1]):getMobilityRecoverBaseSpeed()
	else
		return 0
	end
end

function FurnitureData:isCanLevelUp(arg_63_1)
	return self:getRoomInfo(arg_63_1):isCanLevelUp()
end

function FurnitureData:isCanLevelUpWithCustomData(arg_64_1)
	if arg_64_1.dormId then
		return self:getRoomInfo(arg_64_1.dormId):isCanLevelUp()
	end

	return false
end

function FurnitureData:getDormFloorData()
	local var_65_0 = {}

	for iter_65_0 = 1, var_0_1.getLength() do
		table.insert(var_65_0, var_0_1.indexOf(iter_65_0).id)
	end

	table.sort(var_65_0, function(arg_66_0, arg_66_1)
		if arg_66_0 ~= arg_66_1 then
			return arg_66_1 < arg_66_0
		end

		return false
	end)

	return var_65_0
end

function FurnitureData:getDormIdByFloorIdx(arg_67_1)
	local var_67_0 = 0

	for iter_67_0, iter_67_1 in ipairs((self:getDormFloorData())) do
		if iter_67_0 == arg_67_1 then
			var_67_0 = iter_67_1
		end
	end

	return var_67_0
end

function FurnitureData:getFloorIdxByDormId(arg_68_1)
	local var_68_0 = 0

	for iter_68_0, iter_68_1 in ipairs((self:getDormFloorData())) do
		if iter_68_1 == arg_68_1 then
			var_68_0 = iter_68_0
		end
	end

	return var_68_0
end

function FurnitureData:isCheckInBtnNotClicked()
	local var_69_0 = false

	if self:_getJsonDict().checkInBtnClicked == 1 then
		var_69_0 = true
	elseif self:isExistKnightCheckIn() then
		self:saveCheckInBtnClicked()

		var_69_0 = true
	end

	return not var_69_0
end

function FurnitureData:saveCheckInBtnClicked()
	local var_70_0 = self:_getJsonDict()

	if var_70_0.checkInBtnClicked ~= 1 then
		var_70_0.checkInBtnClicked = 1

		g.core.common.Storage:save(var_0_6.JSON_NAME, var_70_0)
	end
end

function FurnitureData:isDormPromptedUpgrade(arg_71_1)
	return self:_getJsonDict()[self:getRoomInfo(arg_71_1):getKeySaveUpgradePrompt()] == 1
end

function FurnitureData:savePromptedUpgradeDorm(arg_72_1)
	local var_72_0 = self:getRoomInfo(arg_72_1):getKeySaveUpgradePrompt()
	local var_72_1 = self:_getJsonDict()

	if var_72_1[var_72_0] ~= 1 then
		var_72_1[var_72_0] = 1

		g.core.common.Storage:save(var_0_6.JSON_NAME, var_72_1)
	end
end

function FurnitureData:_getJsonDict()
	return g.core.common.Storage:load(var_0_6.JSON_NAME) or {}
end

function FurnitureData:getNeedCheckInKnights()
	local var_74_0 = {}

	for iter_74_0, iter_74_1 in ipairs((self:getKnightsMobilityLessThanPercentage(10))) do
		if not self:isKnightCheckIn((iter_74_1:getServerId())) then
			table.insert(var_74_0, iter_74_1)
		end
	end

	return var_74_0
end

function FurnitureData:getKnightsMobilityLessThanPercentage(arg_75_1)
	arg_75_1 = arg_75_1 or 0
	arg_75_1 = math.min(100, arg_75_1)
	arg_75_1 = math.max(0, arg_75_1)

	if arg_75_1 == 0 then
		return {}
	end

	arg_75_1 = arg_75_1 / 100

	return (var_0_9.knightsData:getSpList(function(arg_76_0)
		if arg_76_0:isCanCheckIn() then
			return arg_76_0:getMobilityVal() / arg_76_0:getMaxMobility() < arg_75_1
		end

		return false
	end))
end

function FurnitureData:getCheckInKnightIdsFullMobility()
	local var_77_0 = {}

	for iter_77_0, iter_77_1 in pairs(self._roomInfo) do
		table.insertto(var_77_0, (iter_77_1:getCheckInKnightIdsFullMobility()))
	end

	return var_77_0
end

function FurnitureData:getEmptyPlaceNum()
	local var_78_0 = 0

	for iter_78_0 = 1, self._dormMaxNum do
		if self:isDormUnlocked(iter_78_0) then
			var_78_0 = var_78_0 + self:getRoomInfo(iter_78_0):getEmptyPlaceNum()
		end
	end

	return var_78_0
end

function FurnitureData:initServerCharmRankAward()
	if self._dataInit then
		return
	end

	self._dataInit = true

	for iter_79_0, iter_79_1 in ipairs((RankAward:getRankAwardArray(var_0_4.RankAwardConst.FURNITURE_CHARM))) do
		for iter_79_2 = iter_79_1.minRank, iter_79_1.maxRank do
			self._svrCharmRankAward[iter_79_2] = iter_79_1
		end
	end
end

function FurnitureData:getServerCharmRankAward(arg_80_1)
	self:initServerCharmRankAward()

	return self._svrCharmRankAward[arg_80_1]
end

function FurnitureData:getCharmValue()
	return self._charm
end

function FurnitureData:getSumCharmValue()
	return self._sumCharm
end

function FurnitureData:getFriendCharmValue()
	return self._friendCharm
end

function FurnitureData:getSweepDailyMaxTime()
	return tonumber(g.core.config.play_num_info.get(var_0_6.FURNITURE_SWEEP_INFO_ID).reset or 0)
end

function FurnitureData:getCurSweepTime()
	local var_85_0 = 0

	for iter_85_0, iter_85_1 in pairs(self._friendSweep) do
		var_85_0 = var_85_0 + tonumber(iter_85_1)
	end

	return (math.max(0, self:getSweepDailyMaxTime() - var_85_0))
end

function FurnitureData:randomDormIdToSweep()
	local var_86_0 = self:getDormMaxNum()
	local var_86_1 = 1

	repeat
		var_86_1 = math.random(1, var_86_0)
	until self:isDormUnlocked(var_86_1, true)

	return var_86_1
end

function FurnitureData:getFriendSweepTime(arg_87_1)
	return (self._friendSweep[arg_87_1] or nil) and self._friendSweep[arg_87_1]
end

function FurnitureData:isCanCleanFurnitureByUserId(arg_88_1, arg_88_2)
	local var_88_0 = g.core.model.User.friendData:getFriendInfoById(arg_88_1)

	if self:getCurSweepTime() > 0 and self:getFriendSweepTime(arg_88_1) < g.core.config.parameter_info.get(var_0_6.FURNITURE_LIMIT_SWEEP_ID).parameter and g.core.model.User.friendData:isInFriendList(arg_88_1) then
		if arg_88_2 and var_88_0 and var_88_0:isCrossServerFriend() then
			return false
		end

		return true
	end

	return false
end

function FurnitureData:getNumRecommendCheckIn()
	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_4.FUNCTION_TYPE.HOME_LAND_FURNITURE) then
		return 0
	end

	local var_89_0 = self:getEmptyPlaceNum() + #self:getCheckInKnightIdsFullMobility()

	if var_89_0 == 0 then
		return 0
	else
		return math.min(var_89_0, #self:getNeedCheckInKnights())
	end
end

function FurnitureData:checkHaveCleanRoomFriends()
	for iter_90_0, iter_90_1 in ipairs((g.core.model.User.friendData:getFriendList())) do
		if self:isCanCleanFurnitureByUserId((iter_90_1:getFriendId())) then
			return true
		end
	end

	return false
end

function FurnitureData:getEditIdArr(arg_91_1)
	return self:getRoomInfo(arg_91_1):getEditIdArr()
end

function FurnitureData:getAllFurnitureSuit()
	local var_92_0 = {}
	local var_92_1 = {}
	local var_92_2 = var_0_10:getFurnitureData()

	if var_92_2 then
		for iter_92_0 = 1, #var_92_2 do
			local var_92_3 = {}

			var_92_3.furnitureId = var_92_2[iter_92_0].id
			var_92_3.suitBookId = var_0_0.get(var_92_2[iter_92_0].id).furniture_book

			if var_92_3.suitBookId > 0 and not var_92_1[var_92_3.suitBookId] then
				var_92_3.bookInfo = g.core.config.furniture_book_info.get(var_92_3.suitBookId).toObject()
				var_92_3.totalOwnCount, var_92_3.totalCount = var_0_13:getCollectKitCount(var_92_3.suitBookId), #var_0_13:getFurnituresByKitIdWithoutOrder(var_92_3.suitBookId)
				var_92_1[var_92_3.suitBookId] = var_92_3

				table.insert(var_92_0, var_92_3)
			end
		end
	end

	self:_sortSuitBook(var_92_0)
	table.insert(var_92_0, {
		suitBookId = 0,
		isAllSuit = true
	})

	self._suitList = var_92_0
	self._suitIdList = var_92_1

	return var_92_0
end

function FurnitureData:_sortSuitBook(arg_93_1)
	table.sort(arg_93_1, function(arg_94_0, arg_94_1)
		if arg_94_0.suitBookId ~= arg_94_1.suitBookId then
			return arg_94_0.suitBookId < arg_94_1.suitBookId
		end

		return false
	end)
end

function FurnitureData:getSuitInfoById(arg_95_1)
	if arg_95_1 then
		return self._suitIdList[arg_95_1]
	end
end

function FurnitureData:getFriendRecordList()
	return self._friendRecordList
end

return FurnitureData
