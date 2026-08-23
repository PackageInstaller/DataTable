local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.const.ConstMgr.EquipConst
local EquipmentStruct = class("EquipmentStruct")
local var_0_3 = table.insert
local var_0_4 = g.core.config.glyph_info
local var_0_5 = g.core.config.equipment_resonance_info
local var_0_6 = g.core.config.equipment_stage_info

function EquipmentStruct:ctor(arg_1_1)
	self._sId = arg_1_1
	self._serverData = {}
	self._cfg = {}
	self._glyphInfo = {}
end

function EquipmentStruct:setServerData(arg_2_1)
	self._serverData = arg_2_1

	self:_updateGlyphInfo()
	self:_updateResonanceInfo()
	self:_updateMagicalInfo()
end

function EquipmentStruct:setCfg(arg_3_1)
	self._cfg = arg_3_1
end

function EquipmentStruct:getServerData()
	return self._serverData
end

function EquipmentStruct:getCfg()
	return self._cfg
end

function EquipmentStruct:getPosition()
	if self._serverData then
		return self._serverData.position
	end

	return 0
end

function EquipmentStruct:isInitEquipment()
	if self._serverData then
		if self._serverData.position > 0 then
			local var_7_0 = math.ceil(self._serverData.position / 4)
			local var_7_1 = g.core.model.User.knightsData:getFormationKnights()

			if var_7_1[var_7_0] and var_7_1[var_7_0] > 0 then
				return false
			else
				return true
			end
		else
			return false
		end
	end

	return false
end

function EquipmentStruct:updatePosition(arg_8_1)
	if self._serverData then
		self._serverData.position = arg_8_1
	end
end

function EquipmentStruct:isDeveloped()
	if self._serverData.level > 1 then
		return true
	end

	if self._serverData.refining_level > 0 then
		return true
	end

	if self._serverData.refining_exp > 0 then
		return true
	end

	if self:getResonanceLevel() > 0 or self:getResonanceExp() > 0 then
		return true
	end

	return false
end

function EquipmentStruct:getEquipAttr()
	local var_10_1 = self._cfg.strength_value + self._cfg.strength_growth * (self._serverData.level - 1)
	local var_10_2 = self._cfg.refining_value_1 + self._cfg.refining_growth_1 * self._serverData.refining_level
	local var_10_3 = self._cfg.refining_value_2 + self._cfg.refining_growth_2 * self._serverData.refining_level
	local var_10_4 = self._cfg.strength_type
	local var_10_5 = self._cfg.strength_type == self._cfg.refining_type_1 and self._cfg.refining_type_2 or self._cfg.refining_type_1
	local var_10_6

	if self._cfg.strength_type == self._cfg.refining_type_1 then
		var_10_6 = var_10_1 + var_10_2 or var_10_1 + var_10_3
	end

	local var_10_7 = self._cfg.strength_type == self._cfg.refining_type_1 and var_10_3 or var_10_2
	local var_10_8 = {}

	table.insert(var_10_8, {
		name = var_10_4,
		value = var_10_6
	})
	table.insert(var_10_8, {
		name = var_10_5,
		value = var_10_7
	})

	return var_10_8
end

function EquipmentStruct:getEquipAttrAll(arg_11_1, arg_11_2)
	arg_11_1 = arg_11_1 or self._serverData.level
	arg_11_2 = arg_11_2 or self._serverData.refining_level or 0

	local var_11_0 = self._cfg
	local var_11_1 = {}

	for iter_11_0 = 1, 10 do
		if var_11_0["talent_skill_" .. iter_11_0] ~= 0 then
			local var_11_2 = g.core.config.talent_skill_info.get(var_11_0["talent_skill_" .. iter_11_0])

			var_0_3(var_11_1, {
				info = var_11_2,
				open = arg_11_2 >= var_11_2.open_value
			})
		end
	end

	return {
		level = arg_11_1,
		{
			attr = self._cfg.strength_type,
			value = self._cfg.strength_value + self._cfg.strength_growth * (arg_11_1 - 1)
		}
	}, {
		level = arg_11_2,
		{
			attr = self._cfg.refining_type_1,
			value = self._cfg.refining_value_1 + self._cfg.refining_growth_1 * arg_11_2
		},
		{
			attr = self._cfg.refining_type_2,
			value = self._cfg.refining_value_2 + self._cfg.refining_growth_2 * arg_11_2
		}
	}, var_11_1
