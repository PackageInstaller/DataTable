local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_1 = g.core.model.User.knightsData
local var_0_2 = g.core.model.User.artifactData
local var_0_3 = g.core.model.User.petsData
local var_0_4 = g.core.model.User.uniteTokenData
local FightValueCalculation = require("app.core.common.FightValue.FightValueCalculation")
local MulFormationStruct = class("MulFormationStruct", import(".FormationStruct"))

function MulFormationStruct:ctor(arg_1_1, arg_1_2)
	assert(arg_1_1 > 0 and arg_1_2 > 0, "Error! MulFormationStruct:ctor invalid mulType, index", arg_1_1, arg_1_2)
	self.super.ctor(self)

	self._type = arg_1_1
	self._index = arg_1_2

	local var_1_0 = {}

	for iter_1_0 = 1, var_0_0.LINEUP_MAX do
		var_1_0[iter_1_0] = iter_1_0
	end

	self._knightPosArr = var_1_0
	self._posKeyEquipmentTreasureAttrDict = {}
	self._petAttrDict = {}
	self._uniteTokenAttrDict = {}
	self._otherFixedAttrDict = {}
	self._advanceIdCheckEnable = false

	if g.core.config.multi_team_formation_info.get(arg_1_1).succuba_limit == 1 then
		self:setLimitUpSuccubaCnt(0)
	end
end

function MulFormationStruct:setAdvanceIdEnable(arg_2_1)
	self._advanceIdCheckEnable = arg_2_1
end

function MulFormationStruct:setSvrData(arg_3_1)
	self.super.setSvrData(self, arg_3_1)

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.position or {}) do
		if self:isPositionValid(iter_3_1) then
			var_3_0[iter_3_1] = iter_3_0
		end
	end

	for iter_3_2 in ipairs(self._knightPosArr) do
		self._knightPosArr[iter_3_2] = self:isPositionValid(var_3_0[iter_3_2]) and var_3_0[iter_3_2] or iter_3_2
	end

	self:_updatePetAttr()
	self:_updateUniteTokenAttr()
end

function MulFormationStruct:toOutBaseFormation()
	local var_4_0 = self.super.toOutBaseFormation(self)
	local var_4_1 = {}
	local var_4_2 = {}
	local var_4_3 = {}

	for iter_4_0, iter_4_1 in pairs(self._knightPosArr) do
		var_4_2[iter_4_1] = iter_4_0
		var_4_1[iter_4_1] = self:getKnightSid(iter_4_0)
		var_4_3[iter_4_1] = self:getArtifactSid(iter_4_0)
	end

	var_4_0.knight_id = var_4_1
	var_4_0.position = var_4_2
	var_4_0.artifact_id = var_4_3

	return var_4_0
end

function MulFormationStruct:lineupKnight(arg_5_1, arg_5_2)
	if not self:canLineUpKnight(arg_5_1, arg_5_2) then
		return
	end

	arg_5_2 = arg_5_2 or 0

	if self:isSidValid(arg_5_2) then
		if self:isKnightLineUp(arg_5_2) then
			local var_5_0 = self:getKnightStationPos(arg_5_2)

			self._knightPosArr[var_5_0] = self:getKnightPosByStationPos(arg_5_1)
			self._knightPosArr[arg_5_1] = self:getKnightPosByStationPos(var_5_0)

			self.super.lineupKnight(self, arg_5_1, arg_5_2)

			if self:isStationPosLineupArtifact(var_5_0) then
				self:lineupArtifact(arg_5_1, (self:getArtifactSid(var_5_0)))
			elseif self:isStationPosLineupArtifact(arg_5_1) then
				self:lineupArtifact(var_5_0, (self:getArtifactSid(arg_5_1)))
			end
		else
			self.super.lineupKnight(self, arg_5_1, arg_5_2)

			if not self:isStationPosLineupArtifact(arg_5_1) then
				self:lineupRelatedArtifact(arg_5_1)
			else
				local var_5_1 = var_0_1:getKnight({
					id = arg_5_2
				})
				local var_5_2 = self:getArtifactSid(arg_5_1)

				if not var_0_2:getArtifactBySid(var_5_2):checkWearKnight(var_5_1:getAdvanceId()) then
					self:takeOffArtifact(var_5_2)
				end
			end
		end
	else
		self.super.lineupKnight(self, arg_5_1, arg_5_2)
		self:lineupArtifact(arg_5_1, 0)
	end
