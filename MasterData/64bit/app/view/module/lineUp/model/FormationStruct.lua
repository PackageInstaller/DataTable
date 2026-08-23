local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_1 = g.core.const.ConstMgr.PetConst
local var_0_2 = g.core.const.ConstMgr.UniteTokenConst
local var_0_3 = g.core.const.ConstMgr.PreciousConst
local var_0_4 = g.core.const.ConstMgr.SuccubaConst
local FormationStruct = class("FormationStruct")

function FormationStruct:ctor()
	self:_initLimitMember()

	self._type = 0
	self._index = 0
	self._uniqueId = 0
	self._svrData = {}

	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0 = 1, var_0_0.LINEUP_MAX do
		var_1_0[iter_1_0] = 0
		var_1_1[iter_1_0] = 0
	end

	self._knightSidArr = var_1_0
	self._artifactSidArr = var_1_1

	local var_1_2 = {}

	for iter_1_1 = 1, var_0_2.FORMAT_UNITE_NUM_MAX do
		var_1_2[iter_1_1] = 0
	end

	self._uniteTokenSidArr = var_1_2

	local var_1_3 = {}

	for iter_1_2 = 1, var_0_1.SERVER_LINEUP_MAX do
		var_1_3[iter_1_2] = 0
	end

	self._petSidArr = var_1_3

	local var_1_4 = {}

	for iter_1_3 = 1, var_0_3.LINEUP_MAX do
		var_1_4[iter_1_3] = 0
	end

	self._preciousSuitSidArr = var_1_4

	local var_1_5 = {}

	for iter_1_4 = 1, var_0_4.FORMAT_SUCCUBA_NUM_MAX do
		var_1_5[iter_1_4] = 0
	end

	self._succubaSidArr = var_1_5
	self._fightValue = 0
	self._formationValidFunc = handler(self, self._normalCheckValid)
end

function FormationStruct:_initLimitMember()
	self._minKnightNum = 0
	self._limitKnightNum = -1
	self._limitUniteTokenNum = -1
	self._limitPetNum = -1
	self._limitSuccubaNum = -1
	self._limitKnightCnt = -1
	self._limitUniteCnt = -1
	self._limitPetCnt = -1
	self._limitSuccubaCnt = -1
end

function FormationStruct:setSvrData(arg_3_1)
	arg_3_1 = arg_3_1 or {}
	self._svrData = arg_3_1
	self._type = arg_3_1.tp or self._type
	self._index = arg_3_1.seq or self._index
	self._uniqueId = arg_3_1.unique_id or 0

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.position or {}) do
		if self:isPositionValid(iter_3_1) then
			var_3_0[iter_3_1] = iter_3_0
		end
	end

	local var_3_1 = arg_3_1.knight_id or {}
	local var_3_2 = arg_3_1.artifact_id or {}

	for iter_3_2 in ipairs(self._knightSidArr) do
		local var_3_3 = self:_getValueDefault_0(var_3_0, iter_3_2)

		self._knightSidArr[iter_3_2] = self:_getValueDefault_0(var_3_1, var_3_3)
		self._artifactSidArr[iter_3_2] = self:_getValueDefault_0(var_3_2, var_3_3)
	end

	local var_3_4 = arg_3_1.unite_token_id or {}

	for iter_3_3 in ipairs(self._uniteTokenSidArr) do
		self._uniteTokenSidArr[iter_3_3] = self:_getValueDefault_0(var_3_4, iter_3_3)
	end

	local var_3_5 = arg_3_1.pet_id or {}

	for iter_3_4 in ipairs(self._petSidArr) do
		self._petSidArr[iter_3_4] = self:_getValueDefault_0(var_3_5, iter_3_4)
	end

	local var_3_6 = arg_3_1.precious_suits or {}

	for iter_3_5 in ipairs(self._preciousSuitSidArr) do
		self._preciousSuitSidArr[iter_3_5] = self:_getValueDefault_0(var_3_6, iter_3_5)
	end

	local var_3_7 = arg_3_1.succuba_id or {}

	for iter_3_6 in ipairs(var_3_7) do
		self._succubaSidArr[iter_3_6] = self:_getValueDefault_0(var_3_7, iter_3_6)
	end

	if arg_3_1.fight_value then
		self._fightValue = arg_3_1.fight_value
	end
