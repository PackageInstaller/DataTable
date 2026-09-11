local var_0_0 = singletonClass("SummerRaceData")

function var_0_0.GetEventRuntimeUpdated()
	return SummerRaceConst.EVENT.RUNTIME_UPDATED
end

function var_0_0.GetEventDamageText()
	return SummerRaceConst.EVENT.DAMAGE_TEXT
end

function var_0_0.GetEventPlayerLabelPoseUpdated()
	return SummerRaceConst.EVENT.PLAYER_LABEL_POSE_UPDATED
end

function var_0_0.GetEventSettlementUpdated()
	return SummerRaceConst.EVENT.SETTLEMENT_UPDATED
end

function var_0_0.GetEventStageResolved()
	return SummerRaceConst.EVENT.STAGE_RESOLVED
end

function var_0_0.GetEventOutGameUpdated()
	return SummerRaceConst.EVENT.OUTGAME_UPDATED
end

function var_0_0.GetEventStageItemUnlockAnim()
	return SummerRaceConst.EVENT.STAGE_ITEM_UNLOCK_ANIM
end

function var_0_0.GetEventReturnFromModify()
	return SummerRaceConst.EVENT.RETURN_FROM_MODIFY
end

local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9 = -1

function var_0_0.NormalizeChallengeBestScore(arg_9_0, arg_9_1)
	local var_9_0 = tonumber(arg_9_1)

	if var_9_0 == nil or var_9_0 < 0 then
		return var_0_9
	end

	return math.max(0, math.floor(var_9_0))
end

function var_0_0.InstallDataModules(arg_10_0)
	if var_0_0.dataModulesInstalled_ == true then
		return
	end

	var_0_0.dataList_ = {
		require("game.data.ActivitySubmodule.SummerRaceRedPointData").New(),
		require("game.data.ActivitySubmodule.SummerRaceRewardData").New(),
		require("game.data.ActivitySubmodule.SummerRaceRankData").New()
	}

	for iter_10_0, iter_10_1 in ipairs(var_0_0.dataList_) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1:ExportMethod()) do
			if var_0_0[iter_10_3] then
				-- block empty
			elseif iter_10_1[iter_10_3] == nil then
				-- block empty
			else
				var_0_0[iter_10_3] = function(arg_11_0, ...)
					return iter_10_1[iter_10_3](iter_10_1, arg_11_0, ...)
				end
			end
		end
	end

	var_0_0.dataModulesInstalled_ = true
end

var_0_0:InstallDataModules()

function var_0_0:SortCfgBySort(arg_12_1)
	local var_12_0 = tonumber(self.sort) or tonumber(self.id) or 0
	local var_12_1 = tonumber(arg_12_1.sort) or tonumber(arg_12_1.id) or 0

	if var_12_0 == var_12_1 then
		return (tonumber(self.id) or 0) < (tonumber(arg_12_1.id) or 0)
	end

	return var_12_0 < var_12_1
end

