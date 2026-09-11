local var_0_0 = {}
local bit = import("bit")

function var_0_0.GetAllSuits()
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(EquipSuitCfg.get_id_list_by_suit) do
		table.insert(var_1_0, iter_1_0)
	end

	return var_1_0
end

function var_0_0.GetEquipNum()
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in pairs((EquipData:GetEquipList())) do
		var_2_0 = var_2_0 + 1
	end

	return var_2_0
end

function var_0_0.GetEquipListByPrefabId(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs((EquipData:GetEquipList())) do
		if iter_3_1.prefab_id == arg_3_0 then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_0.GetEquipListByEquipid(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs((EquipData:GetEquipList())) do
		if EquipCfg[iter_4_1.prefab_id].pos == EquipCfg[arg_4_0].pos and EquipCfg[iter_4_1.prefab_id].suit == EquipCfg[arg_4_0].suit and EquipCfg[iter_4_1.prefab_id].starlevel == EquipCfg[arg_4_0].starlevel then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function var_0_0.GetHaveSuitList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = HideInfoData:GetEquipSuitHideList()

	for iter_5_0, iter_5_1 in pairs((EquipData:GetEquipList())) do
		if not var_5_1[EquipCfg[iter_5_1.prefab_id].suit] then
			var_5_0[EquipCfg[iter_5_1.prefab_id].suit] = true
		end
	end

	local var_5_2 = {}

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		table.insert(var_5_2, tonumber(iter_5_2))
	end

	if arg_5_0 then
		for iter_5_4, iter_5_5 in ipairs(EquipSuitCfg.all) do
			if not var_5_0[iter_5_5] and not var_5_1[iter_5_5] then
				table.insert(var_5_2, iter_5_5)
			end
		end
	end

	return var_5_2, var_5_0
end

function var_0_0.GetIsHaveExEquip()
	for iter_6_0, iter_6_1 in pairs((EquipData:GetEquipList())) do
		if EquipCfg[iter_6_1.prefab_id].suit >= EquipConst.EX_EQUIP_SUIT_ID then
			return true
		end
	end

	return false
end

function var_0_0.IsHaveEquip(arg_7_0)
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0) do
		var_7_1[iter_7_1] = false
	end

	for iter_7_2, iter_7_3 in pairs((EquipData:GetEquipList())) do
		if table.indexof(arg_7_0, iter_7_3.prefab_id) then
			var_7_1[iter_7_3.prefab_id] = true
		end
	end

	return var_7_1
end

function var_0_0.GetFreeEquipByEquipId(arg_8_0, arg_8_1)
	local var_8_0 = HeroTools.GetEquipMap(HeroData:GetHeroList())
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = false
	local var_8_4 = false

	for iter_8_0, iter_8_1 in pairs(EquipData:GetEquipList()) do
		local var_8_5 = false
		local var_8_6

		for iter_8_2, iter_8_3 in ipairs(arg_8_0) do
			if EquipTools.IsSameEquip(iter_8_3, iter_8_1.prefab_id) then
				var_8_5 = true
				var_8_6 = iter_8_3

				break
			end
		end

		if var_8_5 then
			var_8_2[var_8_6] = var_8_2[var_8_6] or {}

			table.insert(var_8_2[var_8_6], iter_8_1)

			var_8_4 = true

			if var_8_0[iter_8_1.equip_id] == nil or var_8_0[iter_8_1.equip_id] == arg_8_1 then
				var_8_1[var_8_6] = var_8_1[var_8_6] or {}

				table.insert(var_8_1[var_8_6], iter_8_1)

				var_8_3 = true
			end
		end
	end

	return var_8_1, var_8_2, var_8_3, var_8_4, var_8_0
end

function var_0_0.IsSameEquip(arg_9_0, arg_9_1)
	if EquipCfg[arg_9_0].pos == EquipCfg[arg_9_1].pos and EquipCfg[arg_9_0].starlevel == EquipCfg[arg_9_1].starlevel and EquipCfg[arg_9_0].suit == EquipCfg[arg_9_1].suit then
		return true
	end

	return false
end

function var_0_0.GetHaveSkillList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs((EquipData:GetEquipList())) do
		for iter_10_2, iter_10_3 in ipairs(EquipCfg[iter_10_1.prefab_id].effect) do
			if iter_10_3[1] then
				var_10_0[iter_10_3[1]] = true
			end
		end

		for iter_10_4, iter_10_5 in pairs(iter_10_1.enchant) do
			for iter_10_6, iter_10_7 in ipairs(iter_10_5) do
				if iter_10_7 and iter_10_7.id then
					var_10_0[iter_10_7.id] = true
				end
			end
		end
	end

	local var_10_1 = {}

	for iter_10_8, iter_10_9 in pairs(var_10_0) do
		table.insert(var_10_1, tonumber(iter_10_8))
	end

	if arg_10_0 then
		for iter_10_10, iter_10_11 in ipairs(EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]) do
			if not var_10_0[iter_10_11] then
				table.insert(var_10_1, iter_10_11)
			end
		end
	end

	return var_10_1
