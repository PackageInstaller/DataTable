PolyhedronConst = {
	HERO_ATTRIBUTE_ICON_PATH = "TextureConfig/PolyhedronItem/Attribute/",
	ARTIFACT_ICON_PATH = "TextureConfig/PolyhedronItem/Artifact/",
	TERMINAL_ICON_PATH = "TextureConfig/PolyhedronItem/Terminal/",
	EFFECT_ATTRIBUTE_ICON_PATH = "TextureConfig/PolyhedronItem/Effect/",
	BEACON_ICON_PATH = "TextureConfig/PolyhedronItem/Beacon/",
	SAVE_POINT_TYPE = {
		OPTION = 3,
		REWARD = 2,
		UNDEFINED = 0,
		BATTLE = 1
	},
	STATE_TYPE = {
		SETTLEMENT = 3,
		STARTED = 2,
		NOTSTARTED = 1
	},
	ITEM_TYPE = {
		BLOOD = 7,
		ARTIFACT_UP_LEVEL = 5,
		BUFF = 4,
		COIN = 1,
		HERO = 3,
		ARTIFACT = 6
	},
	REWARD_TYEP = {
		TEAMMATE = 2,
		ARTIFACT_1 = 3001,
		ARTIFACT_2 = 3002,
		ARTIFACT_4 = 3004,
		CURRENCY = 1,
		ARTIFACT_3 = 3003,
		ARTIFACT_SPEC = 3007,
		ARTIFACT_6 = 3006,
		EMPTY = 6,
		ARTIFACT_5 = 3005,
		SHOP = 5,
		ARTIFACT_STRENGTH = 7,
		HERO_ATTRIBUTE = 4,
		ARTIFACT = 3
	},
	ENLIST_TYPE = {
		GIVE_UP = 0,
		PAY = 2,
		FREE = 3,
		BATTLE = 1
	},
	RANK_TYPE = {
		ALL = 1,
		GUILD = 2
	},
	RANK_SUB_TYPE = {
		SCORE = 1,
		HERO = 2
	},
	EFFECT_ACTION = {
		AFFIX = 4,
		ATTRIBUTE_MULTIPLE_ARTIFACT_NUM = 5,
		ATTRIBUTE = 2
	},
	EFFECT_MOMENT = {
		FOREVER = 2
	},
	AFFIX_TYPE = {
		MATRIX_BEACON = 806
	},
	REVIVE_COIN_EFFECT = {
		BEACON = {
			[5] = true
		},
		TERMINAL = {
			[1101] = true
		}
	},
	POLYHEDRON_SETTING_ID = {
		SHOP_RECOVER = 15
	}
}
PolyhedronConst.SPECIAL_ATTR_DESC = {}

local var_0_0 = GameSetting.polyhedron_difficulty_affixes.value

for iter_0_0, iter_0_1 in ipairs(var_0_0) do
	PolyhedronConst.SPECIAL_ATTR_DESC[iter_0_1[1]] = iter_0_1
end

PolyhedronTools = {}

function PolyhedronTools.GetPolicyActivityID()
	local var_1_0 = PolyhedronData:GetActivityID()

	if not PolyhedronPolicyCfg.get_id_list_by_activity_id[var_1_0] then
		return 0
	else
		return var_1_0
	end
end

function PolyhedronTools.GetPolicyIDList()
	local var_2_0 = PolyhedronTools.GetPolicyActivityID()

	return PolyhedronPolicyCfg.get_id_list_by_activity_id[var_2_0]
end

function PolyhedronTools.PolyhedronPolicyExpToLevel()
	local var_3_0 = PolyhedronTools.GetPolicyIDList()
	local var_3_1 = #var_3_0
	local var_3_2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SHIFTING_EXP)
	local var_3_3 = 0
	local var_3_4 = var_3_2

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if var_3_2 < PolyhedronPolicyCfg[iter_3_1].exp then
			return var_3_3, var_3_4
		else
			var_3_3 = iter_3_0

			if iter_3_0 < var_3_1 then
				var_3_4 = var_3_2 - PolyhedronPolicyCfg[iter_3_1].exp
			end
		end
	end

	return var_3_3, var_3_4
