local TeamBattleFormationStruct = class("TeamBattleFormationStruct", require("app.view.module.lineUp.model.FormationStruct"))

function TeamBattleFormationStruct:ctor(arg_1_1, arg_1_2)
	self.super.ctor(self)

	self._type = arg_1_1
	self._index = arg_1_2
end

function TeamBattleFormationStruct:setSvrData(arg_2_1, arg_2_2)
	if arg_2_2 then
		arg_2_1 = arg_2_1 or {}

		local var_2_0 = g.core.model.User.teamBattleData:getFormationData()

		self._svrData = arg_2_1
		self._type = arg_2_1.tp or self._type
		self._index = arg_2_1.seq or self._index
		self._uniqueId = arg_2_1.unique_id or 0

		local var_2_1 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.position or {}) do
			if self:isPositionValid(iter_2_1) then
				var_2_1[iter_2_1] = iter_2_0
			end
		end

		local var_2_2 = arg_2_1.knight_id or {}
		local var_2_3 = arg_2_1.artifact_id or {}

		for iter_2_2 in ipairs(self._knightSidArr) do
			local var_2_4 = self:_getValueDefault_0(var_2_1, iter_2_2)
			local var_2_5 = self:_getValueDefault_0(var_2_2, var_2_4)

			if var_2_0:getKnightByServerId(var_2_5) then
				self._knightSidArr[iter_2_2] = var_2_5
				self._artifactSidArr[iter_2_2] = self:_getValueDefault_0(var_2_3, var_2_4)
			else
				self._knightSidArr[iter_2_2] = 0
				self._artifactSidArr[iter_2_2] = 0
			end
		end

		local var_2_6 = arg_2_1.unite_token_id or {}

		for iter_2_3 in ipairs(self._uniteTokenSidArr) do
			self._uniteTokenSidArr[iter_2_3] = self:_getValueDefault_0(var_2_6, iter_2_3)
		end

		local var_2_7 = arg_2_1.pet_id or {}

		for iter_2_4 in ipairs(self._petSidArr) do
			self._petSidArr[iter_2_4] = self:_getValueDefault_0(var_2_7, iter_2_4)
		end

		local var_2_8 = arg_2_1.precious_suits or {}

		for iter_2_5 in ipairs(self._preciousSuitSidArr) do
			self._preciousSuitSidArr[iter_2_5] = self:_getValueDefault_0(var_2_8, iter_2_5)
		end

		if arg_2_1.fight_value then
			self._fightValue = arg_2_1.fight_value
		end
	else
		self.super.setSvrData(self, arg_2_1)
	end
end

function TeamBattleFormationStruct:_changeStationPos(arg_3_1, arg_3_2, arg_3_3)
	arg_3_3 = arg_3_3 or 0

	local var_3_0 = self:_getKeyDefault_0(arg_3_1, arg_3_3)

	if self:isPositionValid(var_3_0) then
		arg_3_1[var_3_0] = arg_3_1[arg_3_2]
	end

	arg_3_1[arg_3_2] = var_3_0 == arg_3_2 and 0 or arg_3_3
end

function TeamBattleFormationStruct:lineupKnight(arg_4_1, arg_4_2)
	arg_4_2 = arg_4_2 or 0

	if self:isSidValid(arg_4_2) then
		if self:isKnightLineUp(arg_4_2) then
			local var_4_0, var_4_1 = self:getKnightStationPos(arg_4_2)

			self.super.lineupKnight(self, arg_4_1, var_4_1)

			if self:isStationPosLineupArtifact(var_4_0) then
				self:lineupArtifact(arg_4_1, (self:getArtifactSid(var_4_0)))
			elseif self:isStationPosLineupArtifact(arg_4_1) then
				self:lineupArtifact(var_4_0, (self:getArtifactSid(arg_4_1)))
			end
		else
			self.super.lineupKnight(self, arg_4_1, arg_4_2)

			if self:isStationPosLineupArtifact(arg_4_1) then
				local var_4_2 = self:getArtifactSid(arg_4_1)

				if not g.core.model.User.teamBattleData:getFormationData():getArtifactByServerId(var_4_2):checkWearKnight(g.core.model.User.teamBattleData:getFormationData():getKnightByServerId(arg_4_2):getAdvanceId()) then
					self:takeOffArtifact(var_4_2)
				end
			end
		end
	else
		self.super.lineupKnight(self, arg_4_1, arg_4_2)
		self:lineupArtifact(arg_4_1, 0)
	end
end

function TeamBattleFormationStruct:getKnightStationPos(arg_5_1)
	local var_5_0 = g.core.model.User.teamBattleData:getFormationData():getKnightByServerId(arg_5_1)

	if not var_5_0 then
		return 0, 0
	end

	for iter_5_0, iter_5_1 in pairs(self:getKnightDict()) do
		if iter_5_1:getAdvanceId() == var_5_0:getAdvanceId() then
			return iter_5_0, iter_5_1:getServerId()
		end
	end

	return self:_getKeyDefault_0(self._knightSidArr, arg_5_1), 0
end

function TeamBattleFormationStruct:getArtifactStationPos(arg_6_1)
	local var_6_0 = g.core.model.User.teamBattleData:getFormationData():getArtifactByServerId(arg_6_1)

	if not var_6_0 then
		return 0, 0
	end

	for iter_6_0, iter_6_1 in pairs(self:getArtifactDict()) do
		if iter_6_1:getAdvanceId() == var_6_0:getAdvanceId() then
			return iter_6_0, iter_6_1:getServerOnlyId()
		end
	end

	return self:_getKeyDefault_0(self._artifactSidArr, arg_6_1), 0
