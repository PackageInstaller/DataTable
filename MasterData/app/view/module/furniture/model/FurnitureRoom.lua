local var_0_0 = g.core.config.furniture_info
local var_0_1 = g.core.config.dormroom_upgrade_info
local var_0_2 = g.core.config.furniture_unlock_info
local var_0_3 = g.core.config.dormroom_attribute_info
local var_0_4 = g.core.const.ConstMgr.FurnitureConst
local FurnitureStruct = import(".FurnitureStruct")
local var_0_6 = g.core.model.User.bagData
local var_0_7 = g.core.model.User.hlTrainData
local var_0_8 = g.core.model.User.knightsData
local FurnitureRoom = class("FurnitureRoom")

function FurnitureRoom:ctor(arg_1_1)
	self._dormId = arg_1_1
	self._level = 1
	self._comfort = 0
	self._checkInKnightList = {}
	self._checkInKnightDressList = {}
	self._furnitureList = {}
end

function FurnitureRoom:setRoomServerData(arg_2_1)
	self._level = arg_2_1.level or 1

	self:setKnightIds(arg_2_1.knight_id)
	self:setKnightDressIds(arg_2_1.dress_id)
	self:setFurniture(arg_2_1.furniture)
end

function FurnitureRoom:getCheckInKnightIds()
	return self._checkInKnightList
end

function FurnitureRoom:getCheckInKnightDressIds()
	return self._checkInKnightDressList
end

function FurnitureRoom:getCheckInKnightIdsFullMobility()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self._checkInKnightList) do
		local var_5_1 = var_0_8:getKnightById(iter_5_1)

		if not var_5_1 then
			-- block empty
		elseif var_5_1:getMobilityVal() >= var_5_1:getMaxMobility() then
			table.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function FurnitureRoom:setFurniture(arg_6_1)
	if arg_6_1 then
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			table.insert(var_6_0, FurnitureStruct.new(iter_6_1))
		end

		self._furnitureList = var_6_0
	else
		self._furnitureList = {}
	end

	self:_updateComfort()
end

function FurnitureRoom:addFurniture(arg_7_1)
	table.insert(self._furnitureList, (FurnitureStruct.new(arg_7_1)))
	self:_updateComfort()
end

function FurnitureRoom:removeFurniture(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self._furnitureList) do
		if iter_8_1:isSame(arg_8_1) then
			table.remove(self._furnitureList, iter_8_0)

			break
		end
	end

	self:_updateComfort()
end

function FurnitureRoom:setKnightIds(arg_9_1)
	if arg_9_1 then
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			if iter_9_1 > 0 then
				table.insert(var_9_0, iter_9_1)
			end
		end

		self._checkInKnightList = var_9_0
	else
		self._checkInKnightList = {}
	end
end

function FurnitureRoom:setKnightDressIds(arg_10_1)
	if arg_10_1 then
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
			if iter_10_1 > 0 then
				table.insert(var_10_0, iter_10_1)
			end
		end

		self._checkInKnightDressList = var_10_0
	else
		self._checkInKnightDressList = {}
	end
end

function FurnitureRoom:removeKnightId(arg_11_1)
	if not arg_11_1 or arg_11_1 == 0 then
		return
	end

	local var_11_0 = 0

	for iter_11_0 = 1, #self._checkInKnightList do
		if arg_11_1 == self._checkInKnightList[iter_11_0] then
			var_11_0 = iter_11_0

			break
		end
	end

	table.removebyvalue(self._checkInKnightList, arg_11_1, false)

	if var_11_0 ~= 0 and self._checkInKnightDressList[var_11_0] then
		table.removebyvalue(self._checkInKnightDressList, self._checkInKnightDressList[var_11_0], false)
	end
end

function FurnitureRoom:getFurnitureList()
	return self._furnitureList
end

