local var_0_0 = {}

manager.net:Bind(50001, function(arg_1_0)
	ChipData:InitData(arg_1_0)
end)

function var_0_0.UpdateChipRed()
	for iter_2_0, iter_2_1 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_MANAGER]) do
		if not table.keyof(ChipData:GetUnlockChipManagerIDList(), iter_2_1) then
			local var_2_0 = ChipCfg[iter_2_1].new_condition

			if IsConditionAchieved(var_2_0) and JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) == false then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_MANAGER, iter_2_1), 1)
			end
		end
	end

	for iter_2_2, iter_2_3 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHAR_CHIP]) do
		if not table.keyof(ChipData:GetUnlockCharChipIDList(), iter_2_3) then
			local var_2_1 = ChipCfg[iter_2_3]

			if var_2_1.role_type_id == ChipConst.ROLE_TYPE_CHAR_CHIP_BASE then
				if ChipTools.IsCharChipBaseCanUnlock(iter_2_3) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_CHAR_BASE_CHIP, iter_2_3), 1)
				end
			elseif var_2_1.role_type_id == ChipConst.ROLE_TYPE_CHAR_CHIP_EXTRA and ChipTools.IsCharChipBaseUnlock(var_2_1.spec_char) and ChipTools.GetNextCharChipIDToUnlock(var_2_1.spec_char) == iter_2_3 and ChipTools.IsCharChipExtraCanUnlock(iter_2_3) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_CHAR_EXTRA_CHIP, iter_2_3), 1)
			end
		end
	end

	if table.length(ChipData:GetUnlockChipIDList()) <= 0 and manager.redPoint:getTipValue(RedPointConst.CHIP_MANAGER) <= 0 then
		return
	end

	for iter_2_4, iter_2_5 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]) do
		if not table.keyof(ChipData:GetUnlockChipIDList(), iter_2_5) and ChipTools.GetChipCanLocked(iter_2_5) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_CHIP, iter_2_5), 1)
		end
	end
end

function var_0_0.UnlockChipManager(arg_3_0)
	manager.net:SendWithLoadingNew(50002, {
		id = arg_3_0
	}, 50003, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			ShowTips("CHIP_MANAGER_UNLOCK_SUCCESS")
			ChipData:UnlockChipManager(arg_3_0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_MANAGER, arg_3_0), 0)
			print(" UnlockChipManager chipManagerID")
			manager.notify:Invoke(UNLOCK_CHIP_MANAGER)
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.UnlockChip(arg_5_0)
	manager.net:SendWithLoadingNew(50002, {
		id = arg_5_0
	}, 50003, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			ShowTips("CHIP_UNLOCK_SUCCESS")
			ChipData:UnlockChip(arg_5_0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_CHIP, arg_5_0), 0)
			manager.notify:Invoke(UNLOCK_CHIP)
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.UnlockHeroChip(arg_7_0)
	manager.net:SendWithLoadingNew(50002, {
		id = arg_7_0
	}, 50003, function(arg_8_0)
		if isSuccess(arg_8_0.result) then
			ShowTips("CHIP_HERO_UNLOCK_SUCCESS")
			ChipData:UnlockHeroChip(arg_7_0)

			local var_8_0 = ChipCfg[arg_7_0]
			local var_8_1

			if ChipCfg[arg_7_0].cost_condition ~= "" then
				var_8_1 = RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. var_8_0.spec_char .. "_" .. var_8_0.role_type_id .. "_" .. arg_7_0
			else
				var_8_1 = RedPointConst.CHIP_HERO_CHIP .. "_" .. var_8_0.spec_char .. "_" .. var_8_0.role_type_id .. "_" .. arg_7_0
			end

			manager.redPoint:setTip(var_8_1, 0)
			var_0_0.UpdateHeroChipRedPoint()
			manager.notify:CallUpdateFunc(HERO_CHIP_STATUS_UPDATE)
		else
			ShowTips(arg_8_0.result)
		end
	end)
end