end

function EquipmentStruct:getEquipNextAttrAll()
	return self:getEquipAttrAll(self._serverData.level + 1, (self._serverData.refining_level or nil) and (self._serverData.refining_level + 1 or 1))
end

function EquipmentStruct:getOwner()
	local var_13_0

	if not self._serverData or self._serverData.position == 0 then
		do return end

		var_13_0 = {}
	end

	var_13_0.pos = math.ceil(self._serverData.position / 4)

	return g.core.model.User.knightsData:getKnight(var_13_0)
end

function EquipmentStruct:getOnceStrengthCost(arg_14_1)
	arg_14_1 = arg_14_1 or self:getServerData().level

	local var_14_0 = self:getCfg()

	return var_14_0.money_1 * arg_14_1^1.6 + var_14_0.money_2 * arg_14_1
end

function EquipmentStruct:getFiveStrengthCost(arg_15_1)
	arg_15_1 = arg_15_1 or self:getServerData().level

	local var_15_0 = 0

	for iter_15_0 = 1, 5 do
		var_15_0 = var_15_0 + self:getOnceStrengthCost(arg_15_1 + iter_15_0 - 1)
	end

	return var_15_0
end

function EquipmentStruct:getKnightPos()
	local var_16_0 = self:getPosition()

	if var_16_0 == 0 then
		return 0
	else
		return (math.ceil(var_16_0 / 4))
	end
end

function EquipmentStruct:_updateGlyphInfo()
	self._glyphInfo = var_0_4.get(self._cfg.equipment_glyph, self._serverData.glyph_level)
end

function EquipmentStruct:getGlyphInfo()
	return self._glyphInfo
end

function EquipmentStruct:getPreGlyphInfo()
	for iter_19_0, iter_19_1 in g.core.config.glyph_info.ipairs() do
		if iter_19_1.id == self._glyphInfo.id and iter_19_1.next_level == self._glyphInfo.level then
			return iter_19_1
		end
	end
end

function EquipmentStruct:isMaxGlyph()
	return self._glyphInfo.next_level == 0
end

function EquipmentStruct:getSuitInfo(arg_21_1)
	arg_21_1 = arg_21_1 or 2

	for iter_21_0, iter_21_1 in g.core.config.glyph_suit_info.ipairs() do
		if iter_21_1.type == self._glyphInfo.type and iter_21_1.level == ((self._glyphInfo.level > 0 or nil) and (self._glyphInfo.level or 1)) and iter_21_1.suit_num == arg_21_1 then
			return iter_21_1
		end
	end
end

function EquipmentStruct:getCastingID()
	return self._cfg.casting_id
end

function EquipmentStruct:isHasCast()
	return self._cfg.casting_id ~= 0
end

function EquipmentStruct:getCastLevel()
	local var_24_0 = self._serverData.castLevel or 1

	var_24_0 = var_24_0 == 0 and 1 or var_24_0

	return var_24_0
end

function EquipmentStruct:getCastExp()
	return self._serverData.castExp or 0
end

function EquipmentStruct:getCurPhase()
	if not self:isHasCast() then
		return 1
	end

	local var_26_0 = 0
	local var_26_1 = ""
	local var_26_2 = self:getCastingID()

	for iter_26_0 = 1, g.core.config.casting_info.getLength() do
		local var_26_3 = g.core.config.casting_info.indexOf(iter_26_0)

		if iter_26_0 == 1 then
			var_26_1 = var_26_3.name
		end

		if var_26_3.level == self:getCastLevel() and var_26_2 == var_26_3.id then
			var_26_0 = 0
			var_26_0 = math.floor(self:getCastExp() / var_26_3.stage_1)
			var_26_1 = var_26_3.name
		end
	end

	return var_26_0, var_26_1
end