end

function PolyhedronTools.PolyhedronTerminalExpToLevel(arg_4_0)
	local var_4_0 = PolyhedronTerminalLevelCfg.all
	local var_4_1 = 1
	local var_4_2 = #var_4_0
	local var_4_3 = -1

	while var_4_1 <= var_4_2 do
		local var_4_4 = var_4_1 + math.floor((var_4_2 - var_4_1) / 2)

		if arg_4_0 < PolyhedronTerminalLevelCfg[var_4_0[var_4_4]].exp then
			var_4_2 = var_4_4 - 1
		else
			var_4_3 = var_4_4
			var_4_1 = var_4_4 + 1
		end
	end

	local var_4_5 = arg_4_0 - PolyhedronTerminalLevelCfg[var_4_0[var_4_3]].exp

	return var_4_0[var_4_3], var_4_5
end

function PolyhedronTools.GetRaceEffect(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = 0
	local var_5_2 = false
	local var_5_3 = 3
	local var_5_4 = PolyhedronData:GetPolyhedronInfo():GetTotalAffix()

	for iter_5_0, iter_5_1 in ipairs(var_5_4) do
		if iter_5_1[1] == PolyhedronConst.AFFIX_TYPE.MATRIX_BEACON then
			var_5_3 = 2
		end
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0) do
		if iter_5_3 ~= 0 then
			local var_5_5 = HeroCfg[iter_5_3].race

			var_5_0[var_5_5] = (var_5_0[var_5_5] or 0) + 1

			if var_5_0[var_5_5] == 2 then
				var_5_1 = var_5_5
			end

			if var_5_3 <= var_5_0[var_5_5] then
				var_5_2 = true
			end
		end
	end

	return var_5_1, var_5_2, var_5_0[var_5_1] or 1
end

function PolyhedronTools.GetBeaconIsUnlockCondition(arg_6_0)
	local var_6_0 = PolyhedronBeaconCfg[arg_6_0]

	if var_6_0 and var_6_0.condition ~= 0 then
		return IsConditionAchieved(var_6_0.condition)
	end

	return true
end

function PolyhedronTools.CalPolyhedronDifficultyAttr(arg_7_0, arg_7_1)
	for iter_7_0 = 1, arg_7_1 do
		local var_7_0 = PolyhedronDifficultyCfg[iter_7_0].params

		for iter_7_1, iter_7_2 in ipairs(var_7_0) do
			if iter_7_2[1] == 2 then
				local var_7_1 = iter_7_2[2]
				local var_7_2 = iter_7_2[3]

				arg_7_0[var_7_1] = HeroTools.AttributeAdd(var_7_1, arg_7_0[var_7_1], var_7_2)
			end
		end
	end

	return arg_7_0
end

