local var_0_0 = class("NewEducatePermanent")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.gameCnt = arg_1_2.ng_plus_count or 1
	arg_1_0.polaroids = arg_1_2.polaroids or {}

	arg_1_0:InitPolaroidsConfig()

	arg_1_0.finishedEndings = arg_1_2.active_endings or {}
	arg_1_0.activatedEndings = arg_1_2.endings or {}
	arg_1_0.buffIds = arg_1_2.tarot_archive or {}

	arg_1_0:InitEntryConfig()

	arg_1_0.maxRound = arg_1_2.max_round

	arg_1_0:InitStroyName2Id()
	arg_1_0:InitSecretary()
	arg_1_0:UpdateSecretaryIDs(false)

	return
end

function var_0_0.AddGameCnt(arg_2_0)
	arg_2_0.gameCnt = arg_2_0.gameCnt + 1

	return
end

function var_0_0.GetGameCnt(arg_3_0)
	return arg_3_0.gameCnt
end

function var_0_0.GetMaxRound(arg_4_0)
	return arg_4_0.maxRound
end

function var_0_0.OnNextRound(arg_5_0, arg_5_1)
	arg_5_0.maxRound = math.max(arg_5_1, arg_5_0.maxRound)

	return
end

function var_0_0.GetAllMemoryIds(arg_6_0)
	return pg.child2_memory.get_id_list_by_character[arg_6_0.id] or {}
end

function var_0_0.GetUnlockMemoryIds(arg_7_0)
	return underscore.select(arg_7_0:GetAllMemoryIds(), function(arg_8_0)
		return (pg.NewStoryMgr.GetInstance():IsPlayed(pg.child2_memory[arg_8_0].lua))
	end)
end

function var_0_0.InitStroyName2Id(arg_9_0)
	arg_9_0.name2memoryIds = {}

	underscore.each(arg_9_0:GetAllMemoryIds(), function(arg_10_0)
		arg_9_0.name2memoryIds[pg.child2_memory[arg_10_0].lua] = arg_10_0

		return
	end)

	return
end

function var_0_0.GetMemoryIdByName(arg_11_0, arg_11_1)
	return arg_11_0.name2memoryIds[arg_11_1]
end

function var_0_0.InitPolaroidsConfig(arg_12_0)
	arg_12_0.polaroidGroup2Ids = {}

	for iter_12_0, iter_12_1 in ipairs(pg.child2_polaroid.get_id_list_by_character[arg_12_0.id]) do
		arg_12_0.polaroidGroup2Ids[pg.child2_polaroid[iter_12_1].group] = arg_12_0.polaroidGroup2Ids[pg.child2_polaroid[iter_12_1].group] or {}

		table.insert(arg_12_0.polaroidGroup2Ids[pg.child2_polaroid[iter_12_1].group], iter_12_1)
	end

	arg_12_0.unlockPolaroidGroups = {}

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.polaroids) do
		if not table.contains(arg_12_0.unlockPolaroidGroups, pg.child2_polaroid[iter_12_3].group) then
			table.insert(arg_12_0.unlockPolaroidGroups, pg.child2_polaroid[iter_12_3].group)
		end
	end

	return
end

function var_0_0.GetPolaroidGroup2Ids(arg_13_0)
	return arg_13_0.polaroidGroup2Ids
end

function var_0_0.GetAllPolaroidGroups(arg_14_0)
	return underscore.keys(arg_14_0.polaroidGroup2Ids)
end

function var_0_0.GetUnlockPolaroidGroups(arg_15_0)
	return arg_15_0.unlockPolaroidGroups
end

function var_0_0.GetPolaroids(arg_16_0)
	return arg_16_0.polaroids
end

function var_0_0.AddPolaroid(arg_17_0, arg_17_1)
	table.insert(arg_17_0.polaroids, arg_17_1)

	if not table.contains(arg_17_0.unlockPolaroidGroups, pg.child2_polaroid[arg_17_1].group) then
		table.insert(arg_17_0.unlockPolaroidGroups, pg.child2_polaroid[arg_17_1].group)
		arg_17_0:UpdateSecretaryIDs(true)
	end

	return
end