end

function MulFormationStruct:lineupRelatedArtifact(arg_6_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT) then
		return
	end

	local var_6_0 = self:getKnightSid(arg_6_1)

	if not self:isSidValid(var_6_0) then
		return
	end

	local var_6_1 = self:getUndressedMaxQualityRelatedArtifactByKnight((var_0_1:getKnightById(var_6_0)))

	if var_6_1 then
		self:lineupArtifact(arg_6_1, (var_6_1:getServerOnlyId()))
	end
end

function MulFormationStruct:lineupPet(arg_7_1, arg_7_2, arg_7_3)
	if self._advanceIdCheckEnable and arg_7_3 then
		local var_7_0 = self:getPetStationPosByAdvanceId(arg_7_3, arg_7_2)

		if self:isPositionValid(var_7_0) then
			self.super.lineupPet(self, var_7_0, 0)
		end
	end

	self.super.lineupPet(self, arg_7_1, arg_7_2)
	self:_updatePetAttr()
end

function MulFormationStruct:takeOffPet(arg_8_1, arg_8_2)
	if not self:isSidValid(arg_8_1) and self._advanceIdCheckEnable and arg_8_2 then
		arg_8_1 = self._petSidArr[self:getPetStationPosByAdvanceId(arg_8_2, arg_8_1)]
	end

	self.super.takeOffPet(self, arg_8_1)
	self:_updatePetAttr()
end

function MulFormationStruct:lineupUniteToken(arg_9_1, arg_9_2)
	if self._advanceIdCheckEnable then
		local var_9_0 = self:getUniteTokenStationPos(arg_9_2)

		if self:isPositionValid(var_9_0) then
			self.super.lineupUniteToken(self, var_9_0, 0)
		end
	end

	self.super.lineupUniteToken(self, arg_9_1, arg_9_2)
end

function MulFormationStruct:takeOffUniteToken(arg_10_1)
	if self._advanceIdCheckEnable then
		arg_10_1 = self._uniteTokenSidArr[self:getUniteTokenStationPos(arg_10_1)]
	end

	self.super.takeOffUniteToken(self, arg_10_1)
end

function MulFormationStruct:getKnightPosByStationPos(arg_11_1)
	local var_11_0 = self:_getValueDefault_0(self._knightPosArr, arg_11_1)

	if self:isPositionValid(var_11_0) then
		return var_11_0
	else
		self._knightPosArr[arg_11_1] = arg_11_1

		return arg_11_1
	end
end

function MulFormationStruct:getKnightStationPosByPos(arg_12_1)
	local var_12_0 = self:_getKeyDefault_0(self._knightPosArr, arg_12_1)

	if self:isPositionValid(var_12_0) then
		return var_12_0
	else
		self._knightPosArr[arg_12_1] = arg_12_1

		return arg_12_1
	end
end

function MulFormationStruct:getKnightSidByPos(arg_13_1)
	return self:getKnightSid((self:getKnightStationPosByPos(arg_13_1)))
end

function MulFormationStruct:getKnightPos(arg_14_1)
	return self:getKnightPosByStationPos((self:getKnightStationPos(arg_14_1)))
end

function MulFormationStruct:getArtifactSidByPos(arg_15_1)
	return self:getArtifactSid((self:getKnightStationPosByPos(arg_15_1)))
end

function MulFormationStruct:getArtifactPos(arg_16_1)
	return self:getKnightPosByStationPos((self:getArtifactStationPos(arg_16_1)))
end

function MulFormationStruct:getUniteTokenSidByPos(arg_17_1)
	return self:getUniteTokenSid(arg_17_1)
end