function PolyhedronTools.GetPolyhedronDifficultyAffixDir(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = 1, arg_8_0 do
		local var_8_1 = PolyhedronDifficultyCfg[iter_8_0].params

		for iter_8_1, iter_8_2 in ipairs(var_8_1) do
			if iter_8_2[1] == 1 then
				local var_8_2 = iter_8_2[2]
				local var_8_3 = iter_8_2[3]
				local var_8_4 = iter_8_2[4]

				var_8_0[var_8_2] = {
					var_8_2,
					var_8_3,
					var_8_4
				}
			end
		end
	end

	return var_8_0
end

function PolyhedronTools.GetPolyhedronTerminalClassifyDes(arg_9_0)
	return GetTips("POLYHEDRON_TERMINAL_CLASSIFY_" .. arg_9_0)
end

function PolyhedronTools.GetPolyhedronArtifactSubTypeDes(arg_10_0)
	return GetTips("POLYHEDRON_ARTIFACT_SUB_TYPE_" .. arg_10_0)
end

function PolyhedronTools.GetGateCfg(arg_11_0, arg_11_1)
	local var_11_0 = PolyhedronEventCfg[arg_11_0]

	for iter_11_0, iter_11_1 in ipairs(PolyhedronGateCfg.all) do
		local var_11_1 = PolyhedronGateCfg[iter_11_1]

		if (var_11_1.event_type == 0 or var_11_0.event_type == var_11_1.event_type) and (var_11_1.reward_type == 0 or arg_11_1 == var_11_1.reward_type) then
			return var_11_1
		end
	end

	print("polyhedron error cant find gate index by" .. arg_11_0 .. ":" .. arg_11_1)

	return {
		reward_type = 0,
		gate_index = 999,
		event_type = 0,
		gate_des = ""
	}
end

function PolyhedronTools.getAffixUpLvDes(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = AffixTypeCfg[arg_12_0]

	if var_12_0 == nil then
		-- block empty
	end

	local var_12_1 = var_12_0.description[1]
	local var_12_2 = DescriptionCfg[var_12_1]

	if not var_12_2 then
		return ""
	end

	local function var_12_3(arg_13_0, arg_13_1)
		if arg_13_1 then
			return math.floor(arg_13_0 * 10^arg_13_1 + 0.5) / 10^arg_13_1
		else
			return math.floor(arg_13_0 + 0.5)
		end
	end

	local var_12_4 = GetI18NText(var_12_2.description)

	if var_12_2.type == 1 then
		if arg_12_2 > var_12_2.maxLv or arg_12_2 < 1 then
			return ""
		end

		if arg_12_1 > var_12_2.maxLv or arg_12_1 < 1 then
			return ""
		end

		local var_12_5 = var_12_2.param

		if #var_12_5 >= 1 then
			local var_12_6 = {
				"0"
			}

			for iter_12_0, iter_12_1 in ipairs(var_12_5) do
				local var_12_7 = iter_12_1[1]
				local var_12_8 = iter_12_1[2]
				local var_12_9 = iter_12_1[4]
				local var_12_10 = var_12_3(var_12_7 + var_12_8 * (arg_12_1 - 1), 1)

				if var_12_10 % 1 == 0 then
					var_12_10 = string.format("%.0f", var_12_10) .. var_12_9
				else
					var_12_10 = string.format("%.1f", var_12_10) .. var_12_9
				end

				local var_12_11 = var_12_3(var_12_7 + var_12_8 * (arg_12_2 - 1), 1)

				if var_12_11 % 1 == 0 then
					var_12_11 = string.format("%.0f", var_12_11) .. var_12_9
				else
					var_12_11 = string.format("%.1f", var_12_11) .. var_12_9
				end

				if var_12_10 ~= var_12_11 then
					table.insert(var_12_6, var_12_10 .. "->" .. var_12_11)
				else
					table.insert(var_12_6, var_12_10)
				end
			end

			return LuaExchangeHelper.GetDescription(var_12_4, var_12_6)
		else
			return var_12_4
		end
	else
		local var_12_12 = var_12_2.param[arg_12_1]
		local var_12_13 = var_12_2.param[arg_12_2]

		if not var_12_12 or not var_12_13 then
			return ""
		end

		local var_12_14 = {}
		local var_12_15 = #var_12_12

		for iter_12_2 = 1, var_12_15 do
			local var_12_16

			if var_12_12[iter_12_2] ~= var_12_13[iter_12_2] then
				var_12_16 = var_12_12[iter_12_2] .. "->" .. var_12_13[iter_12_2]
			else
				var_12_16 = var_12_12[iter_12_2]
			end

			table.insert(var_12_14, var_12_16)
		end

		if #var_12_14 > 1 then
			return LuaExchangeHelper.GetDescription(var_12_4, var_12_14)
		else
			return var_12_4
		end
	end
end

function PolyhedronTools.ArtifactSubTypeSorter(arg_14_0, arg_14_1)
	local var_14_0 = 3007

	if arg_14_0 == var_14_0 or arg_14_1 == var_14_0 then
		return arg_14_0 == var_14_0
	end

	return arg_14_1 < arg_14_0
end

PolyhedronTemplate = class("PolyhedronProcessTemplate")

function PolyhedronTemplate.Ctor(arg_15_0, arg_15_1)
	arg_15_0:UpdateGame(arg_15_1)
end

function PolyhedronTemplate.UpdateGame(arg_16_0, arg_16_1)
	arg_16_0.state = arg_16_1.state

	local var_16_0 = arg_16_1.start_info

	arg_16_0.leader = PolyhedronSnapShotTemplate.New(var_16_0.leader)
	arg_16_0.beacon_id_list = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0.beacon_id_list) do
		table.insert(arg_16_0.beacon_id_list, iter_16_1)
	end

	arg_16_0.difficulty = var_16_0.difficulty
	arg_16_0.terminal_id_list = {}

	for iter_16_2, iter_16_3 in ipairs(var_16_0.terminal_id_list) do
		table.insert(arg_16_0.terminal_id_list, iter_16_3)
	end

	arg_16_0:UpdatePocess(arg_16_1.progress)
end

function PolyhedronTemplate.UpdatePocess(arg_17_0, arg_17_1)
	arg_17_0.tier_id = arg_17_1.tier_id
	arg_17_0.event = PolyhedronEventTemplate.New(arg_17_1.event)
	arg_17_0.stage = PolyhedronStageTemplate.New(arg_17_1.stage)
	arg_17_0.hero_list = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1.hero_list) do
		arg_17_0.hero_list[iter_17_1.hero_id] = PolyhedronHeroTemplate.New(iter_17_1)
	end

	arg_17_0.fight_hero_id_list = {}

	for iter_17_2, iter_17_3 in ipairs(arg_17_1.fight_hero_id_list) do
		table.insert(arg_17_0.fight_hero_id_list, iter_17_3)
	end

	arg_17_0.artifact_list = {}

	for iter_17_4, iter_17_5 in ipairs(arg_17_1.artifact_list) do
		table.insert(arg_17_0.artifact_list, {
			id = iter_17_5.id,
			level = iter_17_5.level
		})
	end

	arg_17_0.effect_list = {}

	for iter_17_6, iter_17_7 in ipairs(arg_17_1.effect_list) do
		table.insert(arg_17_0.effect_list, {
			id = iter_17_7.id
		})
	end

	arg_17_0.attribute_list = {}

	for iter_17_8, iter_17_9 in ipairs(arg_17_1.attribute_list) do
		local var_17_0 = iter_17_9.id
		local var_17_1 = iter_17_9.value

		arg_17_0.attribute_list[var_17_0] = var_17_1
	end

	arg_17_0.stackable_item_list = {}

	for iter_17_10, iter_17_11 in ipairs(arg_17_1.stackable_item_list) do
		local var_17_2 = iter_17_11.id
		local var_17_3 = iter_17_11.num

		arg_17_0.stackable_item_list[var_17_2] = var_17_3
	end