function var_0_0.GetAllEndingIds(arg_18_0)
	return pg.child2_ending.get_id_list_by_character[arg_18_0.id]
end

function var_0_0.GetFinishedEndings(arg_19_0)
	return arg_19_0.finishedEndings
end

function var_0_0.AddFinishedEnding(arg_20_0, arg_20_1)
	if table.contains(arg_20_0.finishedEndings, arg_20_1) then
		return
	end

	table.insert(arg_20_0.finishedEndings, arg_20_1)

	return
end

function var_0_0.GetActivatedEndings(arg_21_0)
	return arg_21_0.activatedEndings
end

function var_0_0.AddActivatedEndings(arg_22_0, arg_22_1)
	arg_22_0.activatedEndings = table.mergeArray(arg_22_0.activatedEndings, arg_22_1, true)

	arg_22_0:UpdateSecretaryIDs(true)

	return
end

function var_0_0.GetAllBuffIds(arg_23_0)
	return pg.child2_benefit_list.get_id_list_by_character[arg_23_0.id] or {}
end

function var_0_0.GetAllTarotIds(arg_24_0)
	return underscore.select(arg_24_0:GetAllBuffIds(), function(arg_25_0)
		return pg.child2_benefit_list[arg_25_0].type == NewEducateBuff.TYPE.TAROT and NewEducateBuff.IsVisible(arg_25_0)
	end)
end

function var_0_0.GetActivatedTarotIds(arg_26_0)
	return underscore.select(arg_26_0.buffIds, function(arg_27_0)
		return pg.child2_benefit_list[arg_27_0].type == NewEducateBuff.TYPE.TAROT and NewEducateBuff.IsVisible(arg_27_0)
	end)
end

function var_0_0.GetAllTalentIds(arg_28_0)
	return underscore.select(arg_28_0:GetAllBuffIds(), function(arg_29_0)
		return pg.child2_benefit_list[arg_29_0].type == NewEducateBuff.TYPE.TALENT and NewEducateBuff.IsVisible(arg_29_0)
	end)
end

function var_0_0.GetActivatedTalentIds(arg_30_0)
	return underscore.select(arg_30_0.buffIds, function(arg_31_0)
		return pg.child2_benefit_list[arg_31_0].type == NewEducateBuff.TYPE.TALENT and NewEducateBuff.IsVisible(arg_31_0)
	end)
end

function var_0_0.GetAllEntryIds(arg_32_0)
	return underscore.select(arg_32_0:GetAllBuffIds(), function(arg_33_0)
		return pg.child2_benefit_list[arg_33_0].type == NewEducateBuff.TYPE.ENTRY and NewEducateBuff.IsVisible(arg_33_0)
	end)
end

function var_0_0.InitEntryConfig(arg_34_0)
	arg_34_0.entryGroup2Ids = {}

	for iter_34_0, iter_34_1 in ipairs(arg_34_0:GetAllEntryIds()) do
		arg_34_0.entryGroup2Ids[pg.child2_benefit_list[iter_34_1].level_tag] = arg_34_0.entryGroup2Ids[pg.child2_benefit_list[iter_34_1].level_tag] or {}

		table.insert(arg_34_0.entryGroup2Ids[pg.child2_benefit_list[iter_34_1].level_tag], iter_34_1)
	end

	return
end

function var_0_0.GetEntryGroup2Ids(arg_35_0)
	return arg_35_0.entryGroup2Ids
end

function var_0_0.GetAllEntryGroups(arg_36_0)
	return underscore.keys(arg_36_0.entryGroup2Ids)
end

function var_0_0.GetActivatedEntryIds(arg_37_0)
	return underscore.select(arg_37_0.buffIds, function(arg_38_0)
		return pg.child2_benefit_list[arg_38_0].type == NewEducateBuff.TYPE.ENTRY and NewEducateBuff.IsVisible(arg_38_0)
	end)
end

function var_0_0.GetUnlockEntryGroups(arg_39_0)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0:GetActivatedEntryIds()) do
		if not table.contains({}, pg.child2_benefit_list[iter_39_1].level_tag) then
			table.insert({}, pg.child2_benefit_list[iter_39_1].level_tag)
		end
	end

	return {}
