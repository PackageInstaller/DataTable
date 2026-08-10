local var_0_0 = {}

manager.net:Bind(12097, function(arg_1_0)
	CultureGravureData:InitFromServer(arg_1_0)
end)

function var_0_0.GetSortedEquipIDByEquipList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_1 = deepClone(EquipData:GetEquipPrefabMap(iter_2_1))

		for iter_2_2, iter_2_3 in ipairs(var_2_1) do
			table.insert(var_2_0, iter_2_3)
		end
	end

	if #var_2_0 > 1 then
		table.sort(var_2_0, function(arg_3_0, arg_3_1)
			local var_3_0 = EquipData:GetEquipData(arg_3_0)
			local var_3_1 = EquipData:GetEquipData(arg_3_1)

			if var_3_0.race ~= var_3_1.race and (var_3_0.race == arg_2_0 or var_3_1.race == arg_2_0) then
				return var_3_0.race == arg_2_0 and var_3_1.race ~= arg_2_0
			elseif var_3_0:GetLevel() ~= var_3_1:GetLevel() then
				return var_3_0:GetLevel() > var_3_1:GetLevel()
			elseif var_3_0.race ~= var_3_1.race then
				return var_3_0.race == HeroCfg[arg_2_0].race and var_3_1.race ~= HeroCfg[arg_2_0].race
			else
				local var_3_2 = #var_3_0.enchant[1] + #var_3_0.enchant[2]
				local var_3_3 = #var_3_1.enchant[1] + #var_3_1.enchant[2]

				return var_3_2 ~= 0 and var_3_3 == 0
			end
		end)
	end

	return var_2_0
end

function var_0_0.EquipByEquiptID(arg_4_0, arg_4_1)
	local var_4_0 = var_0_0.GetRecommendEquip(arg_4_0, arg_4_1)

	if var_4_0 then
		HeroAction.EquipSwap(arg_4_0, var_4_0.id, var_4_0.pos)

		return true
	end

	return false
end

function var_0_0.GetRecommendEquip(arg_5_0, arg_5_1)
	local var_5_0 = CultureGravureData:GetEquiptPrefabListByEquiptID(arg_5_1)
	local var_5_1 = HeroData:GetEquipMap()
	local var_5_2 = var_0_0.GetSortedEquipIDByEquipList(arg_5_0, var_5_0)
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_2) do
		local var_5_4 = EquipData:GetEquipData(iter_5_1)

		if not var_5_1[iter_5_1] then
			var_5_3.pos = EquipCfg[var_5_4.prefab_id].pos
			var_5_3.id = iter_5_1

			return var_5_3
		end
	end

	return nil
end

function var_0_0.EquipByList(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0.GetRecommendEquipList(arg_6_0, arg_6_1)

	EquipAction.EquipQuickDressOn(arg_6_0, var_6_0)
end

function var_0_0.GetRecommendEquipList(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = HeroData:GetEquipMap()

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_2 = CultureGravureData:GetEquiptPrefabListByEquiptID(iter_7_1)
		local var_7_3 = var_0_0.GetSortedEquipIDByEquipList(arg_7_0, var_7_2)

		for iter_7_2, iter_7_3 in ipairs(var_7_3) do
			local var_7_4 = EquipData:GetEquipData(iter_7_3)

			if not var_7_1[iter_7_3] or var_7_1[iter_7_3] == arg_7_0 then
				local var_7_5 = EquipCfg[var_7_4.prefab_id].pos

				table.insert(var_7_0, {
					pos = var_7_5,
					equip_id = iter_7_3
				})

				break
			end
		end
	end

	return var_7_0
end

function var_0_0.EquipByServantID(arg_8_0, arg_8_1)
	local var_8_0 = WeaponServantData:GetWeaponServantById(arg_8_1)
	local var_8_1 = ServantTools.GetServantMap()
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not var_8_1[iter_8_1.uid] then
			table.insert(var_8_2, iter_8_1)
		end
	end

	table.sort(var_8_2, function(arg_9_0, arg_9_1)
		if arg_9_0.stage ~= arg_9_1.stage then
			return arg_9_0.stage > arg_9_1.stage
		else
			return arg_9_0.uid < arg_9_1.uid
		end
	end)
	ServantAction.ServantReplace(arg_8_0, var_8_2[1].uid)
end

return var_0_0