end

function FormationStruct:setFightValue(arg_4_1)
	self._fightValue = arg_4_1
end

function FormationStruct:toOutBaseFormation()
	local var_5_0 = {}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(self._knightSidArr) do
		var_5_0[iter_5_0] = iter_5_1
		var_5_1[iter_5_0] = iter_5_0
	end

	local var_5_2 = {
		knight_id = var_5_0,
		position = var_5_1,
		unite_token_id = clone(self._uniteTokenSidArr),
		equipment_id = {},
		treasure_id = {},
		artifact_id = clone(self._artifactSidArr),
		pet_id = clone(self._petSidArr),
		precious_suits = clone(self._preciousSuitSidArr),
		pet_equipment_id = {},
		succuba_id = clone(self._succubaSidArr)
	}

	if self._type > 0 then
		var_5_2.tp = self._type
		var_5_2.seq = self._index
		var_5_2.unique_id = self._uniqueId
	end

	return var_5_2
end

function FormationStruct:getSvrData()
	return self._svrData
end

function FormationStruct:isInitWithSvrData()
	return checkbool(next(self._svrData))
end

function FormationStruct:getMulIndex()
	return self._index
end

function FormationStruct:isModified()
	local var_9_0 = self:toOutBaseFormation()

	if next(self._svrData) then
		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			if type(iter_9_1) == "table" then
				local var_9_1 = self._svrData[iter_9_0] or {}

				for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
					if iter_9_3 ~= self:_getValueDefault_0(var_9_1, iter_9_2) then
						return true
					end
				end
			end
		end
	else
		for iter_9_4, iter_9_5 in pairs(var_9_0) do
			if type(iter_9_5) == "table" and iter_9_4 ~= "position" then
				for iter_9_6, iter_9_7 in ipairs(iter_9_5) do
					if self:isSidValid(iter_9_7) then
						return true
					end
				end
			end
		end
	end

	return false
end

function FormationStruct:resetFormation()
	self:setSvrData(self._svrData)
end

function FormationStruct:resetFormationValidFunc(arg_11_1)
	self._formationValidFunc = arg_11_1
end

function FormationStruct:isFormationValid()
	return (self._formationValidFunc or nil) and self._formationValidFunc()
end

function FormationStruct:_normalCheckValid()
	return self:isKnightNumValid() and self:isUniteTokenNumValid() and self:isPetNumValid() or false
end

function FormationStruct:_changeStationPos(arg_14_1, arg_14_2, arg_14_3)
	arg_14_3 = arg_14_3 or 0

	local var_14_0 = self:_getKeyDefault_0(arg_14_1, arg_14_3)

	if self:isPositionValid(var_14_0) then
		arg_14_1[var_14_0] = arg_14_1[arg_14_2]
	end

	arg_14_1[arg_14_2] = arg_14_3
end

function FormationStruct:_getKeyDefault_0(arg_15_1, arg_15_2)
	if not arg_15_1 or not arg_15_2 then
		return 0
	elseif arg_15_2 == 0 then
		return 0
	else
		return table.keyof(arg_15_1, arg_15_2) or 0
	end
end

function FormationStruct:_getValueDefault_0(arg_16_1, arg_16_2)
	if not arg_16_1 or not arg_16_2 then
		return 0
	elseif arg_16_2 == 0 then
		return 0
	else
		return arg_16_1[arg_16_2] or 0
	end
end

