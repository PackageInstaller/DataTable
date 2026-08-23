local var_0_0 = g.core.config.equipment_resonance_info
local var_0_1 = g.core.config.pet_compose_info
local var_0_2 = g.core.config.pet_advance_info
local var_0_3 = g.core.config.pet_info
local var_0_4 = g.core.config.artifact_compose_info
local var_0_5 = g.core.config.artifact_upgrade_info
local var_0_6 = g.core.config.furniture_book_info
local var_0_7 = g.core.config.scroll_stage_growth_info
local var_0_8 = g.core.config.knight_book_award_info
local var_0_9 = g.core.config.knight_book_info
local var_0_10 = g.core.config.knight_favorability_level_info
local var_0_11 = g.core.config.knight_favorability_addition_info
local var_0_12 = g.core.config.equipment_info
local var_0_13 = g.core.config.treasure_info
local var_0_14 = g.core.config.knight_association_info
local var_0_15 = g.core.config.artifact_info
local var_0_16 = g.core.config.knight_advance_info
local var_0_17 = g.core.config.knight_info
local var_0_18 = g.core.config.battle_parameter_info
local var_0_19 = g.core.config.talent_skill_info
local var_0_20 = g.core.config.unite_token_info
local var_0_21 = g.core.config.unite_token_upgrade_info
local var_0_22 = g.core.config.enhance_master_info
local var_0_23 = g.core.const.ConstMgr.ETConst
local FightValueConst = require("app.core.common.FightValue.FightValueConst")
local var_0_25 = FightValueConst.ATTR_CONST
local var_0_26

local function var_0_27(arg_1_0)
	if not var_0_26 then
		var_0_26 = {}

		for iter_1_0, iter_1_1 in var_0_18.ipairs() do
			if iter_1_1.type == FightValueConst.BATTLE_PARAMETER_TYPE then
				var_0_26[iter_1_1.sub_type] = iter_1_1
			end
		end
	end

	if var_0_26[arg_1_0] then
		return var_0_26[arg_1_0].value / 1000
	end

	return 0
end

local var_0_28

local function var_0_29()
	if not var_0_28 then
		var_0_28 = var_0_19.match("open_type", g.core.const.ConstMgr.TalentConst.OPEN_TYPE.LINEUP_HALO)

		table.sort(var_0_28, function(arg_3_0, arg_3_1)
			return arg_3_0.open_value < arg_3_1.open_value
		end)
	end

	return var_0_28
end

local function var_0_30(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1 or {}) do
		arg_4_0[iter_4_0] = arg_4_0[iter_4_0] and arg_4_0[iter_4_0] + iter_4_1 or iter_4_1
	end
end

local var_0_31 = {
	getArtifactStarAttrList = function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = {}
		local var_5_1 = 1

		if arg_5_0 and arg_5_0 > 0 then
			local var_5_2 = var_0_15.get(arg_5_0)

			arg_5_2 = arg_5_2 or var_0_17.fetch(arg_5_1) or {}

			if (arg_5_2.advance_id or 0) == var_5_2.knight_advance_code and var_5_2.if_try == 1 then
				var_5_1 = 2
			end

			local var_5_3 = 1

			while var_0_16.hasKey("affect_type_" .. var_5_3) do
				var_5_0[var_5_2["affect_type_" .. var_5_3]] = var_5_2["affect_value_" .. var_5_3] / var_5_1
				var_5_3 = var_5_3 + 1
			end
		end

		return var_5_0
	end,
	getArtifactLevelAttrList = function(arg_6_0, arg_6_1)
		local var_6_0 = {}
		local var_6_1 = var_0_5.get(arg_6_0, arg_6_1)
		local var_6_2 = 1

		while var_0_5.hasKey("upgrade_type_" .. var_6_2) do
			var_6_0[var_6_1["upgrade_type_" .. var_6_2]] = var_6_0[var_6_1["upgrade_type_" .. var_6_2]] and var_6_0[var_6_1["upgrade_type_" .. var_6_2]] + var_6_1["upgrade_value_" .. var_6_2] or var_6_1["upgrade_value_" .. var_6_2]
			var_6_2 = var_6_2 + 1
		end

		return var_6_0
	end,
	getArtifactBookAttrList = function()
		local var_7_0 = {}

		local function var_7_1(arg_8_0)
			while var_0_4.hasKey("affect_type_" .. 1) do
				var_7_0[arg_8_0["affect_type_" .. 1]] = var_7_0[arg_8_0["affect_type_" .. 1]] and var_7_0[arg_8_0["affect_type_" .. 1]] + arg_8_0["affect_value_" .. 1] or arg_8_0["affect_value_" .. 1]
			end
		end

		for iter_7_0, iter_7_1 in ipairs((g.core.model.User.artifactHandBookData:getGroupList())) do
			for iter_7_2, iter_7_3 in ipairs(iter_7_1.artifacts) do
				if iter_7_3.isActive then
					var_7_1((g.core.model.User.artifactHandBookData:getTargetLvCfg(iter_7_3.advId, iter_7_3.lv)))
				end
			end

			if iter_7_1.isActive then
				var_7_1((g.core.model.User.artifactHandBookData:getTargetLvCfg(iter_7_1.advId, iter_7_1.lv)))
			end
		end

		return var_7_0
	end,
	getPetLvStarAttrList = function(self, arg_9_1)
		local var_9_0 = self:getCfg()
		local var_9_1 = {}

		while var_0_3.hasKey("affect_type_" .. 1) do
			if var_9_0["affect_type_" .. 1] > 0 then
				var_9_1[var_9_0["affect_type_" .. 1]] = var_9_1[var_9_0["affect_type_" .. 1]] and var_9_1[var_9_0["affect_type_" .. 1]] + var_9_0["affect_value_" .. 1] + var_9_0["develop_" .. 1] * (arg_9_1 - 1) or var_9_0["affect_value_" .. 1] + var_9_0["develop_" .. 1] * (arg_9_1 - 1)
			end
		end

		return var_9_1
	end
}

