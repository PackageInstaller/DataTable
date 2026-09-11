local var_0_0 = {}

function var_0_0.GetJumpDataByEquipSpecialType(arg_1_0, arg_1_1)
	local var_1_0 = SystemLinkActivityCfg.all or {}

	if #var_1_0 == 0 then
		return {}
	end

	print(arg_1_1, "  GetJumpDataByEquipSpecialType")

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1, var_1_2 = var_0_0.CheckRouletteHasEquip(arg_1_1, iter_1_1)

		if var_1_1 then
			return var_1_2
		end
	end
end

function var_0_0.CheckRouletteHasEquip(arg_2_0, arg_2_1)
	if ActivityData:GetActivityIsOpen(arg_2_1) then
		for iter_2_0, iter_2_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_2_1] or {}) do
			if ActivityPtRouletteStageCfg[iter_2_1] then
				for iter_2_2, iter_2_3 in ipairs(ActivityPtRouletteStageCfg[iter_2_1].roulette_id) do
					if ActivityPtRouletteRandomCfg[iter_2_3] then
						if EquipCfg[arg_2_0] and table.indexof(ActivityPtRouletteRandomCfg[iter_2_3].equip_suit_list or {}, EquipCfg[arg_2_0].suit) then
							return true, SystemLinkActivityCfg[arg_2_1].system_link_data
						end
					end
				end
			end
		end
	end

	return false, {}
end

function var_0_0.GetJumpDataByHeroSpecialType(arg_3_0)
	local var_3_0 = DrawTools.GetNowAllRolePool()
	local var_3_1 = {
		5,
		6,
		2,
		nil,
		5,
		1,
		3,
		4,
		7
	}

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		local var_4_0 = DrawPoolCfg[arg_4_0]
		local var_4_1 = DrawPoolCfg[arg_4_1]

		if DrawPoolCfg[arg_4_0] == nil and var_4_1 == nil then
			return arg_4_1 < arg_4_0
		elseif var_4_0 == nil then
			return false
		elseif var_4_1 == nil then
			return true
		end

		local var_4_2 = var_3_1[var_4_0.pool_show_type] or 999
		local var_4_3 = var_3_1[var_4_1.pool_show_type] or 999

		if var_4_2 ~= var_4_3 then
			return var_4_2 < var_4_3
		end

		if var_4_0.order ~= var_4_1.order then
			return var_4_0.order < var_4_1.order
		end

		return arg_4_1 < arg_4_0
	end)

	local var_3_2 = {
		ViewConst.JUMP_SPECIAL_ID.HERO_NORMAL_SOURCE,
		[3] = ViewConst.JUMP_SPECIAL_ID.HERO_LIMIT_SOURCE,
		[5] = ViewConst.JUMP_SPECIAL_ID.NEW_PLAYER_DRAW,
		[6] = ViewConst.JUMP_SPECIAL_ID.LIMIT_MUST_DRAW,
		[7] = ViewConst.JUMP_SPECIAL_ID.HERO_AGAIN,
		[8] = ViewConst.JUMP_SPECIAL_ID.NEW_PLAYER_DRAW
	}
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_4 = DrawPoolCfg[iter_3_1].excluded_group

		if DrawPoolCfg[iter_3_1] then
			local var_3_5 = DrawPoolCfg[iter_3_1].pool_type
			local var_3_6 = DrawPoolCfg[iter_3_1].pool_show_type

			if DrawSettingCfg[DrawPoolCfg[iter_3_1].pool_draw_range_type] then
				if DrawSettingCfg[DrawPoolCfg[iter_3_1].pool_draw_range_type].pool_id ~= "" then
					for iter_3_2, iter_3_3 in pairs(DrawSettingCfg[DrawPoolCfg[iter_3_1].pool_draw_range_type].pool_id) do
						for iter_3_4, iter_3_5 in ipairs(DrawItemCfg.get_id_list_by_pool_id[iter_3_3] or {}) do
							if DrawItemCfg[iter_3_5] then
								local var_3_8 = DrawItemCfg[iter_3_5].item_id or 0

								if ItemCfg[arg_3_0] then
									if (ItemCfg[arg_3_0].hero_id or 0) == var_3_8 and not var_3_3[var_3_6] and SystemLinkCfg[var_3_2[var_3_6]] then
										if var_3_5 == 8 then
											if not DrawData:GetNewbieChooseDrawFlag() then
												var_3_3[var_3_6] = {
													var_3_2[var_3_6],
													iter_3_1
												}
											end
										elseif var_3_4[1][1] and var_3_4[1][1] == var_3_8 then
											-- block empty
										else
											var_3_3[var_3_6] = {
												var_3_2[var_3_6],
												iter_3_1
											}
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	local var_3_10 = {}

	for iter_3_6, iter_3_7 in pairs(var_3_3) do
		table.insert(var_3_10, iter_3_7)
	end

	return #var_3_10 > 0, var_3_10
