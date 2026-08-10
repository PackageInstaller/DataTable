local var_0_0 = {}
local var_0_1 = import("bit")

function var_0_0.GetAllSuits()
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(EquipSuitCfg.get_id_list_by_suit) do
		table.insert(var_1_0, iter_1_0)
	end

	return var_1_0
end

function var_0_0.GetEquipNum()
	local var_2_0 = 0
	local var_2_1 = EquipData:GetEquipList()

	for iter_2_0, iter_2_1 in pairs(var_2_1) do
		var_2_0 = var_2_0 + 1
	end

	return var_2_0
end

function var_0_0.GetEquipListByPrefabId(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = EquipData:GetEquipList()

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		if iter_3_1.prefab_id == arg_3_0 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_0.GetEquipListByEquipid(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = EquipData:GetEquipList()

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		local var_4_2 = EquipCfg[arg_4_0]
		local var_4_3 = EquipCfg[iter_4_1.prefab_id]

		if var_4_3.pos == var_4_2.pos and var_4_3.suit == var_4_2.suit and var_4_3.starlevel == var_4_2.starlevel then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function var_0_0.GetHaveSuitList(arg_5_0)
	local var_5_0 = EquipData:GetEquipList()
	local var_5_1 = {}
	local var_5_2 = HideInfoData:GetEquipSuitHideList()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_3 = EquipCfg[iter_5_1.prefab_id]

		if not var_5_2[var_5_3.suit] then
			var_5_1[var_5_3.suit] = true
		end
	end

	local var_5_4 = {}

	for iter_5_2, iter_5_3 in pairs(var_5_1) do
		table.insert(var_5_4, tonumber(iter_5_2))
	end

	if arg_5_0 then
		for iter_5_4, iter_5_5 in ipairs(EquipSuitCfg.all) do
			if not var_5_1[iter_5_5] and not var_5_2[iter_5_5] then
				table.insert(var_5_4, iter_5_5)
			end
		end
	end

	return var_5_4, var_5_1
end

function var_0_0.GetIsHaveExEquip()
	local var_6_0 = EquipData:GetEquipList()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		if EquipCfg[iter_6_1.prefab_id].suit >= EquipConst.EX_EQUIP_SUIT_ID then
			return true
		end
	end

	return false
end

function var_0_0.IsHaveEquip(arg_7_0)
	local var_7_0 = EquipData:GetEquipList()
	local var_7_1 = {}
	local var_7_2 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		var_7_2[iter_7_1] = false
	end

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		if table.indexof(arg_7_0, iter_7_3.prefab_id) then
			var_7_2[iter_7_3.prefab_id] = true
		end
	end

	return var_7_2
end

function var_0_0.GetFreeEquipByEquipId(arg_8_0, arg_8_1)
	local var_8_0 = HeroTools.GetEquipMap(HeroData:GetHeroList())
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = false
	local var_8_4 = false

	for iter_8_0, iter_8_1 in pairs(EquipData:GetEquipList()) do
		local var_8_5 = iter_8_1.prefab_id
		local var_8_6 = iter_8_1.equip_id
		local var_8_7 = false
		local var_8_8

		for iter_8_2, iter_8_3 in ipairs(arg_8_0) do
			if EquipTools.IsSameEquip(iter_8_3, var_8_5) then
				var_8_7 = true
				var_8_8 = iter_8_3

				break
			end
		end

		if var_8_7 then
			if not var_8_2[var_8_8] then
				var_8_2[var_8_8] = {}
			end

			table.insert(var_8_2[var_8_8], iter_8_1)

			var_8_4 = true

			if var_8_0[var_8_6] == nil or var_8_0[var_8_6] == arg_8_1 then
				if not var_8_1[var_8_8] then
					var_8_1[var_8_8] = {}
				end

				table.insert(var_8_1[var_8_8], iter_8_1)

				var_8_3 = true
			end
		end
	end

	return var_8_1, var_8_2, var_8_3, var_8_4, var_8_0
end

function var_0_0.IsSameEquip(arg_9_0, arg_9_1)
	local var_9_0 = EquipCfg[arg_9_0]
	local var_9_1 = EquipCfg[arg_9_1]

	if var_9_0.pos == var_9_1.pos and var_9_0.starlevel == var_9_1.starlevel and var_9_0.suit == var_9_1.suit then
		return true
	end

	return false
end

function var_0_0.GetHaveSkillList(arg_10_0)
	local var_10_0 = EquipData:GetEquipList()
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_2 = EquipCfg[iter_10_1.prefab_id]

		for iter_10_2, iter_10_3 in ipairs(var_10_2.effect) do
			if iter_10_3[1] then
				var_10_1[iter_10_3[1]] = true
			end
		end

		for iter_10_4, iter_10_5 in pairs(iter_10_1.enchant) do
			for iter_10_6, iter_10_7 in ipairs(iter_10_5) do
				if iter_10_7 and iter_10_7.id then
					var_10_1[iter_10_7.id] = true
				end
			end
		end
	end

	local var_10_3 = {}

	for iter_10_8, iter_10_9 in pairs(var_10_1) do
		table.insert(var_10_3, tonumber(iter_10_8))
	end

	if arg_10_0 then
		for iter_10_10, iter_10_11 in ipairs(EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]) do
			if not var_10_1[iter_10_11] then
				table.insert(var_10_3, iter_10_11)
			end
		end
	end

	return var_10_3
end

function var_0_0.GetHeroEquipSuitPos(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = 0

	if arg_11_0 and arg_11_0 ~= 0 then
		local var_11_2 = HeroData:GetHeroList()[arg_11_0]
		local var_11_3 = EquipData:GetEquipList()

		for iter_11_0, iter_11_1 in pairs(var_11_2.equip) do
			local var_11_4 = iter_11_1.equip_id

			if var_11_4 and var_11_4 ~= 0 then
				local var_11_5 = var_11_3[var_11_4].prefab_id
				local var_11_6 = EquipCfg[var_11_5]

				if var_11_6.suit == arg_11_1 then
					var_11_0[var_11_6.pos] = true
					var_11_1 = var_11_1 + 1
				end
			end
		end
	elseif arg_11_2 then
		var_11_0[arg_11_2] = true
		var_11_1 = var_11_1 + 1
	end

	return var_11_0, var_11_1
end

function var_0_0.GetEquipedHeroId(arg_12_0)
	local var_12_0 = HeroData:GetHeroList()

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		for iter_12_2, iter_12_3 in pairs(iter_12_1.equip) do
			if iter_12_3.equip_id == arg_12_0 then
				return iter_12_0
			end
		end
	end

	return 0
end

function var_0_0.CountActiveSuit(arg_13_0)
	local var_13_0 = EquipData:GetEquipList()
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0) do
		if iter_13_1.equip_id ~= 0 then
			local var_13_2

			if iter_13_1.prefab_id then
				var_13_2 = iter_13_1.prefab_id
			else
				var_13_2 = var_13_0[iter_13_1.equip_id].prefab_id
			end

			local var_13_3 = EquipCfg[var_13_2]

			if var_13_1[var_13_3.suit] then
				var_13_1[var_13_3.suit].num = var_13_1[var_13_3.suit].num + 1
				var_13_1[var_13_3.suit].pos[var_13_3.pos] = true
			else
				var_13_1[var_13_3.suit] = {
					num = 1,
					id = var_13_3.suit,
					pos = {
						[var_13_3.pos] = true
					}
				}
			end
		end
	end

	local var_13_4 = {}

	for iter_13_2, iter_13_3 in pairs(var_13_1) do
		table.insert(var_13_4, iter_13_3)
	end

	return var_13_4
end

function var_0_0.GetSuitEquiptCount(arg_14_0, arg_14_1)
	local var_14_0 = 0
	local var_14_1 = var_0_0.CountActiveSuit(arg_14_0)

	for iter_14_0, iter_14_1 in pairs(var_14_1) do
		if iter_14_1.id == arg_14_1 then
			var_14_0 = iter_14_1.num

			break
		end
	end

	return var_14_0
end

function var_0_0.GetSuitNeedNum(arg_15_0, arg_15_1)
	local var_15_0 = EquipSuitCfg[arg_15_0]

	if var_15_0.need < 3 or not arg_15_1 then
		return var_15_0.need
	else
		return var_15_0.need - 1
	end
end

function var_0_0.CountHeroTotalSkill(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0) do
		if iter_16_1.equip_id and iter_16_1.equip_id ~= 0 then
			local var_16_2 = EquipCfg[iter_16_1.prefab_id]
			local var_16_3 = var_0_0.CountEquipLevel(iter_16_1)
			local var_16_4 = {}

			for iter_16_2 = 1, #var_16_2.effect do
				local var_16_5 = var_16_2.effect[iter_16_2]

				if var_16_5 and var_16_3 >= var_16_2.effect_unlock_level[iter_16_2] then
					local var_16_6 = var_16_5[1]

					var_16_0[var_16_6] = (var_16_0[var_16_6] or 0) + var_16_5[2]
					var_16_4[var_16_6] = (var_16_4[var_16_6] or 0) + var_16_5[2]
				end
			end

			for iter_16_3, iter_16_4 in pairs(iter_16_1.enchant) do
				for iter_16_5, iter_16_6 in ipairs(iter_16_4) do
					if iter_16_6 and iter_16_6.id then
						local var_16_7 = iter_16_6.id

						var_16_0[var_16_7] = (var_16_0[var_16_7] or 0) + iter_16_6.num
						var_16_4[var_16_7] = (var_16_4[var_16_7] or 0) + iter_16_6.num
					end
				end
			end

			for iter_16_7, iter_16_8 in pairs(var_16_4) do
				var_16_1[iter_16_7] = var_16_1[iter_16_7] or {}

				local var_16_8 = {
					isEquip = true,
					id = iter_16_1.equip_id,
					level = iter_16_8,
					prefab_id = iter_16_1.prefab_id
				}

				table.insert(var_16_1[iter_16_7], var_16_8)
			end
		end
	end

	local var_16_9 = HeroTools.GetHeroEquipSkillAddLevel(arg_16_1)

	for iter_16_9, iter_16_10 in pairs(var_16_0) do
		var_16_0[iter_16_9] = iter_16_10 + var_16_9

		if var_16_9 ~= 0 then
			table.insert(var_16_1[iter_16_9], {
				isEquip = false,
				level = var_16_9
			})
		end
	end

	if not arg_16_2 then
		for iter_16_11, iter_16_12 in pairs(var_16_0) do
			local var_16_10 = EquipSkillCfg[iter_16_11]

			if iter_16_12 > var_16_10.lvmax then
				var_16_0[iter_16_11] = var_16_10.lvmax
			end
		end
	end

	return var_16_0, var_16_9 > 0, var_16_1
end

function var_0_0.CountEquipAttribute(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = EquipCfg[arg_17_0.prefab_id]
	local var_17_2 = var_0_0.CountEquipLevel(arg_17_0)
	local var_17_3 = arg_17_0.now_break_level + 1
	local var_17_4 = false
	local var_17_5 = false

	if arg_17_2 and arg_17_0.race ~= 0 then
		local var_17_6 = HeroCfg[arg_17_2]

		if arg_17_0.race == var_17_6.race then
			var_17_4 = true
		end

		if arg_17_0.race == arg_17_2 then
			var_17_5 = true
		end
	end

	local var_17_7 = var_17_1.fixed_attributes[var_17_3]

	for iter_17_0, iter_17_1 in pairs(var_17_7) do
		local var_17_8 = iter_17_1[1]

		var_17_0[var_17_8] = iter_17_1[2] + iter_17_1[3] * (var_17_2 - 1)

		if var_17_4 then
			var_17_0[var_17_8] = var_17_0[var_17_8] * 1.2
		end

		if var_17_5 then
			local var_17_9 = GameSetting.equip_hero_strengthen_num.value[1]

			var_17_0[var_17_8] = var_17_0[var_17_8] * var_17_9
		end
	end

	if arg_17_1 then
		for iter_17_2 = 1, #var_17_1.effect do
			local var_17_10 = var_17_1.effect[iter_17_2]

			if var_17_10 and var_17_2 >= var_17_1.effect_unlock_level[iter_17_2] then
				local var_17_11 = EquipSkillCfg[var_17_10[1]]
				local var_17_12 = var_17_11.upgrade * var_17_10[2]
				local var_17_13 = var_17_11.attribute

				var_17_0[var_17_13] = (var_17_0[var_17_13] or 0) + var_17_12
			end
		end

		if arg_17_0.enchant then
			for iter_17_3, iter_17_4 in pairs(arg_17_0.enchant) do
				for iter_17_5, iter_17_6 in ipairs(iter_17_4) do
					if iter_17_6 and iter_17_6.id then
						local var_17_14 = EquipSkillCfg[iter_17_6.id]
						local var_17_15 = var_17_14.upgrade * iter_17_6.num
						local var_17_16 = var_17_14.attribute

						var_17_0[var_17_16] = (var_17_0[var_17_16] or 0) + var_17_15
					end
				end
			end
		end
	end

	return var_17_0
end

function var_0_0.CountEquipMaxLv(arg_18_0)
	return EquipCfg[arg_18_0.prefab_id].max_level[arg_18_0.now_break_level + 1]
end

function var_0_0.CountEquipMaxLvWitnoutBreak(arg_19_0)
	local var_19_0 = EquipCfg[arg_19_0.prefab_id]

	return var_19_0.max_level[#var_19_0.max_level]
end

function var_0_0.CountEquipLevel(arg_20_0)
	local var_20_0 = arg_20_0.exp or 0
	local var_20_1 = var_0_0.CountEquipMaxLv(arg_20_0)
	local var_20_2 = EquipCfg[arg_20_0.prefab_id]
	local var_20_3 = "exp" .. var_20_2.starlevel

	for iter_20_0 = 1, var_20_1 - 1 do
		local var_20_4 = EquipExpCfg[iter_20_0][var_20_3]

		if var_20_0 < var_20_4 then
			return iter_20_0
		end

		var_20_0 = var_20_0 - var_20_4
	end

	return var_20_1
end

function var_0_0.CountSingleEquipAttribute(arg_21_0, arg_21_1)
	local var_21_0 = EquipCfg[arg_21_0.prefab_id]
	local var_21_1 = var_0_0.CountEquipLevel(arg_21_0)
	local var_21_2 = arg_21_0.now_break_level + 1
	local var_21_3 = var_21_0.fixed_attributes[var_21_2]

	for iter_21_0, iter_21_1 in ipairs(var_21_3) do
		if iter_21_1[1] == arg_21_1 then
			return iter_21_1[2] + iter_21_1[3] * (var_21_1 - 1)
		end
	end

	return 0
end

function var_0_0.CalHeroVirtualEquipAttribute(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = {
		0,
		0,
		0,
		0
	}

	for iter_22_0, iter_22_1 in pairs(arg_22_0) do
		if iter_22_1.prefab_id ~= 0 then
			for iter_22_2, iter_22_3 in pairs(var_0_0.CountEquipAttribute(iter_22_1, false, arg_22_1.id)) do
				if var_22_0[iter_22_2] == nil then
					var_22_0[iter_22_2] = 0
				end

				var_22_0[iter_22_2] = var_22_0[iter_22_2] + iter_22_3
			end
		end
	end

	if not arg_22_2 then
		local var_22_1 = var_0_0.CountHeroTotalSkill(arg_22_0, arg_22_1)

		for iter_22_4, iter_22_5 in pairs(var_22_1) do
			local var_22_2 = EquipSkillCfg[iter_22_4]
			local var_22_3 = var_22_2.upgrade * iter_22_5
			local var_22_4 = var_22_2.attribute

			var_22_0[var_22_4] = (var_22_0[var_22_4] or 0) + var_22_3
		end
	end

	return var_22_0
end

function var_0_0.GetHeroEquipS(arg_23_0)
	local var_23_0 = HeroData:GetHeroList()[arg_23_0]
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in pairs(var_23_0.equip) do
		var_23_1[iter_23_1.pos] = EquipData:GetEquipList()[iter_23_1.equip_id]
	end

	return var_23_1
end

function var_0_0.GetEquipDataList(arg_24_0)
	local var_24_0 = {}

	for iter_24_0 = 1, 6 do
		local var_24_1

		if arg_24_0[iter_24_0].equip_id ~= 0 then
			var_24_1 = EquipData:GetEquipData(arg_24_0[iter_24_0].equip_id)
		end

		var_24_0[iter_24_0] = var_24_1
	end

	return var_24_0
end

function var_0_0.GetEffectS(arg_25_0, arg_25_1)
	local var_25_0 = {}
	local var_25_1 = false

	if arg_25_1 then
		var_25_1 = HeroTools.GetIsSuitNumCut(arg_25_1)
	end

	local var_25_2 = {}

	for iter_25_0, iter_25_1 in pairs(arg_25_0) do
		local var_25_3 = EquipCfg[iter_25_1.prefab_id].suit

		if var_25_2[var_25_3] == nil then
			var_25_2[var_25_3] = 0
		end

		var_25_2[var_25_3] = var_25_2[var_25_3] + 1
	end

	for iter_25_2, iter_25_3 in pairs(var_25_2) do
		local var_25_4 = EquipSuitCfg.get_id_list_by_suit[iter_25_2]

		for iter_25_4, iter_25_5 in ipairs(var_25_4) do
			local var_25_5 = EquipSuitCfg[iter_25_5]

			if iter_25_3 >= var_0_0.GetSuitNeedNum(iter_25_5, var_25_1) and var_25_5.suit_effect then
				for iter_25_6, iter_25_7 in pairs(var_25_5.suit_effect) do
					var_25_0[iter_25_7] = true
				end
			end
		end
	end

	return var_25_0
end

function var_0_0.GetDecomposeRewardItem(arg_26_0)
	local var_26_0 = {}
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0) do
		local var_26_2 = EquipCfg[iter_26_1.prefab_id].starlevel
		local var_26_3 = (iter_26_1.exp * 0.8 or 0) + var_0_0.CountBreakExp(iter_26_1) + GameSetting.base_exp_equip_star.value[var_26_2]
		local var_26_4 = GameSetting.equip_exp_props_id_list.value
		local var_26_5 = {
			var_26_4[3],
			var_26_4[2],
			var_26_4[1]
		}

		for iter_26_2 = 1, #var_26_5 do
			local var_26_6 = var_26_5[iter_26_2]
			local var_26_7 = ItemCfg[var_26_6].param[1]

			if var_26_7 <= var_26_3 then
				local var_26_8 = math.floor(var_26_3 / var_26_7)

				var_26_0[var_26_6] = (var_26_0[var_26_6] or 0) + var_26_8
				var_26_3 = var_26_3 - var_26_7 * var_26_8
			end
		end

		local var_26_9 = EquipData:GetEquipData(iter_26_0):GetBreakCostReturn()

		for iter_26_3, iter_26_4 in pairs(var_26_9) do
			local var_26_10 = iter_26_4[1] or 0
			local var_26_11 = iter_26_4[2] or 0

			var_26_0[var_26_10] = (var_26_0[var_26_10] or 0) + var_26_11
		end
	end

	for iter_26_5, iter_26_6 in pairs(var_26_0) do
		if iter_26_6 > 0 then
			table.insert(var_26_1, {
				id = iter_26_5,
				number = iter_26_6
			})
		end
	end

	return var_26_1
end

function var_0_0.CountNeedExp(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = 0
	local var_27_1 = EquipCfg[arg_27_0.prefab_id]
	local var_27_2 = "exp" .. var_27_1.starlevel

	for iter_27_0 = 1, arg_27_1 - 1 do
		var_27_0 = var_27_0 + EquipExpCfg[iter_27_0][var_27_2]
	end

	return var_27_0
end

function var_0_0.CountMinAddLevel(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.exp + arg_28_1
	local var_28_1 = EquipCfg[arg_28_0.prefab_id]
	local var_28_2 = var_0_0.CountEquipMaxLvWitnoutBreak(arg_28_0)
	local var_28_3 = "exp_sum_" .. arg_28_0.star

	for iter_28_0 = 2, var_28_2 do
		if var_28_0 < EquipExpCfg[iter_28_0][var_28_3] then
			return iter_28_0 - 1
		end
	end

	return 1
end

function var_0_0.CalculateCultueLevel(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0:GetLevel()
	local var_29_1 = arg_29_0.now_break_level
	local var_29_2 = EquipCfg[arg_29_0.prefab_id]
	local var_29_3 = var_0_0.CountEquipMaxLvWitnoutBreak(arg_29_0)
	local var_29_4 = arg_29_2 or var_29_3
	local var_29_5 = arg_29_0.exp - EquipExpCfg[var_29_0]["exp_sum_" .. var_29_2.starlevel]
	local var_29_6 = "exp" .. var_29_2.starlevel

	arg_29_1 = arg_29_1 + var_29_5

	local var_29_7 = var_29_0
	local var_29_8 = 0
	local var_29_9 = 0
	local var_29_10 = var_29_0 + 1
	local var_29_11 = {}
	local var_29_12 = false
	local var_29_13 = false
	local var_29_14

	for iter_29_0 = var_29_0 + 1, var_29_4 do
		local var_29_15 = false

		if iter_29_0 % 10 == 0 and var_29_1 <= var_29_2.break_times_max or arg_29_3 then
			if iter_29_0 >= 40 and (arg_29_0.race == 0 or table.keyof(RaceEffectCfg.all, arg_29_0.race) ~= nil) then
				var_29_15 = true
			end

			var_29_1 = var_29_1 + 1

			local var_29_16 = var_29_2.break_cost[var_29_1]

			if var_29_16 then
				local var_29_17 = EquipMaterialCfg[var_29_16]
				local var_29_18 = false

				for iter_29_1 = 2, #var_29_17.item_list do
					local var_29_19 = var_29_17.item_list[iter_29_1]
					local var_29_20 = var_29_19[1]
					local var_29_21 = var_29_19[2]

					var_29_11[var_29_20] = (var_29_11[var_29_20] and var_29_11[var_29_20] or 0) + var_29_21

					if var_29_11[var_29_20] > ItemTools.getItemNum(var_29_20) then
						var_29_18 = true
					end
				end

				if var_29_18 then
					var_29_15 = true
				else
					var_29_9 = var_29_9 + var_29_17.item_list[1][2]
					var_29_10 = arg_29_3 and iter_29_0 - 1 or iter_29_0
				end
			end

			arg_29_3 = false
		end

		local var_29_22 = EquipExpCfg[iter_29_0 - 1][var_29_6]

		if var_29_5 > 0 then
			var_29_22 = var_29_22 - var_29_5
			var_29_5 = 0
		end

		if arg_29_1 < var_29_22 then
			var_29_12 = true
			var_29_14 = var_29_14 or iter_29_0 - 1
			var_29_15 = true
		else
			var_29_8 = var_29_8 + math.floor(var_29_22 * GameSetting.equip_strengthen_gold_cost.value[1])
			arg_29_1 = arg_29_1 - var_29_22
			var_29_14 = iter_29_0
		end

		if not arg_29_2 then
			if var_29_10 < iter_29_0 then
				var_29_8 = var_29_8 + var_29_9
				var_29_9 = 0
			end

			if var_29_8 > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
				var_29_13 = true
				var_29_15 = true
			end

			if var_29_15 then
				var_29_7 = (var_29_12 or var_29_13) and iter_29_0 - 1 or iter_29_0

				break
			end
		end

		var_29_7 = iter_29_0
	end

	local var_29_23 = math.max(var_29_0 + 1, var_29_7)

	return {
		maxLevel = var_29_23,
		expMaxLevel = var_29_14
	}
end

function var_0_0.GetLockedEquipS()
	local var_30_0 = {}
	local var_30_1 = EquipData:GetEquipList()

	for iter_30_0, iter_30_1 in pairs(var_30_1) do
		if iter_30_1.is_lock and iter_30_1.is_lock == 1 then
			table.insert(var_30_0, iter_30_1.equip_id)
		end
	end

	return var_30_0
end

function var_0_0.GetHeroUsedEquipS()
	local var_31_0 = {}
	local var_31_1 = HeroData:GetHeroList()

	for iter_31_0, iter_31_1 in pairs(var_31_1) do
		if iter_31_1.equip then
			for iter_31_2, iter_31_3 in pairs(iter_31_1.equip) do
				if iter_31_3.equip_id ~= 0 then
					table.insert(var_31_0, iter_31_3.equip_id)
				end
			end
		end
	end

	return var_31_0
end

function var_0_0.GetSuitEquipNum(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = EquipData:GetEquipList()
	local var_32_1 = 0

	for iter_32_0, iter_32_1 in pairs(var_32_0) do
		local var_32_2 = EquipCfg[iter_32_1.prefab_id]
		local var_32_3 = arg_32_3 and HeroData:GetEquipMap()[iter_32_1.equip_id]
		local var_32_4 = arg_32_2 == 0 or arg_32_2 == nil or var_32_2.pos == arg_32_2

		if not var_32_3 and var_32_4 and (not arg_32_1 or not table.keyof(arg_32_1, iter_32_1.equip_id)) and var_32_2.suit == arg_32_0 then
			var_32_1 = var_32_1 + 1
		end
	end

	return var_32_1
end

function var_0_0.GetEquipSkillNum(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = EquipData:GetEquipList()
	local var_33_1 = 0

	for iter_33_0, iter_33_1 in pairs(var_33_0) do
		local var_33_2 = EquipCfg[iter_33_1.prefab_id]
		local var_33_3 = arg_33_3 and HeroData:GetEquipMap()[iter_33_1.equip_id]
		local var_33_4 = arg_33_2 == 0 or arg_33_2 == nil or var_33_2.pos == arg_33_2
		local var_33_5 = false

		if not var_33_3 and var_33_4 and (not arg_33_1 or not table.keyof(arg_33_1, iter_33_1.equip_id)) then
			for iter_33_2, iter_33_3 in ipairs(var_33_2.effect) do
				if iter_33_3 and iter_33_3[1] and iter_33_3[1] == arg_33_0 then
					var_33_5 = true

					break
				end
			end

			if not var_33_5 then
				for iter_33_4, iter_33_5 in pairs(iter_33_1.enchant) do
					for iter_33_6, iter_33_7 in ipairs(iter_33_5) do
						if iter_33_7 and iter_33_7.id and iter_33_7.id == arg_33_0 then
							var_33_5 = true

							break
						end
					end
				end
			end

			if var_33_5 then
				var_33_1 = var_33_1 + 1
			end
		end
	end

	return var_33_1
end

function var_0_0.GetEquipInfoById(arg_34_0)
	return EquipData:GetEquipList()[arg_34_0]
end

function var_0_0.CountAddExp(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = 0
	local var_35_1 = 9999999

	for iter_35_0, iter_35_1 in pairs(arg_35_0) do
		var_35_0 = var_35_0 + ItemCfg[iter_35_0].param[1] * iter_35_1
		var_35_1 = math.min(var_35_1, ItemCfg[iter_35_0].param[1])
	end

	for iter_35_2, iter_35_3 in pairs(arg_35_1) do
		local var_35_2 = iter_35_3.id or iter_35_3.prefab_id
		local var_35_3 = iter_35_3.equip_info and iter_35_3.equip_info.exp or iter_35_3.exp

		if not arg_35_2 or iter_35_3.exp <= 0 then
			local var_35_4 = EquipCfg[var_35_2].starlevel
			local var_35_5 = (var_35_3 * 0.8 or 0) + var_0_0.CountBreakExp(iter_35_3) + GameSetting.base_exp_equip_star.value[var_35_4]

			var_35_0 = var_35_0 + var_35_5
			var_35_1 = math.min(var_35_1, var_35_5)
		end
	end

	if var_35_1 == 9999999 then
		var_35_1 = 0
	end

	return var_35_0, var_35_1
end

function var_0_0.CountBreakExp(arg_36_0)
	return 0
end

function var_0_0.QuickSelectList(arg_37_0, arg_37_1)
	local var_37_0 = EquipData:GetEquipList()
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		local var_37_2 = ItemTools.getItemNum(iter_37_1)
		local var_37_3 = ItemCfg[iter_37_1]

		if var_37_3.sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and var_37_2 > 0 then
			table.insert(var_37_1, {
				id = iter_37_1,
				add = var_37_3.param[1],
				num = var_37_2
			})
		end
	end

	local var_37_4 = 0
	local var_37_5 = {}
	local var_37_6 = {}
	local var_37_7 = arg_37_0 - var_37_4
	local var_37_8 = {}

	for iter_37_2 = 1, #var_37_1 do
		local var_37_9 = var_37_1[iter_37_2].add

		var_37_8[iter_37_2] = math.max(math.min(math.ceil(var_37_7 / var_37_9), var_37_1[iter_37_2].num), 0)
		var_37_7 = var_37_7 - var_37_8[iter_37_2] * var_37_9

		if var_37_7 < 0 and iter_37_2 > 1 then
			local var_37_10 = -var_37_7

			for iter_37_3 = iter_37_2 - 1, 1, -1 do
				local var_37_11 = var_37_1[iter_37_3].add
				local var_37_12 = math.modf(var_37_10 / var_37_11)
				local var_37_13 = var_37_8[iter_37_3]

				var_37_8[iter_37_3] = math.max(0, var_37_8[iter_37_3] - var_37_12)

				local var_37_14 = math.min(var_37_13, var_37_12)

				var_37_10 = var_37_10 - var_37_11 * var_37_14
				var_37_7 = var_37_7 + var_37_11 * var_37_14
			end
		end

		if var_37_7 <= 0 then
			break
		end
	end

	for iter_37_4 = 1, #var_37_1 do
		if var_37_8[iter_37_4] == nil then
			var_37_8[iter_37_4] = 0
		end

		var_37_4 = var_37_4 + var_37_8[iter_37_4] * var_37_1[iter_37_4].add
		var_37_5[var_37_1[iter_37_4].id] = var_37_8[iter_37_4]
	end

	if var_37_7 > 0 then
		local var_37_15 = EquipData:GetEquipListComplex(ItemConst.SORT_TYPE.UP, EquipConst.EQUIP_SORT.RARE)
		local var_37_16 = HeroTools.GetEquipMap(HeroData:GetHeroList())
		local var_37_17 = ProposalData:GetEquipMap()
		local var_37_18 = #var_37_15

		for iter_37_5 = 1, var_37_18 do
			local var_37_19 = arg_37_0 - var_37_4
			local var_37_20 = var_37_15[iter_37_5].equip_id
			local var_37_21 = var_37_0[var_37_20]

			if var_37_19 <= 0 then
				break
			end

			local var_37_22 = EquipCfg[var_37_21.prefab_id]

			if var_37_16[var_37_20] == nil and var_37_21.exp == 0 and var_37_21.now_break_level == 0 and var_37_21.star < 5 and not var_37_21.is_lock and not var_37_17[var_37_21.equip_id] and not table.indexof(arg_37_1, var_37_21.equip_id) then
				var_37_6[var_37_20] = {
					isEquiped = false,
					number = 1,
					type = ItemConst.ITEM_TYPE.EQUIP,
					id = var_37_21.prefab_id,
					equip_id = var_37_21.equip_id,
					equip_info = var_37_21,
					equip_star = getItemStar(var_37_21.prefab_id),
					equip_lv = var_0_0.CountEquipLevel(var_37_21)
				}
				var_37_4 = var_37_4 + GameSetting.base_exp_equip_star.value[var_37_21.star]
			end
		end
	end

	return var_37_5, var_37_6
end

function var_0_0.GetEquipLevelUpMaterial(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = EquipData:GetEquipListComplex(arg_38_0, arg_38_1)
	local var_38_1 = {}
	local var_38_2 = {}
	local var_38_3 = {}

	for iter_38_0, iter_38_1 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.MATERIAL]) do
		local var_38_4 = ItemTools.getItemNum(iter_38_1)

		if ItemCfg[iter_38_1].sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and var_38_4 > 0 then
			table.insert(var_38_1, {
				type = ItemCfg[iter_38_1].type,
				id = iter_38_1,
				number = var_38_4
			})

			var_38_2[iter_38_1] = var_38_4
		end
	end

	local var_38_5 = HeroData:GetEquipMap()
	local var_38_6 = ProposalData:GetEquipMap()

	for iter_38_2 = #var_38_0, 1, -1 do
		if var_38_5[var_38_0[iter_38_2].equip_id] or table.indexof(arg_38_2, var_38_0[iter_38_2].equip_id) or arg_38_3 and arg_38_3 <= var_38_0[iter_38_2].star then
			table.remove(var_38_0, iter_38_2)
		end
	end

	for iter_38_3, iter_38_4 in ipairs(var_38_0) do
		if not iter_38_4.is_lock and not var_38_6[iter_38_4.equip_id] then
			iter_38_4.type = ItemCfg[iter_38_4.prefab_id].type

			table.insert(var_38_1, iter_38_4)

			var_38_3[iter_38_4.equip_id] = iter_38_4
		end
	end

	return var_38_1, var_38_2, var_38_3
end

function var_0_0.CountRestAddExp(arg_39_0, arg_39_1)
	local var_39_0 = 0

	for iter_39_0 = arg_39_1, 1, -1 do
		var_39_0 = var_39_0 + arg_39_0[iter_39_0].add * arg_39_0[iter_39_0].num
	end

	return var_39_0
end

function var_0_0.QuickMaterialList(arg_40_0, arg_40_1)
	local var_40_0 = {}
	local var_40_1 = {}
	local var_40_2 = 0

	for iter_40_0, iter_40_1 in ipairs(arg_40_1) do
		local var_40_3 = arg_40_0 - var_40_2

		if var_40_3 > 0 then
			local var_40_4 = ItemCfg[iter_40_1.id].param[1]
			local var_40_5 = math.min(math.ceil(var_40_3 / var_40_4), iter_40_1.num)

			var_40_0[iter_40_1.id] = var_40_5
			var_40_1[iter_40_0] = var_40_5
			var_40_2 = var_40_2 + var_40_5 * var_40_4
		else
			var_40_1[iter_40_0] = 0
		end
	end

	return var_40_0, var_40_1
end

function var_0_0.QuickEquipList(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = {}
	local var_41_1 = 0

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		local var_41_2 = arg_41_0 - var_41_1
		local var_41_3 = var_0_0.GetEquipInfoById(iter_41_1)
		local var_41_4 = EquipCfg[equip.prefab_id].starlevel

		if var_41_2 > 0 and var_41_4 <= arg_41_2 then
			var_41_0[iter_41_1] = var_41_3
			var_41_1 = var_41_1 + var_41_3.exp + GameSetting.base_exp_equip_star.value[var_41_4]
		end
	end

	return var_41_0
end

function var_0_0.GetEquipSuitEffect(arg_42_0)
	local var_42_0 = {}
	local var_42_1 = deepClone(EquipSuitCfg.get_id_list_by_suit[EquipCfg[arg_42_0.prefab_id].suit])

	table.sort(var_42_1, function(arg_43_0, arg_43_1)
		return EquipSuitCfg[arg_43_0].need < EquipSuitCfg[arg_43_1].need
	end)

	return var_42_1
end

function var_0_0.CountSuitEffect(arg_44_0)
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in pairs(arg_44_0) do
		local var_44_1 = EquipCfg[iter_44_1.prefab_id].suit

		var_44_0[var_44_1] = 1 + (var_44_0[var_44_1] or 0)
	end

	local var_44_2 = {}

	for iter_44_2, iter_44_3 in pairs(var_44_0) do
		local var_44_3 = EquipSuitCfg.get_id_list_by_suit[iter_44_2]

		for iter_44_4, iter_44_5 in ipairs(var_44_3) do
			if iter_44_3 >= EquipSuitCfg[iter_44_5].need then
				table.insert(var_44_2, iter_44_5)
			end
		end
	end

	return var_44_2
end

function var_0_0.Filt(arg_45_0, arg_45_1)
	local var_45_0 = deepClone(arg_45_0)

	for iter_45_0, iter_45_1 in pairs(var_45_0) do
		if not arg_45_1[EquipCfg[iter_45_1.prefab_id].pos] then
			var_45_0[iter_45_0] = nil
		end
	end

	return var_45_0
end

function var_0_0.MutiFilt(arg_46_0, arg_46_1)
	local var_46_0 = deepClone(arg_46_0)

	for iter_46_0, iter_46_1 in pairs(var_46_0) do
		for iter_46_2, iter_46_3 in pairs(arg_46_1) do
			if not iter_46_3[EquipCfg[iter_46_1.prefab_id][iter_46_2]] then
				var_46_0[iter_46_0] = nil
			end
		end
	end

	return var_46_0
end

function var_0_0.FiltByPos(arg_47_0, arg_47_1)
	local var_47_0 = deepClone(arg_47_0)

	for iter_47_0, iter_47_1 in pairs(var_47_0) do
		if not arg_47_1[EquipCfg[iter_47_1.prefab_id].pos] then
			var_47_0[iter_47_0] = nil
		end
	end

	return var_47_0
end

function var_0_0.FiltBySuit(arg_48_0, arg_48_1)
	local var_48_0 = deepClone(arg_48_0)

	for iter_48_0, iter_48_1 in pairs(var_48_0) do
		if not arg_48_1[EquipCfg[iter_48_1.prefab_id].suit] then
			var_48_0[iter_48_0] = nil
		end
	end

	return var_48_0
end

function var_0_0.EquipSort(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in pairs(arg_49_0) do
		table.insert(var_49_0, iter_49_1)
	end

	local var_49_1 = arg_49_2 or 0
	local var_49_2 = arg_49_1 or 0

	local function var_49_3(arg_50_0, arg_50_1)
		if var_49_2 == ItemConst.SORT_TYPE.DOWN then
			return arg_50_1 < arg_50_0
		else
			return arg_50_0 < arg_50_1
		end
	end

	if var_49_1 == EquipConst.EQUIP_SORT.LEVEL then
		local function var_49_4(arg_51_0, arg_51_1)
			if arg_51_0:GetLevel() ~= arg_51_1:GetLevel() then
				return var_49_3(arg_51_0:GetLevel(), arg_51_1:GetLevel())
			elseif arg_51_0.now_break_level ~= arg_51_1.now_break_level then
				return var_49_3(arg_51_0.now_break_level, arg_51_1.now_break_level)
			elseif arg_51_0.star ~= arg_51_1.star then
				return var_49_3(arg_51_0.star, arg_51_1.star)
			elseif arg_51_0:GetSuit() ~= arg_51_1:GetSuit() then
				return arg_51_0:GetSuit() < arg_51_1:GetSuit()
			elseif arg_51_0.prefab_id and arg_51_1.prefab_id and arg_51_0.prefab_id ~= arg_51_1.prefab_id then
				return arg_51_0.prefab_id < arg_51_1.prefab_id
			elseif arg_51_0.equip_id ~= arg_51_1.equip_id then
				return var_49_3(arg_51_0.equip_id, arg_51_1.equip_id)
			end

			return false
		end

		table.sort(var_49_0, var_49_4)
	elseif var_49_1 == EquipConst.EQUIP_SORT.RARE then
		local function var_49_5(arg_52_0, arg_52_1)
			if arg_52_0.star ~= arg_52_1.star then
				return var_49_3(arg_52_0.star, arg_52_1.star)
			elseif arg_52_0:GetLevel() ~= arg_52_1:GetLevel() then
				return var_49_3(arg_52_0:GetLevel(), arg_52_1:GetLevel())
			elseif arg_52_0.now_break_level ~= arg_52_1.now_break_level then
				return var_49_3(arg_52_0.now_break_level, arg_52_1.now_break_level)
			elseif arg_52_0:GetSuit() ~= arg_52_1:GetSuit() then
				return arg_52_0:GetSuit() < arg_52_1:GetSuit()
			elseif arg_52_0.prefab_id and arg_52_1.prefab_id and arg_52_0.prefab_id ~= arg_52_1.prefab_id then
				return arg_52_0.prefab_id < arg_52_1.prefab_id
			elseif arg_52_0.equip_id ~= arg_52_1.equip_id then
				return var_49_3(arg_52_0.equip_id, arg_52_1.equip_id)
			end

			return false
		end

		table.sort(var_49_0, var_49_5)
	else
		local function var_49_6(arg_53_0, arg_53_1)
			if arg_53_0.equip_id ~= arg_53_1.equip_id then
				return var_49_3(arg_53_0.equip_id, arg_53_1.equip_id)
			end

			return false
		end

		table.sort(var_49_0, var_49_6)
		print("EquipSort Fucntion cant find current sort Type")
	end

	return var_49_0
end

function var_0_0.GetEffectDesc(arg_54_0)
	local var_54_0 = EquipEffectCfg[arg_54_0]

	if not var_54_0 then
		print("装备效果 id" .. arg_54_0 .. "没有配置")
	end

	if var_54_0.desc and var_54_0.desc ~= "" then
		return GetCfgDescription(var_54_0.desc[1], 1)
	end

	return ""
end

function var_0_0.GetEffectDescOld(arg_55_0)
	if arg_55_0 == nil then
		return ""
	end

	local var_55_0 = EquipEffectCfg[arg_55_0]
	local var_55_1 = var_55_0.desc
	local var_55_2 = {}

	for iter_55_0 in string.gmatch(var_55_0.desc, "@{.-}") do
		local var_55_3 = 0
		local var_55_4 = string.sub(iter_55_0, 3, -2)
		local var_55_5 = string.split(var_55_4, "_")
		local var_55_6 = EquipEffectCfg[tonumber(var_55_5[1])]
		local var_55_7 = var_55_3 + tonumber(var_55_6.param[tonumber(var_55_5[2])])

		var_55_2[#var_55_2 + 1] = var_55_7
	end

	for iter_55_1 = 1, #var_55_2 do
		var_55_1 = string.gsub(var_55_1, "@{.-}", var_55_2[iter_55_1], 1)
	end

	return var_55_1
end

function var_0_0.GetSkillDescWithoutHero(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = EquipSkillCfg[arg_56_0]
	local var_56_1 = ""
	local var_56_2 = GameSetting.exclusive_skill_cd_type.value
	local var_56_3 = GameSetting.exclusive_skill_level_up_type.value
	local var_56_4 = GameSetting.exclusive_skill_damage_type.value
	local var_56_5 = false

	if not var_56_5 then
		for iter_56_0, iter_56_1 in ipairs(var_56_2) do
			if arg_56_0 == iter_56_1[1] then
				var_56_5 = iter_56_1[2]
			end
		end
	end

	if not var_56_5 then
		for iter_56_2, iter_56_3 in ipairs(var_56_3) do
			if arg_56_0 == iter_56_3[1] then
				var_56_5 = iter_56_3[2]
			end
		end
	end

	if not var_56_5 then
		for iter_56_4, iter_56_5 in ipairs(var_56_4) do
			if arg_56_0 == iter_56_5[1] then
				local var_56_6 = iter_56_5[2]
			end
		end
	end

	local var_56_7 = ""

	if arg_56_1 == 0 then
		var_56_7 = EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * 1, arg_56_0)
	elseif arg_56_1 < var_56_0.lvmax then
		if arg_56_2 then
			var_56_7 = EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * arg_56_1, arg_56_0)
		else
			var_56_7 = EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * arg_56_1, arg_56_0) .. string.format(GetTips("EQUIP_HERO_SKILL_NEXT_LEVEL"), EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * (arg_56_1 + 1), arg_56_0))
		end
	else
		var_56_7 = EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * arg_56_1, arg_56_0)
	end

	return GetCfgDescriptionWithValue(var_56_0.desc[1], var_56_7)
end

function var_0_0.GetSkillDesc(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = EquipSkillCfg[arg_57_0]
	local var_57_1 = HeroCfg[arg_57_2]
	local var_57_2 = ""
	local var_57_3 = GameSetting.exclusive_skill_cd_type.value
	local var_57_4 = GameSetting.exclusive_skill_level_up_type.value
	local var_57_5 = GameSetting.exclusive_skill_damage_type.value
	local var_57_6 = false

	if not var_57_6 then
		for iter_57_0, iter_57_1 in ipairs(var_57_3) do
			if arg_57_0 == iter_57_1[1] then
				var_57_6 = iter_57_1[2]
			end
		end
	end

	if not var_57_6 then
		for iter_57_2, iter_57_3 in ipairs(var_57_4) do
			if arg_57_0 == iter_57_3[1] then
				var_57_6 = iter_57_3[2]
			end
		end
	end

	if not var_57_6 then
		for iter_57_4, iter_57_5 in ipairs(var_57_5) do
			if arg_57_0 == iter_57_5[1] then
				var_57_6 = iter_57_5[2]
			end
		end
	end

	if var_57_6 then
		local var_57_7 = var_57_1.skills[var_57_6]
		local var_57_8 = HeroSkillCfg[var_57_7].name
	end

	local var_57_9 = ""

	if arg_57_1 == 0 then
		var_57_9 = EquipTools.Calculate(var_57_0.upgrade / var_57_0.percent * 1, arg_57_0)
	elseif arg_57_1 < var_57_0.lvmax then
		var_57_9 = EquipTools.Calculate(var_57_0.upgrade / var_57_0.percent * arg_57_1, arg_57_0) .. string.format(GetTips("EQUIP_HERO_SKILL_NEXT_LEVEL"), EquipTools.Calculate(var_57_0.upgrade / var_57_0.percent * (arg_57_1 + 1), arg_57_0))
	else
		var_57_9 = EquipTools.Calculate(var_57_0.upgrade / var_57_0.percent * arg_57_1, arg_57_0)
	end

	return GetCfgDescriptionWithValue(var_57_0.desc[1], var_57_9)
end

function var_0_0.GetSkillDescWithoutNext(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = EquipSkillCfg[arg_58_0]
	local var_58_1 = HeroCfg[arg_58_2]
	local var_58_2 = ""
	local var_58_3 = GameSetting.exclusive_skill_cd_type.value
	local var_58_4 = GameSetting.exclusive_skill_level_up_type.value
	local var_58_5 = GameSetting.exclusive_skill_damage_type.value
	local var_58_6 = false

	if not var_58_6 then
		for iter_58_0, iter_58_1 in ipairs(var_58_3) do
			if arg_58_0 == iter_58_1[1] then
				var_58_6 = iter_58_1[2]
			end
		end
	end

	if not var_58_6 then
		for iter_58_2, iter_58_3 in ipairs(var_58_4) do
			if arg_58_0 == iter_58_3[1] then
				var_58_6 = iter_58_3[2]
			end
		end
	end

	if not var_58_6 then
		for iter_58_4, iter_58_5 in ipairs(var_58_5) do
			if arg_58_0 == iter_58_5[1] then
				var_58_6 = iter_58_5[2]
			end
		end
	end

	if var_58_6 then
		local var_58_7 = var_58_1.skills[var_58_6]
		local var_58_8 = HeroSkillCfg[var_58_7].name
	end

	local var_58_9 = ""

	if arg_58_1 == 0 then
		var_58_9 = EquipTools.Calculate(var_58_0.upgrade / var_58_0.percent * 1, arg_58_0)
	else
		var_58_9 = EquipTools.Calculate(var_58_0.upgrade / var_58_0.percent * arg_58_1, arg_58_0)
	end

	return GetCfgDescriptionWithValue(var_58_0.desc[1], var_58_9)
end

function var_0_0.Calculate(arg_59_0, arg_59_1)
	local var_59_0 = GameDisplayCfg.equip_hero_skill_int.value

	if table.indexof(var_59_0, arg_59_1) then
		return arg_59_0
	else
		return string.format("%.1f%%", arg_59_0)
	end
end

function var_0_0.GetIsHide(arg_60_0)
	local var_60_0 = EquipCfg[arg_60_0].suit

	hideList = HideInfoData:GetEquipSuitHideList()

	return hideList[var_60_0] or false
end

function var_0_0.GetSuitTotalNum()
	local var_61_0 = HideInfoData:GetEquipSuitHideList()
	local var_61_1 = 0

	for iter_61_0, iter_61_1 in ipairs(EquipSuitCfg.all) do
		if not var_61_0[iter_61_1] then
			var_61_1 = var_61_1 + 1
		end
	end

	return var_61_1
end

function var_0_0.RefreshSkillData(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = {}

	if arg_62_1 and arg_62_2 then
		local var_62_1 = arg_62_2:GetEquipDataList(arg_62_1)
		local var_62_2 = HeroData:GetHeroData(arg_62_1)
		local var_62_3, var_62_4, var_62_5 = EquipTools.CountHeroTotalSkill(var_62_1, var_62_2, true)

		for iter_62_0, iter_62_1 in pairs(var_62_3) do
			var_62_0[iter_62_0] = {
				id = iter_62_0,
				num = iter_62_1,
				isAdd = var_62_4,
				location = var_62_5[iter_62_0]
			}
		end
	else
		local var_62_6 = arg_62_0:GetTotalSkill()

		for iter_62_2, iter_62_3 in ipairs(var_62_6) do
			var_62_0[iter_62_3.id] = {
				id = iter_62_3.id,
				num = iter_62_3.num,
				location = {
					{
						isEquip = true,
						id = arg_62_0.equip_id,
						level = iter_62_3.num,
						prefab_id = arg_62_0.prefab_id
					}
				}
			}
		end
	end

	return var_62_0
end

return var_0_0
