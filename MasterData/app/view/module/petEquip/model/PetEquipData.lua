local PetEquipData = class("PetEquipData")
local PetEquipStruct = import(".PetEquipStruct")
local var_0_2 = g.core.config.pet_equipment_info
local var_0_3 = g.core.config.pet_equipment_attribute_info
local var_0_4 = g.core.config.role_info
local var_0_5 = g.core.config.parameter_info
local var_0_6 = g.core.const.ConstMgr.PetEquipConst
local var_0_7 = g.core.const.ConstMgr.PetConst.FORMATION_NUM
local var_0_8 = g.core.const.ConstMgr.PARAMETER_CONST

function PetEquipData:ctor()
	self:initData()
end

function PetEquipData:initData()
	self._allPetEquipMap = {}
	self._allPetEquips = {}
	self._allEquipedPetEquips = {}
	self._isPrompted = false
	self._isOnekeyPrompted = false
	self._isLockPrompted = false
	self._matIsNotEnoughtMatId = 0
	self._wearEquipRecomEquipIds = {}

	for iter_2_0 = 1, var_0_2.getLength() do
		local var_2_0 = var_0_2.indexOf(iter_2_0)
		local var_2_1

		if var_2_0.type == var_0_6.PETEQUIPTYPEEXP then
			if 0 < var_2_0.exp then
				var_2_1 = var_2_0.exp
				self._matIsNotEnoughtMatId = var_2_0.id
			end
		else
			self._wearEquipRecomEquipIds[var_2_0.type] = self._wearEquipRecomEquipIds[var_2_0.type] or var_2_0.id
		end
	end

	self._specialShowMinQua = checknumber(var_0_5.get(var_0_8.PETEQUIP_SPECIAL_SHOW_MIN_QUA).parameter)
	self._petEquipsInAwards = {}
	self._petEquipsShouldSpecialShow = {}
end

function PetEquipData:getMatIsNotEnoughMatId()
	return self._matIsNotEnoughtMatId
end

function PetEquipData:getWearEquipRecomIdByTp(arg_4_1)
	return self._wearEquipRecomEquipIds[arg_4_1]
end

function PetEquipData:updateAllPetEquip()
	self._allPetEquips = {}
	self._allEquipedPetEquips = {}

	for iter_5_0, iter_5_1 in ipairs((g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.PET_EQUIPMENT))) do
		if not self._allPetEquipMap[iter_5_1.id] then
			local var_5_0 = PetEquipStruct.new()

			var_5_0:setCfg((var_0_2.get(iter_5_1.base_id)))

			self._allPetEquipMap[iter_5_1.id] = var_5_0
		end

		local var_5_1 = self._allPetEquipMap[iter_5_1.id]

		self._allPetEquipMap[iter_5_1.id]:setServerData(iter_5_1)

		iter_5_1.score = var_5_1:getCfg().basic_score

		for iter_5_2, iter_5_3 in ipairs(var_5_1:getLegendAttList().attribute_ids) do
			local var_5_2 = var_0_3.fetch(iter_5_3)

			if var_5_2 then
				iter_5_1.score = iter_5_1.score + var_5_2.score
			end
		end

		table.insert(self._allPetEquips, var_5_1)

		if iter_5_1.position > 0 then
			local var_5_3 = math.ceil(iter_5_1.position / var_0_6.PETEQUIPTYPENUM)

			self._allEquipedPetEquips[var_5_3] = self._allEquipedPetEquips[var_5_3] or {}
			self._allEquipedPetEquips[var_5_3][var_5_1:getCfg().type] = var_5_1
		end
	end
end