function EquipmentStruct:getCastAtt(arg_27_1, arg_27_2)
	arg_27_1 = arg_27_1 or self:getCastLevel()
	arg_27_2 = arg_27_2 or self:getCastExp()

	local var_27_0 = self:getCastingID()
	local var_27_1 = {}

	for iter_27_0 = 1, g.core.config.casting_info.getLength() do
		local var_27_2 = g.core.config.casting_info.indexOf(iter_27_0)

		if arg_27_1 >= var_27_2.level and var_27_2.id == var_27_0 then
			if arg_27_1 > var_27_2.level or arg_27_1 >= var_27_2.level and self:isMaxCast(arg_27_1, arg_27_2) then
				for iter_27_1 = 1, 10 do
					if g.core.config.casting_info.hasKey("advance_affect_type" .. iter_27_1) and var_27_2["advance_affect_type" .. iter_27_1] > 0 then
						var_27_1[var_27_2["advance_affect_type" .. iter_27_1]] = (var_27_1[var_27_2["advance_affect_type" .. iter_27_1]] or 0) + ((g.core.config.casting_info.hasKey("advance_affect_value" .. iter_27_1) or nil) and (var_27_2["advance_affect_value" .. iter_27_1] or 0))
					end
				end
			end

			if arg_27_1 > var_27_2.level then
				for iter_27_2 = 1, 10 do
					if g.core.config.casting_info.hasKey("affect_type" .. iter_27_2) and var_27_2["affect_type" .. iter_27_2] > 0 then
						var_27_1[var_27_2["affect_type" .. iter_27_2]] = (var_27_1[var_27_2["affect_type" .. iter_27_2]] or 0) + ((g.core.config.casting_info.hasKey("affect_value" .. iter_27_2) or nil) and (var_27_2["affect_value" .. iter_27_2] or 0))
					end
				end
			else
				for iter_27_3 = 1, math.floor(arg_27_2 / var_27_2.stage_1) do
					if g.core.config.casting_info.hasKey("affect_type" .. iter_27_3) and var_27_2["affect_type" .. iter_27_3] > 0 then
						var_27_1[var_27_2["affect_type" .. iter_27_3]] = (var_27_1[var_27_2["affect_type" .. iter_27_3]] or 0) + ((g.core.config.casting_info.hasKey("affect_value" .. iter_27_3) or nil) and (var_27_2["affect_value" .. iter_27_3] or 0))
					end
				end
			end
		end
	end

	return var_27_1
end

function EquipmentStruct:isCanCast()
	if not self:isHasCast() then
		return false
	end

	local var_28_0 = self:getCastingID()
	local var_28_1 = self:getCastLevel()
	local var_28_2 = self:getCastExp()

	if g.core.config.casting_info.hasData(var_28_0, var_28_1 + 1) then
		return true
	else
		return var_28_2 < g.core.config.casting_info.get(var_28_0, var_28_1).cost_experience
	end
end

function EquipmentStruct:isMaxCast(arg_29_1, arg_29_2)
	if not self:isHasCast() then
		return false
	end

	local var_29_0 = self:getCastLevel()
	local var_29_1 = self:getCastingID()

	arg_29_1 = arg_29_1 or var_29_0
	arg_29_2 = arg_29_2 or self:getCastExp()

	if not g.core.config.casting_info.hasData(var_29_1, arg_29_1 + 1) and arg_29_2 >= g.core.config.casting_info.get(var_29_1, arg_29_1).cost_experience then
		return true
	end

	return false
end

function EquipmentStruct:isCanCastSuccess()
	if not self:isHasCast() then
		return false
	end

	local var_30_0 = self:getCastLevel()
	local var_30_1 = self:getCastingID()
	local var_30_2 = g.core.config.casting_info.get(var_30_1, var_30_0)
	local var_30_3 = self:getCastExp()

	if not g.core.config.casting_info.hasData(var_30_1, var_30_0 + 1) and var_30_3 >= var_30_2.cost_experience then
		return false
	end

	local var_30_4 = var_30_2.casting_develop
	local var_30_5 = {}

	for iter_30_0, iter_30_1 in g.core.config.casting_develop.ipairs() do
		if var_30_4 == iter_30_1.id then
			table.insert(var_30_5, {
				cost_type = iter_30_1.cost_type,
				cost_value = iter_30_1.cost_value,
				addExp = iter_30_1.casting_experience
			})
		end
	end

	local var_30_6 = 0

	for iter_30_2, iter_30_3 in ipairs(var_30_5) do
		var_30_6 = var_30_6 + iter_30_3.addExp * g.core.model.User.bagData:getCountById(iter_30_3.cost_type, iter_30_3.cost_value)
	end

	local var_30_7 = {}

	for iter_30_4 = 1, 10 do
		if g.core.config.casting_info.hasKey("stage_" .. iter_30_4) then
			table.insert(var_30_7, var_30_2["stage_" .. iter_30_4])
		end
	end

	table.insert(var_30_7, var_30_2.cost_experience)

	local var_30_8 = var_30_7[math.floor(var_30_3 / var_30_2.stage_1) + 1]

	if var_30_8 and var_30_8 <= var_30_6 + var_30_3 then
		return true
	end

	return false