function FormationStruct:_dictToArr(arg_17_1)
	local var_17_0 = 0

	for iter_17_0 in pairs(arg_17_1) do
		var_17_0 = math.max(iter_17_0, var_17_0)
	end

	local var_17_1 = {}

	for iter_17_1 = 1, var_17_0 do
		var_17_1[iter_17_1] = self:_getValueDefault_0(arg_17_1, iter_17_1)
	end

	return var_17_1
end

function FormationStruct:_getHaloGroupInfo(arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_1 = iter_18_1:getGroup()

		if var_0_0.HALO_QUALITY_LIMIT <= iter_18_1:getQuality() then
			var_18_0[var_18_1] = var_18_0[var_18_1] or 0
			var_18_0[var_18_1] = var_18_0[var_18_1] + 1
		end
	end

	local var_18_2 = var_0_0.GROUP_TYPE.DEFAULT
	local var_18_3 = 0

	for iter_18_2, iter_18_3 in pairs(var_18_0) do
		if var_18_3 < iter_18_3 then
			var_18_2 = iter_18_2
			var_18_3 = iter_18_3
		end
	end

	return {
		curCnt = var_18_3,
		group = var_18_2,
		knights = arg_18_1
	}
end

function FormationStruct:setLimitKnightNum(arg_19_1)
	self._limitKnightNum = arg_19_1
end

function FormationStruct:getLimitKnightNum()
	return self._limitKnightNum
end

function FormationStruct:setMinKnightCnt(arg_21_1)
	self._minKnightNum = arg_21_1
end

function FormationStruct:getMinKnightCnt()
	return self._minKnightNum
end

function FormationStruct:setLimitKnightCnt(arg_23_1)
	self._limitKnightCnt = arg_23_1
end

function FormationStruct:getLimitKnightCnt()
	return self._limitKnightCnt
end

function FormationStruct:getValidKnightSidList()
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(self._knightSidArr) do
		if self:isSidValid(iter_25_1) then
			var_25_0[#var_25_0 + 1] = iter_25_1
		end
	end

	return var_25_0
end

function FormationStruct:canLineUpKnight(arg_26_1, arg_26_2)
	if self._limitKnightNum < 0 and self._limitKnightCnt < 0 and self._minKnightNum <= 0 then
		return true
	end

	if arg_26_1 then
		if self:isSidValid(self._knightSidArr[arg_26_1]) or self:getKnightStationPos(arg_26_2) ~= 0 then
			return true
		end
	end

	local var_26_0 = self:getValidKnightSidList()

	if arg_26_2 == 0 and #var_26_0 - 1 < self._minKnightNum then
		return false
	end

	if self._limitKnightNum >= 0 then
		return #var_26_0 < self._limitKnightNum
	elseif self._limitKnightCnt >= 0 then
		return #var_26_0 < self._limitKnightCnt
	else
		return true
	end
end

function FormationStruct:isKnightNumValid()
	if self._limitKnightNum < 0 and self._limitKnightCnt < 0 and self._minKnightNum <= 0 then
		return true
	end

	local var_27_0 = self:getValidKnightSidList()

	if self._minKnightNum > 0 then
		return #var_27_0 >= self._minKnightNum
	end

	if self._limitKnightNum >= 0 then
		return #var_27_0 == self._limitKnightNum
	elseif self._limitKnightCnt >= 0 then
		return #var_27_0 <= self._limitKnightCnt
	end
end

function FormationStruct:lineupKnight(arg_28_1, arg_28_2)
	self:_changeStationPos(self._knightSidArr, arg_28_1, arg_28_2)
end

function FormationStruct:takeOffKnight(arg_29_1)
	local var_29_0 = self:getKnightStationPos(arg_29_1)

	if self:isPositionValid(var_29_0) then
		self:lineupKnight(var_29_0, 0)
	end
end

function FormationStruct:lineupArtifact(arg_30_1, arg_30_2)
	self:_changeStationPos(self._artifactSidArr, arg_30_1, arg_30_2)
end

function FormationStruct:takeOffArtifact(arg_31_1)
	local var_31_0 = self:getArtifactStationPos(arg_31_1)

	if self:isPositionValid(var_31_0) then
		self:lineupArtifact(var_31_0, 0)
	end
end

function FormationStruct:setLimitUpUniteTokenNum(arg_32_1)
	self._limitUniteTokenNum = arg_32_1
end

function FormationStruct:getLimitUpUniteTokenNum()
	return self._limitUniteTokenNum
end

function FormationStruct:setLimitUpUniteTokenCnt(arg_34_1)
	self._limitUniteCnt = arg_34_1
end

function FormationStruct:getLimitUpUniteTokenCnt()
	return self._limitUniteCnt
end

function FormationStruct:getValidUniteTokenSidList()
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs(self._uniteTokenSidArr) do
		if self:isSidValid(iter_36_1) then
			var_36_0[#var_36_0 + 1] = iter_36_1
		end
	end

	return var_36_0
end

function FormationStruct:canLineUpUniteToken(arg_37_1, arg_37_2)
	if self._limitUniteTokenNum < 0 and self._limitUniteCnt < 0 then
		return true
	end

	if arg_37_1 then
		if self:isSidValid(self._uniteTokenSidArr[arg_37_1]) or self:getUniteTokenSid(arg_37_2) ~= 0 then
			return true
		end
	end

	local var_37_0 = self:getValidUniteTokenSidList()

	if self._limitUniteTokenNum >= 0 then
		return #var_37_0 < self._limitUniteTokenNum
	elseif self._limitUniteCnt >= 0 then
		return #var_37_0 < self._limitUniteCnt
	end
end

function FormationStruct:isUniteTokenNumValid()
	if self._limitUniteTokenNum < 0 and self._limitUniteCnt < 0 then
		return true
	end

	local var_38_0 = self:getValidUniteTokenSidList()

	if self._limitUniteTokenNum >= 0 then
		return #var_38_0 == self._limitUniteTokenNum
	elseif self._limitUniteCnt >= 0 then
		return #var_38_0 <= self._limitUniteCnt
	end
end

function FormationStruct:lineupUniteToken(arg_39_1, arg_39_2)
	self:_changeStationPos(self._uniteTokenSidArr, arg_39_1, arg_39_2)
end

function FormationStruct:takeOffUniteToken(arg_40_1)
	local var_40_0 = self:getUniteTokenStationPos(arg_40_1)

	if self:isPositionValid(var_40_0) then
		self:lineupUniteToken(var_40_0, 0)
	end
end

function FormationStruct:setLimitUpPetNum(arg_41_1)
	self._limitPetNum = arg_41_1
end

function FormationStruct:getLimitUpPetNum()
	return self._limitPetNum
end

function FormationStruct:setLimitUpPetCnt(arg_43_1)
	self._limitPetCnt = arg_43_1
end

function FormationStruct:getLimitUpPetCnt()
	return self._limitPetCnt
end

function FormationStruct:getValidPetSidList()
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in ipairs(self._petSidArr) do
		if self:isSidValid(iter_45_1) then
			var_45_0[#var_45_0 + 1] = iter_45_1
		end
	end

	return var_45_0
end

function FormationStruct:canLineUpPet(arg_46_1, arg_46_2)
	if self._limitPetNum < 0 and self._limitPetCnt < 0 then
		return true
	end

	if arg_46_1 then
		if self:isSidValid(self._petSidArr[arg_46_1]) or self:getPetSid(arg_46_2) ~= 0 then
			return true
		end
	end

	local var_46_0 = self:getValidPetSidList()

	if self._limitPetNum >= 0 then
		return #var_46_0 < self._limitPetNum
	elseif self._limitPetCnt >= 0 then
		return #var_46_0 < self._limitPetCnt
	end
end

function FormationStruct:isPetNumValid()
	if self._limitPetNum < 0 and self._limitPetCnt < 0 then
		return true
	end

	local var_47_0 = self:getValidPetSidList()

	if self._limitPetNum >= 0 then
		return #var_47_0 == self._limitPetNum
	elseif self._limitPetCnt >= 0 then
		return #var_47_0 <= self._limitPetCnt
	end
end

function FormationStruct:lineupPet(arg_48_1, arg_48_2)
	self:_changeStationPos(self._petSidArr, arg_48_1, arg_48_2)
end

function FormationStruct:takeOffPet(arg_49_1)
	local var_49_0 = self:getPetStationPos(arg_49_1)

	if self:isPositionValid(var_49_0) then
		self:lineupPet(var_49_0, 0)
	end
end

function FormationStruct:lineupPreciousSuit(arg_50_1, arg_50_2)
	self:_changeStationPos(self._preciousSuitSidArr, arg_50_1, arg_50_2)
end

function FormationStruct:takeOffPreciousSuit(arg_51_1)
	local var_51_0 = self:getPreciousSuitStationPos(arg_51_1)

	if self:isPositionValid(var_51_0) then
		self:lineupPreciousSuit(var_51_0, 0)
	end
end

function FormationStruct:setLimitUpSuccubaNum(arg_52_1)
	self._limitSuccubaNum = arg_52_1
end

function FormationStruct:getLimitUpSuccubaNum()
	return self._limitSuccubaNum
end

function FormationStruct:setLimitUpSuccubaCnt(arg_54_1)
	self._limitSuccubaCnt = arg_54_1
end

function FormationStruct:getLimitUpSuccubaCnt()
	return self._limitSuccubaCnt
end

function FormationStruct:getValidSuccubaSidList()
	local var_56_0 = {}

	for iter_56_0, iter_56_1 in ipairs(self._succubaSidArr) do
		if self:isSidValid(iter_56_1) then
			var_56_0[#var_56_0 + 1] = iter_56_1
		end
	end

	return var_56_0
end

function FormationStruct:canLineUpSuccuba(arg_57_1, arg_57_2)
	if self._limitSuccubaNum < 0 and self._limitSuccubaCnt < 0 then
		return true
	end

	if arg_57_1 then
		if self:isSidValid(self._succubaSidArr[arg_57_1]) or self:getSuccubaStationPos(arg_57_2) ~= 0 then
			return true
		end
	end

	local var_57_0 = self:getValidSuccubaSidList()

	if self._limitSuccubaNum >= 0 then
		return #var_57_0 < self._limitSuccubaNum
	elseif self._limitSuccubaCnt >= 0 then
		return #var_57_0 < self._limitSuccubaCnt
	end
end

function FormationStruct:isSuccubaNumValid()
	if self._limitSuccubaNum < 0 and self._limitSuccubaCnt < 0 then
		return true
	end

	local var_58_0 = self:getValidSuccubaSidList()

	if self._limitSuccubaNum >= 0 then
		return #var_58_0 == self._limitSuccubaNum
	elseif self._limitSuccubaCnt >= 0 then
		return #var_58_0 <= self._limitSuccubaCnt
	end
end

function FormationStruct:lineupSuccuba(arg_59_1, arg_59_2)
	self:_changeStationPos(self._succubaSidArr, arg_59_1, arg_59_2)
end

function FormationStruct:takeOffSuccuba(arg_60_1)
	local var_60_0 = self:getSuccubaStationPos(arg_60_1)

	if self:isPositionValid(var_60_0) then
		self:lineupSuccuba(var_60_0, 0)
	end
end

function FormationStruct:isKnightLineUp(arg_61_1)
	return self:isPositionValid((self:getKnightStationPos(arg_61_1)))
end

function FormationStruct:isStationPosLineupKnight(arg_62_1)
	return self:isSidValid((self:getKnightSid(arg_62_1)))
end

function FormationStruct:isArtifactLineUp(arg_63_1)
	return self:isPositionValid((self:getArtifactStationPos(arg_63_1)))
end

function FormationStruct:isStationPosLineupArtifact(arg_64_1)
	return self:isSidValid((self:getArtifactSid(arg_64_1)))
end

function FormationStruct:isUniteTokenLineUp(arg_65_1)
	return self:isPositionValid((self:getUniteTokenStationPos(arg_65_1)))
end

function FormationStruct:isStationPosLineupUniteToken(arg_66_1)
	return self:isSidValid((self:getUniteTokenSid(arg_66_1)))
end

function FormationStruct:isPetLineUp(arg_67_1)
	return self:isPositionValid((self:getPetStationPos(arg_67_1)))
end

function FormationStruct:isStationPosLineupPet(arg_68_1)
	return self:isSidValid((self:getPetSid(arg_68_1)))
end

function FormationStruct:isPreciousSuitLineUp(arg_69_1)
	return self:isPositionValid((self:getPreciousSuitStationPos(arg_69_1)))
end

function FormationStruct:isStationPosLineupPreciousSuit(arg_70_1)
	return self:isSidValid((self:getPreciousSuitSid(arg_70_1)))
end

function FormationStruct:isSuccubaLineUp(arg_71_1)
	return self:isPositionValid((self:getSuccubaStationPos(arg_71_1)))
end

function FormationStruct:isStationPosLineupSuccuba(arg_72_1)
	return self:isSidValid((self:getSuccubaSid(arg_72_1)))
end

function FormationStruct:isPositionValid(arg_73_1)
	return arg_73_1 and arg_73_1 > 0
end

function FormationStruct:isSidValid(arg_74_1)
	return arg_74_1 and arg_74_1 > 0
end

function FormationStruct:isThereKnightLineup()
	for iter_75_0, iter_75_1 in ipairs(self._knightSidArr) do
		if self:isSidValid(iter_75_1) then
			return true
		end
	end

	return false
end

function FormationStruct:getFormationType()
	return self._type
end

function FormationStruct:getFormationIdx()
	return self._index
end

function FormationStruct:getKnightSid(arg_78_1)
	return self:_getValueDefault_0(self._knightSidArr, arg_78_1)
end

function FormationStruct:getKnightStationPos(arg_79_1)
	return self:_getKeyDefault_0(self._knightSidArr, arg_79_1)
end

function FormationStruct:getArtifactSid(arg_80_1)
	return self:_getValueDefault_0(self._artifactSidArr, arg_80_1)
end

function FormationStruct:getArtifactStationPos(arg_81_1)
	return self:_getKeyDefault_0(self._artifactSidArr, arg_81_1)
end

function FormationStruct:getUniteTokenSid(arg_82_1)
	return self:_getValueDefault_0(self._uniteTokenSidArr, arg_82_1)
end

function FormationStruct:getUniteTokenStationPos(arg_83_1)
	return self:_getKeyDefault_0(self._uniteTokenSidArr, arg_83_1)
end

function FormationStruct:getPetSid(arg_84_1)
	return self:_getValueDefault_0(self._petSidArr, arg_84_1)
end

function FormationStruct:getPetStationPos(arg_85_1)
	return self:_getKeyDefault_0(self._petSidArr, arg_85_1)
end

function FormationStruct:getPreciousSuitSid(arg_86_1)
	return self:_getValueDefault_0(self._preciousSuitSidArr, arg_86_1)
end

function FormationStruct:getPreciousSuitStationPos(arg_87_1)
	return self:_getKeyDefault_0(self._preciousSuitSidArr, arg_87_1)
end

function FormationStruct:getSuccubaSid(arg_88_1)
	return self:_getValueDefault_0(self._succubaSidArr, arg_88_1)
end

function FormationStruct:getSuccubaStationPos(arg_89_1)
	return self:_getKeyDefault_0(self._succubaSidArr, arg_89_1)
end

function FormationStruct:getKnightSidArr()
	return self._knightSidArr
end

function FormationStruct:getKnightDict()
	local var_91_0 = {}

	for iter_91_0, iter_91_1 in pairs(self._knightSidArr) do
		if self:isSidValid(iter_91_1) then
			local var_91_1 = g.core.model.User.knightsData:getKnight({
				id = iter_91_1
			})

			if var_91_1 then
				var_91_0[iter_91_0] = var_91_1
			end
		end
	end

	return var_91_0
end

function FormationStruct:getArtifactSidArr()
	return self._artifactSidArr
end

function FormationStruct:getUniteTokenSidArr()
	return self._uniteTokenSidArr
end

function FormationStruct:getPetSidArr()
	return self._petSidArr
end

function FormationStruct:getPreciousSuitSidArr()
	return self._preciousSuitSidArr
end

function FormationStruct:getSuccubaSidArr()
	return self._succubaSidArr
end

function FormationStruct:getFormationUniqueId()
	return self._uniqueId
end

function FormationStruct:getHaloGroupInfo()
	return self:_getHaloGroupInfo((table.values((self:getKnightDict()))))
end

function FormationStruct:getLeaderGainTV()
	local var_99_0 = self:getHaloGroupInfo()

	return var_99_0.group, var_99_0.curCnt
end

function FormationStruct:hasAnyGoodsLineUp(arg_100_1)
	local var_100_0 = false

	local function var_100_1(arg_101_0)
		arg_101_0 = arg_101_0 or {}

		for iter_101_0, iter_101_1 in ipairs(arg_101_0) do
			if iter_101_1 > 0 then
				return true
			end
		end

		return false
	end

	if arg_100_1 == g.core.common.Goods.TYPE_KNIGHT then
		var_100_0 = var_100_1(self._knightSidArr)
	elseif arg_100_1 == g.core.common.Goods.TYPE_ARTIFACT then
		var_100_0 = var_100_1(self._artifactSidArr)
	elseif arg_100_1 == g.core.common.Goods.TYPE_UNITETOKEN then
		var_100_0 = var_100_1(self._uniteTokenSidArr)
	elseif arg_100_1 == g.core.common.Goods.TYPE_PET then
		var_100_0 = var_100_1(self._petSidArr)
	end

	return var_100_0
end

function FormationStruct:hasNotGoodsLineUp(arg_102_1)
	local var_102_0 = false

	local function var_102_1(arg_103_0)
		arg_103_0 = arg_103_0 or {}

		for iter_103_0, iter_103_1 in pairs(arg_103_0) do
			if not self:isSidValid(iter_103_1) then
				return true
			end
		end

		return false
	end

	if arg_102_1 == g.core.common.Goods.TYPE_KNIGHT then
		var_102_0 = var_102_1(self._knightSidArr)
	elseif arg_102_1 == g.core.common.Goods.TYPE_ARTIFACT then
		var_102_0 = var_102_1(self._artifactSidArr)
	elseif arg_102_1 == g.core.common.Goods.TYPE_UNITETOKEN then
		var_102_0 = var_102_1(self._uniteTokenSidArr)
	elseif arg_102_1 == g.core.common.Goods.TYPE_PET then
		var_102_0 = var_102_1(self._petSidArr)
	end

	return var_102_0
end

function FormationStruct:getTeamProcess()
	local var_104_0 = 0

	for iter_104_0, iter_104_1 in pairs(g.core.const.ConstMgr.FormationConst.GOODS_TYPE_PROCESS_MAP) do
		if self:hasAnyGoodsLineUp(iter_104_0) then
			var_104_0 = var_104_0 + g.core.config.parameter_info.get(iter_104_1).parameter
		end
	end

	return var_104_0
end

function FormationStruct:getFightValue()
	return self._fightValue
end

return FormationStruct