end

function var_0_0.GetHeroEquipSuitPos(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}
	local var_11_1 = 0

	if arg_11_0 and arg_11_0 ~= 0 then
		local var_11_2 = EquipData:GetEquipList()

		for iter_11_0, iter_11_1 in pairs(HeroData:GetHeroList()[arg_11_0].equip) do
			if iter_11_1.equip_id and iter_11_1.equip_id ~= 0 then
				if EquipCfg[var_11_2[iter_11_1.equip_id].prefab_id].suit == arg_11_1 then
					var_11_0[EquipCfg[var_11_2[iter_11_1.equip_id].prefab_id].pos] = true
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
	for iter_12_0, iter_12_1 in pairs((HeroData:GetHeroList())) do
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
			local var_13_3 = EquipCfg[iter_13_1.prefab_id and iter_13_1.prefab_id or var_13_0[iter_13_1.equip_id].prefab_id]

			if var_13_1[EquipCfg[iter_13_1.prefab_id and iter_13_1.prefab_id or var_13_0[iter_13_1.equip_id].prefab_id].suit] then
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

	for iter_14_0, iter_14_1 in pairs((var_0_0.CountActiveSuit(arg_14_0))) do
		if iter_14_1.id == arg_14_1 then
			var_14_0 = iter_14_1.num

			break
		end
	end

	return var_14_0
end

function var_0_0.GetSuitNeedNum(arg_15_0, arg_15_1)
	if EquipSuitCfg[arg_15_0].need < 3 or not arg_15_1 then
		return EquipSuitCfg[arg_15_0].need
	else
		return EquipSuitCfg[arg_15_0].need - 1
	end
end

function var_0_0.CountHeroTotalSkill(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0) do
		if iter_16_1.equip_id and iter_16_1.equip_id ~= 0 then
			local var_16_2 = var_0_0.CountEquipLevel(iter_16_1)
			local var_16_3 = {}

			for iter_16_2 = 1, #EquipCfg[iter_16_1.prefab_id].effect do
				if EquipCfg[iter_16_1.prefab_id].effect[iter_16_2] and var_16_2 >= EquipCfg[iter_16_1.prefab_id].effect_unlock_level[iter_16_2] then
					var_16_0[EquipCfg[iter_16_1.prefab_id].effect[iter_16_2][1]] = (var_16_0[EquipCfg[iter_16_1.prefab_id].effect[iter_16_2][1]] or 0) + EquipCfg[iter_16_1.prefab_id].effect[iter_16_2][2]
					var_16_3[EquipCfg[iter_16_1.prefab_id].effect[iter_16_2][1]] = (var_16_3[EquipCfg[iter_16_1.prefab_id].effect[iter_16_2][1]] or 0) + EquipCfg[iter_16_1.prefab_id].effect[iter_16_2][2]
				end
			end

			for iter_16_3, iter_16_4 in pairs(iter_16_1.enchant) do
				for iter_16_5, iter_16_6 in ipairs(iter_16_4) do
					if iter_16_6 and iter_16_6.id then
						var_16_0[iter_16_6.id] = (var_16_0[iter_16_6.id] or 0) + iter_16_6.num
						var_16_3[iter_16_6.id] = (var_16_3[iter_16_6.id] or 0) + iter_16_6.num
					end
				end
			end

			for iter_16_7, iter_16_8 in pairs(var_16_3) do
				var_16_1[iter_16_7] = var_16_1[iter_16_7] or {}

				table.insert(var_16_1[iter_16_7], {
					isEquip = true,
					id = iter_16_1.equip_id,
					level = iter_16_8,
					prefab_id = iter_16_1.prefab_id
				})
			end
		end
	end

	local var_16_6 = HeroTools.GetHeroEquipSkillAddLevel(arg_16_1)

	for iter_16_9, iter_16_10 in pairs(var_16_0) do
		var_16_0[iter_16_9] = iter_16_10 + var_16_6

		if var_16_6 ~= 0 then
			table.insert(var_16_1[iter_16_9], {
				isEquip = false,
				level = var_16_6
			})
		end
	end

	if not arg_16_2 then
		for iter_16_11, iter_16_12 in pairs(var_16_0) do
			if iter_16_12 > EquipSkillCfg[iter_16_11].lvmax then
				var_16_0[iter_16_11] = EquipSkillCfg[iter_16_11].lvmax
			end
		end
	end

	return var_16_0, var_16_6 > 0, var_16_1
