local var_0_0 = {
	SortChipManager = function(arg_1_0)
		local var_1_0 = ChipData:GetChipManagerList()
		local var_1_1 = {}
		local var_1_2 = {}
		local var_1_3 = {}
		local var_1_4 = ChipData:GetUnlockChipManagerIDList()

		for iter_1_0, iter_1_1 in pairs(var_1_0) do
			if iter_1_0 ~= arg_1_0 then
				if table.keyof(var_1_4, iter_1_0) then
					table.insert(var_1_1, iter_1_0)
				elseif IsConditionAchieved(ChipCfg[iter_1_0].new_condition) then
					table.insert(var_1_2, iter_1_0)
				else
					table.insert(var_1_3, iter_1_0)
				end
			end
		end

		table.sort(var_1_1, function(arg_2_0, arg_2_1)
			return arg_2_0 < arg_2_1
		end)
		table.sort(var_1_2, function(arg_3_0, arg_3_1)
			return arg_3_0 < arg_3_1
		end)
		table.sort(var_1_3, function(arg_4_0, arg_4_1)
			return arg_4_0 < arg_4_1
		end)
		table.insertto(var_1_1, var_1_2)
		table.insertto(var_1_1, var_1_3)

		if arg_1_0 ~= 0 then
			table.insert(var_1_1, 1, arg_1_0)
		end

		if manager.guide:IsPlaying() then
			local var_1_5 = table.indexof(var_1_1, 6)

			if var_1_5 then
				table.remove(var_1_1, var_1_5)
				table.insert(var_1_1, 1, 6)
			end
		end

		return var_1_1
	end
}

function var_0_0.SortChip(arg_5_0, arg_5_1)
	local var_5_0 = ChipData:GetChipManagerList()[arg_5_1]

	return var_0_0.SortChipList(var_5_0, arg_5_0, arg_5_1)
end

function var_0_0.SortChipList(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = {}
	local var_6_4

	if arg_6_3 then
		var_6_4 = ChipData:GetUnlockHeroChipIDList()
	else
		var_6_4 = ChipData:GetUnlockChipIDList()
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if not table.keyof(arg_6_0, iter_6_1) then
			if table.keyof(var_6_4, iter_6_1) then
				table.insert(var_6_1, iter_6_1)
			else
				local var_6_5

				if ChipCfg[iter_6_1].new_condition > 0 then
					if ChipCfg[iter_6_1].spec_char > 0 then
						var_6_5 = IsConditionAchieved(ChipCfg[iter_6_1].new_condition, {
							heroId = ChipCfg[iter_6_1].spec_char
						})
					else
						var_6_5 = IsConditionAchieved(ChipCfg[iter_6_1].new_condition)
					end
				else
					var_6_5 = ItemTools.getItemNum(ChipCfg[iter_6_1].cost_condition[1][1]) >= ChipCfg[iter_6_1].cost_condition[1][1] and true or false
				end

				if var_6_5 then
					table.insert(var_6_2, iter_6_1)
				else
					table.insert(var_6_3, iter_6_1)
				end
			end
		else
			table.insert(var_6_0, iter_6_1)
		end
	end

	var_0_0.SortRegular(var_6_1)
	var_0_0.SortRegular(var_6_2)
	var_0_0.SortRegular(var_6_3)
	table.insertto(var_6_0, var_6_1)
	table.insertto(var_6_0, var_6_2)
	table.insertto(var_6_0, var_6_3)

	return var_6_0
end

function var_0_0.GetChipCanLocked(arg_7_0)
	if not ChipCfg[arg_7_0] then
		return false
	end

	local var_7_0 = ChipCfg[arg_7_0].new_condition

	return (IsConditionAchieved(var_7_0))
end

function var_0_0.SortRegular(arg_8_0)
	table.sort(arg_8_0, function(arg_9_0, arg_9_1)
		local var_9_0 = ChipCfg[arg_9_0].spec_char
		local var_9_1 = ChipCfg[arg_9_1].spec_char

		if var_9_0 ~= 0 and var_9_1 == 0 then
			return false
		end

		return arg_9_0 < arg_9_1
	end)
end

function var_0_0.FormatChipByRoleType(arg_10_0)
	local var_10_0 = {}

	if type(arg_10_0) ~= "table" then
		return var_10_0
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0) do
		var_10_0[ChipCfg[iter_10_1].role_type_id] = iter_10_1
	end

	return var_10_0