end

function EquipmentStruct:isCanReborn(arg_31_1)
	local var_31_0 = self:getServerData()
	local var_31_1 = arg_31_1 and self:getCfg().quality >= g.core.const.ConstMgr.QUALITY_TYPE.SR or var_31_0.level > 1 or var_31_0.refining_level > 0 or var_31_0.glyph_level > 0 or self:getResonanceLevel() > 0

	var_31_1 = var_31_1 or self:isHasCast() and (self:getCastLevel() > 1 or self:getCurPhase() >= 1)

	return var_31_1
end

function EquipmentStruct:getQuality()
	return self:getCfg().quality
end

function EquipmentStruct:getAdvanceId()
	return self:getCfg().advance_id
end

function EquipmentStruct:_updateResonanceInfo()
	self._resonanceLevel = self._serverData.resonance_level or 0
	self._resonanceExp = self._serverData.resonance_exp or 0
end

function EquipmentStruct:hasResonance()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_RESONANCE) then
		return false
	end

	return self._cfg and self._cfg.resonance_id > 0
end

function EquipmentStruct:getResonanceLevel()
	return self._resonanceLevel or 0
end

function EquipmentStruct:getResonanceExp()
	return self._resonanceExp or 0
end

function EquipmentStruct:isResonanceMaxLevel()
	return false
end