function PetEquipData:removePetEquips(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if self._allPetEquipMap[iter_6_1] then
			local var_6_0 = self._allPetEquipMap[iter_6_1]:getPosition()

			if var_6_0 > 0 then
				self._allEquipedPetEquips[math.ceil(var_6_0 / var_0_6.PETEQUIPTYPENUM)][self._allPetEquipMap[iter_6_1]:getCfg().type] = nil
			end

			self._allPetEquipMap[iter_6_1] = nil

			for iter_6_2, iter_6_3 in ipairs(self._allPetEquips) do
				if iter_6_1 == iter_6_3:getSid() then
					table.remove(self._allPetEquips, iter_6_2)

					break
				end
			end
		end
	end
end

function PetEquipData:getAllEquipedPetEquips()
	return self._allEquipedPetEquips
end

function PetEquipData:getAllEquipsEquipedByPet(arg_8_1)
	local var_8_0 = {}

	if self._allEquipedPetEquips[arg_8_1] then
		var_8_0 = table.values(self._allEquipedPetEquips[arg_8_1])

		table.sort(var_8_0, function(arg_9_0, arg_9_1)
			return arg_9_0:getCfg().type < arg_9_1:getCfg().type
		end)
	end

	return var_8_0
end

function PetEquipData:checkIsCanEatExpInEquipedEquips()
	for iter_10_0, iter_10_1 in pairs(self._allEquipedPetEquips) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			local var_10_0 = iter_10_3:getSid()

			if iter_10_3:isCanEatExp() then
				return true
			end
		end
	end

	return false
end

function PetEquipData:checkIsCanEatExp(arg_11_1)
	return self._allPetEquipMap[arg_11_1]:isCanEatExp()
end

function PetEquipData:getEquipByPos(arg_12_1)
	local var_12_0 = math.ceil(arg_12_1 / 3)

	if not self._allEquipedPetEquips[var_12_0] then
		return nil
	end

	return self._allEquipedPetEquips[var_12_0][(arg_12_1 - 1) % 3 + 1]
end

function PetEquipData:checkHasHigherEquipByPos(arg_13_1)
	local var_13_0 = self:getEquipByPos(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs(self._allPetEquips) do
		if ((var_13_0 or nil) and var_13_0:getServerData().score) < iter_13_1:getScore() and iter_13_1:getPosition() == 0 and iter_13_1:getCfg().type == (arg_13_1 - 1) % 3 + 1 then
			return true
		end
	end

	return false
end

function PetEquipData:getAllPetEquipMap()
	return self._allPetEquipMap
end

function PetEquipData:getAllPetEquips()
	return self._allPetEquips
end

function PetEquipData:getPetEquipById(arg_16_1)
	return self._allPetEquipMap[arg_16_1]
end

function PetEquipData:getPetEquipBaseAtt(arg_17_1, arg_17_2)
	local var_17_0 = var_0_2.get(arg_17_1)
	local var_17_1 = {}

	for iter_17_0 = 1, 4 do
		if var_0_2.hasKey("basic_type_" .. iter_17_0) then
			table.insert(var_17_1, {
				k = var_17_0["basic_type_" .. iter_17_0],
				v = var_17_0["basic_value_" .. iter_17_0] + (arg_17_2 - 1) * var_17_0["basic_growth_" .. iter_17_0]
			})
		end
	end

	return var_17_1
end

function PetEquipData:getPetEquipBaseAttAndAddAtt(arg_18_1, arg_18_2)
	local var_18_0 = var_0_2.get(arg_18_1)
	local var_18_1 = {}

	for iter_18_0 = 1, 4 do
		if var_0_2.hasKey("basic_type_" .. iter_18_0) then
			table.insert(var_18_1, {
				k = var_18_0["basic_type_" .. iter_18_0],
				base = var_18_0["basic_value_" .. iter_18_0],
				add = (arg_18_2 - 1) * var_18_0["basic_growth_" .. iter_18_0]
			})
		end
	end

	return var_18_1
end

function PetEquipData:getEquipLevelUpNeedExp(arg_19_1, arg_19_2)
	local var_19_0 = var_0_2.get(arg_19_1)

	return math.ceil(var_19_0.strength_parameter_1 * math.pow(arg_19_2, 1.7) + var_19_0.strength_parameter_2 * arg_19_2)
end

function PetEquipData:createUnwearEquips()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(self._allPetEquips) do
		if iter_20_1:getPosition() == 0 then
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function PetEquipData:createEquipBagData(arg_21_1)
	local var_21_0 = arg_21_1 and self:createUnwearEquips() or self._allPetEquips

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:getPosition()
		local var_22_1 = arg_22_1:getPosition()
		local var_22_2 = arg_22_0:getLevel()
		local var_22_3 = arg_22_1:getLevel()
		local var_22_4 = arg_22_0:getScore()
		local var_22_5 = arg_22_1:getScore()
		local var_22_6 = arg_22_0:getCfg()
		local var_22_7 = arg_22_1:getCfg()
		local var_22_8 = var_22_6.type
		local var_22_9 = var_22_7.type
		local var_22_10 = var_22_6.class
		local var_22_11 = var_22_7.class
		local var_22_12 = var_22_6.quality
		local var_22_13 = var_22_7.quality

		if var_22_0 ~= 0 and var_22_1 ~= 0 then
			return var_22_0 < var_22_1
		elseif var_22_0 == 0 and var_22_1 == 0 then
			if var_22_8 ~= var_22_9 then
				return var_22_8 < var_22_9
			elseif var_22_10 ~= var_22_11 then
				return var_22_11 < var_22_10
			elseif var_22_12 ~= var_22_13 then
				return var_22_13 < var_22_12
			elseif var_22_2 ~= var_22_3 then
				return var_22_3 < var_22_2
			else
				return var_22_5 < var_22_4
			end
		else
			return var_22_1 < var_22_0
		end
	end)

	return var_21_0
end

function PetEquipData:hasEquipToEquipByTp(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(self._allPetEquips) do
		if iter_23_1:getType() == arg_23_1 and iter_23_1:getPosition() == 0 then
			return true
		end
	end

	return false
end

function PetEquipData:createChooseEquipListByTp(arg_24_1, arg_24_2)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self._allPetEquips) do
		if arg_24_1 == iter_24_1:getCfg().type then
			if arg_24_2 and iter_24_1:getPosition() == 0 then
				table.insert(var_24_0, iter_24_1)
			elseif not arg_24_2 then
				table.insert(var_24_0, iter_24_1)
			end
		end
	end

	table.sort(var_24_0, function(arg_25_0, arg_25_1)
		local var_25_0 = arg_25_0:getPosition()
		local var_25_1 = arg_25_1:getPosition()
		local var_25_2 = arg_25_0:getScore()
		local var_25_3 = arg_25_1:getScore()
		local var_25_4 = arg_25_0:getCfg()
		local var_25_5 = arg_25_1:getCfg()
		local var_25_6 = arg_25_0:getLevel()
		local var_25_7 = arg_25_1:getLevel()
		local var_25_8 = var_25_4.class
		local var_25_9 = var_25_5.class
		local var_25_10 = var_25_4.quality
		local var_25_11 = var_25_5.quality

		if var_25_0 ~= var_25_1 then
			return var_25_1 < var_25_0
		elseif var_25_2 ~= var_25_3 then
			return var_25_3 < var_25_2
		elseif var_25_8 ~= var_25_9 then
			return var_25_9 < var_25_8
		elseif var_25_10 ~= var_25_11 then
			return var_25_11 < var_25_10
		else
			return var_25_7 < var_25_6
		end
	end)

	return var_24_0
end

function PetEquipData:createChooseEquipList(arg_26_1, arg_26_2)
	local var_26_0 = self._allPetEquipMap[arg_26_1]:getCfg().type
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(self._allPetEquips) do
		if arg_26_1 ~= iter_26_1:getSid() and var_26_0 == iter_26_1:getCfg().type then
			if arg_26_2 and iter_26_1:getPosition() == 0 then
				table.insert(var_26_1, iter_26_1)
			elseif not arg_26_2 then
				table.insert(var_26_1, iter_26_1)
			end
		end
	end

	table.sort(var_26_1, function(arg_27_0, arg_27_1)
		local var_27_0 = arg_27_0:getPosition()
		local var_27_1 = arg_27_1:getPosition()
		local var_27_2 = arg_27_0:getScore()
		local var_27_3 = arg_27_1:getScore()
		local var_27_4 = arg_27_0:getCfg()
		local var_27_5 = arg_27_1:getCfg()
		local var_27_6 = arg_27_0:getLevel()
		local var_27_7 = arg_27_1:getLevel()
		local var_27_8 = var_27_4.class
		local var_27_9 = var_27_5.class
		local var_27_10 = var_27_4.quality
		local var_27_11 = var_27_5.quality

		if var_27_0 ~= var_27_1 then
			return var_27_1 < var_27_0
		elseif var_27_2 ~= var_27_3 then
			return var_27_3 < var_27_2
		elseif var_27_8 ~= var_27_9 then
			return var_27_9 < var_27_8
		elseif var_27_10 ~= var_27_11 then
			return var_27_11 < var_27_10
		else
			return var_27_7 < var_27_6
		end
	end)

	return var_26_1
end

function PetEquipData:getBagLimit()
	return var_0_4.get(g.core.model.User:getLevel()).pet_equipment_bag_num_client
end

function PetEquipData:getTotalCount()
	return #self._allPetEquips
end

function PetEquipData:getStrengthEquipList(arg_30_1)
	local var_30_0 = {}
	local var_30_1 = self:getPetEquipById(arg_30_1)
	local var_30_2 = var_30_1:getServerData()
	local var_30_3 = var_30_1:getPosition()
	local var_30_4 = var_30_1:getCfg()
	local var_30_5 = math.ceil(var_30_3 / var_0_6.PETEQUIPTYPENUM)

	for iter_30_0, iter_30_1 in ipairs(self._allPetEquips) do
		local var_30_6 = iter_30_1:getServerData()
		local var_30_7 = iter_30_1:getCfg()

		if var_30_3 > 0 then
			if var_30_5 == math.ceil(iter_30_1:getPosition() / var_0_6.PETEQUIPTYPENUM) then
				table.insert(var_30_0, iter_30_1)
			end
		elseif var_30_4.type == var_30_7.type and var_30_7.type ~= var_0_6.PETEQUIPTYPEEXP then
			table.insert(var_30_0, iter_30_1)
		end
	end

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
		local var_31_0 = arg_31_0:getPosition()
		local var_31_1 = arg_31_1:getPosition()
		local var_31_2 = arg_31_0:getScore()
		local var_31_3 = arg_31_1:getScore()
		local var_31_4 = arg_31_0:getCfg()
		local var_31_5 = arg_31_1:getCfg()
		local var_31_6 = arg_31_0:getLevel()
		local var_31_7 = arg_31_1:getLevel()
		local var_31_8 = var_31_4.class
		local var_31_9 = var_31_5.class
		local var_31_10 = var_31_4.quality
		local var_31_11 = var_31_5.quality
		local var_31_12 = var_31_4.type
		local var_31_13 = var_31_5.type

		if var_30_3 > 0 then
			return var_31_0 < var_31_1
		elseif var_31_8 ~= var_31_9 then
			return var_31_9 < var_31_8
		elseif var_31_10 ~= var_31_11 then
			return var_31_11 < var_31_10
		elseif var_31_6 ~= var_31_7 then
			return var_31_7 < var_31_6
		else
			return var_31_12 < var_31_13
		end
	end)

	return var_30_0
