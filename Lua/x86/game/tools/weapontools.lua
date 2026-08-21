local var_0_0 = {
	WeaponAtk = function(arg_1_0, arg_1_1)
		local var_1_0 = GameSetting.weapon_fixed_attributes.value[arg_1_1 + 1]

		return var_1_0[1] + var_1_0[2] * (arg_1_0 - 1)
	end,
	ExpToLv = function(arg_2_0)
		local var_2_0
		local var_2_1
		local var_2_2 = 0

		for iter_2_0 = HeroConst.WEAPON_LV_MAX, 1, -1 do
			local var_2_3 = GameLevelSetting[iter_2_0].weapon_lv_exp_sum

			if var_2_3 <= arg_2_0 then
				var_2_0 = iter_2_0
				var_2_1 = arg_2_0 - var_2_3

				break
			end
		end

		return var_2_0, var_2_1
	end,
	CurMaxExp = function(arg_3_0)
		local var_3_0
		local var_3_1 = GameSetting.weapon_exp_limit.value[arg_3_0 + 1]

		return GameLevelSetting[var_3_1].weapon_lv_exp_sum
	end
}

function var_0_0.AddWeaponExp(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 0
	local var_4_1 = 0
	local var_4_2 = 0
	local var_4_3 = false
	local var_4_4 = var_0_0.CurMaxExp(arg_4_1)
	local var_4_5 = arg_4_0 + arg_4_2

	if var_4_4 <= var_4_5 then
		var_4_2 = var_4_5 - var_4_4
		var_4_5 = var_4_4
		var_4_3 = true
	end

	local var_4_6, var_4_7 = WeaponTools.ExpToLv(var_4_5)

	return var_4_7, var_4_6, var_4_2, var_4_3
end

function var_0_0.BreakMaterial(arg_5_0)
	if arg_5_0 >= 4 then
		return 0, {}
	end

	local var_5_0 = GameSetting.weapon_break_cost.value[arg_5_0 + 1]

	if not var_5_0 then
		print()
	end

	local var_5_1 = EquipMaterialCfg[var_5_0].item_list
	local var_5_2 = 1
	local var_5_3 = {}

	if var_5_1[1][1] == 2 then
		var_5_2 = var_5_1[1][2]
	end

	for iter_5_0 = 2, #var_5_1 do
		var_5_3[iter_5_0 - 1] = deepClone(var_5_1[iter_5_0])
	end

	return var_5_2, var_5_3
end

function var_0_0.CalWeaponAttribute(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1 = var_0_0.ExpToLv(arg_6_1.exp)
	local var_6_2 = GameSetting.weapon_fixed_attributes.value[arg_6_1.breakthrough + 1]
	local var_6_3 = 1

	if arg_6_2 and arg_6_2.id and arg_6_2.id ~= 0 then
		local var_6_4 = WeaponServantCfg[arg_6_2.id]

		if var_6_4 then
			var_6_3 = var_6_4.attrib_addition * 0.01 + 1
			var_6_0[var_6_4.attribute[1]] = var_6_4.attribute[2]
		end
	end

	var_6_0[1] = (var_6_2[1] + var_6_2[2] * (var_6_1 - 1)) * var_6_3 + (var_6_0[1] or 0)

	local var_6_5 = HeroCfg[arg_6_0].weapon_break_attribute[arg_6_1.breakthrough + 1]

	var_6_0[var_6_5[1]] = var_6_5[2] + (var_6_0[var_6_5[1]] or 0)

	return var_6_0
end

function var_0_0.GetWeaponModuleDes(arg_7_0, arg_7_1)
	local var_7_0 = getWeaponServantAffectByModule(arg_7_0)
	local var_7_1 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_4")
	local var_7_2 = WeaponServantCfg[var_7_0].effect[1]

	return string.format(var_7_1, ItemTools.getItemName(var_7_0), GetCfgDescription(WeaponEffectCfg[var_7_2].strengthen_description[2], 1, nil, nil, arg_7_1))
end

function var_0_0.QuickSelectList(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2
	local var_8_1 = {}
	local var_8_2 = {}

	for iter_8_0 = 1, #arg_8_0 do
		table.insert(var_8_1, {
			num = 0,
			id = arg_8_0[iter_8_0].id
		})
	end

	local var_8_3 = {}

	for iter_8_1 = 1, #arg_8_0 do
		local var_8_4 = arg_8_0[iter_8_1]
		local var_8_5 = ItemCfg[var_8_4.id].param[1]

		var_8_3[iter_8_1] = math.max(math.min(math.ceil(var_8_0 / var_8_5), var_8_4.number), 0)
		var_8_0 = var_8_0 - var_8_3[iter_8_1] * var_8_5

		if var_8_0 < 0 and iter_8_1 > 1 then
			local var_8_6 = -var_8_0

			for iter_8_2 = iter_8_1 - 1, 1, -1 do
				local var_8_7 = arg_8_0[iter_8_2]
				local var_8_8 = ItemCfg[var_8_7.id].param[1]
				local var_8_9 = math.modf(var_8_6 / var_8_8)
				local var_8_10 = math.min(var_8_3[iter_8_2], var_8_9)

				var_8_3[iter_8_2] = math.max(0, var_8_3[iter_8_2] - var_8_10)
				var_8_6 = var_8_6 - var_8_8 * var_8_10
				var_8_0 = var_8_0 + var_8_8 * var_8_10
			end
		end

		if var_8_0 <= 0 then
			break
		end
	end

	for iter_8_3 = 1, #arg_8_0 do
		if var_8_3[iter_8_3] == nil then
			var_8_3[iter_8_3] = 0
		end

		var_8_1[iter_8_3].num = var_8_3[iter_8_3]
	end

	for iter_8_4 = #var_8_1, 1, -1 do
		if var_8_1[iter_8_4].num == 0 then
			table.remove(var_8_1, iter_8_4)
		end
	end

	for iter_8_5 = 1, #arg_8_1 do
		local var_8_11 = arg_8_1[iter_8_5]

		if not (ItemCfg[var_8_11.id].rare >= 4 or var_8_11.number ~= 1) then
			local var_8_12 = ItemCfg[var_8_11.id].rare
			local var_8_13 = GameSetting.base_exp_weapon_servant.value[var_8_12]

			if var_8_0 > 0 then
				table.insert(var_8_2, var_8_11.uid)

				var_8_0 = var_8_0 - var_8_13
			end
		end
	end

	if var_8_0 > 0 then
		local var_8_14 = var_8_0
		local var_8_15 = {}

		for iter_8_6, iter_8_7 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
			if ItemCfg[iter_8_7].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP then
				table.insert(var_8_15, {
					num = 0,
					id = iter_8_7,
					exp = ItemCfg[iter_8_7].param[1]
				})
			end
		end

		table.sort(var_8_15, function(arg_9_0, arg_9_1)
			return arg_9_0.exp > arg_9_1.exp
		end)

		for iter_8_8 = 1, #var_8_15 do
			while var_8_14 >= var_8_15[iter_8_8].exp do
				var_8_15[iter_8_8].num = var_8_15[iter_8_8].num + 1
				var_8_14 = var_8_14 - var_8_15[iter_8_8].exp
			end

			if var_8_14 <= 0 then
				break
			end
		end

		if var_8_14 > 0 then
			var_8_15[#var_8_15].num = var_8_15[#var_8_15].num + 1
		end

		for iter_8_9 = #var_8_15, 1, -1 do
			if var_8_15[iter_8_9].num <= 0 then
				table.remove(var_8_15, iter_8_9)
			end
		end

		table.sort(var_8_15, function(arg_10_0, arg_10_1)
			return arg_10_0.exp < arg_10_1.exp
		end)

		var_8_1 = WeaponTools.MergeMaterialListByName(var_8_1, var_8_15)
	end

	return var_8_1, var_8_2, arg_8_2 - var_8_0
end

function var_0_0.MergeMaterialList(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_0 = false

		for iter_11_2, iter_11_3 in ipairs(arg_11_0) do
			if iter_11_3[1] == iter_11_1[1] then
				iter_11_3[2] = iter_11_1[2] + iter_11_3[2]
				var_11_0 = true

				break
			end
		end

		if var_11_0 == false then
			table.insert(arg_11_0, iter_11_1)
		end
	end

	return arg_11_0
end

function var_0_0.MergeMaterialListByName(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_0 = false

		for iter_12_2, iter_12_3 in ipairs(arg_12_0) do
			if iter_12_3.id == iter_12_1.id then
				iter_12_3.num = iter_12_1.num + iter_12_3.num
				var_12_0 = true

				break
			end
		end

		if var_12_0 == false then
			table.insert(arg_12_0, iter_12_1)
		end
	end

	return arg_12_0
end

function var_0_0.GetMaterialAndNum(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		if ItemCfg[iter_13_1].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP then
			table.insert(var_13_0, {
				id = iter_13_1,
				exp = ItemCfg[iter_13_1].param[1]
			})
		end
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.exp > arg_14_1.exp
	end)

	local var_13_1 = 1

	for iter_13_2 = 1, #var_13_0 do
		if arg_13_0 >= var_13_0[iter_13_2].exp then
			var_13_1 = iter_13_2

			break
		end
	end

	local var_13_2 = ItemTools.getItemName(var_13_0[var_13_1].id)
	local var_13_3 = math.ceil(arg_13_0 / var_13_0[var_13_1].exp)

	return var_13_2, var_13_3
end

function var_0_0.GetServantByUid(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0) do
		if iter_15_1.uid == arg_15_1 then
			return iter_15_1
		end
	end
end

return var_0_0
