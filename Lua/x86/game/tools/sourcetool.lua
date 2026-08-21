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
		local var_2_0 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_2_1] or {}

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if ActivityPtRouletteStageCfg[iter_2_1] then
				local var_2_1 = ActivityPtRouletteStageCfg[iter_2_1].roulette_id

				for iter_2_2, iter_2_3 in ipairs(var_2_1) do
					local var_2_2 = ActivityPtRouletteRandomCfg[iter_2_3] and ActivityPtRouletteRandomCfg[iter_2_3].equip_suit_list or {}

					if EquipCfg[arg_2_0] then
						local var_2_3 = EquipCfg[arg_2_0].suit

						if table.indexof(var_2_2, var_2_3) then
							local var_2_4 = SystemLinkActivityCfg[arg_2_1].system_link_data

							return true, var_2_4
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

		if var_4_0 == nil and var_4_1 == nil then
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
		local var_3_4 = DrawPoolCfg[iter_3_1]
		local var_3_5 = var_3_4.excluded_group

		if var_3_4 then
			local var_3_6 = var_3_4.pool_type
			local var_3_7 = var_3_4.pool_show_type
			local var_3_8 = var_3_4.pool_draw_range_type
			local var_3_9 = DrawSettingCfg[var_3_8]

			if var_3_9 then
				local var_3_10 = var_3_9.pool_id

				if var_3_10 ~= "" then
					for iter_3_2, iter_3_3 in pairs(var_3_10) do
						local var_3_11 = DrawItemCfg.get_id_list_by_pool_id[iter_3_3] or {}

						for iter_3_4, iter_3_5 in ipairs(var_3_11) do
							local var_3_12 = DrawItemCfg[iter_3_5] and DrawItemCfg[iter_3_5].item_id or 0

							if (ItemCfg[arg_3_0] and ItemCfg[arg_3_0].hero_id or 0) == var_3_12 and not var_3_3[var_3_7] and SystemLinkCfg[var_3_2[var_3_7]] then
								if var_3_6 == 8 then
									if not DrawData:GetNewbieChooseDrawFlag() then
										var_3_3[var_3_7] = {
											var_3_2[var_3_7],
											iter_3_1
										}
									end
								elseif var_3_5[1][1] and var_3_5[1][1] == var_3_12 then
									-- block empty
								else
									var_3_3[var_3_7] = {
										var_3_2[var_3_7],
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

	local var_3_13 = {}

	for iter_3_6, iter_3_7 in pairs(var_3_3) do
		table.insert(var_3_13, iter_3_7)
	end

	return #var_3_13 > 0, var_3_13
end

function var_0_0.GetJumpDataByServantSpecialType(arg_5_0)
	local var_5_0 = DrawTools.GetNowAllServantPool()
	local var_5_1 = {
		[2] = ViewConst.JUMP_SPECIAL_ID.SERVANT_NORMAL_SOURCE
	}
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_3 = DrawPoolCfg[iter_5_1]

		if var_5_3 then
			local var_5_4 = var_5_3.pool_type
			local var_5_5 = var_5_3.pool_show_type
			local var_5_6 = var_5_3.pool_draw_range_type
			local var_5_7 = DrawSettingCfg[var_5_6]

			if var_5_7 then
				local var_5_8 = var_5_7.pool_id

				if var_5_8 ~= "" then
					for iter_5_2, iter_5_3 in pairs(var_5_8) do
						local var_5_9 = DrawItemCfg.get_id_list_by_pool_id[iter_5_3] or {}

						for iter_5_4, iter_5_5 in ipairs(var_5_9) do
							if DrawItemCfg[iter_5_5] and DrawItemCfg[iter_5_5].item_id == arg_5_0 and not var_5_2[var_5_5] and SystemLinkCfg[var_5_1[var_5_5]] then
								var_5_2[var_5_5] = {
									var_5_1[var_5_5],
									iter_5_1
								}
							end
						end
					end
				end
			end
		end
	end

	local var_5_10 = {}

	for iter_5_6, iter_5_7 in pairs(var_5_2) do
		table.insert(var_5_10, iter_5_7)
	end

	return #var_5_10 > 0, var_5_10
end

function var_0_0.GetGodEaterSourece(arg_6_0)
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GODEATER_SERVANT) then
		return false, {}
	end

	local var_6_0 = DrawTools.GetNowAllServantPool()
	local var_6_1 = {
		[9] = ViewConst.JUMP_SPECIAL_ID.GODEATER_SPECIAL_SERVANT
	}
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_3 = DrawPoolCfg[iter_6_1]

		if var_6_3 then
			local var_6_4 = var_6_3.pool_type
			local var_6_5 = var_6_3.pool_show_type
			local var_6_6 = var_6_3.pool_draw_range_type
			local var_6_7 = var_6_3.pool_selected_type
			local var_6_8 = DrawSettingCfg[var_6_6]

			if var_6_4 == 2 and var_6_7 == 9 and iter_6_1 ~= 10002 and not var_6_2[var_6_7] and SystemLinkCfg[var_6_1[var_6_7]] then
				var_6_2[var_6_7] = {
					var_6_1[var_6_7],
					iter_6_1
				}
			end
		end
	end

	if not var_6_2[9] then
		var_6_2[9] = {
			var_6_1[9],
			1001
		}
	end

	local var_6_9 = {}

	for iter_6_2, iter_6_3 in pairs(var_6_2) do
		table.insert(var_6_9, iter_6_3)
	end

	return #var_6_9 > 0, var_6_9
end

return var_0_0
