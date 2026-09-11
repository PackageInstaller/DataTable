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

for iter_0_0, iter_0_1 in ipairs(GameSetting.polyhedron_difficulty_affixes.value) do
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
	return PolyhedronPolicyCfg.get_id_list_by_activity_id[PolyhedronTools.GetPolicyActivityID()]
end

function PolyhedronTools.PolyhedronPolicyExpToLevel()
	local var_3_0 = PolyhedronTools.GetPolicyIDList()
	local var_3_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SHIFTING_EXP)
	local var_3_2 = 0
	local var_3_3 = var_3_1

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if var_3_1 < PolyhedronPolicyCfg[iter_3_1].exp then
			return var_3_2, var_3_3
		else
			var_3_2 = iter_3_0

			if iter_3_0 < #var_3_0 then
				var_3_3 = var_3_1 - PolyhedronPolicyCfg[iter_3_1].exp
			end
		end
	end

	return var_3_2, var_3_3
end

function PolyhedronTools.PolyhedronTerminalExpToLevel(arg_4_0)
	local var_4_0 = -1

	while 1 <= #PolyhedronTerminalLevelCfg.all do
		local var_4_1 = 1 + math.floor((#PolyhedronTerminalLevelCfg.all - 1) / 2)
		local var_4_2, var_4_3

		if arg_4_0 < PolyhedronTerminalLevelCfg[PolyhedronTerminalLevelCfg.all[var_4_1]].exp then
			var_4_2 = var_4_1 - 1
		else
			var_4_0 = var_4_1
			var_4_3 = var_4_1 + 1
		end
	end

	return PolyhedronTerminalLevelCfg.all[var_4_0], arg_4_0 - PolyhedronTerminalLevelCfg[PolyhedronTerminalLevelCfg.all[var_4_0]].exp
end

function PolyhedronTools.GetRaceEffect(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = 0
	local var_5_2 = false
	local var_5_3 = 3

	for iter_5_0, iter_5_1 in ipairs((PolyhedronData:GetPolyhedronInfo():GetTotalAffix())) do
		if iter_5_1[1] == PolyhedronConst.AFFIX_TYPE.MATRIX_BEACON then
			var_5_3 = 2
		end
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0) do
		if iter_5_3 ~= 0 then
			var_5_0[HeroCfg[iter_5_3].race] = (var_5_0[HeroCfg[iter_5_3].race] or 0) + 1

			if var_5_0[HeroCfg[iter_5_3].race] == 2 then
				var_5_1 = HeroCfg[iter_5_3].race
			end

			if var_5_3 <= var_5_0[HeroCfg[iter_5_3].race] then
				var_5_2 = true
			end
		end
	end

	return var_5_1, var_5_2, var_5_0[var_5_1] or 1
end

function PolyhedronTools.GetBeaconIsUnlockCondition(arg_6_0)
	if PolyhedronBeaconCfg[arg_6_0] and PolyhedronBeaconCfg[arg_6_0].condition ~= 0 then
		return IsConditionAchieved(PolyhedronBeaconCfg[arg_6_0].condition)
	end

	return true
end

function PolyhedronTools:CalPolyhedronDifficultyAttr(arg_7_1)
	for iter_7_0 = 1, arg_7_1 do
		for iter_7_1, iter_7_2 in ipairs(PolyhedronDifficultyCfg[iter_7_0].params) do
			if iter_7_2[1] == 2 then
				self[iter_7_2[2]] = HeroTools.AttributeAdd(iter_7_2[2], self[iter_7_2[2]], iter_7_2[3])
			end
		end
	end

	return self
end

function PolyhedronTools.GetPolyhedronDifficultyAffixDir(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = 1, arg_8_0 do
		for iter_8_1, iter_8_2 in ipairs(PolyhedronDifficultyCfg[iter_8_0].params) do
			if iter_8_2[1] == 1 then
				var_8_0[iter_8_2[2]] = {
					iter_8_2[2],
					iter_8_2[3],
					iter_8_2[4]
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
	for iter_11_0, iter_11_1 in ipairs(PolyhedronGateCfg.all) do
		if (PolyhedronGateCfg[iter_11_1].event_type == 0 or PolyhedronEventCfg[arg_11_0].event_type == PolyhedronGateCfg[iter_11_1].event_type) and (PolyhedronGateCfg[iter_11_1].reward_type == 0 or arg_11_1 == PolyhedronGateCfg[iter_11_1].reward_type) then
			return PolyhedronGateCfg[iter_11_1]
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
	if AffixTypeCfg[arg_12_0] == nil then
		-- block empty
	end

	local var_12_0 = DescriptionCfg[AffixTypeCfg[arg_12_0].description[1]]

	if not DescriptionCfg[AffixTypeCfg[arg_12_0].description[1]] then
		return ""
	end

	local function var_12_1(arg_13_0, arg_13_1)
		if arg_13_1 then
			return math.floor(arg_13_0 * 10^arg_13_1 + 0.5) / 10^arg_13_1
		else
			return math.floor(arg_13_0 + 0.5)
		end
	end

	local var_12_2 = GetI18NText(var_12_0.description)

	if var_12_0.type == 1 then
		if arg_12_2 > var_12_0.maxLv or arg_12_2 < 1 then
			return ""
		end

		if arg_12_1 > var_12_0.maxLv or arg_12_1 < 1 then
			return ""
		end

		if #var_12_0.param >= 1 then
			local var_12_3 = {
				"0"
			}

			for iter_12_0, iter_12_1 in ipairs(var_12_0.param) do
				local var_12_4 = iter_12_1[1]
				local var_12_5 = iter_12_1[2]
				local var_12_6 = iter_12_1[4]
				local var_12_7 = var_12_1(iter_12_1[1] + iter_12_1[2] * (arg_12_1 - 1), 1)

				var_12_7 = var_12_7 % 1 == 0 and string.format("%.0f", var_12_7) .. var_12_6 or string.format("%.1f", var_12_7) .. var_12_6

				local var_12_8 = var_12_1(var_12_4 + var_12_5 * (arg_12_2 - 1), 1)

				var_12_8 = var_12_8 % 1 == 0 and string.format("%.0f", var_12_8) .. var_12_6 or string.format("%.1f", var_12_8) .. var_12_6

				if var_12_7 ~= var_12_8 then
					table.insert(var_12_3, var_12_7 .. "->" .. var_12_8)
				else
					table.insert(var_12_3, var_12_7)
				end
			end

			return LuaExchangeHelper.GetDescription(var_12_2, var_12_3)
		else
			return var_12_2
		end
	else
		local var_12_9 = var_12_0.param[arg_12_1]

		if not var_12_0.param[arg_12_1] or not var_12_0.param[arg_12_2] then
			return ""
		end

		local var_12_10 = {}

		for iter_12_2 = 1, #var_12_9 do
			table.insert(var_12_10, var_12_9[iter_12_2] ~= var_12_0.param[arg_12_2][iter_12_2] and var_12_9[iter_12_2] .. "->" .. var_12_0.param[arg_12_2][iter_12_2] or var_12_9[iter_12_2])
		end

		if #var_12_10 > 1 then
			return LuaExchangeHelper.GetDescription(var_12_2, var_12_10)
		else
			return var_12_2
		end
	end
end

function PolyhedronTools.ArtifactSubTypeSorter(arg_14_0, arg_14_1)
	if arg_14_0 == 3007 or arg_14_1 == 3007 then
		return arg_14_0 == 3007
	end

	return arg_14_1 < arg_14_0
end

PolyhedronTemplate = class("PolyhedronProcessTemplate")

function PolyhedronTemplate:Ctor(arg_15_1)
	self:UpdateGame(arg_15_1)
end

function PolyhedronTemplate:UpdateGame(arg_16_1)
	self.state = arg_16_1.state
	self.leader = PolyhedronSnapShotTemplate.New(arg_16_1.start_info.leader)
	self.beacon_id_list = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1.start_info.beacon_id_list) do
		table.insert(self.beacon_id_list, iter_16_1)
	end

	self.difficulty = arg_16_1.start_info.difficulty
	self.terminal_id_list = {}

	for iter_16_2, iter_16_3 in ipairs(arg_16_1.start_info.terminal_id_list) do
		table.insert(self.terminal_id_list, iter_16_3)
	end

	self:UpdatePocess(arg_16_1.progress)
end

function PolyhedronTemplate:UpdatePocess(arg_17_1)
	self.tier_id = arg_17_1.tier_id
	self.event = PolyhedronEventTemplate.New(arg_17_1.event)
	self.stage = PolyhedronStageTemplate.New(arg_17_1.stage)
	self.hero_list = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1.hero_list) do
		self.hero_list[iter_17_1.hero_id] = PolyhedronHeroTemplate.New(iter_17_1)
	end

	self.fight_hero_id_list = {}

	for iter_17_2, iter_17_3 in ipairs(arg_17_1.fight_hero_id_list) do
		table.insert(self.fight_hero_id_list, iter_17_3)
	end

	self.artifact_list = {}

	for iter_17_4, iter_17_5 in ipairs(arg_17_1.artifact_list) do
		table.insert(self.artifact_list, {
			id = iter_17_5.id,
			level = iter_17_5.level
		})
	end

	self.effect_list = {}

	for iter_17_6, iter_17_7 in ipairs(arg_17_1.effect_list) do
		table.insert(self.effect_list, {
			id = iter_17_7.id
		})
	end

	self.attribute_list = {}

	for iter_17_8, iter_17_9 in ipairs(arg_17_1.attribute_list) do
		self.attribute_list[iter_17_9.id] = iter_17_9.value
	end

	self.stackable_item_list = {}

	for iter_17_10, iter_17_11 in ipairs(arg_17_1.stackable_item_list) do
		self.stackable_item_list[iter_17_11.id] = iter_17_11.num
	end
end

function PolyhedronTemplate:GetState()
	return self.state
end

function PolyhedronTemplate:GetTierId()
	return self.tier_id
end

function PolyhedronTemplate:GetDifficulty()
	return self.difficulty
end

function PolyhedronTemplate:GetArtifact(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(self.artifact_list) do
		if iter_21_1.id == arg_21_1 then
			return iter_21_1
		end
	end
end

function PolyhedronTemplate:GetBeaconList()
	return self.beacon_id_list
end

function PolyhedronTemplate:GetArtifactList()
	return self.artifact_list
end

function PolyhedronTemplate:GetTerminalIdList()
	return self.terminal_id_list
end

function PolyhedronTemplate:GetSavePoint()
	return self.stage.save_point
end

function PolyhedronTemplate:GetStageId()
	return self.stage.stage_id
end

function PolyhedronTemplate:GetGateData(arg_27_1)
	return self.stage.gate_list[arg_27_1]
end

function PolyhedronTemplate:GetRewardList()
	return self.stage:GetRewardList()
end

function PolyhedronTemplate:GetTipsList()
	return self.stage:GetTipsList()
end

function PolyhedronTemplate:GetEnlistHeroList()
	local var_30_0 = {}

	for iter_30_0 = 1, math.floor(#self.stage.params / 2) do
		table.insert(var_30_0, {
			heroId = self.stage.params[iter_30_0 * 2 - 1],
			enlist_type = self.stage.params[iter_30_0 * 2]
		})
	end

	return var_30_0
end

function PolyhedronTemplate:GetShopItemList()
	return self.stage.shop_item_list
end

function PolyhedronTemplate:GetShopRefreshTimes()
	return self.stage.refresh_times
end

function PolyhedronTemplate:GetShopRecoverTimes()
	return self.stage.recover_times
end

function PolyhedronTemplate:GetRewardType()
	return self.event.reward_type
end

function PolyhedronTemplate:GetPolyhedronLeader()
	return self.leader
end

function PolyhedronTemplate:GetLeaderHeroId()
	return self.leader:GetHeroId()
end

function PolyhedronTemplate:GetFightHeroList()
	return self.fight_hero_id_list
end

function PolyhedronTemplate:GetHeroList()
	return table.keys(self.hero_list)
end

function PolyhedronTemplate:GetHeroPolyData(arg_39_1)
	return self.hero_list[arg_39_1]
end

function PolyhedronTemplate:GetCoinCount()
	return self.stackable_item_list[1] or 0
end

function PolyhedronTemplate:GetAttribulteValue(arg_41_1)
	return self.attribute_list[PolyhedronAttributeIdCfg[arg_41_1].id]
end

function PolyhedronTemplate:GetReviveCount()
	local var_42_0 = 3

	for iter_42_0, iter_42_1 in ipairs(self.beacon_id_list) do
		if PolyhedronConst.REVIVE_COIN_EFFECT.BEACON[iter_42_1] == true then
			var_42_0 = var_42_0 + 1
		end
	end

	for iter_42_2, iter_42_3 in ipairs(self.terminal_id_list) do
		if PolyhedronConst.REVIVE_COIN_EFFECT.TERMINAL[iter_42_3] == true then
			var_42_0 = var_42_0 + 1
		end
	end

	return self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_LEADER_REBORN_TIMES") or 0, var_42_0
end

function PolyhedronTemplate:GetReviveHp()
	local var_43_0 = self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_REBORN_HEALTH_PERCENT")

	if var_43_0 then
		return var_43_0 / 10
	else
		return 100
	end
end

function PolyhedronTemplate:ReviveMaxCount()
	return self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_LEADER_REBORN_MAX_TIMES") or 0
end

function PolyhedronTemplate:GetRollGateCount()
	return self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_RE_ROLL_GATE_TIMES") or 0
end

function PolyhedronTemplate:GetRollRewardCount()
	return self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_RE_ROLL_ARTIFACT_REWARD_TIMES") or 0
end

function PolyhedronTemplate:GetShopFressRefreshTimes()
	return self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_SHOP_FREE_REFRESH_TIME") or 0
end

function PolyhedronTemplate:GetShopMaxRefreshTimes()
	return self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_SHOP_REFRESH_TIME") or 0
end

function PolyhedronTemplate:GetShopRecoverMaxTimes()
	return self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_SHOP_RECOVER_TIME") or 0
end

function PolyhedronTemplate:GetRewardGiveUpCoinAdd()
	return self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_GIVE_UP_ADD_COIN_NUM") or 0
end

function PolyhedronTemplate:GetTeamateRebornMaxColdDown()
	return self:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_TEAMMATE_REBORN_MAX_COLD_DOWN") or 0
end

function PolyhedronTemplate.GetPolyhedronCoinId(arg_52_0)
	return 26
end

function PolyhedronTemplate.GetShopRefreshCost(arg_53_0, arg_53_1)
	for iter_53_0, iter_53_1 in ipairs(PolyhedronSettingCfg[14].value) do
		if iter_53_1[1] == arg_53_1 then
			return iter_53_1[2]
		end
	end

	return PolyhedronSettingCfg[14].value[#PolyhedronSettingCfg[14].value][2]
end

function PolyhedronTemplate:GetRewardGiveUpCoin()
	return PolyhedronSettingCfg[21].value[1] + self:GetRewardGiveUpCoinAdd()
end

function PolyhedronTemplate.GetShopOriginalPrice(arg_55_0, arg_55_1)
	for iter_55_0, iter_55_1 in ipairs(PolyhedronSettingCfg[13].value) do
		if iter_55_1[1] == arg_55_1 then
			return iter_55_1[2]
		end
	end

	return 0
end

function PolyhedronTemplate:GetTotalAffix()
	local var_56_0 = {}

	for iter_56_0, iter_56_1 in pairs((PolyhedronTools.GetPolyhedronDifficultyAffixDir(self.difficulty))) do
		table.insert(var_56_0, iter_56_1)
	end

	for iter_56_2, iter_56_3 in ipairs(self.effect_list) do
		if PolyhedronConst.EFFECT_ACTION.AFFIX == PolyhedronEffectCfg[iter_56_3.id].action then
			for iter_56_4, iter_56_5 in ipairs(PolyhedronEffectCfg[iter_56_3.id].params) do
				table.insert(var_56_0, iter_56_5)
			end
		end
	end

	local var_56_1 = self:GetCoinCount()

	for iter_56_6, iter_56_7 in ipairs(self.artifact_list) do
		local var_56_2 = iter_56_7.level
		local var_56_4

		if iter_56_7.id >= 70701 and iter_56_7.id <= 70750 then
			var_56_2 = var_56_2 * var_56_1
			var_56_4 = {
				PolyhedronArtifactCfg[iter_56_7.id].affix_id,
				var_56_2
			}
		end

		var_56_4[3] = PolyhedronArtifactCfg[iter_56_7.id].affix_target

		table.insert(var_56_0, var_56_4)
	end

	return var_56_0
end

function PolyhedronTemplate:CalPolyhedronAttribute(arg_57_1)
	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs(self.effect_list) do
		if iter_57_1.id == 2014 then
			CustomLog.Log(debug.traceback(string.format("2014")))
		end

		local var_57_1 = PolyhedronEffectCfg[iter_57_1.id]

		if PolyhedronConst.EFFECT_MOMENT.FOREVER == PolyhedronEffectCfg[iter_57_1.id].moment then
			if PolyhedronConst.EFFECT_ACTION.ATTRIBUTE == var_57_1.action then
				for iter_57_2, iter_57_3 in ipairs(var_57_1.params) do
					var_57_0[iter_57_3[1]] = HeroTools.AttributeAdd(iter_57_3[1], var_57_0[iter_57_3[1]], iter_57_3[2])
				end
			elseif PolyhedronConst.EFFECT_ACTION.ATTRIBUTE_MULTIPLE_ARTIFACT_NUM == var_57_1.action then
				for iter_57_4, iter_57_5 in ipairs(var_57_1.params) do
					var_57_0[iter_57_5[1]] = HeroTools.AttributeAdd(iter_57_5[1], var_57_0[iter_57_5[1]], iter_57_5[2] * #self.artifact_list)
				end
			end
		end
	end

	if self.hero_list[arg_57_1] then
		for iter_57_6, iter_57_7 in ipairs(self.hero_list[arg_57_1].difference_attribute_list) do
			var_57_0[iter_57_7.id] = HeroTools.AttributeAdd(iter_57_7.id, var_57_0[iter_57_7.id], iter_57_7.value)
		end
	end

	return var_57_0
end

PolyhedronSnapShotTemplate = class("PolyhedronSnapShotTemplate")

function PolyhedronSnapShotTemplate:Ctor(arg_58_1)
	self.hero_id = arg_58_1.hero_id
	self.astrolabe_list = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1.astrolabe_list) do
		table.insert(self.astrolabe_list, iter_58_1)
	end
end

function PolyhedronSnapShotTemplate:GetHeroId()
	return self.hero_id
end

function PolyhedronSnapShotTemplate:GetVirtualData()
	local var_60_0 = deepClone(TempHeroData:GetTempHeroDataByTempID(PolyhedronHeroCfg[self.hero_id].standard_id))

	var_60_0.using_astrolabe = self.astrolabe_list
	var_60_0.using_skin = PolyhedronData:GetHeroUsingSkinInfo(self.hero_id).id

	for iter_60_0, iter_60_1 in ipairs(var_60_0.skill) do
		iter_60_1.skill_level = iter_60_1.skill_level + HeroTools.GetHeroSkillAddLevel(var_60_0, iter_60_1.skill_id)
	end

	return var_60_0, var_60_0.equip_list
end

PolyhedronHeroTemplate = class("PolyhedronHeroTemplate")

function PolyhedronHeroTemplate:Ctor(arg_61_1)
	self.hero_id = arg_61_1.hero_id
	self.template_id = arg_61_1.template_id
	self.health = arg_61_1.health
	self.max_health = arg_61_1.max_health
	self.reborn_cold_down = arg_61_1.reborn_cold_down
	self.difference_attribute_list = {}

	for iter_61_0, iter_61_1 in ipairs(arg_61_1.difference_attribute_list) do
		table.insert(self.difference_attribute_list, {
			id = iter_61_1.id,
			value = iter_61_1.value
		})
	end

	self.injured = arg_61_1.injured
	self.heal = arg_61_1.heal
	self.damage = arg_61_1.damage
end

function PolyhedronHeroTemplate:IsDead()
	return self.health <= 0
end

function PolyhedronHeroTemplate:GetHeroMaxHP()
	return self.max_health
end

function PolyhedronHeroTemplate:GetHeroHP()
	return math.ceil(self.health)
end

PolyhedronEventTemplate = class("PolyhedronHeroTemplate")

function PolyhedronEventTemplate.Ctor(arg_65_0, arg_65_1)
	arg_65_0.id = arg_65_1.id
	arg_65_0.stage_id = arg_65_1.stage_id
	arg_65_0.reward_type = arg_65_1.reward_type
end

PolyhedronStageTemplate = class("PolyhedronStageTemplate")

function PolyhedronStageTemplate:Ctor(arg_66_1)
	self.stage_id = arg_66_1.stage_id
	self.save_point = arg_66_1.save_point

	print("更新保存点" .. self.save_point)

	self.rewardRound = arg_66_1.reward.round
	self.item_list = {}

	for iter_66_0, iter_66_1 in ipairs(arg_66_1.reward.item_list) do
		local var_66_0 = {}

		for iter_66_2, iter_66_3 in ipairs(iter_66_1.params) do
			table.insert(var_66_0, iter_66_3)
		end

		table.insert(self.item_list, {
			class = iter_66_1.class,
			params = var_66_0
		})
	end

	self.params = {}

	for iter_66_4, iter_66_5 in ipairs(arg_66_1.params) do
		table.insert(self.params, iter_66_5)
	end

	self.gate_list = {}

	for iter_66_6, iter_66_7 in ipairs(arg_66_1.gate_list) do
		self.gate_list[iter_66_7.index] = PolyhedronEventTemplate.New(iter_66_7.event)
	end

	if arg_66_1.shop then
		self.refresh_times = arg_66_1.shop.refresh_times
		self.recover_times = arg_66_1.shop.recover_times
		self.shop_item_list = {}

		for iter_66_8, iter_66_9 in ipairs(arg_66_1.shop.item_list) do
			local var_66_1 = {}

			for iter_66_10, iter_66_11 in ipairs(iter_66_9.item.params) do
				table.insert(var_66_1, iter_66_11)
			end

			if iter_66_9.is_available == 1 then
				table.insert(self.shop_item_list, {
					class = iter_66_9.item.class,
					params = var_66_1,
					price = iter_66_9.price,
					shop_index = iter_66_8
				})
			end
		end
	else
		self.refresh_times = 0
		self.recover_times = 0
		self.shop_item_list = {}
	end

	self.attribute_modify_list = {}

	for iter_66_12, iter_66_13 in ipairs(arg_66_1.attribute_modify_list) do
		local var_66_2 = {
			attribute_id = iter_66_13.attribute_id
		}

		if iter_66_13.target_id then
			var_66_2.target_id = iter_66_13.target_id
		end

		if iter_66_13.delta then
			var_66_2.delta = iter_66_13.delta
		end

		table.insert(self.attribute_modify_list, var_66_2)
	end
end

function PolyhedronStageTemplate:GetRewardList()
	if PolyhedronConst.SAVE_POINT_TYPE.REWARD == self.save_point then
		return self.item_list
	end

	return {}
end

function PolyhedronStageTemplate:GetTipsList()
	return self.attribute_modify_list
end

PolyhedronRankTemplate = class("PolyhedronRankTemplate")

function PolyhedronRankTemplate:Ctor(arg_69_1)
	self.user_id = arg_69_1.user_id
	self.score = arg_69_1.score
	self.difficulty = arg_69_1.difficulty
	self.rank = arg_69_1.rank
	self.timestamp = arg_69_1.timestamp

	local var_69_0 = PlayerData:GetPlayerInfo()

	if var_69_0 and self.user_id == var_69_0.userID then
		self.nick = var_69_0.nick
		self.icon = var_69_0.portrait
		self.icon_frame = var_69_0.icon_frame
	else
		self.nick = arg_69_1.nick
		self.icon = arg_69_1.portrait
		self.icon_frame = arg_69_1.frame
	end

	self.select_hero_id_list = {}

	for iter_69_0, iter_69_1 in ipairs((arg_69_1.team_info[1] or nil) and (arg_69_1.team_info[1].hero_info_list or {})) do
		table.insert(self.select_hero_id_list, {
			id = iter_69_1.hero_id,
			skin_id = iter_69_1.skin_id
		})
	end
end