end

function PetEquipData:createMatList(arg_32_1)
	local var_32_0 = self._allPetEquipMap[arg_32_1]:getServerData()
	local var_32_1 = self._allPetEquipMap[arg_32_1]:getSid()
	local var_32_2 = {}

	for iter_32_0, iter_32_1 in ipairs(self._allPetEquips) do
		local var_32_3 = iter_32_1:getPosition()
		local var_32_4 = iter_32_1:getSid()
		local var_32_5 = iter_32_1:isLocked()

		if iter_32_1:getCfg().type == var_0_6.PETEQUIPTYPEEXP then
			table.insert(var_32_2, iter_32_1)
		elseif var_32_3 == 0 and var_32_4 ~= var_32_1 and not var_32_5 then
			table.insert(var_32_2, iter_32_1)
		end
	end

	table.sort(var_32_2, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0:getPosition()
		local var_33_1 = arg_33_1:getPosition()
		local var_33_2 = arg_33_0:getScore()
		local var_33_3 = arg_33_1:getScore()
		local var_33_4 = arg_33_0:getCfg()
		local var_33_5 = arg_33_1:getCfg()
		local var_33_6 = arg_33_0:getLevel()
		local var_33_7 = arg_33_1:getLevel()
		local var_33_8 = var_33_4.class
		local var_33_9 = var_33_5.class
		local var_33_10 = var_33_4.quality
		local var_33_11 = var_33_5.quality
		local var_33_12 = var_33_4.type
		local var_33_13 = var_33_5.type
		local var_33_14 = 0
		local var_33_15 = 0

		if var_33_4.type == var_0_6.PETEQUIPTYPEEXP then
			var_33_14 = 999
		end

		if var_33_13 == var_0_6.PETEQUIPTYPEEXP then
			var_33_15 = 999
		end

		if var_33_14 ~= var_33_15 then
			return var_33_15 < var_33_14
		elseif var_33_8 ~= var_33_9 then
			return var_33_8 < var_33_9
		elseif var_33_10 ~= var_33_11 then
			return var_33_10 < var_33_11
		elseif var_33_6 ~= var_33_7 then
			return var_33_6 < var_33_7
		else
			return var_33_12 < var_33_13
		end
	end)

	return var_32_2