end

function var_0_0.IsTarotType(arg_40_0)
	return #arg_40_0:GetAllTarotIds() > 0
end

function var_0_0.GetAllBuffCnt(arg_41_0)
	return #arg_41_0:GetAllTarotIds() + #arg_41_0:GetAllTalentIds() + #arg_41_0:GetAllEntryIds()
end

function var_0_0.GetAllUnlockBuffCnt(arg_42_0)
	return #arg_42_0:GetActivatedTarotIds() + #arg_42_0:GetActivatedTalentIds() + #arg_42_0:GetActivatedEntryIds()
end

function var_0_0.GetBuffIds(arg_43_0)
	return arg_43_0.buffIds
end

function var_0_0.CheckBuffRecord(arg_44_0, arg_44_1)
	if not table.contains(arg_44_0.buffIds, arg_44_1) then
		table.insert(arg_44_0.buffIds, arg_44_1)
	end

	return
end

function var_0_0.InitSecretary(arg_45_0)
	arg_45_0.unlcokTipByPolaroidCnt = {}

	for iter_45_0, iter_45_1 in ipairs(pg.secretary_special_ship.all) do
		if pg.secretary_special_ship[iter_45_1].unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_POLAROID then
			if not table.contains(arg_45_0.unlcokTipByPolaroidCnt, pg.secretary_special_ship[iter_45_1].unlock[1]) then
				table.insert(arg_45_0.unlcokTipByPolaroidCnt, pg.secretary_special_ship[iter_45_1].unlock[1])
			end
		end
	end

	return
end

function var_0_0.CheckSecretaryID(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_2 == "or" then
		for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
			if table.contains(arg_46_0.activatedEndings, iter_46_1[1]) then
				return true
			end
		end

		return false
	elseif arg_46_2 == "and" then
		for iter_46_2, iter_46_3 in ipairs(arg_46_1) do
			if not table.contains(arg_46_0.activatedEndings, iter_46_3) then
				return false
			end

			return true
		end
	end

	return false
end

function var_0_0.UpdateSecretaryIDs(arg_47_0, arg_47_1)
	local var_47_0

	if arg_47_1 then
		var_47_0 = Clone(NewEducateHelper.GetAllUnlockSecretaryIds())
	end

	arg_47_0.unlockSecretaryIds = {}

	local var_47_1 = #arg_47_0.unlockPolaroidGroups
	local var_47_2 = pg.secretary_special_ship.get_id_list_by_tb_id[arg_47_0.id] or {}

	for iter_47_0, iter_47_1 in ipairs(var_47_2) do
		local var_47_3 = pg.secretary_special_ship[iter_47_1].unlock

		switch(pg.secretary_special_ship[iter_47_1].unlock_type, {
			[EducateConst.SECRETARY_UNLCOK_TYPE_DEFAULT] = function()
				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_POLAROID] = function()
				if var_47_3[1] and var_47_1 >= var_47_3[1] then
					table.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_ENDING] = function()
				if var_47_3[1] then
					if type(var_47_3[1]) == "table" then
						if arg_47_0:CheckSecretaryID(var_47_3, "or") then
							table.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
						end
					elseif type(var_47_3[1]) == "number" and arg_47_0:CheckSecretaryID(var_47_3, "and") then
						table.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
					end
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_SHOP] = function()
				if var_47_3[1] then
					if getProxy(ShipSkinProxy):hasSkin(var_47_3[1]) then
						table.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
					end
				end

				return
			end,
			[EducateConst.SECRETARY_UNLCOK_TYPE_STORY] = function()
				if var_47_3[1] then
					if pg.NewStoryMgr.GetInstance():IsPlayed(pg.NewStoryMgr.GetInstance():StoryId2StoryName(var_47_3[1])) then
						table.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
					end
				end

				return
			end
		})
	end

	if arg_47_1 then
		getProxy(SettingsProxy):UpdateEducateCharTip(var_47_0)
	end

	return
end

function var_0_0.GetUnlockSecretaryIds(arg_53_0)
	return arg_53_0.unlockSecretaryIds
end

return var_0_0
