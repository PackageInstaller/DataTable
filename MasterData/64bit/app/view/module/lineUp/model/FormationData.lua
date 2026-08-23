local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.config.knight_association_info
local var_0_2 = g.core.config.enhance_master_info
local var_0_3 = g.core.config.multi_team_info
local var_0_4 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_5 = g.core.const.ConstMgr.FormationConst
local PreFormationStruct = require("app.view.module.formation.model.PreFormationStruct")
local var_0_7 = g.core.const.ConstMgr.ETConst
local FormationData = class("FormationData")

function FormationData:ctor()
	self:initData()
end

function FormationData:initData()
	self._tokenFormation = {}
	self._knightIdList = {}
	self._knightFormatMap = {}
	self._position = {}
	self._assData = {}
	self._newUnlockAss = {}
	self._suitData = {}
	self._newSuitData = {}
	self._equipMasterData = {}
	self._newEquipData = {}
	self._treasMasterData = {}
	self._newTreasData = {}
	self._equipIdList = {}
	self._preciousSuitList = {}
	self._succubaList = {}
	self._curHaloGroup = var_0_4.GROUP_TYPE.DEFAULT
	self._groupMap = {}
	self._curHaloCnt = 0
	self._newHaloCnt = 0
	self._hideLineupKnight = true
	self._hideLineupPet = true
	self._allActiveAssList = {}
	self._mainName = ""
	self._preFormationList = {}
	self._preFormationIndexDict = {}
	self._needSaveFormationData = {}
	self._isGetPreFormationData = false
	self._maxPreFormationCount = 0
	self._isInterchangeFormation = false
	self._needChangeFormationData = {}

	self:initFormationPreData()
end

function FormationData:initFormationPreData()
	local var_3_0 = 0

	for iter_3_0, iter_3_1 in var_0_3.ipairs() do
		if iter_3_1.type == var_0_5.PRESET_FORMATION_TYPE.MAIN then
			var_3_0 = var_3_0 + 1
			self._preFormationList[var_3_0] = self:createPreFormation(var_3_0, iter_3_1.id)
			self._preFormationIndexDict[iter_3_1.id] = var_3_0
		end
	end

	self._maxPreFormationCount = var_3_0

	local var_3_1 = g.core.common.Storage:load("preset_formation_use_interchange.json", false) or {}

	self._isInterchangeFormation = var_3_1.isInterchangeFormation ~= nil and var_3_1.isInterchangeFormation == true or true
end

function FormationData:updateFormation(arg_4_1)
	self._tokenFormation = clone(arg_4_1.unite_token_id) or {}
	self._knightIdList = clone(arg_4_1.knight_id) or {}
	self._position = clone(arg_4_1.position) or {}
	self._treasure = clone(arg_4_1.treasure_id) or {}
	self._preciousSuitList = arg_4_1.precious_suits or {}
	self._succubaList = arg_4_1.succuba_id or {}
	self._mainName = arg_4_1.name or ""

	g.core.model.User.knightsData:updateKnightPos(arg_4_1)
	g.core.model.User.uniteTokenData:updateTokenFormation(self._tokenFormation)
	g.core.model.User.treasureData:updateTreasurePos(self._treasure)
	g.core.model.User.equipmentData:updateEquipmentPos(arg_4_1.equipment_id)
	g.core.model.User.artifactData:updateArtifactPos(arg_4_1.artifact_id)
	self:generateMasterData()
end

function FormationData:updatePreciousSuitFormation(arg_5_1)
	self._preciousSuitList = arg_5_1.precious_suits
end

function FormationData:updateSuccubaFormation(arg_6_1)
	self._succubaList = arg_6_1.succuba_id
end

function FormationData:initActiveData(arg_7_1)
	self:updateAssociationData()
	self:updateSuitData(arg_7_1)
	self:updateMasterData()
	self:updateCurrentGroupAndCnt(true)
end

function FormationData:updateAssDataAndSuit(arg_8_1)
	self:_generateNewSuitData(arg_8_1)
	self:updateNewAssociationData()
	self:updateCurrentGroupAndCnt()
end

function FormationData:updateAssociationData()
	self._assData = {}

	for iter_9_0 = 1, var_0_4.LINEUP_MAX do
		table.insert(self._assData, (self:_generateAssDataByIndex(iter_9_0, (g.core.model.User.knightsData:getKnight({
			id = self._knightIdList[iter_9_0]
		})))))
	end
end

function FormationData:_generateAssDataByIndex(arg_10_1, arg_10_2)
	local var_10_0 = {}

	if arg_10_2 then
		local var_10_1 = arg_10_2:getBaseInfo()

		for iter_10_0 = 1, var_0_4.ASSCT_MAX do
			if var_10_1["association_" .. iter_10_0] > 0 then
				table.insert(var_10_0, {
					assId = var_10_1["association_" .. iter_10_0],
					isActive = self:isAssctActive(var_10_1["association_" .. iter_10_0], arg_10_1),
					knightId = var_10_1.id
				})
			end
		end

		table.sort(var_10_0, function(arg_11_0, arg_11_1)
			if arg_11_0.isActive ~= arg_11_1.isActive then
				return arg_11_0.isActive
			end

			if arg_11_0.assId ~= arg_11_1.assId then
				return arg_11_0.assId < arg_11_1.assId
			end
		end)
	end

	return var_10_0
end