end

function PolyhedronTemplate.GetState(arg_18_0)
	return arg_18_0.state
end

function PolyhedronTemplate.GetTierId(arg_19_0)
	return arg_19_0.tier_id
end

function PolyhedronTemplate.GetDifficulty(arg_20_0)
	return arg_20_0.difficulty
end

function PolyhedronTemplate.GetArtifact(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.artifact_list) do
		if iter_21_1.id == arg_21_1 then
			return iter_21_1
		end
	end
end

function PolyhedronTemplate.GetBeaconList(arg_22_0)
	return arg_22_0.beacon_id_list
end

function PolyhedronTemplate.GetArtifactList(arg_23_0)
	return arg_23_0.artifact_list
end

function PolyhedronTemplate.GetTerminalIdList(arg_24_0)
	return arg_24_0.terminal_id_list
end

function PolyhedronTemplate.GetSavePoint(arg_25_0)
	return arg_25_0.stage.save_point
end

function PolyhedronTemplate.GetStageId(arg_26_0)
	return arg_26_0.stage.stage_id
end

function PolyhedronTemplate.GetGateData(arg_27_0, arg_27_1)
	return arg_27_0.stage.gate_list[arg_27_1]
end

function PolyhedronTemplate.GetRewardList(arg_28_0)
	return arg_28_0.stage:GetRewardList()
end

function PolyhedronTemplate.GetTipsList(arg_29_0)
	return arg_29_0.stage:GetTipsList()