function EquipmentStruct:getResonanceAttrDataBySetting(arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = {}

	if arg_39_1 == 0 and arg_39_2 == 0 then
		return var_39_0
	end

	for iter_39_0 = 1, arg_39_1 do
		for iter_39_1, iter_39_2, iter_39_3 in var_0_5.get(self._cfg.resonance_id, iter_39_0).gmatch({
			"advance_affect_type%d+",
			"advance_affect_value%d+"
		}) do
			if iter_39_3[1] > 0 then
				if var_39_0[iter_39_3[1]] then
					var_39_0[iter_39_3[1]].value = var_39_0[iter_39_3[1]].value + iter_39_3[2]
				else
					var_39_0[iter_39_3[1]] = {
						type = iter_39_3[1],
						value = iter_39_3[2]
					}
				end
			end
		end
	end

	local var_39_1 = var_0_5.fetch(self._cfg.resonance_id, arg_39_1 + 1)

	if var_39_1 then
		for iter_39_4, iter_39_5, iter_39_6 in var_39_1.gmatch({
			"advance_affect_type%d+",
			"advance_affect_value%d+"
		}) do
			local var_39_2 = {
				type = iter_39_6[1],
				value = math.floor(iter_39_6[2] * (arg_39_2 / var_39_1.exp))
			}

			if iter_39_6[1] > 0 then
				if var_39_0[iter_39_6[1]] then
					if arg_39_3 then
						var_39_0[iter_39_6[1]].value2 = var_39_0[iter_39_6[1]].value + iter_39_6[2]
					end

					var_39_0[iter_39_6[1]].value = var_39_0[iter_39_6[1]].value + var_39_2.value
				else
					var_39_0[iter_39_6[1]] = var_39_2

					if arg_39_3 then
						var_39_0[iter_39_6[1]].value2 = iter_39_6[2]
					end
				end
			end
		end
	end

	local var_39_3 = table.values(var_39_0)

	table.sort(var_39_3, function(arg_40_0, arg_40_1)
		return arg_40_0.type < arg_40_1.type
	end)

	return var_39_3
end

function EquipmentStruct:getCurResonanceAttrData(arg_41_1)
	return self:getResonanceAttrDataBySetting(self._resonanceLevel, self._resonanceExp, arg_41_1)
end

function EquipmentStruct:getCurResonanceInfo()
	if self._cfg.resonance_id == 0 then
		return nil
	end

	return (var_0_5.get(self._cfg.resonance_id, (self._resonanceLevel == 0 or nil) and 1))
end

function EquipmentStruct:getNextResonanceInfo()
	local var_43_0 = false

	if self._cfg.resonance_id == 0 then
		return nil, var_43_0
	end

	local var_43_1 = var_0_5.fetch(self._cfg.resonance_id, self._resonanceLevel + 1)

	if not var_43_1 then
		var_43_1 = var_0_5.get(self._cfg.resonance_id, self._resonanceLevel)
		var_43_0 = true
	end

	return var_43_1, var_43_0
end

function EquipmentStruct:hasMagical()
	return self:getQuality() >= var_0_0.UR
end

function EquipmentStruct:_updateMagicalInfo()
	self._magicalStage = self._serverData.magical_stage or 0
end

function EquipmentStruct:getMagicalStage()
	return self._magicalStage
end

function EquipmentStruct:setMagicalStage(arg_47_1)
	self._magicalStage = arg_47_1
end

function EquipmentStruct:canMagicalStageUp()
	if not self:hasMagical() then
		return false
	end

	if self:isMaxMagicalStage() then
		return false
	end

	return self:isMagicalStageUpCostEnough()
end

function EquipmentStruct:isMagicalStageUpCostEnough()
	local var_49_0 = self:getMagicalStageUpCost()

	return g.core.model.User.bagData:getOwnNum(var_49_0.type, var_49_0.value) >= var_49_0.size
end

function EquipmentStruct:_getEquipmentStageInfoByKey(arg_50_1)
	arg_50_1 = math.max(arg_50_1, 0)

	return (var_0_6.fetch((tonumber(self:getAdvanceId() .. string.format("%03d", arg_50_1)))))
end

function EquipmentStruct:getEquipmentStageInfo(arg_51_1)
	arg_51_1 = arg_51_1 or self:getMagicalStage()

	return self:_getEquipmentStageInfoByKey(arg_51_1)
end

function EquipmentStruct:getNextMagicalStage()
	local var_52_0 = self:getEquipmentStageInfo()

	return (var_52_0 or nil) and (var_52_0.next_stage or 0)
end

function EquipmentStruct:isMaxMagicalStage()
	local var_53_0 = self:getEquipmentStageInfo()

	return var_53_0 and var_53_0.next_stage == 0
end

function EquipmentStruct:getMagicalStageUpCost()
	local var_54_0 = self:getEquipmentStageInfo()

	return {
		type = var_54_0.up_type,
		value = var_54_0.up_value,
		size = var_54_0.up_size
	}
end

function EquipmentStruct:getMagicalAttrMap(arg_55_1)
	local var_55_0 = self:getEquipmentStageInfo(arg_55_1)
	local var_55_1 = {}

	while var_0_6.hasKey("attr_type_" .. 1) do
		if var_55_0["attr_type_" .. 1] > 0 and var_55_0["attr_value_" .. 1] > 0 then
			var_55_1[var_55_0["attr_type_" .. 1]] = var_55_0["attr_value_" .. 1]
		end
	end

	return var_55_1
end

function EquipmentStruct:getSuitId()
	return self:getCfg().suit_id
end

function EquipmentStruct:getMaxMagicalStage()
	return var_0_1.MAGICAL_MAX_STAGE[self:getQuality()]
end

function EquipmentStruct:getMagicalTalentSkillList(arg_58_1)
	local var_58_0 = {}
	local var_58_1

	if not arg_58_1 then
		arg_58_1 = self:getMagicalStage()
		var_58_1 = self:getAdvanceId()
	end

	for iter_58_0 = 1, self:getMaxMagicalStage() do
		local var_58_2 = var_0_6.fetch((tonumber(var_58_1 .. string.format("%03d", iter_58_0))))

		if var_58_2 then
			table.insert(var_58_0, {
				talentId = var_58_2["talent_" .. iter_58_0],
				isActive = iter_58_0 <= arg_58_1,
				stage = var_58_2.stage
			})
		end
	end

	return var_58_0
end

function EquipmentStruct:getSid()
	return self._sId
end

function EquipmentStruct:getEquipmentType()
	return self:getCfg().equipment_type
end

return EquipmentStruct