function FormationData:getAllActiveAssList(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = 0
	local var_12_1 = 0
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		local var_12_3 = iter_12_1:getBaseInfo()

		for iter_12_2 = 1, var_0_4.ASSCT_MAX do
			if var_12_3["association_" .. iter_12_2] > 0 then
				var_12_1 = var_12_1 + 1

				local var_12_4 = var_0_1.get(var_12_3["association_" .. iter_12_2])
				local var_12_5 = true

				for iter_12_3 = 1, var_0_4.ASS_COND_MAX do
					if var_12_4.type == 1 and var_12_4["value_" .. iter_12_3] > 0 then
						if not arg_12_2[var_12_4["value_" .. iter_12_3]] and not arg_12_3[var_12_4["value_" .. iter_12_3]] then
							var_12_5 = false
						end
					end
				end

				if var_12_5 then
					var_12_0 = var_12_0 + 1

					table.insert(var_12_2, {
						isActive = true,
						assId = var_12_3["association_" .. iter_12_2],
						knightId = var_12_3.id
					})
				end
			end
		end
	end

	return var_12_0, var_12_1, var_12_2
end

function FormationData:getGroupInfo(arg_13_1)
	local var_13_1, var_13_2 = self:_getGrouAndCntByGroupList(var_0_4.HALO_LIMIT_CNT, (self:updateKnightGroupMapByQuality(var_0_4.HALO_QUALITY_LIMIT, arg_13_1)))

	return {
		group = var_13_1,
		count = var_13_2
	}
end

function FormationData:getTotalAssCount(arg_14_1, arg_14_2)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		local var_14_1, var_14_2 = self:generateAssDataAndActiveAssCountByOtherInfos(iter_14_1, arg_14_2[iter_14_0])

		var_14_0 = var_14_0 + var_14_2
	end

	return var_14_0
end

function FormationData:generateAssDataAndActiveAssCountByOtherInfos(arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = 0
	local var_15_2 = arg_15_1:getBaseInfo()

	for iter_15_0 = 1, var_0_4.ASSCT_MAX do
		if var_15_2["association_" .. iter_15_0] > 0 then
			local var_15_3 = self:_isAssctActiveByMatchInfos(var_15_2["association_" .. iter_15_0], arg_15_2)
			local var_15_4

			if var_15_3 then
				var_15_1 = var_15_1 + 1
				var_15_4 = var_15_0
			end

			table.insert(var_15_0, {
				assId = var_15_2["association_" .. iter_15_0],
				isActive = var_15_3,
				knightId = var_15_2.id
			})
		end
	end

	return var_15_0, var_15_1
end

function FormationData:_isAssctActiveByMatchInfos(arg_16_1, arg_16_2, arg_16_3)
	if arg_16_1 <= 0 then
		return false
	end

	local var_16_0 = var_0_1.get(arg_16_1)
	local var_16_1

	if var_16_0.type == var_0_4.ASS_TYPE.KNIGHT then
		var_16_1 = arg_16_2[g.core.common.Goods.TYPE_KNIGHT]
	elseif var_16_0.type == var_0_4.ASS_TYPE.EQUIP then
		var_16_1 = arg_16_2[g.core.common.Goods.TYPE_EQUIP]
	elseif var_16_0.type == var_0_4.ASS_TYPE.TREATURE then
		var_16_1 = arg_16_2[g.core.common.Goods.TYPE_TREASURE]
	end

	local var_16_2 = false

	if not var_16_1 then
		return var_16_2, 0
	end

	for iter_16_0 = 1, var_0_4.ASS_COND_MAX do
		if var_16_0["value_" .. iter_16_0] > 0 and var_16_0["value_" .. iter_16_0] ~= arg_16_3 then
			var_16_2 = var_16_1[var_16_0["value_" .. iter_16_0]]

			if not var_16_1[var_16_0["value_" .. iter_16_0]] then
				break
			end
		end
	end

	return var_16_2, 0
end

function FormationData:generateAssDataAndActiveAssCountByKnight(arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = 0

	if arg_17_1 then
		local var_17_2 = arg_17_1:getBaseInfo()
		local var_17_3 = arg_17_2 or arg_17_1:isLineup()

		for iter_17_0 = 1, var_0_4.ASSCT_MAX do
			if var_17_2["association_" .. iter_17_0] > 0 then
				local var_17_4 = arg_17_1:getInfo()
				local var_17_5 = false

				if var_17_4 and var_17_3 then
					var_17_5 = self:isAssctActive(var_17_2["association_" .. iter_17_0], var_17_4.position)
				end

				local var_17_6

				if var_17_5 then
					var_17_1 = var_17_1 + 1
					var_17_6 = var_17_0
				end

				table.insert(var_17_0, {
					assId = var_17_2["association_" .. iter_17_0],
					isActive = var_17_5,
					knightId = var_17_2.id
				})
			end
		end
	end

	return var_17_0, var_17_1
end

function FormationData:isAssctActive(arg_18_1, arg_18_2, arg_18_3)
	if arg_18_1 <= 0 then
		return false
	end

	local var_18_0 = var_0_1.get(arg_18_1)
	local var_18_1 = false
	local var_18_2 = 0

	for iter_18_0 = 1, var_0_4.ASS_COND_MAX do
		if var_18_0["value_" .. iter_18_0] > 0 and var_18_0["value_" .. iter_18_0] ~= arg_18_3 then
			if var_18_0.type == var_0_4.ASS_TYPE.KNIGHT then
				var_18_1 = g.core.model.User.knightsData:isActiveAssct(var_18_0["value_" .. iter_18_0])
			elseif var_18_0.type == var_0_4.ASS_TYPE.EQUIP then
				var_18_1, var_18_2 = g.core.model.User.equipmentData:isActiveAssct(var_18_0["value_" .. iter_18_0], arg_18_2)
			elseif var_18_0.type == var_0_4.ASS_TYPE.TREATURE then
				var_18_1 = g.core.model.User.treasureData:isActiveAssct(var_18_0["value_" .. iter_18_0], arg_18_2)
			end

			if not var_18_1 then
				return false
			end
		end
	end

	return var_18_1, var_18_2
end

function FormationData:updateNewAssociationData()
	self._newUnlockAss = {}

	local var_19_0 = {}

	for iter_19_0 = 1, var_0_4.LINEUP_MAX do
		for iter_19_1, iter_19_2 in ipairs((self:getAssDatabyIndex(iter_19_0))) do
			if var_0_1.get(iter_19_2.assId).type == var_0_4.ASS_TYPE.KNIGHT then
				var_19_0[#var_19_0 + 1] = iter_19_2
			end
		end
	end

	local var_19_1 = {}

	for iter_19_3 = 1, var_0_4.LINEUP_MAX do
		local var_19_2 = g.core.model.User.knightsData:getKnight({
			id = self._knightIdList[iter_19_3]
		})

		if not var_19_2 then
			break
		end

		local var_19_3 = self:getAssDatabyIndex(iter_19_3)
		local var_19_4 = self:_generateAssDataByIndex(iter_19_3, var_19_2)
		local var_19_5 = not not (var_19_3[1] and var_19_4[1] and g.core.config.knight_info.get(var_19_3[1].knightId).advance_id ~= g.core.config.knight_info.get(var_19_4[1].knightId).advance_id)

		self:setAssDataByIndex(iter_19_3, var_19_4)

		if var_19_5 then
			for iter_19_4 = 1, #var_19_4 do
				if var_19_4[iter_19_4].isActive then
					local var_19_6 = false

					for iter_19_5 = 1, #var_19_0 do
						if var_19_0[iter_19_5].assId == var_19_4[iter_19_4].assId and var_19_0[iter_19_5].isActive then
							var_19_6 = true

							break
						end
					end

					if var_19_6 == false then
						table.insert(var_19_1, {
							assId = var_19_4[iter_19_4].assId,
							knightId = var_19_2:getBaseInfo().id
						})
					end
				end
			end
		else
			for iter_19_6 = 1, #var_19_4 do
				if var_19_4[iter_19_6].isActive then
					local var_19_7 = false

					for iter_19_7 = 1, #var_19_3 do
						if var_19_3[iter_19_7].assId == var_19_4[iter_19_6].assId and var_19_3[iter_19_7].isActive then
							var_19_7 = true

							break
						end
					end

					if var_19_7 == false then
						table.insert(var_19_1, {
							assId = var_19_4[iter_19_6].assId,
							knightId = var_19_2:getBaseInfo().id
						})
					end
				end
			end
		end
	end

	self._newUnlockAss = var_19_1
end

function FormationData:getNewUnlockAssId()
	self._newUnlockAss = {}

	return self._newUnlockAss or {}
end

function FormationData:freshMainAssctList()
	self:setAssDataByIndex(1, (self:_generateAssDataByIndex(1, (g.core.model.User.knightsData:getMainKnight()))))
end

function FormationData:getAssPrevListByKnightIndex(arg_22_1)
	local var_22_0 = self:getAssDatabyIndex(arg_22_1)

	if not var_22_0 then
		return {}
	end

	local var_22_1 = {}
	local var_22_2 = {}
	local var_22_3 = {}

	local function var_22_4(arg_23_0)
		local var_23_1 = false

		if arg_23_0.type == 2 then
			local var_23_2 = g.core.config.equipment_info.get(arg_23_0.value_1).type

			var_23_1 = table.indexof(var_22_2, var_23_2)

			if not var_23_1 then
				table.insert(var_22_2, var_23_2)
			end
		elseif arg_23_0.type == 3 then
			local var_23_3 = g.core.config.treasure_info.get(arg_23_0.value_1).type

			var_23_1 = table.indexof(var_22_3, var_23_3)

			if not var_23_1 then
				table.insert(var_22_3, var_23_3)
			end
		end

		return var_23_1
	end

	for iter_22_0 = 1, var_0_4.ASSCT_MAX do
		if var_22_0[iter_22_0] then
			local var_22_5 = var_0_1.get(var_22_0[iter_22_0].assId)

			if var_22_0[iter_22_0].isActive then
				table.insert(var_22_1, var_22_0[iter_22_0])
				var_22_4(var_22_5)
			elseif not var_22_4(var_22_5) then
				table.insert(var_22_1, var_22_0[iter_22_0])
			end
		end
	end

	return var_22_1
end

function FormationData:getActiveAssCountByKnightPos(arg_24_1)
	local var_24_0 = 0

	for iter_24_0 = 1, #self._assData[arg_24_1] do
		if self._assData[arg_24_1][iter_24_0].isActive then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function FormationData:getAssctConditionCount(arg_25_1)
	local var_25_0 = 0
	local var_25_1 = var_0_1.get(arg_25_1)

	for iter_25_0 = 1, var_0_4.ASS_COND_MAX do
		if var_25_1["value_" .. iter_25_0] > 0 then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0
end

function FormationData:setAssDataByIndex(arg_26_1, arg_26_2)
	self._assData[arg_26_1] = arg_26_2
end

function FormationData:getAssDatabyIndex(arg_27_1)
	return self._assData[arg_27_1]
end

function FormationData:getAssociationListData()
	local var_28_0 = {}

	for iter_28_0 = 1, var_0_4.LINEUP_MAX do
		if not math.uint64_lt(self._knightIdList[iter_28_0], 0, true) then
			local var_28_1 = g.core.model.User.knightsData:getKnightById(self._knightIdList[iter_28_0])
			local var_28_2 = var_28_1:getBaseInfo()
			local var_28_3 = {}

			var_28_3.isRealCell = false
			var_28_3.id = var_28_2.id
			var_28_3.pos = var_28_1:getInfo().position

			table.insert(var_28_0, var_28_3)

			local var_28_4 = {}

			for iter_28_1 = 1, var_0_4.ASSCT_MAX do
				local var_28_5 = {}
				local var_28_6

				if var_28_2["association_" .. iter_28_1] > 0 then
					var_28_6 = true
					var_28_5.isActive = g.core.model.User.formationData:isAssctActive(var_28_2["association_" .. iter_28_1], var_28_1:getInfo().position)
					var_28_5.isRealCell = true
					var_28_5.assctId = var_28_2["association_" .. iter_28_1]
					var_28_5.knightId = var_28_2.id

					table.insert(var_28_4, var_28_5)
				end
			end

			table.sort(var_28_4, function(arg_29_0, arg_29_1)
				if arg_29_0.isActive ~= arg_29_1.isActive then
					return arg_29_0.isActive
				end
			end)

			for iter_28_2 = 1, #var_28_4 do
				table.insert(var_28_0, var_28_4[iter_28_2])
			end

			if not false then
				table.remove(var_28_0)
			end
		end
	end

	return var_28_0
end

function FormationData:getKnightAssctData()
	local var_30_0 = {}

	for iter_30_0 = 1, var_0_4.LINEUP_MAX do
		if not math.uint64_lt(self._knightIdList[iter_30_0], 0, true) then
			local var_30_1 = g.core.model.User.knightsData:getKnightById(self._knightIdList[iter_30_0])
			local var_30_2 = var_30_1:getBaseInfo()
			local var_30_3 = {}

			for iter_30_1 = 1, var_0_4.ASSCT_MAX do
				local var_30_4 = {}

				if var_30_2["association_" .. iter_30_1] > 0 then
					var_30_4.isActive = g.core.model.User.formationData:isAssctActive(var_30_2["association_" .. iter_30_1], var_30_1:getInfo().position)
					var_30_4.assctId = var_30_2["association_" .. iter_30_1]

					if #var_30_3 < 6 then
						table.insert(var_30_3, var_30_4)
					end
				end
			end

			table.sort(var_30_3, function(arg_31_0, arg_31_1)
				if arg_31_0.isActive ~= arg_31_1.isActive then
					return arg_31_0.isActive
				end
			end)
			table.insert(var_30_0, {
				assData = var_30_3,
				knightId = var_30_2.id,
				knightPos = var_30_1:getInfo().position
			})
		end
	end

	return var_30_0
end

function FormationData:getAssctTotalCount()
	local var_32_0 = 0

	for iter_32_0 = 1, var_0_4.LINEUP_MAX do
		var_32_0 = var_32_0 + self:getActiveAssCountByKnightPos(iter_32_0)
	end

	return var_32_0
end

function FormationData:getAvailAssctCountByAdvId(arg_33_1, arg_33_2)
	local var_33_0 = 0
	local var_33_1 = 0
	local var_33_2 = 0

	for iter_33_0 = 1, var_0_4.LINEUP_MAX do
		if self._knightIdList[iter_33_0] and not math.uint64_lt(self._knightIdList[iter_33_0], 0, true) and iter_33_0 ~= arg_33_2 then
			local var_33_3 = var_0_0.get((g.core.model.User.knightsData:getKnightBaseIdById(self._knightIdList[iter_33_0])))

			var_33_2 = 0

			for iter_33_1 = 1, var_0_4.ASSCT_MAX do
				if var_33_3["association_" .. iter_33_1] > 0 then
					var_33_2 = var_33_2 + 1

					local var_33_4 = var_0_1.get(var_33_3["association_" .. iter_33_1])
					local var_33_5 = false
					local var_33_6 = true

					for iter_33_2 = 1, var_0_4.ASS_COND_MAX do
						if var_33_4["value_" .. iter_33_2] == arg_33_1 then
							var_33_5 = true
						elseif var_33_4["value_" .. iter_33_2] > 0 and var_33_4.type == 1 and not g.core.model.User.knightsData:isLineUpByAdvId(var_33_4["value_" .. iter_33_2]) then
							var_33_6 = false
						end
					end

					if var_33_5 and var_33_6 then
						var_33_0 = var_33_0 + 1
					end
				end
			end
		end
	end

	if arg_33_2 and arg_33_2 > 0 and arg_33_2 <= var_0_4.LINEUP_MAX then
		local var_33_7 = g.core.model.User.knightsData:getKnightInfoByAdvanceId(arg_33_1)
		local var_33_8 = 0

		if self._knightIdList[arg_33_2] and not math.uint64_lt(self._knightIdList[arg_33_2], 0, true) then
			var_33_8 = g.core.model.User.knightsData:getKnightById(self._knightIdList[arg_33_2]):getBaseInfo().advance_id
		end

		var_33_2 = 0

		for iter_33_3 = 1, var_0_4.ASSCT_MAX do
			if var_33_7["association_" .. iter_33_3] > 0 then
				var_33_2 = var_33_2 + 1

				if self:isAssctActive(var_33_7["association_" .. iter_33_3], arg_33_2, var_33_8) then
					var_33_0 = var_33_0 + 1
					var_33_1 = var_33_1 + 1
				end
			end
		end
	end

	return var_33_0, var_33_1, var_33_2
end

function FormationData:getPartnerIdByIndex(arg_34_1)
	return (g.core.model.User.knightsData:getKnightBaseIdById(self._knightIdList[arg_34_1 + var_0_4.LINEUP_MAX]))
end

function FormationData:getAssctCountByAssId(arg_35_1)
	local var_35_0 = 0
	local var_35_1 = var_0_1.get(arg_35_1)

	for iter_35_0 = 1, var_0_4.ASS_COND_MAX do
		if var_35_1["value_" .. iter_35_0] > 0 then
			var_35_0 = var_35_0 + 1
		end
	end

	return var_35_0
end

function FormationData:getActiveCountBySid(arg_36_1)
	local var_36_0 = 0
	local var_36_1 = g.core.config.knight_info.get((g.core.model.User.knightsData:getKnightBaseIdById(arg_36_1))).advance_id

	for iter_36_0 = 1, #self._assData do
		for iter_36_1 = 1, #self._assData[iter_36_0] do
			if self._assData[iter_36_0][iter_36_1].isActive then
				local var_36_2 = var_0_1.get(self._assData[iter_36_0][iter_36_1].assId)

				if var_36_2.type == 1 then
					for iter_36_2 = 1, 5 do
						if var_36_2["value_" .. iter_36_2] > 0 and var_36_1 == var_36_2["value_" .. iter_36_2] then
							var_36_0 = var_36_0 + 1
						end
					end
				end
			end
		end
	end

	return var_36_0
end

function FormationData:updateSuitData(arg_37_1)
	self._equipIdList = clone(arg_37_1.equipment_id) or {}

	for iter_37_0 = 1, var_0_4.LINEUP_MAX do
		self._suitData[iter_37_0] = g.core.model.User.equipmentData:getSuitByKnightPos(iter_37_0)
	end
end

function FormationData:_generateNewSuitData(arg_38_1)
	self._newSuitData = {}

	if arg_38_1.tp == 3 then
		local var_38_0 = {}

		for iter_38_0 = 1, #self._equipIdList do
			if self._equipIdList[iter_38_0] ~= arg_38_1.formation.equipment_id[iter_38_0] then
				table.insert(var_38_0, (math.ceil(iter_38_0 / 4)))
			end
		end

		self._equipIdList = clone(arg_38_1.formation.equipment_id)

		for iter_38_1 = 1, #var_38_0 do
			if var_38_0[iter_38_1] > 0 then
				local var_38_1 = self._suitData[var_38_0[iter_38_1]] or {}
				local var_38_2 = g.core.model.User.equipmentData:getSuitByKnightPos(var_38_0[iter_38_1])

				self._suitData[var_38_0[iter_38_1]] = var_38_2

				if var_38_0[iter_38_1] == math.ceil(arg_38_1.pos / 4) then
					for iter_38_2, iter_38_3 in pairs(var_38_2) do
						local var_38_3 = table.nums(var_38_1)
						local var_38_4 = 0

						for iter_38_4, iter_38_5 in pairs(var_38_1) do
							if iter_38_2 ~= iter_38_4 then
								var_38_4 = var_38_4 + 1
							end

							if iter_38_2 == iter_38_4 and iter_38_5 < iter_38_3 then
								table.insert(self._newSuitData, {
									suitId = iter_38_2,
									num = iter_38_3
								})
							end
						end

						if iter_38_3 > 1 and var_38_4 == var_38_3 then
							table.insert(self._newSuitData, {
								suitId = iter_38_2,
								num = iter_38_3
							})
						end
					end
				end
			else
				self:updateSuitData(arg_38_1.formation)
			end
		end
	end
end

function FormationData:getEquipSuitByKnightPos(arg_39_1)
	return self._suitData[arg_39_1]
end

function FormationData:getNewEquipmentSuitData()
	return self._newSuitData
end

function FormationData:updateMasterData()
	self._equipMasterData = {}
	self._treasMasterData = {}

	for iter_41_0 = 1, var_0_4.LINEUP_MAX do
		table.insert(self._equipMasterData, (g.core.model.User.equipmentData:getEquipMasterDataByKnightIdx(iter_41_0)))
		table.insert(self._treasMasterData, (g.core.model.User.treasureData:getTreasMasterDataByKnightIdx(iter_41_0)))
	end
end

function FormationData:generateMasterData()
	self:generateNewEquipMasterData()
	self:generateNewTreasMasterData()
end

function FormationData:generateNewEquipMasterData()
	for iter_43_0 = 1, var_0_4.LINEUP_MAX do
		local var_43_0 = g.core.model.User.equipmentData:getEquipMasterDataByKnightIdx(iter_43_0)

		self:_handleNewMasterData(self._equipMasterData, self._newEquipData, var_43_0, iter_43_0, 4)

		self._equipMasterData[iter_43_0] = var_43_0
	end
end

function FormationData:generateNewTreasMasterData()
	for iter_44_0 = 1, var_0_4.LINEUP_MAX do
		local var_44_0 = g.core.model.User.treasureData:getTreasMasterDataByKnightIdx(iter_44_0)

		self:_handleNewMasterData(self._treasMasterData, self._newTreasData, var_44_0, iter_44_0, 2)

		self._treasMasterData[iter_44_0] = var_44_0
	end
end

function FormationData:_handleNewMasterData(arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	arg_45_2[arg_45_4] = {}

	if not arg_45_1[arg_45_4] then
		return
	end

	for iter_45_0, iter_45_1 in pairs(var_0_7.MASTER_TYPE) do
		if arg_45_3[iter_45_1] and next(arg_45_3[iter_45_1]) then
			local var_45_0 = self:_getMasterMinByList(arg_45_3[iter_45_1], arg_45_5)
			local var_45_1 = self:_getMasterMinByList(arg_45_1[arg_45_4][iter_45_1], arg_45_5)

			if var_45_1 < var_45_0 then
				local var_45_2 = {
					self:_getMasterLevelList(var_45_1, var_45_0, iter_45_1)
				}

				if var_45_2[1] > var_45_2[2] then
					arg_45_2[arg_45_4][iter_45_1] = {
						aLevel = var_45_2[1],
						bLevel = var_45_2[2]
					}
				end
			end
		end
	end
end

function FormationData:_getMasterLevelList(arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = 0
	local var_46_1 = 0
	local var_46_2 = var_0_2.match(function(arg_47_0)
		return arg_47_0.type == arg_46_3
	end)

	for iter_46_0 = 1, #var_46_2 do
		if arg_46_1 >= var_46_2[iter_46_0].value then
			var_46_0 = var_46_2[iter_46_0].value
		end

		if arg_46_2 >= var_46_2[iter_46_0].value then
			var_46_1 = var_46_2[iter_46_0].value
		end
	end

	return var_46_1, var_46_0
end

function FormationData:_getMasterMinByList(arg_48_1, arg_48_2)
	if not arg_48_1 or not next(arg_48_1) then
		return 0
	end

	if arg_48_2 > #arg_48_1 then
		return 0
	end

	local var_48_0 = arg_48_1[1]

	for iter_48_0 = 2, #arg_48_1 do
		var_48_0 = math.min(var_48_0, arg_48_1[iter_48_0])
	end

	return var_48_0
end

function FormationData:getNewEquipMasterData(arg_49_1)
	self._newEquipData[arg_49_1] = {}

	return self._newEquipData[arg_49_1] or {}
end

function FormationData:getNewTreasMasterData(arg_50_1)
	self._newTreasData[arg_50_1] = {}

	return self._newTreasData[arg_50_1] or {}
end

function FormationData:getKnightList()
	return self._knightIdList
end

function FormationData:getKnightFormationIndexById(arg_52_1)
	for iter_52_0, iter_52_1 in ipairs(self._knightIdList) do
		if arg_52_1 == iter_52_1 then
			return iter_52_0
		end
	end
end

function FormationData:getKnightListIndex()
	local var_53_0 = {}

	for iter_53_0 = 1, var_0_4.LINEUP_MAX do
		var_53_0[#var_53_0 + 1] = {
			id = self._knightIdList[iter_53_0],
			index = self._position[iter_53_0]
		}
	end

	table.sort(var_53_0, function(arg_54_0, arg_54_1)
		if arg_54_0.index ~= arg_54_1.index then
			return arg_54_0.index < arg_54_1.index
		end
	end)

	return var_53_0
end

function FormationData:getPositionList()
	return self._position
end

function FormationData:getKnightPositionBySid(arg_56_1)
	for iter_56_0, iter_56_1 in ipairs(self._knightIdList) do
		if iter_56_1 == arg_56_1 then
			return iter_56_0
		end
	end

	return 0
end

function FormationData:updatePosition(arg_57_1, arg_57_2)
	local var_57_0

	for iter_57_0, iter_57_1 in ipairs(self._position) do
		if iter_57_1 == arg_57_1 then
			var_57_0 = iter_57_0
		end

		local var_57_1

		if iter_57_1 == arg_57_2 then
			var_57_1 = iter_57_0
		end
	end

	self._position[var_57_0] = self._position[nil]
	self._position[nil] = self._position[var_57_0]
end

function FormationData:getLineupKnightCount()
	local var_58_0 = 0

	for iter_58_0 = 1, var_0_4.LINEUP_MAX do
		if not math.uint64_lt(self._knightIdList[iter_58_0], 0, true) then
			var_58_0 = var_58_0 + 1
		end
	end

	return var_58_0
end

function FormationData:getKnightMinPotential()
	local var_59_0 = 100

	for iter_59_0 = 1, var_0_4.LINEUP_MAX do
		local var_59_1 = g.core.model.User.knightsData:getKnight({
			id = self._knightIdList[iter_59_0]
		})

		if var_59_1 and not var_59_1:isMain() then
			local var_59_2 = var_59_1:getBaseInfo()

			if var_59_0 > var_59_2.potential then
				var_59_0 = var_59_2.potential
			end
		end
	end

	return var_59_0
end

function FormationData:getKnightMinQuality()
	local var_60_0 = 100

	for iter_60_0 = 1, var_0_4.LINEUP_MAX do
		local var_60_1 = g.core.model.User.knightsData:getKnight({
			id = self._knightIdList[iter_60_0]
		})

		if var_60_1 and not var_60_1:isMain() then
			local var_60_2 = var_60_1:getBaseInfo()

			if var_60_0 > var_60_2.quality then
				var_60_0 = var_60_2.quality
			end
		end
	end

	return var_60_0
end

function FormationData:getCanLineupKnightCount()
	local var_61_0 = 0
	local var_61_1 = {
		g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_LINE_UP_1,
		g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_LINE_UP_2,
		g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_LINE_UP_3,
		g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_LINE_UP_4,
		g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_LINE_UP_5,
		g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_LINE_UP_6
	}
	local var_61_2 = self:getKnightList()

	for iter_61_0 = 2, var_0_4.LINEUP_MAX do
		if var_61_2[iter_61_0] == 0 and g.core.common.ModuleUnlock:isModuleUnlock(var_61_1[iter_61_0 - 1]) then
			var_61_0 = var_61_0 + 1
		end
	end

	return (math.min(#g.core.model.User.knightsData:getIdleList(), var_61_0))
end

function FormationData:getUnlockFormationNum()
	local var_62_0 = 0

	for iter_62_0 = 1, var_0_4.LINEUP_MAX do
		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["KNIGHT_LINE_UP_" .. iter_62_0]) then
			var_62_0 = var_62_0 + 1
		else
			break
		end
	end

	return var_62_0
end

function FormationData:updateKnightGroupMapByQuality(arg_63_1, arg_63_2)
	arg_63_2 = arg_63_2 or {}
	arg_63_1 = arg_63_1 or var_0_4.GROUP_TYPE.DEFAULT

	local var_63_0 = {}

	for iter_63_0, iter_63_1 in ipairs(arg_63_2) do
		local var_63_1 = iter_63_1:getGroup()

		if not arg_63_1 or arg_63_1 <= iter_63_1:getQuality() then
			var_63_0[var_63_1] = var_63_0[var_63_1] or 0
			var_63_0[var_63_1] = var_63_0[var_63_1] + 1
		end
	end

	return var_63_0
end

function FormationData:getCurrentGroupAndCnt(arg_64_1)
	return self._curHaloGroup, self._curHaloCnt
end

function FormationData:_getGrouAndCntByGroupList(arg_65_1, arg_65_2)
	local var_65_0 = var_0_4.GROUP_TYPE.DEFAULT
	local var_65_1 = 0

	arg_65_1 = arg_65_1 or 0

	for iter_65_0, iter_65_1 in pairs(arg_65_2) do
		if var_65_1 < iter_65_1 then
			var_65_0 = iter_65_0
			var_65_1 = iter_65_1
		end
	end

	return var_65_0, var_65_1
end

function FormationData:updateCurrentGroupAndCnt(arg_66_1)
	self._groupMap = self:updateKnightGroupMapByQuality(var_0_4.HALO_QUALITY_LIMIT, g.core.model.User.knightsData:getLineupKnightList())

	local var_66_0, var_66_1 = self:_getGrouAndCntByGroupList(var_0_4.HALO_LIMIT_CNT, self._groupMap)

	self._curHaloGroup = var_66_0

	if not arg_66_1 and var_66_1 - self._curHaloCnt > 0 then
		self._newHaloCnt = var_66_1 - self._curHaloCnt
	end

	self._curHaloCnt = var_66_1
end

function FormationData:isActiveHalo(arg_67_1, arg_67_2)
	if arg_67_2 < 2 or arg_67_2 > var_0_4.LINEUP_MAX then
		return false
	end

	local var_67_0 = g.core.model.User.knightsData:getKnight({
		id = arg_67_1
	})

	if var_67_0:getQuality() < var_0_4.HALO_QUALITY_LIMIT then
		return false
	end

	local var_67_1 = self._groupMap
	local var_67_2 = var_67_0:getGroup()

	if self._knightIdList[arg_67_2] and not math.uint64_lt(self._knightIdList[arg_67_2], 0, true) then
		local var_67_3 = g.core.model.User.knightsData:getKnightById(self._knightIdList[arg_67_2])

		if var_67_3:getQuality() >= var_0_4.HALO_QUALITY_LIMIT and var_67_2 == var_67_3:getGroup() then
			return false
		end
	end

	return (var_67_1[var_67_2] or 0) + 1 > self._curHaloCnt
end

function FormationData:getActiveHalo()
	if self._newHaloCnt == 0 then
		return nil
	end

	local var_68_0 = g.core.config.talent_skill_info.match("open_type", g.core.const.ConstMgr.TalentConst.OPEN_TYPE.LINEUP_HALO)

	self._newHaloCnt = 0

	return {
		group = self._curHaloGroup,
		count = self._curHaloCnt,
		cfg = var_68_0[self._curHaloCnt],
		type = var_0_4.SHOW_ASS_TYPE.HALO
	}
end

function FormationData:getHaloGroupByCount(arg_69_1)
	for iter_69_0, iter_69_1 in pairs(self._groupMap) do
		if arg_69_1 <= iter_69_1 then
			return iter_69_0
		end
	end

	return 0
end

function FormationData:getActiveEquipGlyphSuit(arg_70_1)
	if arg_70_1 == 0 then
		return {}
	end

	local var_70_0 = g.core.model.User.equipmentData:getEquipSuitByKnightPos(arg_70_1)
	local var_70_1 = {}

	for iter_70_0 = 1, #var_70_0 do
		if var_70_0[iter_70_0] ~= 0 then
			local var_70_2 = var_70_0[iter_70_0]:getGlyphInfo().level

			if var_70_2 > 0 then
				repeat
					var_70_1[var_70_2] = var_70_1[var_70_2] or 0
					var_70_1[var_70_2] = var_70_1[var_70_2] + 1
					var_70_2 = var_70_2 - 1
				until var_70_2 == 0
			end
		end
	end

	local var_70_3 = {}

	for iter_70_1, iter_70_2 in pairs(var_70_1) do
		if iter_70_2 > 1 then
			table.insert(var_70_3, {
				level = iter_70_1,
				num = iter_70_2
			})
		end
	end

	table.sort(var_70_3, function(arg_71_0, arg_71_1)
		if arg_71_0.level ~= arg_71_1.level then
			return arg_71_0.level > arg_71_1.level
		end
	end)

	return var_70_3
end

function FormationData:getActiveTreasureGlyphSuit(arg_72_1)
	if arg_72_1 == 0 then
		return {}
	end

	local var_72_0 = g.core.model.User.treasureData:getTreasureDataListByKnightPos(arg_72_1)
	local var_72_1 = {}

	for iter_72_0 = 1, #var_72_0 do
		if var_72_0[iter_72_0] ~= 0 then
			local var_72_2 = g.core.model.User.treasureData:getTreasureGlyphInfo(var_72_0[iter_72_0]).level

			if var_72_2 > 0 then
				repeat
					var_72_1[var_72_2] = var_72_1[var_72_2] or 0
					var_72_1[var_72_2] = var_72_1[var_72_2] + 1
					var_72_2 = var_72_2 - 1
				until var_72_2 == 0
			end
		end
	end

	local var_72_3 = {}

	for iter_72_1, iter_72_2 in pairs(var_72_1) do
		if iter_72_2 > 1 then
			table.insert(var_72_3, {
				level = iter_72_1,
				num = iter_72_2
			})
		end
	end

	table.sort(var_72_3, function(arg_73_0, arg_73_1)
		if arg_73_0.level ~= arg_73_1.level then
			return arg_73_0.level > arg_73_1.level
		end
	end)

	return var_72_3
end

function FormationData:isBackupShow(arg_74_1)
	local var_74_0 = g.core.config.backup_open_info.get(arg_74_1)

	return (self:_checkReach(var_74_0.show_unlock_type, var_74_0.show_unlock_value))
end

function FormationData:isBackupUnlock(arg_75_1)
	local var_75_0 = g.core.config.backup_open_info.get(arg_75_1)

	return (self:_checkReach(var_75_0.unlock_type, var_75_0.unlock_value))
end

function FormationData:checkBackupUnlockStatus(arg_76_1)
	if not self:isBackupUnlock(arg_76_1) then
		local var_76_0 = g.core.config.backup_open_info.fetch(arg_76_1)

		g.core.module.ModuleManager:tip((var_76_0 or nil) and (var_76_0.lock_des or ""))

		return false
	end

	return true
end

function FormationData:_checkReach(arg_77_1, arg_77_2)
	local var_77_0 = 0

	if arg_77_1 == 2 then
		var_77_0 = g.core.model.User:getLevel()
	else
		for iter_77_0 = 1, var_0_4.LINEUP_MAX do
			if not math.uint64_lt(self._knightIdList[iter_77_0], 0, true) then
				local var_77_1 = g.core.model.User.knightsData:getKnightById(self._knightIdList[iter_77_0])

				if var_77_1:getBaseInfo().quality >= 7 and not var_77_1:isMain() then
					var_77_0 = var_77_0 + 1
				end
			end
		end
	end

	return arg_77_2 <= var_77_0
end

function FormationData:isPositionCanLineupKnight(arg_78_1)
	if arg_78_1.index then
		if self._knightIdList[arg_78_1.index] ~= 0 then
			return false
		else
			return not not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["KNIGHT_LINE_UP_" .. arg_78_1.index]) and #g.core.model.User.knightsData:getIdleList() > 0
		end
	else
		for iter_78_0 = 1, var_0_4.LINEUP_MAX do
			if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["KNIGHT_LINE_UP_" .. iter_78_0]) then
				return false
			end

			if self._knightIdList[iter_78_0] == 0 and #g.core.model.User.knightsData:getIdleList() > 0 then
				return true
			end
		end

		return false
	end
end

function FormationData:getKnightStarStateByPos(arg_79_1)
	local var_79_0 = g.core.model.User.knightsData:getKnight({
		id = self._knightIdList[arg_79_1]
	})

	if var_79_0 and var_79_0:canStarUp() then
		return true
	else
		return false
	end
end

function FormationData:getKnightAdvanceStateByPos(arg_80_1)
	local var_80_0 = g.core.model.User.knightsData:getKnight({
		id = self._knightIdList[arg_80_1]
	})

	if var_80_0 and var_80_0:canStarUp() then
		return true
	else
		return false
	end
end

function FormationData:isPositionCanLineupUniteToken(arg_81_1)
	if self._tokenFormation[arg_81_1.pos] ~= 0 then
		return false
	else
		return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["UNITE_TOKEN_LINE_UP_" .. arg_81_1.pos])
	end
end

function FormationData:hasPositionCanLineupUniteToken()
	if g.core.model.User.uniteTokenData:hasNotLineUpToken() then
		for iter_82_0, iter_82_1 in pairs(self._tokenFormation) do
			if iter_82_1 == 0 and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE["UNITE_TOKEN_LINE_UP_" .. iter_82_0]) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function FormationData:getLevelFormatStr(arg_83_1, arg_83_2)
	return arg_83_1 >= 100 and "Lv." .. tostring(arg_83_1) or arg_83_1 >= 10 and "Lv.0" .. tostring(arg_83_1) or "Lv.00" .. tostring(arg_83_1), (arg_83_2 or nil) and (arg_83_2 >= 10 and "+" .. tostring(arg_83_2) or "+0" .. tostring(arg_83_2))
end

function FormationData:isHideLineupKnight()
	return self._hideLineupKnight
end

function FormationData:setHideLineupKnight(arg_85_1)
	self._hideLineupKnight = arg_85_1
end

function FormationData:isHideLineupPet()
	return self._hideLineupPet
end

function FormationData:setHideLineupPet(arg_87_1)
	self._hideLineupPet = arg_87_1
end

function FormationData:onS2CPreFormationFlush(arg_88_1)
	self._isGetPreFormationData = true

	for iter_88_0, iter_88_1 in pairs(arg_88_1.data or {}) do
		self:getPreFormation(self._preFormationIndexDict[iter_88_1.id]):setSvrData(iter_88_1)
	end
end

function FormationData:onS2CPreFormationInherit(arg_89_1)
	if self._isInterchangeFormation then
		local var_89_0 = self:getPreFormation(self._preFormationIndexDict[arg_89_1.preset_id])

		var_89_0:setSvrData(self:getNeedChangeFormationData())
		g.core.network.GameNetProxy:send_C2S_PresetFormation_Save({
			formations = {
				(var_89_0:toOutBaseFormation())
			}
		})
		g.core.network.GameNetProxy:send_C2S_PresetFormation_NameModify({
			id = var_89_0:getFormationUniqueId(),
			name = var_89_0:getFormationName()
		})
		self:setNeedSaveFormation(var_89_0)
	end

	local var_89_1 = arg_89_1.formation

	if arg_89_1.formation then
		self:updateFormation(var_89_1)
		g.core.model.User.treasureData:updateTreasureFormation()
		self:initActiveData(var_89_1)
		g.core.model.User.rebornData:updateKnightRed()
		g.core.model.User.rebornData:updateDecomposeEquipRed()
		g.core.model.User.petsData:_updatePosBySidDict(var_89_1.pet_id)
	end
end

function FormationData:onS2CPreFormationSaveError()
	for iter_90_0, iter_90_1 in ipairs(self._needSaveFormationData) do
		self:getPreFormation(self._preFormationIndexDict[iter_90_0]):resetSvrData()

		self._needSaveFormationData[iter_90_1] = nil
	end
end

function FormationData:onS2CPreFormationSaveById(arg_91_1)
	if self._needSaveFormationData[arg_91_1] then
		self._preFormationList[self._preFormationIndexDict[arg_91_1]]:setSvrData(self._needSaveFormationData[arg_91_1])

		self._needSaveFormationData[arg_91_1] = nil
	end
end

function FormationData:onS2CPreFormationNameModify(arg_92_1)
	if self._preFormationIndexDict[arg_92_1.id or 0] then
		self._preFormationList[self._preFormationIndexDict[arg_92_1.id]]:setName(arg_92_1.name or "")
	end
end

function FormationData:setNeedSaveFormation(arg_93_1)
	self._needSaveFormationData[arg_93_1:getFormationUniqueId()] = arg_93_1:toOutBaseFormation()
end

function FormationData:createPreFormation(arg_94_1, arg_94_2)
	return PreFormationStruct.new(arg_94_1, arg_94_2)
end

function FormationData:getPreFormation(arg_95_1)
	self._preFormationList[arg_95_1] = self._preFormationList[arg_95_1] or self:createPreFormation(arg_95_1, 0)

	return self._preFormationList[arg_95_1]
end

function FormationData:getAllPreFormation(arg_96_1)
	return self._preFormationList
end

function FormationData:getPreFormationByString(arg_97_1)
	local var_97_0 = self:createPreFormation()

	var_97_0:analysisStringFormation(arg_97_1)

	return var_97_0
end

function FormationData:getMaxFormationCount()
	return self._maxPreFormationCount
end

function FormationData:isGetPreFormationData()
	return self._isGetPreFormationData
end

function FormationData:setInterchangeFormation(arg_100_1)
	if arg_100_1 ~= self._isInterchangeFormation then
		self._isInterchangeFormation = arg_100_1 == true

		g.core.common.Storage:save("preset_formation_use_interchange.json", {
			isInterchangeFormation = self._isInterchangeFormation
		}, false)
	end
end

function FormationData:isInterchangeFormation()
	return self._isInterchangeFormation
end

function FormationData:isOpenPreFormation()
	for iter_102_0 = 1, var_0_4.LINEUP_MAX do
		if self._knightIdList[iter_102_0] == 0 then
			return false
		end
	end

	return true
end

function FormationData:refreshPreDataByCurFormation()
	self._needChangeFormationData = {
		knight_id = {},
		unite_token_id = {},
		artifact_id = {},
		pet_id = {},
		pet_equipment_id = {},
		precious_suits = {},
		succuba_id = {},
		name = {},
		knight_id = self._knightIdList,
		unite_token_id = self._tokenFormation,
		pet_id = g.core.model.User.petsData:getLineupSidDict(),
		precious_suits = self._preciousSuitList,
		succuba_id = self._succubaList,
		pet_equipment_id = {},
		name = self._mainName
	}
end

function FormationData:getMulTeamDataByCurFormation(arg_104_1)
	local var_104_0 = {
		position = {},
		knight_id = {},
		unite_token_id = {},
		artifact_id = {},
		pet_id = {},
		pet_equipment_id = {},
		precious_suits = {},
		equipment_id = {},
		treasure_id = {},
		tp = arg_104_1
	}

	var_104_0.seq = 1
	var_104_0.unique_id = 1
	var_104_0.name = self._mainName
	var_104_0.position = self._position
	var_104_0.knight_id = self:_getList(self._knightIdList, var_0_4.LINEUP_MAX)
	var_104_0.unite_token_id = self._tokenFormation
	var_104_0.pet_id = self:_getList(g.core.model.User.petsData:getLineupSidDict(), g.core.const.ConstMgr.PetConst.SERVER_LINEUP_MAX)
	var_104_0.precious_suits = self._preciousSuitList
	var_104_0.succuba_id = self._succubaList
	var_104_0.artifact_id = g.core.model.User.artifactData:getFormationList()

	return var_104_0
end

function FormationData:_getList(arg_105_1, arg_105_2)
	local var_105_0 = {}

	for iter_105_0 = 1, arg_105_2 do
		var_105_0[iter_105_0] = arg_105_1[iter_105_0] or 0
	end

	return var_105_0
end

function FormationData:getNeedChangeFormationData()
	return self._needChangeFormationData
end

function FormationData:setMainName(arg_107_1)
	self._mainName = arg_107_1
end

function FormationData:isValidMainName()
	return self._mainName ~= ""
end

function FormationData:getMainName()
	if self._mainName == "" then
		return g.core.lang:get(200019)
	end

	return self._mainName
end

function FormationData:getPreciousSuitId(arg_110_1)
	return self._preciousSuitList[arg_110_1] or 0
end

function FormationData:getPreciousSuitStationPos(arg_111_1)
	return table.keyof(self._preciousSuitList, arg_111_1) or 0
end

function FormationData:hasPreciousSuitCanLineUp(arg_112_1)
	if arg_112_1.hasRed == false then
		return false
	end

	if arg_112_1.pos then
		if self:getPreciousSuitId(arg_112_1.pos) > 0 then
			return false
		else
			local var_112_0 = 0

			for iter_112_0, iter_112_1 in pairs(self._preciousSuitList) do
				if iter_112_1 > 0 then
					var_112_0 = var_112_0 + 1
				end
			end

			return var_112_0 < #g.core.model.User.preciousData:getAllActiveSuitList()
		end
	else
		local var_112_1 = 0

		for iter_112_2, iter_112_3 in pairs(self._preciousSuitList) do
			if iter_112_3 > 0 then
				var_112_1 = var_112_1 + 1
			end
		end

		if var_112_1 >= g.core.const.ConstMgr.PreciousConst.LINEUP_MAX then
			return false
		else
			return var_112_1 < #g.core.model.User.preciousData:getAllActiveSuitList()
		end
	end

	return false
end

function FormationData:getSuccubaId(arg_113_1)
	return self._succubaList[arg_113_1] or 0
end

function FormationData:getSuccubaStationPos(arg_114_1)
	return table.keyof(self._succubaList, arg_114_1) or 0
end

function FormationData:hasSuccubaCanLineUp(arg_115_1)
	if arg_115_1.hasRed == false then
		return false
	end

	if arg_115_1.pos then
		if self:getSuccubaId(arg_115_1.pos) > 0 then
			return false
		else
			local var_115_0 = 0

			for iter_115_0, iter_115_1 in pairs(self._succubaList) do
				if iter_115_1 > 0 then
					var_115_0 = var_115_0 + 1
				end
			end

			return var_115_0 < #g.core.model.User.succubaData:getSuccubaList()
		end
	else
		local var_115_1 = 0

		for iter_115_2, iter_115_3 in pairs(self._succubaList) do
			if iter_115_3 > 0 then
				var_115_1 = var_115_1 + 1
			end
		end

		if var_115_1 >= g.core.const.ConstMgr.SuccubaConst.FORMAT_SUCCUBA_NUM_MAX then
			return false
		else
			return var_115_1 < #g.core.model.User.succubaData:getSuccubaList()
		end
	end

	return false
end

return FormationData
