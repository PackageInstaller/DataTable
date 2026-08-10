local var_0_0 = {
	GetServantMap = function()
		local var_1_0 = {}
		local var_1_1 = HeroData:GetHeroList()

		for iter_1_0, iter_1_1 in pairs(var_1_1) do
			if iter_1_1.servant_uid ~= 0 then
				var_1_0[iter_1_1.servant_uid] = iter_1_0
			end
		end

		return var_1_0
	end,
	GetServantLimited = function(arg_2_0, arg_2_1)
		local var_2_0 = HeroData:GetHeroList()
		local var_2_1 = {}
		local var_2_2 = {}
		local var_2_3 = WeaponServantData:GetWeaponServantList()

		if arg_2_1 then
			for iter_2_0, iter_2_1 in pairs(var_2_0) do
				var_2_2[iter_2_1.servant_uid] = 1
			end
		end

		if arg_2_0 then
			for iter_2_2, iter_2_3 in pairs(var_2_3) do
				if iter_2_3.locked == 0 and not var_2_2[iter_2_2] then
					table.insert(var_2_1, iter_2_3)
				end
			end
		else
			for iter_2_4, iter_2_5 in pairs(var_2_3) do
				table.insert(var_2_1, iter_2_5)
			end
		end

		return var_2_1
	end,
	GetServantByIDLimited = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = HeroData:GetHeroList()
		local var_3_1 = {}
		local var_3_2 = {}
		local var_3_3 = WeaponServantData:GetServantSByID(arg_3_0)

		if arg_3_2 then
			for iter_3_0, iter_3_1 in pairs(var_3_0) do
				var_3_2[iter_3_1.servant_uid] = 1
			end
		end

		if arg_3_1 then
			for iter_3_2, iter_3_3 in pairs(var_3_3) do
				if WeaponServantData:GetServantDataByUID(iter_3_2).locked == 0 and not var_3_2[iter_3_2] and iter_3_2 ~= arg_3_3 then
					table.insert(var_3_1, iter_3_2)
				end
			end
		else
			for iter_3_4, iter_3_5 in pairs(var_3_3) do
				table.insert(var_3_1, iter_3_4)
			end
		end

		return var_3_1
	end,
	ServantBreakCost = function(arg_4_0, arg_4_1)
		if arg_4_1 > GameSetting.weapon_promote_max.value[arg_4_0] then
			print("已超过最大突破次数")

			return false
		end

		return GameSetting.weapon_servant_gold_cost.value[arg_4_0][arg_4_1]
	end
}

function var_0_0.ServantBreakMaterialCost(arg_5_0, arg_5_1)
	if var_0_0.GetServantSpecHero(arg_5_0) then
		return GameSetting.weapon_promote_cost_exclusive.value
	else
		return GameSetting.weapon_promote_cost.value[arg_5_1 - 3]
	end
end

function var_0_0.GetServantSpecHero(arg_6_0)
	local var_6_0 = WeaponServantCfg[arg_6_0].effect[1]
	local var_6_1

	if var_6_0 > 0 then
		var_6_1 = WeaponEffectCfg[var_6_0].spec_char[1]
	end

	return var_6_1
end

function var_0_0.IsSleepServant(arg_7_0)
	local var_7_0 = WeaponServantCfg[arg_7_0]

	if var_7_0 and var_7_0.type == 3 then
		return true
	end

	return false
end

function var_0_0.GetSleepyServantByServant(arg_8_0)
	if var_0_0.GetServantSpecHero(arg_8_0) then
		local var_8_0 = WeaponServantCfg[arg_8_0].race

		for iter_8_0, iter_8_1 in ipairs(WeaponServantCfg.get_id_list_by_race[var_8_0]) do
			if WeaponServantCfg[iter_8_1].type == 3 then
				return iter_8_1
			end
		end
	end

	return false
end

function var_0_0.GetSleepyServantNum(arg_9_0)
	if not WeaponServantCfg.get_id_list_by_race[arg_9_0] then
		error("错误的race:" .. arg_9_0)
	end

	local var_9_0

	for iter_9_0, iter_9_1 in ipairs(WeaponServantCfg.get_id_list_by_race[arg_9_0]) do
		if WeaponServantCfg[iter_9_1].type == 3 then
			var_9_0 = iter_9_1
		end
	end

	return table.length(WeaponServantData:GetServantSByID(var_9_0))
end

