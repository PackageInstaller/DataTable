local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local GveFormationStruct = class("GveFormationStruct", import(".FormationStruct"))

function GveFormationStruct:ctor(arg_1_1, arg_1_2)
	self.super.ctor(self)

	self._type = arg_1_1
	self._index = arg_1_2
end

function GveFormationStruct:setSvrData(arg_2_1, arg_2_2)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = g.core.model.User.gveDataMgr:getGveFormationData()

	self._svrData = arg_2_1
	self._type = arg_2_1.tp or self._type
	self._index = arg_2_1.seq or self._index
	self._uniqueId = arg_2_1.unique_id or 0

	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.position or {}) do
		if iter_2_0 > var_0_0.LINEUP_MAX then
			break
		end

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

	local var_2_9 = arg_2_1.succuba_id or {}

	for iter_2_6 in ipairs(self._succubaSidArr) do
		self._succubaSidArr[iter_2_6] = self:_getValueDefault_0(var_2_9, iter_2_6)
	end

	if arg_2_1.fight_value then
		self._fightValue = arg_2_1.fight_value
	end
end

function GveFormationStruct:_changeStationPos(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_3 = arg_3_3 or 0

	local var_3_0 = self:_getKeyDefault_0(arg_3_1, arg_3_3)

	if self:isPositionValid(var_3_0) then
		arg_3_1[var_3_0] = arg_3_1[arg_3_2]
	end

	arg_3_1[arg_3_2] = var_3_0 == arg_3_2 and not arg_3_4 and 0 or arg_3_3
end

function GveFormationStruct:lineupKnight(arg_4_1, arg_4_2, arg_4_3)
	self:_changeStationPos(self._knightSidArr, arg_4_1, arg_4_2, arg_4_3)
end

function GveFormationStruct:lineupArtifact(arg_5_1, arg_5_2, arg_5_3)
	self:_changeStationPos(self._artifactSidArr, arg_5_1, arg_5_2, arg_5_3)
end

function GveFormationStruct:lineupUniteToken(arg_6_1, arg_6_2, arg_6_3)
	self:_changeStationPos(self._uniteTokenSidArr, arg_6_1, arg_6_2, arg_6_3)
end

function GveFormationStruct:lineupPet(arg_7_1, arg_7_2, arg_7_3)
	self:_changeStationPos(self._petSidArr, arg_7_1, arg_7_2, arg_7_3)
end

function GveFormationStruct:lineupPreciousSuit(arg_8_1, arg_8_2, arg_8_3)
	self:_changeStationPos(self._preciousSuitSidArr, arg_8_1, arg_8_2, arg_8_3)
end

function GveFormationStruct:lineupSuccuba(arg_9_1, arg_9_2, arg_9_3)
	self:_changeStationPos(self._succubaSidArr, arg_9_1, arg_9_2, arg_9_3)
end

function GveFormationStruct:getKnightDict()
	local var_10_0 = g.core.model.User.gveDataMgr:getGveFormationData()
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(self._knightSidArr) do
		if self:isSidValid(iter_10_1) then
			local var_10_2 = var_10_0:getKnightByServerId(iter_10_1)

			if var_10_2 then
				var_10_1[iter_10_0] = var_10_2
			end
		end
	end

	return var_10_1
end

return GveFormationStruct