end

function PolyhedronTemplate.GetEnlistHeroList(arg_30_0)
	local var_30_0 = arg_30_0.stage.params
	local var_30_1 = math.floor(#var_30_0 / 2)
	local var_30_2 = {}

	for iter_30_0 = 1, var_30_1 do
		table.insert(var_30_2, {
			heroId = var_30_0[iter_30_0 * 2 - 1],
			enlist_type = var_30_0[iter_30_0 * 2]
		})
	end

	return var_30_2
end

function PolyhedronTemplate.GetShopItemList(arg_31_0)
	return arg_31_0.stage.shop_item_list
end

function PolyhedronTemplate.GetShopRefreshTimes(arg_32_0)
	return arg_32_0.stage.refresh_times
end

function PolyhedronTemplate.GetShopRecoverTimes(arg_33_0)
	return arg_33_0.stage.recover_times
end

function PolyhedronTemplate.GetRewardType(arg_34_0)
	return arg_34_0.event.reward_type
end

function PolyhedronTemplate.GetPolyhedronLeader(arg_35_0)
	return arg_35_0.leader
end

function PolyhedronTemplate.GetLeaderHeroId(arg_36_0)
	return arg_36_0.leader:GetHeroId()
end

function PolyhedronTemplate.GetFightHeroList(arg_37_0)
	return arg_37_0.fight_hero_id_list
end

function PolyhedronTemplate.GetHeroList(arg_38_0)
	return table.keys(arg_38_0.hero_list)
end

function PolyhedronTemplate.GetHeroPolyData(arg_39_0, arg_39_1)
	return arg_39_0.hero_list[arg_39_1]
end

function PolyhedronTemplate.GetCoinCount(arg_40_0)
	return arg_40_0.stackable_item_list[1] or 0
end

function PolyhedronTemplate.GetAttribulteValue(arg_41_0, arg_41_1)
	local var_41_0 = PolyhedronAttributeIdCfg[arg_41_1]

	return arg_41_0.attribute_list[var_41_0.id]
end

function PolyhedronTemplate.GetReviveCount(arg_42_0)
	local var_42_0 = 3

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.beacon_id_list) do
		if PolyhedronConst.REVIVE_COIN_EFFECT.BEACON[iter_42_1] == true then
			var_42_0 = var_42_0 + 1
		end
	end

	for iter_42_2, iter_42_3 in ipairs(arg_42_0.terminal_id_list) do
		if PolyhedronConst.REVIVE_COIN_EFFECT.TERMINAL[iter_42_3] == true then
			var_42_0 = var_42_0 + 1
		end
	end

	return arg_42_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_LEADER_REBORN_TIMES") or 0, var_42_0
end

function PolyhedronTemplate.GetReviveHp(arg_43_0)
	local var_43_0 = arg_43_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_REBORN_HEALTH_PERCENT")

	if var_43_0 then
		return var_43_0 / 10
	else
		return 100
	end
end

function PolyhedronTemplate.ReviveMaxCount(arg_44_0)
	return arg_44_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_LEADER_REBORN_MAX_TIMES") or 0
end

function PolyhedronTemplate.GetRollGateCount(arg_45_0)
	return arg_45_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_RE_ROLL_GATE_TIMES") or 0
end

function PolyhedronTemplate.GetRollRewardCount(arg_46_0)
	return arg_46_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_RE_ROLL_ARTIFACT_REWARD_TIMES") or 0
end

function PolyhedronTemplate.GetShopFressRefreshTimes(arg_47_0)
	return arg_47_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_SHOP_FREE_REFRESH_TIME") or 0
end

function PolyhedronTemplate.GetShopMaxRefreshTimes(arg_48_0)
	return arg_48_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_SHOP_REFRESH_TIME") or 0
end

function PolyhedronTemplate.GetShopRecoverMaxTimes(arg_49_0)
	return arg_49_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_SHOP_RECOVER_TIME") or 0
end

function PolyhedronTemplate.GetRewardGiveUpCoinAdd(arg_50_0)
	return arg_50_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_GIVE_UP_ADD_COIN_NUM") or 0
end