function var_0_0.EnabledChipID(arg_9_0, arg_9_1)
	local var_9_0 = ChipData:GetChipManagerList()[arg_9_0]
	local var_9_1 = false
	local var_9_2 = 0
	local var_9_3 = ChipCfg[arg_9_1].spec_char
	local var_9_4 = ChipCfg.get_id_list_by_spec_char[var_9_3]

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if ChipCfg[iter_9_1].spec_char ~= 0 and table.keyof(var_9_4, iter_9_1) and iter_9_1 ~= arg_9_1 then
			var_9_1 = true
			var_9_2 = iter_9_1

			break
		end
	end

	local var_9_5 = table.keyof(var_9_0, arg_9_1)

	if not var_9_5 and not var_9_1 and #var_9_0 >= GameSetting.ai_secondary_chip_equip_num.value[1] then
		ShowTips("CHIP_CNT_MORE_THEN_MAX")

		return
	end

	manager.net:SendWithLoadingNew(50006, {
		kernel_id = arg_9_0,
		secondary_id = arg_9_1,
		oper = var_9_5 and 2 or 1
	}, 50007, function(arg_10_0)
		if isSuccess(arg_10_0.result) then
			if var_9_1 then
				ChipData:RemoveChipID(arg_9_0, var_9_2)
				ShowTips("CHIP_USE_SUCCESS")
				ChipData:SetEnabledChipID(arg_9_0, arg_9_1)
			elseif var_9_5 then
				ShowTips("CHIP_UNLOAD_SUCCESS")
				ChipData:RemoveChipID(arg_9_0, arg_9_1)
			else
				ShowTips("CHIP_USE_SUCCESS")
				ChipData:SetEnabledChipID(arg_9_0, arg_9_1)
			end

			manager.notify:Invoke(ENABLED_CHIP)
		else
			ShowTips(arg_10_0.result)
		end
	end)
end

function var_0_0.EnabledHeroChip(arg_11_0, arg_11_1, arg_11_2)
	manager.net:SendWithLoadingNew(50018, {
		hero_id = arg_11_0,
		slot_id = arg_11_2,
		secondary = arg_11_1
	}, 50019, function(arg_12_0)
		if isSuccess(arg_12_0.result) then
			if arg_11_1 == 0 then
				ShowTips("CHIP_HERO_UNLOAD_SUCCESS")
			else
				ShowTips("CHIP_HERO_USE_SUCCESS")
			end

			ChipData:EnableHeroChip(arg_11_0, arg_11_1, arg_11_2)
			manager.notify:CallUpdateFunc(HERO_CHIP_STATUS_UPDATE)
		else
			ShowTips(arg_12_0.result)
		end
	end)
end

function var_0_0.EnabledSchemeID(arg_13_0, arg_13_1)
	manager.net:SendWithLoadingNew(50014, {
		kernel_chip_id = arg_13_0,
		proposal_id = arg_13_1
	}, 50015, function(arg_14_0)
		if isSuccess(arg_14_0.result) then
			ShowTips("USE_SCHEME_SUCCESS")

			local var_14_0 = ChipData:GetSchemeList()[arg_13_1]

			var_0_0.ResetChip(arg_13_0)

			for iter_14_0, iter_14_1 in ipairs(var_14_0.chipList) do
				ChipData:SetEnabledChipID(arg_13_0, iter_14_1)
			end

			manager.notify:Invoke(ENABLED_SCHEME)
		else
			ShowTips(arg_14_0.result)
		end
	end)
end

function var_0_0.ResetChipManager(arg_15_0)
	manager.net:SendWithLoadingNew(50016, {
		kernel_id = arg_15_0
	}, 50017, function(arg_16_0)
		if isSuccess(arg_16_0.result) then
			ShowTips("CHIP_UNLOAD_SUCCESS")
			var_0_0.ResetChip(arg_15_0)
		else
			ShowTips(arg_16_0.result)
		end
	end)
end

function var_0_0.ResetChip(arg_17_0)
	ChipData:ResetChipManager(arg_17_0)
	manager.notify:Invoke(ENABLED_CHIP)
end