function FurnitureRoom:getFurnitureInfoWithType(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(self._furnitureList) do
		if var_0_0.get(iter_13_1.furniture_id).type == arg_13_1 then
			return iter_13_1
		end
	end
end

function FurnitureRoom:getFurnitureInfoWithId(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self._furnitureList) do
		if iter_14_1.furniture_id == arg_14_1 then
			return iter_14_1
		end
	end
end

function FurnitureRoom:updateFurnitureData(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self._furnitureList) do
		if iter_15_1.furniture_id == arg_15_1.furniture_id then
			iter_15_1:updateData(arg_15_1)

			break
		end
	end
end

function FurnitureRoom:_updateComfort()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs((self:getFurnitureList())) do
		var_16_0 = var_16_0 + var_0_0.get(iter_16_1.furniture_id).comfort
	end

	self._comfort = math.min(self:getComfortLimit(), var_16_0)
end

function FurnitureRoom:getComfort()
	return self._comfort
end

function FurnitureRoom:getComfortLimit(arg_18_1)
	arg_18_1 = arg_18_1 or self._level

	for iter_18_0, iter_18_1 in var_0_1.ipairs() do
		if iter_18_1.room_id == self._dormId and iter_18_1.level == arg_18_1 then
			return iter_18_1.comfort_limit
		end
	end

	return 0
end

function FurnitureRoom:getMobilityRecoverBaseSpeed(arg_19_1)
	arg_19_1 = arg_19_1 or self._level

	for iter_19_0, iter_19_1 in var_0_1.ipairs() do
		if iter_19_1.room_id == self._dormId and iter_19_1.level == arg_19_1 then
			return (math.ceil(iter_19_1.heal_mobility * 3600 / iter_19_1.heal_mobility_time))
		end
	end

	return 0
end

function FurnitureRoom:getMobilityRecoverAddSpeed()
	return (math.ceil(g.core.config.parameter_info.get(var_0_4.MOBILITY_RECOVER_FACTOR_ID).parameter / 10000 * self:getComfort()))
end

function FurnitureRoom:getLevel()
	return self._level
end

function FurnitureRoom:setLevel(arg_22_1)
	self._level = arg_22_1

	self:_updateComfort()
end

function FurnitureRoom:isMaxLevel()
	return self:getNextLevel() == 0
end

function FurnitureRoom:getNextLevel()
	for iter_24_0, iter_24_1 in var_0_1.ipairs() do
		if iter_24_1.room_id == self._dormId and iter_24_1.level == self._level then
			return iter_24_1.next_level
		end
	end
end

function FurnitureRoom:getKeySaveUpgradePrompt()
	return self._dormId .. self._level
end

function FurnitureRoom:getUpUpgradeInfo()
	local var_26_0 = self._dormId
	local var_26_1 = self._level

	return var_0_1.match(function(arg_27_0)
		return arg_27_0.room_id == var_26_0 and arg_27_0.level == var_26_1
	end)[1]
end

function FurnitureRoom:isCanLevelUp()
	local var_28_0 = self:getUpUpgradeInfo()

	if not var_28_0 then
		return false
	elseif var_28_0.next_level == 0 then
		return false
	elseif var_28_0.update_type == var_0_4.LEVEL_UP_COND_TYPE.NONE then
		return true
	elseif var_28_0.update_type == var_0_4.LEVEL_UP_COND_TYPE.HL_TRAIN_ROOM_LEVEL then
		local var_28_1 = var_0_7:getRoomStruct(var_28_0.update_value_1)

		if var_28_1:isUnlocked() and var_28_0.update_value_2 <= var_28_1.curLevel then
			return true
		else
			local var_28_2 = {}

			var_28_2.name = var_28_1.refCfgBaseInfo.name
			var_28_2.num = var_28_0.update_value_2

			return false, g.core.lang:get(112539, var_28_2)
		end
	else
		g.core.log:error("------    dormroom_upgrade_info.update_type is unknown:", var_28_0.update_type)

		return false
	end
end

function FurnitureRoom:isEnoughItemLevelUpNeed()
	local var_29_0 = self:getUpUpgradeInfo()

	if not var_29_0 then
		return false
	elseif var_29_0.upgrade_cost_type == 0 then
		return true
	else
		return var_0_6:getCountById(var_29_0.upgrade_cost_type, var_29_0.upgrade_cost_value) >= var_29_0.upgrade_cost_size
	end
end

function FurnitureRoom:getCheckInCountLimit(arg_30_1)
	arg_30_1 = arg_30_1 or self._level

	for iter_30_0 = var_0_2.getLength(), 1, -1 do
		local var_30_0 = var_0_2.indexOf(iter_30_0)

		if var_30_0.room == self._dormId and arg_30_1 >= var_30_0.unlock_lev then
			return var_30_0.order
		end
	end

	return 1
end

function FurnitureRoom:getUnlockLevelByCount(arg_31_1)
	local var_31_0 = 0

	for iter_31_0 = 1, var_0_2.getLength() do
		local var_31_1 = var_0_2.indexOf(iter_31_0)

		if self._dormId == var_31_1.room and arg_31_1 == var_31_1.order then
			var_31_0 = var_31_1.unlock_lev
		end
	end

	return var_31_0
end

function FurnitureRoom:getEmptyPlaceNum()
	return self:getCheckInCountLimit() - #self._checkInKnightList
end

function FurnitureRoom:getActivatedAttributeArr()
	local var_33_0 = self._dormId
	local var_33_1 = self._comfort

	return var_0_3.match(function(arg_34_0)
		return var_33_0 == arg_34_0.floor_id and var_33_1 >= arg_34_0.comfort
	end)
end

function FurnitureRoom:getInactiveAttributeArr()
	local var_35_0 = self._dormId
	local var_35_1 = self:getComfort()

	return var_0_3.match(function(arg_36_0)
		return var_35_0 == arg_36_0.floor_id and var_35_1 < arg_36_0.comfort
	end)
end

function FurnitureRoom:getAttributesSumArr(arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs((self:getAttributesSumDict(arg_37_1))) do
		table.insert(var_37_0, {
			attributeType = iter_37_0,
			attributeValue = iter_37_1
		})
	end

	return var_37_0
end

function FurnitureRoom:getAttributesSumDict(arg_38_1)
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs(arg_38_1) do
		var_38_0[iter_38_1.attribute_type] = (var_38_0[iter_38_1.attribute_type] or 0) + iter_38_1.attribute_value
	end

	return var_38_0
end

function FurnitureRoom:getNewActivatedAttributeArr(arg_39_1)
	arg_39_1 = arg_39_1 or 0

	local var_39_0 = {}

	if arg_39_1 < self._comfort then
		for iter_39_0, iter_39_1 in var_0_3.ipairs() do
			if iter_39_1.floor_id == self._dormId and arg_39_1 < iter_39_1.comfort and iter_39_1.comfort <= self._comfort then
				table.insert(var_39_0, iter_39_1)
			end
		end
	end

	return var_39_0
end

function FurnitureRoom:getEditIdArr()
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(self._furnitureList) do
		table.insert(var_40_0, (iter_40_1:getEditId()))
	end

	return var_40_0
end

return FurnitureRoom
