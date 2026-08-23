local EquipmentData = class("EquipmentData")
local var_0_1 = g.core.config.enhance_master_info
local var_0_2 = g.core.config.equipment_info
local var_0_3 = g.core.config.equipment_resonance_info
local var_0_4 = g.core.config.equipment_resonance_sub_info
local var_0_5 = g.core.config.equipment_refine_cap_info
local var_0_6 = g.core.config.equipment_suit_stage_info
local var_0_7 = g.core.config.talent_skill_info
local var_0_8 = g.core.config.equipment_stage_info
local var_0_9 = g.core.model.User.bagData
local EquipmentStruct = import(".EquipmentStruct")
local var_0_11 = table.insert
local var_0_12 = g.core.common.Path
local var_0_13 = g.core.const.ConstMgr

EquipmentData.TYPE_EQUIP = 1
EquipmentData.TYPE_EQUIP_FRAG = 2

function EquipmentData:ctor()
	self:initData()
end

function EquipmentData:initData()
	self._lazy = false
	self._equipMap = {}
	self._equipList = {}
	self._equipPosMap = {}
	self._equipKnightPosMap = {}
	self._isPrompted = false
	self._isHideWear = true
	self._upType = {
		{
			name = g.core.lang:get(201553),
			iconUrl = var_0_12:getAttrIcon(var_0_13.BASE_CONST.ATTRIBUTE_TYPE.LIFE, true)
		},
		{
			name = g.core.lang:get(201554),
			iconUrl = var_0_12:getAttrIcon(var_0_13.BASE_CONST.ATTRIBUTE_TYPE.ATTACK, true)
		},
		{
			name = g.core.lang:get(201555),
			iconUrl = var_0_12:getAttrIcon(var_0_13.BASE_CONST.ATTRIBUTE_TYPE.ARMOR, true)
		},
		{
			name = g.core.lang:get(201556),
			iconUrl = var_0_12:getAttrIcon(var_0_13.BASE_CONST.ATTRIBUTE_TYPE.RESISTANCE, true)
		}
	}
end