end

function PetEquipData:createMatListCanLevelup(arg_34_1, arg_34_2)
	local var_34_0 = self._allPetEquipMap[arg_34_1]:getLevel()
	local var_34_1 = self._allPetEquipMap[arg_34_1]:getMaxLevel()
	local var_34_2 = self._allPetEquipMap[arg_34_1]:isMaxLevel()
	local var_34_3 = {}
	local var_34_4 = var_34_0
	local var_34_5 = self._allPetEquipMap[arg_34_1]:getExp()
	local var_34_6 = 0

	for iter_34_0, iter_34_1 in ipairs(arg_34_2) do
		local var_34_7 = iter_34_1:getCfg()
		local var_34_8 = self:calEquipApplyExp((iter_34_1:getSid()))

		var_34_5 = var_34_5 + var_34_8
		var_34_6 = var_34_6 + var_34_8

		table.insert(var_34_3, iter_34_1)

		local var_34_9

		if var_34_5 >= self:getEquipLevelUpNeedExp(var_34_7.id, var_34_0 + 0) and not var_34_2 then
			var_34_4 = self:getLevelAfterUseExp(var_34_6, arg_34_1)
			var_34_9 = var_34_4 - var_34_0

			if var_34_4 - var_34_0 >= 5 or var_34_4 == var_34_1 then
				break
			end
		end
	end

	return var_34_3, var_34_5, self:getEquipLevelUpNeedExp(self._allPetEquipMap[arg_34_1]:getCfg().id, var_34_0), var_34_4, var_34_6