function var_0_0.GetServantDecomposeRewardItem(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0) do
		local var_10_1 = WeaponServantCfg[iter_10_1.id].starlevel
		local var_10_2 = GameSetting.weapon_servant_break_cost_return.value[var_10_1]
		local var_10_3 = var_10_2[1][1]

		var_10_0[var_10_3] = (var_10_0[var_10_3] and var_10_0[var_10_3] or 0) + var_10_2[1][2]
	end

	local var_10_4 = {}
	local var_10_5 = 1

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		var_10_4[var_10_5] = {
			id = iter_10_2,
			number = iter_10_3
		}
		var_10_5 = var_10_5 + 1
	end

	return var_10_4
end

function var_0_0.GetServantIsUnlock(arg_11_0)
	return IllustratedData:GetServantInfo()[arg_11_0]
end

function var_0_0.GetServantIsHideUntilObtained(arg_12_0)
	return nullable(WeaponServantCfg, arg_12_0, "display_type") == 1
end

function var_0_0.GetIsHide(arg_13_0)
	if HideInfoData:GetWeaponServantHideList()[arg_13_0] then
		return true
	end

	if var_0_0.GetServantIsHideUntilObtained(arg_13_0) and not var_0_0.GetServantIsUnlock(arg_13_0) then
		return true
	end

	return false
end

function var_0_0.GetNotSummonable(arg_14_0)
	return nullable(WeaponServantCfg, arg_14_0, "summon_blocked") == 1
end

function var_0_0.GetServantShowCount()
	local var_15_0 = 0
	local var_15_1 = WeaponServantData:GetWeaponServantList()

	for iter_15_0, iter_15_1 in pairs(var_15_1) do
		if not var_0_0.GetIsHide(iter_15_1.id) then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function var_0_0.GetWeaponShowData(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0 or Filter_Root_Define.Servant_Filter_List.filter_id
	local var_16_1 = {}
	local var_16_2 = ServantTools.GetServantMap()
	local var_16_3 = WeaponServantData:GetWeaponServantList()
	local var_16_4 = CommonFilterData:IsAll(var_16_0)
	local var_16_5 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)

	local function var_16_6(arg_17_0, arg_17_1)
		if arg_17_1.hideStar then
			local var_17_0 = WeaponServantCfg[arg_17_0.id].starlevel

			for iter_17_0, iter_17_1 in pairs(arg_17_1.hideStar) do
				if var_17_0 == iter_17_1 then
					return true
				end
			end
		end

		if arg_17_1.hideEquip and var_16_2[arg_17_0.uid] then
			return true
		end

		if arg_17_1.hideLock and WeaponServantData:GetServantDataByUID(arg_17_0.uid).locked == 1 then
			return true
		end

		return false
	end

	for iter_16_0, iter_16_1 in pairs(var_16_3) do
		local var_16_7 = not var_0_0.GetIsHide(iter_16_1.id)
		local var_16_8 = arg_16_1 and var_16_6(iter_16_1, arg_16_1) or false

		if var_16_7 and not var_16_4 and not var_16_8 then
			local var_16_9 = WeaponServantCfg[iter_16_1.id]
			local var_16_10 = {}
			local var_16_11 = var_0_0.ServantBreakCost(var_16_9.starlevel, iter_16_1.stage)

			if var_16_11 and var_16_11 < var_16_5 and var_16_9.type ~= 3 then
				table.insert(var_16_10, Filter_Tags_Define.Beyond)
			end

			if var_16_2[iter_16_1.uid] then
				table.insert(var_16_10, Filter_Tags_Define.Equip)
			end

			if var_16_9.type == 3 then
				table.insert(var_16_10, Filter_Tags_Define.CallName)
			end

			var_16_7 = var_0_0.FilterCheck(var_16_9, var_16_0, var_16_10)
		end

		if var_16_7 and not var_16_8 then
			table.insert(var_16_1, iter_16_1)
		end
	end

	return var_16_1
end

