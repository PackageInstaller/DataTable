EquipStruct = class("EquipStruct")

function EquipStruct.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.equip_id = arg_1_1
	arg_1_0.prefab_id = arg_1_2
	arg_1_0.exp = 0
	arg_1_0.is_lock = false
	arg_1_0.now_break_level = 0
	arg_1_0.enchant = {}
	arg_1_0.enchant_preview = {}
	arg_1_0.race = 0
	arg_1_0.race_preview = 0
	arg_1_0.equipConfig = EquipCfg[arg_1_0.prefab_id]
	arg_1_0.star = arg_1_0.equipConfig and arg_1_0.equipConfig.starlevel or 0
end

function EquipStruct.ParseServerData(arg_2_0, arg_2_1)
	arg_2_0.equip_id = arg_2_1.equip_id
	arg_2_0.prefab_id = arg_2_1.prefab_id
	arg_2_0.exp = arg_2_1.exp or 0
	arg_2_0.is_lock = arg_2_1.is_lock or false
	arg_2_0.now_break_level = arg_2_1.now_break_level or 0
	arg_2_0.enchant = {}
	arg_2_0.enchant_preview = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.enchant_slot_list) do
		local var_2_0 = iter_2_1.id
		local var_2_1 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.effect_list) do
			table.insert(var_2_1, {
				id = iter_2_3.id,
				num = iter_2_3.level
			})
		end

		local var_2_2 = {}

		for iter_2_4, iter_2_5 in ipairs(iter_2_1.preview_list) do
			local var_2_3 = {}

			for iter_2_6, iter_2_7 in ipairs(iter_2_5.effect_list) do
				table.insert(var_2_3, {
					id = iter_2_7.id,
					num = iter_2_7.level
				})
			end

			table.insert(var_2_2, var_2_3)
		end

		arg_2_0.enchant[var_2_0] = var_2_1
		arg_2_0.enchant_preview[var_2_0] = var_2_2
	end

	arg_2_0.race = arg_2_1.race or 0
	arg_2_0.race_preview = arg_2_1.race_preview or 0
	arg_2_0.equipConfig = EquipCfg[arg_2_0.prefab_id]
	arg_2_0.star = arg_2_0.equipConfig and arg_2_0.equipConfig.starlevel or 0
end

function EquipStruct.GetBreakCostReturn(arg_3_0)
	local var_3_0 = arg_3_0.equipConfig.starlevel
	local var_3_1 = (GameSetting.equip_break_cost_return and GameSetting.equip_break_cost_return.value or {})[var_3_0]
	local var_3_2 = {}

	if var_3_1 ~= nil then
		for iter_3_0 = 1, arg_3_0.now_break_level do
			local var_3_3 = var_3_1[iter_3_0]

			if var_3_3 ~= nil then
				local var_3_4 = EquipMaterialCfg[var_3_3].item_list or {}

				for iter_3_1 = 2, #var_3_4 do
					table.insert(var_3_2, var_3_4[iter_3_1])
				end
			end
		end
	end

	if var_3_0 > 4 then
		local var_3_5 = GameSetting.equip_resolve_num and GameSetting.equip_resolve_num.value[var_3_0 - 4]

		if var_3_5 then
			table.insert(var_3_2, var_3_5)
		end
	end

	return var_3_2
end

function EquipStruct.GetLevel(arg_4_0)
	local var_4_0 = arg_4_0.exp or 0
	local var_4_1 = arg_4_0:GetMaxLv()
	local var_4_2 = "exp_sum_" .. arg_4_0.equipConfig.starlevel

	for iter_4_0 = 2, var_4_1 do
		if var_4_0 < EquipExpCfg[iter_4_0][var_4_2] then
			return iter_4_0 - 1
		end
	end

	return var_4_1
end

function EquipStruct.GetMaxLv(arg_5_0)
	return arg_5_0.equipConfig.max_level[arg_5_0.now_break_level + 1]
end

function EquipStruct.GetPos(arg_6_0)
	return arg_6_0.equipConfig and arg_6_0.equipConfig.pos or 0
end

function EquipStruct.GetSuit(arg_7_0)
	return arg_7_0.equipConfig and arg_7_0.equipConfig.suit or 0
end