end

function PetEquipData:canLevelUpUseMats(arg_35_1, arg_35_2)
	local var_35_0 = self._allPetEquipMap[arg_35_2]:getLevel()
	local var_35_1 = self._allPetEquipMap[arg_35_2]:getBaseId()
	local var_35_2 = self._allPetEquipMap[arg_35_2]:isMaxLevel()
	local var_35_3 = self._allPetEquipMap[arg_35_2]:getMaxLevel()
	local var_35_4 = 0
	local var_35_6 = 0 + self._allPetEquipMap[arg_35_2]:getExp()

	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		local var_35_7 = self:calEquipApplyExp((iter_35_1:getSid()))

		var_35_6 = var_35_6 + var_35_7
		var_35_4 = var_35_4 + var_35_7

		local var_35_9

		if self:getEquipLevelUpNeedExp(var_35_1, var_35_0 + 0) <= var_35_6 and not var_35_2 then
			local var_35_8 = self:getLevelAfterUseExp(var_35_4, arg_35_2)

			var_35_9 = var_35_8 - var_35_0

			if var_35_8 - var_35_0 >= 5 or var_35_8 == var_35_3 then
				return true
			end
		end
	end

	return false
end

function PetEquipData:getLevelAfterUseExp(arg_36_1, arg_36_2)
	local var_36_0 = self._allPetEquipMap[arg_36_2]:getCfg()
	local var_36_1 = self._allPetEquipMap[arg_36_2]:getLevel()
	local var_36_2 = self._allPetEquipMap[arg_36_2]:getMaxLevel()
	local var_36_3 = self._allPetEquipMap[arg_36_2]:getExp() + arg_36_1

	while var_36_3 > 0 do
		local var_36_4 = self:getEquipLevelUpNeedExp(var_36_0.id, var_36_1)

		if var_36_4 <= var_36_3 and var_36_1 < var_36_2 then
			var_36_3 = var_36_3 - var_36_4
			var_36_1 = var_36_1 + 1
		else
			break
		end
	end

	return var_36_1
