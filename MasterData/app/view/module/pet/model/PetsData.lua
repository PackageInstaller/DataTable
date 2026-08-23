local var_0_0 = g.core.config.pet_info
local var_0_1 = g.core.config.pet_advance_info
local var_0_2 = g.core.const.ConstMgr
local PetStruct = import(".PetStruct")
local PetsData = class("PetsData")

function PetsData:ctor()
	self:initData()
end

function PetsData:initData()
	self._advIdArr = {}
	self._advIdKeyPetDict = {}
	self._ownPetArr = {}
	self._sidKeyOwnAdvIdDict = {}
	self._lineupSidDict = {}
	self._advCfgDict = {}

	self:_initData()
end

function PetsData:_initData()
	for iter_3_0, iter_3_1 in var_0_0.ipairs() do
		if not self._advIdKeyPetDict[iter_3_1.advance_id] then
			self._advIdKeyPetDict[iter_3_1.advance_id] = PetStruct.new(iter_3_1.advance_id)

			table.insert(self._advIdArr, iter_3_1.advance_id)
		end
	end

	for iter_3_2, iter_3_3 in var_0_1.ipairs() do
		self._advCfgDict[self:_getAdvCfgKey(iter_3_3.advance_id, iter_3_3.stage, iter_3_3.node)] = iter_3_3
	end
end

function PetsData:onS2CUpdatePets()
	self._lineupSidDict = {}
	self._ownPetArr = {}
	self._sidKeyOwnAdvIdDict = {}

	for iter_4_0, iter_4_1 in pairs(self._advIdKeyPetDict) do
		if iter_4_1:isOwn() then
			iter_4_1:clearServerData()
		end
	end

	for iter_4_2, iter_4_3 in ipairs((g.core.model.User.bagData:getList(var_0_2.BAG_TYPE.PET))) do
		local var_4_0 = self:getPetByBaseId(iter_4_3.base_id)

		var_4_0:setServerData(iter_4_3)
		table.insert(self._ownPetArr, var_4_0)

		self._sidKeyOwnAdvIdDict[iter_4_3.id] = var_4_0:getAdvanceId()

		if var_4_0:isLineup() then
			self._lineupSidDict[var_4_0:getLineupPos()] = iter_4_3.id
		end
	end
end

function PetsData:onS2CFormationChangeFormation(arg_5_1)
	if arg_5_1.tp ~= g.core.network.proto.TYPE_PET then
		return
	end

	self:_updatePosBySidDict(arg_5_1.formation.pet_id)
end