end

function TeamBattleFormationStruct:getUniteTokenStationPos(arg_7_1)
	local var_7_0 = g.core.model.User.teamBattleData:getFormationData():getUniteTokenByServerId(arg_7_1)

	if not var_7_0 then
		return 0, 0
	end

	for iter_7_0, iter_7_1 in pairs(self:getUniteTokenDict()) do
		if iter_7_1:getAdvanceId() == var_7_0:getAdvanceId() then
			return iter_7_0, iter_7_1:getAdvanceId()
		end
	end

	return self:_getKeyDefault_0(self._artifactSidArr, arg_7_1), 0
end

function TeamBattleFormationStruct:getPetStationPos(arg_8_1)
	local var_8_0 = g.core.model.User.teamBattleData:getFormationData():getPetByServerId(arg_8_1)

	if not var_8_0 then
		return 0, 0
	end

	for iter_8_0, iter_8_1 in pairs(self:getPetDict()) do
		if iter_8_1:getAdvanceId() == var_8_0:getAdvanceId() then
			return iter_8_0, iter_8_1:getSid()
		end
	end

	return self:_getKeyDefault_0(self._petSidArr, arg_8_1), 0
end

function TeamBattleFormationStruct:getKnightDict()
	local var_9_0 = g.core.model.User.teamBattleData:getFormationData()
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(self._knightSidArr) do
		if self:isSidValid(iter_9_1) then
			local var_9_2 = var_9_0:getKnightByServerId(iter_9_1)

			if var_9_2 then
				var_9_1[iter_9_0] = var_9_2
			end
		end
	end

	return var_9_1
end

function TeamBattleFormationStruct:isKnightLineUp(arg_10_1)
	local var_10_0 = g.core.model.User.teamBattleData:getFormationData():getKnightByServerId(arg_10_1)

	if not var_10_0 then
		return false
	end

	for iter_10_0, iter_10_1 in pairs(self:getKnightDict()) do
		if iter_10_1:getAdvanceId() == var_10_0:getAdvanceId() then
			return true
		end
	end

	return false
end

function TeamBattleFormationStruct:getArtifactDict()
	local var_11_0 = g.core.model.User.teamBattleData:getFormationData()
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(self._artifactSidArr) do
		if self:isSidValid(iter_11_1) then
			local var_11_2 = var_11_0:getArtifactByServerId(iter_11_1)

			if var_11_2 then
				var_11_1[iter_11_0] = var_11_2
			end
		end
	end

	return var_11_1
end

function TeamBattleFormationStruct:isArtifactLineUp(arg_12_1)
	local var_12_0 = g.core.model.User.teamBattleData:getFormationData():getArtifactByServerId(arg_12_1)

	if not var_12_0 then
		return false
	end

	for iter_12_0, iter_12_1 in pairs(self:getArtifactDict()) do
		if iter_12_1:getAdvanceId() == var_12_0:getAdvanceId() then
			return true
		end
	end

	return false
end

function TeamBattleFormationStruct:getPetDict()
	local var_13_0 = g.core.model.User.teamBattleData:getFormationData()
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(self._petSidArr) do
		if self:isSidValid(iter_13_1) then
			local var_13_2 = var_13_0:getPetByServerId(iter_13_1)

			if var_13_2 then
				var_13_1[iter_13_0] = var_13_2
			end
		end
	end

	return var_13_1
end

function TeamBattleFormationStruct:isPetLineUp(arg_14_1)
	local var_14_0 = g.core.model.User.teamBattleData:getFormationData():getPetByServerId(arg_14_1)

	if not var_14_0 then
		return false
	end

	for iter_14_0, iter_14_1 in pairs(self:getPetDict()) do
		if iter_14_1:getAdvanceId() == var_14_0:getAdvanceId() then
			return true
		end
	end

	return false
end

function TeamBattleFormationStruct:getUniteTokenDict()
	local var_15_0 = g.core.model.User.teamBattleData:getFormationData()
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in pairs(self._uniteTokenSidArr) do
		if self:isSidValid(iter_15_1) then
			local var_15_2 = var_15_0:getUniteTokenByServerId(iter_15_1)

			if var_15_2 then
				var_15_1[iter_15_0] = var_15_2
			end
		end
	end

	return var_15_1
end

function TeamBattleFormationStruct:isUniteTokenLineUp(arg_16_1)
	local var_16_0 = g.core.model.User.teamBattleData:getFormationData():getUniteTokenByServerId(arg_16_1)

	if not var_16_0 then
		return false
	end

	for iter_16_0, iter_16_1 in pairs(self:getUniteTokenDict()) do
		if iter_16_1:getAdvanceId() == var_16_0:getAdvanceId() then
			return true
		end
	end

	return false
end

function TeamBattleFormationStruct:isUsingKnight(arg_17_1)
	return self:isPositionValid((self.super.getKnightStationPos(self, arg_17_1)))
end

function TeamBattleFormationStruct:isUsingArtifact(arg_18_1)
	return self:isPositionValid((self.super.getArtifactStationPos(self, arg_18_1)))
end

function TeamBattleFormationStruct:isUsingPet(arg_19_1)
	return self:isPositionValid((self.super.getPetStationPos(self, arg_19_1)))
end

function TeamBattleFormationStruct:isUsingUniteToken(arg_20_1)
	return self:isPositionValid((self.super.getUniteTokenStationPos(self, arg_20_1)))
end

return TeamBattleFormationStruct