end

function PetEquipData:getLowestScoreByType(arg_37_1)
	local var_37_0 = 99999999

	for iter_37_0 = 1, var_0_7 do
		if g.core.model.User.petsData:getPetByPos(iter_37_0) then
			local var_37_2 = (not self._allEquipedPetEquips[iter_37_0] or not self._allEquipedPetEquips[iter_37_0][arg_37_1]) and 0 or self._allEquipedPetEquips[iter_37_0][arg_37_1]:getServerData().score

			if var_37_2 < var_37_0 then
				var_37_0 = var_37_2
			end
		end
	end

	return var_37_0
end

function PetEquipData:isHigherThanCurEquip(arg_38_1)
	return
end

function PetEquipData:getIsPrompted()
	return self._isPrompted
end

function PetEquipData:setIsPrompted(arg_40_1)
	self._isPrompted = arg_40_1
end

function PetEquipData:getIsOnekeyPrompted()
	return self._isOnekeyPrompted
end

function PetEquipData:setIsOnekeyPrompted(arg_42_1)
	self._isOnekeyPrompted = arg_42_1
end

function PetEquipData:calEquipApplyExp(arg_43_1)
	if not self._allPetEquipMap[arg_43_1] then
		return 0
	end

	local var_43_0 = self._allPetEquipMap[arg_43_1]:getLevel()
	local var_43_1 = self._allPetEquipMap[arg_43_1]:getExp()
	local var_43_2 = self._allPetEquipMap[arg_43_1]:getCfg()
	local var_43_3 = self._allPetEquipMap[arg_43_1]:getCfgExp()

	if var_43_0 > 1 or var_43_1 > 0 then
		for iter_43_0 = 1, var_43_0 - 1 do
			var_43_3 = var_43_3 + self:getEquipLevelUpNeedExp(var_43_2.id, iter_43_0)
		end
	end

	return var_43_3 + var_43_1
end

function PetEquipData:checkOnekeyLevelupHaveHigherScore(arg_44_1)
	if #arg_44_1 == 0 then
		return false
	end

	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(arg_44_1) do
		table.insert(var_44_0, {
			index = iter_44_0,
			needExp = self:getEquipLevelUpNeedExp(iter_44_1:getCfg().id, (iter_44_1:getLevel())) - iter_44_1:getExp()
		})
	end

	table.sort(var_44_0, function(arg_45_0, arg_45_1)
		return arg_45_0.needExp < arg_45_1.needExp
	end)

	local var_44_1 = 5
	local var_44_2 = {}
	local var_44_3 = {}
	local var_44_4 = self:createMatList(arg_44_1[1]:getServerData().id)
	local var_44_5 = {}
	local var_44_6 = #var_44_4

	for iter_44_2 = 1, var_0_6.PETEQUIPTYPENUM do
		var_44_5[iter_44_2] = self:getLowestScoreByType(iter_44_2)
	end

	local var_44_7 = 1
	local var_44_8 = false
	local var_44_9 = false

	for iter_44_3, iter_44_4 in ipairs(var_44_0) do
		local var_44_10 = arg_44_1[iter_44_4.index]:getCfg()
		local var_44_11 = arg_44_1[iter_44_4.index]:getServerData()
		local var_44_12 = var_44_10.level_max
		local var_44_13 = arg_44_1[iter_44_4.index]:getLevel()
		local var_44_14 = arg_44_1[iter_44_4.index]:getExp()
		local var_44_15 = arg_44_1[iter_44_4.index]:getPosition()

		if var_44_10.level_max == var_44_13 then
			var_44_2[iter_44_3] = true
		else
			var_44_2[iter_44_3] = false

			local var_44_16 = 0
			local var_44_17 = 0

			for iter_44_5 = var_44_13, (var_44_12 <= var_44_13 + var_44_1 and var_44_12 or var_44_13 + var_44_1) - 1 do
				local var_44_18 = self:getEquipLevelUpNeedExp(var_44_10.id, iter_44_5)

				var_44_16 = var_44_18 + var_44_16

				if iter_44_5 == var_44_13 then
					var_44_17 = var_44_17 + var_44_18
				end
			end

			local var_44_19 = 0
			local var_44_20 = false

			for iter_44_6 = var_44_7, var_44_6 do
				local var_44_21 = var_44_4[iter_44_6]:getCfg()
				local var_44_22 = var_44_4[iter_44_6]:getScore()

				var_44_19 = var_44_19 + self:calEquipApplyExp((var_44_4[iter_44_6]:getSid()))

				if var_44_21.type ~= var_0_6.PETEQUIPTYPEEXP and var_44_22 >= var_44_5[var_44_21.type] then
					var_44_8 = true
				end

				if var_44_17 - var_44_14 <= var_44_19 then
					var_44_20 = true
				end

				if var_44_16 - var_44_14 <= var_44_19 then
					var_44_7 = iter_44_6 + 1

					table.insert(var_44_3, var_44_15)

					break
				elseif (var_44_20 or var_44_9) and iter_44_6 == var_44_6 then
					table.insert(var_44_3, var_44_15)
				end
			end

			var_44_9 = var_44_9 or var_44_20
		end
	end

	local var_44_23 = 0
	local var_44_24 = true

	for iter_44_7, iter_44_8 in ipairs(var_44_2) do
		var_44_24 = var_44_24 and iter_44_8
	end

	if var_44_24 then
		var_44_23 = 1

		return false, 1
	end

	if not var_44_9 then
		var_44_23 = 2

		return false, 2
	end

	return var_44_8, var_44_23, var_44_3
