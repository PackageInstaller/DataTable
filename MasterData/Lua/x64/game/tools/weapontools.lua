local var_0_0 = {
	WeaponAtk = function(arg_1_0, arg_1_1)
		return GameSetting.weapon_fixed_attributes.value[arg_1_1 + 1][1] + GameSetting.weapon_fixed_attributes.value[arg_1_1 + 1][2] * (arg_1_0 - 1)
	end,
	ExpToLv = function(arg_2_0)
		local var_2_0

		for iter_2_0 = HeroConst.WEAPON_LV_MAX, 1, -1 do
			if GameLevelSetting[iter_2_0].weapon_lv_exp_sum <= arg_2_0 then
				var_2_0 = iter_2_0

				break
			end
		end

		return var_2_0, nil
	end,
	CurMaxExp = function(arg_3_0)
		return GameLevelSetting[GameSetting.weapon_exp_limit.value[arg_3_0 + 1]].weapon_lv_exp_sum
	end
}

function var_0_0.AddWeaponExp(arg_4_0, arg_4_1, arg_4_2)
	local var_4_2 = 0
	local var_4_3 = false
	local var_4_4 = var_0_0.CurMaxExp(arg_4_1)
	local var_4_5 = arg_4_0 + arg_4_2

	if var_4_4 <= arg_4_0 + arg_4_2 then
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

	if not GameSetting.weapon_break_cost.value[arg_5_0 + 1] then
		print()
	end

	local var_5_1 = EquipMaterialCfg[var_5_0].item_list
	local var_5_2 = 1
	local var_5_3 = {}

	if EquipMaterialCfg[var_5_0].item_list[1][1] == 2 then
		var_5_2 = var_5_1[1][2]
	end

	for iter_5_0 = 2, #var_5_1 do
		var_5_3[iter_5_0 - 1] = deepClone(var_5_1[iter_5_0])
	end

	return var_5_2, var_5_3
end

function var_0_0.CalWeaponAttribute(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1 = 1

	if arg_6_2 and arg_6_2.id and arg_6_2.id ~= 0 then
		if WeaponServantCfg[arg_6_2.id] then
			var_6_1 = WeaponServantCfg[arg_6_2.id].attrib_addition * 0.01 + 1
			var_6_0[WeaponServantCfg[arg_6_2.id].attribute[1]] = WeaponServantCfg[arg_6_2.id].attribute[2]
		end
	end

	var_6_0[1] = (GameSetting.weapon_fixed_attributes.value[arg_6_1.breakthrough + 1][1] + GameSetting.weapon_fixed_attributes.value[arg_6_1.breakthrough + 1][2] * (var_0_0.ExpToLv(arg_6_1.exp) - 1)) * var_6_1 + (var_6_0[1] or 0)
	var_6_0[HeroCfg[arg_6_0].weapon_break_attribute[arg_6_1.breakthrough + 1][1]] = HeroCfg[arg_6_0].weapon_break_attribute[arg_6_1.breakthrough + 1][2] + (var_6_0[HeroCfg[arg_6_0].weapon_break_attribute[arg_6_1.breakthrough + 1][1]] or 0)

	return var_6_0
end

function var_0_0.GetWeaponModuleDes(arg_7_0, arg_7_1)
	local var_7_0 = getWeaponServantAffectByModule(arg_7_0)

	return string.format(GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_4"), ItemTools.getItemName(var_7_0), GetCfgDescription(WeaponEffectCfg[WeaponServantCfg[var_7_0].effect[1]].strengthen_description[2], 1, nil, nil, arg_7_1))
end

function var_0_0:QuickSelectList(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_2
	local var_8_1 = {}
	local var_8_2 = {}

	for iter_8_0 = 1, #self do
		table.insert(var_8_1, {
			num = 0,
			id = self[iter_8_0].id
		})
	end

	local var_8_3 = {}

	for iter_8_1 = 1, #self do
		var_8_3[iter_8_1] = math.max(math.min(math.ceil(var_8_0 / ItemCfg[self[iter_8_1].id].param[1]), self[iter_8_1].number), 0)
		var_8_0 = var_8_0 - var_8_3[iter_8_1] * ItemCfg[self[iter_8_1].id].param[1]

		if var_8_0 < 0 and iter_8_1 > 1 then
			local var_8_4 = -var_8_0

			for iter_8_2 = iter_8_1 - 1, 1, -1 do
				local var_8_5 = math.min(var_8_3[iter_8_2], (math.modf(var_8_4 / ItemCfg[self[iter_8_2].id].param[1])))

				var_8_3[iter_8_2] = math.max(0, var_8_3[iter_8_2] - var_8_5)
				var_8_4 = var_8_4 - ItemCfg[self[iter_8_2].id].param[1] * var_8_5
				var_8_0 = var_8_0 + ItemCfg[self[iter_8_2].id].param[1] * var_8_5
			end
		end

		if var_8_0 <= 0 then
			break
		end
	end

	for iter_8_3 = 1, #self do
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
		local var_8_6 = arg_8_1[iter_8_5]

		if not (ItemCfg[arg_8_1[iter_8_5].id].rare >= 4 or var_8_6.number ~= 1) then
			if var_8_0 > 0 then
				table.insert(var_8_2, var_8_6.uid)

				var_8_0 = var_8_0 - GameSetting.base_exp_weapon_servant.value[ItemCfg[var_8_6.id].rare]
			end
		end
	end

	if var_8_0 > 0 then
		local var_8_7 = var_8_0
		local var_8_8 = {}

		for iter_8_6, iter_8_7 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
			if ItemCfg[iter_8_7].sub_type == MaterialConst.MATERIAL_TYPE.WEAPON_LEVEL_UP then
				table.insert(var_8_8, {
					num = 0,
					id = iter_8_7,
					exp = ItemCfg[iter_8_7].param[1]
				})
			end
		end

		table.sort(var_8_8, function(arg_9_0, arg_9_1)
			return arg_9_0.exp > arg_9_1.exp
		end)

		for iter_8_8 = 1, #var_8_8 do
			while var_8_7 >= var_8_8[iter_8_8].exp do
				var_8_8[iter_8_8].num = var_8_8[iter_8_8].num + 1
				var_8_7 = var_8_7 - var_8_8[iter_8_8].exp
			end

			if var_8_7 <= 0 then
				break
			end
		end

		if var_8_7 > 0 then
			var_8_8[#var_8_8].num = var_8_8[#var_8_8].num + 1
		end

		for iter_8_9 = #var_8_8, 1, -1 do
			if var_8_8[iter_8_9].num <= 0 then
				table.remove(var_8_8, iter_8_9)
			end
		end

		table.sort(var_8_8, function(arg_10_0, arg_10_1)
			return arg_10_0.exp < arg_10_1.exp
		end)

		var_8_1 = WeaponTools.MergeMaterialListByName(var_8_1, var_8_8)
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

	return ItemTools.getItemName(var_13_0[var_13_1].id), (math.ceil(arg_13_0 / var_13_0[var_13_1].exp))
end

function var_0_0.GetServantByUid(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0) do
		if iter_15_1.uid == arg_15_1 then
			return iter_15_1
		end
	end
end

return var_0_0
