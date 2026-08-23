local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local SpecialFormationStruct = class("SpecialFormationStruct")

function SpecialFormationStruct:ctor()
	self._idx = 0
	self._knightPosList = {}
	self._knightPosMap = {}
	self._knightSidMap = {}
	self._groupHaloInfo = {}
	self._uniteTokenList = {}
	self._petList = {}
	self._preciousSuitList = {}
	self._otherUserSuitList = {}
	self._succubaList = {}
	self._otherUserSuccubaList = {}
	self._extInfo = {}
end

function SpecialFormationStruct:setKnight(arg_2_1, arg_2_2)
	local var_2_0 = self:getKnight(arg_2_2)

	if var_2_0 then
		self._knightPosMap[var_2_0:getAdvanceId()] = nil

		local var_2_1 = var_2_0:getServerId()

		if var_2_1 > 0 then
			self._knightSidMap[var_2_1] = nil
		end

		var_2_0:updatePos(0)
		var_2_0:updateTempFormationPos(0)
	end

	if arg_2_1 then
		self._knightPosMap[arg_2_1:getAdvanceId()] = arg_2_2

		local var_2_2 = arg_2_1:getServerId()

		if var_2_2 > 0 then
			self._knightSidMap[var_2_2] = arg_2_1
		end

		arg_2_1:updatePos(arg_2_2)
		arg_2_1:updateTempFormationPos(self._idx)
	end

	self._knightPosList[arg_2_2] = arg_2_1
end

function SpecialFormationStruct:getKnight(arg_3_1)
	return self._knightPosList[arg_3_1]
end

function SpecialFormationStruct:popKnight(arg_4_1)
	local var_4_0 = self:getKnight(arg_4_1)

	var_4_0:setDevelopStruct(nil, var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT)
	self:setKnight(nil, arg_4_1)

	return var_4_0
end

function SpecialFormationStruct:getFormationFight()
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in pairs(self._knightPosList) do
		var_5_0 = var_5_0 + iter_5_1:getKnightFight()
	end

	return var_5_0
end

function SpecialFormationStruct:switchKnight(arg_6_1, arg_6_2)
	if self._knightPosList[arg_6_1] and self._knightPosList[arg_6_2] then
		self._knightPosList[arg_6_1]:setDevelopStruct(self._knightPosList[arg_6_2]:getDevelopStruct(var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT), var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT)
		self._knightPosList[arg_6_2]:setDevelopStruct(self._knightPosList[arg_6_1]:getDevelopStruct(var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT), var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT)
	end

	self:setKnight(nil, arg_6_1)
	self:setKnight(nil, arg_6_2)
	self:setKnight(self._knightPosList[arg_6_1], arg_6_2)
	self:setKnight(self._knightPosList[arg_6_2], arg_6_1)
end

function SpecialFormationStruct:switchArtifact(arg_7_1, arg_7_2)
	if self._knightPosList[arg_7_1] and self._knightPosList[arg_7_2] then
		self._knightPosList[arg_7_1]:setDevelopStruct(self._knightPosList[arg_7_2]:getDevelopStruct(var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT), var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT)
		self._knightPosList[arg_7_2]:setDevelopStruct(self._knightPosList[arg_7_1]:getDevelopStruct(var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT), var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT)
	end
end

function SpecialFormationStruct:getKnightPosList()
	return self._knightPosList
end

function SpecialFormationStruct:setFormationIdx(arg_9_1)
	self._idx = arg_9_1

	for iter_9_0, iter_9_1 in pairs(self._knightPosList) do
		iter_9_1:updateTempFormationPos(self._idx)
	end
end

function SpecialFormationStruct:getFormationIdx()
	return self._idx
end

function SpecialFormationStruct:hasKnight(arg_11_1)
	return self._knightPosMap[arg_11_1] ~= nil
end

function SpecialFormationStruct:getKnightPos(arg_12_1)
	return self._knightPosMap[arg_12_1] or 0
end

function SpecialFormationStruct:getKnightByServerId(arg_13_1)
	return self._knightSidMap[arg_13_1]
end

function SpecialFormationStruct:getKnightsNum()
	return table.nums(self._knightPosList)
end