end

function var_0_0.GetJumpDataByServantSpecialType(arg_5_0)
	local var_5_0 = {
		[2] = ViewConst.JUMP_SPECIAL_ID.SERVANT_NORMAL_SOURCE
	}
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in pairs((DrawTools.GetNowAllServantPool())) do
		if DrawPoolCfg[iter_5_1] then
			if DrawSettingCfg[DrawPoolCfg[iter_5_1].pool_draw_range_type] then
				if DrawSettingCfg[DrawPoolCfg[iter_5_1].pool_draw_range_type].pool_id ~= "" then
					for iter_5_2, iter_5_3 in pairs(DrawSettingCfg[DrawPoolCfg[iter_5_1].pool_draw_range_type].pool_id) do
						for iter_5_4, iter_5_5 in ipairs(DrawItemCfg.get_id_list_by_pool_id[iter_5_3] or {}) do
							if DrawItemCfg[iter_5_5] and DrawItemCfg[iter_5_5].item_id == arg_5_0 and not var_5_1[DrawPoolCfg[iter_5_1].pool_show_type] and SystemLinkCfg[var_5_0[DrawPoolCfg[iter_5_1].pool_show_type]] then
								var_5_1[DrawPoolCfg[iter_5_1].pool_show_type] = {
									var_5_0[DrawPoolCfg[iter_5_1].pool_show_type],
									iter_5_1
								}
							end
						end
					end
				end
			end
		end
	end

	local var_5_4 = {}

	for iter_5_6, iter_5_7 in pairs(var_5_1) do
		table.insert(var_5_4, iter_5_7)
	end

	return #var_5_4 > 0, var_5_4
end

function var_0_0.GetGodEaterSourece(arg_6_0)
	local var_6_1
	local var_6_0

	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GODEATER_SERVANT) then
		do return false, {} end

		var_6_0 = {
			[9] = ViewConst.JUMP_SPECIAL_ID.GODEATER_SPECIAL_SERVANT
		}
		var_6_1 = {}
	end

	for iter_6_0, iter_6_1 in pairs((DrawTools.GetNowAllServantPool())) do
		if DrawPoolCfg[iter_6_1] then
			if DrawPoolCfg[iter_6_1].pool_type == 2 and DrawPoolCfg[iter_6_1].pool_selected_type == 9 and iter_6_1 ~= 10002 and not var_6_1[DrawPoolCfg[iter_6_1].pool_selected_type] and SystemLinkCfg[var_6_0[DrawPoolCfg[iter_6_1].pool_selected_type]] then
				var_6_1[DrawPoolCfg[iter_6_1].pool_selected_type] = {
					var_6_0[DrawPoolCfg[iter_6_1].pool_selected_type],
					iter_6_1
				}
			end
		end
	end

	var_6_1[9] = var_6_1[9] or {
		var_6_0[9],
		1001
	}

	local var_6_4 = {}

	for iter_6_2, iter_6_3 in pairs(var_6_1) do
		table.insert(var_6_4, iter_6_3)
	end

	return #var_6_4 > 0, var_6_4
end

return var_0_0
