local var_0_0 = g.core.config.knight_association_info
local Struct = require("app.core.common.Struct")
local var_0_2 = g.core.const.ConstMgr.PetConst
local var_0_3 = g.core.const.ConstMgr.UniteTokenConst
local var_0_4 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_5 = g.core.const.ConstMgr.FormationConst
local var_0_6 = g.core.const.ConstMgr.PreciousConst
local var_0_7 = g.core.const.ConstMgr.SuccubaConst
local var_0_8 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_9 = g.core.model.User.knightsData
local var_0_10 = g.core.model.User.preciousData
local var_0_11 = g.core.model.User.succubaData
local var_0_12 = g.core.model.User.uniteTokenData
local PreciousSuitStruct = require("app.view.module.precious.model.PreciousSuitStruct")
local SuccubaStruct = require("app.view.module.succuba.model.SuccubaStruct")
local FormationPreStruct = class("FormationPreStruct", require("app.view.module.lineUp.model.FormationStruct"))

function FormationPreStruct:ctor(arg_1_1, arg_1_2)
	FormationPreStruct.super.ctor(self)

	self._formationName = ""
	self._serverData = {}
	self._partnerSidDict = {}
	self._index = arg_1_1 or 0
	self._uniqueId = arg_1_2 or 0
end

function FormationPreStruct:setSvrData(arg_2_1)
	self._serverData = arg_2_1
	self._uniqueId = arg_2_1.id or self._uniqueId

	if arg_2_1.name and arg_2_1.name ~= "" then
		self._formationName = arg_2_1.name
	end

	local var_2_0 = arg_2_1.knight_id or {}
	local var_2_1 = arg_2_1.artifact_id or {}

	for iter_2_0 = 1, var_0_4.LINEUP_MAX do
		self._knightSidArr[iter_2_0] = self:_getValueDefault_0(var_2_0, iter_2_0)
		self._artifactSidArr[iter_2_0] = self:_getValueDefault_0(var_2_1, iter_2_0)
	end

	local var_2_2 = arg_2_1.unite_token_id or {}

	for iter_2_1 in ipairs(self._uniteTokenSidArr) do
		self._uniteTokenSidArr[iter_2_1] = self:_getValueDefault_0(var_2_2, iter_2_1)
	end

	local var_2_3 = arg_2_1.pet_id or {}

	for iter_2_2 in ipairs(self._petSidArr) do
		self._petSidArr[iter_2_2] = self:_getValueDefault_0(var_2_3, iter_2_2)
	end

	local var_2_4 = arg_2_1.precious_suits or {}

	for iter_2_3 = 1, var_0_6.LINEUP_MAX do
		self._preciousSuitSidArr[iter_2_3] = self:_getValueDefault_0(var_2_4, iter_2_3)
	end

	local var_2_5 = arg_2_1.succuba_id or {}

	for iter_2_4 = 1, var_0_7.FORMAT_SUCCUBA_NUM_MAX do
		self._succubaSidArr[iter_2_4] = self:_getValueDefault_0(var_2_5, iter_2_4)
	end

	for iter_2_5 = 1, var_0_4.SHOW_PARTNER_NUM do
		self._partnerSidDict[iter_2_5] = self:_getValueDefault_0(var_2_0, iter_2_5 + var_0_4.LINEUP_MAX)
	end
end

function FormationPreStruct:resetSvrData()
	self:setSvrData(self:getServerData())
end

