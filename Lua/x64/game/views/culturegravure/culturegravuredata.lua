local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}

function var_0_0.InitFromServer(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(cleanProtoTable(arg_1_1.astro)) do
		var_0_1[iter_1_1.id] = {}

		for iter_1_2, iter_1_3 in pairs(cleanProtoTable(iter_1_1.rate_list)) do
			local var_1_0 = {}
			local var_1_1 = iter_1_3.rate

			for iter_1_4, iter_1_5 in pairs(cleanProtoTable(iter_1_3.id_list)) do
				table.insert(var_1_0, iter_1_5)
			end

			table.insert(var_0_1[iter_1_1.id], {
				list = var_1_0,
				rate = var_1_1
			})
		end

		table.sort(var_0_1[iter_1_1.id], function(arg_2_0, arg_2_1)
			return arg_2_0.rate > arg_2_1.rate
		end)
	end

	for iter_1_6, iter_1_7 in ipairs(cleanProtoTable(arg_1_1.common_equip)) do
		var_0_2[iter_1_7.id] = {}

		for iter_1_8, iter_1_9 in pairs(cleanProtoTable(iter_1_7.rate_list)) do
			local var_1_2 = {}
			local var_1_3 = iter_1_9.rate

			for iter_1_10, iter_1_11 in pairs(cleanProtoTable(iter_1_9.id_list)) do
				table.insert(var_1_2, iter_1_11)
			end

			table.insert(var_0_2[iter_1_7.id], {
				list = var_1_2,
				rate = var_1_3
			})
		end

		table.sort(var_0_2[iter_1_7.id], function(arg_3_0, arg_3_1)
			return arg_3_0.rate > arg_3_1.rate
		end)
	end

	for iter_1_12, iter_1_13 in ipairs(cleanProtoTable(arg_1_1.omega_equip)) do
		var_0_3[iter_1_13.id] = {}

		for iter_1_14, iter_1_15 in pairs(cleanProtoTable(iter_1_13.rate_list)) do
			local var_1_4 = {}
			local var_1_5 = iter_1_15.rate

			for iter_1_16, iter_1_17 in pairs(cleanProtoTable(iter_1_15.id_list)) do
				table.insert(var_1_4, iter_1_17)
			end

			table.insert(var_0_3[iter_1_13.id], {
				list = var_1_4,
				rate = var_1_5
			})
		end

		table.sort(var_0_3[iter_1_13.id], function(arg_4_0, arg_4_1)
			return arg_4_0.rate > arg_4_1.rate
		end)
	end

	var_0_0:InitServantList()
	var_0_0:InitEquipSkillList()
end

function var_0_0.InitServantList(arg_5_0)
	local var_5_0 = EquipRecommendCfg.all

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_1 = HeroCfg[iter_5_1]
		local var_5_2 = WeaponServantData:GetPrivateWeaponServantIdByHeroID(var_5_1.id)

		var_0_4[var_5_1.id] = {}

		if var_5_2 ~= 0 then
			table.insert(var_0_4[var_5_1.id], var_5_2)
		end

		table.insert(var_0_4[var_5_1.id], WeaponServantData:GetPublicWeaponServantIdByRace(var_5_1.race))
		table.insert(var_0_4[var_5_1.id], EquipRecommendCfg[var_5_1.id].weapon[1])
	end
end

function var_0_0.InitEquipSkillList(arg_6_0)
	local var_6_0 = {
		3,
		2,
		1
	}
	local var_6_1 = EquipRecommendCfg.all

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		local var_6_2 = HeroCfg[iter_6_1].recommend_equip_skill

		var_0_5[iter_6_1] = {}

		for iter_6_2, iter_6_3 in ipairs(var_6_2) do
			for iter_6_4, iter_6_5 in ipairs(iter_6_3) do
				table.insert(var_0_5[iter_6_1], {
					id = iter_6_5,
					recommendLevel = var_6_0[iter_6_2]
				})
			end
		end
	end
end

function var_0_0.GetServantListByID(arg_7_0, arg_7_1)
	return var_0_4[arg_7_1] or {}
end

function var_0_0.GetAstroListByID(arg_8_0, arg_8_1)
	return var_0_1[arg_8_1] or {}
end

function var_0_0.GetCommonEquiptListByID(arg_9_0, arg_9_1)
	return var_0_2[arg_9_1] or {}
end

function var_0_0.GetOmegaEquiptListByID(arg_10_0, arg_10_1)
	return var_0_3[arg_10_1] or {}
end

function var_0_0.GetTransitionListByID(arg_11_0, arg_11_1)
	return HeroCfg[arg_11_1] and HeroCfg[arg_11_1].recommend_equip_warp or {}
end

function var_0_0.GetEquipSkillListByID(arg_12_0, arg_12_1)
	return var_0_5[arg_12_1] or {}
end

function var_0_0.GetTeamListByID(arg_13_0, arg_13_1)
	return HeroCfg[arg_13_1] and HeroCfg[arg_13_1].recommend_team or {}
end

function var_0_0.GetServantIsEquipped(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = WeaponServantData:GetWeaponServantList()
	local var_14_1 = ServantTools.GetServantMap()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if var_14_1[iter_14_1.uid] and var_14_1[iter_14_1.uid] == arg_14_1 and iter_14_1.id == arg_14_2 then
			return true
		end
	end

	return false
end

function var_0_0.GetHasServant(arg_15_0, arg_15_1)
	local var_15_0 = WeaponServantData:GetWeaponServantById(arg_15_1)
	local var_15_1 = ServantTools.GetServantMap()

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if not var_15_1[iter_15_1.uid] then
			return true
		end
	end

	return false
end

function var_0_0.GetEquiptIsEquipped(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = HeroData.GetEquipMap()

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_1 = EquipData:GetEquipData(iter_16_0)
		local var_16_2 = var_0_0:GetEquiptPrefabListByEquiptID(arg_16_2)

		for iter_16_2, iter_16_3 in pairs(var_16_2) do
			if var_16_1 and var_16_1.prefab_id == iter_16_3 and iter_16_1 == arg_16_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetHasEquipt(arg_17_0, arg_17_1)
	local var_17_0 = var_0_0:GetEquiptPrefabListByEquiptID(arg_17_1)
	local var_17_1 = HeroData:GetEquipMap()
	local var_17_2 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_3 = EquipData:GetEquipPrefabMap(iter_17_1)

		for iter_17_2, iter_17_3 in ipairs(var_17_3) do
			if not var_17_1[iter_17_3] then
				table.insert(var_17_2, iter_17_3)
			end
		end
	end

	return #var_17_2 ~= 0
end

function var_0_0.ReplaceAndInsert(arg_18_0, arg_18_1)
	local var_18_0 = tostring(arg_18_1)
	local var_18_1 = {}

	for iter_18_0 = 1, 9 do
		local var_18_2 = var_18_0:sub(1, 2) .. iter_18_0 .. var_18_0:sub(4)
		local var_18_3 = tonumber(var_18_2)

		table.insert(var_18_1, var_18_3)
	end

	local var_18_4 = 5 .. var_18_0:sub(2, 2) .. 0 .. var_18_0:sub(4)
	local var_18_5 = tonumber(var_18_4)

	table.insert(var_18_1, var_18_5)

	return var_18_1
end

function var_0_0.GetEquiptPrefabListByEquiptID(arg_19_0, arg_19_1)
	local var_19_0 = {}

	if EquipData:GetEquipCnt(arg_19_1) ~= 0 then
		table.insert(var_19_0, arg_19_1)
	end

	local var_19_1 = var_0_0:ReplaceAndInsert(arg_19_1)

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if iter_19_1 ~= arg_19_1 and EquipData:GetEquipCnt(iter_19_1) ~= 0 then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.GetIsNeedPopRecommendTipsByHeroID(arg_20_0, arg_20_1)
	local var_20_0 = HeroData:GetHeroData(arg_20_1)
	local var_20_1 = var_20_0.equip
	local var_20_2 = true
	local var_20_3 = var_20_0.servant_uid ~= 0
	local var_20_4 = #var_20_0.using_astrolabe == 3

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		if iter_20_1.equip_id == 0 then
			var_20_2 = false
		end
	end

	return var_20_2 and var_20_3 and var_20_4
end

function var_0_0.GetHasEquippedAllAstro(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = HeroData:GetHeroData(arg_21_1).using_astrolabe

	if #var_21_0 < #arg_21_2 then
		return false
	end

	for iter_21_0, iter_21_1 in pairs(arg_21_2) do
		for iter_21_2, iter_21_3 in pairs(var_21_0) do
			if iter_21_3 == iter_21_1 then
				break
			end

			if iter_21_2 == #var_21_0 then
				return false
			end
		end
	end

	return true
end

function var_0_0.GetHasUnlockAllAstro(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = HeroData:GetHeroData(arg_22_1).unlocked_astrolabe

	for iter_22_0, iter_22_1 in pairs(arg_22_2) do
		if #var_22_0 < 1 then
			return false, iter_22_1
		end

		for iter_22_2, iter_22_3 in pairs(var_22_0) do
			if iter_22_3 == iter_22_1 then
				break
			end

			if iter_22_2 == #var_22_0 then
				return false, iter_22_1
			end
		end
	end

	return true, 0
end

function var_0_0.SetLastTabIndex(arg_23_0, arg_23_1)
	var_0_0.tabIndex_ = arg_23_1
end

function var_0_0.GetLastTabIndex(arg_24_0)
	return var_0_0.tabIndex_
end

return var_0_0