function SpecialFormationStruct:checkGroupHalo()
	local var_15_0 = {}

	for iter_15_0 = 1, 6 do
		if self._knightPosList[iter_15_0] then
			var_15_0[#var_15_0 + 1] = self._knightPosList[iter_15_0]
		end
	end

	self._groupHaloInfo = g.core.model.User.formationData:getGroupInfo(var_15_0)
	self._groupHaloInfo.count = self._groupHaloInfo.count or 0
end

function SpecialFormationStruct:getGroupHaloInfo()
	return self._groupHaloInfo
end

function SpecialFormationStruct:checkIsWear(arg_17_1)
	for iter_17_0, iter_17_1 in pairs(self._uniteTokenList) do
		if iter_17_1:getServerId() == arg_17_1:getServerId() then
			return true
		end
	end

	return false
end

function SpecialFormationStruct:setUniteToken(arg_18_1, arg_18_2)
	self._uniteTokenList[arg_18_2] = arg_18_1
end

function SpecialFormationStruct:takeOffUniteToken(arg_19_1)
	for iter_19_0, iter_19_1 in pairs(self._uniteTokenList) do
		if iter_19_1:getServerId() == arg_19_1:getServerId() then
			self._uniteTokenList[iter_19_0] = nil

			return
		end
	end
end

function SpecialFormationStruct:getUniteToken(arg_20_1)
	return self._uniteTokenList[arg_20_1]
end

function SpecialFormationStruct:switchUniteToken(arg_21_1, arg_21_2)
	self:setUniteToken(self:getUniteToken(arg_21_1), arg_21_2)
	self:setUniteToken(self:getUniteToken(arg_21_2), arg_21_1)
end

function SpecialFormationStruct:getUniteTokenList()
	return self._uniteTokenList
end

function SpecialFormationStruct:checkPetIsLineUp(arg_23_1)
	for iter_23_0, iter_23_1 in pairs(self._petList) do
		if iter_23_1:getSid() == arg_23_1:getSid() then
			return true
		end
	end

	return false
end

function SpecialFormationStruct:setPet(arg_24_1, arg_24_2)
	if self._petList[arg_24_2] then
		self._petList[arg_24_2]:setLineupPos(0)
	end

	self._petList[arg_24_2] = arg_24_1

	if arg_24_1 then
		arg_24_1:setLineupPos(arg_24_2)
	end
end

function SpecialFormationStruct:takeOffPet(arg_25_1)
	for iter_25_0, iter_25_1 in pairs(self._petList) do
		if iter_25_1:getSid() == arg_25_1:getSid() then
			self._petList[iter_25_0] = nil

			return
		end
	end
end

function SpecialFormationStruct:getPet(arg_26_1)
	return self._petList[arg_26_1]
end

function SpecialFormationStruct:switchPet(arg_27_1, arg_27_2)
	self:setPet(self:getPet(arg_27_1), arg_27_2)
	self:setPet(self:getPet(arg_27_2), arg_27_1)
end

function SpecialFormationStruct:getPetList()
	return self._petList
end

function SpecialFormationStruct:isPreciousSuitLineUp(arg_29_1)
	for iter_29_0, iter_29_1 in pairs(self._preciousSuitList) do
		if iter_29_1 == arg_29_1 then
			return true
		end
	end

	return false
end

function SpecialFormationStruct:getPreciousSuitPos(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(self._preciousSuitList) do
		if iter_30_1 == arg_30_1 then
			return iter_30_0
		end
	end

	return 0
end

function SpecialFormationStruct:lineupPreciousSuit(arg_31_1, arg_31_2)
	local var_31_0 = self:getPreciousSuitPos(arg_31_2)

	if arg_31_2 > 0 then
		self._preciousSuitList[var_31_0] = self._preciousSuitList[arg_31_1]
	end

	self._preciousSuitList[arg_31_1] = var_31_0 == arg_31_1 and 0 or arg_31_2
end

function SpecialFormationStruct:setPreciousSuit(arg_32_1, arg_32_2)
	self._preciousSuitList[arg_32_1] = arg_32_2
end

function SpecialFormationStruct:getPreciousSuitId(arg_33_1)
	return self._preciousSuitList[arg_33_1] or 0
end

function SpecialFormationStruct:getPreciousSuitList()
	return self._preciousSuitList
end

function SpecialFormationStruct:takeOffPreciousSuit(arg_35_1)
	local var_35_0 = self:getPreciousSuitPos(arg_35_1)

	if var_35_0 > 0 then
		self._preciousSuitList[var_35_0] = 0
	end
end

function SpecialFormationStruct:setOtherUserSuit(arg_36_1, arg_36_2)
	self._otherUserSuitList[arg_36_1] = arg_36_2
end

function SpecialFormationStruct:getOtherUserSuit()
	return self._otherUserSuitList
end

function SpecialFormationStruct:isSuccubaLineUp(arg_38_1)
	for iter_38_0, iter_38_1 in pairs(self._succubaList) do
		if iter_38_1 == arg_38_1 then
			return true
		end
	end

	return false
end

function SpecialFormationStruct:getSuccubaPos(arg_39_1)
	for iter_39_0, iter_39_1 in pairs(self._succubaList) do
		if iter_39_1 == arg_39_1 then
			return iter_39_0
		end
	end

	return 0
end

function SpecialFormationStruct:lineupSuccuba(arg_40_1, arg_40_2)
	local var_40_0 = self:getSuccubaPos(arg_40_2)

	if arg_40_2 > 0 and var_40_0 ~= 0 then
		self._succubaList[var_40_0] = self._succubaList[arg_40_1]
	end

	self._succubaList[arg_40_1] = var_40_0 == arg_40_1 and 0 or arg_40_2
end

function SpecialFormationStruct:setSuccuba(arg_41_1, arg_41_2)
	self._succubaList[arg_41_1] = arg_41_2
end

function SpecialFormationStruct:getSuccubaId(arg_42_1)
	return self._succubaList[arg_42_1] or 0
end

function SpecialFormationStruct:getSuccubaList()
	return self._succubaList
end

function SpecialFormationStruct:takeOffSuccuba(arg_44_1)
	local var_44_0 = self:getSuccubaPos(arg_44_1)

	if var_44_0 > 0 then
		self._succubaList[var_44_0] = 0
	end
end

function SpecialFormationStruct:setOtherUserSuccuba(arg_45_1, arg_45_2)
	self._otherUserSuccubaList[arg_45_1] = arg_45_2
end

function SpecialFormationStruct:getOtherUserSuccuba()
	return self._otherUserSuccubaList
end

function SpecialFormationStruct:switchSuccuba(arg_47_1, arg_47_2)
	self:setSuccuba(arg_47_2, (self:getSuccubaId(arg_47_1)))
	self:setSuccuba(arg_47_1, (self:getSuccubaId(arg_47_2)))
end

function SpecialFormationStruct:getSuccubaStructList()
	local var_48_0 = {}

	for iter_48_0 = 1, var_0_0.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX do
		local var_48_1 = self:getSuccubaStruct(iter_48_0)

		if var_48_1 then
			var_48_0[#var_48_0 + 1] = var_48_1
		end
	end
end

function SpecialFormationStruct:setExtInfo(arg_49_1, arg_49_2)
	self._extInfo[arg_49_1] = arg_49_2
end

function SpecialFormationStruct:getExtInfo(arg_50_1)
	return self._extInfo[arg_50_1]
end

function SpecialFormationStruct:getFormationString()
	local var_51_0 = {}
	local var_51_1 = {}

	for iter_51_0 = 1, var_0_0.KNIGHT_CONST.LINEUP_MAX do
		local var_51_2 = self:getKnight(iter_51_0)

		if var_51_2 then
			var_51_1[#var_51_1 + 1] = var_51_2:getKnightString()
		end
	end

	var_51_0[#var_51_0 + 1] = table.concat(var_51_1, "|")

	local var_51_3 = {}

	for iter_51_1 = 1, var_0_0.UniteTokenConst.FORMAT_UNITE_NUM_MAX do
		if self._uniteTokenList[iter_51_1] then
			var_51_3[#var_51_3 + 1] = self._uniteTokenList[iter_51_1]:getServerId()
		end
	end

	var_51_0[#var_51_0 + 1] = table.concat(var_51_3, "|")

	local var_51_4 = {}

	for iter_51_2 = 1, var_0_0.PetConst.LINEUP_MAX do
		if self._petList[iter_51_2] then
			var_51_4[#var_51_4 + 1] = self._petList[iter_51_2]:getSid()
		end
	end

	var_51_0[#var_51_0 + 1] = var_51_4

	local var_51_5 = {}

	for iter_51_3 = 1, var_0_0.PreciousConst.LINEUP_MAX do
		var_51_5[#var_51_5 + 1] = self._preciousSuitList[iter_51_3] or 0
	end

	var_51_0[#var_51_0 + 1] = var_51_5

	local var_51_6 = {}

	for iter_51_4 = 1, var_0_0.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX do
		var_51_6[#var_51_6 + 1] = self._succubaList[iter_51_4] or 0
	end

	var_51_0[#var_51_0 + 1] = var_51_6

	return (("" .. "&") .. "&") .. "&"
end

return SpecialFormationStruct