end

function PetEquipData:checkHasEquipToReborn()
	for iter_46_0, iter_46_1 in ipairs(self._allPetEquips) do
		if iter_46_1:getPosition() == 0 and (iter_46_1:getExp() > 0 or iter_46_1:getLevel() > 1) then
			return true
		end
	end

	return false
end

function PetEquipData:getAllPetEquipsCanReborn()
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs(self._allPetEquips) do
		if iter_47_1:getPosition() == 0 and (iter_47_1:getExp() > 0 or iter_47_1:getLevel() > 1) then
			table.insert(var_47_0, iter_47_1)
		end
	end

	return var_47_0
end

function PetEquipData:getAddAttListLevelUp(arg_48_1, arg_48_2)
	local var_48_0 = self._allPetEquipMap[arg_48_1]:getCfg()
	local var_48_1 = self._allPetEquipMap[arg_48_1]:getLevel()
	local var_48_2 = {}

	if var_48_1 == arg_48_2 then
		return var_48_2
	end

	var_48_2[var_48_0.basic_type_1] = (var_48_1 - arg_48_2) * var_48_0.basic_growth_1
	var_48_2[var_48_0.basic_type_2] = (var_48_1 - arg_48_2) * var_48_0.basic_growth_2

	return var_48_2
end

function PetEquipData:setPetEquipsInAwards(arg_49_1)
	self._petEquipsInAwards = {}
	self._petEquipsShouldSpecialShow = {}

	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
		local var_49_1 = self:getPetEquipById(iter_49_1.id)
		local var_49_2 = var_49_1:getType()
		local var_49_3 = var_49_1:getQuality()

		var_49_0[var_49_2] = var_49_0[var_49_2] or self:getLowestScoreByType(var_49_2)

		if var_49_0[var_49_2] < var_49_1:getScore() then
			table.insert(self._petEquipsInAwards, iter_49_1.id)
		end

		if var_49_3 >= self._specialShowMinQua then
			table.insert(self._petEquipsShouldSpecialShow, iter_49_1.id)
		end
	end
end

function PetEquipData:getPetEquipsInAwards()
	return self._petEquipsInAwards
end

function PetEquipData:getPetEquipsShouldSpecialShow()
	return self._petEquipsShouldSpecialShow
end

function PetEquipData:getIsLockPrompted()
	return self._isLockPrompted
end

function PetEquipData:setIsLockPrompted(arg_53_1)
	self._isLockPrompted = checkbool(arg_53_1)
end

return PetEquipData