end

function var_0_0.GetChipTypeList(arg_11_0)
	local var_11_0 = {
		-1,
		0
	}
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		local var_11_2 = ChipCfg[iter_11_1].spec_char

		if not table.keyof(var_11_1, var_11_2) and var_11_2 ~= 0 then
			table.insert(var_11_1, var_11_2)
		end
	end

	local var_11_3 = HeroTools.SortHero(var_11_1)

	table.insertto(var_11_0, var_11_3)

	return var_11_0
end

function var_0_0.GetChipTypeCntList(arg_12_0)
	local var_12_0 = {
		[-1] = {}
	}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
		local var_12_1 = ChipCfg[iter_12_1].spec_char

		var_12_0[var_12_1] = var_12_0[var_12_1] or {}

		table.insert(var_12_0[var_12_1], iter_12_1)
		table.insert(var_12_0[-1], iter_12_1)
	end

	return var_12_0
end

function var_0_0.SortScheme(arg_13_0)
	local var_13_0 = ChipData:GetChipManagerList()[arg_13_0]
	local var_13_1 = ChipData:GetSchemeList()
	local var_13_2 = {
		{
			id = 0,
			name = GetTips("CURRENT_SCHEME"),
			chipList = var_13_0
		}
	}

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		local var_13_3 = #var_13_0 == #iter_13_1.chipList

		for iter_13_2, iter_13_3 in ipairs(iter_13_1.chipList) do
			if not table.keyof(var_13_0, iter_13_3) then
				var_13_3 = false

				break
			end
		end

		if var_13_3 then
			var_13_2[1] = clone(iter_13_1)
		else
			table.insert(var_13_2, clone(iter_13_1))
		end
	end

	local var_13_4 = GameSetting.ai_chip_proposal_num_max.value[1] + (var_13_2[1].id == 0 and 1 or 0)

	for iter_13_4 = #var_13_2 + 1, var_13_4 do
		table.insert(var_13_2, {
			id = -1
		})
	end

	return var_13_2
end