function EquipStruct.GetEquipHero(arg_8_0)
	return HeroData:GetEquipMap()[arg_8_0.equip_id]
end

function EquipStruct.GetBaseSkill(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = arg_9_0.equipConfig

	for iter_9_0, iter_9_1 in ipairs(var_9_1.effect) do
		local var_9_2 = var_9_1.effect_unlock_level[iter_9_0] or 0

		if iter_9_1[1] then
			table.insert(var_9_0, {
				id = iter_9_1[1],
				num = iter_9_1[2],
				unlockLevel = var_9_2
			})
		end
	end

	return var_9_0
end

function EquipStruct.GetTotalSkill(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = {}

	table.insertto(var_10_0, arg_10_0:GetBaseSkill())

	for iter_10_0, iter_10_1 in pairs(clone(arg_10_0.enchant)) do
		table.insertto(var_10_0, iter_10_1)
	end

	for iter_10_2, iter_10_3 in ipairs(var_10_0) do
		if iter_10_3.unlockLevel and arg_10_0:GetLevel() < iter_10_3.unlockLevel then
			local var_10_4 = iter_10_3.id .. iter_10_3.unlockLevel

			var_10_1[var_10_4] = iter_10_3

			table.insert(var_10_3, var_10_4)
		elseif var_10_1[iter_10_3.id] then
			var_10_1[iter_10_3.id].num = var_10_1[iter_10_3.id].num + iter_10_3.num
		else
			var_10_1[iter_10_3.id] = iter_10_3

			table.insert(var_10_3, iter_10_3.id)
		end
	end

	for iter_10_4 = 1, #var_10_3 do
		table.insert(var_10_2, var_10_1[var_10_3[iter_10_4]])
	end

	return var_10_2
end

function EquipStruct.ContainSkill(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:GetTotalSkill()

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_1 = false

		for iter_11_2, iter_11_3 in pairs(var_11_0) do
			if iter_11_3.id == iter_11_1 then
				var_11_1 = true

				break
			end
		end

		if var_11_1 == false then
			return false
		end
	end

	return true
end

function EquipStruct.GetSkillLevel(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = arg_12_0:GetLevel()
	local var_12_2 = EquipCfg[arg_12_0.prefab_id].slot_open_level or {}
	local var_12_3 = arg_12_0:GetBaseSkill()

	for iter_12_0, iter_12_1 in pairs(var_12_3) do
		if iter_12_1.id == arg_12_1 and var_12_2[iter_12_0] and var_12_1 >= var_12_2[iter_12_0] then
			var_12_0 = var_12_0 + iter_12_1.num
		end
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0.enchant) do
		for iter_12_4, iter_12_5 in pairs(iter_12_3) do
			if iter_12_5.id == arg_12_1 then
				var_12_0 = var_12_0 + iter_12_5.num
			end
		end
	end

	return var_12_0
end

function EquipStruct.GetUpgradeCost(arg_13_0)
	local var_13_0 = arg_13_0.now_break_level + 1
	local var_13_1 = arg_13_0.equipConfig.break_cost[var_13_0]
	local var_13_2 = EquipMaterialCfg[var_13_1]

	if not var_13_2 then
		return {}
	end

	local var_13_3 = 0
	local var_13_4 = {}

	for iter_13_0, iter_13_1 in pairs(var_13_2.item_list) do
		if iter_13_1[1] == 2 then
			var_13_3 = iter_13_1[2]
		else
			table.insert(var_13_4, iter_13_1)
		end
	end

	return {
		item_list = var_13_4,
		money = var_13_3
	}
end

function EquipStruct.GetEnchantCount(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.enchant) do
		if #iter_14_1 > 0 then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0
end

local var_0_0 = singletonClass("EquipData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = false
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = 1
local var_0_8 = 0
local var_0_9 = 0
local var_0_10 = 0
local var_0_11 = 1

function var_0_0.Init(arg_15_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = false
	var_0_4 = {}
	var_0_5 = {}
	var_0_7 = 1
	var_0_6 = {}
	autoDecompose_ = {}
end

function var_0_0.EquipInit(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		arg_16_0:AddEquip(iter_16_1)
	end

	arg_16_0:ResetEquipSort()
	manager.notify:Invoke(EQUIP_LIST_UPDATE)
end

function var_0_0.AddEquip(arg_17_0, arg_17_1)
	local var_17_0 = EquipStruct.New(arg_17_1.equip_id, arg_17_1.prefab_id)

	var_17_0:ParseServerData(arg_17_1)

	var_0_1[arg_17_1.equip_id] = var_17_0

	local var_17_1 = EquipCfg[arg_17_1.prefab_id].suit

	var_0_2[var_17_1] = var_0_2[var_17_1] or {}
	var_0_2[var_17_1][arg_17_1.equip_id] = true
	var_0_5[arg_17_1.prefab_id] = var_0_5[arg_17_1.prefab_id] and var_0_5[arg_17_1.prefab_id] + 1 or 1

	if not var_0_6[arg_17_1.prefab_id] then
		var_0_6[arg_17_1.prefab_id] = {}
	end

	if not table.indexof(var_0_6[arg_17_1.prefab_id], arg_17_1.equip_id) then
		table.insert(var_0_6[arg_17_1.prefab_id], arg_17_1.equip_id)
	end
end

function var_0_0.ApplyEquipStrengthSuccess(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = arg_18_1
	local var_18_1 = arg_18_2
	local var_18_2 = arg_18_4
	local var_18_3 = var_0_1[var_18_0].exp + var_18_2

	var_0_1[var_18_0].exp = var_18_3

	arg_18_0:ResetEquipSort()
end

function var_0_0.ApplyLockEquipSuccess(arg_19_0, arg_19_1, arg_19_2)
	var_0_1[arg_19_1].is_lock = arg_19_2
end

function var_0_0.ApplyUpgradeEquipSuccess(arg_20_0, arg_20_1, arg_20_2)
	arg_20_2 = arg_20_2 or 1

	local var_20_0 = arg_20_1
	local var_20_1 = var_0_1[var_20_0].prefab_id
	local var_20_2 = EquipCfg[var_20_1]
	local var_20_3 = var_0_1[var_20_0].now_break_level + arg_20_2
	local var_20_4 = var_20_2.max_level[var_20_3]

	var_0_1[var_20_0].now_break_level = var_0_1[var_20_0].now_break_level + arg_20_2

	arg_20_0:ResetEquipSort()

	return var_0_1[var_20_0].exp
end

function var_0_0.RemoveEquip(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.equip_id
	local var_21_1 = var_0_1[var_21_0].prefab_id
	local var_21_2 = EquipCfg[var_21_1].suit

	var_0_2[var_21_2] = var_0_2[var_21_2] or {}
	var_0_2[var_21_2][var_21_0] = nil
	var_0_1[var_21_0] = nil
	var_0_5[var_21_1] = var_0_5[var_21_1] - 1

	for iter_21_0, iter_21_1 in pairs(var_0_4) do
		for iter_21_2, iter_21_3 in pairs(iter_21_1) do
			if var_21_0 == iter_21_3.equip_id then
				table.remove(iter_21_1, iter_21_2)

				break
			end
		end
	end

	for iter_21_4, iter_21_5 in pairs(var_0_6[var_21_1]) do
		if var_21_0 == iter_21_5 then
			table.remove(var_0_6[var_21_1], iter_21_4)

			break
		end
	end

	var_0_3 = false
end

function var_0_0.EquipBagFull(arg_22_0, arg_22_1)
	var_0_3 = arg_22_1
end

function var_0_0.AddPreEnchant(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = var_0_1[arg_23_1]

	if var_23_0 and var_23_0.enchant_preview[arg_23_2] then
		local var_23_1 = arg_23_3.effect_list
		local var_23_2 = {}

		for iter_23_0, iter_23_1 in ipairs(var_23_1) do
			table.insert(var_23_2, {
				id = iter_23_1.id,
				num = iter_23_1.level
			})
		end

		table.insert(var_23_0.enchant_preview[arg_23_2], var_23_2)
	end
end

function var_0_0.ConfirmEnchant(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = var_0_1[arg_24_1]

	if var_24_0 and var_24_0.enchant_preview[arg_24_2] then
		local var_24_1 = table.remove(var_24_0.enchant_preview[arg_24_2], arg_24_4)

		if arg_24_3 and var_24_1 then
			var_24_0.enchant[arg_24_2] = var_24_1
		end
	end
end

function var_0_0.DirectionalEnchant(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = var_0_1[arg_25_1]

	if var_25_0 then
		var_25_0.enchant[arg_25_2][arg_25_3] = arg_25_4
	end
end

function var_0_0.GiveUpAllEnchant(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = var_0_1[arg_26_1]

	if var_26_0 and var_26_0.enchant_preview[arg_26_2] then
		var_26_0.enchant_preview[arg_26_2] = {}
	end
end

function var_0_0.SetPreRace(arg_27_0, arg_27_1, arg_27_2)
	if var_0_1[arg_27_1] then
		var_0_1[arg_27_1].race_preview = arg_27_2
	end
end

function var_0_0.ConfirmRace(arg_28_0, arg_28_1, arg_28_2)
	if var_0_1[arg_28_1] then
		if arg_28_2 then
			var_0_1[arg_28_1].race = var_0_1[arg_28_1].race_preview
		end

		var_0_1[arg_28_1].race_preview = 0

		arg_28_0:ResetEquipSort()
	end
end

function var_0_0.GetEquipList(arg_29_0)
	return var_0_1
end

function var_0_0.GetEquipData(arg_30_0, arg_30_1)
	local var_30_0 = var_0_1[arg_30_1]

	if var_30_0 then
		return var_30_0
	else
		return nil
	end
end

function var_0_0.GetEquipPrefabMap(arg_31_0, arg_31_1)
	return var_0_6[arg_31_1]
end

function var_0_0.GetEquipBagFull(arg_32_0)
	return var_0_3
end

function var_0_0.GetEquipListBySort(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1 .. arg_33_2

	if var_0_4[var_33_0] then
		return var_0_4[var_33_0]
	end

	var_0_4[var_33_0] = EquipTools.EquipSort(var_0_1, arg_33_1, arg_33_2)

	return var_0_4[var_33_0]
end

function var_0_0.GetEquipListComplex(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5)
	local var_34_0 = EquipTools.EquipSort(var_0_1, arg_34_1, arg_34_2)
	local var_34_1 = type(arg_34_4) == "table"
	local var_34_2 = type(arg_34_5) == "table"

	arg_34_3 = arg_34_3 or 0

	if arg_34_4 == nil or var_34_1 and #arg_34_4 == 0 then
		arg_34_4 = 0
	end

	if arg_34_5 == nil or var_34_2 and #arg_34_5 == 0 then
		arg_34_5 = 0
	end

	local var_34_3 = {}

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		local var_34_4 = EquipCfg[iter_34_1.prefab_id]

		if (arg_34_3 == 0 or var_34_4.pos == arg_34_3) and (arg_34_4 == 0 or var_34_4.suit == arg_34_4 or var_34_1 and table.indexof(arg_34_4, var_34_4.suit) or arg_34_4 == EquipConst.EX_EQUIP_SUIT_ID and var_34_4.suit >= EquipConst.EX_EQUIP_SUIT_ID) and (arg_34_5 == 0 or iter_34_1:ContainSkill(arg_34_5)) then
			table.insert(var_34_3, iter_34_1)
		end
	end

	return var_34_3
end

function var_0_0.ResetEquipSort(arg_35_0)
	var_0_4 = {}
end

function var_0_0.GetEnchantMaterial(arg_36_0)
	local var_36_0 = GameSetting.equip_enchant_cost and GameSetting.equip_enchant_cost.value or {}
	local var_36_1 = {}

	for iter_36_0, iter_36_1 in pairs(var_36_0) do
		local var_36_2 = EquipMaterialCfg[iter_36_1] or {}
		local var_36_3 = var_36_2.item_list[1][2]
		local var_36_4 = var_36_2.item_list[2][1]
		local var_36_5 = var_36_2.item_list[2][2]

		table.insert(var_36_1, {
			id = var_36_4,
			number = var_36_5,
			money = var_36_3
		})
	end

	return var_36_1
end

function var_0_0.GetLockEnchantMaterial(arg_37_0)
	local var_37_0 = GameSetting.equip_enchant_lock_cost and GameSetting.equip_enchant_lock_cost.value or {}
	local var_37_1 = arg_37_0:GetEnchantMaterial()
	local var_37_2 = clone(var_37_1)

	for iter_37_0, iter_37_1 in pairs(var_37_0) do
		local var_37_3 = EquipMaterialCfg[iter_37_1] or {}
		local var_37_4 = var_37_3.item_list[1][2]
		local var_37_5 = var_37_3.item_list[2][1]
		local var_37_6 = var_37_3.item_list[2][2]

		for iter_37_2, iter_37_3 in ipairs(var_37_2) do
			if iter_37_3.id == var_37_5 then
				var_37_2[iter_37_2].id = var_37_5
				var_37_2[iter_37_2].number = var_37_6
				var_37_2[iter_37_2].money = var_37_4
				var_37_2[iter_37_2].lock = true
			end
		end
	end

	return var_37_2
end

function var_0_0.GetRaceMaterial(arg_38_0, arg_38_1)
	local var_38_0

	if arg_38_1 == 1 then
		var_38_0 = GameSetting.equip_reset_cost and GameSetting.equip_reset_cost.value or {}
	else
		var_38_0 = GameSetting.equip_hero_reset_cost and GameSetting.equip_hero_reset_cost.value or {}
	end

	local var_38_1 = EquipMaterialCfg[var_38_0[1] or 0]
	local var_38_2 = 0
	local var_38_3 = 0
	local var_38_4 = 0

	for iter_38_0, iter_38_1 in pairs(var_38_1.item_list) do
		if iter_38_1[1] == 2 then
			var_38_4 = iter_38_1[2]
		else
			var_38_2 = iter_38_1[1]
			var_38_3 = iter_38_1[2]
		end
	end

	return {
		id = var_38_2,
		number = var_38_3,
		money = var_38_4
	}
end

function var_0_0.GetEquipCnt(arg_39_0, arg_39_1)
	return var_0_5[arg_39_1] or 0
end

function var_0_0.GetSelectEnchantMaterialIndex(arg_40_0)
	return var_0_7
end

function var_0_0.SetSelectEnchantMaterialIndex(arg_41_0, arg_41_1)
	var_0_7 = arg_41_1
end

function var_0_0.SetEnchatLockIndex(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	var_0_8 = arg_42_1
	var_0_9 = arg_42_2
	var_0_10 = arg_42_3
end

function var_0_0.GetIsSetLockView(arg_43_0, arg_43_1, arg_43_2)
	if var_0_8 == arg_43_1 and var_0_9 == arg_43_2 then
		return var_0_10
	end

	return false
end

function var_0_0.GetRaceIndex(arg_44_0)
	return var_0_11
end

function var_0_0.SetRaceIndex(arg_45_0, arg_45_1)
	var_0_11 = arg_45_1
end

function var_0_0.GetInheritCost(arg_46_0, arg_46_1)
	local var_46_0 = GameSetting.equip_inherit_cost and GameSetting.equip_inherit_cost.value or {}
	local var_46_1 = {}
	local var_46_2 = 0

	if EquipSuitCfg[arg_46_1] ~= nil then
		local var_46_3 = EquipSuitCfg[arg_46_1].inherit_cost_type
		local var_46_4

		if var_46_3 == 1 then
			var_46_4 = EquipMaterialCfg[var_46_0[1] or 0]
		else
			var_46_4 = EquipMaterialCfg[var_46_0[2] or 0]
		end

		for iter_46_0, iter_46_1 in pairs(var_46_4.item_list) do
			local var_46_5 = {}

			if iter_46_1[1] == 2 then
				var_46_2 = iter_46_1[2]
			else
				var_46_5.id = iter_46_1[1]
				var_46_5.number = iter_46_1[2]
				var_46_1[#var_46_1 + 1] = var_46_5
			end
		end
	end

	return var_46_1, var_46_2
end

function var_0_0.InitAutoDecompose(arg_47_0, arg_47_1)
	for iter_47_0, iter_47_1 in ipairs(arg_47_1.type_list) do
		autoDecompose_[iter_47_1] = true
	end
end

function var_0_0.UpdateAutoDecompose(arg_48_0, arg_48_1, arg_48_2)
	autoDecompose_[arg_48_1] = arg_48_2
end

function var_0_0.GetAutoDecompose(arg_49_0, arg_49_1)
	return autoDecompose_[arg_49_1] == true
end

return var_0_0