function var_0_31:getPetStageAttrList(arg_10_1, arg_10_2)
	local var_10_0 = {}
	local var_10_1 = self:getAdvanceId()

	for iter_10_0 = 0, arg_10_1 do
		local var_10_2 = g.core.model.User.petsData:getAdvCfg(var_10_1, iter_10_0, arg_10_2)

		if var_10_2 and var_10_2.id then
			while var_0_2.hasKey("talent_skill_" .. 1) do
				if var_10_2["talent_skill_" .. 1] > 0 then
					var_0_31._getTalentAttrList(var_10_2["talent_skill_" .. 1], var_10_0)
				end
			end
		end
	end

	return var_10_0
end

function var_0_31.getPetBookAttrList()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs((g.core.model.User.petHandBookData:getAllPetInfoDict())) do
		if iter_11_1.isActivated then
			local var_11_1 = iter_11_1.handBookId or 0

			if var_11_1 > 0 then
				local var_11_2 = var_0_1.get(var_11_1)
				local var_11_3 = 1

				while var_0_1.hasKey("attribute_type_" .. var_11_3) do
					var_11_0[var_11_2["attribute_type_" .. var_11_3]] = var_11_0[var_11_2["attribute_type_" .. var_11_3]] and var_11_0[var_11_2["attribute_type_" .. var_11_3]] + var_11_2["attribute_value_" .. var_11_3] or var_11_2["attribute_value_" .. var_11_3]
					var_11_3 = var_11_3 + 1
				end
			end
		end
	end

	return var_11_0
end