function EquipmentData:updateEquipInfo()
	local var_3_0 = g.core.model.User.bagData:getList(var_0_13.BAG_TYPE.EQUIPMENT)

	for iter_3_0 = 1, #var_3_0 do
		if not self._equipMap[var_3_0[iter_3_0].id] then
			local var_3_1 = EquipmentStruct.new(var_3_0[iter_3_0].id)

			var_3_1:setCfg((g.core.config.equipment_info.get(var_3_0[iter_3_0].base_id)))
			var_3_1:setServerData(var_3_0[iter_3_0])

			self._equipList[#self._equipList + 1] = var_3_1
			self._equipMap[var_3_0[iter_3_0].id] = var_3_1
		else
			self._equipMap[var_3_0[iter_3_0].id]:setServerData(var_3_0[iter_3_0])
		end
	end

	self:sortEquipList(self._equipList)
end

function EquipmentData:removeEquipment(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		for iter_4_2, iter_4_3 in ipairs(self._equipList) do
			if iter_4_1 == iter_4_3:getServerData().id then
				table.remove(self._equipList, iter_4_2)

				break
			end
		end

		self._equipMap[iter_4_1] = nil
	end
end

function EquipmentData:updateEquipmentPos(arg_5_1)
	self._equipPosMap = arg_5_1
	self._equipKnightPosMap = {}

	for iter_5_0 = 1, #arg_5_1, 4 do
		local var_5_0 = {}

		for iter_5_1 = iter_5_0, iter_5_0 + 4 - 1 do
			var_0_11(var_5_0, arg_5_1[iter_5_1])
		end

		var_0_11(self._equipKnightPosMap, var_5_0)
	end

	local var_5_1 = {}

	for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
		if not math.uint64_equal(iter_5_3, 0) then
			var_5_1[iter_5_3] = iter_5_2
		end
	end

	for iter_5_4, iter_5_5 in ipairs(self._equipList) do
		iter_5_5:updatePosition(var_5_1[iter_5_5:getServerData().id] or 0)
	end
end

function EquipmentData:sortEquipList(arg_6_1)
	table.sort(arg_6_1, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:getCfg()
		local var_7_1 = arg_7_1:getCfg()
		local var_7_2 = arg_7_0:getServerData()
		local var_7_3 = arg_7_1:getServerData()

		if var_7_2.position ~= 0 and var_7_3.position == 0 or var_7_2.position == 0 and var_7_3.position ~= 0 then
			return var_7_2.position ~= 0
		end

		if var_7_0.quality ~= var_7_1.quality then
			return var_7_0.quality > var_7_1.quality
		end

		if var_7_2.level ~= var_7_3.level then
			return var_7_2.level > var_7_3.level
		end

		if var_7_2.refining_level ~= var_7_3.refining_level then
			return var_7_2.refining_level > var_7_3.refining_level
		end

		if var_7_2.position ~= 0 and var_7_3.position ~= 0 then
			return var_7_2.position < var_7_3.position
		end
	end)
end

function EquipmentData:getAllEquipList()
	return self._equipList
end

function EquipmentData:countEquipmentNum()
	return #self._equipList
end

function EquipmentData:getEquipList(arg_10_1)
	local var_10_0 = {
		typeIndex = {},
		noWearIndex = {},
		allIndex = {}
	}

	for iter_10_0, iter_10_1 in ipairs(self._equipList) do
		if not arg_10_1 or iter_10_1:getCfg().type == arg_10_1 then
			var_0_11(var_10_0.allIndex, iter_10_1)

			if iter_10_1:getPosition() == 0 then
				var_0_11(var_10_0.noWearIndex, iter_10_1)
			end

			if iter_10_1:getCfg().type == arg_10_1 then
				var_0_11(var_10_0.typeIndex, iter_10_1)
			end
		end
	end

	return var_10_0
end

function EquipmentData:getEquipBySid(arg_11_1)
	return self._equipMap[arg_11_1]
end

function EquipmentData:getEquipMap()
	return self._equipMap
end

function EquipmentData:getEquipIdByPos(arg_13_1)
	return self._equipPosMap[arg_13_1]
end

function EquipmentData:getEquipDataByPos(arg_14_1)
	return self:getEquipBySid((self:getEquipIdByPos(arg_14_1)))
end

function EquipmentData:isWornEquip(arg_15_1)
	return not math.uint64_equal(self._equipPosMap[arg_15_1], 0)
end

function EquipmentData:getEquipSuitByKnightPos(arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self._equipKnightPosMap[arg_16_1]) do
		var_0_11(var_16_0, math.uint64_equal(iter_16_1, 0) and 0 or self:getEquipBySid(iter_16_1))
	end

	return var_16_0
end

function EquipmentData:isEquipWearedSuitByBaseId(arg_17_1, arg_17_2)
	local var_17_0 = self:getEquipSuitByKnightPos(arg_17_2)

	for iter_17_0 = 1, #var_17_0 do
		if type(var_17_0[iter_17_0]) ~= "number" and var_17_0[iter_17_0].getCfg and math.uint64_equal(var_17_0[iter_17_0]:getCfg().id, arg_17_1) then
			return true
		end
	end

	return false
end

function EquipmentData:getSuitByKnightPos(arg_18_1)
	local var_18_0 = self:getEquipSuitByKnightPos(arg_18_1)
	local var_18_1 = {}
	local var_18_2 = {}

	for iter_18_0 = 1, #var_18_0 do
		if type(var_18_0[iter_18_0]) ~= "number" and var_18_0[iter_18_0].getCfg then
			table.insert(var_18_1, var_18_0[iter_18_0]:getCfg().suit_id)
		end
	end

	for iter_18_1 = 1, #var_18_1 do
		var_18_2[var_18_1[iter_18_1]] = var_18_2[var_18_1[iter_18_1]] and var_18_2[var_18_1[iter_18_1]] + 1 or 1
	end

	return var_18_2
end

function EquipmentData:getEquipMasterDataByKnightIdx(arg_19_1)
	local var_19_0 = {
		[var_0_13.ETConst.MASTER_TYPE.EQUIP_LEVEL] = {},
		[var_0_13.ETConst.MASTER_TYPE.EQUIP_REFINE] = {},
		[var_0_13.ETConst.MASTER_TYPE.EQUIP_RESONANCE] = {}
	}
	local var_19_1 = self:getEquipSuitByKnightPos(arg_19_1)

	for iter_19_0 = 1, #var_19_1 do
		if type(var_19_1[iter_19_0]) ~= "number" and var_19_1[iter_19_0].getCfg then
			local var_19_2 = var_19_1[iter_19_0]:getServerData()

			table.insert(var_19_0[var_0_13.ETConst.MASTER_TYPE.EQUIP_LEVEL], var_19_2.level)
			table.insert(var_19_0[var_0_13.ETConst.MASTER_TYPE.EQUIP_REFINE], var_19_2.refining_level)
			table.insert(var_19_0[var_0_13.ETConst.MASTER_TYPE.EQUIP_RESONANCE], var_19_2.resonance_level)
		end
	end

	return var_19_0
end

function EquipmentData:isActiveMaster(arg_20_1)
	local var_20_0 = self:getEquipSuitByKnightPos(arg_20_1)

	for iter_20_0 = 1, #var_20_0 do
		if type(var_20_0[iter_20_0]) == "number" then
			return false
		elseif not var_20_0[iter_20_0].getCfg then
			return false
		end
	end

	return true
end

function EquipmentData:isCanWearEquipByType(arg_21_1)
	for iter_21_0 = 1, #self._equipList do
		if self._equipList[iter_21_0]:getCfg().type == arg_21_1 and self._equipList[iter_21_0]:getServerData().position == 0 then
			return true
		end
	end

	return false
end

function EquipmentData:isActiveAssct(arg_22_1, arg_22_2)
	if arg_22_2 == 0 then
		return false
	end

	local var_22_0 = self:getEquipSuitByKnightPos(arg_22_2)

	for iter_22_0 = 1, #var_22_0 do
		if type(var_22_0[iter_22_0]) ~= "number" and var_22_0[iter_22_0].getCfg and arg_22_1 == var_22_0[iter_22_0]:getCfg().advance_id then
			return true, var_22_0[iter_22_0]:getServerData().id
		end
	end

	return false
end

function EquipmentData:isHasSellEquipOrFrag(arg_23_1)
	if arg_23_1 == EquipmentData.TYPE_EQUIP then
		for iter_23_0, iter_23_1 in ipairs(self:getEquipList().noWearIndex) do
			if iter_23_1:getCfg().is_sell == 1 and not iter_23_1:isDeveloped() then
				return true
			end
		end
	elseif arg_23_1 == EquipmentData.TYPE_EQUIP_FRAG then
		for iter_23_2, iter_23_3 in ipairs((g.core.model.User.fragmentsData:getSpFragmentList(g.core.common.Goods.FRAGMENT.TYPE_EQUIP, {
			quality = 0,
			type = 0
		}))) do
			if g.core.config.fragment_info.get(iter_23_3.id).is_sell == 1 then
				return true
			end
		end
	end

	return false
end

function EquipmentData:getAllKnightsByEquipId()
	local var_24_0 = g.core.model.User.knightsData:getFormationKnights()
	local var_24_1 = {}
	local var_24_2 = {}

	for iter_24_0, iter_24_1 in ipairs(self:getEquipList().allIndex) do
		local var_24_3 = iter_24_1:getPosition()
		local var_24_4 = math.ceil(var_24_3 / 4)
		local var_24_5 = var_24_0[var_24_4] or 0

		if var_24_3 ~= 0 and not math.uint64_lt(var_24_5, 0, true) then
			local var_24_6 = g.core.model.User.knightsData:getKnight({
				id = var_24_5
			})

			var_24_2[var_24_5] = var_24_2[var_24_5] or {
				index = var_24_4,
				knight = var_24_6,
				equip = {}
			}

			table.insert(var_24_2[var_24_5].equip, iter_24_1)
		end
	end

	for iter_24_2, iter_24_3 in pairs(var_24_2) do
		table.insert(var_24_1, iter_24_3)
	end

	table.sort(var_24_1, function(arg_25_0, arg_25_1)
		if arg_25_0.index ~= arg_25_1.index then
			return arg_25_0.index > arg_25_1.index
		end
	end)

	return var_24_1
end

function EquipmentData:getIndexByEquipId(arg_26_1, arg_26_2)
	for iter_26_0, iter_26_1 in ipairs(arg_26_2) do
		for iter_26_2, iter_26_3 in ipairs(iter_26_1.equip) do
			if math.uint64_equal(iter_26_3:getServerData().id, arg_26_1) then
				return iter_26_0
			end
		end
	end

	return 1
end

function EquipmentData:getBagLimit()
	return g.core.config.role_info.get(g.core.model.User:getLevel()).equipment_bag_num_client
end

function EquipmentData:isCanActiveAssc(arg_28_1, arg_28_2)
	local var_28_0 = 0

	if arg_28_1 and not math.uint64_lt(arg_28_1, 0, true) then
		local var_28_1 = g.core.model.User.knightsData:getKnight({
			id = arg_28_1
		})

		if var_28_1 then
			local var_28_2 = var_28_1:getBaseInfo()

			for iter_28_0 = 1, var_0_13.KNIGHT_CONST.ASSCT_MAX do
				if var_28_2["association_" .. iter_28_0] > 0 then
					local var_28_3 = g.core.config.knight_association_info.get(var_28_2["association_" .. iter_28_0])

					if var_28_3 and var_28_3.value_1 == arg_28_2 then
						var_28_0 = var_28_0 + 1
					end
				end
			end
		end
	end

	return var_28_0 > 0, var_28_0
end

function EquipmentData:hasEquipByAdvId(arg_29_1)
	for iter_29_0, iter_29_1 in pairs(self._equipMap) do
		if iter_29_1:getCfg().advance_id == arg_29_1 then
			return true
		end
	end

	return false
end

function EquipmentData:getIdleEquipment(arg_30_1)
	local var_30_0 = {}

	for iter_30_0 = 1, #self._equipList do
		if self._equipList[iter_30_0]:getCfg().type == arg_30_1 and self._equipList[iter_30_0]:getServerData().position == 0 then
			table.insert(var_30_0, self._equipList[iter_30_0])
		end
	end

	return var_30_0
end

function EquipmentData:getMaxPotentialIdleEquip(arg_31_1)
	local var_31_0 = self:getIdleEquipment(arg_31_1)
	local var_31_1 = 0

	for iter_31_0 = 1, #var_31_0 do
		local var_31_2 = var_31_0[iter_31_0]:getCfg()

		if var_31_1 < var_31_2.potential then
			var_31_1 = var_31_2.potential
		end
	end

	return var_31_1
end

function EquipmentData:getEquipSuitByEquipPos(arg_32_1)
	local var_32_0 = {}

	if arg_32_1 == 0 or arg_32_1 == nil then
		return var_32_0
	end

	local var_32_1 = math.ceil(arg_32_1 / 4)

	for iter_32_0 = 1, 4 do
		local var_32_2 = self:getEquipDataByPos((var_32_1 - 1) * 4 + iter_32_0)

		if var_32_2 then
			table.insert(var_32_0, var_32_2)
		end
	end

	return var_32_0
end

function EquipmentData:setLazy(arg_33_1)
	self._lazy = arg_33_1
end

function EquipmentData:isLazy()
	return self._lazy
end

function EquipmentData:getGlyphSuitInfoByLevel(arg_35_1, arg_35_2)
	local var_35_0 = {}

	arg_35_2 = arg_35_2 or 1

	for iter_35_0, iter_35_1 in g.core.config.glyph_suit_info.ipairs() do
		if iter_35_1.type == arg_35_2 and iter_35_1.level == arg_35_1 then
			var_35_0[iter_35_1.suit_num] = iter_35_1
		end
	end

	return var_35_0
end

function EquipmentData:isPrompted()
	return self._isPrompted
end

function EquipmentData:setIsPrompted(arg_37_1)
	self._isPrompted = arg_37_1
end

function EquipmentData:getIsHideWearEquip()
	return self._isHideWear
end

function EquipmentData:setHideWearEquip(arg_39_1)
	self._isHideWear = arg_39_1
end

function EquipmentData:getUpTypeIconByName(arg_40_1)
	for iter_40_0, iter_40_1 in pairs(self._upType) do
		if iter_40_1.name == arg_40_1 then
			return iter_40_1.iconUrl
		end
	end

	return ""
end

function EquipmentData:isHasGoldEquip()
	for iter_41_0, iter_41_1 in ipairs(self._equipList) do
		if iter_41_1:getCfg().quality == var_0_13.QUALITY_TYPE.GOLD then
			return true
		end
	end

	return false
end

function EquipmentData:isHaveEquipSuitByKnightIndex(arg_42_1)
	arg_42_1 = arg_42_1 or 0

	for iter_42_0 = 1, 4 do
		local var_42_0 = self:getEquipBySid((self:getEquipIdByPos((arg_42_1 - 1) * 4 + iter_42_0)))

		if var_42_0 then
			local var_42_1 = var_42_0:getCfg()

			if var_42_1 and var_42_1.suit_id and var_42_1.suit_id > 0 then
				return true
			end
		end
	end

	return false
end

function EquipmentData:getEquipDataByKnightIndex(arg_43_1, arg_43_2)
	arg_43_1 = arg_43_1 or 0
	arg_43_2 = arg_43_2 or 0

	for iter_43_0 = 1, 4 do
		local var_43_0 = self:getEquipBySid((self:getEquipIdByPos((arg_43_1 - 1) * 4 + iter_43_0)))

		if var_43_0 and arg_43_2 ~= 0 and var_43_0:getCfg().type == arg_43_2 then
			return var_43_0
		end
	end

	return nil
end

function EquipmentData:isKnightHasEquip(arg_44_1)
	arg_44_1 = arg_44_1 or 0

	for iter_44_0 = 1, 4 do
		for iter_44_1 = 1, 4 do
			local var_44_0 = self:getEquipBySid((self:getEquipIdByPos((arg_44_1 - 1) * 4 + iter_44_1)))

			if var_44_0 and iter_44_0 ~= 0 and var_44_0:getCfg().type == iter_44_0 then
				return false
			end
		end
	end

	for iter_44_2 = 1, 4 do
		if self:isCanWearEquipByType(iter_44_2) then
			return true, iter_44_2
		end
	end

	return false
end

function EquipmentData:getMasterByKnightId(arg_45_1)
	local var_45_0 = g.core.model.User.knightsData:getFormationKnights()

	for iter_45_0 = 1, var_0_13.KNIGHT_CONST.LINEUP_MAX do
		if var_45_0[iter_45_0] == arg_45_1 then
			local var_45_1 = g.core.model.User.formationData:getNewEquipMasterData(iter_45_0)
			local var_45_2 = g.core.model.User.formationData:getNewTreasMasterData(iter_45_0)

			for iter_45_1, iter_45_2 in pairs(var_0_13.ETConst.MASTER_TYPE) do
				local var_45_3 = var_45_1[iter_45_2] or var_45_2[iter_45_2]

				if var_45_3 then
					return {
						bLevel = var_45_3.bLevel,
						aLevel = var_45_3.aLevel,
						type = iter_45_2
					}
				end
			end

			break
		end
	end

	return nil
end

function EquipmentData:getEquipMaxGlyGroupNum(arg_46_1, arg_46_2)
	local var_46_0 = {}
	local var_46_1 = arg_46_1 or 1

	for iter_46_0 = 1, g.core.config.glyph_info.getLength() do
		local var_46_2 = g.core.config.glyph_info.indexOf(iter_46_0)

		if var_46_2.type == var_46_1 and arg_46_2 == var_46_2.id and var_46_2.level ~= 0 and not var_46_0[var_46_2.level] then
			var_46_0[var_46_2.level] = var_46_2.level
		end
	end

	return table.nums(var_46_0)
end

function EquipmentData:getEquipMaxGlyGroupCfg(arg_47_1, arg_47_2)
	local var_47_0
	local var_47_1 = arg_47_1 or 1
	local var_47_2 = 0

	for iter_47_0 = 1, g.core.config.glyph_info.getLength() do
		local var_47_3 = g.core.config.glyph_info.indexOf(iter_47_0)

		if var_47_3.type == var_47_1 and arg_47_2 == var_47_3.id and var_47_3.level ~= 0 and var_47_2 < var_47_3.level then
			var_47_2 = var_47_3.level
			var_47_0 = var_47_3
		end
	end

	return var_47_0
end

function EquipmentData:getEquipMaxStrengthAttr(arg_48_1)
	return {
		{
			type = arg_48_1.info.strength_type,
			value = arg_48_1.info.strength_value + (g.core.model.User:getMaxLevel() * 2 - 1) * arg_48_1.info.strength_growth
		}
	}
end

function EquipmentData:getEquipMaxRefineAttr(arg_49_1)
	local var_49_0 = {}

	for iter_49_0 = 1, 2 do
		if arg_49_1.info["refining_growth_" .. iter_49_0] ~= 0 then
			table.insert(var_49_0, {
				type = arg_49_1.info["refining_type_" .. iter_49_0],
				value = arg_49_1.info["refining_growth_" .. iter_49_0] * arg_49_1.info.refine_level
			})
		end
	end

	var_49_0.max_level = arg_49_1.info.refine_level

	return var_49_0
end

function EquipmentData:getEquipMaxGlyAttr(arg_50_1)
	local var_50_0 = self:getEquipMaxGlyGroupCfg(1, arg_50_1.info.equipment_glyph)
	local var_50_1 = {}

	for iter_50_0 = 1, 2 do
		if var_50_0["affect_value" .. iter_50_0] ~= 0 then
			table.insert(var_50_1, {
				type = var_50_0["affect_type" .. iter_50_0],
				value = var_50_0["affect_value" .. iter_50_0]
			})
		end
	end

	return var_50_1
end

function EquipmentData:getEquipStrengthShortCutLevel()
	local var_51_0 = 0
	local var_51_1 = {}
	local var_51_2 = g.core.model.User.knightsData:getLineUpList()

	for iter_51_0 = 1, #var_51_2 do
		local var_51_3 = self:getEquipSuitByKnightPos(var_51_2[iter_51_0]:getFormationPos())

		if var_51_2[iter_51_0] and #var_51_3 > 0 then
			local var_51_4 = 0

			for iter_51_1 = 1, #var_51_3 do
				if type(var_51_3[iter_51_1]) ~= "number" and var_51_3[iter_51_1].getCfg then
					var_51_4 = var_51_4 + var_51_3[iter_51_1]:getServerData().level
				end
			end

			table.insert(var_51_1, var_51_4 / #var_51_3)
		end

		table.sort(var_51_1, function(arg_52_0, arg_52_1)
			if arg_52_0 ~= arg_52_1 then
				return arg_52_1 < arg_52_0
			end
		end)
	end

	if #var_51_1 > 0 then
		var_51_0 = math.floor(var_51_1[1])

		if var_51_0 > 0 then
			var_51_0 = var_51_0 - var_51_0 % 10 - 20
		end
	end

	return var_51_0
end

function EquipmentData:getEquipRefineShortCutLevel()
	local var_53_0 = 0
	local var_53_1 = {}
	local var_53_2 = g.core.model.User.knightsData:getLineUpList()

	for iter_53_0 = 1, #var_53_2 do
		local var_53_3 = self:getEquipSuitByKnightPos(var_53_2[iter_53_0]:getFormationPos())

		if var_53_2[iter_53_0] and #var_53_3 > 0 then
			local var_53_4 = 0

			for iter_53_1 = 1, #var_53_3 do
				if type(var_53_3[iter_53_1]) ~= "number" and var_53_3[iter_53_1].getCfg then
					var_53_4 = var_53_4 + var_53_3[iter_53_1]:getServerData().refining_level
				end
			end

			table.insert(var_53_1, var_53_4 / #var_53_3)
		end

		table.sort(var_53_1, function(arg_54_0, arg_54_1)
			if arg_54_0 ~= arg_54_1 then
				return arg_54_1 < arg_54_0
			end
		end)
	end

	if #var_53_1 > 0 then
		var_53_0 = math.floor(var_53_1[1])

		if var_53_0 > 0 then
			var_53_0 = var_53_0 - var_53_0 % 10 - 20
		end
	end

	return math.min(var_53_0, 5)
end

function EquipmentData:checkWearEquipByType(arg_55_1)
	local var_55_0 = arg_55_1.index or 1
	local var_55_1 = arg_55_1.type

	if arg_55_1.type then
		if not self:isWornEquip((var_55_0 - 1) * 4 + var_55_1) then
			return (self:isCanWearEquipByType(var_55_1))
		else
			return false
		end
	else
		local var_55_2 = g.core.model.User.knightsData:getFormationKnights()

		if var_55_2[var_55_0] == nil or var_55_2[var_55_0] == 0 then
			return false
		end

		for iter_55_0 = 1, 4 do
			if not self:isWornEquip((var_55_0 - 1) * 4 + iter_55_0) and self:isCanWearEquipByType(iter_55_0) then
				return true
			end
		end

		return false
	end
end

function EquipmentData:checkChangeEquipByType(arg_56_1)
	local var_56_0 = arg_56_1.index

	local function var_56_1(arg_57_0, arg_57_1)
		local var_57_0

		if not arg_57_1 or not arg_57_1 then
			::label_57_0::

			var_57_0 = var_56_0 or 1
		end

		local var_57_1 = self:getEquipDataByPos((var_57_0 - 1) * 4 + arg_57_0)

		if var_57_1 then
			return self:getMaxPotentialIdleEquip(arg_57_0) > var_57_1:getCfg().potential
		end

		return false
	end

	if arg_56_1.type then
		return var_56_1(arg_56_1.type)
	elseif arg_56_1.index then
		for iter_56_0 = 1, 4 do
			if var_56_1(iter_56_0) then
				return true
			end
		end
	else
		local var_56_2 = g.core.model.User.knightsData:getFormationKnights()

		for iter_56_1 = 1, 6 do
			if var_56_2[iter_56_1] and var_56_2[iter_56_1] ~= 0 then
				for iter_56_2 = 1, 4 do
					if var_56_1(iter_56_2, iter_56_1) then
						return true
					end
				end
			end
		end
	end
end

function EquipmentData:checkEquipGlyph(arg_58_1)
	if not arg_58_1.id or arg_58_1.id and math.uint64_equal(arg_58_1.id, 0) then
		return false
	end

	local var_58_0 = self:getEquipBySid(arg_58_1.id)

	if var_58_0 == nil then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_13.FUNCTION_TYPE.EQUIP_GLYPH) then
		return false
	end

	if var_58_0:getPosition() <= 0 or var_58_0:isInitEquipment() then
		return false
	end

	local var_58_1 = var_58_0:getServerData()
	local var_58_2 = g.core.config.glyph_info.get(g.core.config.equipment_info.get(var_58_1.base_id).equipment_glyph, var_58_1.glyph_level)

	if var_58_2.next_level == 0 then
		return false
	end

	if var_58_2.cost_type1 > 0 and g.core.model.User.bagData:getCountById(var_58_2.cost_type1, var_58_2.cost_value1) < var_58_2.cost_num1 then
		return false
	end

	if var_58_2.cost_type2 > 0 and g.core.model.User.bagData:getCountById(var_58_2.cost_type2, var_58_2.cost_value2) < var_58_2.cost_num2 then
		return false
	end

	return true
end

function EquipmentData:checkEquipStrength(arg_59_1)
	if not arg_59_1.id or arg_59_1.id and math.uint64_equal(arg_59_1.id, 0) then
		return false
	end

	local var_59_0 = self:getEquipBySid(arg_59_1.id)

	if var_59_0 == nil then
		return false
	end

	local var_59_1 = var_59_0:getServerData()
	local var_59_2 = g.core.config.equipment_info.get(var_59_1.base_id)

	if var_59_0:getPosition() <= 0 or var_59_0:isInitEquipment() then
		return false
	end

	if var_59_1.level >= g.core.model.User:getLevel() * 2 then
		return false
	end

	local var_59_3 = var_0_1.match(function(arg_60_0)
		return arg_60_0.type == 1
	end)
	local var_59_4 = 0

	for iter_59_0 = 1, #var_59_3 do
		if var_59_1.level < var_59_3[iter_59_0].value then
			var_59_4 = var_59_3[iter_59_0].value

			break
		end
	end

	if var_59_4 > 0 then
		local var_59_5 = 0

		for iter_59_1 = var_59_1.level, var_59_4 do
			var_59_5 = var_59_5 + var_59_2.money_1 * iter_59_1^1.6 + var_59_2.money_2 * iter_59_1
		end

		if var_59_5 <= g.core.model.User.resourceData:getCoin() then
			return true
		end
	end

	return false
end

function EquipmentData:checkEquipRefine(arg_61_1)
	if not arg_61_1.id or arg_61_1.id and math.uint64_equal(arg_61_1.id, 0) then
		return false
	end

	local var_61_0 = self:getEquipBySid(arg_61_1.id)

	if var_61_0 == nil then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_13.FUNCTION_TYPE.EQUIP_REFINE) then
		return false
	end

	local var_61_1 = var_61_0:getServerData()

	if var_61_0:getPosition() <= 0 or var_61_0:isInitEquipment() then
		return false
	end

	local var_61_2 = g.core.config.equipment_info.get(var_61_1.base_id)

	if var_61_1.refining_level >= var_61_2.refine_level then
		return false
	end

	local var_61_3 = 0

	for iter_61_0, iter_61_1 in ipairs((g.core.config.item_info.match(function(arg_62_0)
		return arg_62_0.item_type == 10
	end))) do
		local var_61_4 = g.core.model.User.itemsData:getItemNumById(iter_61_1.id)

		if var_61_4 > 0 then
			var_61_3 = var_61_3 + var_61_4 * iter_61_1.item_value
		end
	end

	local var_61_5 = var_0_1.match(function(arg_63_0)
		return arg_63_0.type == 2
	end)
	local var_61_6 = 0

	for iter_61_2 = 1, #var_61_5 do
		if var_61_1.refining_level < var_61_5[iter_61_2].value then
			var_61_6 = var_61_5[iter_61_2].value

			break
		end
	end

	if var_61_1.refining_level >= self:getTotalEquipRefineLvLimitLv((self:getTotalEquipRefineLv())) then
		var_61_6 = 0
	end

	if var_61_6 > 0 and (var_61_1.refining_level + (var_61_6 - var_61_1.refining_level))^1.8 / 10 * var_61_2.refining_exp_1 + var_61_1.refining_level * var_61_2.refining_exp_2 <= var_61_3 + var_61_1.refining_exp then
		return true
	end

	return false
end

function EquipmentData:checkEquipMagical(arg_64_1)
	if not arg_64_1.id or arg_64_1.id and math.uint64_equal(arg_64_1.id, 0) then
		return false
	end

	local var_64_0 = self:getEquipBySid(arg_64_1.id)

	if var_64_0 == nil then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_13.FUNCTION_TYPE.EQUIP_MAGICAL) then
		return false
	end

	return var_64_0:canMagicalStageUp()
end

function EquipmentData:getLineUpEquipList()
	local var_65_0 = {}

	for iter_65_0, iter_65_1 in ipairs(self._equipList) do
		if iter_65_1:getPosition() > 0 then
			table.insert(var_65_0, iter_65_1)
		end
	end

	return var_65_0
end

function EquipmentData:getEquipResonanceMaterials(arg_66_1)
	return (var_0_4.match(function(arg_67_0)
		return arg_67_0.id == arg_66_1
	end))
end

function EquipmentData:getEquipResonanceInfos(arg_68_1)
	local var_68_0 = var_0_2.get(arg_68_1).resonance_id

	if var_68_0 == 0 then
		return nil
	end

	return (var_0_3.match(function(arg_69_0)
		return arg_69_0.id == var_68_0
	end))
end

function EquipmentData:getMaxResonanceInfo(arg_70_1)
	local var_70_0 = self:getEquipResonanceInfos(arg_70_1)

	if not var_70_0 then
		return nil
	end

	local var_70_1

	for iter_70_0, iter_70_1 in ipairs(var_70_0) do
		if not var_70_1 then
			var_70_1 = iter_70_1
		elseif var_70_1.level < iter_70_1.level then
			var_70_1 = iter_70_1
		end
	end

	return var_70_1
end

function EquipmentData:getAllResonanceAttr(arg_71_1)
	local var_71_0 = {}

	if var_0_2.get(arg_71_1).resonance_id == 0 then
		return var_71_0
	end

	for iter_71_0, iter_71_1 in ipairs((self:getEquipResonanceInfos(arg_71_1))) do
		for iter_71_2, iter_71_3, iter_71_4 in iter_71_1.gmatch({
			"advance_affect_type%d+",
			"advance_affect_value%d+"
		}) do
			if iter_71_4[1] > 0 then
				if var_71_0[iter_71_4[1]] then
					var_71_0[iter_71_4[1]].value = var_71_0[iter_71_4[1]].value + iter_71_4[2]
				else
					var_71_0[iter_71_4[1]] = {
						type = iter_71_4[1],
						value = iter_71_4[2]
					}
				end
			end
		end
	end

	local var_71_1 = table.values(var_71_0)

	table.sort(var_71_1, function(arg_72_0, arg_72_1)
		return arg_72_0.type < arg_72_1.type
	end)

	return var_71_1
end

function EquipmentData:checkEquipResonance(arg_73_1)
	if arg_73_1.id then
		return self:checkEquipResonanceById(arg_73_1.id)
	end

	if arg_73_1.index then
		local var_73_0 = self:getEquipSuitByKnightPos(arg_73_1.index)

		for iter_73_0 = 1, #var_73_0 do
			if type(var_73_0[iter_73_0]) ~= "number" and var_73_0[iter_73_0].getCfg and self:checkEquipResonanceById(var_73_0[iter_73_0]:getServerData().id) then
				return true
			end
		end
	end

	return false
end

function EquipmentData:checkRealEquipResonance(arg_74_1)
	if arg_74_1.id then
		return self:checkRealEquipResonanceById(arg_74_1.id)
	end

	if arg_74_1.index then
		local var_74_0 = self:getEquipSuitByKnightPos(arg_74_1.index)

		for iter_74_0 = 1, #var_74_0 do
			if type(var_74_0[iter_74_0]) ~= "number" and var_74_0[iter_74_0].getCfg and self:checkRealEquipResonanceById(var_74_0[iter_74_0]:getServerData().id) then
				return true
			end
		end
	end

	return false
end

function EquipmentData:checkEquipResonanceById(arg_75_1)
	if not arg_75_1 or math.uint64_equal(arg_75_1, 0) then
		return false
	end

	local var_75_0 = self:getEquipBySid(arg_75_1)

	if var_75_0 == nil then
		return false
	end

	if not var_75_0:hasResonance() then
		return false
	end

	local var_75_1, var_75_2 = var_75_0:getNextResonanceInfo()
	local var_75_3

	if var_75_2 then
		do return false end

		var_75_3 = false
	end

	for iter_75_0, iter_75_1 in ipairs((self:getEquipResonanceMaterials(var_0_3.get(var_75_0:getCfg().resonance_id, var_75_0:getResonanceLevel() + 1).cost))) do
		if var_0_9:getOwnNum(iter_75_1.cost_type, iter_75_1.cost_value) > 0 then
			var_75_3 = true

			break
		end
	end

	return var_75_3
end

function EquipmentData:checkRealEquipResonanceById(arg_76_1)
	if not arg_76_1 or math.uint64_equal(arg_76_1, 0) then
		return false
	end

	local var_76_0 = self:getEquipBySid(arg_76_1)

	if var_76_0 == nil then
		return false
	end

	if not var_76_0:hasResonance() then
		return false
	end

	local var_76_1, var_76_2 = var_76_0:getNextResonanceInfo()
	local var_76_3, var_76_4, var_76_5, var_76_6

	if var_76_2 then
		do return false end

		var_76_3 = false
		var_76_4 = {}
		var_76_5 = 0
		var_76_6 = var_76_0:getCfg().type
	end

	for iter_76_0, iter_76_1 in ipairs((self:getEquipResonanceMaterials(var_0_3.get(var_76_0:getCfg().resonance_id, var_76_0:getResonanceLevel() + 1).cost))) do
		local var_76_7 = var_0_9:getOwnNum(iter_76_1.cost_type, iter_76_1.cost_value)
		local var_76_9

		if var_76_7 > 0 and iter_76_1.cost_type == g.core.common.Goods.TYPE_FRAGMENT then
			local var_76_8 = g.core.config.fragment_info.get(iter_76_1.cost_value)

			if var_76_7 >= var_76_8.combine_num and var_76_5 < var_76_8.quality then
				if 0 > 0 then
					var_76_4[#var_76_4 + 1] = 0
				end

				var_76_5 = var_76_8.quality
				var_76_9 = var_76_7
			else
				var_76_4[#var_76_4 + 1] = var_76_7
			end
		end
	end

	if #var_76_4 > 0 then
		var_76_3 = true
	elseif var_76_5 > 0 then
		local var_76_10 = {}

		for iter_76_2, iter_76_3 in ipairs((self:getLineUpEquipList())) do
			if iter_76_3:getCfg().type == var_76_6 then
				var_76_10[#var_76_10 + 1] = iter_76_3

				if var_76_5 > iter_76_3:getCfg().quality then
					var_76_10 = {}

					break
				end
			end
		end

		if #var_76_10 == g.core.model.User.knightsData:getLineupKnightCount() then
			var_76_3 = true
		end
	end

	return var_76_3
end

function EquipmentData:onS2CEquipInheritFormation(arg_77_1)
	if arg_77_1 and arg_77_1.formation and arg_77_1.formation.equipment_id then
		self:updateEquipmentPos(arg_77_1.formation.equipment_id)

		arg_77_1.tp = 3

		g.core.model.User.formationData:updateAssDataAndSuit(arg_77_1)
	end
end

function EquipmentData:getTotalEquipRefineLv()
	local var_78_0 = 0

	for iter_78_0, iter_78_1 in pairs((self:getEquipMap())) do
		if iter_78_1:getPosition() > 0 and not iter_78_1:isInitEquipment() then
			var_78_0 = var_78_0 + iter_78_1:getServerData().refining_level
		end
	end

	return var_78_0
end

function EquipmentData:getTotalEquipRefineLvLimitLv(arg_79_1)
	local var_79_0

	for iter_79_0 = 1, var_0_5.getLength() do
		local var_79_1 = var_0_5.indexOf(iter_79_0)

		if arg_79_1 < var_79_1.refine_all then
			break
		end

		var_79_0 = var_79_1
	end

	return var_79_0.refine_cap
end

function EquipmentData:getNextTotalEquipRefineLvLimitLv(arg_80_1)
	local var_80_0

	for iter_80_0 = 1, var_0_5.getLength() do
		local var_80_1 = var_0_5.indexOf(iter_80_0)

		var_80_0 = var_80_1

		if arg_80_1 < var_80_1.refine_all then
			break
		end
	end

	return var_80_0.refine_all
end

function EquipmentData:getSuitStageInfoBySuitIdAndStage(arg_81_1, arg_81_2)
	for iter_81_0, iter_81_1 in var_0_6.ipairs() do
		if iter_81_1.suit_id == arg_81_1 and iter_81_1.suit_stage == arg_81_2 then
			return iter_81_1
		end
	end
end

function EquipmentData:getSuitMagicalActiveMap(arg_82_1)
	local var_82_0 = {}

	for iter_82_0 = 1, 4 do
		local var_82_1 = self:getEquipDataByPos((arg_82_1 - 1) * 4 + iter_82_0)

		if var_82_1 then
			table.insert(var_82_0, var_82_1)
		end
	end

	local var_82_2 = {}
	local var_82_3 = {}

	for iter_82_1, iter_82_2 in ipairs(var_82_0) do
		if iter_82_2:hasMagical() then
			local var_82_4 = iter_82_2:getQuality()
			local var_82_5 = iter_82_2:getSuitId()
			local var_82_6 = iter_82_2:getMagicalStage()

			if not var_82_2[var_82_5] then
				var_82_2[var_82_5] = {
					activeNum = 1,
					suitId = var_82_5,
					quality = var_82_4
				}
				var_82_3[var_82_5] = {
					var_82_6
				}
			else
				local var_82_7 = {
					suitId = var_82_5,
					quality = var_82_4
				}

				var_82_7.activeNum = var_82_2[var_82_5].activeNum + 1
				var_82_2[var_82_5] = var_82_7

				table.insert(var_82_3[var_82_5], var_82_6)
			end
		end
	end

	for iter_82_3, iter_82_4 in pairs(var_82_3) do
		table.sort(iter_82_4, function(arg_83_0, arg_83_1)
			return arg_83_0 < arg_83_1
		end)

		if var_82_2[iter_82_3].activeNum >= 4 then
			var_82_2[iter_82_3].minStage = iter_82_4[1] or -1
		end

		if var_82_2[iter_82_3].activeNum >= 2 then
			var_82_2[iter_82_3].maxStage = iter_82_4[#iter_82_4 - 1] or -1
		end

		var_82_2[iter_82_3].stageList = iter_82_4
	end

	return var_82_2
end

function EquipmentData:cacheActiveSuitMap(arg_84_1)
	self._cacheSuitActiveMap = self:getSuitMagicalActiveMap(arg_84_1)
end

function EquipmentData:getCacheActiveSuitMap()
	self._cacheSuitActiveMap = nil

	return self._cacheSuitActiveMap
end

function EquipmentData:getSuitTalentList(arg_86_1, arg_86_2, arg_86_3, arg_86_4)
	local var_86_0 = arg_86_2 == var_0_13.EquipConst.EQUIP_SUIT_TYPE.TWO and "two_suit_talent_" or "four_suit_talent_"
	local var_86_1 = arg_86_2 == var_0_13.EquipConst.EQUIP_SUIT_TYPE.TWO and 2 or 4
	local var_86_2 = {}

	for iter_86_0, iter_86_1 in var_0_6.ipairs() do
		if iter_86_1.suit_id == arg_86_1 then
			local var_86_3 = 1

			while var_0_6.hasKey(var_86_0 .. var_86_3) do
				local var_86_4 = iter_86_1[var_86_0 .. var_86_3]

				if iter_86_1[var_86_0 .. var_86_3] > 0 then
					if not var_86_2[var_86_4] then
						var_86_2[var_86_4] = {
							suitId = arg_86_1,
							talentId = var_86_4,
							isActive = arg_86_3 >= iter_86_1.suit_stage and var_86_1 <= arg_86_4,
							stage = iter_86_1.suit_stage
						}
					elseif var_86_2[var_86_4].stage > iter_86_1.suit_stage then
						var_86_2[var_86_4].stage = iter_86_1.suit_stage
					end
				end

				var_86_3 = var_86_3 + 1
			end
		end
	end

	local var_86_5 = {}

	for iter_86_2, iter_86_3 in pairs(var_86_2) do
		table.insert(var_86_5, iter_86_3)
	end

	table.sort(var_86_5, function(arg_87_0, arg_87_1)
		return arg_87_0.stage < arg_87_1.stage
	end)

	return var_86_5
end

function EquipmentData:getSuitTalentListOfSpecificStage(arg_88_1, arg_88_2, arg_88_3)
	local var_88_1 = arg_88_2 == var_0_13.EquipConst.EQUIP_SUIT_TYPE.TWO and "two_suit_talent_" or "four_suit_talent_"
	local var_88_2 = self:getSuitStageInfoBySuitIdAndStage(arg_88_1, arg_88_3)
	local var_88_3 = {}

	if var_88_2 then
		local var_88_4 = 1

		while var_0_6.hasKey(var_88_1 .. var_88_4) do
			if var_88_2[var_88_1 .. var_88_4] > 0 then
				local var_88_5 = var_0_7.get(var_88_2[var_88_1 .. var_88_4])

				while var_0_7.hasKey("affect_type_" .. 1) do
					if var_88_5["affect_type_" .. 1] > 0 and var_88_5["affect_value_" .. 1] > 0 then
						var_88_3[var_88_5["affect_type_" .. 1]] = var_88_3[var_88_5["affect_type_" .. 1]] or 0
						var_88_3[var_88_5["affect_type_" .. 1]] = var_88_3[var_88_5["affect_type_" .. 1]] + var_88_5["affect_value_" .. 1]
					end
				end
			end

			var_88_4 = var_88_4 + 1
		end
	end

	local var_88_7 = {}

	for iter_88_0, iter_88_1 in pairs(var_88_3) do
		table.insert(var_88_7, {
			type = iter_88_0,
			value = iter_88_1
		})
	end

	return var_88_7
end

function EquipmentData:getFourSuitSkillId(arg_89_1, arg_89_2)
	for iter_89_0, iter_89_1 in var_0_6.ipairs() do
		if iter_89_1.suit_id == arg_89_1 and iter_89_1.suit_stage == arg_89_2 then
			return iter_89_1.four_suit_passive
		end
	end

	return 0
end

function EquipmentData:getFourSuitSkillList(arg_90_1)
	local var_90_0 = {}

	for iter_90_0, iter_90_1 in var_0_6.ipairs() do
		if iter_90_1.suit_id == arg_90_1 and iter_90_1.four_suit_passive > 0 then
			table.insert(var_90_0, {
				isPassive = true,
				skillId = iter_90_1.four_suit_passive,
				stage = iter_90_1.suit_stage
			})
		end
	end

	return var_90_0
end

function EquipmentData:getEquipStageInfo(arg_91_1, arg_91_2)
	for iter_91_0, iter_91_1 in var_0_8.ipairs() do
		if iter_91_1.advance_id == arg_91_1 and iter_91_1.stage == arg_91_2 then
			return iter_91_1
		end
	end
end

function EquipmentData:getMagicalAttrMap(arg_92_1, arg_92_2)
	local var_92_0 = self:getEquipStageInfo(arg_92_1, arg_92_2)
	local var_92_1 = {}

	if var_92_0 then
		while var_0_8.hasKey("attr_type_" .. 1) do
			if var_92_0["attr_type_" .. 1] > 0 and var_92_0["attr_value_" .. 1] > 0 then
				var_92_1[var_92_0["attr_type_" .. 1]] = var_92_0["attr_value_" .. 1]
			end
		end
	end

	return var_92_1
end

function EquipmentData:onS2CEquipmentMagicalStageUp(arg_93_1)
	self:getEquipBySid(arg_93_1.id):setMagicalStage(arg_93_1.target_stage)
end

return EquipmentData