function var_0_0.InsertChip(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0, var_14_1 = var_0_0.InternalInsertChip(arg_14_0, arg_14_1)

	if var_14_0 == true then
		if arg_14_2 then
			arg_14_2(arg_14_0)
		end

		ShowTips("CHIP_USE_SUCCESS")
		manager.notify:Invoke(ENABLED_CHIP)
	elseif var_14_1 then
		ShowTips(var_14_1)
	end
end

function var_0_0.RemoveChip(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0, var_15_1 = var_0_0.InternalRemoveChip(arg_15_0, arg_15_1)

	if var_15_0 == true then
		if arg_15_2 then
			arg_15_2(arg_15_0)
		end

		ShowTips("CHIP_UNLOAD_SUCCESS")
		manager.notify:Invoke(ENABLED_CHIP)
	elseif var_15_1 then
		ShowTips(var_15_1)
	end
end

function var_0_0.InternalInsertChip(arg_16_0, arg_16_1)
	local var_16_0 = true
	local var_16_1
	local var_16_2 = false
	local var_16_3 = 0
	local var_16_4 = ChipCfg[arg_16_1].spec_char
	local var_16_5 = ChipCfg.get_id_list_by_spec_char[var_16_4]

	for iter_16_0, iter_16_1 in ipairs(arg_16_0) do
		if ChipCfg[iter_16_1].spec_char ~= 0 and table.keyof(var_16_5, iter_16_1) and iter_16_1 ~= arg_16_1 then
			var_16_2 = true
			var_16_3 = iter_16_1

			break
		end
	end

	if not table.indexof(arg_16_0, arg_16_1) and not var_16_2 and #arg_16_0 >= GameSetting.ai_secondary_chip_equip_num.value[1] then
		var_16_0 = false
		var_16_1 = "CHIP_CNT_MORE_THEN_MAX"

		return var_16_0, var_16_1
	end

	if var_16_2 then
		local var_16_6 = table.indexof(arg_16_0, var_16_3)

		if var_16_6 then
			table.remove(arg_16_0, var_16_6)
		end
	end

	table.insert(arg_16_0, arg_16_1)

	return var_16_0, var_16_1
end

function var_0_0.InternalRemoveChip(arg_17_0, arg_17_1)
	local var_17_0 = table.indexof(arg_17_0, arg_17_1)

	if var_17_0 then
		table.remove(arg_17_0, var_17_0)
	end

	return true
end

function var_0_0.GetChipManagerIcon(arg_18_0)
	local var_18_0 = ChipCfg[arg_18_0]

	if not var_18_0 then
		Debug.Log(string.format("<color=ff0000>ChipCfg has no ID(%d)</color>", arg_18_0))

		return
	end

	return getSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. var_18_0.picture_id)
end

function var_0_0.GetChipManagerIconPath(arg_19_0)
	local var_19_0 = ChipCfg[arg_19_0]

	if not var_19_0 then
		Debug.Log(string.format("<color=ff0000>ChipCfg has no ID(%d)</color>", arg_19_0))

		return
	end

	return "TextureConfig/Managecat_l/" .. var_19_0.picture_id
end

function var_0_0.GetHeroChipIDList(arg_20_0)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(ChipCfg.get_id_list_by_spec_char[arg_20_0]) do
		if ChipCfg[iter_20_1].type_id ~= ChipConst.TYPE_CHAR_CHIP then
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function var_0_0.HasUnlockCharChip()
	return #ChipData:GetUnlockCharChipIDList() > 0
end

function var_0_0.CanUnlockAnyCharChip()
	return manager.redPoint:getTipValue(RedPointConst.CHIP_CHAR_CHIP) > 0
end

function var_0_0.IsCharChipBaseUnlock(arg_23_0)
	return ChipData:IsUnlockCharChip(arg_23_0)
end

function var_0_0.IsCharChipBaseCanUnlock(arg_24_0)
	local var_24_0 = ChipCfg[arg_24_0].module_condition

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if not IsConditionAchieved(iter_24_1) then
			return false
		end
	end

	return true
end

function var_0_0.IsCharChipExtraUnlock(arg_25_0)
	return ChipData:IsUnlockCharChip(arg_25_0)
end

function var_0_0.IsCharChipExtraCanUnlock(arg_26_0)
	return ChipTools.IsCharChipBaseCanUnlock(arg_26_0)
end

function var_0_0.GetCharChipExtraIDList(arg_27_0)
	if arg_27_0 == 0 then
		return {}
	end

	return ChipCfg.get_id_list_by_spec_char[arg_27_0]
end

function var_0_0.GetCharChipExtraIDListUnlock(arg_28_0)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(ChipTools.GetCharChipExtraIDList(arg_28_0)) do
		if ChipTools.IsCharChipExtraUnlock(iter_28_1) then
			table.insert(var_28_0, iter_28_1)
		end
	end

	return var_28_0
end

function var_0_0.GetNextCharChipIDToUnlock(arg_29_0)
	if not ChipTools.IsCharChipBaseUnlock(arg_29_0) then
		return arg_29_0
	end

	local var_29_0 = ChipTools.GetCharChipExtraIDList(arg_29_0)
	local var_29_1 = ChipTools.GetCharChipExtraIDListUnlock(arg_29_0)

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		if not table.keyof(var_29_1, iter_29_1) then
			return iter_29_1
		end
	end

	return 0
end

function var_0_0.GetAllCharChipBaseIDList(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(ChipCfg.all) do
		local var_30_1 = ChipCfg[iter_30_1]

		if var_30_1.type_id == ChipConst.TYPE_CHAR_CHIP and var_30_1.role_type_id == ChipConst.ROLE_TYPE_CHAR_CHIP_BASE then
			table.insert(var_30_0, iter_30_1)
		end
	end

	if arg_30_0 then
		var_30_0 = ChipTools.SortCharChipBaseIDList(var_30_0)
	end

	return var_30_0
end

function var_0_0.SortCharChipBaseIDList(arg_31_0)
	local var_31_0 = {}
	local var_31_1 = {}
	local var_31_2 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0) do
		local var_31_3 = ChipCfg[iter_31_1]
		local var_31_4 = var_0_0.IsCharChipBaseUnlock(iter_31_1)
		local var_31_5 = var_0_0.IsCharChipBaseCanUnlock(iter_31_1)
		local var_31_6 = 0

		if var_31_4 then
			var_31_6 = #var_0_0.GetCharChipExtraIDListUnlock(iter_31_1)
		end

		if var_31_5 and not var_31_4 then
			table.insert(var_31_0, {
				id = iter_31_1,
				sort = var_31_3.sort
			})
		elseif var_31_4 then
			table.insert(var_31_1, {
				id = iter_31_1,
				sort = var_31_3.sort,
				effectCnt = var_31_6
			})
		else
			local var_31_7 = 0

			for iter_31_2, iter_31_3 in ipairs(var_31_3.module_condition) do
				if not IsConditionAchieved(iter_31_3) then
					var_31_7 = var_31_7 + 1
				end
			end

			table.insert(var_31_2, {
				id = iter_31_1,
				sort = var_31_3.sort,
				unfinishCnt = var_31_7
			})
		end
	end

	table.sort(var_31_0, function(arg_32_0, arg_32_1)
		return arg_32_0.sort > arg_32_1.sort
	end)
	table.sort(var_31_1, function(arg_33_0, arg_33_1)
		if arg_33_0.effectCnt ~= arg_33_1.effectCnt then
			return arg_33_0.effectCnt > arg_33_1.effectCnt
		else
			return arg_33_0.sort > arg_33_1.sort
		end
	end)
	table.sort(var_31_2, function(arg_34_0, arg_34_1)
		if arg_34_0.unfinishCnt ~= arg_34_1.unfinishCnt then
			return arg_34_0.unfinishCnt < arg_34_1.unfinishCnt
		else
			return arg_34_0.sort > arg_34_1.sort
		end
	end)

	local var_31_8 = {}

	for iter_31_4, iter_31_5 in ipairs(var_31_0) do
		table.insert(var_31_8, iter_31_5.id)
	end

	for iter_31_6, iter_31_7 in ipairs(var_31_1) do
		table.insert(var_31_8, iter_31_7.id)
	end

	for iter_31_8, iter_31_9 in ipairs(var_31_2) do
		table.insert(var_31_8, iter_31_9.id)
	end

	return var_31_8
end

function var_0_0.GetCharChipIcon(arg_35_0, arg_35_1)
	local var_35_0 = ChipCfg[arg_35_0]

	if not var_35_0 then
		Debug.Log(string.format("<color=ff0000>ChipCfg has no ID(%d)</color>", arg_35_0))

		return
	end

	local var_35_1 = tonumber(var_35_0.picture_id)
	local var_35_2 = HeroTools.HeroUsingSkinInfo(var_35_1).id

	if arg_35_1 then
		return getSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" .. var_35_2)
	end

	return getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_35_2)
end

function var_0_0.GetChipUnlockProgress()
	local var_36_0 = ChipTools.GetAllCharChipBaseIDList()
	local var_36_1 = ChipData:GetChipManagerList()
	local var_36_2 = #var_36_0 + #var_36_1
	local var_36_3 = 0

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if ChipTools.IsCharChipBaseUnlock(iter_36_1) then
			var_36_3 = var_36_3 + 1
		end
	end

	for iter_36_2, iter_36_3 in pairs(var_36_1) do
		if table.keyof(ChipData:GetUnlockChipManagerIDList(), iter_36_2) then
			var_36_3 = var_36_3 + 1
		end
	end

	return var_36_3 / var_36_2
end

return var_0_0