function var_0_31.getPetAttrList(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = {}

	var_0_30(var_12_0, (var_0_31.getPetLvStarAttrList(arg_12_0, arg_12_1)))
	var_0_30(var_12_0, (var_0_31.getPetStageAttrList(arg_12_0, arg_12_2, arg_12_3)))

	return var_12_0
end

function var_0_31.getKnightLevelAttrList(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or 1

	local var_13_0 = arg_13_0 or {}

	return {
		[var_0_25.hp] = var_13_0.base_hp + (arg_13_1 - 1) * var_13_0.develop_hp,
		[var_0_25.atk] = var_13_0.base_attack + (arg_13_1 - 1) * var_13_0.develop_attack,
		[var_0_25.def] = var_13_0.base_physical_defence + (arg_13_1 - 1) * var_13_0.develop_physical_defence,
		[var_0_25.resistance] = var_13_0.base_magical_defence + (arg_13_1 - 1) * var_13_0.develop_magical_defence
	}
end

function var_0_31:getKnightRankAttrList(arg_14_1)
	local var_14_0 = {}

	if not arg_14_1 or arg_14_1 < 1 then
		return var_14_0
	end

	local var_14_1 = self.promote_code

	for iter_14_0 = 1, arg_14_1 - 1 do
		local var_14_2 = var_0_16.get(var_14_1, iter_14_0)
		local var_14_3 = 1

		while var_0_16.hasKey("affect_type_" .. var_14_3) do
			local var_14_4 = 1

			while var_0_16.hasKey("place_" .. var_14_3 .. "_affect_type_" .. var_14_4) do
				var_14_0[var_14_2["place_" .. var_14_3 .. "_affect_type_" .. var_14_4]] = var_14_0[var_14_2["place_" .. var_14_3 .. "_affect_type_" .. var_14_4]] and var_14_0[var_14_2["place_" .. var_14_3 .. "_affect_type_" .. var_14_4]] + var_14_2["place_" .. var_14_3 .. "_affect_value_" .. var_14_4] or var_14_2["place_" .. var_14_3 .. "_affect_value_" .. var_14_4]
				var_14_4 = var_14_4 + 1
			end

			local var_14_5 = var_14_2["affect_type_" .. var_14_3]

			var_14_0[var_14_5] = var_14_0[var_14_2["affect_type_" .. var_14_3]] and var_14_0[var_14_5] + var_14_2["affect_value_" .. var_14_3] or var_14_2["affect_value_" .. var_14_3]
			var_14_3 = var_14_3 + 1
		end
	end

	local var_14_6 = 1

	while var_0_17.hasKey("skill_type_" .. var_14_6) and var_14_6 <= var_0_16.get(var_14_1, arg_14_1).stage do
		if self["skill_type_" .. var_14_6] == 1 or self["skill_type_" .. var_14_6] == 3 then
			if self["promote_talent_" .. var_14_6] > 0 then
				var_0_31._getTalentAttrList(self["promote_talent_" .. var_14_6], var_14_0)
			end
		end

		var_14_6 = var_14_6 + 1
	end

	return var_14_0
end

function var_0_31:getKnightStarAttrList(arg_15_1)
	local var_15_0 = {}

	arg_15_1 = arg_15_1 or 1

	local var_15_1 = 1

	while var_0_17.hasKey("star_talent_" .. var_15_1) and var_15_1 <= arg_15_1 do
		if self["star_talent_" .. var_15_1] > 0 then
			var_0_31._getTalentAttrList(self["star_talent_" .. var_15_1], var_15_0)
		end

		var_15_1 = var_15_1 + 1
	end

	return var_15_0
end

function var_0_31._getAssociationAttrList(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or {}

	local var_16_0 = var_0_14.get(arg_16_0)

	while var_0_14.hasKey("affect_type_" .. 1) do
		if var_16_0["affect_type_" .. 1] > 0 then
			arg_16_1[var_16_0["affect_type_" .. 1]] = arg_16_1[var_16_0["affect_type_" .. 1]] and arg_16_1[var_16_0["affect_type_" .. 1]] + var_16_0["affect_value_" .. 1] or var_16_0["affect_value_" .. 1]
		end
	end

	return arg_16_1
end

function var_0_31._getTalentAttrList(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or {}

	local var_17_0 = var_0_19.fetch(arg_17_0)

	if not var_17_0 then
		return arg_17_1
	end

	local var_17_1 = 1

	while var_0_19.hasKey("affect_type_" .. var_17_1) do
		if var_17_0["affect_type_" .. var_17_1] > 0 then
			arg_17_1[var_17_0["affect_type_" .. var_17_1]] = arg_17_1[var_17_0["affect_type_" .. var_17_1]] and arg_17_1[var_17_0["affect_type_" .. var_17_1]] + var_17_0["affect_value_" .. var_17_1] or var_17_0["affect_value_" .. var_17_1]
		end

		var_17_1 = var_17_1 + 1
	end

	return arg_17_1
end

function var_0_31.getAttrListByTalentSkillId(arg_18_0, arg_18_1)
	arg_18_1 = arg_18_1 or {}

	var_0_31._getTalentAttrList(arg_18_0, arg_18_1)

	return arg_18_1
end

function var_0_31.getAllUniteTokenAttrList()
	local var_19_0 = g.core.model.User.uniteTokenData:getOwnTokenList()
	local var_19_1 = {}

	for iter_19_0 = 1, #var_19_0 do
		var_0_31.getUniteTokenStarAttrList(nil, var_19_0[iter_19_0]:getCfg(), var_19_1)
		var_0_31.getUniteTokenLevelAttrList(var_19_0[iter_19_0]:getCfg().upgrade_code, var_19_0[iter_19_0]:getLevel(), var_19_1)
	end

	return var_19_1
end

function var_0_31.getAllUniteTokenStarAttrList()
	local var_20_0 = g.core.model.User.uniteTokenData:getOwnTokenList()
	local var_20_1 = {}

	for iter_20_0 = 1, #var_20_0 do
		var_0_31.getUniteTokenStarAttrList(nil, var_20_0[iter_20_0]:getCfg(), var_20_1)
	end

	return var_20_1
end

function var_0_31.getUniteTokenStarAttrList(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2 = arg_21_2 or {}
	arg_21_1 = arg_21_1 or var_0_20.get(arg_21_0)

	local var_21_0 = 1

	while var_0_20.hasKey("basic_type_" .. var_21_0) do
		if arg_21_1["basic_type_" .. var_21_0] > 0 then
			arg_21_2[arg_21_1["basic_type_" .. var_21_0]] = arg_21_2[arg_21_1["basic_type_" .. var_21_0]] and arg_21_2[arg_21_1["basic_type_" .. var_21_0]] + arg_21_1["basic_value_" .. var_21_0] or arg_21_1["basic_value_" .. var_21_0]
		end

		var_21_0 = var_21_0 + 1
	end

	return arg_21_2
end

function var_0_31.getUniteTokenLevelAttrList(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2 = arg_22_2 or {}

	local var_22_0 = var_0_21.get(arg_22_0, arg_22_1)

	while var_0_21.hasKey("upgrade_type_" .. 1) do
		if var_22_0["upgrade_type_" .. 1] > 0 then
			arg_22_2[var_22_0["upgrade_type_" .. 1]] = arg_22_2[var_22_0["upgrade_type_" .. 1]] and arg_22_2[var_22_0["upgrade_type_" .. 1]] + var_22_0["upgrade_value_" .. 1] or var_22_0["upgrade_value_" .. 1]
		end
	end

	return arg_22_2
end

function var_0_31.getKnightFavorAttrListByQualityFavorLv(arg_23_0, arg_23_1)
	local var_23_0 = {}
	local var_23_1 = var_0_10.get(arg_23_0, arg_23_1)

	var_23_0[var_0_25.hp] = var_23_1.initial_hp
	var_23_0[var_0_25.atk] = var_23_1.attack
	var_23_0[var_0_25.def] = var_23_1.phy_defence
	var_23_0[var_0_25.resistance] = var_23_1.mag_defence

	return var_23_0
end

function var_0_31:getKnightFavorLevelAttrList()
	if not self then
		return {}
	end

	return var_0_31.getKnightFavorAttrListByQualityFavorLv(self:getQuality(), (self:getFavoLevel()))
end

function var_0_31.getKnightFavorAttrListByTotalLevel(arg_25_0)
	arg_25_0 = math.min(var_0_11.getLength(), arg_25_0)

	local var_25_0 = {}

	for iter_25_0 = 1, arg_25_0 do
		local var_25_1 = var_0_11.indexOf(iter_25_0)

		while var_0_21.hasKey("affect_type_" .. 1) do
			if var_25_1["affect_type_" .. 1] > 0 then
				var_25_0[var_25_1["affect_type_" .. 1]] = var_25_0[var_25_1["affect_type_" .. 1]] and var_25_0[var_25_1["affect_type_" .. 1]] + var_25_1["affect_value_" .. 1] or var_25_1["affect_value_" .. 1]
			end
		end
	end

	return var_25_0
end

function var_0_31.getKnightFavorTotalLevelAttrList(arg_26_0)
	return var_0_31.getKnightFavorAttrListByTotalLevel((g.core.model.User.knightFavoData:getTotalFavoLevel()))
end

local var_0_32

local function var_0_33(arg_27_0, arg_27_1)
	if not var_0_32 then
		var_0_32 = {}

		for iter_27_0, iter_27_1 in var_0_9.ipairs() do
			var_0_32[iter_27_1.advance_id .. iter_27_1.level] = iter_27_1
		end
	end

	return var_0_32[arg_27_0 .. arg_27_1]
end

function var_0_31.getAllKnightBookAttrList()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs((g.core.model.User.handBookData:getAllActiveKnightData())) do
		var_0_31._getKnightBookAttrList(iter_28_0, iter_28_1.level, var_28_0)
	end

	var_0_32 = nil

	local var_28_2 = g.core.model.User.handBookData:getCurAndNextScoreInfo()

	var_0_31._getKnightBookLevelAttrList(not var_28_2.cur and 0 or var_28_2.cur.id, var_28_0)

	return var_28_0
end

function var_0_31._getKnightBookAttrList(arg_29_0, arg_29_1, arg_29_2)
	arg_29_2 = arg_29_2 or {}

	local var_29_0 = var_0_33(arg_29_0, arg_29_1)

	if var_29_0 then
		while var_0_9.hasKey("affect_type_" .. 1) do
			if var_29_0["affect_type_" .. 1] > 0 then
				arg_29_2[var_29_0["affect_type_" .. 1]] = arg_29_2[var_29_0["affect_type_" .. 1]] and arg_29_2[var_29_0["affect_type_" .. 1]] + var_29_0["affect_value_" .. 1] or var_29_0["affect_value_" .. 1]
			end
		end
	end

	return arg_29_2
end

function var_0_31._getKnightBookLevelAttrList(arg_30_0, arg_30_1)
	arg_30_1 = arg_30_1 or {}

	for iter_30_0 = 1, arg_30_0 do
		local var_30_0 = var_0_8.get(iter_30_0)

		while var_0_8.hasKey("affect_type_" .. 1) do
			if var_30_0["affect_type_" .. 1] > 0 then
				arg_30_1[var_30_0["affect_type_" .. 1]] = arg_30_1[var_30_0["affect_type_" .. 1]] and arg_30_1[var_30_0["affect_type_" .. 1]] + var_30_0["affect_value_" .. 1] or var_30_0["affect_value_" .. 1]
			end
		end
	end

	return arg_30_1
end

function var_0_31.getKingdomAttrList()
	local var_31_0 = {}
	local var_31_1 = g.core.model.User.kingdomDataNew

	local function var_31_2(arg_32_0)
		for iter_32_0, iter_32_1 in ipairs((var_31_1:getChapterInfoByType(arg_32_0))) do
			for iter_32_2, iter_32_3 in ipairs((var_31_1:getCurNodeInfo(arg_32_0, iter_32_1.id))) do
				if var_31_1:isHasCurNode(iter_32_3.id) then
					var_31_0[iter_32_3.attribute_type] = var_31_0[iter_32_3.attribute_type] and var_31_0[iter_32_3.attribute_type] + iter_32_3.attribute_value or iter_32_3.attribute_value

					if iter_32_3.stage_id ~= 0 then
						local var_32_0 = var_0_7.get(iter_32_3.stage_id)

						while var_0_7.hasKey("attribute_type_" .. 1) do
							if var_32_0["attribute_type_" .. 1] > 0 then
								var_31_0[var_32_0["attribute_type_" .. 1]] = var_31_0[var_32_0["attribute_type_" .. 1]] and var_31_0[var_32_0["attribute_type_" .. 1]] + var_32_0["attribute_value_" .. 1] or var_32_0["attribute_value_" .. 1]
							end
						end
					end
				else
					break
				end
			end
		end
	end

	var_31_2(1)
	var_31_2(2)

	return var_31_0
end

function var_0_31.getFurnitureAttrList()
	local var_33_0 = {}

	var_0_31.addFurnitureCollectionAttr(var_33_0)
	var_0_31.addComfortBuffAttrDict(var_33_0)

	return var_33_0
end

function var_0_31:addFurnitureCollectionAttr()
	for iter_34_0, iter_34_1 in var_0_6.ipairs() do
		if g.core.model.User.furnitureHandBookData:getCurCollectProgress(iter_34_1.id) * 10 >= iter_34_1.attribute_process then
			self[iter_34_1.attribute_type] = self[iter_34_1.attribute_type] and self[iter_34_1.attribute_type] + iter_34_1.attribute_value or iter_34_1.attribute_value
		end
	end
end

function var_0_31.addComfortBuffAttrDict(arg_35_0)
	for iter_35_0 = 1, g.core.model.User.furnitureData:getDormMaxNum() do
		local var_35_0 = g.core.model.User.furnitureData:getRoomInfo(iter_35_0)

		var_0_30(arg_35_0, (var_35_0:getAttributesSumDict((var_35_0:getActivatedAttributeArr()))))
	end
end

function var_0_31.getEquipmentLevelAttrList(arg_36_0, arg_36_1)
	local var_36_0 = {}
	local var_36_1 = var_0_12.get(arg_36_0)

	var_36_0[var_36_1.strength_type] = var_36_1.strength_value + var_36_1.strength_growth * (arg_36_1 - 1)

	return var_36_0
end

function var_0_31.getEquipmentRefineAttrList(arg_37_0, arg_37_1)
	local var_37_0 = var_0_12.get(arg_37_0)
	local var_37_1 = {}

	while var_0_12.hasKey("refining_type_" .. 1) do
		if var_37_0["refining_type_" .. 1] > 0 then
			var_37_1[var_37_0["refining_type_" .. 1]] = var_37_1[var_37_0["refining_type_" .. 1]] and var_37_1[var_37_0["refining_type_" .. 1]] + (var_37_0["refining_value_" .. 1] + var_37_0["refining_growth_" .. 1] * arg_37_1) or var_37_0["refining_value_" .. 1] + var_37_0["refining_growth_" .. 1] * arg_37_1
		end
	end

	return var_37_1
end

function var_0_31.getEquipmentResonanceAttrList(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = {}

	if arg_38_1 == 0 and arg_38_2 == 0 then
		return var_38_0
	end

	for iter_38_0 = 1, arg_38_1 do
		for iter_38_1, iter_38_2, iter_38_3 in var_0_0.get(arg_38_0, iter_38_0).gmatch({
			"advance_affect_type%d+",
			"advance_affect_value%d+"
		}) do
			if iter_38_3[1] > 0 then
				var_38_0[iter_38_3[1]] = var_38_0[iter_38_3[1]] and var_38_0[iter_38_3[1]] + iter_38_3[2] or iter_38_3[2]
			end
		end
	end

	local var_38_1 = var_0_0.fetch(arg_38_0, arg_38_1 + 1)

	if var_38_1 then
		for iter_38_4, iter_38_5, iter_38_6 in var_38_1.gmatch({
			"advance_affect_type%d+",
			"advance_affect_value%d+"
		}) do
			if iter_38_6[1] > 0 then
				local var_38_2 = math.floor(iter_38_6[2] * (arg_38_2 / var_38_1.exp))

				var_38_0[iter_38_6[1]] = var_38_0[iter_38_6[1]] and var_38_0[iter_38_6[1]] + var_38_2 or var_38_2
			end
		end
	end

	return var_38_0
end

function var_0_31.getTreasureLevelAttrList(arg_39_0, arg_39_1)
	local var_39_0 = {}
	local var_39_1 = var_0_13.get(arg_39_0)

	while var_0_13.hasKey("basic_type_" .. 1) do
		if var_39_1["basic_type_" .. 1] > 0 then
			var_39_0[var_39_1["basic_type_" .. 1]] = var_39_0[var_39_1["basic_type_" .. 1]] and var_39_0[var_39_1["basic_type_" .. 1]] + (var_39_1["basic_value_" .. 1] + var_39_1["basic_growth_" .. 1] * (arg_39_1 - 1)) or var_39_1["basic_value_" .. 1] + var_39_1["basic_growth_" .. 1] * (arg_39_1 - 1)
		end
	end

	return var_39_0
end

function var_0_31.getTreasureRefineAttrList(arg_40_0, arg_40_1)
	local var_40_0 = var_0_13.get(arg_40_0)
	local var_40_1 = {}

	while var_0_13.hasKey("refine_type_" .. 1) do
		if var_40_0["refine_type_" .. 1] > 0 then
			var_40_1[var_40_0["refine_type_" .. 1]] = var_40_1[var_40_0["refine_type_" .. 1]] and var_40_1[var_40_0["refine_type_" .. 1]] + var_40_0["refine_growth_" .. 1] * (arg_40_1 - 1) or var_40_0["refine_growth_" .. 1] * (arg_40_1 - 1)
		end
	end

	return var_40_1
end

function var_0_31.getEquipmentAttrListByPos(arg_41_0)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs((g.core.model.User.equipmentData:getEquipSuitByKnightPos(arg_41_0))) do
		if type(iter_41_1) ~= "number" and iter_41_1.getCfg then
			local var_41_2 = iter_41_1:getServerData()
			local var_41_3 = iter_41_1:getCfg()
			local var_41_4 = var_41_2.level
			local var_41_5

			if not var_41_2.level then
				var_41_4 = 0
				var_41_5 = var_41_0
			end

			var_0_30(var_41_0, (var_0_31.getEquipmentLevelAttrList(var_41_3.id, var_41_4)))

			local var_41_6 = var_41_2.refining_level
			local var_41_7

			if not var_41_2.refining_level then
				var_41_6 = 0
				var_41_7 = var_41_0
			end

			var_0_30(var_41_0, (var_0_31.getEquipmentRefineAttrList(var_41_3.id, var_41_6)))

			if iter_41_1:hasResonance() then
				var_0_30(var_41_0, (var_0_31.getEquipmentResonanceAttrList(var_41_3.resonance_id, iter_41_1:getResonanceLevel(), iter_41_1:getResonanceExp())))
			end
		end
	end

	var_0_30(var_41_0, (var_0_31.getEquipmentMasterAttrList(arg_41_0)))

	return var_41_0
end

function var_0_31.getTreasureAttrListByPos(arg_42_0)
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs((g.core.model.User.treasureData:getTreasureDataListByKnightPos(arg_42_0))) do
		if iter_42_1 > 0 then
			local var_42_2 = g.core.model.User.treasureData:getTreasureDataByOnlyId(iter_42_1)

			if var_42_2 and next(var_42_2) then
				var_0_30(var_42_0, (var_0_31.getTreasureLevelAttrList(var_42_2.base_id, (g.core.model.User.treasureData:getTreasureLevelByOnlyId(iter_42_1)))))
				var_0_30(var_42_0, (var_0_31.getTreasureRefineAttrList(var_42_2.base_id, (g.core.model.User.treasureData:getTreasureRefineLevelByOnlyId(iter_42_1)))))
			end
		end
	end

	var_0_30(var_42_0, (var_0_31.getTreasureMasterAttrList(arg_42_0)))

	return var_42_0
end

function var_0_31.getEquipmentMasterAttrList(arg_43_0)
	local var_43_0, var_43_1, var_43_2

	if not g.core.model.User.equipmentData:isActiveMaster(arg_43_0) then
		do return {} end

		var_43_0 = 9999999
		var_43_1 = 9999999
		var_43_2 = 9999999
	end

	for iter_43_0, iter_43_1 in ipairs((g.core.model.User.equipmentData:getEquipSuitByKnightPos(arg_43_0))) do
		local var_43_3 = iter_43_1:getServerData()
		local var_43_4 = var_43_3.level or 0

		if var_43_4 < var_43_0 then
			var_43_0 = var_43_4
		end

		local var_43_5 = var_43_3.refining_level or 0

		if var_43_5 < var_43_1 then
			var_43_1 = var_43_5
		end

		local var_43_6 = iter_43_1:getResonanceLevel()

		if var_43_6 < var_43_2 then
			var_43_2 = var_43_6
		end
	end

	local var_43_7 = {}

	var_0_30(var_43_7, var_0_31._getEquipmentLevelMasterAttrListByMinLevel(var_43_0))
	var_0_30(var_43_7, var_0_31._getEquipmentRefineMasterAttrListByMinLevel(var_43_1))
	var_0_30(var_43_7, var_0_31._getEquipmentResonanceMasterAttrListByMinLevel(var_43_2))

	return var_43_7
end

function var_0_31.getTreasureMasterAttrList(arg_44_0)
	local var_44_0, var_44_1

	if not g.core.model.User.treasureData:isActiveMaster(arg_44_0) then
		do return {} end

		var_44_0 = 9999999
		var_44_1 = 9999999
	end

	for iter_44_0, iter_44_1 in ipairs((g.core.model.User.treasureData:getTreasureDataListByKnightPos(arg_44_0))) do
		local var_44_2 = g.core.model.User.treasureData:getTreasureLevelByOnlyId(iter_44_1)

		if var_44_2 < var_44_0 then
			var_44_0 = var_44_2
		end

		local var_44_3 = g.core.model.User.treasureData:getTreasureRefineLevelByOnlyId(iter_44_1)

		if var_44_3 < var_44_1 then
			var_44_1 = var_44_3
		end
	end

	local var_44_4 = {}

	var_0_30(var_44_4, var_0_31._getTreasureLevelMasterAttrListByMinLevel(var_44_0))
	var_0_30(var_44_4, var_0_31._getTreasureRefineMasterAttrListByMinLevel(var_44_1))

	return var_44_4
end

function var_0_31._getEquipmentLevelMasterAttrListByMinLevel(arg_45_0)
	return var_0_31._getMasterAttrListByType(var_0_23.MASTER_TYPE.EQUIP_LEVEL, arg_45_0)
end

function var_0_31._getEquipmentRefineMasterAttrListByMinLevel(arg_46_0)
	return var_0_31._getMasterAttrListByType(var_0_23.MASTER_TYPE.EQUIP_REFINE, arg_46_0)
end

function var_0_31._getTreasureLevelMasterAttrListByMinLevel(arg_47_0)
	return var_0_31._getMasterAttrListByType(var_0_23.MASTER_TYPE.TREASURE_LEVEL, arg_47_0)
end

function var_0_31._getTreasureRefineMasterAttrListByMinLevel(arg_48_0)
	return var_0_31._getMasterAttrListByType(var_0_23.MASTER_TYPE.TREASURE_REFINE, arg_48_0)
end

function var_0_31._getEquipmentResonanceMasterAttrListByMinLevel(arg_49_0)
	return var_0_31._getMasterAttrListByType(var_0_23.MASTER_TYPE.EQUIP_RESONANCE, arg_49_0)
end

function var_0_31._getMasterAttrListByType(arg_50_0, arg_50_1)
	local var_50_0

	for iter_50_0, iter_50_1 in var_0_22.ipairs() do
		if iter_50_1.type == arg_50_0 then
			if arg_50_1 < iter_50_1.value then
				break
			else
				var_50_0 = iter_50_1
			end
		end
	end

	return var_0_31._getMasterAttrList(var_50_0)
end

function var_0_31:_getMasterAttrList()
	if not self then
		return {}
	end

	local var_51_0 = {}

	while var_0_22.hasKey("affect_type_" .. 1) do
		if self["affect_type_" .. 1] > 0 then
			var_51_0[self["affect_type_" .. 1]] = var_51_0[self["affect_type_" .. 1]] and var_51_0[self["affect_type_" .. 1]] + self["affect_value_" .. 1] or self["affect_value_" .. 1]
		end
	end

	return var_51_0
end

function var_0_31.getGroupHaloAttrList(arg_52_0)
	local var_52_0 = {}
	local var_52_1 = arg_52_0 or 0
	local var_52_2 = 1

	while var_0_19.hasKey("affect_type_" .. var_52_2) do
		var_52_2 = var_52_2 + 1
	end

	local var_52_3 = var_52_2 - 1

	for iter_52_0, iter_52_1 in pairs((var_0_29())) do
		if var_52_1 >= iter_52_1.open_value then
			for iter_52_2 = 1, var_52_3 do
				var_52_0[iter_52_1["affect_type_" .. iter_52_2]] = var_52_0[iter_52_1["affect_type_" .. iter_52_2]] and var_52_0[iter_52_1["affect_type_" .. iter_52_2]] + iter_52_1["affect_value_" .. iter_52_2] or iter_52_1["affect_value_" .. iter_52_2]
			end
		else
			break
		end
	end

	return var_52_0
end

function var_0_31.getEchoLabAttrList()
	local var_53_0 = {}

	var_0_30(var_53_0, (var_0_31._getEchoLabTreeAttrList()))
	var_0_30(var_53_0, (var_0_31._getEchoLabCollectAttrList()))
	var_0_30(var_53_0, (var_0_31._getEchoLabCoreCrystalAttrList()))

	return var_53_0
end

function var_0_31._getEchoLabTreeAttrList()
	return (g.core.model.User.echoLabData:getTreeData():getAllActiveAttrList())
end

function var_0_31._getEchoLabCollectAttrList()
	return g.core.model.User.echoLabData:getCollectData():getAllBuildAttrInfoDict().all
end

function var_0_31._getEchoLabCoreCrystalAttrList()
	return (g.core.model.User.echoLabData:getAllAttrSumData())
end

function var_0_31.getKnightSoulAttrList()
	return (g.core.model.User.knightSoulData:getAllAttrDict())
end

function var_0_31.addAttr(arg_58_0, arg_58_1)
	var_0_30(arg_58_0, arg_58_1)
end

function var_0_31.checkBaseAttrList(arg_59_0)
	local function var_59_0(arg_60_0)
		return arg_59_0[arg_60_0] or 0
	end

	local function var_59_1(arg_61_0)
		return var_59_0(arg_61_0) / 1000
	end

	arg_59_0[var_0_25.hp] = math.floor(var_59_0(var_0_25.hp) * (1 + var_59_1(var_0_25.hp_per) + var_59_1(var_0_25.all_base_attr)))
	arg_59_0[var_0_25.atk] = math.floor(var_59_0(var_0_25.atk) * (1 + var_59_1(var_0_25.atk_per) + var_59_1(var_0_25.all_base_attr)))
	arg_59_0[var_0_25.def] = math.floor((var_59_0(var_0_25.def) + var_59_0(var_0_25.def_resistance)) * (1 + var_59_1(var_0_25.def_per) + var_59_1(var_0_25.all_base_attr) + var_59_1(var_0_25.def_resistance_per)))
	arg_59_0[var_0_25.resistance] = math.floor((var_59_0(var_0_25.resistance) + var_59_0(var_0_25.def_resistance)) * (1 + var_59_1(var_0_25.resistance_per) + var_59_1(var_0_25.all_base_attr) + var_59_1(var_0_25.def_resistance_per)))
	arg_59_0["old_" .. var_0_25.def_resistance] = var_59_0("old_" .. var_0_25.def_resistance) + var_59_0(var_0_25.def_resistance)
	arg_59_0["old_" .. var_0_25.all_base_attr] = var_59_0("old_" .. var_0_25.all_base_attr) + var_59_0(var_0_25.all_base_attr)
	arg_59_0["old_" .. var_0_25.def_resistance_per] = var_59_0("old_" .. var_0_25.def_resistance_per) + var_59_0(var_0_25.def_resistance_per)
	arg_59_0[var_0_25.def_resistance] = 0
	arg_59_0[var_0_25.all_base_attr] = 0
	arg_59_0[var_0_25.def_resistance_per] = 0

	return arg_59_0
end

function var_0_31.calculationFightValue(arg_62_0, arg_62_1)
	local var_62_0 = {}

	var_62_0 = arg_62_1 == false and arg_62_0 or var_0_31.checkBaseAttrList(arg_62_0)

	local function var_62_1(arg_63_0)
		return var_62_0[arg_63_0] or 0
	end

	local function var_62_3(arg_64_0)
		return var_62_1(arg_64_0) / 1000 * var_0_27(arg_64_0)
	end

	return (math.floor((var_62_1(var_0_25.hp) * var_0_27(var_0_25.hp) + var_62_1(var_0_25.atk) * var_0_27(var_0_25.atk) + var_62_1(var_0_25.def) * var_0_27(var_0_25.def) + var_62_1(var_0_25.resistance) * var_0_27(var_0_25.resistance)) * (1 + var_62_3(var_0_25.mingzhon) + var_62_3(var_0_25.shanbi) + var_62_3(var_0_25.baoji) + var_62_3(var_0_25.kangbao) + var_62_3(var_0_25.baoji_qiangdu) + var_62_3(var_0_25.baoji_jianmian) + var_62_3(var_0_25.gedang) + var_62_3(var_0_25.poji) + var_62_3(var_0_25.gedang_qiangdu) + var_62_3(var_0_25.gedang_jianmian) + var_62_3(var_0_25.shanghai_zengjia) + var_62_3(var_0_25.shanghai_jianmian) + var_62_3(var_0_25.zuizhong_zengshang) + var_62_3(var_0_25.youhuati_jingtong) + var_62_3(var_0_25.youhuati_diyu))))
end

function var_0_31.getFogKnightCultivateAttrList(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	local var_65_0 = {}

	var_0_30(var_65_0, var_0_31.getKnightLevelAttrList(arg_65_0, arg_65_1))
	var_0_30(var_65_0, var_0_31.getKnightRankAttrList(arg_65_0, arg_65_2))
	var_0_30(var_65_0, var_0_31.getKnightStarAttrList(arg_65_0, arg_65_3))

	return var_65_0
end

function var_0_31.getFogGroupHaloAttr(arg_66_0)
	local var_66_0 = {}
	local var_66_1 = arg_66_0 or 0

	for iter_66_0, iter_66_1 in pairs((g.core.config.camp_halo_info.match("unlock_type", FightValueConst.FOG_GROUP_HALO_TYPE))) do
		if var_66_1 >= iter_66_1.unlock_value then
			local var_66_2 = var_0_19.fetch(iter_66_1.talent_skill_id)

			if var_66_2 then
				for iter_66_2 = 1, 3 do
					var_66_0[var_66_2["affect_type_" .. iter_66_2]] = var_66_0[var_66_2["affect_type_" .. iter_66_2]] and var_66_0[var_66_2["affect_type_" .. iter_66_2]] + var_66_2["affect_value_" .. iter_66_2] or var_66_2["affect_value_" .. iter_66_2]
				end
			end
		else
			break
		end
	end

	return var_66_0
end

function var_0_31.checkFogRateAttrList(arg_67_0)
	local function var_67_0(arg_68_0)
		return arg_67_0[arg_68_0] or 0
	end

	for iter_67_0, iter_67_1 in g.core.config.attribute_rate_info.ipairs() do
		arg_67_0[iter_67_1.type] = math.floor(var_67_0(iter_67_1.type) * (iter_67_1.value / 1000)) + iter_67_1.basic
	end
end

function var_0_31:getMulTeamKnightAllAssAttrList()
	local var_69_0 = {}

	while var_0_17.hasKey("association_" .. 1) do
		if self["association_" .. 1] > 0 then
			var_0_31._getAssociationAttrList(self["association_" .. 1], var_69_0)
		end
	end

	return var_69_0
end

function var_0_31:getMulTeamKnightAttrList(arg_70_1, arg_70_2)
	local var_70_0 = {}
	local var_70_1 = self:getBaseInfo()

	var_0_30(var_70_0, (var_0_31.getKnightLevelAttrList(var_70_1, arg_70_1)))
	var_0_30(var_70_0, (var_0_31.getKnightRankAttrList(var_70_1, arg_70_2)))
	var_0_30(var_70_0, (var_0_31.getKnightStarAttrList(var_70_1, (self:getStarLv()))))
	var_0_30(var_70_0, (var_0_31.getMulTeamKnightAllAssAttrList(var_70_1)))

	return var_70_0
end

return var_0_31