function PolyhedronTemplate.GetTeamateRebornMaxColdDown(arg_51_0)
	return arg_51_0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_TEAMMATE_REBORN_MAX_COLD_DOWN") or 0
end

function PolyhedronTemplate.GetPolyhedronCoinId(arg_52_0)
	return 26
end

function PolyhedronTemplate.GetShopRefreshCost(arg_53_0, arg_53_1)
	local var_53_0 = PolyhedronSettingCfg[14]

	for iter_53_0, iter_53_1 in ipairs(var_53_0.value) do
		if iter_53_1[1] == arg_53_1 then
			return iter_53_1[2]
		end
	end

	local var_53_1 = #var_53_0.value

	return var_53_0.value[var_53_1][2]
end

function PolyhedronTemplate.GetRewardGiveUpCoin(arg_54_0)
	return PolyhedronSettingCfg[21].value[1] + arg_54_0:GetRewardGiveUpCoinAdd()
end

function PolyhedronTemplate.GetShopOriginalPrice(arg_55_0, arg_55_1)
	local var_55_0 = PolyhedronSettingCfg[13]

	for iter_55_0, iter_55_1 in ipairs(var_55_0.value) do
		if iter_55_1[1] == arg_55_1 then
			return iter_55_1[2]
		end
	end

	return 0
end

function PolyhedronTemplate.GetTotalAffix(arg_56_0)
	local var_56_0 = {}
	local var_56_1 = PolyhedronTools.GetPolyhedronDifficultyAffixDir(arg_56_0.difficulty)

	for iter_56_0, iter_56_1 in pairs(var_56_1) do
		table.insert(var_56_0, iter_56_1)
	end

	for iter_56_2, iter_56_3 in ipairs(arg_56_0.effect_list) do
		local var_56_2 = PolyhedronEffectCfg[iter_56_3.id]

		if PolyhedronConst.EFFECT_ACTION.AFFIX == var_56_2.action then
			for iter_56_4, iter_56_5 in ipairs(var_56_2.params) do
				table.insert(var_56_0, iter_56_5)
			end
		end
	end

	local var_56_3 = arg_56_0:GetCoinCount()

	for iter_56_6, iter_56_7 in ipairs(arg_56_0.artifact_list) do
		local var_56_4 = iter_56_7.id
		local var_56_5 = iter_56_7.level

		if var_56_4 >= 70701 and var_56_4 <= 70750 then
			var_56_5 = var_56_5 * var_56_3
		end

		local var_56_6 = PolyhedronArtifactCfg[var_56_4]

		table.insert(var_56_0, {
			var_56_6.affix_id,
			var_56_5,
			var_56_6.affix_target
		})
	end

	return var_56_0
end

function PolyhedronTemplate.CalPolyhedronAttribute(arg_57_0, arg_57_1)
	local var_57_0 = {}
	local var_57_1 = #arg_57_0.artifact_list

	for iter_57_0, iter_57_1 in ipairs(arg_57_0.effect_list) do
		if iter_57_1.id == 2014 then
			CustomLog.Log(debug.traceback(string.format("2014")))
		end

		local var_57_2 = PolyhedronEffectCfg[iter_57_1.id]

		if PolyhedronConst.EFFECT_MOMENT.FOREVER == var_57_2.moment then
			if PolyhedronConst.EFFECT_ACTION.ATTRIBUTE == var_57_2.action then
				for iter_57_2, iter_57_3 in ipairs(var_57_2.params) do
					local var_57_3 = iter_57_3[1]
					local var_57_4 = iter_57_3[2]

					var_57_0[var_57_3] = HeroTools.AttributeAdd(var_57_3, var_57_0[var_57_3], var_57_4)
				end
			elseif PolyhedronConst.EFFECT_ACTION.ATTRIBUTE_MULTIPLE_ARTIFACT_NUM == var_57_2.action then
				for iter_57_4, iter_57_5 in ipairs(var_57_2.params) do
					local var_57_5 = iter_57_5[1]
					local var_57_6 = iter_57_5[2] * var_57_1

					var_57_0[var_57_5] = HeroTools.AttributeAdd(var_57_5, var_57_0[var_57_5], var_57_6)
				end
			end
		end
	end

	local var_57_7 = arg_57_0.hero_list[arg_57_1]

	if var_57_7 then
		for iter_57_6, iter_57_7 in ipairs(var_57_7.difference_attribute_list) do
			local var_57_8 = iter_57_7.id
			local var_57_9 = iter_57_7.value

			var_57_0[var_57_8] = HeroTools.AttributeAdd(var_57_8, var_57_0[var_57_8], var_57_9)
		end
	end

	return var_57_0