function PetsData:onS2CDelPet(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		for iter_6_2, iter_6_3 in ipairs(self._ownPetArr) do
			if iter_6_1 == iter_6_3:getSid() then
				table.remove(self._ownPetArr, iter_6_2)

				break
			end
		end

		self._sidKeyOwnAdvIdDict[iter_6_1] = nil
	end
end

function PetsData:onS2CInheriFormation(arg_7_1)
	self:_updatePosBySidDict(arg_7_1.formation.pet_id)
end

function PetsData:_updatePosBySidDict(arg_8_1)
	self._lineupSidDict = arg_8_1 or {}

	for iter_8_0 = 1, #self._ownPetArr do
		self._ownPetArr[iter_8_0]:clearLineupPos()
	end

	for iter_8_1, iter_8_2 in pairs(self._lineupSidDict) do
		if iter_8_2 > 0 then
			local var_8_0 = self:getPetBySid(iter_8_2)

			if var_8_0 then
				var_8_0:setLineupPos(iter_8_1)
			else
				g.core.log:error("-------      Error! Not found PetStruct with sid:", iter_8_2)
			end
		end
	end
end

function PetsData:getPetBySid(arg_9_1)
	return self:getPetByAdvanceId(self._sidKeyOwnAdvIdDict[arg_9_1])
end

function PetsData:getPetByAdvanceId(arg_10_1)
	return self._advIdKeyPetDict[arg_10_1]
end

function PetsData:getPetByBaseId(arg_11_1)
	return self:getPetByAdvanceId(var_0_0.get(arg_11_1).advance_id)
end

function PetsData:getSidByPos(arg_12_1)
	return self._lineupSidDict[arg_12_1] or 0
end

function PetsData:getPetByPos(arg_13_1)
	local var_13_0 = self:getSidByPos(arg_13_1)

	if var_13_0 > 0 then
		return self:getPetBySid(var_13_0)
	end
end

function PetsData:getLineupSidDict()
	return self._lineupSidDict
end

function PetsData:getLineupNum()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(self._lineupSidDict) do
		if iter_15_1 > 0 then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function PetsData:getOwnPetArr()
	return self._ownPetArr
end

function PetsData:getPetArrByFilter(arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(self._advIdKeyPetDict) do
		if iter_17_1:isPut() and (not arg_17_1 or arg_17_1(iter_17_1)) then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function PetsData:getOwnPetArrByFilter(arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(self._ownPetArr) do
		if not arg_18_1 or arg_18_1(iter_18_1) then
			table.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function PetsData:getFullPetFragmentArr()
	local var_19_0 = g.core.model.User.fragmentsData:getPetFragmentListByType(g.core.common.Goods.TYPE_PET)
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs((self:getOwnPetArrByFilter(function(arg_20_0)
		return arg_20_0:isMaxStar()
	end))) do
		for iter_19_2, iter_19_3 in ipairs(var_19_0) do
			if iter_19_3.id == iter_19_1:getFragmentId() then
				table.insert(var_19_1, iter_19_3)
			end
		end
	end

	return var_19_1
end

function PetsData:getCanSellPetFragDataArr()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs((self:getFullPetFragmentArr())) do
		local var_21_1 = g.core.config.fragment_info.get(iter_21_1.id)

		table.insert(var_21_0, {
			type = g.core.common.Goods.TYPE_FRAGMENT,
			value = iter_21_1.id,
			size = iter_21_1.num,
			quality = var_21_1.quality,
			priceType = var_21_1.price_type,
			priceValue = var_21_1.price_value,
			priceSize = var_21_1.price_size
		})
	end

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		if arg_22_0.quality ~= arg_22_1.quality then
			return arg_22_0.quality < arg_22_1.quality
		end

		return arg_22_0.value < arg_22_1.value
	end)

	return var_21_0
end

function PetsData:getInfoListByAdvId(arg_23_1)
	local var_23_0 = {}
	local var_23_1 = arg_23_1

	while arg_23_1 ~= 0 do
		local var_23_2 = var_0_0.get(arg_23_1)

		var_23_0[var_23_2.star] = var_23_2
		var_23_1 = var_23_2.next_id
	end

	return var_23_0
end

function PetsData:_getAdvCfgKey(arg_24_1, arg_24_2, arg_24_3)
	return string.format("%d_%d_%d", arg_24_1, arg_24_2, arg_24_3)
end

function PetsData:getAdvCfg(arg_25_1, arg_25_2, arg_25_3)
	return self._advCfgDict[self:_getAdvCfgKey(arg_25_1, arg_25_2, arg_25_3)] or {}
end

function PetsData:isTherePetLineup()
	for iter_26_0, iter_26_1 in pairs(self._lineupSidDict) do
		if iter_26_1 > 0 then
			return true
		end
	end

	return false
end

function PetsData:isLineupByPos(arg_27_1)
	return self:getSidByPos(arg_27_1) > 0
end

function PetsData:getLinkKnight(arg_28_1)
	local var_28_0 = {}
	local var_28_1 = 0

	if arg_28_1 then
		local var_28_2 = arg_28_1:getCfg()

		if var_28_2.link_advance_id > 0 then
			table.insert(var_28_0, {
				assId = var_28_2.link_advance_id,
				isActive = g.core.model.User.knightsData:getKnightByAdvanceId(var_28_2.link_advance_id):isOwn(),
				linkSkillId = var_28_2.link_passive_skill_1,
				petAdvId = var_28_2.advance_id
			})

			var_28_1 = #var_28_0
		end
	end

	return var_28_0, var_28_1
end

function PetsData:getSortFunc()
	return function(arg_30_0, arg_30_1)
		if arg_30_0:isComposeEnable() ~= arg_30_1:isComposeEnable() then
			return arg_30_0:isComposeEnable()
		end

		if arg_30_0:canStarUp() ~= arg_30_1:canStarUp() then
			return arg_30_0:canStarUp()
		end

		if arg_30_0:isLineup() ~= arg_30_1:isLineup() then
			return arg_30_0:isLineup()
		end

		if arg_30_0:getLevel() ~= arg_30_1:getLevel() then
			return arg_30_0:getLevel() > arg_30_1:getLevel()
		end

		if arg_30_0:getQuality() ~= arg_30_1:getQuality() then
			return arg_30_0:getQuality() > arg_30_1:getQuality()
		end

		return arg_30_0:getAdvanceId() > arg_30_1:getAdvanceId()
	end
end

function PetsData:hasPetCanComposeWithCustomData(arg_31_1)
	if arg_31_1 and arg_31_1.advId then
		local var_31_0 = self:getPetByAdvanceId(arg_31_1.advId)

		return var_31_0 and var_31_0:isComposeEnable()
	else
		for iter_31_0, iter_31_1 in pairs((self:getPetArrByFilter())) do
			if iter_31_1:isComposeEnable() then
				return true
			end
		end

		return false
	end
end

function PetsData:hasPetCanStarUpWithCustomData(arg_32_1)
	if arg_32_1 and arg_32_1.advId then
		local var_32_0 = self:getPetByAdvanceId(arg_32_1.advId)

		return var_32_0 and var_32_0:canStarUp()
	else
		for iter_32_0, iter_32_1 in ipairs(self._ownPetArr) do
			if iter_32_1:canStarUp() then
				return true
			end
		end

		return false
	end
end

function PetsData:hasLineupPetCanStarUpWithCustomData(arg_33_1)
	if arg_33_1 and arg_33_1.advId then
		local var_33_0 = self:getPetByAdvanceId(arg_33_1.advId)

		return var_33_0 and var_33_0:canStarUp()
	else
		for iter_33_0, iter_33_1 in ipairs(self._ownPetArr) do
			if iter_33_1:canStarUp() and iter_33_1:isLineup() then
				return true
			end
		end

		return false
	end
end

function PetsData:hasPetCanLevelUpWithCustomData(arg_34_1)
	if arg_34_1 and arg_34_1.advId then
		local var_34_0 = self:getPetByAdvanceId(arg_34_1.advId)

		return var_34_0 and var_34_0:isLineup() and var_34_0:isLevelUpEnable()
	else
		for iter_34_0, iter_34_1 in ipairs(self._ownPetArr) do
			if iter_34_1:isLevelUpEnable() and iter_34_1:isLineup() then
				return true
			end
		end

		return false
	end
end

function PetsData:hasPetCanAdvanceWithCustomData(arg_35_1)
	if arg_35_1 and arg_35_1.advId then
		local var_35_0 = self:getPetByAdvanceId(arg_35_1.advId)

		return var_35_0 and var_35_0:isLineup() and var_35_0:isAdvanceEnable()
	else
		for iter_35_0, iter_35_1 in ipairs(self._ownPetArr) do
			if iter_35_1:isAdvanceEnable() and iter_35_1:isLineup() then
				return true
			end
		end

		return false
	end
end

function PetsData:isNewPetWithCustomData(arg_36_1)
	if arg_36_1 and arg_36_1.advId then
		local var_36_0 = self:getPetByAdvanceId(arg_36_1.advId)

		return var_36_0 and var_36_0:getIsNewPet()
	else
		for iter_36_0, iter_36_1 in ipairs(self._ownPetArr) do
			if iter_36_1 and iter_36_1:getIsNewPet() then
				return true
			end
		end
	end
end

function PetsData:isPositionCanLineUpPetWithCustomData(arg_37_1)
	if arg_37_1.pos then
		return not self:isLineupByPos(arg_37_1.pos) and self:getLineupNum() < #self._ownPetArr and not arg_37_1.isLocked
	else
		if #self._ownPetArr <= self:getLineupNum() then
			return false
		end

		for iter_37_0 = 1, var_0_2.PetConst.LINEUP_MAX do
			if not self:isLineupByPos(iter_37_0) and g.core.common.ModuleUnlock:isModuleUnlock(var_0_2.FUNCTION_TYPE[var_0_2.LineUpConst.PET_LINE_UP_FUNC_ID_PRE_KEY .. iter_37_0]) then
				return true
			end
		end

		return false
	end
end

return PetsData