local function var_0_10(arg_13_0)
	local var_13_0 = {}

	for iter_13_0 = 1, #(arg_13_0 or {}) do
		if arg_13_0[iter_13_0].isUnlocked == true then
			var_13_0[#var_13_0 + 1] = arg_13_0[iter_13_0]
		end
	end

	for iter_13_1 = 1, #(arg_13_0 or {}) do
		if arg_13_0[iter_13_1].isUnlocked ~= true then
			var_13_0[#var_13_0 + 1] = arg_13_0[iter_13_1]
		end
	end

	return var_13_0
end

function var_0_0.ResolveTipsText(arg_14_0, arg_14_1)
	local var_14_0 = rawget(_G, "GetTips")

	if type(var_14_0) == "function" then
		return var_14_0(arg_14_1)
	end

	return ""
end

function var_0_0.ResolveDisplayText(arg_15_0, arg_15_1)
	if arg_15_1 == nil then
		return ""
	end

	if GetI18NText then
		return tostring(GetI18NText(arg_15_1))
	end

	return tostring(arg_15_1)
end

function var_0_0.GetGameSettingValueList(arg_16_0, arg_16_1)
	if type(arg_16_1) ~= "table" then
		return nil
	end

	for iter_16_0 = 1, #arg_16_1 do
		if GameSetting then
			local var_16_0 = GameSetting[arg_16_1[iter_16_0]] or nil

			if type(var_16_0) == "table" and type(var_16_0.value) == "table" then
				local var_16_1 = var_16_0.value or nil

				if var_16_1 ~= nil then
					return var_16_1
				end
			end
		end
	end

	return nil
end

function var_0_0.GetChallengeWaveScoreTableFromGameSetting(arg_17_0)
	local var_17_0 = var_0_0:GetGameSettingValueList(SummerRaceConst.CHALLENGE_SCORE_SETTING_KEYS)
	local var_17_1 = {}

	if var_17_0 ~= nil then
		for iter_17_0 = 1, #var_17_0 do
			local var_17_2 = math.floor((tonumber(var_17_0[iter_17_0]) or 0) + 0.5)

			if var_17_2 > 0 then
				var_17_1[#var_17_1 + 1] = var_17_2
			end
		end
	end

	if #var_17_1 < 20 then
		var_17_1 = var_0_0:CloneTable(SummerRaceConst.DEFAULT_CHALLENGE_WAVE_SCORE_TABLE)
	end

	return var_17_1
end

function var_0_0.GetChallengeWaveHealRatioFromGameSetting(arg_18_0)
	local var_18_0 = var_0_0:GetGameSettingValueList(SummerRaceConst.CHALLENGE_HEAL_RATIO_SETTING_KEYS)
	local var_18_1 = var_18_0 and tonumber(var_18_0[1]) or nil

	if var_18_1 == nil then
		error("[SummerRaceData] missing GameSetting for " .. table.concat(SummerRaceConst.CHALLENGE_HEAL_RATIO_SETTING_KEYS, " or "))
	end

	if var_18_1 < 0 or var_18_1 > 1 then
		error("[SummerRaceData] invalid challenge heal ratio, expected 0~1, got " .. tostring(var_18_1))
	end

	return var_18_1
end

function var_0_0.GetDamageToEnergyRatioFromGameSetting(arg_19_0)
	if GameSetting then
		local var_19_0 = GameSetting[SummerRaceConst.DAMAGE_TO_ENERGY_RATIO_SETTING_KEY] or nil
		local var_19_1

		if type(var_19_0) == "table" and type(var_19_0.value) == "table" then
			var_19_1 = var_19_0.value or nil
		end
	end

	local var_19_2 = var_19_1 and tonumber(var_19_1[1]) or nil

	if var_19_2 == nil then
		return 0.25
	end

	if var_19_2 < 0 then
		error("[SummerRaceData] invalid damage->energy ratio, expected >= 0, got " .. tostring(var_19_2))
	end

	return var_19_2
end

function var_0_0.GetEnergyRegenPerSecondFromGameSetting(arg_20_0)
	if GameSetting then
		local var_20_0 = GameSetting[SummerRaceConst.ENERGY_REGEN_PER_SECOND_SETTING_KEY] or nil
		local var_20_1

		if type(var_20_0) == "table" and type(var_20_0.value) == "table" then
			var_20_1 = var_20_0.value or nil
		end
	end

	local var_20_2 = var_20_1 and tonumber(var_20_1[1]) or nil

	if var_20_2 == nil then
		return 1.8
	end

	if var_20_2 < 0 then
		error("[SummerRaceData] invalid energy regen per second, expected >= 0, got " .. tostring(var_20_2))
	end

	return var_20_2
end

function var_0_0.GetMaxEnergyFromGameSetting(arg_21_0)
	if GameSetting then
		local var_21_0 = GameSetting[SummerRaceConst.MAX_ENERGY_SETTING_KEY] or nil
		local var_21_1

		if type(var_21_0) == "table" and type(var_21_0.value) == "table" then
			var_21_1 = var_21_0.value or nil
		end
	end

	local var_21_2 = var_21_1 and tonumber(var_21_1[1]) or nil

	if var_21_2 == nil then
		return 10
	end

	if var_21_2 <= 0 then
		error("[SummerRaceData] invalid max energy, expected > 0, got " .. tostring(var_21_2))
	end

	return var_21_2
end

function var_0_0.BuildBodyIconPath(arg_22_0, arg_22_1)
	local var_22_0 = tonumber(arg_22_1) or 0

	if var_22_0 <= 0 then
		return ""
	end

	return string.format("TextureConfig/Activity_SummerRace/carIcon/%s", tostring(var_22_0))
end

function var_0_0.ResolveLogoSkinName(arg_23_0, arg_23_1)
	local var_23_0 = string.match(tostring(arg_23_1 or ""), "^%s*(.-)%s*$") or ""

	if var_23_0 == "" then
		return ""
	end

	return var_23_0
end

function var_0_0.NormalizeVisualAssetSegment(arg_24_0, arg_24_1)
	return (string.gsub(tostring(arg_24_1 or ""), "%.", "_"))
end

function var_0_0.BuildOptionIconPath(arg_25_0, arg_25_1)
	local var_25_0 = tonumber(arg_25_1) or 0

	if var_25_0 <= 0 then
		return ""
	end

	return string.format("TextureConfig/Activity_SummerRace/equipIcon/%s", tostring(var_25_0))
end

function var_0_0.ResolveRoleIconPath(arg_26_0, arg_26_1)
	local var_26_0 = tostring(arg_26_1 or "")

	if var_26_0 == "" then
		return ""
	end

	return string.format("TextureConfig/Activity_SummerRace/roleIcon/%s", var_26_0)
end

function var_0_0.ResolveEnemyAvatarPath(arg_27_0, arg_27_1)
	if type(arg_27_1) ~= "table" then
		return ""
	end

	return var_0_0:ResolveRoleIconPath(arg_27_1.bodyIcon)
end

function var_0_0.ResolveTeammateAvatarPath(arg_28_0, arg_28_1)
	local var_28_0 = tostring(arg_28_1 or "")

	if var_28_0 == "" then
		return ""
	end

	return var_0_0:ResolveRoleIconPath(string.format("%s_02", var_28_0))
end

function var_0_0.BuildBodyConfigAssetPath(arg_29_0, arg_29_1)
	return string.format("Assets/ABResources/SummerRaceActivity/Config/SummerRaceBody_%s.asset", tostring(arg_29_1))
end

function var_0_0.BuildBodyPrefabPath(arg_30_0, arg_30_1)
	return string.format("Assets/ABResources/SummerRaceActivity/Prefabs/SummerRaceBody_%s.prefab", tostring(arg_30_1))
end

function var_0_0.BuildOptionConfigAssetPath(arg_31_0, arg_31_1, arg_31_2)
	return string.format("Assets/ABResources/SummerRaceActivity/Config/%s%s.asset", arg_31_1 == SummerRaceConst.FILTER.WEAPON and "SummerRaceWeapon_" or "SummerRaceEquip_", tostring(arg_31_2))
end

function var_0_0.BuildBodySpineSkinNames(arg_32_0, arg_32_1, arg_32_2)
	if var_0_0:NormalizeVisualAssetSegment(arg_32_1) == "" then
		return {}
	end

	local var_32_0 = var_0_0:CloneTable(SummerRaceConst.BODY_SPINE_SKIN_NAMES)
	local var_32_1 = var_0_0:ResolveLogoSkinName(arg_32_2)

	if var_32_1 ~= "" then
		var_32_0[#var_32_0 + 1] = var_32_1
	end

	return var_32_0
end

function var_0_0.RequireCfgTable(arg_33_0, arg_33_1, arg_33_2)
	if type(arg_33_1) ~= "table" then
		error("[SummerRaceData] missing config table: " .. arg_33_2)
	end

	return arg_33_1
end

function var_0_0.GetSummerRaceCfgEntries(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = var_0_0:RequireCfgTable(arg_34_1, arg_34_2)
	local var_34_1 = var_34_0.all or {}
	local var_34_2 = {}

	for iter_34_0 = 1, #var_34_1 do
		if var_34_0[var_34_1[iter_34_0]] ~= nil and (var_34_0[var_34_1[iter_34_0]].main_activity_id == nil or var_34_0[var_34_1[iter_34_0]].main_activity_id == SummerRaceConst.ACTIVITY_ID.MAIN) then
			var_34_2[#var_34_2 + 1] = var_34_0[var_34_1[iter_34_0]]
		end
	end

	table.sort(var_34_2, function(arg_35_0, arg_35_1)
		return var_0_0.SortCfgBySort(arg_35_0, arg_35_1)
	end)

	return var_34_2
end

function var_0_0.BuildCostSummary(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = tonumber(arg_36_1) or 0
	local var_36_1 = tonumber(arg_36_2) or SummerRaceConst.BUILD.BUDGET_COST

	return {
		totalCost = var_36_0,
		budgetCost = var_36_1,
		isOverflow = var_36_1 < var_36_0,
		remainingCost = var_36_1 - var_36_0
	}
end

function var_0_0.CloneVector2Contract(arg_37_0, arg_37_1)
	local var_37_0 = {}

	var_37_0.x = arg_37_1 and tonumber(arg_37_1.x) or 0
	var_37_0.y = arg_37_1 and tonumber(arg_37_1.y) or 0

	return var_37_0
end

function var_0_0.BuildSlotLabel(arg_38_0, arg_38_1, arg_38_2)
	return ""
end

function var_0_0.SetNumericFieldIfPresent(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = tonumber(arg_39_3)

	if var_39_0 ~= nil then
		arg_39_1[arg_39_2] = var_39_0
	end
end

function var_0_0.NormalizeIdList(arg_40_0, arg_40_1)
	if type(arg_40_1) == "table" then
		return arg_40_1
	end

	if arg_40_1 == nil or arg_40_1 == "" or arg_40_1 == 0 then
		return {}
	end

	return {
		arg_40_1
	}
end

function var_0_0._GetBodyDefs(arg_41_0)
	if var_0_1 ~= nil then
		return var_0_1
	end

	local var_41_0 = var_0_0:GetSummerRaceCfgEntries(ActivityTankBodyCfg, "ActivityTankBodyCfg")
	local var_41_1 = {}

	for iter_41_0 = 1, #var_41_0 do
		local var_41_2 = var_41_0[iter_41_0]
		local var_41_3 = tostring(var_41_0[iter_41_0].asset_name or "")

		if var_41_3 == "" then
			error("[SummerRaceData] missing body asset_name for bodyId=" .. tostring(var_41_2.id))
		end

		local var_41_4 = #var_41_1 + 1
		local var_41_5 = {
			bodyId = var_41_2.id,
			bodyName = var_0_0:ResolveDisplayText(var_41_2.name),
			desc = var_0_0:ResolveDisplayText(var_41_2.desc)
		}

		var_41_5.hp = tonumber(var_41_2.hp) or 0
		var_41_5.cost = tonumber(var_41_2.cost_cap) or tonumber(var_41_2.cost) or 0
		var_41_5.costCap = tonumber(var_41_2.cost_cap) or tonumber(var_41_2.cost) or 0
		var_41_5.speed = tonumber(var_41_2.speed) or 0
		var_41_5.forwardAcceleration = tonumber(var_41_2.forward_acceleration) or 0
		var_41_5.weaponSlots = tonumber(var_41_2.weapon_slot_count) or tonumber(var_41_2.weapon_slots) or 0
		var_41_5.equipSlots = tonumber(var_41_2.equip_slot_count) or tonumber(var_41_2.equip_slots) or 0
		var_41_5.weightClass = tonumber(var_41_2.weight) or 0
		var_41_5.isUnlocked = tonumber(var_41_2.is_unlocked) ~= 1
		var_41_5.isDefaultUnlocked = tonumber(var_41_2.is_unlocked) ~= 1
		var_41_5.isRecommended = var_41_2.is_recommended == true
		var_41_5.bodyType = tonumber(var_41_2.body_type) or 0
		var_41_5.assetName = var_41_3
		var_41_5.icon = var_0_0:BuildBodyIconPath(var_41_2.id)
		var_41_5.model = tostring(var_41_2.model or "")
		var_41_5.configPath = var_0_0:BuildBodyConfigAssetPath(var_41_3)
		var_41_5.sort = tonumber(var_41_2.sort) or iter_41_0
		var_41_1[var_41_4] = var_41_5
	end

	var_0_1 = var_41_1

	return var_0_1
end

function var_0_0.EnsureOptionDefsBuilt(arg_42_0)
	if var_0_2 ~= nil and var_0_3 ~= nil then
		return
	end

	local var_42_0 = var_0_0:GetSummerRaceCfgEntries(ActivityTankWeaponCfg, "ActivityTankWeaponCfg")
	local var_42_1 = {}
	local var_42_2 = {}

	for iter_42_0 = 1, #var_42_0 do
		local var_42_3 = var_42_0[iter_42_0]
		local var_42_4 = tostring(var_42_0[iter_42_0].asset_name or "")
		local var_42_5 = SummerRaceConst.OPTION_ITEM_TYPE_TO_FILTER[var_42_3.item_type] or SummerRaceConst.FILTER.EQUIP

		if var_42_4 == "" then
			error("[SummerRaceData] missing option asset_name for itemId=" .. tostring(var_42_3.id))
		end

		local var_42_6 = 0
		local var_42_7 = 0

		if var_42_5 == SummerRaceConst.FILTER.WEAPON then
			var_42_6 = tonumber(var_42_3.damage)
			var_42_7 = tonumber(var_42_3.rof)

			if var_42_6 == nil then
				error("[SummerRaceData] missing weapon damage in ActivityTankWeaponCfg, itemId=" .. tostring(var_42_3.id))
			end

			if var_42_7 == nil then
				error("[SummerRaceData] missing weapon rof in ActivityTankWeaponCfg, itemId=" .. tostring(var_42_3.id))
			end

			if var_42_7 <= 0 then
				error("[SummerRaceData] invalid weapon rof <= 0 in ActivityTankWeaponCfg, itemId=" .. tostring(var_42_3.id))
			end
		end

		local var_42_8 = var_0_0:BuildOptionIconPath(var_42_3.id)
		local var_42_9 = var_0_0:BuildOptionVisualLayout(var_42_5, var_42_4)
		local var_42_10 = {
			itemId = var_42_3.id,
			itemName = var_0_0:ResolveDisplayText(var_42_3.name),
			desc = var_0_0:ResolveDisplayText(var_42_3.desc),
			typeText = var_42_5,
			assetName = var_42_4,
			iconPath = var_42_8
		}

		var_42_10.skeletonDataPath = tostring(var_42_9.skeletonDataPath or "")
		var_42_10.cost = tonumber(var_42_3.cost) or 0
		var_42_10.energyCost = tonumber(var_42_3.energy_cost) or 0
		var_42_10.damage = var_42_6
		var_42_10.rof = var_42_7
		var_42_10.weightClass = tonumber(var_42_3.weight) or 0
		var_42_10.valueText = var_0_0:ResolveDisplayText((var_42_3.value_text ~= nil or nil) and (var_42_3.value_text or string.format("DMG %s / ROF %s", tostring(var_42_6), tostring(var_42_7))))
		var_42_10.isUnlocked = tonumber(var_42_3.is_unlocked) ~= 1
		var_42_10.isDefaultUnlocked = tonumber(var_42_3.is_unlocked) ~= 1
		var_42_10.icon = var_42_8
		var_42_10.configPath = var_0_0:BuildOptionConfigAssetPath(var_42_5, var_42_4)
		var_42_10.skillGroup = tonumber(var_42_3.skill_group) or 0
		var_42_10.effectType = tonumber(var_42_3.effect_type) or 0
		var_42_10.effectParams = var_42_3.effect_params or {}
		var_42_10.sort = tonumber(var_42_3.sort) or iter_42_0
		var_42_10.moduleLocalOffset = var_0_0:CloneTable(var_42_9.localOffset)
		var_42_10.moduleLocalAngle = tonumber(var_42_9.localAngle) or 0
		var_42_10.moduleScale = tonumber(var_42_9.scale) or 1
		var_42_10.moduleSize = var_0_0:CloneTable(var_42_9.moduleSize)
		var_42_10.muzzleLocalOffset = var_0_0:CloneTable(var_42_9.muzzleLocalOffset)

		if var_42_10.typeText == SummerRaceConst.FILTER.WEAPON then
			var_42_1[#var_42_1 + 1] = var_42_10
		else
			var_42_2[#var_42_2 + 1] = var_42_10
		end
	end

	var_0_2 = var_42_1
	var_0_3 = var_42_2
end

function var_0_0._GetWeaponDefs(arg_43_0)
	var_0_0:EnsureOptionDefsBuilt()

	return var_0_2
end

function var_0_0._GetEquipDefs(arg_44_0)
	var_0_0:EnsureOptionDefsBuilt()

	return var_0_3
end

function var_0_0.GetIllustratedDefById(arg_45_0, arg_45_1)
	local var_45_0 = tonumber(arg_45_1) or arg_45_1
	local var_45_1 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), var_45_0)

	if var_45_1 ~= nil then
		return var_45_1, SummerRaceConst.FILTER.BODY
	end

	local var_45_2 = var_0_0:FindDefById(var_0_0:_GetWeaponDefs(), var_45_0)

	if var_45_2 ~= nil then
		return var_45_2, SummerRaceConst.FILTER.WEAPON
	end

	local var_45_3 = var_0_0:FindDefById(var_0_0:_GetEquipDefs(), var_45_0)

	if var_45_3 ~= nil then
		return var_45_3, SummerRaceConst.FILTER.EQUIP
	end

	return nil, nil
end

function var_0_0.BuildIllustratedBodyItemData(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = {
		itemId = arg_46_1.bodyId,
		typeText = SummerRaceConst.FILTER.BODY,
		bodyName = arg_46_1.bodyName,
		itemName = arg_46_1.bodyName,
		desc = arg_46_1.desc
	}

	var_46_0.iconPath = tostring(arg_46_1.icon or "")
	var_46_0.cost = tonumber(arg_46_1.cost) or 0
	var_46_0.hp = tonumber(arg_46_1.hp) or 0
	var_46_0.isUnlocked = arg_46_1.isUnlocked ~= false
	var_46_0.isSelected = arg_46_1.bodyId == arg_46_2

	return var_46_0
end

function var_0_0.BuildIllustratedOptionItemData(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = {
		costState = "white",
		itemId = arg_47_1.itemId,
		typeText = arg_47_1.typeText,
		itemName = arg_47_1.itemName,
		desc = arg_47_1.desc
	}

	var_47_0.iconPath = tostring(arg_47_1.icon or "")
	var_47_0.cost = tonumber(arg_47_1.cost) or 0
	var_47_0.damage = tonumber(arg_47_1.damage) or 0
	var_47_0.rof = tonumber(arg_47_1.rof) or 0
	var_47_0.energyCost = tonumber(arg_47_1.energyCost) or 0
	var_47_0.valueText = arg_47_1.valueText
	var_47_0.isUnlocked = arg_47_1.isUnlocked ~= false
	var_47_0.isSelected = arg_47_1.itemId == arg_47_2

	return var_47_0
end

function var_0_0.BuildUnlockedRewardStateFromProgress(arg_48_0)
	local var_48_0 = {
		bodyIds = {},
		optionIds = {}
	}
	local var_48_1 = var_0_0:_GetBodyDefs()

	for iter_48_0 = 1, #var_48_1 do
		if var_48_1[iter_48_0] ~= nil and var_48_1[iter_48_0].isUnlocked == true then
			var_48_0.bodyIds[tonumber(var_48_1[iter_48_0].bodyId) or var_48_1[iter_48_0].bodyId] = true
		end
	end

	local var_48_2 = var_0_0:_GetWeaponDefs()

	for iter_48_1 = 1, #var_48_2 do
		if var_48_2[iter_48_1] ~= nil and var_48_2[iter_48_1].isUnlocked == true then
			var_48_0.optionIds[tonumber(var_48_2[iter_48_1].itemId) or var_48_2[iter_48_1].itemId] = true
		end
	end

	local var_48_3 = var_0_0:_GetEquipDefs()

	for iter_48_2 = 1, #var_48_3 do
		if var_48_3[iter_48_2] ~= nil and var_48_3[iter_48_2].isUnlocked == true then
			var_48_0.optionIds[tonumber(var_48_3[iter_48_2].itemId) or var_48_3[iter_48_2].itemId] = true
		end
	end

	local function var_48_4(arg_49_0)
		for iter_49_0 = 1, #(arg_49_0 or {}) do
			if type(arg_49_0[iter_49_0]) == "table" and arg_49_0[iter_49_0][1] ~= nil then
				local var_49_0 = tonumber(arg_49_0[iter_49_0][1]) or 0
				local var_49_1 = tonumber(arg_49_0[iter_49_0][2]) or arg_49_0[iter_49_0][2] or arg_49_0[iter_49_0][1]

				if var_49_0 == 3 then
					var_48_0.bodyIds[var_49_1] = true
				elseif var_49_0 == 1 or var_49_0 == 2 then
					var_48_0.optionIds[var_49_1] = true
				end
			end
		end
	end

	for iter_48_3, iter_48_4 in pairs(var_0_0:GetTournamentStageMap()) do
		for iter_48_5 = 1, #(iter_48_4 or {}) do
			if iter_48_4[iter_48_5] ~= nil and iter_48_4[iter_48_5].isCompleted == true then
				var_48_4(iter_48_4[iter_48_5].firstReward)
				var_48_4(iter_48_4[iter_48_5].rewardList)
				var_48_4(iter_48_4[iter_48_5].repetitionReward)
			end
		end
	end

	local var_48_5 = var_0_0.outGameState_ and var_0_0:getCurrentBuild() or nil

	if type(var_48_5) == "table" then
		local var_48_6 = tonumber(var_48_5.bodyId) or var_48_5.bodyId

		if var_48_6 ~= nil and var_48_6 ~= "" and var_48_6 ~= 0 then
			var_48_0.bodyIds[var_48_6] = true
		end

		for iter_48_6 = 1, #(var_48_5.weaponIds or {}) do
			local var_48_7 = tonumber(var_48_5.weaponIds[iter_48_6]) or var_48_5.weaponIds[iter_48_6]

			if var_48_7 ~= nil and var_48_7 ~= "" and var_48_7 ~= 0 then
				var_48_0.optionIds[var_48_7] = true
			end
		end

		for iter_48_7 = 1, #(var_48_5.equipIds or {}) do
			local var_48_8 = tonumber(var_48_5.equipIds[iter_48_7]) or var_48_5.equipIds[iter_48_7]

			if var_48_8 ~= nil and var_48_8 ~= "" and var_48_8 ~= 0 then
				var_48_0.optionIds[var_48_8] = true
			end
		end
	end

	if var_0_0.outGameState_ then
		local var_48_9 = tonumber(var_0_0.outGameState_.selectedBodyId) or var_0_0.outGameState_.selectedBodyId or nil

		if var_48_9 ~= nil and var_48_9 ~= "" and var_48_9 ~= 0 then
			var_48_0.bodyIds[var_48_9] = true
		end

		if next(var_48_0.bodyIds) == nil then
			local var_48_10 = var_0_0:GetDefaultBodyDef()

			if var_48_10 ~= nil then
				var_48_0.bodyIds[var_48_10.bodyId] = true
			end
		end
	end

	return var_48_0
end

function var_0_0.BuildIllustratedPropertyData(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5)
	local var_50_0 = tonumber(arg_50_2) or 0
	local var_50_1 = tonumber(arg_50_3) or 0

	if var_50_1 <= 0 then
		error("[SummerRaceData] invalid illustrated property max value for `" .. tostring(arg_50_1) .. "`")
	end

	return {
		state = arg_50_1,
		value = tostring(arg_50_4 ~= nil and arg_50_4 or var_50_0),
		currentValue = var_50_0,
		maxValue = var_50_1,
		slotKey = arg_50_5 or arg_50_1
	}
end

function var_0_0:GetPropertyMax(arg_51_1, arg_51_2)
	local var_51_0 = tostring(arg_51_1 or "")
	local var_51_1 = tostring(arg_51_2 or "")
	local var_51_2

	if var_51_0 == "Cost" then
		var_51_2 = var_51_0 .. "|" .. var_51_1 or var_51_0
	end

	self.propertyMaxCache_ = self.propertyMaxCache_ or {}

	if self.propertyMaxCache_[var_51_2] ~= nil then
		return self.propertyMaxCache_[var_51_2]
	end

	local var_51_3 = 0

	if var_51_0 == "HP" then
		local var_51_4 = var_0_0:_GetBodyDefs()

		for iter_51_0 = 1, #var_51_4 do
			var_51_3 = math.max(var_51_3, tonumber(var_51_4[iter_51_0].hp) or 0)
		end
	elseif var_51_0 == "ATK" or var_51_0 == "ROF" then
		local var_51_5 = var_0_0:_GetWeaponDefs()
		local var_51_6 = var_51_0 == "ATK" and "damage" or "rof"

		for iter_51_1 = 1, #var_51_5 do
			var_51_3 = math.max(var_51_3, tonumber(var_51_5[iter_51_1][var_51_6]) or 0)
		end
	elseif var_51_0 == "Skill" then
		local var_51_7 = var_0_0:_GetWeaponDefs()
		local var_51_8 = var_0_0:_GetEquipDefs()

		for iter_51_2 = 1, #var_51_7 do
			var_51_3 = math.max(var_51_3, tonumber(var_51_7[iter_51_2].energyCost) or 0)
		end

		for iter_51_3 = 1, #var_51_8 do
			var_51_3 = math.max(var_51_3, tonumber(var_51_8[iter_51_3].energyCost) or 0)
		end
	elseif var_51_0 == "Cost" then
		if var_51_1 == SummerRaceConst.FILTER.BODY then
			local var_51_9 = var_0_0:_GetBodyDefs()

			for iter_51_4 = 1, #var_51_9 do
				var_51_3 = math.max(var_51_3, tonumber(var_51_9[iter_51_4].cost) or 0)
			end
		else
			local var_51_10 = var_0_0:_GetWeaponDefs()
			local var_51_11 = var_0_0:_GetEquipDefs()

			for iter_51_5 = 1, #var_51_10 do
				var_51_3 = math.max(var_51_3, tonumber(var_51_10[iter_51_5].cost) or 0)
			end

			for iter_51_6 = 1, #var_51_11 do
				var_51_3 = math.max(var_51_3, tonumber(var_51_11[iter_51_6].cost) or 0)
			end
		end
	end

	self.propertyMaxCache_[var_51_2] = var_51_3 > 0 and var_51_3 or SummerRaceConst.PROPERTY_MAX[var_51_0]

	return var_51_3 > 0 and var_51_3 or SummerRaceConst.PROPERTY_MAX[var_51_0]
end

function var_0_0.BuildIllustratedDetailPanel(arg_52_0, arg_52_1)
	if arg_52_1 == nil then
		return {
			cost = "",
			name = "",
			lockState = "off",
			typeState = "carbody",
			desc = "",
			propertyList = {},
			lockPropertyList = {}
		}
	end

	local var_52_0 = {}
	local var_52_1 = {}

	if arg_52_1.typeText == SummerRaceConst.FILTER.BODY then
		local var_52_2 = var_0_0:GetPropertyMax("HP", arg_52_1.typeText)
		local var_52_3 = var_0_0:GetPropertyMax("Cost", arg_52_1.typeText)

		var_52_0 = {
			var_0_0:BuildIllustratedPropertyData("HP", arg_52_1.hp, var_52_2, arg_52_1.hp),
			var_0_0:BuildIllustratedPropertyData("Cost", arg_52_1.cost, var_52_3, arg_52_1.cost)
		}
		var_52_1 = {
			var_0_0:BuildIllustratedPropertyData("HP", arg_52_1.hp, var_52_2, arg_52_1.hp, "slot1"),
			var_0_0:BuildIllustratedPropertyData("Cost", arg_52_1.cost, var_52_3, arg_52_1.cost, "slot2")
		}
	elseif arg_52_1.typeText == SummerRaceConst.FILTER.WEAPON then
		local var_52_4 = var_0_0:GetPropertyMax("Skill", arg_52_1.typeText)
		local var_52_5 = var_0_0:GetPropertyMax("Cost", arg_52_1.typeText)

		var_52_0 = {
			var_0_0:BuildIllustratedPropertyData("ATK", arg_52_1.damage, var_0_0:GetPropertyMax("ATK", arg_52_1.typeText), arg_52_1.damage),
			var_0_0:BuildIllustratedPropertyData("ROF", arg_52_1.rof, var_0_0:GetPropertyMax("ROF", arg_52_1.typeText), arg_52_1.rof),
			var_0_0:BuildIllustratedPropertyData("Skill", arg_52_1.energyCost, var_52_4, arg_52_1.energyCost),
			var_0_0:BuildIllustratedPropertyData("Cost", arg_52_1.cost, var_52_5, arg_52_1.cost)
		}
		var_52_1 = {
			var_0_0:BuildIllustratedPropertyData("Skill", arg_52_1.energyCost, var_52_4, arg_52_1.energyCost, "slot1"),
			var_0_0:BuildIllustratedPropertyData("Cost", arg_52_1.cost, var_52_5, arg_52_1.cost, "slot2")
		}
	else
		local var_52_6 = var_0_0:GetPropertyMax("Skill", arg_52_1.typeText)
		local var_52_7 = var_0_0:GetPropertyMax("Cost", arg_52_1.typeText)

		var_52_0 = {
			var_0_0:BuildIllustratedPropertyData("Skill", arg_52_1.energyCost, var_52_6, arg_52_1.energyCost),
			var_0_0:BuildIllustratedPropertyData("Cost", arg_52_1.cost, var_52_7, arg_52_1.cost)
		}
		var_52_1 = {
			var_0_0:BuildIllustratedPropertyData("Skill", arg_52_1.energyCost, var_52_6, arg_52_1.energyCost, "slot1"),
			var_0_0:BuildIllustratedPropertyData("Cost", arg_52_1.cost, var_52_7, arg_52_1.cost, "slot2")
		}
	end

	local var_52_8 = {}

	var_52_8.name = arg_52_1.itemName or arg_52_1.bodyName or ""
	var_52_8.desc = arg_52_1.desc or ""
	var_52_8.cost = arg_52_1.cost or 0

	if arg_52_1.typeText ~= SummerRaceConst.FILTER.BODY then
		var_52_8.itemImagePath = tostring(arg_52_1.iconPath or "") or ""
	end

	if arg_52_1.typeText == SummerRaceConst.FILTER.BODY then
		var_52_8.carImagePath = tostring(arg_52_1.iconPath or "") or ""
	end

	var_52_8.imageState = arg_52_1.typeText == SummerRaceConst.FILTER.BODY and "car" or "item"
	var_52_8.typeState = arg_52_1.typeText == SummerRaceConst.FILTER.BODY and "carbody" or arg_52_1.typeText == SummerRaceConst.FILTER.WEAPON and "weapon" or "parts"
	var_52_8.lockState = arg_52_1.isUnlocked and "off" or "on"
	var_52_8.propertyList = var_52_0
	var_52_8.lockPropertyList = var_52_1

	return var_52_8
end

function var_0_0.GetEnemyDefs(arg_53_0)
	if var_0_4 ~= nil then
		return var_0_4
	end

	local var_53_0 = var_0_0:GetSummerRaceCfgEntries(ActivityTankEnemyCfg, "ActivityTankEnemyCfg")
	local var_53_1 = {}

	for iter_53_0 = 1, #var_53_0 do
		local var_53_2 = var_53_0[iter_53_0]
		local var_53_3 = var_53_0[iter_53_0].body
		local var_53_4 = tonumber(var_53_0[iter_53_0].body_id) or tonumber(var_53_3) or 0
		local var_53_5 = tostring(var_53_0[iter_53_0].asset_name or "")
		local var_53_6 = tostring(var_53_2.build_asset_name or var_53_2.buildName or "")
		local var_53_7 = var_53_4 ~= 0 and var_0_0:FindDefById(var_0_0:_GetBodyDefs(), var_53_4) or nil
		local var_53_8 = ""

		if type(var_53_3) == "string" then
			var_53_8 = tostring(var_53_3)
		end

		if var_53_7 == nil and var_53_5 ~= "" then
			var_53_7 = var_0_0:FindBodyDefByRuntimeKey(var_53_5)
		end

		local var_53_9 = ""

		if var_53_7 ~= nil then
			var_53_9 = var_0_0:ResolveBodyRuntimeKey(var_53_7)
		elseif var_53_5 ~= "" then
			var_53_9 = var_53_5
		elseif var_53_8 ~= "" then
			var_53_9 = var_53_8
		end

		if var_53_6 == "" and var_53_9 == "" then
			error("[SummerRaceData] enemy requires build_asset_name or body reference, enemyId=" .. tostring(var_53_2.id))
		end

		local var_53_10 = tonumber(var_53_2.damage_multiplier)

		if var_53_10 == nil then
			var_53_10 = 1
		end

		if var_53_10 < 0 then
			error("[SummerRaceData] invalid enemy damage_multiplier < 0, enemyId=" .. tostring(var_53_2.id))
		end

		local var_53_11 = #var_53_1 + 1
		local var_53_12 = {
			enemyId = var_53_2.id,
			enemyName = var_0_0:ResolveDisplayText(var_53_2.name),
			desc = var_0_0:ResolveDisplayText(var_53_2.desc)
		}

		var_53_12.bodyIcon = var_53_2.avatar or var_53_2.body_icon
		var_53_12.logo = var_0_0:ResolveLogoSkinName(var_53_2.logo)

		local var_53_13

		if var_53_7 then
			var_53_13 = var_53_7.model

			if not var_53_7.model then
				if var_53_9 ~= "" then
					var_53_13 = var_0_0:BuildBodyPrefabPath(var_53_9) or ""
				end
			end
		end

		var_53_12.model = var_53_13
		var_53_12.assetName = var_53_9
		var_53_12.buildAssetName = var_53_6

		if var_53_4 == 0 or not var_53_4 then
			::label_53_0::

			local var_53_14

			if var_53_7 then
				var_53_14 = var_53_7.bodyId or 0
			end
		end

		var_53_12.bodyId = var_53_14
		var_53_12.bodyKey = var_53_9
		var_53_12.enemyType = tonumber(var_53_2.enemy_type) or 0
		var_53_12.weaponList = var_0_0:NormalizeIdList(var_53_2.weapon_list or var_53_2.weapon)
		var_53_12.equipList = var_0_0:NormalizeIdList(var_53_2.equip_list or var_53_2.equip)
		var_53_12.baseAttributes = var_53_2.base_attributes or {}
		var_53_12.growthAttributes = var_53_2.growth_attributes or {}
		var_53_12.damageMultiplier = var_53_10

		local var_53_15 = tonumber(var_53_2.hp)

		if not var_53_15 then
			var_53_15 = tonumber(var_53_7 and var_53_7.hp)

			if not var_53_15 then
				var_53_15 = tonumber((var_53_2.base_attributes or {})[1])
				var_53_15 = var_53_15 or 0
			end
		end

		var_53_12.baseHp = var_53_15
		var_53_12.attackRatio = tonumber(var_53_2.attack_ratio) or 1
		var_53_12.challengePoolId = tonumber(var_53_2.challenge_enemy_pool) or tonumber(var_53_2.challenge_pool_id) or 0

		local var_53_17 = tonumber((var_53_2.base_attributes or {})[2])

		var_53_17 = var_53_17 or 0
		var_53_12.moveSpeed = var_53_17
		var_53_12.battleIntroText = var_0_0:ResolveDisplayText(var_53_2.battle_intro_text or var_53_2.enemy_battle_intro_text or var_53_2.bubble_text or var_53_2.intro_text)
		var_53_12.overclockBubbleText = var_0_0:ResolveDisplayText(var_53_2.overclock_bubble_text or var_53_2.enemy_overclock_bubble_text or var_53_2.overload_bubble_text)
		var_53_12.defeatEffect = tostring(var_53_2.defeat_effect or var_53_2.defeatEffect or "")
		var_53_12.sort = tonumber(var_53_2.sort) or iter_53_0
		var_53_1[var_53_11] = var_53_12
	end

	var_0_4 = var_53_1

	return var_0_4
end

function var_0_0.GetTournamentStageMap(arg_54_0)
	if var_0_6 ~= nil then
		return var_0_6
	end

	local var_54_0 = var_0_0:GetStageDefs()
	local var_54_1 = {
		[SummerRaceConst.TOURNAMENT_TAB.NORMAL] = {},
		[SummerRaceConst.TOURNAMENT_TAB.SURVIVAL] = {},
		[SummerRaceConst.TOURNAMENT_TAB.DUEL] = {}
	}

	for iter_54_0 = 1, #var_54_0 do
		if SummerRaceConst.STAGE_MODE_TO_TAB[var_54_0[iter_54_0].modeType] ~= nil then
			var_54_1[SummerRaceConst.STAGE_MODE_TO_TAB[var_54_0[iter_54_0].modeType]][#var_54_1[SummerRaceConst.STAGE_MODE_TO_TAB[var_54_0[iter_54_0].modeType]] + 1] = var_0_0:CloneTable(var_54_0[iter_54_0])
		end
	end

	for iter_54_1, iter_54_2 in pairs(var_54_1) do
		table.sort(iter_54_2, function(arg_55_0, arg_55_1)
			return var_0_0.SortCfgBySort(arg_55_0, arg_55_1)
		end)

		for iter_54_3 = 1, #iter_54_2 do
			iter_54_2[iter_54_3].stageIndex = iter_54_3
			iter_54_2[iter_54_3].isUnlocked = false
			iter_54_2[iter_54_3].isCompleted = false
		end
	end

	var_0_0:RecalculateTournamentStageUnlockState(var_54_1)

	var_0_6 = var_54_1

	return var_0_6
end

function var_0_0.BuildBannerUnlockedStageSet(arg_56_0)
	local var_56_0 = {}
	local var_56_1 = var_0_0:GetTournamentStageMap()

	for iter_56_0, iter_56_1 in ipairs({
		SummerRaceConst.TOURNAMENT_TAB.NORMAL,
		SummerRaceConst.TOURNAMENT_TAB.SURVIVAL,
		SummerRaceConst.TOURNAMENT_TAB.DUEL
	}) do
		local var_56_2 = var_56_1[iter_56_1] or {}

		for iter_56_2 = 1, #var_56_2 do
			if var_56_2[iter_56_2].isUnlocked == true then
				var_56_0[tostring(var_56_2[iter_56_2].stageId)] = true
			end
		end
	end

	return var_56_0
end

function var_0_0.HasNewUnlockedBannerStage(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = type(arg_57_1) == "table" and arg_57_1 or {}

	for iter_57_0, iter_57_1 in pairs(type(arg_57_2) == "table" and arg_57_2 or {}) do
		if var_57_0[iter_57_0] ~= true then
			return true
		end
	end

	return false
end

function var_0_0.IsFirstUnlockedPracticeModeStage(arg_58_0, arg_58_1)
	local var_58_0 = tonumber(arg_58_1 and arg_58_1.modeType) or 0

	if var_58_0 ~= 2 and var_58_0 ~= 3 then
		return false
	end

	local var_58_1 = var_0_0:FindStageInfoById(tonumber(arg_58_1.preStage) or 0)
	local var_58_2 = tonumber(var_58_1 and var_58_1.modeType) or 0

	return var_58_2 ~= 2 and var_58_2 ~= 3
end

function var_0_0.GetNewUnlockedPracticeStageInfo(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = type(arg_59_1) == "table" and arg_59_1 or {}
	local var_59_1 = type(arg_59_2) == "table" and arg_59_2 or {}
	local var_59_2 = var_0_0:GetTournamentStageMap()

	for iter_59_0, iter_59_1 in ipairs({
		SummerRaceConst.TOURNAMENT_TAB.SURVIVAL,
		SummerRaceConst.TOURNAMENT_TAB.DUEL
	}) do
		for iter_59_2, iter_59_3 in ipairs(var_59_2[iter_59_1] or {}) do
			local var_59_4 = tostring(iter_59_3.stageId)

			if var_59_1[var_59_4] == true and var_59_0[var_59_4] ~= true and var_0_0:IsFirstUnlockedPracticeModeStage(iter_59_3) then
				return iter_59_3
			end
		end
	end

	return nil
end

function var_0_0.GetNewUnlockedStageItemAnimModelList(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = type(arg_60_1) == "table" and arg_60_1 or {}
	local var_60_1 = type(arg_60_2) == "table" and arg_60_2 or {}
	local var_60_2 = var_0_0:GetTournamentStageMap()
	local var_60_3 = {}

	for iter_60_0, iter_60_1 in ipairs({
		SummerRaceConst.TOURNAMENT_TAB.NORMAL,
		SummerRaceConst.TOURNAMENT_TAB.SURVIVAL,
		SummerRaceConst.TOURNAMENT_TAB.DUEL
	}) do
		for iter_60_2, iter_60_3 in ipairs(var_60_2[iter_60_1] or {}) do
			local var_60_5 = tostring(iter_60_3.stageId)

			if var_60_1[var_60_5] == true and var_60_0[var_60_5] ~= true then
				var_60_3[#var_60_3 + 1] = {
					stageId = iter_60_3.stageId
				}
			end
		end
	end

	return var_60_3
end

function var_0_0.GetNewUnlockedStageItemAnimModel(arg_61_0, arg_61_1, arg_61_2)
	return var_0_0:GetNewUnlockedStageItemAnimModelList(arg_61_1, arg_61_2)[1]
end

function var_0_0.CloneTable(arg_62_0, arg_62_1)
	if arg_62_1 == nil then
		return {}
	end

	if type(arg_62_1) ~= "table" then
		return arg_62_1
	end

	local var_62_0 = {}

	for iter_62_0, iter_62_1 in pairs(arg_62_1) do
		var_62_0[iter_62_0] = type(iter_62_1) == "table" and var_0_0:CloneTable(iter_62_1) or iter_62_1
	end

	return var_62_0
end

function var_0_0.ResolveModeKey(arg_63_0, arg_63_1)
	if type(arg_63_1) == "number" then
		return SummerRaceConst.MODE_VALUE_TO_KEY[arg_63_1]
	end

	if type(arg_63_1) == "string" then
		local var_63_0 = tonumber(arg_63_1)

		if var_63_0 ~= nil then
			return SummerRaceConst.MODE_VALUE_TO_KEY[var_63_0]
		end

		local var_63_1 = string.lower(arg_63_1)

		if SummerRaceConst.VALID_MODE[var_63_1] then
			return var_63_1
		end
	end

	return nil
end

function var_0_0.RequireTable(arg_64_0, arg_64_1, arg_64_2)
	if type(arg_64_1) ~= "table" then
		error("[SummerRaceData] " .. arg_64_2 .. " must be a table")
	end
end

function var_0_0.RequireString(arg_65_0, arg_65_1, arg_65_2)
	if type(arg_65_1) ~= "string" then
		error("[SummerRaceData] " .. arg_65_2 .. " must be a string")
	end

	return arg_65_1
end

function var_0_0.RequireId(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = type(arg_66_1)

	if var_66_0 ~= "string" and var_66_0 ~= "number" then
		error("[SummerRaceData] " .. arg_66_2 .. " must be a string or number")
	end

	return arg_66_1
end

function var_0_0.RequireBoolean(arg_67_0, arg_67_1, arg_67_2)
	if type(arg_67_1) ~= "boolean" then
		error("[SummerRaceData] " .. arg_67_2 .. " must be a boolean")
	end

	return arg_67_1
end

function var_0_0.RequireNumber(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = tonumber(arg_68_1)

	if var_68_0 == nil then
		error("[SummerRaceData] " .. arg_68_2 .. " must be a number")
	end

	return var_68_0
end

function var_0_0.RequireArray(arg_69_0, arg_69_1, arg_69_2)
	if type(arg_69_1) ~= "table" then
		error("[SummerRaceData] " .. arg_69_2 .. " must be an array table")
	end

	for iter_69_0 = 1, #arg_69_1 do
		if arg_69_1[iter_69_0] == nil then
			error("[SummerRaceData] " .. arg_69_2 .. " has non-contiguous index at " .. tostring(iter_69_0))
		end
	end

	return arg_69_1
end

function var_0_0.RequireSkillType(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0 = var_0_0:RequireString(arg_70_1, arg_70_2)

	if var_70_0 ~= SummerRaceConst.FILTER.WEAPON and var_70_0 ~= SummerRaceConst.FILTER.EQUIP then
		error("[SummerRaceData] " .. arg_70_2 .. " must be weapon or equip")
	end

	return var_70_0
end

function var_0_0.InvokeNotify(arg_71_0, arg_71_1, ...)
	if manager and manager.notify and manager.notify.Invoke then
		manager.notify:Invoke(arg_71_1, ...)
	end
end

function var_0_0.NormalizeAllowedValue(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	if type(arg_72_1) ~= "string" then
		return arg_72_3
	end

	local var_72_0 = string.lower(arg_72_1)

	if arg_72_2[var_72_0] then
		return var_72_0
	end

	return arg_72_3
end

function var_0_0.FindDefById(arg_73_0, arg_73_1, arg_73_2)
	if arg_73_2 == nil or arg_73_2 == "" then
		return nil
	end

	local var_73_0 = tostring(arg_73_2)

	for iter_73_0 = 1, #arg_73_1 do
		if arg_73_1[iter_73_0].itemId ~= nil and (arg_73_1[iter_73_0].itemId == arg_73_2 or tostring(arg_73_1[iter_73_0].itemId) == var_73_0) or arg_73_1[iter_73_0].bodyId ~= nil and (arg_73_1[iter_73_0].bodyId == arg_73_2 or tostring(arg_73_1[iter_73_0].bodyId) == var_73_0) or arg_73_1[iter_73_0].enemyId ~= nil and (arg_73_1[iter_73_0].enemyId == arg_73_2 or tostring(arg_73_1[iter_73_0].enemyId) == var_73_0) then
			return arg_73_1[iter_73_0]
		end
	end

	return nil
end

function var_0_0.GetDefaultBodyDef(arg_74_0)
	local var_74_0 = var_0_0:_GetBodyDefs()
	local var_74_1 = var_74_0[1]

	for iter_74_0 = 1, #var_74_0 do
		if var_74_0[iter_74_0].isRecommended == true then
			var_74_1 = var_74_0[iter_74_0]

			break
		end
	end

	return var_74_1
end

function var_0_0.GetDefaultStageDef(arg_75_0)
	local var_75_0 = var_0_0:GetTournamentStageMap()

	if #var_75_0[SummerRaceConst.TOURNAMENT_TAB.NORMAL] > 0 then
		return var_75_0[SummerRaceConst.TOURNAMENT_TAB.NORMAL][1]
	end

	if #var_75_0[SummerRaceConst.TOURNAMENT_TAB.SURVIVAL] > 0 then
		return var_75_0[SummerRaceConst.TOURNAMENT_TAB.SURVIVAL][1]
	end

	if #var_75_0[SummerRaceConst.TOURNAMENT_TAB.DUEL] > 0 then
		return var_75_0[SummerRaceConst.TOURNAMENT_TAB.DUEL][1]
	end

	return nil
end

function var_0_0.GetDefaultStageDefByTab(arg_76_0, arg_76_1)
	local var_76_0 = var_0_0:GetTournamentStageMap()[SummerRaceConst.VALID_TOURNAMENT_TAB[arg_76_1] and arg_76_1 or SummerRaceConst.TOURNAMENT_TAB.NORMAL] or {}

	if #var_76_0 > 0 then
		return var_76_0[1]
	end

	return var_0_0:GetDefaultStageDef()
end

function var_0_0.BuildEmptyDefaultBuild(arg_77_0, arg_77_1)
	local var_77_0 = {}

	if arg_77_1 then
		var_77_0.bodyId = arg_77_1.bodyId or 0
	end

	var_77_0.weaponIds = {}
	var_77_0.equipIds = {}

	return var_77_0
end

function var_0_0.ExtractAssetBaseName(arg_78_0, arg_78_1)
	if type(arg_78_1) ~= "string" or arg_78_1 == "" then
		return ""
	end

	local var_78_0 = string.gsub(arg_78_1, "\\", "/")

	return string.gsub(string.match(var_78_0, "([^/]+)$") or var_78_0, "%..+$", "")
end

function var_0_0.StripAssetPrefix(arg_79_0, arg_79_1, arg_79_2)
	if type(arg_79_1) ~= "string" or arg_79_1 == "" then
		return ""
	end

	if string.sub(arg_79_1, 1, #arg_79_2) == arg_79_2 then
		return string.sub(arg_79_1, #arg_79_2 + 1)
	end

	return arg_79_1
end

function var_0_0.ResolveBodyRuntimeKey(arg_80_0, arg_80_1)
	if type(arg_80_1) ~= "table" then
		return ""
	end

	if type(arg_80_1.assetName) == "string" and arg_80_1.assetName ~= "" then
		do return arg_80_1.assetName end

		local var_80_0

		if arg_80_1.model ~= "" then
			var_80_0 = arg_80_1.model or arg_80_1.icon
		end
	end

	return var_0_0:StripAssetPrefix(var_0_0:ExtractAssetBaseName(var_80_0), "SummerRaceBody_")
end

function var_0_0.ResolveOptionRuntimeKey(arg_81_0, arg_81_1)
	if type(arg_81_1) ~= "table" then
		return ""
	end

	if type(arg_81_1.assetName) == "string" and arg_81_1.assetName ~= "" then
		return arg_81_1.assetName
	end

	return ""
end

function var_0_0.BuildMountPointContract(arg_82_0, arg_82_1)
	local var_82_0 = tonumber(arg_82_1.slotIndex) or 0
	local var_82_1 = arg_82_1.localPosition
	local var_82_2

	if tonumber(arg_82_1.slotType) == SummerRaceConst.MOUNT_SLOT_TYPE.EQUIP then
		var_82_2 = SummerRaceConst.FILTER.EQUIP or SummerRaceConst.FILTER.WEAPON
	end

	local var_82_3 = {}

	var_82_3.x = var_82_1 and tonumber(var_82_1.x) or 0
	var_82_3.y = var_82_1 and tonumber(var_82_1.y) or 0

	local var_82_4 = {
		slotType = var_82_2,
		slotIndex = var_82_0 + 1,
		configSlotIndex = var_82_0,
		localPosition = var_82_3
	}

	var_82_4.displayLocalPosition = var_0_0:CloneVector2Contract(arg_82_1.displayLocalPosition or var_82_3)
	var_82_4.localAngle = tonumber(arg_82_1.localAngle) or 0
	var_82_4.mountName = string.format("%sMount_%d", var_82_2, var_82_0)

	return var_82_4
end

function var_0_0.TraceMountVector(arg_83_0, arg_83_1)
	return string.format("(%.4f,%.4f)", arg_83_1 and tonumber(arg_83_1.x) or 0, arg_83_1 and tonumber(arg_83_1.y) or 0)
end

function var_0_0.TraceBodyMountPayload(arg_84_0, arg_84_1, arg_84_2, arg_84_3)
	print(string.format("[SummerRace][MountMap][LuaData] bodyId=%s assetName=%s boundsCenter=%s boundsSize=%s rawCount=%d", tostring((arg_84_1 or nil) and (arg_84_1.bodyId or "")), tostring((arg_84_1 or nil) and (arg_84_1.assetName or "")), var_0_0:TraceMountVector(arg_84_2 and arg_84_2.bodyBoundsCenter), var_0_0:TraceMountVector(arg_84_2 and arg_84_2.bodyBoundsSize), #(arg_84_3 or {})))

	for iter_84_0 = 1, #(arg_84_3 or {}) do
		local var_84_2 = arg_84_3[iter_84_0]
		local var_84_3

		if arg_84_3[iter_84_0] then
			var_84_3 = var_84_2.localPosition or nil
		end

		local var_84_4 = print
		local var_84_5 = "[SummerRace][MountMap][LuaData] bodyId=%s rawIndex=%d slotType=%s slotIndex=%s payloadLocal=%s angle=%s"
		local var_84_6 = tostring((arg_84_1 or nil) and (arg_84_1.bodyId or ""))
		local var_84_7 = iter_84_0

		var_84_4(string.format(var_84_5, var_84_6, var_84_7, tostring((var_84_2 or nil) and (var_84_2.slotType or "")), tostring((var_84_2 or nil) and (var_84_2.slotIndex or "")), var_0_0:TraceMountVector(var_84_3), tostring((var_84_2 or nil) and (var_84_2.localAngle or 0))))
	end
end

function var_0_0.BuildWheelContract(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_1 and arg_85_1.localPosition
	local var_85_1 = tostring((arg_85_1 or nil) and (arg_85_1.wheelSpritePath or ""))
	local var_85_2 = tostring((arg_85_1 or nil) and (arg_85_1.innerWheelSpritePath or ""))
	local var_85_3 = tonumber(arg_85_1 and arg_85_1.wheelVisualScale) or 1

	if var_85_1 == "" then
		error("[SummerRaceData] missing wheelSpritePath in body mount layout payload")
	end

	if var_85_2 == "" then
		error("[SummerRaceData] missing innerWheelSpritePath in body mount layout payload")
	end

	if var_85_3 <= 0 then
		error("[SummerRaceData] invalid wheelVisualScale in body mount layout payload: " .. tostring(var_85_3))
	end

	local var_85_4 = {
		hasVisual = true,
		visualType = "image"
	}

	var_85_4.name = tostring((arg_85_1 or nil) and (arg_85_1.name or ""))

	local var_85_5 = {}

	var_85_5.x = var_85_0 and tonumber(var_85_0.x) or 0
	var_85_5.y = var_85_0 and tonumber(var_85_0.y) or 0
	var_85_4.localPosition = var_85_5
	var_85_4.radius = tonumber(arg_85_1 and arg_85_1.radius) or 0
	var_85_4.width = tonumber(arg_85_1 and arg_85_1.width) or 0
	var_85_4.visualPath = var_85_1
	var_85_4.innerVisualPath = var_85_2
	var_85_4.visualScale = var_85_3

	return var_85_4
end

function var_0_0:SortMountPointContract(arg_86_1)
	return (self.slotIndex or 0) < (arg_86_1.slotIndex or 0)
end

function var_0_0.LoadBodyMountLayoutPayload(arg_87_0, arg_87_1)
	local var_87_0 = SummerRaceLuaBridge

	if SummerRaceLuaBridge == nil or type(SummerRaceLuaBridge.RequestGetBodyMountLayout) ~= "function" then
		error("[SummerRaceData] SummerRaceLuaBridge.RequestGetBodyMountLayout is unavailable")
	end

	local var_87_1, var_87_2 = pcall(require, "cjson")

	if not var_87_1 or type(var_87_2) ~= "table" or type(var_87_2.decode) ~= "function" then
		error("[SummerRaceData] cjson is unavailable for body mount layout decode")
	end

	local var_87_3, var_87_4 = pcall(function()
		return var_87_0.RequestGetBodyMountLayout(tostring(arg_87_1.assetName or ""))
	end)

	if not var_87_3 or type(var_87_4) ~= "string" or var_87_4 == "" then
		error("[SummerRaceData] failed to request body mount layout for bodyId=" .. tostring(arg_87_1.bodyId))
	end

	local var_87_5, var_87_6 = pcall(var_87_2.decode, var_87_4)

	if not var_87_5 or type(var_87_6) ~= "table" then
		error("[SummerRaceData] invalid body mount layout payload for bodyId=" .. tostring(arg_87_1.bodyId))
	end

	return var_87_6
end

function var_0_0.BuildBodyMountLayoutSignature(arg_89_0, arg_89_1)
	local var_89_0 = {}
	local var_89_1

	if type(arg_89_1.mountPoints) == "table" then
		var_89_1 = arg_89_1.mountPoints or {}
	end

	var_89_0[#var_89_0 + 1] = tostring(arg_89_1.mappingVersion or "")
	var_89_0[#var_89_0 + 1] = var_0_0:TraceMountVector(arg_89_1.bodyBoundsCenter)
	var_89_0[#var_89_0 + 1] = var_0_0:TraceMountVector(arg_89_1.bodyBoundsSize)

	for iter_89_0 = 1, #var_89_1 do
		local var_89_2 = var_89_1[iter_89_0] or {}
		local var_89_3 = #var_89_0 + 1
		local var_89_4 = {}

		var_89_4[1] = tostring(var_89_2.slotType or "")
		var_89_4[2] = tostring(var_89_2.slotIndex or "")
		var_89_4[3] = var_0_0:TraceMountVector(var_89_2.localPosition)
		var_89_4[4] = var_0_0:TraceMountVector(var_89_2.displayLocalPosition)
		var_89_4[5] = tostring(var_89_2.localAngle or 0)
		var_89_0[var_89_3] = table.concat(var_89_4, ":")
	end

	return table.concat(var_89_0, "|")
end

function var_0_0.BuildOptionVisualLayout(arg_90_0, arg_90_1, arg_90_2)
	local var_90_0 = tostring(arg_90_2 or "")
	local var_90_1 = string.format("%s|%s", tostring(arg_90_1 or ""), var_90_0)

	if var_0_8 == nil then
		var_0_8 = {}
	end

	if var_0_8[var_90_1] ~= nil then
		return var_0_0:CloneTable(var_0_8[var_90_1])
	end

	if var_90_0 == "" then
		error("[SummerRaceData] option asset_name is empty while requesting option visual layout")
	end

	local var_90_2 = SummerRaceLuaBridge

	if SummerRaceLuaBridge == nil or type(var_90_2.RequestGetOptionVisualLayout) ~= "function" then
		error("[SummerRaceData] SummerRaceLuaBridge.RequestGetOptionVisualLayout is unavailable")
	end

	local var_90_3, var_90_4 = pcall(require, "cjson")

	if not var_90_3 or type(var_90_4) ~= "table" or type(var_90_4.decode) ~= "function" then
		error("[SummerRaceData] cjson is unavailable for option visual layout decode")
	end

	local var_90_5, var_90_6 = pcall(function()
		return var_90_2.RequestGetOptionVisualLayout(tostring(arg_90_1 or ""), var_90_0)
	end)

	if not var_90_5 or type(var_90_6) ~= "string" or var_90_6 == "" then
		error("[SummerRaceData] failed to request option visual layout for type=" .. tostring(arg_90_1) .. ", assetName=" .. tostring(var_90_0))
	end

	local var_90_7, var_90_8 = pcall(var_90_4.decode, var_90_6)

	if not var_90_7 or type(var_90_8) ~= "table" then
		error("[SummerRaceData] invalid option visual layout payload for type=" .. tostring(arg_90_1) .. ", assetName=" .. tostring(var_90_0))
	end

	local var_90_9 = {}

	var_90_9.skeletonDataPath = tostring(var_90_8.skeletonDataPath or "")
	var_90_9.localOffset = var_0_0:CloneVector2Contract(var_90_8.localOffset)
	var_90_9.localAngle = tonumber(var_90_8.localAngle) or 0
	var_90_9.scale = tonumber(var_90_8.scale) or 1
	var_90_9.moduleSize = var_0_0:CloneVector2Contract(var_90_8.moduleSize)
	var_90_9.muzzleLocalOffset = var_0_0:CloneVector2Contract(var_90_8.muzzleLocalOffset)

	if var_90_9.skeletonDataPath == "" then
		error("[SummerRaceData] missing skeletonDataPath in option visual layout payload for type=" .. tostring(arg_90_1) .. ", assetName=" .. tostring(var_90_0))
	end

	if var_90_9.scale <= 0 then
		error("[SummerRaceData] invalid scale in option visual layout payload for type=" .. tostring(arg_90_1) .. ", assetName=" .. tostring(var_90_0))
	end

	var_0_8[var_90_1] = var_90_9

	return var_0_0:CloneTable(var_90_9)
end

function var_0_0.BuildBodyMountLayout(arg_92_0, arg_92_1)
	if type(arg_92_1) ~= "table" then
		error("[SummerRaceData] bodyDef is required for mount layout")
	end

	if var_0_7 == nil then
		var_0_7 = {}
	end

	local var_92_0 = var_0_0:LoadBodyMountLayoutPayload(arg_92_1)
	local var_92_1 = var_0_0:BuildBodyMountLayoutSignature(var_92_0)

	if var_0_7[arg_92_1.bodyId] ~= nil and var_0_7[arg_92_1.bodyId].layoutSignature == var_92_1 then
		return var_0_0:CloneTable(var_0_7[arg_92_1.bodyId])
	end

	local var_92_2

	if type(var_92_0.mountPoints) == "table" then
		var_92_2 = var_92_0.mountPoints or {}

		local var_92_3

		if type(var_92_0.wheels) == "table" then
			var_92_3 = var_92_0.wheels or {}
		end
	end

	local var_92_4 = {}
	local var_92_5 = {}
	local var_92_6 = {}
	local var_92_7 = {}

	var_0_0:TraceBodyMountPayload(arg_92_1, var_92_0, var_92_2)

	for iter_92_0 = 1, #var_92_2 do
		local var_92_8 = var_0_0:BuildMountPointContract(var_92_2[iter_92_0])

		print(string.format("[SummerRace][MountMap][LuaData] bodyId=%s contract slotType=%s slotIndex=%s configSlotIndex=%s local=%s displayLocal=%s angle=%s", tostring(arg_92_1.bodyId), tostring(var_92_8.slotType), tostring(var_92_8.slotIndex), tostring(var_92_8.configSlotIndex), var_0_0:TraceMountVector(var_92_8.localPosition), var_0_0:TraceMountVector(var_92_8.displayLocalPosition), tostring(var_92_8.localAngle)))

		var_92_4[#var_92_4 + 1] = var_92_8

		if var_92_8.slotType == SummerRaceConst.FILTER.WEAPON then
			var_92_5[#var_92_5 + 1] = var_92_8
		else
			var_92_6[#var_92_6 + 1] = var_92_8
		end
	end

	table.sort(var_92_5, function(arg_93_0, arg_93_1)
		return var_0_0.SortMountPointContract(arg_93_0, arg_93_1)
	end)
	table.sort(var_92_6, function(arg_94_0, arg_94_1)
		return var_0_0.SortMountPointContract(arg_94_0, arg_94_1)
	end)

	for iter_92_1 = 1, #var_92_3 do
		var_92_7[#var_92_7 + 1] = var_0_0:BuildWheelContract(var_92_3[iter_92_1])
	end

	local var_92_9 = {
		bodyId = arg_92_1.bodyId,
		bodyName = arg_92_1.bodyName,
		configPath = arg_92_1.configPath
	}

	var_92_9.bodySkeletonDataPath = tostring(var_92_0.bodySkeletonDataPath or "")
	var_92_9.chassisPrefabPath = tostring(var_92_0.chassisPrefabPath or arg_92_1.model or "")
	var_92_9.bodyBoundsSize = var_0_0:CloneVector2Contract(var_92_0.bodyBoundsSize)
	var_92_9.bodyBoundsCenter = var_0_0:CloneVector2Contract(var_92_0.bodyBoundsCenter)
	var_92_9.wheels = var_92_7
	var_92_9.weaponMounts = var_92_5
	var_92_9.equipMounts = var_92_6
	var_92_9.mountPoints = var_92_4
	var_92_9.layoutSignature = var_92_1

	if tonumber(var_92_9.bodyBoundsSize.x) == 0 or tonumber(var_92_9.bodyBoundsSize.y) == 0 then
		error(string.format("[SummerRaceData] missing body visual bounds for bodyId=%s assetName=%s. RequestGetBodyMountLayout must return bodyBoundsSize/bodyBoundsCenter", tostring(arg_92_1.bodyId), tostring(arg_92_1.assetName)))
	end

	if var_92_9.bodySkeletonDataPath == "" then
		error(string.format("[SummerRaceData] missing bodySkeletonDataPath for bodyId=%s assetName=%s", tostring(arg_92_1.bodyId), tostring(arg_92_1.assetName)))
	end

	var_0_7[arg_92_1.bodyId] = var_92_9

	return var_0_0:CloneTable(var_92_9)
end

function var_0_0.NormalizeBuildDataForBody(arg_95_0, arg_95_1, arg_95_2)
	local var_95_0 = var_0_0:BuildBodyMountLayout(arg_95_1)
	local var_95_1 = {
		bodyId = arg_95_1.bodyId,
		weaponIds = {},
		equipIds = {}
	}
	local var_95_2

	if type(arg_95_2) == "table" then
		var_95_2 = arg_95_2.weaponIds or nil

		local var_95_3

		if type(arg_95_2) == "table" then
			var_95_3 = arg_95_2.equipIds or nil
		end
	end

	for iter_95_0 = 1, #var_95_0.weaponMounts do
		if var_95_2 then
			var_95_1.weaponIds[iter_95_0] = var_95_2[iter_95_0] or nil
		end
	end

	for iter_95_1 = 1, #var_95_0.equipMounts do
		if var_95_3 then
			var_95_1.equipIds[iter_95_1] = var_95_3[iter_95_1] or nil
		end
	end

	return var_95_1
end

function var_0_0.ResolveModeKeyFromStageModeType(arg_96_0, arg_96_1)
	return SummerRaceConst.MODE_TYPE_TO_MODE_KEY[tonumber(arg_96_1) or 0]
end

function var_0_0.ResolveModeTypeFromModeKey(arg_97_0, arg_97_1)
	return SummerRaceConst.MODE_KEY_TO_MODE_TYPE[arg_97_1] or 0
end

function var_0_0.NormalizeStageEnemyWaves(arg_98_0, arg_98_1)
	local var_98_0 = {}

	if type(arg_98_1) ~= "table" then
		return var_98_0
	end

	if #arg_98_1 > 0 and type(arg_98_1[1]) == "table" then
		for iter_98_0 = 1, #arg_98_1 do
			local var_98_1 = {}

			for iter_98_1 = 1, #(arg_98_1[iter_98_0] or {}) do
				local var_98_2 = tonumber(arg_98_1[iter_98_0][iter_98_1]) or arg_98_1[iter_98_0][iter_98_1]

				if var_98_2 ~= nil and var_98_2 ~= "" and var_98_2 ~= 0 then
					var_98_1[#var_98_1 + 1] = var_98_2
				end
			end

			if #var_98_1 > 0 then
				var_98_0[#var_98_0 + 1] = var_98_1
			end
		end

		return var_98_0
	end

	for iter_98_2 = 1, #arg_98_1 do
		local var_98_3 = tonumber(arg_98_1[iter_98_2]) or arg_98_1[iter_98_2]

		if var_98_3 ~= nil and var_98_3 ~= "" and var_98_3 ~= 0 then
			var_98_0[#var_98_0 + 1] = {
				var_98_3
			}
		end
	end

	return var_98_0
end

function var_0_0.NormalizeRandomEnemyPool(arg_99_0, arg_99_1)
	local var_99_0 = {}

	if type(arg_99_1) ~= "table" then
		return var_99_0
	end

	for iter_99_0 = 1, #arg_99_1 do
		local var_99_1
		local var_99_2 = 1

		if type(arg_99_1[iter_99_0]) == "table" then
			var_99_1 = tonumber(arg_99_1[iter_99_0].enemyId) or arg_99_1[iter_99_0].enemyId or tonumber(arg_99_1[iter_99_0][1]) or arg_99_1[iter_99_0][1]
			var_99_2 = tonumber(arg_99_1[iter_99_0].weight) or tonumber(arg_99_1[iter_99_0][2]) or 1
		else
			var_99_1 = tonumber(arg_99_1[iter_99_0]) or arg_99_1[iter_99_0]
		end

		if var_99_1 ~= nil and var_99_1 ~= "" and var_99_1 ~= 0 then
			local var_99_3 = {
				enemyId = var_99_1
			}

			var_99_3.weight = math.max(1, tonumber(var_99_2) or 1)
			var_99_0[#var_99_0 + 1] = var_99_3
		end
	end

	return var_99_0
end

function var_0_0.NormalizeSpecialDefeatRules(arg_100_0, arg_100_1)
	local var_100_0 = {}

	if type(arg_100_1) ~= "table" then
		return var_100_0
	end

	for iter_100_0 = 1, #arg_100_1 do
		if type(arg_100_1[iter_100_0]) == "table" then
			local var_100_1 = math.max(1, tonumber(arg_100_1[iter_100_0].wave_index) or tonumber(arg_100_1[iter_100_0].waveIndex) or tonumber(arg_100_1[iter_100_0][1]) or 1)
			local var_100_2 = tonumber(arg_100_1[iter_100_0].enemy_id)

			if not var_100_2 then
				var_100_2 = arg_100_1[iter_100_0].enemy_id

				if not arg_100_1[iter_100_0].enemy_id then
					var_100_2 = tonumber(arg_100_1[iter_100_0].enemyId)

					if not var_100_2 then
						var_100_2 = arg_100_1[iter_100_0].enemyId

						local var_100_3

						if not arg_100_1[iter_100_0].enemyId then
							var_100_2 = arg_100_1[iter_100_0][2]
							var_100_3 = tonumber(arg_100_1[iter_100_0].guide_id) or tonumber(arg_100_1[iter_100_0].guideId) or tonumber(arg_100_1[iter_100_0][3]) or 0
						end
					end
				end
			end

			local var_100_4 = math.max(0, var_100_3)
			local var_100_5 = tostring(arg_100_1[iter_100_0].fx_id or arg_100_1[iter_100_0].fxId or arg_100_1[iter_100_0][4] or "")

			if var_100_2 ~= nil and var_100_2 ~= "" and var_100_2 ~= 0 then
				var_100_0[#var_100_0 + 1] = {
					waveIndex = var_100_1,
					enemyId = tostring(var_100_2),
					guideId = var_100_4,
					fxId = var_100_5
				}
			end
		end
	end

	return var_100_0
end

function var_0_0.FindEnemyDefeatBeforeFxGuideId(arg_101_0, arg_101_1)
	if arg_101_1 == nil or arg_101_1 == "" or arg_101_1 == 0 then
		return 0
	end

	if GuideBaseCfg == nil or type(GuideBaseCfg.all) ~= "table" then
		return 0
	end

	local var_101_0 = tostring(arg_101_1)

	for iter_101_0 = 1, #GuideBaseCfg.all do
		local var_101_1 = GuideBaseCfg.all[iter_101_0]
		local var_101_2

		if GuideBaseCfg[GuideBaseCfg.all[iter_101_0]] then
			var_101_2 = GuideBaseCfg[GuideBaseCfg.all[iter_101_0]].open_condition or nil
		end

		local var_101_3 = false
		local var_101_4 = false

		if type(var_101_2) == "table" then
			for iter_101_1 = 1, #var_101_2 do
				if type(var_101_2[iter_101_1]) == "table" then
					if var_101_2[iter_101_1][1] == SummerRaceConst.GUIDE_TRIGGER.ENEMY_DEFEAT_BEFORE_FX and tostring(var_101_2[iter_101_1][2]) == var_101_0 then
						var_101_3 = true
					elseif var_101_2[iter_101_1][1] == "guide" then
						var_101_4 = true
					end
				end
			end
		end

		if var_101_3 and not var_101_4 then
			return tonumber(var_101_1) or 0
		end
	end

	return 0
end

function var_0_0.BuildSpecialDefeatRulesFromEnemyGuides(arg_102_0, arg_102_1, arg_102_2)
	local var_102_0 = {}
	local var_102_1 = arg_102_2 or {}
	local var_102_2

	if arg_102_1 then
		var_102_2 = arg_102_1.enemyWaves or {}
	end

	for iter_102_0 = 1, #var_102_2 do
		local var_102_3 = var_102_2[iter_102_0] or {}

		for iter_102_1 = 1, #var_102_3 do
			local var_102_4 = var_0_0:FindEnemyDefeatBeforeFxGuideId(var_102_3[iter_102_1])

			if var_102_4 > 0 then
				local var_102_5 = tostring(iter_102_0) .. ":" .. tostring(var_102_3[iter_102_1])

				if var_102_1[var_102_5] ~= true then
					var_102_1[var_102_5] = true
					var_102_0[#var_102_0 + 1] = {
						fxId = "",
						waveIndex = iter_102_0,
						enemyId = tostring(var_102_3[iter_102_1]),
						guideId = var_102_4
					}
				end
			end
		end
	end

	return var_102_0
end

function var_0_0.BuildChallengeWaveRangeMap(arg_103_0, arg_103_1)
	local var_103_0 = {}
	local var_103_1 = {}

	for iter_103_0 = 1, #arg_103_1 do
		local var_103_2 = tonumber(arg_103_1[iter_103_0]) or 0

		if var_103_2 > 0 then
			var_103_1[#var_103_1 + 1] = var_103_2
		end
	end

	if #var_103_1 == 0 then
		var_103_0[1] = {
			minWave = 1,
			maxWave = 999
		}

		return var_103_0
	end

	for iter_103_1 = 1, #var_103_1 do
		local var_103_3 = math.max(1, tonumber(var_103_1[iter_103_1]) or 1)
		local var_103_4 = 999

		if iter_103_1 < #var_103_1 then
			var_103_4 = (tonumber(var_103_1[iter_103_1 + 1]) or 1000) - 1

			if (tonumber(var_103_1[iter_103_1 + 1]) or 1000) - 1 < var_103_3 then
				var_103_4 = var_103_3
			end
		end

		var_103_0[iter_103_1] = {
			minWave = var_103_3,
			maxWave = var_103_4
		}
	end

	return var_103_0
end

function var_0_0.BuildChallengePoolEntry(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4)
	local var_104_0

	if arg_104_1 == nil or arg_104_1 == "" or arg_104_1 == 0 then
		do return nil end

		var_104_0 = tonumber(arg_104_3) or 1
	end

	local var_104_1 = math.max(1, var_104_0)
	local var_104_2 = tonumber(arg_104_4) or 999
	local var_104_3 = {
		enemyId = arg_104_1
	}

	var_104_3.weight = math.max(1, tonumber(arg_104_2) or 1)
	var_104_3.minWave = var_104_1
	var_104_3.maxWave = math.max(var_104_1, var_104_2)

	return var_104_3
end

function var_0_0.NormalizeChallengeRandomEnemyPool(arg_105_0, arg_105_1, arg_105_2)
	local var_105_0 = {}

	if type(arg_105_1) ~= "table" then
		return var_105_0
	end

	local var_105_1 = var_0_0:BuildChallengeWaveRangeMap(arg_105_2)

	if #var_105_1 > 1 and #arg_105_1 > 0 and #arg_105_1 <= #var_105_1 then
		for iter_105_0 = 1, #arg_105_1 do
			if type(arg_105_1[iter_105_0]) ~= "table" or arg_105_1[iter_105_0].enemyId ~= nil then
				break
			end

			local var_105_3 = var_105_1[iter_105_0] or var_105_1[#var_105_1]

			for iter_105_1 = 1, #arg_105_1[iter_105_0] do
				local var_105_4
				local var_105_5 = 1

				if type(arg_105_1[iter_105_0][iter_105_1]) == "table" then
					var_105_4 = tonumber(arg_105_1[iter_105_0][iter_105_1].enemyId) or arg_105_1[iter_105_0][iter_105_1].enemyId or tonumber(arg_105_1[iter_105_0][iter_105_1][1]) or arg_105_1[iter_105_0][iter_105_1][1]
					var_105_5 = tonumber(arg_105_1[iter_105_0][iter_105_1].weight) or tonumber(arg_105_1[iter_105_0][iter_105_1][2]) or 1
				else
					var_105_4 = tonumber(arg_105_1[iter_105_0][iter_105_1]) or arg_105_1[iter_105_0][iter_105_1]
				end

				local var_105_6 = var_0_0:BuildChallengePoolEntry(var_105_4, var_105_5, var_105_3.minWave, var_105_3.maxWave)

				if var_105_6 ~= nil then
					var_105_0[#var_105_0 + 1] = var_105_6
				end
			end
		end

		if #var_105_1 > 1 and #arg_105_1 > 0 and #arg_105_1 <= #var_105_1 then
			return var_105_0
		end

		var_105_0 = {}
	end

	local var_105_7 = var_105_1[1] or {
		minWave = 1,
		maxWave = 999
	}

	for iter_105_2 = 1, #arg_105_1 do
		local var_105_8
		local var_105_9 = 1
		local var_105_10 = var_105_7.minWave
		local var_105_11 = var_105_7.maxWave

		if type(arg_105_1[iter_105_2]) == "table" then
			var_105_8 = tonumber(arg_105_1[iter_105_2].enemyId) or arg_105_1[iter_105_2].enemyId or tonumber(arg_105_1[iter_105_2][1]) or arg_105_1[iter_105_2][1]
			var_105_9 = tonumber(arg_105_1[iter_105_2].weight) or tonumber(arg_105_1[iter_105_2][2]) or 1
			var_105_10 = tonumber(arg_105_1[iter_105_2].minWave) or tonumber(arg_105_1[iter_105_2].min_wave) or var_105_10
			var_105_11 = tonumber(arg_105_1[iter_105_2].maxWave) or tonumber(arg_105_1[iter_105_2].max_wave) or var_105_11
		else
			var_105_8 = tonumber(arg_105_1[iter_105_2]) or arg_105_1[iter_105_2]
		end

		local var_105_12 = var_0_0:BuildChallengePoolEntry(var_105_8, var_105_9, var_105_10, var_105_11)

		if var_105_12 ~= nil then
			var_105_0[#var_105_0 + 1] = var_105_12
		end
	end

	return var_105_0
end

function var_0_0.FlattenFirstWaveEnemyIds(arg_106_0, arg_106_1)
	local var_106_0 = {}

	for iter_106_0 = 1, #(arg_106_1 or {}) do
		if type(arg_106_1[iter_106_0]) == "table" and arg_106_1[iter_106_0][1] ~= nil then
			var_106_0[#var_106_0 + 1] = arg_106_1[iter_106_0][1]
		end
	end

	return var_106_0
end

function var_0_0.FlattenRandomPoolEnemyIds(arg_107_0, arg_107_1)
	local var_107_0 = {}

	for iter_107_0 = 1, #(arg_107_1 or {}) do
		if type(arg_107_1[iter_107_0]) == "table" and arg_107_1[iter_107_0].enemyId ~= nil then
			var_107_0[#var_107_0 + 1] = arg_107_1[iter_107_0].enemyId
		end
	end

	return var_107_0
end

function var_0_0.BuildChallengePoolIdList(arg_108_0, arg_108_1)
	local var_108_0 = var_0_0:NormalizeIdList(arg_108_1)
	local var_108_1 = {}

	for iter_108_0 = 1, #var_108_0 do
		local var_108_2 = tonumber(var_108_0[iter_108_0]) or var_108_0[iter_108_0]

		if var_108_2 ~= nil and var_108_2 ~= "" and var_108_2 ~= 0 then
			var_108_1[#var_108_1 + 1] = var_108_2
		end
	end

	return var_108_1
end

function var_0_0.BuildChallengePoolKey(arg_109_0, arg_109_1)
	if #arg_109_1 == 0 then
		return ""
	end

	local var_109_0 = {}

	for iter_109_0 = 1, #arg_109_1 do
		var_109_0[#var_109_0 + 1] = tostring(arg_109_1[iter_109_0])
	end

	return table.concat(var_109_0, ",")
end

function var_0_0.BuildChallengeRandomPoolFromEnemyDefs(arg_110_0, arg_110_1)
	local var_110_0 = var_0_0:GetEnemyDefs()
	local var_110_1 = var_0_0:BuildChallengeWaveRangeMap(arg_110_1)
	local var_110_2 = {}

	for iter_110_0 = 1, #var_110_0 do
		local var_110_3 = tonumber(var_110_0[iter_110_0].challengePoolId) or 0

		if var_110_3 > 0 then
			local var_110_4 = var_110_1[var_110_3] or var_110_1[#var_110_1]

			if var_110_4 ~= nil then
				local var_110_5 = var_0_0:BuildChallengePoolEntry(var_110_0[iter_110_0].enemyId, 1, var_110_4.minWave, var_110_4.maxWave)

				if var_110_5 ~= nil then
					var_110_2[#var_110_2 + 1] = var_110_5
				end
			end
		end
	end

	return var_110_2
end

function var_0_0.ResolveBodyRuntimeKeyFromAssetPath(arg_111_0, arg_111_1)
	return var_0_0:StripAssetPrefix(var_0_0:ExtractAssetBaseName(arg_111_1), "SummerRaceBody_")
end

function var_0_0.FindBodyDefByRuntimeKey(arg_112_0, arg_112_1)
	local var_112_0 = var_0_0:_GetBodyDefs()

	for iter_112_0 = 1, #var_112_0 do
		if var_0_0:ResolveBodyRuntimeKey(var_112_0[iter_112_0]) == arg_112_1 then
			return var_112_0[iter_112_0]
		end
	end

	return nil
end

function var_0_0.CollectReferencedEnemyIds(arg_113_0, arg_113_1)
	local var_113_0 = {}
	local var_113_1 = {}

	for iter_113_0 = 1, #(arg_113_1 or {}) do
		local var_113_2 = arg_113_1[iter_113_0] or {}

		for iter_113_1 = 1, #var_113_2 do
			local var_113_3 = tostring(var_113_2[iter_113_1])

			if var_113_1[var_113_3] ~= true then
				var_113_1[var_113_3] = true
				var_113_0[#var_113_0 + 1] = var_113_2[iter_113_1]
			end
		end
	end

	return var_113_0
end

function var_0_0.CollectReferencedEnemyIdsFromStage(arg_114_0, arg_114_1)
	local var_114_0 = {}
	local var_114_1 = {}

	local function var_114_2(arg_115_0)
		local var_115_0 = tostring(arg_115_0)

		if var_114_1[var_115_0] ~= true then
			var_114_1[var_115_0] = true
			var_114_0[#var_114_0 + 1] = arg_115_0
		end
	end

	for iter_114_0 = 1, #((arg_114_1 or nil) and (arg_114_1.enemyWaves or {})) do
		local var_114_3 = arg_114_1.enemyWaves[iter_114_0] or {}

		for iter_114_1 = 1, #var_114_3 do
			var_114_2(var_114_3[iter_114_1])
		end
	end

	for iter_114_2 = 1, #((arg_114_1 or nil) and (arg_114_1.survivalRandomPool or {})) do
		if type(arg_114_1.survivalRandomPool[iter_114_2]) == "table" and arg_114_1.survivalRandomPool[iter_114_2].enemyId ~= nil then
			var_114_2(arg_114_1.survivalRandomPool[iter_114_2].enemyId)
		end
	end

	for iter_114_3 = 1, #((arg_114_1 or nil) and (arg_114_1.challengeRandomPool or {})) do
		if type(arg_114_1.challengeRandomPool[iter_114_3]) == "table" and arg_114_1.challengeRandomPool[iter_114_3].enemyId ~= nil then
			var_114_2(arg_114_1.challengeRandomPool[iter_114_3].enemyId)
		end
	end

	return var_114_0
end

function var_0_0.BuildStageInfoFromCfg(arg_116_0, arg_116_1, arg_116_2)
	local var_116_0 = tonumber(arg_116_1.mode_type) or 0
	local var_116_1 = var_0_0:NormalizeStageEnemyWaves(arg_116_1.enemy_waves or {})
	local var_116_2 = var_0_0:NormalizeRandomEnemyPool(arg_116_1.survival_random_pool or {})
	local var_116_3 = var_0_0:BuildChallengePoolIdList(arg_116_1.challenge_pool_id)
	local var_116_4 = var_0_0:NormalizeChallengeRandomEnemyPool(arg_116_1.challenge_random_pool or {}, var_116_3)
	local var_116_5 = var_0_0:BuildChallengePoolKey(var_116_3)
	local var_116_6 = {}

	if var_116_0 == 4 and #var_116_4 == 0 then
		var_116_4 = var_0_0:BuildChallengeRandomPoolFromEnemyDefs(var_116_3)
	end

	if var_116_0 == 1 or var_116_0 == 3 then
		var_116_6 = var_0_0:FlattenFirstWaveEnemyIds(var_116_1)
	elseif var_116_0 == 2 then
		var_116_6 = var_0_0:FlattenRandomPoolEnemyIds(var_116_2)
	elseif var_116_0 == 4 then
		var_116_6 = var_0_0:FlattenRandomPoolEnemyIds(var_116_4)
	end

	local var_116_7 = {
		isUnlocked = true,
		stageIndex = 0,
		isCompleted = false,
		stageId = arg_116_1.id,
		stageName = var_0_0:ResolveDisplayText(arg_116_1.name),
		desc = var_0_0:ResolveDisplayText(arg_116_1.desc),
		enemyIds = var_116_6,
		enemyWaves = var_116_1,
		survivalRandomPool = var_116_2,
		challengePoolId = var_116_5,
		challengePoolIds = var_116_3,
		challengeRandomPool = var_116_4
	}

	var_116_7.mapName = tostring(arg_116_1.map_name or arg_116_1.mapName or "")
	var_116_7.teammateIcon = tostring(arg_116_1.teammate_icon or arg_116_1.teammateIcon or "")
	var_116_7.specialDefeatRules = var_0_0:NormalizeSpecialDefeatRules(arg_116_1.special_defeat_rules or {})
	var_116_7.rewardList = arg_116_1.reward_list or {}
	var_116_7.firstReward = arg_116_1.first_reward or {}
	var_116_7.repetitionReward = arg_116_1.repetition_reward or {}
	var_116_7.modeType = var_116_0
	var_116_7.nodeType = var_116_0 == 1 and "main" or var_116_0 == 5 and "plot" or "practice"
	var_116_7.preStage = tonumber(arg_116_1.pre_stage) or 0
	var_116_7.sort = tonumber(arg_116_1.sort) or arg_116_2
	var_116_7.recommendedPower = tonumber(arg_116_1.recommended_power) or 0
	var_116_7.timeLimitSeconds = tonumber(arg_116_1.time_limit_seconds) or 0
	var_116_7.survivalDurationSeconds = tonumber(arg_116_1.survival_duration_seconds) or 0
	var_116_7.startStoryId = tonumber(arg_116_1.start_story) or 0
	var_116_7.endStoryId = tonumber(arg_116_1.end_story) or 0

	return var_116_7
end

function var_0_0.ResolveStageModeState(arg_117_0, arg_117_1)
	arg_117_1 = tonumber(arg_117_1) or 0

	if arg_117_1 == 4 then
		return "challenge"
	end

	if arg_117_1 == 2 or arg_117_1 == 3 then
		return "side"
	end

	return "main"
end

function var_0_0.ResolveStageTimeLimitSeconds(arg_118_0, arg_118_1, arg_118_2)
	local var_118_0 = math.floor((tonumber(arg_118_1 and arg_118_1.timeLimitSeconds) or 0) + 0.5)

	if var_118_0 < 0 then
		error("[SummerRaceData] invalid time_limit_seconds, expected >= 0, stageId=" .. tostring(arg_118_2) .. " got " .. tostring(arg_118_1 and arg_118_1.timeLimitSeconds))
	end

	return var_118_0
end

function var_0_0.BuildStageIndexText(arg_119_0, arg_119_1, arg_119_2)
	local var_119_0 = tonumber(arg_119_1 and arg_119_1.modeType) or 0

	if var_119_0 == 1 then
		return string.format(var_0_0:ResolveTipsText("ACTIVITY_TANK_STAGE"), tonumber(arg_119_2) or 0)
	end

	if var_119_0 == 2 then
		return string.format(var_0_0:ResolveTipsText("ACTIVITY_TANK_STAGE_PRACTICE1"), tonumber(arg_119_2) or 0)
	end

	if var_119_0 == 3 then
		return string.format(var_0_0:ResolveTipsText("ACTIVITY_TANK_STAGE_PRACTICE2"), tonumber(arg_119_2) or 0)
	end

	if var_119_0 == 4 then
		return var_0_0:ResolveTipsText("ACTIVITY_TANK_CHALLAGE")
	end

	if var_119_0 == 5 then
		return string.format("剧情-%02d", tonumber(arg_119_2) or 0)
	end

	return tostring((arg_119_1 or nil) and (arg_119_1.stageName or ""))
end

function var_0_0.GetStageDefs(arg_120_0)
	if var_0_5 ~= nil then
		return var_0_5
	end

	local var_120_0 = var_0_0:GetSummerRaceCfgEntries(ActivityTankCfg, "ActivityTankCfg")
	local var_120_1 = {}

	for iter_120_0 = 1, #var_120_0 do
		var_120_1[#var_120_1 + 1] = var_0_0:BuildStageInfoFromCfg(var_120_0[iter_120_0], iter_120_0)
	end

	table.sort(var_120_1, function(arg_121_0, arg_121_1)
		return var_0_0.SortCfgBySort(arg_121_0, arg_121_1)
	end)

	local var_120_2 = {}

	for iter_120_1 = 1, #var_120_1 do
		local var_120_3 = tonumber(var_120_1[iter_120_1].modeType) or 0

		var_120_2[var_120_3] = (var_120_2[var_120_3] or 0) + 1
		var_120_1[iter_120_1].modeState = var_0_0:ResolveStageModeState(var_120_3)
		var_120_1[iter_120_1].stageIndex = var_0_0:BuildStageIndexText(var_120_1[iter_120_1], var_120_2[var_120_3])
	end

	var_0_5 = var_120_1

	return var_0_5
end

function var_0_0.BuildActivityStagePayload(arg_122_0, arg_122_1, arg_122_2, arg_122_3)
	local var_122_0 = var_0_0:ResolveModeTypeFromModeKey(arg_122_2)
	local var_122_1 = tostring((arg_122_1 or nil) and (arg_122_1.challengePoolId or ""))

	if var_122_1 == "0" then
		var_122_1 = ""
	end

	local var_122_2 = var_0_0:ResolveStageTimeLimitSeconds(arg_122_1, arg_122_3)
	local var_122_3 = {
		challengeWaveHealRatio = 0,
		stageId = tostring(arg_122_3 or ""),
		mode = tostring(var_122_0)
	}

	var_122_3.sortOrder = tonumber(arg_122_1 and arg_122_1.sort) or 0
	var_122_3.isMainline = arg_122_2 == SummerRaceConst.MODE.CHAMPIONSHIP
	var_122_3.mapName = tostring((arg_122_1 or nil) and (arg_122_1.mapName or ""))
	var_122_3.challengePoolId = var_122_1
	var_122_3.recommendedPower = tonumber(arg_122_1 and arg_122_1.recommendedPower) or 0
	var_122_3.timeLimitSeconds = var_122_2
	var_122_3.survivalDurationSeconds = tonumber(arg_122_1 and arg_122_1.survivalDurationSeconds) or 0
	var_122_3.damageToEnergyRatio = var_0_0:GetDamageToEnergyRatioFromGameSetting()
	var_122_3.energyRegenPerSecond = var_0_0:GetEnergyRegenPerSecondFromGameSetting()
	var_122_3.maxEnergy = var_0_0:GetMaxEnergyFromGameSetting()
	var_122_3.waves = {}
	var_122_3.survivalRandomPool = {}
	var_122_3.challengeRandomPool = {}
	var_122_3.specialDefeatRules = {}
	var_122_3.challengeWaveScoreTable = {}

	local var_122_4 = var_0_0:CloneTable((arg_122_1 or nil) and (arg_122_1.specialDefeatRules or {}))
	local var_122_5 = {}

	for iter_122_0 = 1, #var_122_4 do
		if type(var_122_4[iter_122_0]) == "table" and var_122_4[iter_122_0].enemyId ~= nil then
			local var_122_6 = math.max(1, tonumber(var_122_4[iter_122_0].waveIndex) or 1)
			local var_122_7 = tostring(var_122_4[iter_122_0].enemyId)

			var_122_5[tostring(var_122_6) .. ":" .. var_122_7] = true

			local var_122_8 = {
				waveIndex = var_122_6,
				enemyId = var_122_7
			}

			var_122_8.guideId = math.max(0, tonumber(var_122_4[iter_122_0].guideId) or 0)
			var_122_8.fxId = tostring(var_122_4[iter_122_0].fxId or "")
			var_122_3.specialDefeatRules[#var_122_3.specialDefeatRules + 1] = var_122_8
		end
	end

	local var_122_9 = var_0_0:BuildSpecialDefeatRulesFromEnemyGuides(arg_122_1, var_122_5)

	for iter_122_1 = 1, #var_122_9 do
		var_122_3.specialDefeatRules[#var_122_3.specialDefeatRules + 1] = var_122_9[iter_122_1]
	end

	if var_122_0 ~= 1 then
		if var_122_0 == 3 then
			local var_122_10 = var_0_0:CloneTable((arg_122_1 or nil) and (arg_122_1.enemyWaves or {}))

			for iter_122_2 = 1, #var_122_10 do
				var_122_3.waves[#var_122_3.waves + 1] = {
					waveIndex = iter_122_2,
					enemyIds = var_0_0:CloneTable(var_122_10[iter_122_2]),
					timeLimitSeconds = var_122_2
				}
			end

			if #var_122_3.waves == 0 then
				error("[SummerRaceData] stage " .. tostring(arg_122_3) .. " requires enemy_waves for mode " .. tostring(var_122_0))
			end
		elseif var_122_0 == 2 then
			local var_122_11 = var_0_0:CloneTable((arg_122_1 or nil) and (arg_122_1.survivalRandomPool or {}))

			for iter_122_3 = 1, #var_122_11 do
				local var_122_12 = {
					enemyId = tostring(var_122_11[iter_122_3].enemyId)
				}

				var_122_12.weight = tonumber(var_122_11[iter_122_3].weight) or 1
				var_122_3.survivalRandomPool[#var_122_3.survivalRandomPool + 1] = var_122_12
			end

			if #var_122_3.survivalRandomPool == 0 then
				error("[SummerRaceData] stage " .. tostring(arg_122_3) .. " requires survival_random_pool for survival mode")
			end
		elseif var_122_0 == 4 then
			var_122_3.challengeWaveHealRatio = var_0_0:GetChallengeWaveHealRatioFromGameSetting()
			var_122_3.challengeWaveScoreTable = var_0_0:GetChallengeWaveScoreTableFromGameSetting()

			local var_122_13 = var_0_0:CloneTable((arg_122_1 or nil) and (arg_122_1.challengeRandomPool or {}))

			for iter_122_4 = 1, #var_122_13 do
				local var_122_14 = {
					enemyId = tostring(var_122_13[iter_122_4].enemyId)
				}

				var_122_14.weight = tonumber(var_122_13[iter_122_4].weight) or 1
				var_122_14.minWave = math.max(1, tonumber(var_122_13[iter_122_4].minWave) or 1)
				var_122_14.maxWave = math.max(math.max(1, tonumber(var_122_13[iter_122_4].minWave) or 1), tonumber(var_122_13[iter_122_4].maxWave) or 999)
				var_122_3.challengeRandomPool[#var_122_3.challengeRandomPool + 1] = var_122_14
			end

			if var_122_3.challengePoolId == "" or var_122_3.challengePoolId == "0" then
				error("[SummerRaceData] stage " .. tostring(arg_122_3) .. " requires challenge_pool_id for challenge mode")
			end

			if #var_122_3.challengeRandomPool == 0 then
				error("[SummerRaceData] stage " .. tostring(arg_122_3) .. " requires challenge_random_pool for challenge mode")
			end
		end
	end

	error("[SummerRaceData] unsupported stage modeType: " .. tostring(var_122_0))

	return var_122_3
end

function var_0_0.BuildActivityEnemyPayloadList(arg_123_0, arg_123_1)
	local var_123_0 = var_0_0:CollectReferencedEnemyIdsFromStage(arg_123_1)
	local var_123_1 = var_0_0:GetEnemyDefs()
	local var_123_2 = var_0_0:_GetWeaponDefs()
	local var_123_3 = var_0_0:_GetEquipDefs()
	local var_123_4 = {}

	for iter_123_0 = 1, #var_123_0 do
		local var_123_5 = var_0_0:FindDefById(var_123_1, var_123_0[iter_123_0])

		if var_123_5 ~= nil then
			local var_123_6 = {}
			local var_123_7 = {}

			for iter_123_1 = 1, #(var_123_5.weaponList or {}) do
				local var_123_8 = var_0_0:ResolveOptionRuntimeKey((var_0_0:FindDefById(var_123_2, var_123_5.weaponList[iter_123_1])))

				if var_123_8 ~= "" then
					var_123_6[#var_123_6 + 1] = var_123_8
				end
			end

			for iter_123_2 = 1, #(var_123_5.equipList or {}) do
				local var_123_9 = var_0_0:ResolveOptionRuntimeKey((var_0_0:FindDefById(var_123_3, var_123_5.equipList[iter_123_2])))

				if var_123_9 ~= "" then
					var_123_7[#var_123_7 + 1] = var_123_9
				end
			end

			local var_123_10 = var_123_5.bodyKey or var_123_5.assetName or var_0_0:ResolveBodyRuntimeKeyFromAssetPath(var_123_5.model)
			local var_123_11 = var_0_0:FindBodyDefByRuntimeKey(var_123_10)
			local var_123_12 = tostring(var_123_5.buildAssetName or "")

			if var_123_12 == "" and var_123_10 == "" then
				error("[SummerRaceData] enemy payload requires build asset or body key, enemyId=" .. tostring(var_123_5.enemyId))
			end

			local var_123_13 = #var_123_4 + 1
			local var_123_14 = {
				enemyId = tostring(var_123_5.enemyId)
			}

			var_123_14.displayName = tostring(var_123_5.enemyName or var_123_5.enemyId)
			var_123_14.battleIntroText = tostring(var_123_5.battleIntroText or "")
			var_123_14.overclockBubbleText = tostring(var_123_5.overclockBubbleText or "")
			var_123_14.defeatEffect = tostring(var_123_5.defeatEffect or var_123_5.defeat_effect or "")
			var_123_14.buildAssetName = var_123_12
			var_123_14.bodyKey = tostring(var_123_10 or "")
			var_123_14.bodyIcon = tostring(var_123_5.bodyIcon or "")
			var_123_14.logo = var_0_0:ResolveLogoSkinName(var_123_5.logo)
			var_123_14.weaponKeys = var_123_6
			var_123_14.equipKeys = var_123_7

			local var_123_15 = tonumber(var_123_5.baseHp)

			if not var_123_15 then
				var_123_15 = tonumber(var_123_11 and var_123_11.hp)

				if not var_123_15 then
					var_123_15 = tonumber((var_123_5.baseAttributes or {})[1])
					var_123_15 = var_123_15 or 1
				end
			end

			var_123_14.baseHp = var_123_15
			var_123_14.damageMultiplier = tonumber(var_123_5.damageMultiplier) or 1
			var_123_14.moveSpeed = tonumber(var_123_5.moveSpeed) or 0
			var_123_4[var_123_13] = var_123_14
		end
	end

	return var_123_4
end

function var_0_0.BuildActivityWeaponPayloadList(arg_124_0)
	local var_124_0 = var_0_0:_GetWeaponDefs()
	local var_124_1 = {}

	for iter_124_0 = 1, #var_124_0 do
		local var_124_2 = var_124_0[iter_124_0]
		local var_124_3 = var_0_0:ResolveOptionRuntimeKey(var_124_0[iter_124_0])

		if var_124_3 ~= "" then
			local var_124_4 = #var_124_1 + 1
			local var_124_5 = {
				weaponKey = var_124_3
			}

			var_124_5.displayName = tostring(var_124_2.itemName or "")
			var_124_5.cost = tonumber(var_124_2.cost) or 0
			var_124_5.energyCost = tonumber(var_124_2.energyCost) or 0
			var_124_5.cooldownSeconds = tonumber(var_124_2.cooldownSeconds) or 0
			var_124_5.damage = tonumber(var_124_2.damage) or 0
			var_124_5.rof = tonumber(var_124_2.rof) or 0
			var_124_5.hasBurnOverride = tonumber(var_124_2.effectType) == 2

			local var_124_6 = tonumber((var_124_2.effectParams or {})[1])

			var_124_6 = var_124_6 or 0
			var_124_5.burnDps = var_124_6

			local var_124_7 = tonumber((var_124_2.effectParams or {})[2])

			var_124_7 = var_124_7 or 0
			var_124_5.burnDuration = var_124_7
			var_124_5.effectParams = var_0_0:CloneTable(var_124_2.effectParams or {})
			var_124_1[var_124_4] = var_124_5
		end
	end

	return var_124_1
end

function var_0_0.BuildActivityEquipPayloadList(arg_125_0)
	local var_125_0 = var_0_0:_GetEquipDefs()
	local var_125_1 = {}

	for iter_125_0 = 1, #var_125_0 do
		local var_125_2 = var_0_0:ResolveOptionRuntimeKey(var_125_0[iter_125_0])

		if var_125_2 ~= "" then
			local var_125_3 = {
				equipKey = var_125_2
			}

			var_125_3.displayName = tostring(var_125_0[iter_125_0].itemName or "")
			var_125_3.cost = tonumber(var_125_0[iter_125_0].cost) or 0
			var_125_3.energyCost = tonumber(var_125_0[iter_125_0].energyCost) or 0
			var_125_3.cooldownSeconds = tonumber(var_125_0[iter_125_0].cooldownSeconds) or 0
			var_125_1[#var_125_1 + 1] = var_125_3
		end
	end

	return var_125_1
end

function var_0_0.BuildActivityConfigPayload(arg_126_0, arg_126_1, arg_126_2, arg_126_3)
	if type(arg_126_1) ~= "table" then
		return nil
	end

	local var_126_0 = var_0_0:CloneTable(arg_126_1.enemyWaves or {})

	return {
		activityId = tostring(SummerRaceConst.ACTIVITY_ID.MAIN),
		stage = var_0_0:BuildActivityStagePayload(arg_126_1, arg_126_2, arg_126_3),
		enemies = var_0_0:BuildActivityEnemyPayloadList(arg_126_1),
		weapons = var_0_0:BuildActivityWeaponPayloadList(),
		equips = var_0_0:BuildActivityEquipPayloadList()
	}
end

function var_0_0.FindStageInfoById(arg_127_0, arg_127_1)
	local var_127_0 = tonumber(arg_127_1) or arg_127_1

	if var_127_0 == nil or var_127_0 == "" or var_127_0 == 0 then
		return nil
	end

	local var_127_1 = var_0_0:GetStageDefs()

	for iter_127_0 = 1, #var_127_1 do
		if var_127_1[iter_127_0].stageId == var_127_0 then
			return var_0_0:CloneTable(var_127_1[iter_127_0])
		end
	end

	return nil
end

function var_0_0.HasStageConfig(arg_128_0, arg_128_1)
	return var_0_0:FindStageInfoById(arg_128_1) ~= nil
end

function var_0_0.FindRuntimeStageInfoById(arg_129_0, arg_129_1)
	local var_129_0 = tonumber(arg_129_1) or arg_129_1

	if var_129_0 == nil or var_129_0 == "" or var_129_0 == 0 then
		return nil
	end

	for iter_129_0, iter_129_1 in pairs((var_0_0:GetTournamentStageMap())) do
		for iter_129_2 = 1, #iter_129_1 do
			if iter_129_1[iter_129_2].stageId == var_129_0 then
				return var_0_0:CloneTable(iter_129_1[iter_129_2])
			end
		end
	end

	return nil
end

function var_0_0.FindStageInfoByTabAndId(arg_130_0, arg_130_1, arg_130_2)
	local var_130_0 = tonumber(arg_130_2) or arg_130_2

	if var_130_0 == nil or var_130_0 == "" or var_130_0 == 0 then
		return nil
	end

	local var_130_1 = var_0_0:GetTournamentStageMap()[arg_130_1]

	var_130_1 = var_130_1 or {}

	for iter_130_0 = 1, #var_130_1 do
		if var_130_1[iter_130_0].stageId == var_130_0 then
			return var_0_0:CloneTable(var_130_1[iter_130_0])
		end
	end

	return nil
end

function var_0_0.ResolveStageIdForTab(arg_131_0, arg_131_1, arg_131_2)
	local var_131_0 = SummerRaceConst.VALID_TOURNAMENT_TAB[arg_131_1] and arg_131_1 or SummerRaceConst.TOURNAMENT_TAB.NORMAL
	local var_131_1 = var_0_0:FindStageInfoByTabAndId(SummerRaceConst.VALID_TOURNAMENT_TAB[arg_131_1] and arg_131_1 or SummerRaceConst.TOURNAMENT_TAB.NORMAL, arg_131_2)

	if var_131_1 ~= nil then
		return var_131_1.stageId
	end

	local var_131_2 = var_0_0:GetDefaultStageDefByTab(var_131_0)

	return (var_131_2 or nil) and (var_131_2.stageId or 0)
end

function var_0_0.GetDefaultStageDefByModeKey(arg_132_0, arg_132_1)
	local var_132_0 = var_0_0:ResolveModeTypeFromModeKey(arg_132_1)
	local var_132_1 = var_0_0:GetStageDefs()

	for iter_132_0 = 1, #var_132_1 do
		if var_132_1[iter_132_0].modeType == var_132_0 then
			return var_0_0:CloneTable(var_132_1[iter_132_0])
		end
	end

	return nil
end

function var_0_0.BuildChallengeRuleText(arg_133_0, arg_133_1)
	local var_133_0 = var_0_0:ResolveDisplayText(arg_133_1 and arg_133_1.desc)

	if var_133_0 ~= "" then
		return var_133_0
	end

	return ""
end

function var_0_0.GetSummerRaceTaskRootActivityId(arg_134_0)
	local var_134_0 = ActivityCfg and ActivityCfg[SummerRaceConst.ACTIVITY_ID.MAIN]

	if var_134_0 ~= nil and type(var_134_0.sub_activity_list) == "table" then
		for iter_134_0, iter_134_1 in ipairs(var_134_0.sub_activity_list) do
			if ActivityCfg[iter_134_1] ~= nil and ActivityCfg[iter_134_1].activity_template == SummerRaceConst.ACTIVITY_TEMPLATE.TASK then
				return tonumber(iter_134_1) or 0
			end
		end

		return tonumber(var_134_0.sub_activity_list[1]) or 0
	end

	return 0
end

function var_0_0.GetSummerRaceRankActivityId(arg_135_0)
	local var_135_0 = ActivityCfg and ActivityCfg[SummerRaceConst.ACTIVITY_ID.MAIN]

	if var_135_0 ~= nil and type(var_135_0.sub_activity_list) == "table" then
		for iter_135_0, iter_135_1 in ipairs(var_135_0.sub_activity_list) do
			if ActivityCfg[iter_135_1] ~= nil and ActivityCfg[iter_135_1].activity_template == SummerRaceConst.ACTIVITY_TEMPLATE.RANK then
				return tonumber(iter_135_1) or 0
			end
		end
	end

	return 0
end

function var_0_0.GetSummerRaceTaskChildActivityIds(arg_136_0)
	local var_136_0 = var_0_0:GetSummerRaceTaskRootActivityId()

	if var_136_0 ~= 0 and ActivityCfg then
		local var_136_1 = ActivityCfg[var_136_0] or nil

		if var_136_1 ~= nil and type(var_136_1.sub_activity_list) == "table" then
			return var_136_1.sub_activity_list
		end
	end

	return {}
end

function var_0_0.ResolveRewardActivityId(arg_137_0, arg_137_1, arg_137_2)
	local var_137_0 = var_0_0:GetSummerRaceTaskRootActivityId()
	local var_137_1 = var_0_0:GetSummerRaceTaskChildActivityIds()

	if arg_137_1 == SummerRaceConst.REWARD_PAGE.RESIDENT then
		return var_137_0
	end

	if arg_137_2 == SummerRaceConst.REWARD_SUBTYPE.STAGE then
		return tonumber(var_137_1[2]) or var_137_0
	elseif arg_137_2 == SummerRaceConst.REWARD_SUBTYPE.ACHIEVEMENT then
		return tonumber(var_137_1[3]) or var_137_0
	end

	return tonumber(var_137_1[1]) or var_137_0
end

function var_0_0.BuildDefaultOutGameState(arg_138_0)
	local var_138_0 = var_0_0:GetDefaultBodyDef()
	local var_138_1 = var_0_0:GetDefaultStageDef()
	local var_138_2

	if var_138_0 then
		var_138_2 = var_138_0.bodyId or 0

		local var_138_3

		if var_138_1 then
			var_138_3 = var_138_1.stageId or 0
		end
	end

	return {
		selectedOptionId = "",
		selectedModifySlotIndex = 0,
		challengeRound = 0,
		modifyInfoTarget = "body",
		challengeBestScore = -1,
		selectedModifySlotType = "",
		selectedRewardId = "",
		selectedRankId = "self",
		modifySlotFilterActive = false,
		tournamentTab = SummerRaceConst.TOURNAMENT_TAB.NORMAL,
		currentStageId = var_138_3,
		modifyFilterType = SummerRaceConst.FILTER.ALL,
		illustratedFilterType = SummerRaceConst.FILTER.BODY,
		rewardPageType = SummerRaceConst.REWARD_PAGE.LIMITED,
		rewardSubType = SummerRaceConst.REWARD_SUBTYPE.DAILY,
		selectedBodyId = var_138_2,
		selectedIllustratedItemId = var_138_2,
		rewardStateMap = {},
		buildTankList = {
			[var_138_2] = var_0_0:BuildEmptyDefaultBuild(var_138_0)
		},
		currentBuild = var_138_0.bodyId,
		pendingUnlockModel = var_0_0:BuildDefaultPendingUnlock(),
		pendingStageUnlockBannerModel = var_0_0:BuildDefaultPendingStageUnlockBanner()
	}
end

function var_0_0.BuildMissionSet(arg_139_0, arg_139_1)
	local var_139_0 = {}
	local var_139_1 = type(arg_139_1) == "table" and arg_139_1 or {}

	for iter_139_0 = 1, #var_139_1 do
		local var_139_2 = tonumber(var_139_1[iter_139_0]) or var_139_1[iter_139_0]

		if var_139_2 ~= nil and var_139_2 ~= "" and var_139_2 ~= 0 then
			var_139_0[tostring(var_139_2)] = true
		end
	end

	return var_139_0
end

function var_0_0.RecalculateTournamentStageUnlockState(arg_140_0, arg_140_1)
	local var_140_0 = type(arg_140_1) == "table" and arg_140_1 or var_0_0:GetTournamentStageMap()
	local var_140_1 = {}

	for iter_140_0, iter_140_1 in pairs(var_140_0) do
		for iter_140_2 = 1, #iter_140_1 do
			var_140_1[tostring(iter_140_1[iter_140_2].stageId)] = iter_140_1[iter_140_2]
		end
	end

	for iter_140_3, iter_140_4 in pairs(var_140_0) do
		for iter_140_5 = 1, #iter_140_4 do
			local var_140_2 = iter_140_4[iter_140_5]
			local var_140_3 = tonumber(iter_140_4[iter_140_5].preStage) or 0

			if var_140_3 == 0 then
				var_140_2.isUnlocked = true
			else
				local var_140_4 = var_140_1[tostring(var_140_3)]

				var_140_2.isUnlocked = var_140_4 ~= nil and var_140_4.isCompleted == true
			end
		end
	end
end

function var_0_0.ApplyMissionProgressToStageMap(arg_141_0, arg_141_1)
	local var_141_0 = var_0_0:GetTournamentStageMap()
	local var_141_1 = type(arg_141_1) == "table" and arg_141_1 or {}

	for iter_141_0, iter_141_1 in pairs(var_141_0) do
		for iter_141_2 = 1, #iter_141_1 do
			iter_141_1[iter_141_2].isCompleted = var_141_1[tostring(iter_141_1[iter_141_2].stageId)] == true
		end
	end

	var_0_0:RecalculateTournamentStageUnlockState(var_141_0)
end

function var_0_0.BuildServerWeaponListFromBuildData(arg_142_0, arg_142_1)
	local var_142_0 = {}
	local var_142_1 = type(arg_142_1) == "table" and arg_142_1 or {}
	local var_142_2 = var_142_1.weaponIds or {}
	local var_142_3 = var_142_1.equipIds or {}

	for iter_142_0 = 1, #var_142_2 do
		if var_142_2[iter_142_0] ~= nil and var_142_2[iter_142_0] ~= "" then
			var_142_0[#var_142_0 + 1] = var_142_2[iter_142_0]
		end
	end

	for iter_142_1 = 1, #var_142_3 do
		if var_142_3[iter_142_1] ~= nil and var_142_3[iter_142_1] ~= "" then
			var_142_0[#var_142_0 + 1] = var_142_3[iter_142_1]
		end
	end

	return var_142_0
end

function var_0_0.getCurrentBuild(arg_143_0)
	local var_143_0 = var_0_0.outGameState_.buildTankList[var_0_0.outGameState_.currentBuild]

	if var_0_0.outGameState_.buildTankList[var_0_0.outGameState_.currentBuild] == nil then
		var_143_0 = var_0_0:BuildEmptyDefaultBuild((var_0_0:FindDefById(var_0_0:_GetBodyDefs(), var_0_0.outGameState_.currentBuild)))
		var_0_0.outGameState_.buildTankList[var_0_0.outGameState_.currentBuild] = var_143_0
	end

	return var_143_0
end

function var_0_0.NormalizeServerTankBuildList(arg_144_0, arg_144_1)
	var_0_0:RequireTable(arg_144_1, "server tank_info list")

	local var_144_0 = {}

	for iter_144_0, iter_144_1 in ipairs(arg_144_1) do
		local var_144_1 = var_0_0:NormalizeServerTankBuild(iter_144_1)

		var_144_0[var_144_1.bodyId] = var_144_1
	end

	return var_144_0
end

function var_0_0.NormalizeServerTankBuild(arg_145_0, arg_145_1)
	var_0_0:RequireTable(arg_145_1, "server tank_info")

	local var_145_0 = var_0_0:RequireNumber(arg_145_1.tank_id, "server tank_info.tank_id")

	if var_145_0 == 0 then
		local var_145_1 = var_0_0:GetDefaultBodyDef()

		if var_145_1 == nil then
			error("[SummerRaceData] server tank_info.tank_id=0 but no default body is available")
		end

		return var_0_0:BuildEmptyDefaultBuild(var_145_1)
	end

	local var_145_2 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), var_145_0)

	if var_145_2 == nil then
		error("[SummerRaceData] unknown server tank body id: " .. tostring(var_145_0))
	end

	local var_145_3 = var_0_0:RequireArray(arg_145_1.weapon_list or {}, "server tank_info.weapon_list")
	local var_145_4 = var_0_0:NormalizeBuildDataForBody(var_145_2, {
		bodyId = var_145_2.bodyId
	})
	local var_145_5 = var_0_0:BuildBodyMountLayout(var_145_2)
	local var_145_6 = #(var_145_5.weaponMounts or {})
	local var_145_7 = #(var_145_5.equipMounts or {})
	local var_145_8 = var_0_0:_GetWeaponDefs()
	local var_145_9 = var_0_0:_GetEquipDefs()

	for iter_145_0 = 1, #var_145_3 do
		local var_145_10 = tonumber(var_145_3[iter_145_0]) or var_145_3[iter_145_0]
		local var_145_11 = var_0_0:FindDefById(var_145_8, var_145_10) or var_0_0:FindDefById(var_145_9, var_145_10)

		if var_145_11 == nil then
			error("[SummerRaceData] unknown server tank option id: " .. tostring(var_145_10))
		end

		local var_145_12

		if var_145_11.typeText == SummerRaceConst.FILTER.WEAPON then
			if var_145_6 < 1 then
				error("[SummerRaceData] server weapon_list overflow weapon slots, bodyId=" .. tostring(var_145_2.bodyId) .. ", optionId=" .. tostring(var_145_10))
			end

			var_145_4.weaponIds[1] = var_145_10
			var_145_12 = 1 + 1
		else
			local var_145_13

			if var_145_11.typeText == SummerRaceConst.FILTER.EQUIP then
				if var_145_7 < 1 then
					error("[SummerRaceData] server weapon_list overflow equip slots, bodyId=" .. tostring(var_145_2.bodyId) .. ", optionId=" .. tostring(var_145_10))
				end

				var_145_4.equipIds[1] = var_145_10
				var_145_13 = 1 + 1
			else
				error("[SummerRaceData] invalid server option type for optionId=" .. tostring(var_145_10))
			end
		end
	end

	return var_145_4
end

function var_0_0.BuildSlotData(arg_146_0, arg_146_1, arg_146_2, arg_146_3, arg_146_4, arg_146_5)
	local var_146_0 = arg_146_3 == nil
	local var_146_1 = arg_146_3 == nil and "" or arg_146_3.itemId
	local var_146_2 = arg_146_3 ~= nil and var_146_1 == arg_146_4
	local var_146_3 = arg_146_3 == nil and "" or tostring((not arg_146_3.iconPath or nil) and (arg_146_3.icon or ""))
	local var_146_5 = {
		interactionMode = "inspect",
		isLocked = false,
		maskState = "state0",
		slotState = "normal",
		slotIndex = arg_146_1,
		slotType = arg_146_2
	}

	if arg_146_5 then
		var_146_5.configSlotIndex = arg_146_5.configSlotIndex or arg_146_1 - 1
	end

	var_146_5.localPosition = arg_146_5 and var_0_0:CloneTable(arg_146_5.localPosition) or {
		x = 0,
		y = 0
	}
	var_146_5.displayLocalPosition = arg_146_5 and var_0_0:CloneTable(arg_146_5.displayLocalPosition) or nil

	if arg_146_5 then
		var_146_5.localAngle = arg_146_5.localAngle or 0
	end

	if arg_146_5 then
		var_146_5.mountName = arg_146_5.mountName or ""
	end

	var_146_5.itemId = var_146_1
	var_146_5.itemName = var_146_0 and "Empty Slot" or arg_146_3.itemName

	if var_146_0 then
		var_146_5.labelText = var_0_0:BuildSlotLabel(arg_146_2, arg_146_1) or tostring((not arg_146_3.itemName or nil) and "")
	end

	if var_146_0 then
		var_146_5.itemIcon = arg_146_2 .. "_slot" or var_146_1
	end

	var_146_5.iconPath = var_146_3
	var_146_5.cost = var_146_0 and 0 or arg_146_3.cost
	var_146_5.typeState = arg_146_2 == SummerRaceConst.FILTER.EQUIP and "state1" or "state0"
	var_146_5.slotVisualType = arg_146_2
	var_146_5.isSelected = var_146_2
	var_146_5.isEmpty = var_146_0

	return var_146_5
end

function var_0_0.GetMountListBySlotType(arg_147_0, arg_147_1, arg_147_2)
	if arg_147_2 == SummerRaceConst.FILTER.WEAPON then
		return arg_147_1.weaponMounts or {}
	end

	if arg_147_2 == SummerRaceConst.FILTER.EQUIP then
		return arg_147_1.equipMounts or {}
	end

	error("[SummerRaceData] invalid slot type: " .. tostring(arg_147_2))
end

function var_0_0.GetBuildIdListBySlotType(arg_148_0, arg_148_1, arg_148_2)
	if arg_148_2 == SummerRaceConst.FILTER.WEAPON then
		return arg_148_1.weaponIds
	end

	if arg_148_2 == SummerRaceConst.FILTER.EQUIP then
		return arg_148_1.equipIds
	end

	error("[SummerRaceData] invalid slot type: " .. tostring(arg_148_2))
end

function var_0_0.FindSlotData(arg_149_0, arg_149_1, arg_149_2, arg_149_3)
	for iter_149_0 = 1, #(arg_149_1 or {}) do
		if arg_149_1[iter_149_0].slotType == arg_149_2 and tonumber(arg_149_1[iter_149_0].slotIndex) == tonumber(arg_149_3) then
			return arg_149_1[iter_149_0]
		end
	end

	return nil
end

function var_0_0.BuildRuntimeSkillVisualTable(arg_150_0, arg_150_1)
	local var_150_0 = {
		weapon = {},
		equip = {}
	}

	for iter_150_0 = 1, #arg_150_1 do
		if arg_150_1[iter_150_0] ~= nil and arg_150_1[iter_150_0].isEmpty ~= true then
			local var_150_1 = tostring(arg_150_1[iter_150_0].slotType)

			if var_150_0[var_150_1] == nil then
				error("[SummerRaceData] invalid slotType in runtime skill visual table: " .. tostring(var_150_1))
			end

			var_150_0[var_150_1][#var_150_0[var_150_1] + 1] = {
				label = var_0_0:RequireString(arg_150_1[iter_150_0].itemName, "runtime skill visual.itemName"),
				iconPath = var_0_0:RequireString(arg_150_1[iter_150_0].iconPath, "runtime skill visual.iconPath")
			}
		end
	end

	return var_150_0
end

function var_0_0.ResolveModifyDisplayFilter(arg_151_0, arg_151_1)
	local var_151_1 = tostring(arg_151_1.selectedModifySlotType or "")

	if arg_151_1.modifySlotFilterActive == true and (var_151_1 == SummerRaceConst.FILTER.WEAPON or var_151_1 == SummerRaceConst.FILTER.EQUIP) then
		return var_151_1
	end

	return arg_151_1.modifyFilterType
end

function var_0_0.BuildVehicleDisplayModelFromSnapshot(arg_152_0, arg_152_1, arg_152_2)
	local var_152_0

	if arg_152_1 then
		var_152_0 = arg_152_1.bodyLayout or {}

		local var_152_1

		if arg_152_1 then
			var_152_1 = arg_152_1.slotSummary or {}
		end
	end

	local var_152_2 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), (arg_152_1 or nil) and (arg_152_1.bodyId or 0))

	var_152_2 = var_152_2 or {}

	local var_152_3 = {}

	for iter_152_0 = 1, #var_152_1 do
		local var_152_4 = var_152_1[iter_152_0]

		if var_152_1[iter_152_0].itemId ~= nil and var_152_4.itemId ~= "" then
			local var_152_5 = var_0_0:FindDefById(var_0_0:_GetWeaponDefs(), var_152_4.itemId) or var_0_0:FindDefById(var_0_0:_GetEquipDefs(), var_152_4.itemId)

			if var_152_5 ~= nil then
				local var_152_6 = var_152_4.localPosition or {}
				local var_152_7 = var_152_4.displayLocalPosition or var_152_6
				local var_152_8 = tonumber(var_152_4.localAngle) or 0
				local var_152_9 = #var_152_3 + 1
				local var_152_10 = {
					visualType = "spine",
					localYAngle = 0,
					itemId = var_152_5.itemId,
					itemName = var_152_5.itemName,
					assetName = var_152_5.assetName
				}

				var_152_10.skeletonDataPath = tostring(var_152_5.skeletonDataPath or "")
				var_152_10.hasVisual = tostring(var_152_5.skeletonDataPath or "") ~= ""
				var_152_10.moduleSize = var_0_0:CloneTable(var_152_5.moduleSize)
				var_152_10.moduleScale = tonumber(var_152_5.moduleScale) or 1
				var_152_10.slotType = var_152_4.slotType
				var_152_10.slotIndex = var_152_4.slotIndex

				local var_152_11 = {}

				var_152_11.x = tonumber(var_152_6.x) or 0
				var_152_11.y = tonumber(var_152_6.y) or 0
				var_152_10.localPosition = var_152_11

				local var_152_12 = {}

				var_152_12.x = tonumber(var_152_7.x) or 0
				var_152_12.y = tonumber(var_152_7.y) or 0
				var_152_10.displayLocalPosition = var_152_12
				var_152_10.moduleLocalOffset = var_0_0:CloneTable(var_152_5.moduleLocalOffset)
				var_152_10.localAngle = var_152_8
				var_152_10.visualLocalAngle = tonumber(var_152_5.moduleLocalAngle) or 0
				var_152_3[var_152_9] = var_152_10
			end
		end
	end

	local var_152_13 = {
		bodyVisualType = "spine"
	}

	if arg_152_1 then
		var_152_13.bodyId = arg_152_1.bodyId or 0
	end

	if arg_152_1 then
		var_152_13.bodyName = arg_152_1.bodyName or ""
	end

	var_152_13.bodyAssetName = tostring(var_152_2.assetName or "")
	var_152_13.bodyType = tonumber(var_152_2.bodyType) or 0
	var_152_13.bodySkeletonDataPath = tostring(var_152_0.bodySkeletonDataPath or "")
	var_152_13.bodySkinNames = var_0_0:BuildBodySpineSkinNames(var_152_2.assetName, arg_152_2)
	var_152_13.bodyBoundsSize = var_0_0:CloneTable(var_152_0.bodyBoundsSize)
	var_152_13.bodyBoundsCenter = var_0_0:CloneTable(var_152_0.bodyBoundsCenter)
	var_152_13.hasBodyVisual = tostring(var_152_0.bodySkeletonDataPath or "") ~= ""
	var_152_13.chassisPrefabPath = tostring(var_152_0.chassisPrefabPath or "")
	var_152_13.wheels = var_0_0:CloneTable(var_152_0.wheels or {})
	var_152_13.modules = var_152_3

	return var_152_13
end

function var_0_0.BuildBuildSnapshot(arg_153_0, arg_153_1, arg_153_2)
	local var_153_0 = var_0_0:_GetBodyDefs()
	local var_153_1 = var_0_0:_GetWeaponDefs()
	local var_153_2 = var_0_0:_GetEquipDefs()
	local var_153_3 = var_0_0:FindDefById(var_153_0, (arg_153_1 or nil) and (arg_153_1.bodyId or arg_153_1.selectedBodyId or nil)) or var_153_0[1] or {
		cost = 0,
		bodyName = "",
		hp = 0,
		desc = "",
		configPath = "",
		bodyId = 0
	}
	local var_153_4 = var_0_0:NormalizeBuildDataForBody(var_153_3, arg_153_1)
	local var_153_5 = var_0_0:BuildBodyMountLayout(var_153_3)
	local var_153_6 = {}
	local var_153_7 = {}
	local var_153_8 = {}
	local var_153_9 = 0

	for iter_153_0 = 1, #var_153_5.weaponMounts do
		local var_153_10 = var_0_0:FindDefById(var_153_1, var_153_4.weaponIds[iter_153_0])

		if var_153_10 ~= nil then
			var_153_9 = var_153_9 + var_153_10.cost
			var_153_6[#var_153_6 + 1] = {
				isEquipped = true,
				itemId = var_153_10.itemId,
				itemName = var_153_10.itemName,
				cost = var_153_10.cost,
				typeText = var_153_10.typeText,
				isUnlocked = var_153_10.isUnlocked,
				isSelected = var_153_10.itemId == arg_153_2
			}
		end

		var_153_8[#var_153_8 + 1] = var_0_0:BuildSlotData(iter_153_0, SummerRaceConst.FILTER.WEAPON, var_153_10, arg_153_2, var_153_5.weaponMounts[iter_153_0])
	end

	for iter_153_1 = 1, #var_153_5.equipMounts do
		local var_153_11 = var_0_0:FindDefById(var_153_2, var_153_4.equipIds[iter_153_1])

		if var_153_11 ~= nil then
			var_153_9 = var_153_9 + var_153_11.cost
			var_153_7[#var_153_7 + 1] = {
				isEquipped = true,
				itemId = var_153_11.itemId,
				itemName = var_153_11.itemName,
				cost = var_153_11.cost,
				typeText = var_153_11.typeText,
				isUnlocked = var_153_11.isUnlocked,
				isSelected = var_153_11.itemId == arg_153_2
			}
		end

		var_153_8[#var_153_8 + 1] = var_0_0:BuildSlotData(iter_153_1, SummerRaceConst.FILTER.EQUIP, var_153_11, arg_153_2, var_153_5.equipMounts[iter_153_1])
	end

	return {
		bodyId = var_153_3.bodyId,
		bodyName = var_153_3.bodyName,
		bodyDesc = var_153_3.desc,
		hp = var_153_3.hp,
		cost = var_153_3.cost,
		totalCost = var_153_9,
		costSummary = var_0_0:BuildCostSummary(var_153_9, var_153_3.cost),
		weaponList = var_153_6,
		equipList = var_153_7,
		slotSummary = var_153_8,
		bodyLayout = var_153_5,
		buildData = var_0_0:CloneTable(var_153_4)
	}
end

function var_0_0.RoundToInt(arg_154_0, arg_154_1)
	return math.floor((tonumber(arg_154_1) or 0) + 0.5)
end

function var_0_0.BuildEnemyBuildSnapshot(arg_155_0, arg_155_1, arg_155_2)
	local var_155_1 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), (arg_155_1 or nil) and (arg_155_1.bodyId or 0))

	if var_155_1 == nil and arg_155_1 ~= nil then
		if tostring(arg_155_1.bodyKey or "") ~= "" then
			var_155_1 = var_0_0:FindBodyDefByRuntimeKey(arg_155_1.bodyKey)
		end
	end

	var_155_1 = var_155_1 or var_0_0:GetDefaultBodyDef()

	if var_155_1 == nil then
		return var_0_0:BuildBuildSnapshot(nil, arg_155_2)
	end

	local var_155_3 = {
		bodyId = var_155_1.bodyId
	}

	var_155_3.weaponIds = var_0_0:CloneTable((arg_155_1 or nil) and (arg_155_1.weaponList or {}))
	var_155_3.equipIds = var_0_0:CloneTable((arg_155_1 or nil) and (arg_155_1.equipList or {}))

	return var_0_0:BuildBuildSnapshot(var_155_3, arg_155_2)
end

function var_0_0:BuildRuntimeBattleInfoPopModel(arg_156_1)
	local var_156_0 = self:BuildCurrentBuildSnapshot()
	local var_156_1 = arg_156_1 and tonumber(arg_156_1.wave) or nil
	local var_156_3 = {
		nextEnabled = false,
		source = "runtime",
		prevEnabled = false,
		titleText = (var_156_1 ~= nil and var_156_1 > 0 or nil) and string.format(var_0_0:ResolveTipsText("ACTIVITY_TANK_WAVE"), var_0_0:RoundToInt(var_156_1)),
		hpText = tostring(var_0_0:RoundToInt(var_156_0.hp)),
		enemyAvatarPath = self:GetRuntimeEnemyAvatarPath(arg_156_1),
		vehicleDisplay = var_0_0:BuildVehicleDisplayModelFromSnapshot(var_156_0),
		slotSummary = var_0_0:CloneTable(var_156_0.slotSummary)
	}

	var_156_3.waveIndex = var_156_1 ~= nil and var_0_0:RoundToInt(var_156_1) or 0
	var_156_3.waveTotal = var_156_1 ~= nil and var_0_0:RoundToInt(var_156_1) or 0

	return var_156_3
end

function var_0_0:ResolveStageWaveContext(arg_157_1)
	local var_157_0

	if arg_157_1 then
		var_157_0 = arg_157_1.stageId or var_0_0.outGameState_.currentStageId
	end

	local var_157_1 = var_157_0 ~= nil and self:GetStageDetailModel(var_157_0) or nil
	local var_157_2

	if var_157_1 then
		var_157_2 = var_157_1.enemyWaves or {}
	end

	local var_157_3 = #var_157_2
	local var_157_4 = var_0_0:RoundToInt((arg_157_1 or nil) and (arg_157_1.waveIndex or 0))

	if var_157_4 <= 0 then
		var_157_4 = 1
	end

	if var_157_3 > 0 then
		var_157_4 = math.min(math.max(var_157_4, 1), var_157_3)
	end

	local var_157_5 = var_157_2[var_157_4]
	local var_157_6

	if arg_157_1 then
		var_157_6 = arg_157_1.enemyId or nil

		if var_157_6 == nil and var_157_5 ~= nil then
			var_157_6 = var_157_5.enemyId
		end
	end

	return var_157_1, var_157_4, var_157_3, var_157_6
end

function var_0_0.BuildStageWaveBattleInfoPopModel(arg_158_0, arg_158_1)
	local var_158_0 = var_0_0:GetEnemyDefs()
	local var_158_1, var_158_2, var_158_3, var_158_4 = var_0_0.ResolveStageWaveContext(arg_158_0, arg_158_1)
	local var_158_5 = tonumber(((var_158_1 or nil) and (var_158_1.enemyWaves or {}))[var_158_2] and ((var_158_1 or nil) and (var_158_1.enemyWaves or {}))[var_158_2].sourceWaveIndex) or var_158_2
	local var_158_6 = var_0_0:FindDefById(var_158_0, var_158_4) or var_158_0[1] or {
		baseHp = 0,
		enemyId = 0,
		enemyName = "",
		weaponList = {},
		equipList = {}
	}
	local var_158_7 = var_0_0:BuildEnemyBuildSnapshot(var_158_6, nil)
	local var_158_8 = tonumber(var_158_6.baseHp) or tonumber(var_158_7.hp) or 0
	local var_158_9 = {
		source = "stageDetail"
	}

	var_158_9.titleText = var_158_5 > 0 and string.format(var_0_0:ResolveTipsText("ACTIVITY_TANK_WAVE"), var_158_5) or ""

	local var_158_10

	if var_158_1 and var_158_1.stageInfo then
		var_158_10 = var_158_1.stageInfo.stageId

		if not var_158_1.stageInfo.stageId then
			if arg_158_1 then
				var_158_10 = arg_158_1.stageId or var_0_0.outGameState_.currentStageId
			end
		end
	end

	var_158_9.stageId = var_158_10
	var_158_9.waveIndex = var_158_2
	var_158_9.waveTotal = var_158_3
	var_158_9.prevEnabled = var_158_2 > 1
	var_158_9.nextEnabled = var_158_3 > 0 and var_158_2 < var_158_3
	var_158_9.enemyId = var_158_6.enemyId
	var_158_9.enemyAvatarPath = var_0_0:ResolveEnemyAvatarPath(var_158_6)
	var_158_9.enemyName = var_158_6.enemyName
	var_158_9.hpText = tostring(var_0_0:RoundToInt(var_158_8))
	var_158_9.vehicleDisplay = var_0_0:BuildVehicleDisplayModelFromSnapshot(var_158_7, var_158_6.logo)
	var_158_9.slotSummary = var_0_0:CloneTable(var_158_7.slotSummary)
	var_158_9.weaponList = var_0_0:CloneTable(var_158_7.weaponList)
	var_158_9.equipList = var_0_0:CloneTable(var_158_7.equipList)

	return var_158_9
end

function var_0_0.FindChallengeStageInfo(arg_159_0)
	local var_159_0 = var_0_0:GetStageDefs()

	for iter_159_0 = 1, #var_159_0 do
		if tonumber(var_159_0[iter_159_0].modeType) == 4 then
			return var_0_0:CloneTable(var_159_0[iter_159_0])
		end
	end

	return nil
end

function var_0_0.BuildEnemyWaveDisplayList(arg_160_0, arg_160_1, arg_160_2)
	local var_160_0 = {}
	local var_160_1 = tonumber(arg_160_1 and arg_160_1.modeType) or 0

	if var_160_1 == 1 then
		for iter_160_0 = 1, #((arg_160_1 or nil) and (arg_160_1.enemyWaves or {})) do
			local var_160_4 = var_0_0:CloneTable(arg_160_1.enemyWaves[iter_160_0] or {})

			if #var_160_4 > 0 then
				var_160_0[#var_160_0 + 1] = {
					waveIndex = #var_160_0 + 1,
					waveTextIndex = #var_160_0 + 1,
					enemyIds = var_160_4
				}
			end
		end
	elseif var_160_1 == 2 then
		for iter_160_1 = 1, #((arg_160_1 or nil) and (arg_160_1.survivalRandomPool or {})) do
			if type(arg_160_1.survivalRandomPool[iter_160_1]) == "table" and arg_160_1.survivalRandomPool[iter_160_1].enemyId ~= nil then
				var_160_0[#var_160_0 + 1] = {
					waveTextIndex = 1,
					sourceWaveIndex = 1,
					waveIndex = #var_160_0 + 1,
					enemyIds = {
						arg_160_1.survivalRandomPool[iter_160_1].enemyId
					}
				}
			end
		end
	elseif var_160_1 == 3 then
		for iter_160_2 = 1, #((arg_160_1 or nil) and (arg_160_1.enemyWaves or {})) do
			local var_160_8 = var_0_0:CloneTable(arg_160_1.enemyWaves[iter_160_2] or {})

			for iter_160_3 = 1, #var_160_8 do
				if var_160_8[iter_160_3] ~= nil and var_160_8[iter_160_3] ~= "" and var_160_8[iter_160_3] ~= 0 then
					var_160_0[#var_160_0 + 1] = {
						waveIndex = #var_160_0 + 1,
						waveTextIndex = iter_160_2,
						sourceWaveIndex = iter_160_2,
						enemyIds = {
							var_160_8[iter_160_3]
						}
					}
				end
			end
		end
	elseif var_160_1 == 4 then
		for iter_160_4 = 1, #((arg_160_1 or nil) and (arg_160_1.challengeRandomPool or {})) do
			if type(arg_160_1.challengeRandomPool[iter_160_4]) == "table" and arg_160_1.challengeRandomPool[iter_160_4].enemyId ~= nil then
				var_160_0[#var_160_0 + 1] = {
					waveIndex = #var_160_0 + 1,
					waveTextIndex = #var_160_0 + 1,
					enemyIds = {
						arg_160_1.challengeRandomPool[iter_160_4].enemyId
					}
				}
			end
		end
	end

	local var_160_10 = {}

	for iter_160_5 = 1, #var_160_0 do
		local var_160_11 = var_0_0:FindDefById(arg_160_2, var_160_0[iter_160_5].enemyIds[1])

		if var_160_11 ~= nil then
			local var_160_12 = #var_160_10 + 1
			local var_160_13 = {
				waveIndex = var_160_0[iter_160_5].waveIndex
			}

			var_160_13.sourceWaveIndex = var_160_0[iter_160_5].sourceWaveIndex or var_160_0[iter_160_5].waveIndex
			var_160_13.waveText = string.format(var_0_0:ResolveTipsText("ACTIVITY_TANK_WAVE"), var_160_0[iter_160_5].waveTextIndex)
			var_160_13.enemyId = var_160_11.enemyId
			var_160_13.enemyIds = var_0_0:CloneTable(var_160_0[iter_160_5].enemyIds)
			var_160_13.enemyName = var_160_11.enemyName
			var_160_13.enemyAvatarPath = var_0_0:ResolveEnemyAvatarPath(var_160_11)
			var_160_13.enemyCount = math.max(1, #var_160_0[iter_160_5].enemyIds)
			var_160_13.isElite = var_160_11.enemyType >= 2
			var_160_13.isExpanded = iter_160_5 == #var_160_0
			var_160_13.equipList = var_0_0:CloneTable(var_160_11.equipList)
			var_160_10[var_160_12] = var_160_13
		end
	end

	return var_160_10
end

function var_0_0:Init()
	self.runtimeState_ = nil
	self.runtimeStateReady_ = false
	self.guideTriggerContext_ = {}
	self.resolvedStageMap_ = {
		[SummerRaceConst.MODE.CHAMPIONSHIP] = "",
		[SummerRaceConst.MODE.SURVIVAL_PRACTICE] = "",
		[SummerRaceConst.MODE.ONE_VS_TWO_PRACTICE] = "",
		[SummerRaceConst.MODE.CHALLENGE] = ""
	}
	self.settlementState_ = nil
	self.settlementReady_ = false
	var_0_0.outGameState_ = var_0_0:BuildDefaultOutGameState()
	self.frameworkRedPointReady_ = false

	self:EnsureFrameworkRedPoints()
end

function var_0_0:SetGuideTriggerContext(arg_162_1, arg_162_2)
	local var_162_0 = tostring(arg_162_1 or "")

	if var_162_0 == "" then
		return nil
	end

	local var_162_1 = var_0_0:CloneTable(type(arg_162_2) == "table" and arg_162_2 or {})

	var_162_1.active = true
	var_162_1.contextType = var_162_0
	self.guideTriggerContext_[var_162_0] = var_162_1

	return var_0_0:CloneTable(var_162_1)
end

function var_0_0:ClearGuideTriggerContext(arg_163_1)
	local var_163_0 = tostring(arg_163_1 or "")

	if var_163_0 == "" then
		return
	end

	self.guideTriggerContext_[var_163_0] = nil
end

function var_0_0:GetGuideTriggerContext(arg_164_1)
	local var_164_0 = tostring(arg_164_1 or "")

	if var_164_0 == "" then
		return nil
	end

	local var_164_1 = self.guideTriggerContext_[var_164_0]

	if self.guideTriggerContext_[var_164_0] == nil then
		return nil
	end

	return var_0_0:CloneTable(var_164_1)
end

function var_0_0.NormalizeMode(arg_165_0, arg_165_1)
	local var_165_0 = var_0_0:ResolveModeKey(arg_165_1)

	if var_165_0 == nil then
		error("[SummerRaceData] invalid mode: " .. tostring(arg_165_1))
	end

	return var_165_0
end

function var_0_0.NormalizeTournamentTab(arg_166_0, arg_166_1)
	return var_0_0:NormalizeAllowedValue(arg_166_1, SummerRaceConst.VALID_TOURNAMENT_TAB, SummerRaceConst.TOURNAMENT_TAB.NORMAL)
end

function var_0_0.NormalizeModifyFilter(arg_167_0, arg_167_1)
	return var_0_0:NormalizeAllowedValue(arg_167_1, SummerRaceConst.VALID_MODIFY_FILTER, SummerRaceConst.FILTER.ALL)
end

function var_0_0.NormalizeIllustratedFilter(arg_168_0, arg_168_1)
	return var_0_0:NormalizeAllowedValue(arg_168_1, SummerRaceConst.VALID_ILLUSTRATED_FILTER, SummerRaceConst.FILTER.BODY)
end

function var_0_0.NormalizeRewardPageType(arg_169_0, arg_169_1)
	return var_0_0:NormalizeAllowedValue(arg_169_1, SummerRaceConst.VALID_REWARD_PAGE, SummerRaceConst.REWARD_PAGE.LIMITED)
end

function var_0_0.NormalizeRewardSubType(arg_170_0, arg_170_1)
	return var_0_0:NormalizeAllowedValue(arg_170_1, SummerRaceConst.VALID_REWARD_SUBTYPE, SummerRaceConst.REWARD_SUBTYPE.DAILY)
end

function var_0_0.NormalizeSourceType(arg_171_0, arg_171_1)
	return var_0_0:NormalizeAllowedValue(arg_171_1, SummerRaceConst.VALID_SOURCE_TYPE, SummerRaceConst.SOURCE_TYPE.MODIFY)
end

function var_0_0:HasRuntimeState()
	return self.runtimeStateReady_ == true and self.runtimeState_ ~= nil
end

function var_0_0:HasSettlementState()
	return self.settlementReady_ == true and self.settlementState_ ~= nil
end

function var_0_0:NotifyOutGameUpdated(arg_174_1)
	self:RefreshFrameworkRedPoints()
	var_0_0:InvokeNotify(var_0_0.GetEventOutGameUpdated(), arg_174_1 or "outGame")
end

function var_0_0:PushRuntimeState(arg_175_1)
	var_0_0:RequireTable(arg_175_1, "runtime snapshot")

	local var_175_0 = var_0_0:RequireArray(arg_175_1.skills, "runtime snapshot.skills")
	local var_175_1 = self:BuildCurrentBuildSnapshot()
	local var_175_2 = var_0_0:BuildRuntimeSkillVisualTable((var_0_0:RequireArray(var_175_1 and var_175_1.slotSummary, "current build snapshot.slotSummary")))
	local var_175_3 = {}
	local var_175_4 = false

	for iter_175_0 = 1, #var_175_0 do
		var_0_0:RequireTable(var_175_0[iter_175_0], "runtime snapshot.skills[" .. iter_175_0 .. "]")

		local var_175_5 = {
			slotIndex = var_0_0:RequireNumber(var_175_0[iter_175_0].slotIndex, "runtime snapshot.skills[" .. iter_175_0 .. "].slotIndex"),
			slotType = var_0_0:RequireSkillType(var_175_0[iter_175_0].slotType, "runtime snapshot.skills[" .. iter_175_0 .. "].slotType"),
			label = var_0_0:RequireString(var_175_0[iter_175_0].label, "runtime snapshot.skills[" .. iter_175_0 .. "].label"),
			cooldownRemaining = var_0_0:RequireNumber(var_175_0[iter_175_0].cooldownRemaining, "runtime snapshot.skills[" .. iter_175_0 .. "].cooldownRemaining"),
			cooldownTotal = var_0_0:RequireNumber(var_175_0[iter_175_0].cooldownTotal, "runtime snapshot.skills[" .. iter_175_0 .. "].cooldownTotal"),
			overloadRemaining = var_0_0:RequireNumber(var_175_0[iter_175_0].overloadRemaining, "runtime snapshot.skills[" .. iter_175_0 .. "].overloadRemaining"),
			overloadTotal = var_0_0:RequireNumber(var_175_0[iter_175_0].overloadTotal, "runtime snapshot.skills[" .. iter_175_0 .. "].overloadTotal"),
			activeRemaining = var_0_0:RequireNumber(var_175_0[iter_175_0].activeRemaining, "runtime snapshot.skills[" .. iter_175_0 .. "].activeRemaining"),
			activeTotal = var_0_0:RequireNumber(var_175_0[iter_175_0].activeTotal, "runtime snapshot.skills[" .. iter_175_0 .. "].activeTotal"),
			energyCost = var_0_0:RequireNumber(var_175_0[iter_175_0].energyCost, "runtime snapshot.skills[" .. iter_175_0 .. "].energyCost"),
			overloadEnergyCost = var_0_0:RequireNumber(var_175_0[iter_175_0].overloadEnergyCost, "runtime snapshot.skills[" .. iter_175_0 .. "].overloadEnergyCost"),
			isReady = var_0_0:RequireBoolean(var_175_0[iter_175_0].isReady, "runtime snapshot.skills[" .. iter_175_0 .. "].isReady"),
			isOverloaded = var_0_0:RequireBoolean(var_175_0[iter_175_0].isOverloaded, "runtime snapshot.skills[" .. iter_175_0 .. "].isOverloaded"),
			canUse = var_0_0:RequireBoolean(var_175_0[iter_175_0].canUse, "runtime snapshot.skills[" .. iter_175_0 .. "].canUse"),
			canOverload = var_0_0:RequireBoolean(var_175_0[iter_175_0].canOverload, "runtime snapshot.skills[" .. iter_175_0 .. "].canOverload"),
			inputBlocked = var_0_0:RequireBoolean(var_175_0[iter_175_0].inputBlocked, "runtime snapshot.skills[" .. iter_175_0 .. "].inputBlocked")
		}
		local var_175_6 = var_175_2[var_175_5.slotType]
		local var_175_7

		if var_175_2[var_175_5.slotType] then
			var_175_7 = var_175_6[var_175_5.slotIndex + 1] or nil

			if var_175_7 == nil then
				local var_175_9 = "[SummerRaceData] runtime skill visual missing: slotType=%s runtimeSlotIndex=%d visualCount=%d"

				error(string.format(var_175_9, tostring(var_175_5.slotType), tonumber(var_175_5.slotIndex) or -1, (var_175_6 or nil) and (#var_175_6 or 0)))
			end
		end

		var_175_5.displayLabel = var_0_0:RequireString(var_175_7.label, "runtime skill visual label, slotType=" .. tostring(var_175_5.slotType))
		var_175_5.iconPath = var_0_0:RequireString(var_175_7.iconPath, "runtime skill visual iconPath, slotType=" .. tostring(var_175_5.slotType))
		var_175_3[iter_175_0] = var_175_5
		var_175_4 = (var_175_5.canUse or var_175_5.canOverload) and true
	end

	local var_175_11 = {}

	if type(arg_175_1.enemyHudSlots) == "table" then
		for iter_175_1 = 1, #arg_175_1.enemyHudSlots do
			local var_175_12 = arg_175_1.enemyHudSlots[iter_175_1]

			if type(arg_175_1.enemyHudSlots[iter_175_1]) == "table" then
				local var_175_13 = #var_175_11 + 1
				local var_175_14 = {}

				var_175_14.enemyId = tostring(var_175_12.enemyId or "")
				var_175_14.enemyName = var_0_0:RequireString(var_175_12.enemyName, "runtime snapshot.enemyHudSlots[" .. iter_175_1 .. "].enemyName")
				var_175_14.enemyHp = var_0_0:RequireNumber(var_175_12.enemyHp, "runtime snapshot.enemyHudSlots[" .. iter_175_1 .. "].enemyHp")
				var_175_14.enemyMaxHp = var_0_0:RequireNumber(var_175_12.enemyMaxHp, "runtime snapshot.enemyHudSlots[" .. iter_175_1 .. "].enemyMaxHp")
				var_175_14.enemyAlive = var_0_0:RequireBoolean(var_175_12.enemyAlive, "runtime snapshot.enemyHudSlots[" .. iter_175_1 .. "].enemyAlive")
				var_175_14.enemyHeadOut = var_175_12.enemyHeadOut == true
				var_175_11[var_175_13] = var_175_14
			end
		end
	end

	local var_175_15 = {
		mode = self:NormalizeMode(arg_175_1.mode),
		wave = var_0_0:RequireNumber(arg_175_1.wave, "runtime snapshot.wave"),
		waveTotal = var_0_0:RequireNumber(arg_175_1.waveTotal, "runtime snapshot.waveTotal"),
		timer = var_0_0:RequireNumber(arg_175_1.timer, "runtime snapshot.timer"),
		countdownRemaining = var_0_0:RequireNumber(arg_175_1.countdownRemaining, "runtime snapshot.countdownRemaining"),
		waveElapsed = var_0_0:RequireNumber(arg_175_1.waveElapsed, "runtime snapshot.waveElapsed"),
		score = var_0_0:RequireNumber(arg_175_1.score, "runtime snapshot.score"),
		hp = var_0_0:RequireNumber(arg_175_1.hp, "runtime snapshot.hp"),
		maxHp = var_0_0:RequireNumber(arg_175_1.maxHp, "runtime snapshot.maxHp"),
		energy = var_0_0:RequireNumber(arg_175_1.energy, "runtime snapshot.energy"),
		maxEnergy = var_0_0:RequireNumber(arg_175_1.maxEnergy, "runtime snapshot.maxEnergy"),
		playerLabelWorldX = var_0_0:RequireNumber(arg_175_1.playerLabelWorldX, "runtime snapshot.playerLabelWorldX"),
		playerLabelWorldY = var_0_0:RequireNumber(arg_175_1.playerLabelWorldY, "runtime snapshot.playerLabelWorldY"),
		playerLabelWorldZ = var_0_0:RequireNumber(arg_175_1.playerLabelWorldZ, "runtime snapshot.playerLabelWorldZ"),
		playerLabelScreenOffsetY = var_0_0:RequireNumber(arg_175_1.playerLabelScreenOffsetY, "runtime snapshot.playerLabelScreenOffsetY"),
		enemyHp = var_0_0:RequireNumber(arg_175_1.enemyHp, "runtime snapshot.enemyHp"),
		enemyMaxHp = var_0_0:RequireNumber(arg_175_1.enemyMaxHp, "runtime snapshot.enemyMaxHp"),
		enemyCount = math.max(1, math.floor(var_0_0:RequireNumber(arg_175_1.enemyCount, "runtime snapshot.enemyCount")))
	}

	var_175_15.enemyId = tostring(arg_175_1.enemyId or "")
	var_175_15.enemyName = var_0_0:RequireString(arg_175_1.enemyName, "runtime snapshot.enemyName")
	var_175_15.enemyHudSlots = var_175_11
	var_175_15.enemyIntroText = var_0_0:RequireString(arg_175_1.enemyIntroText, "runtime snapshot.enemyIntroText")
	var_175_15.enemyOverclockBubbleText = tostring(arg_175_1.enemyOverclockBubbleText or "")
	var_175_15.enemyOverclockBubbleToken = math.max(0, math.floor(tonumber(arg_175_1.enemyOverclockBubbleToken) or 0))
	var_175_15.enemyAlive = var_0_0:RequireBoolean(arg_175_1.enemyAlive, "runtime snapshot.enemyAlive")
	var_175_15.enemyHeadOut = var_0_0:RequireBoolean(arg_175_1.enemyHeadOut, "runtime snapshot.enemyHeadOut")
	var_175_15.skillReady = var_0_0:RequireBoolean(arg_175_1.skillReady, "runtime snapshot.skillReady")
	var_175_15.stageId = var_0_0:RequireId(arg_175_1.stageId, "runtime snapshot.stageId")
	var_175_15.phase = var_0_0:RequireString(arg_175_1.phase, "runtime snapshot.phase")
	var_175_15.isBattleActive = var_0_0:RequireBoolean(arg_175_1.isBattleActive, "runtime snapshot.isBattleActive")
	var_175_15.isPaused = var_0_0:RequireBoolean(arg_175_1.isPaused, "runtime snapshot.isPaused")
	var_175_15.hasInteractableSkill = var_175_4
	var_175_15.skills = var_175_3
	self.runtimeState_ = var_175_15
	self.runtimeStateReady_ = true

	self:RefreshFrameworkRedPoints()

	local var_175_16 = var_0_0:CloneTable(self.runtimeState_)

	var_0_0:InvokeNotify(var_0_0.GetEventRuntimeUpdated(), var_175_16)

	return var_0_0:CloneTable(var_175_16)
end

function var_0_0.PushDamageTextEvent(arg_176_0, arg_176_1)
	var_0_0:RequireTable(arg_176_1, "damage text")

	local var_176_0 = math.max(0, math.floor(var_0_0:RequireNumber(arg_176_1.amount, "damage text.amount") + 0.5))

	if var_176_0 <= 0 then
		return nil
	end

	local var_176_1 = var_0_0:RequireString(arg_176_1.state, "damage text.state")

	if var_176_1 ~= "me" and var_176_1 ~= "enemy" and var_176_1 ~= "overclock" then
		error("[SummerRaceData] damage text.state must be me, enemy or overclock")
	end

	local var_176_2 = {
		amount = var_176_0,
		state = var_176_1,
		worldX = var_0_0:RequireNumber(arg_176_1.worldX, "damage text.worldX"),
		worldY = var_0_0:RequireNumber(arg_176_1.worldY, "damage text.worldY"),
		targetTeam = var_0_0:RequireString(arg_176_1.targetTeam, "damage text.targetTeam"),
		source = var_0_0:RequireString(arg_176_1.source, "damage text.source")
	}

	var_0_0:InvokeNotify(var_0_0.GetEventDamageText(), var_0_0:CloneTable(var_176_2))

	return var_0_0:CloneTable(var_176_2)
end

function var_0_0:PushPlayerLabelPose(arg_177_1)
	var_0_0:RequireTable(arg_177_1, "player label pose")

	local var_177_0 = {
		playerLabelWorldX = var_0_0:RequireNumber(arg_177_1.playerLabelWorldX, "player label pose.playerLabelWorldX"),
		playerLabelWorldY = var_0_0:RequireNumber(arg_177_1.playerLabelWorldY, "player label pose.playerLabelWorldY"),
		playerLabelWorldZ = var_0_0:RequireNumber(arg_177_1.playerLabelWorldZ, "player label pose.playerLabelWorldZ"),
		playerLabelScreenOffsetY = var_0_0:RequireNumber(arg_177_1.playerLabelScreenOffsetY, "player label pose.playerLabelScreenOffsetY")
	}

	if self.runtimeState_ ~= nil then
		self.runtimeState_.playerLabelWorldX = var_177_0.playerLabelWorldX
		self.runtimeState_.playerLabelWorldY = var_177_0.playerLabelWorldY
		self.runtimeState_.playerLabelWorldZ = var_177_0.playerLabelWorldZ
		self.runtimeState_.playerLabelScreenOffsetY = var_177_0.playerLabelScreenOffsetY
	end

	var_0_0:InvokeNotify(var_0_0.GetEventPlayerLabelPoseUpdated(), var_0_0:CloneTable(var_177_0))

	return var_0_0:CloneTable(var_177_0)
end

function var_0_0:GetRuntimeState()
	if not self:HasRuntimeState() then
		return nil
	end

	return var_0_0:CloneTable(self.runtimeState_)
end

function var_0_0:ReplayRuntimeState(arg_179_1)
	if arg_179_1 == nil or not self:HasRuntimeState() then
		return false
	end

	arg_179_1(var_0_0:CloneTable(self.runtimeState_))

	return true
end

function var_0_0:PushResolvedStage(arg_180_1, arg_180_2)
	local var_180_0 = self:NormalizeMode(arg_180_2)
	local var_180_1 = var_0_0:RequireId(arg_180_1, "resolved stageId")

	self.resolvedStageMap_[var_180_0] = var_180_1

	if self:HasRuntimeState() and self.runtimeState_.mode == var_180_0 then
		self.runtimeState_.stageId = var_180_1

		var_0_0:InvokeNotify(var_0_0.GetEventRuntimeUpdated(), var_0_0:CloneTable(self.runtimeState_))
	end

	var_0_0:InvokeNotify(var_0_0.GetEventStageResolved(), var_180_0, var_180_1)
end

function var_0_0:GetCurrentStageIdByMode(arg_181_1)
	local var_181_0 = var_0_0:ResolveModeKey(arg_181_1)

	if var_181_0 == nil then
		return nil
	end

	return self.resolvedStageMap_[var_181_0]
end

function var_0_0:PushSettlementState(arg_182_1)
	var_0_0:RequireTable(arg_182_1, "settlement")

	local var_182_0 = {}

	if type(arg_182_1.roundRecords) == "table" then
		for iter_182_0 = 1, #arg_182_1.roundRecords do
			if type(arg_182_1.roundRecords[iter_182_0]) == "table" then
				local var_182_1 = {}

				var_182_1.round = math.max(0, math.floor(tonumber(arg_182_1.roundRecords[iter_182_0].round) or 0))
				var_182_1.result = tostring(arg_182_1.roundRecords[iter_182_0].result or "")
				var_182_1.durationSec = math.max(0, tonumber(arg_182_1.roundRecords[iter_182_0].durationSec) or 0)
				var_182_1.score = math.max(0, math.floor(tonumber(arg_182_1.roundRecords[iter_182_0].score) or 0))
				var_182_0[#var_182_0 + 1] = var_182_1
			end
		end
	end

	local var_182_2 = {}

	if type(arg_182_1.challengeRoundRecords) == "table" then
		for iter_182_1 = 1, #arg_182_1.challengeRoundRecords do
			if type(arg_182_1.challengeRoundRecords[iter_182_1]) == "table" then
				local var_182_3 = {}

				var_182_3.round = math.max(0, math.floor(tonumber(arg_182_1.challengeRoundRecords[iter_182_1].round) or 0))
				var_182_3.result = tostring(arg_182_1.challengeRoundRecords[iter_182_1].result or "")
				var_182_3.durationSec = math.max(0, tonumber(arg_182_1.challengeRoundRecords[iter_182_1].durationSec) or 0)
				var_182_3.score = math.max(0, math.floor(tonumber(arg_182_1.challengeRoundRecords[iter_182_1].score) or 0))
				var_182_2[#var_182_2 + 1] = var_182_3
			end
		end
	end

	local var_182_4 = {}

	if type(arg_182_1.survivalEnemyRecords) == "table" then
		for iter_182_2 = 1, #arg_182_1.survivalEnemyRecords do
			local var_182_5 = arg_182_1.survivalEnemyRecords[iter_182_2]

			if type(arg_182_1.survivalEnemyRecords[iter_182_2]) == "table" then
				local var_182_6 = tonumber(var_182_5.enemyId) or var_182_5.enemyId

				if var_182_6 ~= nil and var_182_6 ~= "" and var_182_6 ~= 0 then
					local var_182_7 = #var_182_4 + 1
					local var_182_8 = {}

					var_182_8.round = math.max(0, math.floor(tonumber(var_182_5.round) or 0))
					var_182_8.enemyId = var_182_6
					var_182_8.result = tostring(var_182_5.result or "")
					var_182_8.durationSec = math.max(0, tonumber(var_182_5.durationSec) or 0)
					var_182_8.showTime = var_182_5.showTime ~= false
					var_182_4[var_182_7] = var_182_8
				end
			end
		end
	end

	local var_182_9 = {
		isWin = var_0_0:RequireBoolean(arg_182_1.isWin, "settlement.isWin"),
		mode = self:NormalizeMode(arg_182_1.mode),
		stageId = var_0_0:RequireId(arg_182_1.stageId, "settlement.stageId"),
		score = var_0_0:RequireNumber(arg_182_1.score, "settlement.score"),
		destroyedEnemies = var_0_0:RequireNumber(arg_182_1.destroyedEnemies, "settlement.destroyedEnemies"),
		battleElapsed = var_0_0:RequireNumber(arg_182_1.battleElapsed, "settlement.battleElapsed"),
		resultText = var_0_0:RequireString(arg_182_1.resultText, "settlement.resultText")
	}

	var_182_9.resultReason = tostring(arg_182_1.resultReason or "")
	var_182_9.roundRecords = var_182_0
	var_182_9.survivalEnemyRecords = var_182_4
	var_182_9.challengeReachedWave = math.max(0, math.floor(tonumber(arg_182_1.challengeReachedWave) or 0))
	var_182_9.challengeRoundRecords = var_182_2
	self.settlementState_ = var_182_9
	self.settlementState_.rank = var_0_0.ResolveSettlementRank(self, self.settlementState_)
	self.settlementState_.records = var_0_0.BuildSettlementRecords(self, self.settlementState_)
	self.settlementState_.vehicleDisplay = var_0_0:BuildVehicleDisplayModelFromSnapshot(self:BuildCurrentBuildSnapshot())
	self.settlementState_.isNewRecord = self.settlementState_.mode == SummerRaceConst.MODE.CHALLENGE and self.settlementState_.score > self:NormalizeChallengeBestScore(var_0_0.outGameState_.challengeBestScore)
	self.settlementReady_ = true

	self:RefreshFrameworkRedPoints()

	local var_182_10 = var_0_0:CloneTable(self.settlementState_)

	var_0_0:InvokeNotify(var_0_0.GetEventSettlementUpdated(), var_182_10)

	return var_0_0:CloneTable(var_182_10)
end

function var_0_0:GetSettlementState()
	if not self:HasSettlementState() then
		return nil
	end

	return var_0_0:CloneTable(self.settlementState_)
end

function var_0_0.ClearSettlementState(arg_184_0, arg_184_1)
	arg_184_0.settlementState_ = nil
	arg_184_0.settlementReady_ = false

	if arg_184_1 ~= true then
		var_0_0:InvokeNotify(var_0_0.GetEventSettlementUpdated(), nil)
	end
end

function var_0_0:ReplaySettlementState(arg_185_1)
	if arg_185_1 == nil or not self:HasSettlementState() then
		return false
	end

	arg_185_1(var_0_0:CloneTable(self.settlementState_))

	return true
end

function var_0_0:GetMode()
	if not self:HasRuntimeState() then
		return nil
	end

	return self.runtimeState_.mode
end

function var_0_0:IsChallengeMode(arg_187_1)
	return self:NormalizeMode(arg_187_1 or self:GetMode()) == SummerRaceConst.MODE.CHALLENGE
end

function var_0_0:GetBodyDefs()
	local var_188_0 = var_0_0:CloneTable(var_0_0:_GetBodyDefs())

	for iter_188_0 = 1, #var_188_0 do
		var_188_0[iter_188_0].isUnlocked = self:IsBodyUnlocked(var_188_0[iter_188_0].bodyId)
	end

	return var_188_0
end

function var_0_0:GetWeaponDefs()
	local var_189_0 = var_0_0:CloneTable(var_0_0:_GetWeaponDefs())

	for iter_189_0 = 1, #var_189_0 do
		var_189_0[iter_189_0].isUnlocked = self:IsOptionUnlocked(var_189_0[iter_189_0].itemId)
	end

	return var_189_0
end

function var_0_0:GetEquipDefs()
	local var_190_0 = var_0_0:CloneTable(var_0_0:_GetEquipDefs())

	for iter_190_0 = 1, #var_190_0 do
		var_190_0[iter_190_0].isUnlocked = self:IsOptionUnlocked(var_190_0[iter_190_0].itemId)
	end

	return var_190_0
end

function var_0_0:GetCombinedOptionDefs()
	local var_191_0 = var_0_0:_GetWeaponDefs()
	local var_191_1 = var_0_0:_GetEquipDefs()
	local var_191_2 = {}

	for iter_191_0 = 1, #var_191_0 do
		local var_191_3 = var_0_0:CloneTable(var_191_0[iter_191_0])

		var_191_3.isUnlocked = self:IsOptionUnlocked(var_191_3.itemId)
		var_191_2[#var_191_2 + 1] = var_191_3
	end

	for iter_191_1 = 1, #var_191_1 do
		local var_191_4 = var_0_0:CloneTable(var_191_1[iter_191_1])

		var_191_4.isUnlocked = self:IsOptionUnlocked(var_191_4.itemId)
		var_191_2[#var_191_2 + 1] = var_191_4
	end

	return var_191_2
end

function var_0_0.IsBodyUnlocked(arg_192_0, arg_192_1)
	return var_0_0.BuildUnlockedRewardStateFromProgress(arg_192_0).bodyIds[tonumber(arg_192_1) or arg_192_1] == true
end

function var_0_0.IsOptionUnlocked(arg_193_0, arg_193_1)
	return var_0_0.BuildUnlockedRewardStateFromProgress(arg_193_0).optionIds[tonumber(arg_193_1) or arg_193_1] == true
end

function var_0_0:GetOptionDefById(arg_194_1)
	if arg_194_1 == nil then
		return nil
	end

	local var_194_0 = var_0_0:FindDefById(var_0_0:_GetWeaponDefs(), arg_194_1)

	if var_194_0 ~= nil then
		local var_194_1 = var_0_0:CloneTable(var_194_0)

		var_194_1.isUnlocked = self:IsOptionUnlocked(var_194_1.itemId)

		return var_194_1
	end

	local var_194_2 = var_0_0:FindDefById(var_0_0:_GetEquipDefs(), arg_194_1)

	if var_194_2 ~= nil then
		local var_194_3 = var_0_0:CloneTable(var_194_2)

		var_194_3.isUnlocked = self:IsOptionUnlocked(var_194_3.itemId)

		return var_194_3
	end

	return nil
end

function var_0_0:SetTournamentTab(arg_195_1, arg_195_2)
	var_0_0.outGameState_.tournamentTab = self:NormalizeTournamentTab(arg_195_1)
	var_0_0.outGameState_.currentStageId = var_0_0:ResolveStageIdForTab(var_0_0.outGameState_.tournamentTab, var_0_0.outGameState_.currentStageId)

	if not arg_195_2 then
		self:NotifyOutGameUpdated("tournamentTab")
	end

	return var_0_0.outGameState_.tournamentTab
end

function var_0_0:SetCurrentStageId(arg_196_1, arg_196_2)
	var_0_0.outGameState_.currentStageId = tonumber(arg_196_1) or arg_196_1

	if not arg_196_2 then
		self:NotifyOutGameUpdated("stageId")
	end

	return var_0_0.outGameState_.currentStageId
end

function var_0_0:SetModifyFilter(arg_197_1, arg_197_2)
	var_0_0.outGameState_.modifyFilterType = self:NormalizeModifyFilter(arg_197_1)

	if not arg_197_2 then
		self:NotifyOutGameUpdated("modifyFilter")
	end

	return var_0_0.outGameState_.modifyFilterType
end

function var_0_0:SetSelectedModifySlot(arg_198_1, arg_198_2, arg_198_3, arg_198_4)
	local var_198_0

	if arg_198_1 == SummerRaceConst.FILTER.WEAPON then
		var_198_0 = SummerRaceConst.FILTER.WEAPON

		if not SummerRaceConst.FILTER.WEAPON then
			if arg_198_1 == SummerRaceConst.FILTER.EQUIP then
				var_198_0 = SummerRaceConst.FILTER.EQUIP or nil
			end
		end
	end

	local var_198_1 = tonumber(arg_198_2) or 0
	local var_198_2 = (var_0_0:getCurrentBuild() or {}).bodyId
	local var_198_3 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), (not (var_0_0:getCurrentBuild() or {}).bodyId or nil) and var_0_0.outGameState_.selectedBodyId)

	var_198_3 = var_198_3 or var_0_0:GetDefaultBodyDef()

	local var_198_4 = var_0_0:BuildBodyMountLayout(var_198_3)

	if var_198_0 == nil then
		error("[SummerRaceData] invalid slot type: " .. tostring(arg_198_1))
	end

	if var_0_0:GetMountListBySlotType(var_198_4, var_198_0)[var_198_1] == nil then
		error("[SummerRaceData] invalid slot index " .. tostring(var_198_1) .. " for slot type " .. tostring(var_198_0))
	end

	var_0_0.outGameState_.selectedModifySlotType = var_198_0
	var_0_0.outGameState_.selectedModifySlotIndex = var_198_1

	local var_198_5 = var_0_0:GetBuildIdListBySlotType(var_0_0:getCurrentBuild(), var_198_0)[var_198_1]

	if arg_198_4 ~= nil then
		var_0_0.outGameState_.modifySlotFilterActive = arg_198_4 == true
	elseif var_198_5 == nil or var_198_5 == "" then
		var_0_0.outGameState_.modifySlotFilterActive = true
	end

	if var_198_5 ~= nil and var_198_5 ~= "" then
		var_0_0.outGameState_.selectedOptionId = var_198_5
		var_0_0.outGameState_.modifyInfoTarget = "option"
	else
		var_0_0.outGameState_.selectedOptionId = ""
		var_0_0.outGameState_.modifyInfoTarget = "slot"
	end

	if not arg_198_3 then
		self:NotifyOutGameUpdated("modifySlot")
	end

	return {
		slotType = var_0_0.outGameState_.selectedModifySlotType,
		slotIndex = var_0_0.outGameState_.selectedModifySlotIndex
	}
end

function var_0_0:ClearSelectedModifySlot(arg_199_1)
	var_0_0.outGameState_.selectedModifySlotType = ""
	var_0_0.outGameState_.selectedModifySlotIndex = 0
	var_0_0.outGameState_.modifySlotFilterActive = false

	if not arg_199_1 then
		self:NotifyOutGameUpdated("modifySlot")
	end
end

function var_0_0.GetSelectedModifySlot(arg_200_0)
	local var_200_1 = tostring(var_0_0.outGameState_.selectedModifySlotType or "")
	local var_200_2 = tonumber(var_0_0.outGameState_.selectedModifySlotIndex) or 0

	if var_200_1 == "" or var_200_2 <= 0 then
		return nil
	end

	return {
		slotType = var_200_1,
		slotIndex = var_200_2
	}
end

function var_0_0:ResetModifyOperateState(arg_201_1)
	var_0_0.outGameState_.modifyFilterType = SummerRaceConst.FILTER.ALL
	var_0_0.outGameState_.selectedModifySlotType = ""
	var_0_0.outGameState_.selectedModifySlotIndex = 0
	var_0_0.outGameState_.modifySlotFilterActive = false
	var_0_0.outGameState_.modifyInfoTarget = "body"
	var_0_0.outGameState_.selectedOptionId = ""

	if not arg_201_1 then
		self:NotifyOutGameUpdated("modifyReset")
	end
end

function var_0_0:SetIllustratedFilter(arg_202_1, arg_202_2)
	var_0_0.outGameState_.illustratedFilterType = self:NormalizeIllustratedFilter(arg_202_1)

	if not arg_202_2 then
		self:NotifyOutGameUpdated("illustratedFilter")
	end

	return var_0_0.outGameState_.illustratedFilterType
end

function var_0_0:SetSelectedBody(arg_203_1, arg_203_2)
	local var_203_0 = tonumber(arg_203_1) or arg_203_1

	if var_0_0:FindDefById(var_0_0:_GetBodyDefs(), var_203_0) ~= nil then
		var_0_0.outGameState_.selectedBodyId = var_203_0
		var_0_0.outGameState_.currentBuild = var_203_0
		var_0_0.outGameState_.modifyInfoTarget = "body"
		var_0_0.outGameState_.selectedOptionId = ""

		self:ClearSelectedModifySlot(true)
	end

	if not arg_203_2 then
		self:NotifyOutGameUpdated("body")
	end

	return var_0_0.outGameState_.selectedBodyId
end

function var_0_0:CanSelectBody(arg_204_1)
	local var_204_0 = tonumber(arg_204_1) or arg_204_1
	local var_204_1 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), var_204_0)

	if var_204_1 == nil then
		return false, nil, "invalidBody"
	end

	if self:IsBodyUnlocked(var_204_0) ~= true then
		return false, nil, "locked"
	end

	return true, var_0_0:CloneTable(var_0_0:BuildBuildSnapshot(var_0_0:NormalizeBuildDataForBody(var_204_1, var_0_0:getCurrentBuild()), var_0_0.outGameState_.selectedOptionId).costSummary), "ok"
end

function var_0_0:SetSelectedOption(arg_205_1, arg_205_2)
	local var_205_0 = tonumber(arg_205_1) or arg_205_1

	if (var_0_0:FindDefById(var_0_0:_GetWeaponDefs(), var_205_0) or var_0_0:FindDefById(var_0_0:_GetEquipDefs(), var_205_0)) ~= nil then
		var_0_0.outGameState_.selectedOptionId = var_205_0
		var_0_0.outGameState_.modifyInfoTarget = "option"
	end

	if not arg_205_2 then
		self:NotifyOutGameUpdated("option")
	end

	return var_0_0.outGameState_.selectedOptionId
end

function var_0_0:AssignOptionToSlot(arg_206_1, arg_206_2, arg_206_3)
	local var_206_0 = tonumber(arg_206_1) or arg_206_1
	local var_206_1 = var_0_0:FindDefById(var_0_0:_GetWeaponDefs(), var_206_0) or var_0_0:FindDefById(var_0_0:_GetEquipDefs(), var_206_0)
	local var_206_2 = tonumber(arg_206_2) or 1

	if var_206_1 ~= nil then
		local var_206_3 = var_0_0:getCurrentBuild() or {}
		local var_206_4 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), var_206_3.bodyId or var_0_0.outGameState_.selectedBodyId)

		var_206_4 = var_206_4 or var_0_0:GetDefaultBodyDef()

		if var_0_0:GetMountListBySlotType(var_0_0:BuildBodyMountLayout(var_206_4), var_206_1.typeText)[var_206_2] == nil then
			error("[SummerRaceData] invalid slot index " .. tostring(var_206_2) .. " for slot type " .. tostring(var_206_1.typeText))
		end

		var_0_0:GetBuildIdListBySlotType(var_206_3, var_206_1.typeText)[var_206_2] = var_206_0
		var_0_0.outGameState_.selectedOptionId = var_206_0
		var_0_0.outGameState_.modifyInfoTarget = "option"
		var_0_0.outGameState_.selectedModifySlotType = var_206_1.typeText
		var_0_0.outGameState_.selectedModifySlotIndex = var_206_2
	end

	if not arg_206_3 then
		self:NotifyOutGameUpdated("slotAssign")
	end
end

function var_0_0.GetProjectedAssignCostSummary(arg_207_0, arg_207_1, arg_207_2, arg_207_3)
	local var_207_0 = tonumber(arg_207_1) or arg_207_1
	local var_207_1 = var_0_0:FindDefById(var_0_0:_GetWeaponDefs(), var_207_0) or var_0_0:FindDefById(var_0_0:_GetEquipDefs(), var_207_0)
	local var_207_2

	if arg_207_2 == SummerRaceConst.FILTER.WEAPON then
		var_207_2 = SummerRaceConst.FILTER.WEAPON

		if not SummerRaceConst.FILTER.WEAPON then
			if arg_207_2 == SummerRaceConst.FILTER.EQUIP then
				var_207_2 = SummerRaceConst.FILTER.EQUIP or nil
			end
		end
	end

	local var_207_3 = tonumber(arg_207_3) or 0

	if var_207_1 == nil then
		return nil, "invalidOption"
	end

	if var_207_2 == nil then
		return nil, "invalidSlotType"
	end

	if var_207_1.typeText ~= var_207_2 then
		return nil, "slotTypeMismatch"
	end

	if var_207_3 <= 0 then
		return nil, "invalidSlotIndex"
	end

	local var_207_4 = var_0_0:getCurrentBuild() or {}
	local var_207_5 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), var_207_4.bodyId or var_0_0.outGameState_.selectedBodyId)

	var_207_5 = var_207_5 or var_0_0:GetDefaultBodyDef()

	if var_0_0:GetMountListBySlotType(var_0_0:BuildBodyMountLayout(var_207_5), var_207_2)[var_207_3] == nil then
		return nil, "invalidSlotIndex"
	end

	local var_207_6 = var_0_0:CloneTable(var_207_4)

	var_0_0:GetBuildIdListBySlotType(var_207_6, var_207_2)[var_207_3] = var_207_0

	return var_0_0:CloneTable(var_0_0:BuildBuildSnapshot(var_207_6, var_0_0.outGameState_.selectedOptionId).costSummary), "ok"
end

function var_0_0:ClearSlot(arg_208_1, arg_208_2, arg_208_3)
	local var_208_0 = tonumber(arg_208_2) or 1
	local var_208_1

	if arg_208_1 == SummerRaceConst.FILTER.WEAPON then
		var_208_1 = SummerRaceConst.FILTER.WEAPON

		if not SummerRaceConst.FILTER.WEAPON then
			if arg_208_1 == SummerRaceConst.FILTER.EQUIP then
				var_208_1 = SummerRaceConst.FILTER.EQUIP or nil
			end
		end
	end

	local var_208_2 = var_0_0:getCurrentBuild() or {}
	local var_208_3 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), var_208_2.bodyId or var_0_0.outGameState_.selectedBodyId)

	var_208_3 = var_208_3 or var_0_0:GetDefaultBodyDef()

	local var_208_4 = var_0_0:BuildBodyMountLayout(var_208_3)

	if var_208_1 == nil then
		error("[SummerRaceData] invalid slot type: " .. tostring(arg_208_1))
	end

	if var_0_0:GetMountListBySlotType(var_208_4, var_208_1)[var_208_0] == nil then
		error("[SummerRaceData] invalid slot index " .. tostring(var_208_0) .. " for slot type " .. tostring(var_208_1))
	end

	var_0_0:GetBuildIdListBySlotType(var_208_2, var_208_1)[var_208_0] = nil

	if not arg_208_3 then
		self:NotifyOutGameUpdated("slotClear")
	end
end

function var_0_0:SetSelectedIllustratedItem(arg_209_1, arg_209_2)
	local var_209_0 = tonumber(arg_209_1) or arg_209_1 or ""
	local var_209_1, var_209_2 = var_0_0:GetIllustratedDefById(var_209_0)

	var_0_0.outGameState_.selectedIllustratedItemId = var_209_0

	if var_209_2 ~= nil then
		var_0_0.outGameState_.illustratedFilterType = var_209_2
	end

	if not arg_209_2 then
		self:NotifyOutGameUpdated("illustratedItem")
	end
end

function var_0_0.GetSelectedOptionId(arg_210_0)
	return var_0_0.outGameState_.selectedOptionId
end

function var_0_0:SetPendingUnlockModel(arg_211_1, arg_211_2)
	if type(arg_211_1) == "table" then
		var_0_0.outGameState_.pendingUnlockModel = var_0_0:CloneTable(arg_211_1)
	end

	if not arg_211_2 then
		self:NotifyOutGameUpdated("unlock")
	end

	return var_0_0:CloneTable(var_0_0.outGameState_.pendingUnlockModel)
end

function var_0_0:SetPendingStageUnlockBannerModel(arg_212_1, arg_212_2)
	if type(arg_212_1) == "table" then
		var_0_0.outGameState_.pendingStageUnlockBannerQueue = var_0_0.outGameState_.pendingStageUnlockBannerQueue or {}
		var_0_0.outGameState_.pendingStageUnlockBannerQueue[#var_0_0.outGameState_.pendingStageUnlockBannerQueue + 1] = var_0_0:CloneTable(arg_212_1)
		var_0_0.outGameState_.pendingStageUnlockBannerModel = var_0_0:CloneTable(arg_212_1)
	end

	if not arg_212_2 then
		self:NotifyOutGameUpdated("stageUnlockBanner")
	end

	return var_0_0:CloneTable(var_0_0.outGameState_.pendingStageUnlockBannerModel)
end

function var_0_0:SetPendingStageItemUnlockAnimModel(arg_213_1, arg_213_2)
	if type(arg_213_1) == "table" then
		var_0_0.outGameState_.pendingStageItemUnlockAnimQueue = var_0_0.outGameState_.pendingStageItemUnlockAnimQueue or {}
		var_0_0.outGameState_.pendingStageItemUnlockAnimQueue[#var_0_0.outGameState_.pendingStageItemUnlockAnimQueue + 1] = var_0_0:CloneTable(arg_213_1)
		var_0_0.outGameState_.pendingStageItemUnlockAnimModel = var_0_0:CloneTable(arg_213_1)
	end

	if not arg_213_2 then
		self:NotifyOutGameUpdated("stageItemUnlockAnim")
	end

	return var_0_0:CloneTable(var_0_0.outGameState_.pendingStageItemUnlockAnimModel)
end

function var_0_0.ConsumePendingStageItemUnlockAnimModel(arg_214_0)
	local var_214_0

	if type(var_0_0.outGameState_.pendingStageItemUnlockAnimQueue) == "table" and #var_0_0.outGameState_.pendingStageItemUnlockAnimQueue > 0 then
		var_214_0 = table.remove(var_0_0.outGameState_.pendingStageItemUnlockAnimQueue, 1)
		var_0_0.outGameState_.pendingStageItemUnlockAnimModel = var_0_0.outGameState_.pendingStageItemUnlockAnimQueue[1] ~= nil and var_0_0:CloneTable(var_0_0.outGameState_.pendingStageItemUnlockAnimQueue[1]) or nil
	else
		var_214_0 = var_0_0:CloneTable(var_0_0.outGameState_.pendingStageItemUnlockAnimModel)
		var_0_0.outGameState_.pendingStageItemUnlockAnimModel = nil
	end

	if type(var_214_0) ~= "table" or var_214_0.stageId == nil then
		return nil
	end

	return var_214_0
end

function var_0_0.ConsumePendingStageItemUnlockAnimModelList(arg_215_0)
	local var_215_0 = {}

	if type(var_0_0.outGameState_.pendingStageItemUnlockAnimQueue) == "table" and #var_0_0.outGameState_.pendingStageItemUnlockAnimQueue > 0 then
		for iter_215_0 = 1, #var_0_0.outGameState_.pendingStageItemUnlockAnimQueue do
			if type(var_0_0.outGameState_.pendingStageItemUnlockAnimQueue[iter_215_0]) == "table" and var_0_0.outGameState_.pendingStageItemUnlockAnimQueue[iter_215_0].stageId ~= nil then
				var_215_0[#var_215_0 + 1] = var_0_0:CloneTable(var_0_0.outGameState_.pendingStageItemUnlockAnimQueue[iter_215_0])
			end
		end

		var_0_0.outGameState_.pendingStageItemUnlockAnimQueue = {}
		var_0_0.outGameState_.pendingStageItemUnlockAnimModel = nil

		return var_215_0
	end

	local var_215_1 = var_0_0:ConsumePendingStageItemUnlockAnimModel()

	if var_215_1 ~= nil then
		var_215_0[#var_215_0 + 1] = var_215_1
	end

	return var_215_0
end

function var_0_0.HasPendingStageItemUnlockAnim(arg_216_0, arg_216_1)
	local var_216_0 = tostring(arg_216_1)

	if var_0_0.outGameState_ then
		local var_216_1 = var_0_0.outGameState_.pendingStageItemUnlockAnimQueue or nil

		if type(var_216_1) == "table" then
			for iter_216_0 = 1, #var_216_1 do
				if tostring(var_216_1[iter_216_0] and var_216_1[iter_216_0].stageId) == var_216_0 then
					return true
				end
			end
		end

		local var_216_3

		if var_0_0.outGameState_ then
			var_216_3 = var_0_0.outGameState_.pendingStageItemUnlockAnimModel or nil
		end
	end

	return type(var_216_3) == "table" and tostring(var_216_3.stageId) == var_216_0
end

function var_0_0.HasPendingUnlockPop(arg_217_0)
	if var_0_0.outGameState_ then
		local var_217_0 = var_0_0.outGameState_.pendingUnlockModel or nil

		if type(var_217_0) == "table" and var_217_0.shouldOpenPop == true then
			return true
		end

		local var_217_1

		if var_0_0.outGameState_ then
			var_217_1 = var_0_0.outGameState_.pendingStageUnlockBannerModel or nil
		end
	end

	return type(var_217_1) == "table" and var_217_1.shouldOpenPop == true
end

function var_0_0.NotifyPendingStageItemUnlockAnim(arg_218_0)
	var_0_0:InvokeNotify(var_0_0.GetEventStageItemUnlockAnim())
end

function var_0_0.IsStageCompleted(arg_219_0, arg_219_1)
	local var_219_0 = var_0_0:FindRuntimeStageInfoById(arg_219_1)

	return var_219_0 ~= nil and var_219_0.isCompleted == true
end

function var_0_0.GetStageStartStoryId(arg_220_0, arg_220_1)
	local var_220_0 = var_0_0:FindStageInfoById(arg_220_1)

	return tonumber(var_220_0 and var_220_0.startStoryId) or 0
end

function var_0_0.GetStageEndStoryId(arg_221_0, arg_221_1)
	local var_221_0 = var_0_0:FindStageInfoById(arg_221_1)

	return tonumber(var_221_0 and var_221_0.endStoryId) or 0
end

function var_0_0.IsPlotStage(arg_222_0, arg_222_1)
	local var_222_0 = var_0_0:FindStageInfoById(arg_222_1)

	return tonumber(var_222_0 and var_222_0.modeType) == 5
end

function var_0_0:GetFirstPlotStageIdIfIncomplete()
	local var_223_0 = var_0_0:GetStageDefs()

	for iter_223_0 = 1, #var_223_0 do
		if tonumber(var_223_0[iter_223_0] and var_223_0[iter_223_0].modeType) == 5 then
			if self:IsStageCompleted(var_223_0[iter_223_0].stageId) ~= true then
				return var_223_0[iter_223_0].stageId
			end

			return nil
		end
	end

	return nil
end

function var_0_0:ApplyServerOutGameSnapshot(arg_224_1, arg_224_2)
	var_0_0:RequireTable(arg_224_1, "server summerrace snapshot")

	local var_224_0 = tonumber(arg_224_1.activity_id) or arg_224_1.activity_id

	if var_224_0 ~= nil and var_224_0 ~= 0 and var_224_0 ~= SummerRaceConst.ACTIVITY_ID.MAIN then
		error("[SummerRaceData] unexpected server activity_id: " .. tostring(var_224_0))
	end

	if arg_224_1.mission_list ~= nil then
		var_0_0:ApplyMissionProgressToStageMap((var_0_0:BuildMissionSet(var_0_0:RequireArray(arg_224_1.mission_list, "server mission_list"))))
	end

	if arg_224_1.tank_info ~= nil then
		var_0_0.outGameState_.selectedBodyId = arg_224_1.tank_id
		var_0_0.outGameState_.currentBuild = arg_224_1.tank_id
		var_0_0.outGameState_.buildTankList = var_0_0:NormalizeServerTankBuildList(arg_224_1.tank_info)
		var_0_0.outGameState_.modifyInfoTarget = "body"
		var_0_0.outGameState_.selectedOptionId = ""
		var_0_0.outGameState_.selectedModifySlotType = ""
		var_0_0.outGameState_.selectedModifySlotIndex = 0
	end

	if arg_224_1.challenge_stage_info ~= nil then
		var_0_0:RequireTable(arg_224_1.challenge_stage_info, "server challenge_stage_info")

		var_0_0.outGameState_.challengeRound = math.max(0, tonumber(arg_224_1.challenge_stage_info.round) or 0)
		var_0_0.outGameState_.challengeBestScore = var_0_0:NormalizeChallengeBestScore(arg_224_1.challenge_stage_info.max_score)
	end

	var_0_0.outGameState_.currentStageId = var_0_0:ResolveStageIdForTab(var_0_0.outGameState_.tournamentTab, var_0_0.outGameState_.currentStageId)

	if not arg_224_2 then
		self:NotifyOutGameUpdated("serverSync")
	end
end

function var_0_0:MarkStageCompletedFromServer(arg_225_1, arg_225_2)
	local var_225_0 = tonumber(arg_225_1) or arg_225_1

	if var_225_0 == nil or var_225_0 == "" or var_225_0 == 0 then
		return
	end

	local var_225_1 = var_0_0:BuildBannerUnlockedStageSet()
	local var_225_2 = self:GetChallengeUnlockState().isUnlocked == true
	local var_225_3 = var_0_0:GetTournamentStageMap()
	local var_225_4 = false

	for iter_225_0, iter_225_1 in pairs(var_225_3) do
		for iter_225_2 = 1, #iter_225_1 do
			if iter_225_1[iter_225_2].stageId == var_225_0 then
				iter_225_1[iter_225_2].isCompleted = true
				var_225_4 = true

				break
			end
		end
	end

	var_0_0:RecalculateTournamentStageUnlockState(var_225_3)

	if var_225_4 then
		local var_225_5 = self:GetChallengeUnlockState().isUnlocked == true
		local var_225_6 = var_0_0:BuildBannerUnlockedStageSet()
		local var_225_7 = var_0_0:GetNewUnlockedStageItemAnimModelList(var_225_1, var_225_6)

		for iter_225_3 = 1, #var_225_7 do
			self:SetPendingStageItemUnlockAnimModel(var_225_7[iter_225_3], true)
		end

		if var_225_2 ~= true and var_225_5 == true then
			self:SetPendingStageUnlockBannerModel(var_0_0:BuildPendingStageUnlockBannerModel(SummerRaceConst.SOURCE_TYPE.CHALLENGE), true)
		end

		local var_225_8 = var_0_0:GetNewUnlockedPracticeStageInfo(var_225_1, var_225_6)

		if var_225_8 ~= nil then
			self:SetPendingStageUnlockBannerModel(var_0_0:BuildPendingStageUnlockBannerModel(SummerRaceConst.SOURCE_TYPE.REWARD, var_225_8), true)
		end
	end

	if var_225_4 and not arg_225_2 then
		self:NotifyOutGameUpdated("serverStageComplete")
	end
end

function var_0_0:UpdateChallengeRecord(arg_226_1, arg_226_2, arg_226_3)
	local var_226_0 = tonumber(arg_226_1) or 0
	local var_226_1 = var_0_0:NormalizeChallengeBestScore(arg_226_2)
	local var_226_2 = var_0_0:NormalizeChallengeBestScore(var_0_0.outGameState_.challengeBestScore)

	var_0_0.outGameState_.challengeRound = math.max(tonumber(var_0_0.outGameState_.challengeRound) or 0, (math.max(0, var_226_0)))
	var_0_0.outGameState_.challengeBestScore = var_226_1 >= 0 and math.max(var_226_2, var_226_1) or var_226_2

	if not arg_226_3 then
		self:NotifyOutGameUpdated("serverChallengeRecord")
	end
end

function var_0_0:BuildServerModifyPayload()
	local var_227_0 = self:BuildCurrentBuildSnapshot().buildData or {}
	local var_227_1 = tonumber(var_227_0.bodyId) or var_227_0.bodyId or var_0_0.outGameState_.selectedBodyId

	if var_227_1 == nil or var_227_1 == 0 or var_227_1 == "" then
		error("[SummerRaceData] BuildServerModifyPayload requires valid bodyId")
	end

	return {
		activity_id = SummerRaceConst.ACTIVITY_ID.MAIN,
		tank_id = var_227_1,
		weapon_list = var_0_0:BuildServerWeaponListFromBuildData(var_227_0)
	}
end

function var_0_0.BuildCurrentBuildSnapshot(arg_228_0)
	return var_0_0:BuildBuildSnapshot(var_0_0:getCurrentBuild(), var_0_0.outGameState_.selectedOptionId)
end

function var_0_0:GetCurrentBuildCostSummary()
	return var_0_0:CloneTable(self:BuildCurrentBuildSnapshot().costSummary)
end

function var_0_0.GetBattleInfoPopModel(arg_230_0, arg_230_1)
	if type(arg_230_1) == "table" and arg_230_1.source == "rankDetail" then
		return var_0_0.BuildRankBattleInfoPopModel(arg_230_0, arg_230_1)
	end

	if type(arg_230_1) == "table" and arg_230_1.source == "stageDetail" then
		return var_0_0.BuildStageWaveBattleInfoPopModel(arg_230_0, arg_230_1)
	end

	return var_0_0.BuildRuntimeBattleInfoPopModel(arg_230_0, arg_230_1)
end

function var_0_0.GetChallengeUnlockState(arg_231_0)
	local var_231_0 = var_0_0:GetTournamentStageMap()
	local var_231_1

	if var_231_0 then
		var_231_1 = var_231_0[SummerRaceConst.TOURNAMENT_TAB.NORMAL] or {}
	end

	local var_231_2 = #var_231_1 > 0

	for iter_231_0 = 1, #var_231_1 do
		if var_231_1[iter_231_0].isCompleted ~= true then
			var_231_2 = false

			break
		end
	end

	if not var_231_2 then
		return {
			isUnlocked = false,
			lockReason = "clear_all_tournament_normal",
			tipText = var_0_0:ResolveTipsText("ACTIVITY_TANK_CHALLAGE_LOCK")
		}
	end

	return {
		tipText = "",
		isUnlocked = true,
		lockReason = ""
	}
end

function var_0_0.GetChallengeUnlockAnimSaveKey(arg_232_0)
	return "challengeUnlockAnimPlayed_" .. tostring(SummerRaceConst.ACTIVITY_ID.MAIN)
end

function var_0_0.HasChallengeRecord(arg_233_0)
	return var_0_0:NormalizeChallengeBestScore(var_0_0.outGameState_ and var_0_0.outGameState_.challengeBestScore) >= 0
end

function var_0_0:HasPlayedChallengeUnlockAnim()
	return getData("SummerRace", self:GetChallengeUnlockAnimSaveKey()) == true
end

function var_0_0:MarkChallengeUnlockAnimPlayed()
	saveData("SummerRace", self:GetChallengeUnlockAnimSaveKey(), true)
end

function var_0_0:ShouldPlayChallengeUnlockAnim()
	return self:GetChallengeUnlockState().isUnlocked and not self:HasChallengeRecord() and not self:HasPlayedChallengeUnlockAnim()
end

function var_0_0.GetBodyMountLayout(arg_237_0, arg_237_1)
	local var_237_0 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), tonumber(arg_237_1) or arg_237_1 or var_0_0.outGameState_.selectedBodyId) or var_0_0:GetDefaultBodyDef()

	if var_237_0 == nil then
		return {
			chassisPrefabPath = "",
			bodyId = 0,
			wheels = {},
			weaponMounts = {},
			equipMounts = {},
			mountPoints = {}
		}
	end

	return var_0_0:CloneTable(var_0_0:BuildBodyMountLayout(var_237_0))
end

function var_0_0.BuildWeaponRuntimeOverridePayload(arg_238_0, arg_238_1)
	if type(arg_238_1) ~= "table" then
		error("[SummerRaceData] weapon runtime override requires weaponDef table")
	end

	local var_238_0 = var_0_0:ResolveOptionRuntimeKey(arg_238_1)

	if var_238_0 == "" then
		error("[SummerRaceData] weapon runtime override missing runtimeKey, itemId=" .. tostring(arg_238_1.itemId))
	end

	local var_238_1 = tonumber(arg_238_1.damage)

	if var_238_1 == nil then
		error("[SummerRaceData] weapon runtime override missing damage, itemId=" .. tostring(arg_238_1.itemId))
	end

	local var_238_2 = tonumber(arg_238_1.rof)

	if var_238_2 == nil then
		error("[SummerRaceData] weapon runtime override missing rof, itemId=" .. tostring(arg_238_1.itemId))
	end

	if var_238_2 <= 0 then
		error("[SummerRaceData] weapon runtime override invalid rof <= 0, itemId=" .. tostring(arg_238_1.itemId))
	end

	local var_238_3 = {
		weaponKey = var_238_0
	}

	var_238_3.cost = tonumber(arg_238_1.cost) or 0
	var_238_3.energyCost = tonumber(arg_238_1.energyCost) or 0
	var_238_3.damage = var_238_1
	var_238_3.rof = var_238_2
	var_238_3.hasBurnOverride = tonumber(arg_238_1.effectType) == 2

	local var_238_4 = tonumber((arg_238_1.effectParams or {})[1])

	var_238_4 = var_238_4 or 0
	var_238_3.burnDps = var_238_4

	local var_238_5 = tonumber((arg_238_1.effectParams or {})[2])

	var_238_5 = var_238_5 or 0
	var_238_3.burnDuration = var_238_5
	var_238_3.effectParams = var_0_0:CloneTable(arg_238_1.effectParams or {})

	return var_238_3
end

function var_0_0.BuildEquipRuntimeOverridePayload(arg_239_0, arg_239_1)
	if type(arg_239_1) ~= "table" then
		error("[SummerRaceData] equip runtime override requires equipDef table")
	end

	local var_239_0 = var_0_0:ResolveOptionRuntimeKey(arg_239_1)

	if var_239_0 == "" then
		error("[SummerRaceData] equip runtime override missing runtimeKey, itemId=" .. tostring(arg_239_1.itemId))
	end

	local var_239_1 = {
		equipKey = var_239_0
	}

	var_239_1.cost = tonumber(arg_239_1.cost) or 0
	var_239_1.energyCost = tonumber(arg_239_1.energyCost) or 0

	return var_239_1
end

function var_0_0:BuildBattleLaunchPayload(arg_240_1)
	local var_240_0 = type(arg_240_1) == "table" and var_0_0:CloneTable(arg_240_1) or {}
	local var_240_1 = tostring(var_240_0.source or "stageDetail")
	local var_240_2 = 0

	if var_240_0.startWaveIndex ~= nil then
		var_240_2 = math.floor(tonumber(var_240_0.startWaveIndex) or error("[SummerRaceData] startWaveIndex must be a number"))

		if var_240_2 < 0 then
			error("[SummerRaceData] startWaveIndex must be greater than or equal to 0")
		end
	end

	local var_240_3 = var_240_0.mode and self:NormalizeMode(var_240_0.mode) or nil
	local var_240_4
	local var_240_6 = {}

	if var_240_0.stageId ~= nil and var_240_0.stageId ~= "" and var_240_0.stageId ~= 0 then
		var_240_4 = var_0_0:FindStageInfoById(var_240_0.stageId)
	end

	if var_240_4 == nil and var_240_3 ~= nil then
		var_240_4 = var_0_0:GetDefaultStageDefByModeKey(var_240_3)
	end

	if var_240_4 == nil then
		var_240_4 = var_0_0:FindStageInfoById(var_0_0.outGameState_.currentStageId) or var_0_0:GetDefaultStageDef()
	end

	if var_240_4 == nil then
		error("[SummerRaceData] battle launch requires a valid stage selection")
	end

	local var_240_8 = var_240_4.stageId
	local var_240_9 = var_0_0:ResolveModeKeyFromStageModeType(var_240_4.modeType)

	if var_240_3 ~= nil and var_240_3 ~= var_240_9 then
		error("[SummerRaceData] battle launch mode/stage mismatch: mode=" .. tostring(var_240_3) .. " stageMode=" .. tostring(var_240_9))
	end

	local var_240_10 = var_0_0:BuildActivityConfigPayload(var_240_4, var_240_9, var_240_8)

	if var_240_9 == SummerRaceConst.MODE.CHAMPIONSHIP then
		var_240_6 = var_0_0:CloneTable(var_240_4.enemyIds or {})
	end

	if var_240_9 ~= SummerRaceConst.MODE.CHALLENGE then
		var_0_0.outGameState_.currentStageId = var_240_8
	end

	local var_240_12 = self:BuildCurrentBuildSnapshot()
	local var_240_14 = var_0_0:FindDefById(var_0_0:_GetBodyDefs(), (not (var_240_12.buildData or {}).bodyId or nil) and var_240_12.bodyId)
	local var_240_15 = var_0_0:_GetWeaponDefs()
	local var_240_16 = var_0_0:_GetEquipDefs()
	local var_240_17 = {}
	local var_240_18 = {}
	local var_240_19 = {}
	local var_240_20 = {}
	local var_240_21 = {}
	local var_240_22 = {}
	local var_240_23 = {}

	for iter_240_0 = 1, #(var_240_12.slotSummary or {}) do
		local var_240_24 = var_240_12.slotSummary[iter_240_0]
		local var_240_25

		if var_240_12.slotSummary[iter_240_0] then
			var_240_25 = var_240_24.itemId or nil
		end

		local var_240_26 = var_240_24 and tonumber(var_240_24.configSlotIndex) or nil

		if var_240_25 ~= nil and var_240_25 ~= "" and var_240_26 ~= nil then
			if var_240_24.slotType == SummerRaceConst.FILTER.WEAPON then
				local var_240_27 = var_0_0:FindDefById(var_240_15, var_240_25)
				local var_240_28 = var_0_0:ResolveOptionRuntimeKey(var_240_27)

				if var_240_28 ~= "" then
					var_240_17[#var_240_17 + 1] = var_240_28
					var_240_18[#var_240_18 + 1] = var_0_0:BuildWeaponRuntimeOverridePayload(var_240_27)
					var_240_19[#var_240_19 + 1] = var_240_26
				end
			elseif var_240_24.slotType == SummerRaceConst.FILTER.EQUIP then
				local var_240_29 = var_0_0:FindDefById(var_240_16, var_240_25)
				local var_240_30 = var_0_0:ResolveOptionRuntimeKey(var_240_29)

				if var_240_30 ~= "" then
					var_240_20[#var_240_20 + 1] = var_240_30
					var_240_21[#var_240_21 + 1] = var_0_0:BuildEquipRuntimeOverridePayload(var_240_29)
					var_240_22[#var_240_22 + 1] = var_240_26
				end
			end
		end
	end

	if var_240_14 ~= nil then
		var_0_0:SetNumericFieldIfPresent(var_240_23, "hp", var_240_14.hp)
		var_0_0:SetNumericFieldIfPresent(var_240_23, "baseHp", var_240_14.hp)
		var_0_0:SetNumericFieldIfPresent(var_240_23, "cost", var_240_14.costCap or var_240_14.cost)
		var_0_0:SetNumericFieldIfPresent(var_240_23, "costCap", var_240_14.costCap or var_240_14.cost)
		var_0_0:SetNumericFieldIfPresent(var_240_23, "speed", var_240_14.speed)
		var_0_0:SetNumericFieldIfPresent(var_240_23, "moveSpeed", var_240_14.speed)
		var_0_0:SetNumericFieldIfPresent(var_240_23, "forwardAcceleration", var_240_14.forwardAcceleration)
	end

	return {
		mode = var_240_9,
		stageId = tostring(var_240_8),
		activityId = tostring(SummerRaceConst.ACTIVITY_ID.MAIN),
		source = var_240_1,
		startWaveIndex = var_240_2,
		playerConfig = {
			bodyKey = var_0_0:ResolveBodyRuntimeKey(var_240_14),
			weaponKeys = var_240_17,
			weaponOverrides = var_240_18,
			weaponSlotIndices = var_240_19,
			equipKeys = var_240_20,
			equipOverrides = var_240_21,
			equipSlotIndices = var_240_22,
			bodyOverrides = var_240_23
		},
		enemyConfig = {
			enemyIds = var_240_6
		},
		activityConfig = var_240_10
	}
end

function var_0_0:BuildStageBattleLaunchPayload(arg_241_1, arg_241_2)
	return self:BuildBattleLaunchPayload({
		stageId = arg_241_1,
		source = arg_241_2 or "stageDetail"
	})
end

function var_0_0:BuildChallengeBattleLaunchPayload(arg_242_1, arg_242_2)
	return self:BuildBattleLaunchPayload({
		stageId = arg_242_2 or self:GetCurrentStageIdByMode(SummerRaceConst.MODE.CHALLENGE),
		mode = SummerRaceConst.MODE.CHALLENGE,
		source = arg_242_1 or "challenge"
	})
end

function var_0_0.ResolveSettlementRetryStartWaveIndex(arg_243_0, arg_243_1)
	if arg_243_1.isWin == true or arg_243_1.mode == SummerRaceConst.MODE.CHALLENGE then
		return 0
	end

	local var_243_0

	for iter_243_0 = 1, #arg_243_1.roundRecords do
		if type(arg_243_1.roundRecords[iter_243_0]) == "table" then
			if tostring(arg_243_1.roundRecords[iter_243_0].result or "") == "lose" then
				local var_243_2 = math.floor(tonumber(arg_243_1.roundRecords[iter_243_0].round) or 0)

				if var_243_2 <= 0 then
					error("[SummerRaceData] settlement retry failed round must be greater than 0")
				end

				var_243_0 = math.max(var_243_0 or 0, var_243_2)
			end
		end
	end

	if var_243_0 ~= nil and var_243_0 > 0 then
		return var_243_0
	end

	error("[SummerRaceData] settlement retry requires a failed round record")
end

function var_0_0:BuildSettlementRetryLaunchPayload(arg_244_1)
	local var_244_0 = self:GetSettlementState()
	local var_244_1

	if var_244_0 == nil then
		error("[SummerRaceData] settlement retry requires settlement state")

		var_244_1 = {
			stageId = var_244_0.stageId,
			mode = var_244_0.mode,
			source = arg_244_1 or "settlementRetry"
		}
	end

	var_244_1.startWaveIndex = var_0_0:ResolveSettlementRetryStartWaveIndex(var_244_0)

	return self:BuildBattleLaunchPayload(var_244_1)
end

function var_0_0:GetMainPageModel()
	local var_245_0 = self:BuildCurrentBuildSnapshot()
	local var_245_1 = self:GetChallengeUnlockState()

	self:RefreshFrameworkRedPoints()

	local var_245_2 = manager and manager.redPoint and manager.redPoint.getTipBoolean and manager.redPoint:getTipBoolean(var_0_0:BuildLimitTaskRedPointKey()) or false
	local var_245_3 = manager and manager.redPoint and manager.redPoint.getTipBoolean and manager.redPoint:getTipBoolean(var_0_0:BuildChampionshipRedPointKey()) or false
	local var_245_4 = manager and manager.redPoint and manager.redPoint.getTipBoolean and manager.redPoint:getTipBoolean(var_0_0:BuildChallengeRedPointKey()) or false
	local var_245_5 = manager and manager.redPoint and manager.redPoint.getTipBoolean and manager.redPoint:getTipBoolean(var_0_0:BuildNormalTaskRedPointKey()) or false

	return {
		currentBuild = var_245_0,
		vehicleDisplay = var_0_0:BuildVehicleDisplayModelFromSnapshot(var_245_0),
		challengeUnlocked = var_245_1.isUnlocked == true,
		challengeEntry = var_245_1,
		rewardEntry = {
			limited = {
				activityId = self:GetRewardRootActivityId(),
				pageType = SummerRaceConst.REWARD_PAGE.LIMITED,
				subType = select(2, self:ResolveRewardEntryPage(SummerRaceConst.REWARD_PAGE.LIMITED)),
				redPointKey = var_0_0:BuildLimitTaskRedPointKey()
			},
			resident = var_0_0:BuildResidentRewardEntryModel()
		},
		entryStates = {
			reward = true,
			modify = true,
			tournament = true,
			illustrated = true,
			challenge = var_245_1.isUnlocked == true
		},
		redPoints = {
			limitTask = var_245_2,
			championship = var_245_3,
			challenge = var_245_4,
			normalTask = var_245_5,
			reward = var_245_2 or var_245_5,
			tournament = var_245_3
		}
	}
end

function var_0_0.GetTournamentPageModel(arg_246_0)
	local var_246_0 = var_0_0:GetTournamentStageMap()
	local var_246_1 = var_0_0.outGameState_.tournamentTab
	local var_246_2 = var_0_0:ResolveStageIdForTab(var_0_0.outGameState_.tournamentTab, var_0_0.outGameState_.currentStageId)

	var_0_0.outGameState_.currentStageId = var_246_2

	local var_246_3 = {}

	for iter_246_0, iter_246_1 in ipairs({
		SummerRaceConst.TOURNAMENT_TAB.NORMAL,
		SummerRaceConst.TOURNAMENT_TAB.SURVIVAL,
		SummerRaceConst.TOURNAMENT_TAB.DUEL
	}) do
		local var_246_4 = var_246_0[iter_246_1] or {}

		for iter_246_2 = 1, #var_246_4 do
			local var_246_5 = var_0_0:CloneTable(var_246_4[iter_246_2])

			var_246_5.tabType = iter_246_1
			var_246_5.isSelected = var_246_5.stageId == var_246_2
			var_246_5.nodeType = var_246_5.nodeType or var_246_5.modeType == 1 and "main" or var_246_5.modeType == 5 and "plot" or "practice"
			var_246_3[#var_246_3 + 1] = var_246_5
		end
	end

	return {
		tabs = {
			{
				title = "Normal",
				tabType = SummerRaceConst.TOURNAMENT_TAB.NORMAL,
				isSelected = var_246_1 == SummerRaceConst.TOURNAMENT_TAB.NORMAL
			},
			{
				title = "Survival",
				tabType = SummerRaceConst.TOURNAMENT_TAB.SURVIVAL,
				isSelected = var_246_1 == SummerRaceConst.TOURNAMENT_TAB.SURVIVAL
			},
			{
				title = "Duel",
				tabType = SummerRaceConst.TOURNAMENT_TAB.DUEL,
				isSelected = var_246_1 == SummerRaceConst.TOURNAMENT_TAB.DUEL
			}
		},
		selectedTab = var_246_1,
		stageNodes = var_246_3
	}
end

function var_0_0:GetStageDetailModel(arg_247_1)
	local var_247_0 = var_0_0:GetTournamentStageMap()
	local var_247_1 = var_0_0:GetEnemyDefs()
	local var_247_2 = var_0_0.outGameState_.tournamentTab
	local var_247_3 = tonumber(arg_247_1) or arg_247_1

	if var_247_3 == nil or var_247_3 == "" or var_247_3 == 0 then
		var_247_3 = var_0_0:ResolveStageIdForTab(var_247_2, var_0_0.outGameState_.currentStageId)
	end

	local var_247_4 = var_0_0:FindStageInfoById(var_247_3)
	local var_247_5 = var_0_0:FindRuntimeStageInfoById(var_247_3)

	if var_247_4 == nil then
		local var_247_6 = var_0_0:GetDefaultStageDefByTab(var_247_2)

		var_247_4 = var_247_6 and var_0_0:CloneTable(var_247_6) or {
			stageId = 0,
			isUnlocked = false,
			stageIndex = "",
			desc = "",
			stageName = "",
			modeState = "main",
			isCompleted = false,
			enemyIds = {},
			firstReward = {},
			rewardList = {},
			repetitionReward = {}
		}
	end

	if var_247_5 ~= nil then
		var_247_4.isUnlocked = var_247_5.isUnlocked
		var_247_4.isCompleted = var_247_5.isCompleted
	end

	var_0_0.outGameState_.currentStageId = var_247_4.stageId

	local var_247_7 = var_0_0:BuildStageRewardList(var_247_4, var_0_0.outGameState_.rewardStateMap)
	local var_247_8 = var_0_0:BuildEnemyWaveDisplayList(var_247_4, var_247_1)
	local var_247_9 = self:BuildCurrentBuildSnapshot()
	local var_247_10 = {}
	local var_247_11 = {
		stageId = var_247_4.stageId,
		stageIndex = var_247_4.stageIndex,
		stageName = var_247_4.stageName,
		stageDesc = var_247_4.desc
	}

	var_247_11.modeState = var_247_4.modeState or var_0_0:ResolveStageModeState(var_247_4.modeType)
	var_247_11.modeType = var_247_4.modeType
	var_247_11.isUnlocked = var_247_4.isUnlocked
	var_247_11.isCompleted = var_247_4.isCompleted
	var_247_11.canStartBattle = tonumber(var_247_4.modeType) ~= 5
	var_247_10.stageInfo = var_247_11
	var_247_10.vehicleSnapshot = var_247_9
	var_247_10.vehicleDisplay = var_0_0:BuildVehicleDisplayModelFromSnapshot(var_247_9)
	var_247_10.enemyWaves = var_247_8
	var_247_10.rewardList = var_247_7
	var_247_10.slotSummary = var_247_9.slotSummary

	return var_247_10
end

function var_0_0:GetChallengePageModel()
	local var_248_0 = self:GetSettlementState()
	local var_248_1 = var_0_0:NormalizeChallengeBestScore(var_0_0.outGameState_.challengeBestScore)
	local var_248_2 = math.max(0, tonumber(var_0_0.outGameState_.challengeRound) or 0)
	local var_248_3 = self:BuildCurrentBuildSnapshot()
	local var_248_4 = var_0_0:FindChallengeStageInfo()
	local var_248_5 = {}
	local var_248_6 = {}

	if var_248_0 ~= nil and var_248_0.mode == SummerRaceConst.MODE.CHALLENGE then
		var_248_1 = math.max(var_248_1, math.max(0, tonumber(var_248_0.score) or 0))

		local var_248_7 = var_0_0:ResolveCompletedRoundFromRecords(var_248_0.roundRecords)

		if var_248_7 <= 0 then
			var_248_7 = var_0_0:ResolveCompletedRoundFromRecords(var_248_0.challengeRoundRecords)
		end

		if var_248_7 <= 0 and var_248_0.isWin == true then
			var_248_7 = math.max(0, tonumber(var_248_0.challengeReachedWave) or 0)
		end

		var_248_2 = math.max(var_248_2, var_248_7)
	end

	if var_248_4 ~= nil then
		var_248_5 = var_0_0:BuildStageRewardList(var_248_4, var_0_0.outGameState_.rewardStateMap)

		if #var_248_5 == 0 then
			var_248_5 = var_0_0:BuildChallengeRewardList(var_0_0.outGameState_.rewardStateMap)
		end

		var_248_6 = var_0_0:BuildEnemyWaveDisplayList(var_248_4, (var_0_0:GetEnemyDefs()))
	end

	local var_248_8 = {}

	var_248_8.stageInfo = var_248_4 ~= nil and {
		modeState = "challenge",
		stageId = var_248_4.stageId,
		stageIndex = var_248_4.stageIndex,
		stageName = var_248_4.stageName,
		stageDesc = var_248_4.desc,
		modeType = var_248_4.modeType,
		isUnlocked = var_248_4.isUnlocked,
		isCompleted = var_248_4.isCompleted
	} or nil
	var_248_8.bestScore = var_248_1
	var_248_8.bestWave = var_248_2
	var_248_8.hasChallengeRecord = var_248_1 >= 0
	var_248_8.ruleText = var_0_0:BuildChallengeRuleText(var_248_4)
	var_248_8.currentBuild = var_248_3
	var_248_8.vehicleDisplay = var_0_0:BuildVehicleDisplayModelFromSnapshot(var_248_3)
	var_248_8.enemyWaves = var_248_6
	var_248_8.rewardList = var_248_5

	return var_248_8
end

function var_0_0:GetModifyPageModel(arg_249_1)
	local var_249_0 = var_0_0:_GetBodyDefs()
	local var_249_1 = var_0_0:_GetWeaponDefs()
	local var_249_2 = var_0_0:_GetEquipDefs()
	local var_249_3 = self:BuildCurrentBuildSnapshot()

	if arg_249_1 ~= nil then
		self:SetModifyFilter(arg_249_1, true)
	end

	local var_249_4 = self:GetSelectedModifySlot()
	local var_249_5 = var_0_0:ResolveModifyDisplayFilter(var_0_0.outGameState_)
	local var_249_6 = var_0_0.outGameState_.selectedBodyId
	local var_249_7 = var_0_0:FindDefById(var_249_0, var_0_0.outGameState_.selectedBodyId) or var_249_0[1] or {
		cost = 0,
		bodyName = "",
		hp = 0,
		desc = "",
		isRecommended = false,
		isUnlocked = false,
		bodyId = 0
	}
	local var_249_8 = {}

	for iter_249_0 = 1, #var_249_0 do
		local var_249_9 = var_249_0[iter_249_0]
		local var_249_10 = self:IsBodyUnlocked(var_249_0[iter_249_0].bodyId)
		local var_249_11 = #var_249_8 + 1
		local var_249_12 = {
			bodyId = var_249_0[iter_249_0].bodyId,
			bodyName = var_249_0[iter_249_0].bodyName
		}

		var_249_12.iconPath = tostring(var_249_0[iter_249_0].icon or "")
		var_249_12.hp = var_249_9.hp
		var_249_12.cost = var_249_9.cost
		var_249_12.isUnlocked = var_249_10
		var_249_12.isSelected = var_249_9.bodyId == var_249_6
		var_249_12.isRecommended = var_249_9.isRecommended
		var_249_12.redPointKey = self:BuildBodyNewRedPointKey(var_249_9.bodyId)
		var_249_12.isNewRedPoint = var_249_10 == true and var_249_9.isDefaultUnlocked ~= true and self:IsBodyNewRedPointRead(var_249_9.bodyId) ~= true
		var_249_8[var_249_11] = var_249_12
	end

	local var_249_13 = {}
	local var_249_14 = var_249_5 ~= SummerRaceConst.FILTER.EQUIP
	local var_249_15 = var_249_5 ~= SummerRaceConst.FILTER.WEAPON
	local var_249_16 = var_249_3.buildData
	local var_249_17 = tonumber(var_249_3.totalCost) or 0
	local var_249_18 = tonumber((var_249_3.costSummary or {}).budgetCost)

	if not var_249_18 then
		var_249_18 = tonumber(var_249_7.cost)
		var_249_18 = var_249_18 or SummerRaceConst.BUILD.BUDGET_COST
	end

	local var_249_19 = var_249_4 and var_0_0:FindSlotData(var_249_3.slotSummary, var_249_4.slotType, var_249_4.slotIndex) or nil
	local var_249_20 = var_0_0.outGameState_.selectedOptionId or ""
	local var_249_21 = var_0_0:FindDefById(var_249_1, var_249_20) or var_0_0:FindDefById(var_249_2, var_249_20)
	local var_249_22 = var_0_0.outGameState_.modifyInfoTarget or var_249_21 ~= nil and "option" or "body"

	if var_249_14 then
		for iter_249_1 = 1, #var_249_1 do
			local var_249_23 = var_249_1[iter_249_1]
			local var_249_24 = self:IsOptionUnlocked(var_249_1[iter_249_1].itemId)

			if var_249_24 == true then
				local var_249_25 = "white"
				local var_249_26 = table.indexof(var_249_16.weaponIds, var_249_23.itemId) ~= false

				if var_249_4 ~= nil and var_249_4.slotType == var_249_23.typeText then
					local var_249_27 = self:GetProjectedAssignCostSummary(var_249_23.itemId, var_249_4.slotType, var_249_4.slotIndex)

					if var_249_27 ~= nil and var_249_27.isOverflow == true then
						var_249_25 = "red"
					end
				else
					local var_249_28

					if not var_249_26 or not var_249_17 then
						::label_249_0::

						var_249_28 = var_249_17 + (tonumber(var_249_23.cost) or 0)
					end

					if var_249_18 < var_249_28 then
						var_249_25 = "red"
					end
				end

				local var_249_29 = #var_249_13 + 1
				local var_249_30 = {
					itemId = var_249_23.itemId,
					itemName = var_249_23.itemName
				}

				var_249_30.iconPath = tostring(var_249_23.icon or "")
				var_249_30.skeletonDataPath = tostring(var_249_23.skeletonDataPath or "")
				var_249_30.moduleSize = var_0_0:CloneTable(var_249_23.moduleSize)
				var_249_30.moduleScale = tonumber(var_249_23.moduleScale) or 1
				var_249_30.cost = var_249_23.cost
				var_249_30.costState = var_249_25
				var_249_30.typeText = var_249_23.typeText
				var_249_30.isUnlocked = var_249_24
				var_249_30.isSelected = var_249_23.itemId == var_249_20
				var_249_30.isEquipped = var_249_26
				var_249_30.redPointKey = self:BuildOptionNewRedPointKey(var_249_23.itemId)
				var_249_30.isNewRedPoint = var_249_23.isDefaultUnlocked ~= true and self:IsOptionNewRedPointRead(var_249_23.itemId) ~= true
				var_249_13[var_249_29] = var_249_30
			end
		end
	end

	if var_249_15 then
		for iter_249_2 = 1, #var_249_2 do
			local var_249_31 = var_249_2[iter_249_2]
			local var_249_32 = self:IsOptionUnlocked(var_249_2[iter_249_2].itemId)

			if var_249_32 == true then
				local var_249_33 = "white"
				local var_249_34 = table.indexof(var_249_16.equipIds, var_249_31.itemId) ~= false

				if var_249_4 ~= nil and var_249_4.slotType == var_249_31.typeText then
					local var_249_35 = self:GetProjectedAssignCostSummary(var_249_31.itemId, var_249_4.slotType, var_249_4.slotIndex)

					if var_249_35 ~= nil and var_249_35.isOverflow == true then
						var_249_33 = "red"
					end
				else
					local var_249_36

					if not var_249_34 or not var_249_17 then
						::label_249_1::

						var_249_36 = var_249_17 + (tonumber(var_249_31.cost) or 0)
					end

					if var_249_18 < var_249_36 then
						var_249_33 = "red"
					end
				end

				local var_249_37 = #var_249_13 + 1
				local var_249_38 = {
					itemId = var_249_31.itemId,
					itemName = var_249_31.itemName
				}

				var_249_38.iconPath = tostring(var_249_31.icon or "")
				var_249_38.skeletonDataPath = tostring(var_249_31.skeletonDataPath or "")
				var_249_38.moduleSize = var_0_0:CloneTable(var_249_31.moduleSize)
				var_249_38.moduleScale = tonumber(var_249_31.moduleScale) or 1
				var_249_38.cost = var_249_31.cost
				var_249_38.costState = var_249_33
				var_249_38.typeText = var_249_31.typeText
				var_249_38.isUnlocked = var_249_32
				var_249_38.isSelected = var_249_31.itemId == var_249_20
				var_249_38.isEquipped = var_249_34
				var_249_38.redPointKey = self:BuildOptionNewRedPointKey(var_249_31.itemId)
				var_249_38.isNewRedPoint = var_249_31.isDefaultUnlocked ~= true and self:IsOptionNewRedPointRead(var_249_31.itemId) ~= true
				var_249_13[var_249_37] = var_249_38
			end
		end
	end

	local var_249_39 = var_0_0:CloneTable(var_249_3.slotSummary)

	for iter_249_3 = 1, #var_249_39 do
		local var_249_40 = var_249_39[iter_249_3]

		var_249_40.interactionMode = "modify"
		var_249_40.maskState = "state0"
		var_249_40.isSelected = var_249_4 ~= nil and var_249_4.slotType == var_249_40.slotType and tonumber(var_249_4.slotIndex) == tonumber(var_249_40.slotIndex)
		var_249_40.slotState = var_249_40.isLocked and "blocked" or "normal"
		var_249_40.selectedOptionId = var_249_20 or ""

		if var_249_4 then
			var_249_40.selectedOptionType = var_249_4.slotType or ""
		end
	end

	local var_249_41 = {
		optionListLocked = false,
		filterType = var_249_5,
		manualFilterType = var_0_0.outGameState_.modifyFilterType,
		bodyList = var_249_8,
		weaponOptionList = var_249_13,
		slotList = var_249_39
	}
	local var_249_42

	if var_249_4 then
		var_249_42 = {
			slotType = var_249_4.slotType,
			slotIndex = var_249_4.slotIndex
		}

		if var_249_19 then
			var_249_42.itemId = var_249_19.itemId or ""
		end

		var_249_42 = var_249_42 or nil
	end

	var_249_41.selectedSlot = var_249_42
	var_249_41.infoTargetType = var_249_22
	var_249_41.selectedOptionId = var_249_20

	local var_249_43

	if var_249_21 then
		var_249_43 = {
			itemId = var_249_21.itemId,
			itemName = var_249_21.itemName
		}
		var_249_43.iconPath = tostring(var_249_21.icon or "")
		var_249_43.typeText = var_249_21.typeText
		var_249_43.cost = var_249_21.cost
		var_249_43.desc = var_249_21.desc
		var_249_43.energyCost = var_249_21.energyCost or 0
		var_249_43.damage = var_249_21.damage or 0
		var_249_43.rof = var_249_21.rof or 0
		var_249_43.valueText = var_249_21.valueText or ""
		var_249_43 = var_249_43 or nil
	end

	var_249_41.selectedOption = var_249_43
	var_249_41.selectedBody = {
		bodyId = var_249_7.bodyId,
		bodyName = var_249_7.bodyName,
		desc = var_249_7.desc,
		hp = var_249_7.hp,
		cost = var_249_7.cost
	}
	var_249_41.vehicleDisplay = var_0_0:BuildVehicleDisplayModelFromSnapshot(var_249_3)
	var_249_41.vehicleLayout = var_0_0:CloneTable(var_249_3.bodyLayout)
	var_249_41.costSummary = var_0_0:CloneTable(var_249_3.costSummary)

	return var_249_41
end

function var_0_0:GetIllustratedPageModel(arg_250_1)
	if arg_250_1 ~= nil then
		self:SetIllustratedFilter(arg_250_1, true)
	end

	local var_250_0 = var_0_0.outGameState_.selectedIllustratedItemId
	local var_250_1 = {}
	local var_250_2 = {}
	local var_250_3 = {}
	local var_250_4

	for iter_250_0 = 1, #var_0_0:_GetBodyDefs() do
		local var_250_5 = var_0_0:BuildIllustratedBodyItemData(var_0_0:_GetBodyDefs()[iter_250_0], var_250_0)

		var_250_5.isUnlocked = self:IsBodyUnlocked(var_250_5.itemId)
		var_250_1[#var_250_1 + 1] = var_250_5

		if var_250_5.isSelected then
			var_250_4 = var_0_0:CloneTable(var_250_5)
		end
	end

	for iter_250_1 = 1, #var_0_0:_GetWeaponDefs() do
		local var_250_6 = var_0_0:BuildIllustratedOptionItemData(var_0_0:_GetWeaponDefs()[iter_250_1], var_250_0)

		var_250_6.isUnlocked = self:IsOptionUnlocked(var_250_6.itemId)
		var_250_2[#var_250_2 + 1] = var_250_6

		if var_250_6.isSelected then
			var_250_4 = var_0_0:CloneTable(var_250_6)
		end
	end

	for iter_250_2 = 1, #var_0_0:_GetEquipDefs() do
		local var_250_7 = var_0_0:BuildIllustratedOptionItemData(var_0_0:_GetEquipDefs()[iter_250_2], var_250_0)

		var_250_7.isUnlocked = self:IsOptionUnlocked(var_250_7.itemId)
		var_250_3[#var_250_3 + 1] = var_250_7

		if var_250_7.isSelected then
			var_250_4 = var_0_0:CloneTable(var_250_7)
		end
	end

	local var_250_8 = var_0_10(var_250_1)
	local var_250_9 = var_0_10(var_250_2)
	local var_250_10 = var_0_10(var_250_3)
	local var_250_11 = var_250_8

	if var_0_0.outGameState_.illustratedFilterType == SummerRaceConst.FILTER.WEAPON then
		var_250_11 = var_250_9
	elseif var_0_0.outGameState_.illustratedFilterType == SummerRaceConst.FILTER.EQUIP then
		var_250_11 = var_250_10
	end

	if var_250_4 == nil or var_250_4.typeText ~= var_0_0.outGameState_.illustratedFilterType then
		if #var_250_11 == 0 then
			var_250_11 = #var_250_8 > 0 and var_250_8 or #var_250_9 > 0 and var_250_9 or var_250_10
		end

		if #var_250_11 > 0 then
			var_0_0.outGameState_.selectedIllustratedItemId = var_250_11[1].itemId

			for iter_250_3 = 1, #var_250_8 do
				var_250_8[iter_250_3].isSelected = var_250_8[iter_250_3].itemId == var_0_0.outGameState_.selectedIllustratedItemId
			end

			for iter_250_4 = 1, #var_250_9 do
				var_250_9[iter_250_4].isSelected = var_250_9[iter_250_4].itemId == var_0_0.outGameState_.selectedIllustratedItemId
			end

			for iter_250_5 = 1, #var_250_10 do
				var_250_10[iter_250_5].isSelected = var_250_10[iter_250_5].itemId == var_0_0.outGameState_.selectedIllustratedItemId
			end

			var_250_4 = var_0_0:CloneTable(var_250_11[1])
			var_250_4.isSelected = true
		end
	end

	return {
		bodyList = var_250_8,
		weaponList = var_250_9,
		equipList = var_250_10,
		selectedItem = var_250_4,
		detailPanel = var_0_0:BuildIllustratedDetailPanel(var_250_4)
	}
end

function var_0_0:GetRankPageModel()
	return var_0_0.BuildRankPageData(self, self:GetSettlementState())
end

function var_0_0.GetRankActivityId(arg_252_0)
	return var_0_0:GetSummerRaceRankActivityId()
end

function var_0_0.GetEnemyDetailModel(arg_253_0, arg_253_1)
	local var_253_0 = var_0_0:GetEnemyDefs()
	local var_253_1 = var_0_0:_GetEquipDefs()
	local var_253_2 = var_0_0:FindDefById(var_253_0, arg_253_1) or var_253_0[1] or {
		desc = "",
		enemyName = "",
		enemyId = 0,
		bodyIcon = "",
		equipList = {}
	}
	local var_253_3 = {}

	for iter_253_0 = 1, #var_253_2.equipList do
		var_253_3[#var_253_3 + 1] = var_0_0:BuildSlotData(iter_253_0, SummerRaceConst.FILTER.EQUIP, var_0_0:FindDefById(var_253_1, var_253_2.equipList[iter_253_0]), "")
	end

	return {
		enemyId = var_253_2.enemyId,
		enemyName = var_253_2.enemyName,
		desc = var_253_2.desc,
		bodyIcon = var_253_2.bodyIcon,
		bodyIconPath = var_0_0:ResolveEnemyAvatarPath(var_253_2),
		slotList = var_253_3
	}
end

function var_0_0.GetEnemyAvatarPath(arg_254_0, arg_254_1)
	return var_0_0:ResolveEnemyAvatarPath((var_0_0:FindDefById(var_0_0:GetEnemyDefs(), arg_254_1)))
end

function var_0_0:GetRuntimeEnemyAvatarPath(arg_255_1)
	if type(arg_255_1) ~= "table" then
		return ""
	end

	local var_255_0 = var_0_0:GetEnemyDefs()
	local var_255_1

	if arg_255_1.enemyId ~= nil and arg_255_1.enemyId ~= "" and arg_255_1.enemyId ~= 0 then
		var_255_1 = var_0_0:FindDefById(var_255_0, arg_255_1.enemyId)
	end

	if var_255_1 == nil then
		local var_255_3 = var_0_0:RoundToInt(arg_255_1.wave or 0)

		if arg_255_1.stageId ~= nil and arg_255_1.stageId ~= "" and arg_255_1.stageId ~= 0 and var_255_3 > 0 then
			local var_255_4 = self:GetStageDetailModel(arg_255_1.stageId)

			if var_255_4 then
				local var_255_5 = var_255_4.enemyWaves or nil

				if type(var_255_5) == "table" then
					local var_255_6 = var_255_5[var_255_3] or nil

					if var_255_6 then
						local var_255_7 = var_255_6.enemyId or nil

						if var_255_7 ~= nil and var_255_7 ~= "" and var_255_7 ~= 0 then
							var_255_1 = var_0_0:FindDefById(var_255_0, var_255_7)
						end

						if var_255_1 == nil then
							local var_255_9 = tostring(arg_255_1.enemyName or "")

							if var_255_9 ~= "" then
								for iter_255_0 = 1, #var_255_0 do
									local var_255_10 = var_255_0[iter_255_0]

									if var_255_0[iter_255_0] then
										if tostring(var_255_10.enemyName or "") == var_255_9 then
											var_255_1 = var_255_10

											break
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return var_0_0:ResolveEnemyAvatarPath(var_255_1)
end

function var_0_0.GetRuntimeEnemyHudModels(arg_256_0, arg_256_1)
	local var_256_1

	if type(arg_256_1) == "table" then
		var_256_1 = tostring(arg_256_1.enemyName or "") or ""
	end

	local var_256_2 = var_0_0:GetRuntimeEnemyAvatarPath(arg_256_1)
	local var_256_3 = type(arg_256_1) == "table" and tonumber(arg_256_1.enemyHp) or 0
	local var_256_4 = math.max(1, type(arg_256_1) == "table" and tonumber(arg_256_1.enemyMaxHp) or 1 or 1)
	local var_256_5 = {}

	if type(arg_256_1) == "table" then
		var_256_5.enemyId = tostring(arg_256_1.enemyId or "") or ""
	end

	var_256_5.enemyName = var_256_1
	var_256_5.enemyAvatarPath = var_256_2
	var_256_5.enemyHp = math.max(0, var_256_3 or 0)
	var_256_5.enemyMaxHp = var_256_4
	var_256_5.enemyAlive = type(arg_256_1) == "table" and arg_256_1.enemyAlive == true or false
	var_256_5.enemyHeadOut = type(arg_256_1) == "table" and arg_256_1.enemyHeadOut == true or false
	var_256_5.enemyVisible = var_256_5.enemyAlive or var_256_5.enemyHeadOut

	if type(arg_256_1) ~= "table" then
		return {
			var_256_5
		}
	end

	local var_256_8

	if type(arg_256_1.enemyHudSlots) == "table" then
		var_256_8 = arg_256_1.enemyHudSlots or {}
	end

	local var_256_9 = {}
	local var_256_10 = {}
	local var_256_11 = var_0_0:GetEnemyDefs()

	for iter_256_0 = 1, #var_256_8 do
		local var_256_12 = var_256_8[iter_256_0]

		if type(var_256_8[iter_256_0]) == "table" then
			local var_256_14 = tostring(var_256_12.enemyId or "")
			local var_256_15 = var_256_14 ~= "" and var_0_0:FindDefById(var_256_11, var_256_14) or nil
			local var_256_16 = tostring(var_256_12.enemyName or "")

			if var_256_16 == "" and var_256_15 ~= nil then
				var_256_16 = tostring(var_256_15.enemyName or "")
			end

			local var_256_18 = var_256_15 ~= nil and var_0_0:ResolveEnemyAvatarPath(var_256_15) or ""
			local var_256_19 = var_256_12.enemyAlive == true
			local var_256_20 = var_256_12.enemyHeadOut == true
			local var_256_21 = {
				enemyId = var_256_14,
				enemyName = var_256_16,
				enemyAvatarPath = var_256_18
			}

			var_256_21.enemyHp = math.max(0, tonumber(var_256_12.enemyHp) or 0)
			var_256_21.enemyMaxHp = math.max(1, tonumber(var_256_12.enemyMaxHp) or tonumber(var_256_15 and var_256_15.baseHp) or var_256_4)
			var_256_21.enemyAlive = var_256_19
			var_256_21.enemyHeadOut = var_256_20
			var_256_21.enemyVisible = var_256_19 or var_256_20
			var_256_10[#var_256_10 + 1] = var_256_21

			if var_256_14 ~= "" and var_256_9[var_256_14] == nil then
				var_256_9[var_256_14] = var_256_21
			end
		end
	end

	local var_256_22 = tostring(arg_256_1.mode or "")
	local var_256_23

	if var_256_22 == SummerRaceConst.MODE.SURVIVAL_PRACTICE and #var_256_10 > 0 then
		do return var_256_10 end

		var_256_23 = tonumber(arg_256_1.enemyCount) or 1
	end

	local var_256_24 = math.max(1, math.floor(var_256_23))

	if var_256_22 == SummerRaceConst.MODE.ONE_VS_TWO_PRACTICE and #var_256_10 > 0 then
		local var_256_25 = {}

		for iter_256_1 = 1, var_256_24 do
			var_256_25[#var_256_25 + 1] = var_256_10[iter_256_1] or {
				enemyAlive = false,
				enemyAvatarPath = "",
				enemyHeadOut = false,
				enemyId = "",
				enemyHp = 0,
				enemyVisible = false,
				enemyName = "",
				enemyMaxHp = var_256_4
			}
		end

		return var_256_25
	end

	if var_256_24 <= 1 then
		return #var_256_10 > 0 and {
			var_256_10[1]
		} or {
			var_256_5
		}
	end

	local var_256_26 = arg_256_1.stageId
	local var_256_27 = var_0_0:RoundToInt(arg_256_1.wave or 0)

	if var_256_26 == nil or var_256_26 == "" or var_256_26 == 0 or var_256_27 <= 0 then
		return #var_256_10 > 0 and var_256_10 or {
			var_256_5,
			var_0_0:CloneTable(var_256_5)
		}
	end

	local var_256_28 = var_0_0:GetStageDetailModel(var_256_26)

	if var_256_28 then
		local var_256_29 = var_256_28.enemyWaves or nil

		if type(var_256_29) == "table" then
			local var_256_30 = var_256_29[var_256_27] or nil
			local var_256_31

			if type(var_256_30) == "table" then
				var_256_31 = var_256_30.enemyIds or nil
			end
		end
	end

	local var_256_32 = {}

	for iter_256_2 = 1, math.min(var_256_24, #(var_256_31 or {})) do
		local var_256_34 = tostring(var_256_31[iter_256_2] or "")
		local var_256_35 = var_0_0:FindDefById(var_256_11, var_256_34)
		local var_256_36 = var_256_9[var_256_34]
		local var_256_37 = math.max(1, tonumber(var_256_9[var_256_34] and var_256_36.enemyMaxHp) or tonumber(var_256_35 and var_256_35.baseHp) or var_256_5.enemyMaxHp)
		local var_256_39

		if var_256_35 then
			var_256_39 = tostring(var_256_35.enemyName or "") or ""

			if var_256_36 ~= nil then
				if tostring(var_256_36.enemyName or "") ~= "" then
					var_256_39 = tostring(var_256_36.enemyName)

					goto label_256_0
				end
			end

			if var_256_39 == "" and iter_256_2 == 1 then
				var_256_39 = var_256_1
			end
		end

		::label_256_0::

		local var_256_41 = var_256_35 ~= nil and var_0_0:ResolveEnemyAvatarPath(var_256_35) or ""

		if var_256_41 == "" and var_256_36 ~= nil then
			var_256_41 = tostring(var_256_36.enemyAvatarPath or "")
		elseif var_256_41 == "" and iter_256_2 == 1 then
			var_256_41 = var_256_2
		end

		local var_256_43 = #var_256_32 + 1
		local var_256_44 = {
			enemyId = var_256_34,
			enemyName = var_256_39,
			enemyAvatarPath = var_256_41
		}

		var_256_44.enemyHp = math.max(0, tonumber(var_256_36 and var_256_36.enemyHp) or 0)
		var_256_44.enemyMaxHp = var_256_37
		var_256_44.enemyAlive = var_256_36 ~= nil and var_256_36.enemyAlive == true
		var_256_44.enemyHeadOut = var_256_36 ~= nil and var_256_36.enemyHeadOut == true
		var_256_44.enemyVisible = var_256_36 ~= nil and var_256_36.enemyVisible == true
		var_256_32[var_256_43] = var_256_44
	end

	if #var_256_32 <= 0 and #var_256_10 > 0 then
		return var_256_10
	end

	while var_256_24 > #var_256_32 do
		if var_256_10[#var_256_32 + 1] ~= nil then
			var_256_32[#var_256_32 + 1] = var_256_10[#var_256_32 + 1]
		else
			local var_256_45 = var_0_0:CloneTable(var_256_5)

			var_256_45.enemyId = ""
			var_256_45.enemyName = ""
			var_256_45.enemyAvatarPath = ""
			var_256_45.enemyHp = 0
			var_256_45.enemyAlive = false
			var_256_45.enemyHeadOut = false
			var_256_45.enemyVisible = false
			var_256_32[#var_256_32 + 1] = var_256_45
		end
	end

	return var_256_32
end

function var_0_0.GetRuntimeTeammateAvatarPath(arg_257_0, arg_257_1)
	if type(arg_257_1) ~= "table" then
		return ""
	end

	local var_257_0 = var_0_0:FindStageInfoById(arg_257_1.stageId)

	return var_0_0:ResolveTeammateAvatarPath((var_257_0 or nil) and (var_257_0.teammateIcon or ""))
end

function var_0_0.GetTankSnapshotModel(arg_258_0, arg_258_1)
	local var_258_0 = var_0_0:_GetBodyDefs()
	local var_258_1 = arg_258_1

	if type(arg_258_1) ~= "table" then
		var_258_1 = var_0_0:CloneTable(var_0_0:getCurrentBuild())
	end

	local var_258_2 = var_0_0:FindDefById(var_258_0, var_258_1.bodyId) or var_258_0[1] or {
		cost = 0,
		bodyName = "",
		bodyId = 0
	}
	local var_258_3 = var_0_0:BuildBuildSnapshot(var_258_1, var_0_0.outGameState_.selectedOptionId)

	return {
		tankName = var_258_2.bodyName .. " Build",
		bodyIcon = var_258_2.bodyId,
		cost = var_258_3.totalCost,
		slotList = var_258_3.slotSummary
	}
end

function var_0_0.GetEquipInfoModel(arg_259_0, arg_259_1)
	local var_259_0 = var_0_0:_GetWeaponDefs()
	local var_259_1 = var_0_0:_GetEquipDefs()
	local var_259_2 = var_0_0:FindDefById(var_259_0, arg_259_1) or var_0_0:FindDefById(var_259_1, arg_259_1) or var_259_0[1] or var_259_1[1] or {
		cost = 0,
		itemId = 0,
		itemName = "",
		energyCost = 0,
		valueText = "",
		desc = "",
		typeText = SummerRaceConst.FILTER.WEAPON
	}
	local var_259_3 = {
		equipId = var_259_2.itemId,
		icon = var_259_2.itemId,
		equipName = var_259_2.itemName,
		typeText = var_259_2.typeText,
		cost = var_259_2.cost
	}

	var_259_3.energyCost = var_259_2.energyCost or 0
	var_259_3.desc = var_259_2.desc
	var_259_3.valueText = var_259_2.valueText or "Damage / utility module"

	return var_259_3
end

if var_0_0.runtimeState_ == nil then
	var_0_0:Init()
end

return var_0_0