function MulFormationStruct:getUniteTokenPos(arg_18_1)
	return self:getUniteTokenStationPos(arg_18_1)
end

function MulFormationStruct:getPetSidByPos(arg_19_1)
	return self:getPetSid(arg_19_1)
end

function MulFormationStruct:getPetPos(arg_20_1)
	return self:getPetStationPos(arg_20_1)
end

function MulFormationStruct:getBindKnight(arg_21_1)
	return (var_0_1:getKnight({
		pos = self:getKnightPosByStationPos(arg_21_1)
	}))
end

function MulFormationStruct:getBindArtifact(arg_22_1)
	return (var_0_2:getArtifactByPos((self:getKnightPosByStationPos(arg_22_1))))
end

function MulFormationStruct:getBindUniteToken(arg_23_1)
	return var_0_4:getLineupTokenByPos(arg_23_1)
end

function MulFormationStruct:getBindPet(arg_24_1)
	return var_0_3:getPetByPos(arg_24_1)
end

function MulFormationStruct:getFightValue()
	if self._fightValue > 0 then
		return self.super.getFightValue(self)
	end

	local var_25_0 = 0

	for iter_25_0, iter_25_1 in ipairs(self._knightSidArr) do
		local var_25_1 = {}

		if self:isSidValid(iter_25_1) then
			local var_25_2 = 1
			local var_25_3 = 0
			local var_25_4 = self:getBindKnight(iter_25_0)

			if var_25_4 then
				var_25_2 = var_25_4:getLevel()
				var_25_3 = var_25_4:getPromoteLevel()
			end

			local var_25_5 = var_0_1:getKnightById(iter_25_1)

			FightValueCalculation.addAttr(var_25_1, (FightValueCalculation.getMulTeamKnightAttrList(var_25_5, var_25_2, var_25_3)))
			FightValueCalculation.addAttr(var_25_1, (FightValueCalculation.getKnightFavorLevelAttrList(var_25_5)))

			local var_25_6, var_25_7 = self:getLeaderGainTV()

			FightValueCalculation.addAttr(var_25_1, (FightValueCalculation.getGroupHaloAttrList(var_25_7)))
			self:_addArtifactsAttr(var_25_1, iter_25_0)
			FightValueCalculation.addAttr(var_25_1, self._posKeyEquipmentTreasureAttrDict[self:getKnightPosByStationPos(iter_25_0)])
			FightValueCalculation.addAttr(var_25_1, self._petAttrDict)
			FightValueCalculation.addAttr(var_25_1, self._uniteTokenAttrDict)
			FightValueCalculation.addAttr(var_25_1, self._otherFixedAttrDict)

			var_25_0 = var_25_0 + FightValueCalculation.calculationFightValue(var_25_1, true)
		end
	end

	return var_25_0
end

function MulFormationStruct:_addArtifactsAttr(arg_26_1, arg_26_2)
	local var_26_0 = self:getArtifactSid(arg_26_2)
	local var_26_1 = self:getKnightSid(arg_26_2)

	if self:isSidValid(var_26_0) and self:isSidValid(var_26_1) then
		local var_26_2 = self:getBindArtifact(arg_26_2)

		if var_26_2 then
			FightValueCalculation.addAttr(arg_26_1, (FightValueCalculation.getArtifactLevelAttrList(var_26_2:getUpgradeCodeId(), (var_26_2:getLevel()))))
		end

		local var_26_3 = var_0_2:getArtifactBySid(var_26_0)
		local var_26_4 = var_0_1:getKnightById(var_26_1):getBaseInfo()

		FightValueCalculation.addAttr(arg_26_1, (FightValueCalculation.getArtifactStarAttrList(var_26_3:getCfg().id, var_26_4.id, var_26_4)))
	end
end