function FormationPreStruct:toOutBaseFormation()
	local var_4_0 = self:_dictToArr(self._knightSidArr, var_0_4.LINEUP_MAX)

	for iter_4_0 = 1, var_0_4.SHOW_PARTNER_NUM do
		table.insert(var_4_0, self:_getValueDefault_0(self._partnerSidDict, iter_4_0))
	end

	return {
		id = self:getFormationUniqueId(),
		knight_id = var_4_0,
		unite_token_id = self:_dictToArr(self._uniteTokenSidArr, var_0_3.FORMAT_UNITE_NUM_MAX),
		artifact_id = self:_dictToArr(self._artifactSidArr, var_0_4.LINEUP_MAX),
		pet_id = self:_dictToArr(self._petSidArr, var_0_2.SERVER_LINEUP_MAX),
		precious_suits = self:_dictToArr(self._preciousSuitSidArr, var_0_6.LINEUP_MAX),
		succuba_id = self:_dictToArr(self._succubaSidArr, var_0_7.FORMAT_SUCCUBA_NUM_MAX),
		pet_equipment_id = {},
		name = self._formationName
	}
end

function FormationPreStruct:_dictToArr(arg_5_1, arg_5_2)
	local var_5_0 = {}

	for iter_5_0 = 1, arg_5_2 do
		var_5_0[iter_5_0] = self:_getValueDefault_0(arg_5_1, iter_5_0)
	end

	return var_5_0
end

function FormationPreStruct:setName(arg_6_1)
	self._formationName = arg_6_1
end