function var_0_0.FilterCheck(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = false

	if arg_18_1 == Filter_Root_Define.Servant_Filter_List.filter_id then
		local var_18_1 = CommonFilterData:SpecificHasFlag(Filter_Root_Define.Servant_Filter_List.filter_id, Filter_Group_Define.RACE.groupID, {
			Filter_Tags_Define["Race" .. arg_18_0.race]
		})
		local var_18_2 = CommonFilterData:SpecificHasFlag(Filter_Root_Define.Servant_Filter_List.filter_id, Filter_Group_Define.SERVANT_ADD.groupID, arg_18_2)
		local var_18_3 = CommonFilterData:SpecificHasFlag(Filter_Root_Define.Servant_Filter_List.filter_id, Filter_Group_Define.RARITY.groupID, {
			Filter_Tags_Define["Star" .. arg_18_0.starlevel]
		})

		return var_18_1 and var_18_2 and var_18_3
	elseif arg_18_1 == Filter_Root_Define.Decompose_Servant_Filter_List.filter_id then
		local var_18_4 = CommonFilterData:SpecificHasFlag(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id, Filter_Group_Define.RACE.groupID, {
			Filter_Tags_Define["Race" .. arg_18_0.race]
		})
		local var_18_5 = CommonFilterData:SpecificHasFlag(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id, Filter_Group_Define.DECOMPOSE_RARITY.groupID, {
			Filter_Tags_Define["Star" .. arg_18_0.starlevel]
		})
		local var_18_6 = CommonFilterData:SpecificHasFlag(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id, Filter_Group_Define.DECOMPOSE_SERVANT_ADD.groupID, arg_18_2)

		return var_18_4 and var_18_5 and var_18_6
	end
end

function var_0_0.ServantSort(arg_19_0, arg_19_1)
	local var_19_0 = WeaponServantCfg[arg_19_0.id].starlevel
	local var_19_1 = WeaponServantCfg[arg_19_1.id].starlevel
	local var_19_2 = arg_19_0.stage
	local var_19_3 = arg_19_1.stage
	local var_19_4 = WeaponServantCfg[arg_19_0.id].race
	local var_19_5 = WeaponServantCfg[arg_19_1.id].race
	local var_19_6 = arg_19_0.id
	local var_19_7 = arg_19_1.id
	local var_19_8 = arg_19_0.uid
	local var_19_9 = arg_19_1.uid

	if var_19_0 ~= var_19_1 then
		return var_19_1 < var_19_0
	end

	if var_19_2 ~= var_19_3 then
		return var_19_3 < var_19_2
	end

	if var_19_4 ~= var_19_5 then
		return var_19_5 < var_19_4
	end

	if var_19_6 ~= var_19_7 then
		return var_19_7 < var_19_6
	end

	return var_19_9 < var_19_8
end

function var_0_0.GetServantList(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6)
	local function var_20_0(arg_21_0, arg_21_1)
		local var_21_0 = ServantTools.GetServantSpecHero(arg_21_0.id)
		local var_21_1 = ServantTools.GetServantSpecHero(arg_21_1.id)

		if arg_21_0.id == arg_21_1.id then
			local var_21_2 = WeaponServantCfg[arg_21_0.id].starlevel
			local var_21_3 = WeaponServantCfg[arg_21_1.id].starlevel
			local var_21_4 = arg_21_0.stage
			local var_21_5 = arg_21_1.stage
			local var_21_6 = WeaponServantCfg[arg_21_0.id].race
			local var_21_7 = WeaponServantCfg[arg_21_1.id].race
			local var_21_8 = arg_21_0.id
			local var_21_9 = arg_21_1.id
			local var_21_10 = arg_21_0.uid
			local var_21_11 = arg_21_1.uid

			if var_21_4 ~= var_21_5 then
				return var_21_5 < var_21_4
			end

			if var_21_2 ~= var_21_3 then
				return var_21_3 < var_21_2
			end

			if var_21_6 ~= var_21_7 then
				return var_21_7 < var_21_6
			end

			if var_21_8 ~= var_21_9 then
				return var_21_9 < var_21_8
			end

			return var_21_11 < var_21_10
		else
			if arg_20_1 then
				if arg_20_1 == var_21_0 then
					return true
				elseif arg_20_1 == var_21_1 then
					return false
				end
			end

			local var_21_12 = WeaponServantCfg[arg_21_0.id].starlevel
			local var_21_13 = WeaponServantCfg[arg_21_1.id].starlevel
			local var_21_14 = arg_21_0.stage
			local var_21_15 = arg_21_1.stage
			local var_21_16 = WeaponServantCfg[arg_21_0.id].race
			local var_21_17 = WeaponServantCfg[arg_21_1.id].race
			local var_21_18 = arg_21_0.id
			local var_21_19 = arg_21_1.id
			local var_21_20 = arg_21_0.uid
			local var_21_21 = arg_21_1.uid

			if var_21_14 ~= var_21_15 then
				return var_21_15 < var_21_14
			end

			if var_21_12 ~= var_21_13 then
				return var_21_13 < var_21_12
			end

			if var_21_16 ~= var_21_17 then
				return var_21_17 < var_21_16
			end

			if var_21_18 ~= var_21_19 then
				return var_21_19 < var_21_18
			end

			return var_21_21 < var_21_20
		end
	end

	local function var_20_1(arg_22_0, arg_22_1)
		local var_22_0 = ServantTools.GetServantSpecHero(arg_22_0.id)
		local var_22_1 = ServantTools.GetServantSpecHero(arg_22_1.id)

		if arg_22_0.id == arg_22_1.id then
			local var_22_2 = WeaponServantCfg[arg_22_0.id].starlevel
			local var_22_3 = WeaponServantCfg[arg_22_1.id].starlevel
			local var_22_4 = arg_22_0.stage
			local var_22_5 = arg_22_1.stage
			local var_22_6 = WeaponServantCfg[arg_22_0.id].race
			local var_22_7 = WeaponServantCfg[arg_22_1.id].race
			local var_22_8 = arg_22_0.id
			local var_22_9 = arg_22_1.id
			local var_22_10 = arg_22_0.uid
			local var_22_11 = arg_22_1.uid

			if var_22_2 ~= var_22_3 then
				return var_22_3 < var_22_2
			end

			if var_22_4 ~= var_22_5 then
				return var_22_5 < var_22_4
			end

			if var_22_6 ~= var_22_7 then
				return var_22_7 < var_22_6
			end

			if var_22_8 ~= var_22_9 then
				return var_22_9 < var_22_8
			end

			return var_22_11 < var_22_10
		else
			if arg_20_1 then
				if arg_20_1 == var_22_0 then
					return true
				elseif arg_20_1 == var_22_1 then
					return false
				end
			end

			local var_22_12 = WeaponServantCfg[arg_22_0.id].starlevel
			local var_22_13 = WeaponServantCfg[arg_22_1.id].starlevel
			local var_22_14 = arg_22_0.stage
			local var_22_15 = arg_22_1.stage
			local var_22_16 = WeaponServantCfg[arg_22_0.id].race
			local var_22_17 = WeaponServantCfg[arg_22_1.id].race
			local var_22_18 = arg_22_0.id
			local var_22_19 = arg_22_1.id
			local var_22_20 = arg_22_0.uid
			local var_22_21 = arg_22_1.uid

			if var_22_12 ~= var_22_13 then
				return var_22_13 < var_22_12
			end

			if var_22_14 ~= var_22_15 then
				return var_22_15 < var_22_14
			end

			if var_22_16 ~= var_22_17 then
				return var_22_17 < var_22_16
			end

			if var_22_18 ~= var_22_19 then
				return var_22_19 < var_22_18
			end

			return var_22_21 < var_22_20
		end
	end

	local var_20_2

	if arg_20_1 then
		local var_20_3 = HeroTools.GetHeroServantInfo(arg_20_1)

		var_20_2 = var_20_3 and var_20_3.uid
	end

	local function var_20_4(arg_23_0, arg_23_1)
		if var_20_2 then
			if var_20_2 == arg_23_0.uid then
				return true
			elseif var_20_2 == arg_23_1.uid then
				return false
			end
		end

		return 1
	end

	local var_20_5 = 0
	local var_20_6 = false

	if arg_20_1 and arg_20_1 ~= 0 then
		var_20_5 = HeroTools.GetHeroSpecServant(arg_20_1)
	end

	local var_20_7 = WeaponServantData:GetSortConfig()
	local var_20_8 = arg_20_4 or var_20_7[1]
	local var_20_9 = arg_20_5 or var_20_7[2]
	local var_20_10

	if arg_20_1 then
		var_20_10 = HeroCfg[arg_20_1].race
	end

	local var_20_11 = {}
	local var_20_12 = {}
	local var_20_13 = {}
	local var_20_14 = arg_20_2 or WeaponServantData:GetWeaponServantList()

	for iter_20_0, iter_20_1 in pairs(var_20_14) do
		if arg_20_1 then
			if WeaponServantCfg[iter_20_1.id].race == var_20_10 then
				local var_20_15 = WeaponServantCfg[iter_20_1.id].race

				if not table.indexof(var_20_11, var_20_15) then
					table.insert(var_20_11, var_20_15)
				end

				if not var_20_12[var_20_15] then
					var_20_12[var_20_15] = 0
				end

				var_20_12[var_20_15] = var_20_12[var_20_15] + 1

				table.insert(var_20_13, iter_20_1)
			end
		else
			local var_20_16 = WeaponServantCfg[iter_20_1.id].race

			if not table.indexof(var_20_11, var_20_16) then
				table.insert(var_20_11, var_20_16)
			end

			if not var_20_12[var_20_16] then
				var_20_12[var_20_16] = 0
			end

			var_20_12[var_20_16] = var_20_12[var_20_16] + 1

			table.insert(var_20_13, iter_20_1)
		end

		if var_20_5 ~= 0 and iter_20_1.id == var_20_5 then
			var_20_6 = true
		end
	end

	var_20_12[0] = #var_20_13

	if arg_20_3 and var_20_5 ~= 0 and not var_20_6 then
		if arg_20_6 then
			if var_0_0.FilterCheck(WeaponServantCfg[var_20_5], arg_20_6) then
				local var_20_17 = WeaponServantData:GetDefaultData(var_20_5)

				var_20_17.isRecommend = true

				table.insert(var_20_13, var_20_17)
			end
		else
			local var_20_18 = WeaponServantData:GetDefaultData(var_20_5)

			var_20_18.isRecommend = true

			table.insert(var_20_13, var_20_18)
		end
	end

	table.sort(var_20_13, function(arg_24_0, arg_24_1)
		if arg_24_0.isRecommend then
			return true
		end

		if arg_24_1.isRecommend then
			return false
		end

		local var_24_0 = var_20_4(arg_24_0, arg_24_1)

		if var_24_0 == 1 then
			if var_20_8 == 0 then
				if var_20_9 == 0 then
					return var_20_0(arg_24_0, arg_24_1)
				else
					return var_20_0(arg_24_1, arg_24_0)
				end
			elseif var_20_8 == 1 then
				if var_20_9 == 0 then
					return var_20_1(arg_24_0, arg_24_1)
				else
					return var_20_1(arg_24_1, arg_24_0)
				end
			end
		else
			return var_24_0
		end
	end)

	return var_20_13
end

function var_0_0.GetAwakeServantList(arg_25_0, arg_25_1)
	local var_25_0 = WeaponServantData:GetAllPrivateWeaponServantIdList()
	local var_25_1 = {}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if not ServantTools.GetIsHide(iter_25_1) and not var_0_0.GetNotSummonable(iter_25_1) and WeaponServantCfg[iter_25_1].race == arg_25_1 then
			table.insert(var_25_1, {
				locked = 0,
				stage = 1,
				uid = 0,
				id = iter_25_1
			})
		end
	end

	local function var_25_2(arg_26_0, arg_26_1)
		local var_26_0 = arg_25_0:MaterialEnoughById(arg_26_0.id) and 1 or 0
		local var_26_1 = arg_25_0:MaterialEnoughById(arg_26_1.id) and 1 or 0
		local var_26_2 = arg_26_0.id
		local var_26_3 = arg_26_1.id

		if var_26_0 ~= var_26_1 then
			return var_26_1 < var_26_0
		end

		return var_26_2 < var_26_3
	end

	table.sort(var_25_1, var_25_2)

	return var_25_1
end

function var_0_0.MaterialEnoughById(arg_27_0, arg_27_1)
	local var_27_0 = WeaponServantCfg[arg_27_1]
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
		if iter_27_1[1] == var_27_0.race then
			var_27_1 = iter_27_1[2]
		end
	end

	local var_27_2 = WeaponServantData:GetWeaponServantById(var_27_1[1][1])
	local var_27_3 = 0

	if var_27_2 then
		var_27_3 = #var_27_2
	end

	return ItemTools.getItemNum(var_27_1[2][1]) >= var_27_1[2][2] and var_27_3 >= var_27_1[1][2]
end

function var_0_0.JumpToCallName(arg_28_0, arg_28_1)
	local var_28_0 = WeaponServantCfg[arg_28_1].race
	local var_28_1 = {
		openTab = "callName",
		guideForce = true,
		race = var_28_0,
		servantID = arg_28_1,
		HeroID = arg_28_0
	}

	manager.notify:Invoke(SERVANT_SWITCH_TO_CALLNAME, var_28_1)
end

function var_0_0.JumpToNormalList(arg_29_0, arg_29_1)
	local var_29_0 = {
		openTab = "hold",
		servantUID = arg_29_1,
		HeroID = arg_29_0
	}

	manager.notify:Invoke(SERVANT_SWITCH_TO_CALLNAME, var_29_0)
end

function var_0_0.ServantIsHeroRecom(arg_30_0, arg_30_1)
	if not arg_30_1 or not arg_30_0 then
		return false
	end

	if arg_30_1 == 0 or arg_30_0 == 0 then
		return false
	end

	local var_30_0 = WeaponServantCfg[arg_30_0]

	if not var_30_0 then
		return false
	end

	local var_30_1 = var_30_0.effect[1]
	local var_30_2 = 0

	if var_30_1 > 0 then
		var_30_2 = WeaponEffectCfg[var_30_1].spec_char[1]
	end

	if var_30_2 and var_30_2 > 0 and var_30_2 == arg_30_1 then
		return true
	end

	return false
end

return var_0_0