function MulFormationStruct:_updatePetAttr()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(self._petSidArr) do
		if self:isSidValid(iter_27_1) then
			local var_27_1 = 1
			local var_27_2 = 0
			local var_27_3 = 0
			local var_27_4 = self:getBindPet(iter_27_0)

			if var_27_4 then
				var_27_1 = var_27_4:getLevel()
				var_27_2, var_27_3 = var_27_4:getBigSmallStage()
			end

			local var_27_5 = g.core.model.User.mulFormationData:getPetBySid(self:getFormationType(), iter_27_1)

			if var_27_5 then
				FightValueCalculation.addAttr(var_27_0, (FightValueCalculation.getPetAttrList(var_27_5, var_27_1, var_27_2, var_27_3)))
			end
		end
	end

	self._petAttrDict = var_27_0
end

function MulFormationStruct:_updateUniteTokenAttr()
	local var_28_0 = {}

	FightValueCalculation.addAttr(var_28_0, (FightValueCalculation.getAllUniteTokenAttrList()))

	self._uniteTokenAttrDict = var_28_0
end

function MulFormationStruct:_getOtherFixedAttr()
	local var_29_0 = {}

	FightValueCalculation.addAttr(var_29_0, (FightValueCalculation.getFurnitureAttrList()))
	FightValueCalculation.addAttr(var_29_0, (FightValueCalculation.getKingdomAttrList()))
	FightValueCalculation.addAttr(var_29_0, (FightValueCalculation.getAllKnightBookAttrList()))
	FightValueCalculation.addAttr(var_29_0, (FightValueCalculation.getKnightFavorTotalLevelAttrList()))
	FightValueCalculation.addAttr(var_29_0, (FightValueCalculation.getArtifactBookAttrList()))
	FightValueCalculation.addAttr(var_29_0, (FightValueCalculation.getPetBookAttrList()))
	FightValueCalculation.addAttr(var_29_0, (FightValueCalculation.getEchoLabAttrList()))
	FightValueCalculation.addAttr(var_29_0, (FightValueCalculation.getKnightSoulAttrList()))

	return var_29_0
end

function MulFormationStruct:refreshFixedAttr()
	if self._fightValue > 0 then
		return
	end

	self._otherFixedAttrDict = self:_getOtherFixedAttr()

	local var_30_0 = {}

	for iter_30_0 = 1, var_0_0.LINEUP_MAX do
		var_30_0[iter_30_0] = self:_getEquipmentTreasureAttrByPos(iter_30_0)
	end

	self._posKeyEquipmentTreasureAttrDict = var_30_0

	self:_updatePetAttr()
	self:_updateUniteTokenAttr()
end

function MulFormationStruct:_getEquipmentTreasureAttrByPos(arg_31_1)
	local var_31_0 = {}

	FightValueCalculation.addAttr(var_31_0, (FightValueCalculation.getEquipmentAttrListByPos(arg_31_1)))
	FightValueCalculation.addAttr(var_31_0, (FightValueCalculation.getTreasureAttrListByPos(arg_31_1)))

	return var_31_0
end

function MulFormationStruct:getUndressedMaxQualityRelatedArtifactByKnight(arg_32_1)
	local var_32_0 = var_0_2:getRelatedArtifactArrByKnight(arg_32_1)

	for iter_32_0 = 1, #var_32_0 do
		if not g.core.model.User.mulFormationData:isArtifactLineup(self._type, (var_32_0[iter_32_0]:getServerOnlyId())) then
			return var_32_0[iter_32_0]
		end
	end
end

function MulFormationStruct:replaceAllKnights(arg_33_1)
	for iter_33_0 = 1, var_0_0.LINEUP_MAX do
		self._knightPosArr[iter_33_0] = iter_33_0
		self._knightSidArr[iter_33_0] = self:_getValueDefault_0(arg_33_1, iter_33_0)
	end

	for iter_33_1 = 1, var_0_0.LINEUP_MAX do
		if self:isStationPosLineupKnight(iter_33_1) then
			if not self:isStationPosLineupArtifact(iter_33_1) then
				self:lineupRelatedArtifact(iter_33_1)
			elseif not var_0_2:getArtifactBySid((self:getArtifactSid(iter_33_1))):checkWearKnight(var_0_1:getKnight({
				id = self:getKnightSid(iter_33_1)
			}):getAdvanceId()) then
				self:lineupArtifact(iter_33_1, 0)
			end
		elseif not self:isStationPosLineupArtifact(iter_33_1) then
			self:lineupArtifact(iter_33_1, 0)
		end
	end