function FormationPreStruct:_getKnightAssCountByList(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		local var_7_3 = iter_7_1:getBaseInfo()

		for iter_7_2 = 1, var_0_4.ASSCT_MAX do
			if var_7_3["association_" .. iter_7_2] > 0 then
				var_7_1 = var_7_1 + 1

				local var_7_4 = var_0_0.get(var_7_3["association_" .. iter_7_2])
				local var_7_5 = true

				for iter_7_3 = 1, var_0_4.ASS_COND_MAX do
					if var_7_4.type == 1 and var_7_4["value_" .. iter_7_3] > 0 then
						if not arg_7_2[var_7_4["value_" .. iter_7_3]] and not arg_7_3[var_7_4["value_" .. iter_7_3]] then
							var_7_5 = false
						end
					end
				end

				if var_7_5 then
					var_7_0 = var_7_0 + 1

					table.insert(var_7_2, {
						isActive = true,
						assId = var_7_3["association_" .. iter_7_2],
						knightId = var_7_3.id
					})
				end
			end
		end
	end

	return var_7_0, var_7_1, var_7_2
end

function FormationPreStruct:lineupKnight(arg_8_1, arg_8_2)
	if self:isPartnerLineUp(arg_8_2) then
		self:_changeStationPos(self._partnerSidDict, self:getPartnerStationPos(arg_8_2), (self:getKnightSid(arg_8_1)))
	end

	self:_changeStationPos(self._knightSidArr, arg_8_1, arg_8_2)
end

function FormationPreStruct:lineupPartner(arg_9_1, arg_9_2)
	if self:isKnightLineUp(arg_9_2) then
		self:_changeStationPos(self._knightSidArr, self:getKnightStationPos(arg_9_2), (self:getPartnerSid(arg_9_1)))
	end

	self:_changeStationPos(self._partnerSidDict, arg_9_1, arg_9_2)
end

function FormationPreStruct:_changeStationPos(arg_10_1, arg_10_2, arg_10_3)
	arg_10_3 = arg_10_3 or 0

	local var_10_0 = self:_getKeyDefault_0(arg_10_1, arg_10_3)

	if self:isPositionValid(var_10_0) then
		arg_10_1[var_10_0] = arg_10_1[arg_10_2]
	end

	arg_10_1[arg_10_2] = var_10_0 == arg_10_2 and 0 or arg_10_3
end

function FormationPreStruct:loadFormationWithFightFormation(arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1.position) do
		self._knightSidArr[iter_11_1] = arg_11_1.knight_id[iter_11_0]
		self._artifactSidArr[iter_11_1] = arg_11_1.artifact_id[iter_11_0]
	end

	self._uniteTokenSidArr = arg_11_1.unite_token_id
	self._petSidArr = arg_11_1.pet_id
	self._preciousSuitSidArr = arg_11_1.precious_suits
	self._succubaSidArr = arg_11_1.succuba_id
end

function FormationPreStruct:formationKnight(arg_12_1, arg_12_2)
	if self:isPartnerLineUp(arg_12_2) then
		self._partnerSidDict[self:getPartnerStationPos(arg_12_2)] = self:getKnightSid(arg_12_1)
	end

	self._knightSidArr[arg_12_1] = arg_12_2
end

function FormationPreStruct:formationArtifact(arg_13_1, arg_13_2)
	self._artifactSidArr[arg_13_1] = arg_13_2
end

function FormationPreStruct:isPartnerLineUp(arg_14_1)
	return self:isPositionValid((self:getPartnerStationPos(arg_14_1)))
end

function FormationPreStruct:isChangeFormation()
	local function var_15_0(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		arg_16_0 = arg_16_0 or {}
		arg_16_1 = arg_16_1 or {}
		arg_16_3 = arg_16_3 or 0
		arg_16_2 = arg_16_2 or 0

		for iter_16_0 = 1, arg_16_2 do
			if self:_getValueDefault_0(arg_16_0, iter_16_0 + arg_16_3) ~= self:_getValueDefault_0(arg_16_1, iter_16_0) then
				return true
			end
		end
	end

	return var_15_0(self._serverData.knight_id, self._knightSidArr, var_0_4.LINEUP_MAX) or var_15_0(self._serverData.unite_token_id, self._uniteTokenSidArr, var_0_3.FORMAT_UNITE_NUM_MAX) or var_15_0(self._serverData.pet_id, self._petSidArr, var_0_2.LINEUP_MAX) or var_15_0(self._serverData.knight_id, self._partnerSidDict, var_0_4.SHOW_PARTNER_NUM, var_0_4.LINEUP_MAX) or var_15_0(self._serverData.precious_suits, self._preciousSuitSidArr, var_0_6.LINEUP_MAX) or var_15_0(self._serverData.succuba_id, self._succubaSidArr, var_0_7.FORMAT_SUCCUBA_NUM_MAX)
end

function FormationPreStruct:getFormationName()
	if self._formationName and self._formationName ~= "" then
		return self._formationName
	end

	return g.core.lang:get(200018, {
		index = self._index
	})
end

function FormationPreStruct:getPartnerSid(arg_18_1)
	return self:_getValueDefault_0(self._partnerSidDict, arg_18_1)
end

function FormationPreStruct:getPartnerStationPos(arg_19_1)
	return self:_getKeyDefault_0(self._partnerSidDict, arg_19_1)
end

function FormationPreStruct:getAutoLineupArtifact()
	local var_20_0 = {}
	local var_20_1 = {}
	local var_20_2 = self:getKnightDict()

	for iter_20_0 = 1, var_0_4.LINEUP_MAX do
		if var_20_2[iter_20_0] then
			var_20_1[var_20_2[iter_20_0]:getAdvanceId()] = iter_20_0
		end
	end

	local var_20_3 = {}
	local var_20_4 = {}

	for iter_20_1, iter_20_2 in pairs((g.core.model.User.artifactData:getAllArtifactList())) do
		if iter_20_2:isOwn() then
			local var_20_5 = var_20_1[iter_20_2:getBelongToKnightAvdIdIncludingMainRole()]

			if var_20_5 then
				if var_20_4[var_20_5] then
					if var_20_4[var_20_5]:isDemo() then
						var_20_0[var_20_5] = iter_20_2:getServerOnlyId()
						var_20_4[var_20_5] = iter_20_2

						table.insert(var_20_3, var_20_4[var_20_5])
					else
						table.insert(var_20_3, iter_20_2)
					end
				else
					var_20_0[var_20_5] = iter_20_2:getServerOnlyId()
					var_20_4[var_20_5] = iter_20_2
				end
			else
				table.insert(var_20_3, iter_20_2)
			end
		end
	end

	if table.nums(var_20_1) == var_0_4.LINEUP_MAX and table.nums(var_20_1) == table.nums(var_20_0) then
		return var_20_0
	end

	table.sort(var_20_3, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_21_0:getQuality()
		local var_21_1 = arg_21_1:getQuality()

		if var_21_0 ~= var_21_1 then
			return var_21_1 < var_21_0
		end

		local var_21_2 = arg_21_0:getStar()
		local var_21_3 = arg_21_1:getStar()

		if var_21_2 ~= var_21_3 then
			return var_21_3 < var_21_2
		end

		local var_21_4 = arg_21_0:getLevel()
		local var_21_5 = arg_21_1:getLevel()

		if var_21_4 ~= var_21_5 then
			return var_21_5 < var_21_4
		end

		return arg_21_0:getArtifactBaseId() > arg_21_1:getArtifactBaseId()
	end)

	for iter_20_3 = 1, var_0_4.LINEUP_MAX do
		if #var_20_3 > 0 and self:getKnightSid(iter_20_3) > 0 then
			if not var_20_0[iter_20_3] or var_20_0[iter_20_3] == 0 then
				local var_20_6 = var_20_2[iter_20_3]

				for iter_20_4, iter_20_5 in ipairs(var_20_3) do
					if iter_20_5:checkWearKnight(var_20_6:getAdvanceId()) then
						var_20_0[iter_20_3] = iter_20_5:getServerOnlyId()

						table.remove(var_20_3, iter_20_4)

						break
					end
				end
			end

			var_20_0[iter_20_3] = var_20_0[iter_20_3] or 0
		else
			var_20_0[iter_20_3] = var_20_0[iter_20_3] or 0
		end
	end

	return var_20_0
end

function FormationPreStruct:getServerData()
	return clone(self._serverData)
end

function FormationPreStruct:getKnightIds()
	return (self:_dictToArr(self:getKnightSidArr(), var_0_4.LINEUP_MAX))
end

function FormationPreStruct:getFormationIndex()
	return self._index
end

function FormationPreStruct:isFormationFightEnable()
	for iter_25_0 = 1, var_0_4.LINEUP_MAX do
		if self:getKnightSid(iter_25_0) == 0 then
			return var_0_5.USE_CONDITION_STATE.KNIGHT
		end
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(var_0_8.PET) then
		local var_25_0 = 0

		for iter_25_1 = 1, var_0_2.LINEUP_MAX do
			if self:getPetSid(iter_25_1) > 0 then
				var_25_0 = var_25_0 + 1
			end
		end

		if var_25_0 < g.core.model.User.petsData:getLineupNum() then
			return var_0_5.USE_CONDITION_STATE.PET
		end
	end

	return var_0_5.USE_CONDITION_STATE.NONE
end

function FormationPreStruct:isValidName()
	return self._formationName ~= ""
end

function FormationPreStruct:getAllAssCount()
	local var_27_0 = {}
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in pairs(self._partnerSidDict) do
		if iter_27_1 > 0 then
			local var_27_2 = g.core.model.User.knightsData:getKnight({
				id = iter_27_1
			})

			var_27_0[iter_27_0] = var_27_2
			var_27_1[var_27_2:getAdvanceId()] = var_27_2
		end
	end

	local var_27_3 = {}
	local var_27_4 = {}

	for iter_27_2, iter_27_3 in pairs(self._knightSidArr) do
		if iter_27_3 > 0 then
			local var_27_5 = var_0_9:getKnight({
				id = iter_27_3
			})

			var_27_3[iter_27_2] = var_27_5
			var_27_4[var_27_5:getAdvanceId()] = var_27_5
		end
	end

	return self:_getKnightAssCountByList(var_27_3, var_27_4, var_27_1)
end

function FormationPreStruct:getKnightAssCount(arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = 0
	local var_28_1 = 0
	local var_28_2 = 0
	local var_28_3 = {}
	local var_28_4 = {}

	for iter_28_0, iter_28_1 in pairs(self._partnerSidDict) do
		if iter_28_1 > 0 and (arg_28_2 ~= iter_28_0 or arg_28_3) then
			local var_28_5 = g.core.model.User.knightsData:getKnight({
				id = iter_28_1
			})

			var_28_3[iter_28_0] = var_28_5
			var_28_4[var_28_5:getAdvanceId()] = var_28_5
		end
	end

	if not arg_28_3 and arg_28_2 > 0 then
		local var_28_6 = g.core.model.User.knightsData:getKnight({
			id = arg_28_1
		})

		var_28_3[arg_28_2] = var_28_6
		var_28_4[var_28_6:getAdvanceId()] = var_28_6
	end

	local var_28_7 = {}
	local var_28_8 = {}

	for iter_28_2, iter_28_3 in pairs(self._knightSidArr) do
		if iter_28_3 > 0 and (arg_28_2 ~= iter_28_2 or not arg_28_3) then
			local var_28_9 = var_0_9:getKnight({
				id = iter_28_3
			})

			var_28_7[iter_28_2] = var_28_9
			var_28_8[var_28_9:getAdvanceId()] = var_28_9
		end
	end

	if arg_28_3 and arg_28_2 > 0 then
		local var_28_10 = g.core.model.User.knightsData:getKnight({
			id = arg_28_1
		})

		var_28_7[arg_28_2] = var_28_10
		var_28_8[var_28_10:getAdvanceId()] = var_28_10
	end

	local var_28_11 = var_0_9:getKnight({
		id = arg_28_1
	}):getBaseInfo()

	for iter_28_4, iter_28_5 in pairs(var_28_7) do
		local var_28_12 = iter_28_5:getBaseInfo()

		for iter_28_6 = 1, var_0_4.ASSCT_MAX do
			if var_28_12["association_" .. iter_28_6] > 0 then
				local var_28_13 = var_0_0.get(var_28_12["association_" .. iter_28_6])
				local var_28_14 = false
				local var_28_15 = true

				for iter_28_7 = 1, var_0_4.ASS_COND_MAX do
					if var_28_13.type == 1 and var_28_13["value_" .. iter_28_7] > 0 then
						if not var_28_8[var_28_13["value_" .. iter_28_7]] and not var_28_4[var_28_13["value_" .. iter_28_7]] then
							var_28_15 = false
						end

						if var_28_13["value_" .. iter_28_7] == var_28_11.advance_id then
							var_28_14 = true
						end
					end
				end

				if var_28_15 and (iter_28_5:getAdvanceId() == var_28_11.advance_id or var_28_14) then
					var_28_0 = var_28_0 + 1
				end
			end
		end
	end

	if arg_28_4 then
		var_28_1 = 0

		for iter_28_8 = 1, var_0_4.ASSCT_MAX do
			if var_28_11["association_" .. iter_28_8] > 0 then
				var_28_1 = var_28_1 + 1

				if arg_28_3 then
					local var_28_16 = var_0_0.get(var_28_11["association_" .. iter_28_8])
					local var_28_17 = true

					for iter_28_9 = 1, var_0_4.ASS_COND_MAX do
						if var_28_16.type == 1 and var_28_16["value_" .. iter_28_9] > 0 then
							if not var_28_8[var_28_16["value_" .. iter_28_9]] and not var_28_4[var_28_16["value_" .. iter_28_9]] then
								var_28_17 = false
							end
						end
					end

					if var_28_17 then
						var_28_2 = var_28_2 + 1
					end
				end
			end
		end
	end

	return var_28_0, var_28_2, var_28_1
end

function FormationPreStruct:toStringFormation()
	local var_29_0 = {}

	for iter_29_0 = 1, var_0_4.LINEUP_MAX do
		local var_29_1 = self:getKnightSid(iter_29_0)

		if var_29_1 > 0 then
			table.insert(var_29_0, var_0_9:getKnight({
				id = var_29_1
			}):getInfo())
		else
			table.insert(var_29_0, {})
		end
	end

	local var_29_2 = {}

	for iter_29_1 = 1, var_0_3.FORMAT_UNITE_NUM_MAX do
		local var_29_3 = self:getUniteTokenSid(iter_29_1)

		if var_29_3 > 0 then
			local var_29_4 = var_0_12:getTokenByAdvId(var_29_3)

			table.insert(var_29_2, {
				base_id = var_29_4:getBaseId(),
				level = var_29_4:getLevel()
			})
		else
			table.insert(var_29_2, {})
		end
	end

	local var_29_5 = {}

	for iter_29_2 = 1, var_0_2.LINEUP_MAX do
		local var_29_6 = self:getPetSid(iter_29_2)

		if var_29_6 > 0 then
			table.insert(var_29_5, g.core.model.User.petsData:getPetBySid(var_29_6):getServerData())
		else
			table.insert(var_29_5, {})
		end
	end

	local var_29_7 = {}

	for iter_29_3 = 1, var_0_4.SHOW_PARTNER_NUM do
		local var_29_8 = self:getPartnerSid(iter_29_3)

		if var_29_8 > 0 then
			table.insert(var_29_7, var_0_9:getKnight({
				id = var_29_8
			}):getInfo())
		else
			table.insert(var_29_7, {})
		end
	end

	local var_29_9 = {}

	for iter_29_4 = 1, var_0_6.LINEUP_MAX do
		local var_29_10 = self:getPreciousSuitSid(iter_29_4)

		if var_29_10 > 0 then
			table.insert(var_29_9, var_0_10:getSuitByGroupId(var_29_10):getServerData())
		else
			table.insert(var_29_9, {})
		end
	end

	local var_29_11 = {}

	for iter_29_5 = 1, var_0_7.FORMAT_SUCCUBA_NUM_MAX do
		local var_29_12 = self:getPreciousSuitSid(iter_29_5)

		if var_29_12 > 0 then
			table.insert(var_29_11, var_0_11:getSuccubaBySid(var_29_12):getSvrInfo())
		else
			table.insert(var_29_11, {})
		end
	end

	local var_29_13 = json.encode({
		id = self._uniqueId,
		knight_data = var_29_0,
		unite_token_data = var_29_2,
		artifact_data = {},
		pet_data = var_29_5,
		pet_equipment_data = {},
		partner_data = var_29_7,
		precious_suits = var_29_9,
		succuba_id = var_29_11,
		name = self._formationName,
		userName = g.core.model.User:getName(),
		index = self._index
	})

	return Struct.pack("<is", string.len(var_29_13), var_29_13)
end

function FormationPreStruct:analysisStringFormation(arg_30_1)
	local var_30_0, var_30_1 = Struct.unpack("<is", arg_30_1)
	local var_30_2 = json.decode(var_30_1)

	self._index = var_30_2.index
	self._uniqueId = var_30_2.id
	self._formationName = var_30_2.name

	local var_30_3 = {}

	self._otherKnightStructDict = {}

	for iter_30_0, iter_30_1 in pairs(var_30_2.knight_data or {}) do
		if next(iter_30_1) then
			local var_30_4 = g.core.config.knight_info.get(iter_30_1.base_id)

			var_30_3[var_30_4.advance_id] = true

			local var_30_5 = require("app.view.module.knight.model.KnightStruct").new(var_30_4.advance_id)

			var_30_5:addCfgInfo(var_30_4)
			var_30_5:setInfo(iter_30_1)
			var_30_5:setIsOtherUser(true, var_30_2.userName)

			self._otherKnightStructDict[iter_30_0] = var_30_5
		end
	end

	self._otherUniteStructDict = {}

	for iter_30_2, iter_30_3 in pairs(var_30_2.unite_token_data or {}) do
		if next(iter_30_3) then
			local var_30_6 = require("app.view.module.uniteToken.model.UniteTokenStructData").new(iter_30_3.base_id)

			var_30_6:setLevel(iter_30_3.level)

			self._otherUniteStructDict[iter_30_2] = var_30_6
		end
	end

	self._otherPetStructDict = {}

	for iter_30_4, iter_30_5 in pairs(var_30_2.pet_data or {}) do
		if next(iter_30_5) then
			local var_30_7 = require("app.view.module.pet.model.PetStruct").new(g.core.config.pet_info.get(iter_30_5.base_id).advance_id)

			var_30_7:setServerData(iter_30_5)

			self._otherPetStructDict[iter_30_4] = var_30_7
		end
	end

	self._otherPartnerStructDict = {}

	for iter_30_6, iter_30_7 in pairs(var_30_2.partner_data or {}) do
		if next(iter_30_7) then
			local var_30_8 = g.core.config.knight_info.get(iter_30_7.base_id)

			var_30_3[var_30_8.advance_id] = true

			local var_30_9 = require("app.view.module.knight.model.KnightStruct").new(var_30_8.advance_id)

			var_30_9:addCfgInfo(var_30_8)
			var_30_9:setInfo(iter_30_7)
			var_30_9:setIsOtherUser(true, var_30_2.userName or "")

			self._otherPartnerStructDict[iter_30_6] = var_30_9
		end
	end

	self._otherPreciousSuitStructDict = {}

	for iter_30_8, iter_30_9 in pairs(var_30_2.precious_suits or {}) do
		if next(iter_30_9) then
			local var_30_10 = PreciousSuitStruct.new()

			var_30_10:setServerData(iter_30_9)

			self._otherPreciousSuitStructDict[iter_30_8] = var_30_10
		end
	end

	self._otherSuccubaStruct = {}

	for iter_30_10, iter_30_11 in pairs(var_30_2.succuba_id or {}) do
		if next(iter_30_11) then
			local var_30_11 = SuccubaStruct.new({
				id = iter_30_11.base_id
			})

			var_30_11:setSvrData(iter_30_11)

			self._otherSuccubaStruct[iter_30_10] = var_30_11
		end
	end

	self._otherUserName = var_30_2.userName or ""
	self._otherMatchInfos = {}
	self._otherMatchInfos[g.core.common.Goods.TYPE_KNIGHT] = var_30_3
end

function FormationPreStruct:getOtherUserName()
	return self._otherUserName
end

function FormationPreStruct:getOtherKnightStruct(arg_32_1)
	return self._otherKnightStructDict[arg_32_1]
end

function FormationPreStruct:getOtherUniteStruct(arg_33_1)
	return self._otherUniteStructDict[arg_33_1]
end

function FormationPreStruct:getOtherPetStruct(arg_34_1)
	return self._otherPetStructDict[arg_34_1]
end

function FormationPreStruct:getOtherPartnerStruct(arg_35_1)
	return self._otherPartnerStructDict[arg_35_1]
end

function FormationPreStruct:getOtherPreciousSuitStruct(arg_36_1)
	return self._otherPreciousSuitStructDict[arg_36_1]
end

function FormationPreStruct:getOtherPreciousSuitDict()
	return self._otherPreciousSuitStructDict
end

function FormationPreStruct:getOtherSuccubaStruct(arg_38_1)
	return self._otherSuccubaStruct[arg_38_1]
end

function FormationPreStruct:getOtherSuccubaDict()
	return self._otherSuccubaStruct
end

function FormationPreStruct:getOtherHaolGroupInfo()
	return self:_getHaloGroupInfo((table.values(self._otherKnightStructDict)))
end

function FormationPreStruct:getOtherMatchInfos()
	return self._otherMatchInfos or {}
end

function FormationPreStruct:getOtherAllAssCount()
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in pairs(self._otherPartnerStructDict) do
		var_42_0[iter_42_1:getAdvanceId()] = iter_42_1
	end

	local var_42_1 = {}

	for iter_42_2, iter_42_3 in pairs(self._otherKnightStructDict) do
		var_42_1[iter_42_3:getAdvanceId()] = iter_42_3
	end

	return self:_getKnightAssCountByList(self._otherKnightStructDict, var_42_1, var_42_0)
end

return FormationPreStruct