end

PolyhedronSnapShotTemplate = class("PolyhedronSnapShotTemplate")

function PolyhedronSnapShotTemplate.Ctor(arg_58_0, arg_58_1)
	arg_58_0.hero_id = arg_58_1.hero_id
	arg_58_0.astrolabe_list = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1.astrolabe_list) do
		table.insert(arg_58_0.astrolabe_list, iter_58_1)
	end
end

function PolyhedronSnapShotTemplate.GetHeroId(arg_59_0)
	return arg_59_0.hero_id
end

function PolyhedronSnapShotTemplate.GetVirtualData(arg_60_0)
	local var_60_0 = PolyhedronHeroCfg[arg_60_0.hero_id].standard_id
	local var_60_1 = deepClone(TempHeroData:GetTempHeroDataByTempID(var_60_0))
	local var_60_2 = var_60_1.equip_list

	var_60_1.using_astrolabe = arg_60_0.astrolabe_list
	var_60_1.using_skin = PolyhedronData:GetHeroUsingSkinInfo(arg_60_0.hero_id).id

	for iter_60_0, iter_60_1 in ipairs(var_60_1.skill) do
		local var_60_3 = HeroTools.GetHeroSkillAddLevel(var_60_1, iter_60_1.skill_id)

		iter_60_1.skill_level = iter_60_1.skill_level + var_60_3
	end

	return var_60_1, var_60_2
end

PolyhedronHeroTemplate = class("PolyhedronHeroTemplate")

function PolyhedronHeroTemplate.Ctor(arg_61_0, arg_61_1)
	arg_61_0.hero_id = arg_61_1.hero_id
	arg_61_0.template_id = arg_61_1.template_id
	arg_61_0.health = arg_61_1.health
	arg_61_0.max_health = arg_61_1.max_health
	arg_61_0.reborn_cold_down = arg_61_1.reborn_cold_down
	arg_61_0.difference_attribute_list = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_1.difference_attribute_list) do
		local var_61_0 = iter_61_1.id
		local var_61_1 = iter_61_1.value

		table.insert(arg_61_0.difference_attribute_list, {
			id = var_61_0,
			value = var_61_1
		})
	end

	arg_61_0.injured = arg_61_1.injured
	arg_61_0.heal = arg_61_1.heal
	arg_61_0.damage = arg_61_1.damage
end

function PolyhedronHeroTemplate.IsDead(arg_62_0)
	return arg_62_0.health <= 0
end

function PolyhedronHeroTemplate.GetHeroMaxHP(arg_63_0)
	return arg_63_0.max_health
end

function PolyhedronHeroTemplate.GetHeroHP(arg_64_0)
	return math.ceil(arg_64_0.health)
end

PolyhedronEventTemplate = class("PolyhedronHeroTemplate")

function PolyhedronEventTemplate.Ctor(arg_65_0, arg_65_1)
	arg_65_0.id = arg_65_1.id
	arg_65_0.stage_id = arg_65_1.stage_id
	arg_65_0.reward_type = arg_65_1.reward_type
end

PolyhedronStageTemplate = class("PolyhedronStageTemplate")