end

function var_0_0:CountEquipAttribute(arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = var_0_0.CountEquipLevel(self)
	local var_17_2 = false
	local var_17_3 = false

	if arg_17_2 and self.race ~= 0 then
		if self.race == HeroCfg[arg_17_2].race then
			var_17_2 = true
		end

		if self.race == arg_17_2 then
			var_17_3 = true
		end
	end

	for iter_17_0, iter_17_1 in pairs(EquipCfg[self.prefab_id].fixed_attributes[self.now_break_level + 1]) do
		var_17_0[iter_17_1[1]] = iter_17_1[2] + iter_17_1[3] * (var_17_1 - 1)

		if var_17_2 then
			var_17_0[iter_17_1[1]] = var_17_0[iter_17_1[1]] * 1.2
		end

		if var_17_3 then
			var_17_0[iter_17_1[1]] = var_17_0[iter_17_1[1]] * GameSetting.equip_hero_strengthen_num.value[1]
		end
	end

	if arg_17_1 then
		for iter_17_2 = 1, #EquipCfg[self.prefab_id].effect do
			if EquipCfg[self.prefab_id].effect[iter_17_2] and var_17_1 >= EquipCfg[self.prefab_id].effect_unlock_level[iter_17_2] then
				var_17_0[EquipSkillCfg[EquipCfg[self.prefab_id].effect[iter_17_2][1]].attribute] = (var_17_0[EquipSkillCfg[EquipCfg[self.prefab_id].effect[iter_17_2][1]].attribute] or 0) + EquipSkillCfg[EquipCfg[self.prefab_id].effect[iter_17_2][1]].upgrade * EquipCfg[self.prefab_id].effect[iter_17_2][2]
			end
		end

		if self.enchant then
			for iter_17_3, iter_17_4 in pairs(self.enchant) do
				for iter_17_5, iter_17_6 in ipairs(iter_17_4) do
					if iter_17_6 and iter_17_6.id then
						var_17_0[EquipSkillCfg[iter_17_6.id].attribute] = (var_17_0[EquipSkillCfg[iter_17_6.id].attribute] or 0) + EquipSkillCfg[iter_17_6.id].upgrade * iter_17_6.num
					end
				end
			end
		end
	end

	return var_17_0
end

function var_0_0:CountEquipMaxLv()
	return EquipCfg[self.prefab_id].max_level[self.now_break_level + 1]
end

function var_0_0:CountEquipMaxLvWitnoutBreak()
	return EquipCfg[self.prefab_id].max_level[#EquipCfg[self.prefab_id].max_level]
end

function var_0_0:CountEquipLevel()
	local var_20_0 = self.exp or 0
	local var_20_1 = var_0_0.CountEquipMaxLv(self)

	for iter_20_0 = 1, var_20_1 - 1 do
		if var_20_0 < EquipExpCfg[iter_20_0]["exp" .. EquipCfg[self.prefab_id].starlevel] then
			return iter_20_0
		end

		var_20_0 = var_20_0 - EquipExpCfg[iter_20_0]["exp" .. EquipCfg[self.prefab_id].starlevel]
	end

	return var_20_1
end

function var_0_0:CountSingleEquipAttribute(arg_21_1)
	local var_21_0 = var_0_0.CountEquipLevel(self)

	for iter_21_0, iter_21_1 in ipairs(EquipCfg[self.prefab_id].fixed_attributes[self.now_break_level + 1]) do
		if iter_21_1[1] == arg_21_1 then
			return iter_21_1[2] + iter_21_1[3] * (var_21_0 - 1)
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
		for iter_22_4, iter_22_5 in pairs((var_0_0.CountHeroTotalSkill(arg_22_0, arg_22_1))) do
			var_22_0[EquipSkillCfg[iter_22_4].attribute] = (var_22_0[EquipSkillCfg[iter_22_4].attribute] or 0) + EquipSkillCfg[iter_22_4].upgrade * iter_22_5
		end
	end

	return var_22_0
end

function var_0_0.GetHeroEquipS(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(HeroData:GetHeroList()[arg_23_0].equip) do
		var_23_0[iter_23_1.pos] = EquipData:GetEquipList()[iter_23_1.equip_id]
	end

	return var_23_0
end

function var_0_0:GetEquipDataList()
	local var_24_0 = {}

	for iter_24_0 = 1, 6 do
		if self[iter_24_0].equip_id ~= 0 then
			var_24_0[iter_24_0] = EquipData:GetEquipData(self[iter_24_0].equip_id)
		end
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
		if var_25_2[EquipCfg[iter_25_1.prefab_id].suit] == nil then
			var_25_2[EquipCfg[iter_25_1.prefab_id].suit] = 0
		end

		var_25_2[EquipCfg[iter_25_1.prefab_id].suit] = var_25_2[EquipCfg[iter_25_1.prefab_id].suit] + 1
	end

	for iter_25_2, iter_25_3 in pairs(var_25_2) do
		for iter_25_4, iter_25_5 in ipairs(EquipSuitCfg.get_id_list_by_suit[iter_25_2]) do
			if iter_25_3 >= var_0_0.GetSuitNeedNum(iter_25_5, var_25_1) and EquipSuitCfg[iter_25_5].suit_effect then
				for iter_25_6, iter_25_7 in pairs(EquipSuitCfg[iter_25_5].suit_effect) do
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
		local var_26_3 = (iter_26_1.exp * 0.8 or 0) + var_0_0.CountBreakExp(iter_26_1) + GameSetting.base_exp_equip_star.value[EquipCfg[iter_26_1.prefab_id].starlevel]
		local var_26_4 = {
			GameSetting.equip_exp_props_id_list.value[3],
			GameSetting.equip_exp_props_id_list.value[2],
			GameSetting.equip_exp_props_id_list.value[1]
		}

		for iter_26_2 = 1, #var_26_4 do
			if ItemCfg[var_26_4[iter_26_2]].param[1] <= var_26_3 then
				local var_26_5 = math.floor(var_26_3 / ItemCfg[var_26_4[iter_26_2]].param[1])

				var_26_0[var_26_4[iter_26_2]] = (var_26_0[var_26_4[iter_26_2]] or 0) + var_26_5
				var_26_3 = var_26_3 - ItemCfg[var_26_4[iter_26_2]].param[1] * var_26_5
			end
		end

		for iter_26_3, iter_26_4 in pairs((EquipData:GetEquipData(iter_26_0):GetBreakCostReturn())) do
			local var_26_6 = iter_26_4[1] or 0

			var_26_0[var_26_6] = (var_26_0[var_26_6] or 0) + (iter_26_4[2] or 0)
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

function var_0_0:CountNeedExp(arg_27_1, arg_27_2)
	local var_27_0 = 0

	for iter_27_0 = 1, arg_27_1 - 1 do
		var_27_0 = var_27_0 + EquipExpCfg[iter_27_0]["exp" .. EquipCfg[self.prefab_id].starlevel]
	end

	return var_27_0
end

function var_0_0:CountMinAddLevel(arg_28_1)
	for iter_28_0 = 2, var_0_0.CountEquipMaxLvWitnoutBreak(self) do
		if self.exp + arg_28_1 < EquipExpCfg[iter_28_0]["exp_sum_" .. self.star] then
			return iter_28_0 - 1
		end
	end

	return 1
end

function var_0_0:CalculateCultueLevel(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = self:GetLevel()
	local var_29_1 = self.now_break_level
	local var_29_2 = EquipCfg[self.prefab_id]
	local var_29_3 = self.exp - EquipExpCfg[var_29_0]["exp_sum_" .. EquipCfg[self.prefab_id].starlevel]

	arg_29_1 = arg_29_1 + (self.exp - EquipExpCfg[var_29_0]["exp_sum_" .. EquipCfg[self.prefab_id].starlevel])

	local var_29_4 = var_29_0
	local var_29_5 = 0
	local var_29_6 = 0
	local var_29_7 = var_29_0 + 1
	local var_29_8 = {}
	local var_29_9 = false
	local var_29_10 = false
	local var_29_11

	for iter_29_0 = var_29_0 + 1, arg_29_2 or var_0_0.CountEquipMaxLvWitnoutBreak(self) do
		local var_29_12 = false

		if iter_29_0 % 10 == 0 and var_29_1 <= var_29_2.break_times_max or arg_29_3 then
			if iter_29_0 >= 40 and (self.race == 0 or table.keyof(RaceEffectCfg.all, self.race) ~= nil) then
				var_29_12 = true
			end

			var_29_1 = var_29_1 + 1

			if var_29_2.break_cost[var_29_1] then
				local var_29_13 = false

				for iter_29_1 = 2, #EquipMaterialCfg[var_29_2.break_cost[var_29_1]].item_list do
					local var_29_14 = EquipMaterialCfg[var_29_2.break_cost[var_29_1]].item_list[iter_29_1][1]

					var_29_8[var_29_14] = ((var_29_8[EquipMaterialCfg[var_29_2.break_cost[var_29_1]].item_list[iter_29_1][1]] or nil) and (var_29_8[var_29_14] or 0)) + EquipMaterialCfg[var_29_2.break_cost[var_29_1]].item_list[iter_29_1][2]

					if var_29_8[var_29_14] > ItemTools.getItemNum(var_29_14) then
						var_29_13 = true
					end
				end

				if var_29_13 then
					var_29_12 = true
				else
					var_29_6 = var_29_6 + EquipMaterialCfg[var_29_2.break_cost[var_29_1]].item_list[1][2]
					var_29_7 = arg_29_3 and iter_29_0 - 1 or iter_29_0
				end
			end

			arg_29_3 = false
		end

		local var_29_15 = EquipExpCfg[iter_29_0 - 1]["exp" .. EquipCfg[self.prefab_id].starlevel]

		if var_29_3 > 0 then
			var_29_15 = var_29_15 - var_29_3
			var_29_3 = 0
		end

		if arg_29_1 < var_29_15 then
			var_29_9 = true
			var_29_11 = var_29_11 or iter_29_0 - 1
			var_29_12 = true
		else
			var_29_5 = var_29_5 + math.floor(var_29_15 * GameSetting.equip_strengthen_gold_cost.value[1])
			arg_29_1 = arg_29_1 - var_29_15
			var_29_11 = iter_29_0
		end

		if not arg_29_2 then
			if var_29_7 < iter_29_0 then
				var_29_5 = var_29_5 + var_29_6
				var_29_6 = 0
			end

			if var_29_5 > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
				var_29_10 = true
				var_29_12 = true
			end

			if var_29_12 then
				var_29_4 = (var_29_9 or var_29_10) and iter_29_0 - 1 or iter_29_0

				break
			end
		end

		var_29_4 = iter_29_0
	end

	local var_29_16 = {}

	var_29_16.maxLevel = math.max(var_29_0 + 1, var_29_4)
	var_29_16.expMaxLevel = var_29_11

	return var_29_16
end

function var_0_0.GetLockedEquipS()
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs((EquipData:GetEquipList())) do
		if iter_30_1.is_lock and iter_30_1.is_lock == 1 then
			table.insert(var_30_0, iter_30_1.equip_id)
		end
	end

	return var_30_0
end

function var_0_0.GetHeroUsedEquipS()
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in pairs((HeroData:GetHeroList())) do
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
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs((EquipData:GetEquipList())) do
		local var_32_1 = EquipCfg[iter_32_1.prefab_id]

		if not (arg_32_3 and HeroData:GetEquipMap()[iter_32_1.equip_id]) and (arg_32_2 == 0 or arg_32_2 == nil or var_32_1.pos == arg_32_2) and (not arg_32_1 or not table.keyof(arg_32_1, iter_32_1.equip_id)) and var_32_1.suit == arg_32_0 then
			var_32_0 = var_32_0 + 1
		end
	end

	return var_32_0
end

function var_0_0.GetEquipSkillNum(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in pairs((EquipData:GetEquipList())) do
		local var_33_1 = EquipCfg[iter_33_1.prefab_id]
		local var_33_2 = false

		if not (arg_33_3 and HeroData:GetEquipMap()[iter_33_1.equip_id]) and (arg_33_2 == 0 or arg_33_2 == nil or var_33_1.pos == arg_33_2) and (not arg_33_1 or not table.keyof(arg_33_1, iter_33_1.equip_id)) then
			for iter_33_2, iter_33_3 in ipairs(var_33_1.effect) do
				if iter_33_3 and iter_33_3[1] and iter_33_3[1] == arg_33_0 then
					var_33_2 = true

					break
				end
			end

			if not var_33_2 then
				for iter_33_4, iter_33_5 in pairs(iter_33_1.enchant) do
					for iter_33_6, iter_33_7 in ipairs(iter_33_5) do
						if iter_33_7 and iter_33_7.id and iter_33_7.id == arg_33_0 then
							var_33_2 = true

							break
						end
					end
				end
			end

			if var_33_2 then
				var_33_0 = var_33_0 + 1
			end
		end
	end

	return var_33_0
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
		if iter_35_3.equip_info then
			if not arg_35_2 or iter_35_3.exp <= 0 then
				local var_35_5 = ((not ((iter_35_3.equip_info.exp or iter_35_3.exp) * 0.8) or nil) and 0) + var_0_0.CountBreakExp(iter_35_3) + GameSetting.base_exp_equip_star.value[EquipCfg[iter_35_3.id or iter_35_3.prefab_id].starlevel]

				var_35_0 = var_35_0 + var_35_5
				var_35_1 = math.min(var_35_1, var_35_5)
			end
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

		if ItemCfg[iter_37_1].sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and var_37_2 > 0 then
			table.insert(var_37_1, {
				id = iter_37_1,
				add = ItemCfg[iter_37_1].param[1],
				num = var_37_2
			})
		end
	end

	local var_37_3 = 0
	local var_37_4 = {}
	local var_37_5 = {}
	local var_37_6 = arg_37_0 - 0
	local var_37_7 = {}

	for iter_37_2 = 1, #var_37_1 do
		var_37_7[iter_37_2] = math.max(math.min(math.ceil(var_37_6 / var_37_1[iter_37_2].add), var_37_1[iter_37_2].num), 0)
		var_37_6 = var_37_6 - var_37_7[iter_37_2] * var_37_1[iter_37_2].add

		if var_37_6 < 0 and iter_37_2 > 1 then
			for iter_37_3 = iter_37_2 - 1, 1, -1 do
				local var_37_8 = math.modf(-var_37_6 / var_37_1[iter_37_3].add)

				var_37_7[iter_37_3] = math.max(0, var_37_7[iter_37_3] - var_37_8)
				var_37_6 = var_37_6 + var_37_1[iter_37_3].add * math.min(var_37_7[iter_37_3], var_37_8)
			end
		end

		if var_37_6 <= 0 then
			break
		end
	end

	for iter_37_4 = 1, #var_37_1 do
		if var_37_7[iter_37_4] == nil then
			var_37_7[iter_37_4] = 0
		end

		var_37_3 = var_37_3 + var_37_7[iter_37_4] * var_37_1[iter_37_4].add
		var_37_4[var_37_1[iter_37_4].id] = var_37_7[iter_37_4]
	end

	if var_37_6 > 0 then
		local var_37_11 = EquipData:GetEquipListComplex(ItemConst.SORT_TYPE.UP, EquipConst.EQUIP_SORT.RARE)
		local var_37_12 = HeroTools.GetEquipMap(HeroData:GetHeroList())
		local var_37_13 = ProposalData:GetEquipMap()

		for iter_37_5 = 1, #var_37_11 do
			if arg_37_0 - var_37_3 <= 0 then
				break
			end

			if var_37_12[var_37_11[iter_37_5].equip_id] == nil and var_37_0[var_37_11[iter_37_5].equip_id].exp == 0 and var_37_0[var_37_11[iter_37_5].equip_id].now_break_level == 0 and var_37_0[var_37_11[iter_37_5].equip_id].star < 5 and not var_37_0[var_37_11[iter_37_5].equip_id].is_lock and not var_37_13[var_37_0[var_37_11[iter_37_5].equip_id].equip_id] and not table.indexof(arg_37_1, var_37_0[var_37_11[iter_37_5].equip_id].equip_id) then
				var_37_5[var_37_11[iter_37_5].equip_id] = {
					isEquiped = false,
					number = 1,
					type = ItemConst.ITEM_TYPE.EQUIP,
					id = var_37_0[var_37_11[iter_37_5].equip_id].prefab_id,
					equip_id = var_37_0[var_37_11[iter_37_5].equip_id].equip_id,
					equip_info = var_37_0[var_37_11[iter_37_5].equip_id],
					equip_star = getItemStar(var_37_0[var_37_11[iter_37_5].equip_id].prefab_id),
					equip_lv = var_0_0.CountEquipLevel(var_37_0[var_37_11[iter_37_5].equip_id])
				}
				var_37_3 = var_37_3 + GameSetting.base_exp_equip_star.value[var_37_0[var_37_11[iter_37_5].equip_id].star]
			end
		end
	end

	return var_37_4, var_37_5
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

function var_0_0:CountRestAddExp(arg_39_1)
	local var_39_0 = 0

	for iter_39_0 = arg_39_1, 1, -1 do
		var_39_0 = var_39_0 + self[iter_39_0].add * self[iter_39_0].num
	end

	return var_39_0
end

function var_0_0.QuickMaterialList(arg_40_0, arg_40_1)
	local var_40_0 = {}
	local var_40_1 = {}

	for iter_40_0, iter_40_1 in ipairs(arg_40_1) do
		local var_40_3

		if arg_40_0 - 0 > 0 then
			local var_40_2 = math.min(math.ceil((arg_40_0 - 0) / ItemCfg[iter_40_1.id].param[1]), iter_40_1.num)

			var_40_0[iter_40_1.id] = var_40_2
			var_40_1[iter_40_0] = var_40_2
			var_40_3 = 0 + var_40_2 * ItemCfg[iter_40_1.id].param[1]
		else
			var_40_1[iter_40_0] = 0
		end
	end

	return var_40_0, var_40_1
end

function var_0_0.QuickEquipList(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(arg_41_1) do
		if arg_41_0 - 0 > 0 and EquipCfg[equip.prefab_id].starlevel <= arg_41_2 then
			var_41_0[iter_41_1] = var_0_0.GetEquipInfoById(iter_41_1)
		end
	end

	return var_41_0
end

function var_0_0:GetEquipSuitEffect()
	local var_42_1 = deepClone(EquipSuitCfg.get_id_list_by_suit[EquipCfg[self.prefab_id].suit])

	table.sort(var_42_1, function(arg_43_0, arg_43_1)
		return EquipSuitCfg[arg_43_0].need < EquipSuitCfg[arg_43_1].need
	end)

	return var_42_1
end

function var_0_0.CountSuitEffect(arg_44_0)
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in pairs(arg_44_0) do
		var_44_0[EquipCfg[iter_44_1.prefab_id].suit] = 1 + (var_44_0[EquipCfg[iter_44_1.prefab_id].suit] or 0)
	end

	local var_44_2 = {}

	for iter_44_2, iter_44_3 in pairs(var_44_0) do
		for iter_44_4, iter_44_5 in ipairs(EquipSuitCfg.get_id_list_by_suit[iter_44_2]) do
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

	if (arg_49_2 or 0) == EquipConst.EQUIP_SORT.LEVEL then
		table.sort(var_49_0, function(arg_51_0, arg_51_1)
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
		end)
	elseif var_49_1 == EquipConst.EQUIP_SORT.RARE then
		table.sort(var_49_0, function(arg_52_0, arg_52_1)
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
		end)
	else
		table.sort(var_49_0, function(arg_53_0, arg_53_1)
			if arg_53_0.equip_id ~= arg_53_1.equip_id then
				return var_49_3(arg_53_0.equip_id, arg_53_1.equip_id)
			end

			return false
		end)
		print("EquipSort Fucntion cant find current sort Type")
	end

	return var_49_0
end

function var_0_0.GetEffectDesc(arg_54_0)
	if not EquipEffectCfg[arg_54_0] then
		print("装备效果 id" .. arg_54_0 .. "没有配置")
	end

	if EquipEffectCfg[arg_54_0].desc and EquipEffectCfg[arg_54_0].desc ~= "" then
		return GetCfgDescription(EquipEffectCfg[arg_54_0].desc[1], 1)
	end

	return ""
end

function var_0_0.GetEffectDescOld(arg_55_0)
	local var_55_0
	local var_55_1

	if arg_55_0 == nil then
		do return "" end

		var_55_0 = EquipEffectCfg[arg_55_0].desc
		var_55_1 = {}
	end

	for iter_55_0 in string.gmatch(EquipEffectCfg[arg_55_0].desc, "@{.-}") do
		local var_55_2 = string.split(string.sub(iter_55_0, 3, -2), "_")

		var_55_1[#var_55_1 + 1] = 0 + tonumber(EquipEffectCfg[tonumber(var_55_2[1])].param[tonumber(var_55_2[2])])
	end

	for iter_55_1 = 1, #var_55_1 do
		var_55_0 = string.gsub(var_55_0, "@{.-}", var_55_1[iter_55_1], 1)
	end

	return var_55_0
end

function var_0_0.GetSkillDescWithoutHero(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = EquipSkillCfg[arg_56_0]
	local var_56_2 = false

	if not var_56_2 then
		for iter_56_0, iter_56_1 in ipairs(GameSetting.exclusive_skill_cd_type.value) do
			if arg_56_0 == iter_56_1[1] then
				var_56_2 = iter_56_1[2]
			end
		end
	end

	if not var_56_2 then
		for iter_56_2, iter_56_3 in ipairs(GameSetting.exclusive_skill_level_up_type.value) do
			if arg_56_0 == iter_56_3[1] then
				var_56_2 = iter_56_3[2]
			end
		end
	end

	if not var_56_2 then
		for iter_56_4, iter_56_5 in ipairs(GameSetting.exclusive_skill_damage_type.value) do
			if arg_56_0 == iter_56_5[1] then
				-- block empty
			end
		end
	end

	return GetCfgDescriptionWithValue(var_56_0.desc[1], arg_56_1 == 0 and EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * 1, arg_56_0) or arg_56_1 < var_56_0.lvmax and (arg_56_2 and EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * arg_56_1, arg_56_0) or EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * arg_56_1, arg_56_0) .. string.format(GetTips("EQUIP_HERO_SKILL_NEXT_LEVEL"), EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * (arg_56_1 + 1), arg_56_0))) or EquipTools.Calculate(var_56_0.upgrade / var_56_0.percent * arg_56_1, arg_56_0))
end

function var_0_0.GetSkillDesc(arg_57_0, arg_57_1, arg_57_2)
	local var_57_0 = EquipSkillCfg[arg_57_0]
	local var_57_2 = false

	if not var_57_2 then
		for iter_57_0, iter_57_1 in ipairs(GameSetting.exclusive_skill_cd_type.value) do
			if arg_57_0 == iter_57_1[1] then
				var_57_2 = iter_57_1[2]
			end
		end
	end

	if not var_57_2 then
		for iter_57_2, iter_57_3 in ipairs(GameSetting.exclusive_skill_level_up_type.value) do
			if arg_57_0 == iter_57_3[1] then
				var_57_2 = iter_57_3[2]
			end
		end
	end

	if not var_57_2 then
		for iter_57_4, iter_57_5 in ipairs(GameSetting.exclusive_skill_damage_type.value) do
			if arg_57_0 == iter_57_5[1] then
				var_57_2 = iter_57_5[2]
			end
		end
	end

	if var_57_2 then
		-- block empty
	end

	return GetCfgDescriptionWithValue(var_57_0.desc[1], arg_57_1 == 0 and EquipTools.Calculate(var_57_0.upgrade / var_57_0.percent * 1, arg_57_0) or arg_57_1 < var_57_0.lvmax and EquipTools.Calculate(var_57_0.upgrade / var_57_0.percent * arg_57_1, arg_57_0) .. string.format(GetTips("EQUIP_HERO_SKILL_NEXT_LEVEL"), EquipTools.Calculate(var_57_0.upgrade / var_57_0.percent * (arg_57_1 + 1), arg_57_0)) or EquipTools.Calculate(var_57_0.upgrade / var_57_0.percent * arg_57_1, arg_57_0))
end

function var_0_0.GetSkillDescWithoutNext(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = EquipSkillCfg[arg_58_0]
	local var_58_2 = false

	if not var_58_2 then
		for iter_58_0, iter_58_1 in ipairs(GameSetting.exclusive_skill_cd_type.value) do
			if arg_58_0 == iter_58_1[1] then
				var_58_2 = iter_58_1[2]
			end
		end
	end

	if not var_58_2 then
		for iter_58_2, iter_58_3 in ipairs(GameSetting.exclusive_skill_level_up_type.value) do
			if arg_58_0 == iter_58_3[1] then
				var_58_2 = iter_58_3[2]
			end
		end
	end

	if not var_58_2 then
		for iter_58_4, iter_58_5 in ipairs(GameSetting.exclusive_skill_damage_type.value) do
			if arg_58_0 == iter_58_5[1] then
				var_58_2 = iter_58_5[2]
			end
		end
	end

	if var_58_2 then
		-- block empty
	end

	return GetCfgDescriptionWithValue(var_58_0.desc[1], arg_58_1 == 0 and EquipTools.Calculate(var_58_0.upgrade / var_58_0.percent * 1, arg_58_0) or EquipTools.Calculate(var_58_0.upgrade / var_58_0.percent * arg_58_1, arg_58_0))
end

function var_0_0.Calculate(arg_59_0, arg_59_1)
	if table.indexof(GameDisplayCfg.equip_hero_skill_int.value, arg_59_1) then
		return arg_59_0
	else
		return string.format("%.1f%%", arg_59_0)
	end
end

function var_0_0.GetIsHide(arg_60_0)
	hideList = HideInfoData:GetEquipSuitHideList()

	return hideList[EquipCfg[arg_60_0].suit] or false
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

function var_0_0:RefreshSkillData(arg_62_1, arg_62_2)
	local var_62_0 = {}

	if arg_62_1 and arg_62_2 then
		local var_62_1, var_62_2, var_62_3 = EquipTools.CountHeroTotalSkill(arg_62_2:GetEquipDataList(arg_62_1), HeroData:GetHeroData(arg_62_1), true)

		for iter_62_0, iter_62_1 in pairs(var_62_1) do
			var_62_0[iter_62_0] = {
				id = iter_62_0,
				num = iter_62_1,
				isAdd = var_62_2,
				location = var_62_3[iter_62_0]
			}
		end
	else
		for iter_62_2, iter_62_3 in ipairs((self:GetTotalSkill())) do
			var_62_0[iter_62_3.id] = {
				id = iter_62_3.id,
				num = iter_62_3.num,
				location = {
					{
						isEquip = true,
						id = self.equip_id,
						level = iter_62_3.num,
						prefab_id = self.prefab_id
					}
				}
			}
		end
	end

	return var_62_0
end

return var_0_0