function var_0_0.SaveChipScheme(arg_18_0)
	manager.net:SendWithLoadingNew(50008, {
		id = arg_18_0.id,
		name = arg_18_0.name,
		secondary = arg_18_0.chipList
	}, 50009, function(arg_19_0)
		if isSuccess(arg_19_0.result) then
			ShowTips("SAVE_SCHEME_SUCCESS")
			ChipData:SaveChipScheme(clone(arg_18_0))
			manager.notify:Invoke(SAVE_CHIP_SCHEME, arg_18_0.id)
		else
			ShowTips(arg_19_0.result)
		end
	end)
end

function var_0_0.RenameChipScheme(arg_20_0, arg_20_1)
	manager.net:SendWithLoadingNew(50012, {
		id = arg_20_0,
		name = arg_20_1
	}, 50013, function(arg_21_0)
		if isSuccess(arg_21_0.result) then
			ShowTips("SAVE_SCHEME_SUCCESS")
			ChipData:RenameChipScheme(arg_20_0, arg_20_1)
			manager.notify:Invoke(RENAME_CHIP_SCHEME, arg_20_0)
		else
			ShowTips(arg_21_0.result)
		end
	end)
end

function var_0_0.DeleteChipScheme(arg_22_0)
	manager.net:SendWithLoadingNew(50010, {
		id = arg_22_0
	}, 50011, function(arg_23_0)
		if isSuccess(arg_23_0.result) then
			ShowTips("DELETE_CHIP_SCHEME_SUCCESS")
			ChipData:DeleteChipScheme(arg_22_0)
			manager.notify:Invoke(DELETE_CHIP_SCHEME)
		else
			ShowTips(arg_23_0.result)
		end
	end)
end

function var_0_0.UpdateHeroChipRedPoint()
	local var_24_0 = ChipData:GetUnlockHeroChipIDList()

	for iter_24_0, iter_24_1 in pairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_HERO_CHIP]) do
		if not table.keyof(var_24_0, iter_24_1) then
			local var_24_1 = ChipCfg[iter_24_1]
			local var_24_2

			if ChipCfg[iter_24_1].new_condition > 0 then
				if ChipCfg[iter_24_1].spec_char > 0 then
					var_24_2 = IsConditionAchieved(var_24_1.new_condition, {
						heroId = ChipCfg[iter_24_1].spec_char
					})
				else
					var_24_2 = IsConditionAchieved(ChipCfg[iter_24_1].new_condition)
				end
			else
				var_24_2 = ItemTools.getItemNum(ChipCfg[iter_24_1].cost_condition[1][1]) >= ChipCfg[iter_24_1].cost_condition[1][2] and true or false
			end

			local var_24_3

			if ChipCfg[iter_24_1].cost_condition ~= "" then
				var_24_3 = RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. var_24_1.spec_char .. "_" .. var_24_1.role_type_id .. "_" .. iter_24_1
			else
				var_24_3 = RedPointConst.CHIP_HERO_CHIP .. "_" .. var_24_1.spec_char .. "_" .. var_24_1.role_type_id .. "_" .. iter_24_1
			end

			if var_24_2 then
				manager.redPoint:setTip(var_24_3, 1)
			else
				manager.redPoint:setTip(var_24_3, 0)
			end
		end
	end
end

function var_0_0.ActivateCharChipBase(arg_25_0)
	manager.net:SendWithLoadingNew(50002, {
		id = arg_25_0
	}, 50003, function(arg_26_0)
		if isSuccess(arg_26_0.result) then
			ChipData:UnlockCharChip(arg_25_0)
			ChipAction:UpdateChipRed()

			local var_26_0 = ChipCfg[arg_25_0]

			if var_26_0.role_type_id == ChipConst.ROLE_TYPE_CHAR_CHIP_BASE then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_CHAR_BASE_CHIP, arg_25_0), 0)
			elseif var_26_0.role_type_id == ChipConst.ROLE_TYPE_CHAR_CHIP_EXTRA then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.CHIP_CHAR_EXTRA_CHIP, arg_25_0), 0)
			end

			manager.notify:CallUpdateFunc(ON_ACTIVATE_CHAR_CHIP)
		else
			ShowTips(arg_26_0.result)
		end
	end)
end

function var_0_0.ActivateCharChipExtra(arg_27_0)
	ChipAction.ActivateCharChipBase(arg_27_0)
end

return var_0_0