function PolyhedronStageTemplate.Ctor(arg_66_0, arg_66_1)
	arg_66_0.stage_id = arg_66_1.stage_id
	arg_66_0.save_point = arg_66_1.save_point

	print("更新保存点" .. arg_66_0.save_point)

	local var_66_0 = arg_66_1.reward

	arg_66_0.rewardRound = var_66_0.round
	arg_66_0.item_list = {}

	for iter_66_0, iter_66_1 in ipairs(var_66_0.item_list) do
		local var_66_1 = {}

		for iter_66_2, iter_66_3 in ipairs(iter_66_1.params) do
			table.insert(var_66_1, iter_66_3)
		end

		table.insert(arg_66_0.item_list, {
			class = iter_66_1.class,
			params = var_66_1
		})
	end

	arg_66_0.params = {}

	for iter_66_4, iter_66_5 in ipairs(arg_66_1.params) do
		table.insert(arg_66_0.params, iter_66_5)
	end

	arg_66_0.gate_list = {}

	for iter_66_6, iter_66_7 in ipairs(arg_66_1.gate_list) do
		local var_66_2 = iter_66_7.index
		local var_66_3 = PolyhedronEventTemplate.New(iter_66_7.event)

		arg_66_0.gate_list[var_66_2] = var_66_3
	end

	local var_66_4 = arg_66_1.shop

	if var_66_4 then
		arg_66_0.refresh_times = var_66_4.refresh_times
		arg_66_0.recover_times = var_66_4.recover_times
		arg_66_0.shop_item_list = {}

		for iter_66_8, iter_66_9 in ipairs(var_66_4.item_list) do
			local var_66_5 = {}
			local var_66_6 = iter_66_9.item

			for iter_66_10, iter_66_11 in ipairs(var_66_6.params) do
				table.insert(var_66_5, iter_66_11)
			end

			local var_66_7 = var_66_6.class
			local var_66_8 = iter_66_9.price

			if iter_66_9.is_available == 1 then
				table.insert(arg_66_0.shop_item_list, {
					class = var_66_7,
					params = var_66_5,
					price = var_66_8,
					shop_index = iter_66_8
				})
			end
		end
	else
		arg_66_0.refresh_times = 0
		arg_66_0.recover_times = 0
		arg_66_0.shop_item_list = {}
	end

	arg_66_0.attribute_modify_list = {}

	for iter_66_12, iter_66_13 in ipairs(arg_66_1.attribute_modify_list) do
		local var_66_9 = {
			attribute_id = iter_66_13.attribute_id
		}

		if iter_66_13.target_id then
			var_66_9.target_id = iter_66_13.target_id
		end

		if iter_66_13.delta then
			var_66_9.delta = iter_66_13.delta
		end

		table.insert(arg_66_0.attribute_modify_list, var_66_9)
	end
end

function PolyhedronStageTemplate.GetRewardList(arg_67_0)
	if PolyhedronConst.SAVE_POINT_TYPE.REWARD == arg_67_0.save_point then
		return arg_67_0.item_list
	end

	return {}
end

function PolyhedronStageTemplate.GetTipsList(arg_68_0)
	return arg_68_0.attribute_modify_list
end

PolyhedronRankTemplate = class("PolyhedronRankTemplate")

function PolyhedronRankTemplate.Ctor(arg_69_0, arg_69_1)
	arg_69_0.user_id = arg_69_1.user_id
	arg_69_0.score = arg_69_1.score
	arg_69_0.difficulty = arg_69_1.difficulty
	arg_69_0.rank = arg_69_1.rank
	arg_69_0.timestamp = arg_69_1.timestamp

	local var_69_0 = PlayerData:GetPlayerInfo()

	if var_69_0 and arg_69_0.user_id == var_69_0.userID then
		arg_69_0.nick = var_69_0.nick
		arg_69_0.icon = var_69_0.portrait
		arg_69_0.icon_frame = var_69_0.icon_frame
	else
		arg_69_0.nick = arg_69_1.nick
		arg_69_0.icon = arg_69_1.portrait
		arg_69_0.icon_frame = arg_69_1.frame
	end

	arg_69_0.select_hero_id_list = {}

	local var_69_1 = arg_69_1.team_info[1] and arg_69_1.team_info[1].hero_info_list or {}

	for iter_69_0, iter_69_1 in ipairs(var_69_1) do
		table.insert(arg_69_0.select_hero_id_list, {
			id = iter_69_1.hero_id,
			skin_id = iter_69_1.skin_id
		})
	end
end