end

function MulFormationStruct:isPetLineUp(arg_34_1)
	if not self._advanceIdCheckEnable then
		return MulFormationStruct.super.isPetLineUp(self, arg_34_1)
	end

	local var_34_0 = g.core.model.User.mulFormationData:getPetBySid(self._type, arg_34_1)

	if not var_34_0 then
		return false
	end

	return self:isPetLineUpByAdvanceId(var_34_0:getCfg().advance_id)
end

function MulFormationStruct:isPetLineUpByAdvanceId(arg_35_1)
	for iter_35_0, iter_35_1 in pairs(self:getPetDict()) do
		if iter_35_1:getCfg().advance_id == arg_35_1 then
			return true
		end
	end

	return false
end

function MulFormationStruct:getPetStationPos(arg_36_1)
	if not self._advanceIdCheckEnable then
		return MulFormationStruct.super.getPetStationPos(self, arg_36_1)
	end

	local var_36_0 = g.core.model.User.mulFormationData:getPetBySid(self._type, arg_36_1)

	if not var_36_0 then
		return MulFormationStruct.super.getPetStationPos(self, arg_36_1)
	end

	return self:getPetStationPosByAdvanceId(var_36_0:getCfg().advance_id, arg_36_1)
end

function MulFormationStruct:getPetStationPosByAdvanceId(arg_37_1, arg_37_2)
	for iter_37_0, iter_37_1 in pairs(self:getPetDict()) do
		if iter_37_1:getCfg().advance_id == arg_37_1 then
			return iter_37_0, iter_37_1:getSid()
		end
	end

	return self:_getKeyDefault_0(self._petSidArr, arg_37_2), 0
end

function MulFormationStruct:getPetDict()
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs(self._petSidArr) do
		if self:isSidValid(iter_38_1) then
			local var_38_1 = g.core.model.User.mulFormationData:getPetBySid(self._type, iter_38_1)

			if var_38_1 then
				var_38_0[iter_38_0] = var_38_1
			end
		end
	end

	return var_38_0
end

function MulFormationStruct:isUniteTokenLineUp(arg_39_1)
	if not self._advanceIdCheckEnable then
		return MulFormationStruct.super.isUniteTokenLineUp(self, arg_39_1)
	end

	local var_39_0 = g.core.model.User.mulFormationData:getUniteTokenBySid(self._type, arg_39_1)

	if not var_39_0 then
		return false
	end

	for iter_39_0, iter_39_1 in pairs(self:getUniteTokenDict()) do
		if iter_39_1:getAdvanceId() == var_39_0:getAdvanceId() then
			return true
		end
	end

	return false
end

function MulFormationStruct:getUniteTokenStationPos(arg_40_1)
	if not self._advanceIdCheckEnable then
		return MulFormationStruct.super.getUniteTokenStationPos(self, arg_40_1)
	end

	local var_40_0 = g.core.model.User.mulFormationData:getUniteTokenBySid(self._type, arg_40_1)

	if not var_40_0 or not var_40_0:isOwn() then
		return MulFormationStruct.super.getUniteTokenStationPos(self, arg_40_1)
	end

	for iter_40_0, iter_40_1 in pairs(self:getUniteTokenDict()) do
		if iter_40_1:getAdvanceId() == var_40_0:getAdvanceId() then
			return iter_40_0, iter_40_1:getServerId()
		end
	end

	return self:_getKeyDefault_0(self._uniteTokenSidArr, arg_40_1), 0
end

function MulFormationStruct:getUniteTokenDict()
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in pairs(self._uniteTokenSidArr) do
		if self:isSidValid(iter_41_1) then
			local var_41_1 = g.core.model.User.mulFormationData:getUniteTokenBySid(self._type, iter_41_1)

			if var_41_1 then
				var_41_0[iter_41_0] = var_41_1
			end
		end
	end

	return var_41_0
end

return MulFormationStruct
