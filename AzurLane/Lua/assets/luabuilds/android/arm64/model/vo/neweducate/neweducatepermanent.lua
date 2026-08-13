class = var_0_10000

local var_0_0 = var_0_10000("NewEducatePermanent")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1

	local var_1_0

	if not arg_1_2.ng_plus_count then
		var_1_0 = 1
	end

	arg_1_0.gameCnt = var_1_0

	local var_1_1

	if not arg_1_2.polaroids then
		var_1_1 = {}
	end

	arg_1_0.polaroids = var_1_1

	arg_1_0:InitPolaroidsConfig()

	local var_1_2

	if not arg_1_2.active_endings then
		var_1_2 = {}
	end

	arg_1_0.finishedEndings = var_1_2

	local var_1_3

	if not arg_1_2.endings then
		var_1_3 = {}
	end

	arg_1_0.activatedEndings = var_1_3

	local var_1_4

	if not arg_1_2.tarot_archive then
		var_1_4 = {}
	end

	arg_1_0.buffIds = var_1_4

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
	math = var_1_10002
	arg_5_0.maxRound = var_1_10002.max(arg_5_1, arg_5_0.maxRound)

	return
end

function var_0_0.GetAllMemoryIds(arg_6_0)
	pg = var_1_10001

	local var_6_0

	if not var_1_10001.child2_memory.get_id_list_by_character[arg_6_0.id] then
		var_6_0 = {}
	end

	return var_6_0
end

function var_0_0.GetUnlockMemoryIds(arg_7_0)
	underscore = var_1_10001

	return var_1_10001.select(arg_7_0:GetAllMemoryIds(), function(arg_8_0)
		pg = var_2_10001

		local var_8_0 = var_2_10001.child2_memory[arg_8_0].lua

		pg = var_2_10002

		local var_8_1 = var_2_10002.NewStoryMgr.GetInstance()

		return (var_2.IsPlayed(var_8_1, var_8_0))
	end)
end

function var_0_0.InitStroyName2Id(arg_9_0)
	arg_9_0.name2memoryIds = {}
	underscore = var_1

	var_1.each(arg_9_0:GetAllMemoryIds(), function(arg_10_0)
		local var_10_0 = arg_9_0.name2memoryIds

		pg = var_2_10002
		var_10_0[var_2_10002.child2_memory[arg_10_0].lua] = arg_10_0

		return
	end)

	return
end

function var_0_0.GetMemoryIdByName(arg_11_0, arg_11_1)
	return arg_11_0.name2memoryIds[arg_11_1]
end

function var_0_0.InitPolaroidsConfig(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.child2_polaroid.get_id_list_by_character[arg_12_0.id]

	arg_12_0.polaroidGroup2Ids = {}
	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(var_12_0) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.child2_polaroid[iter_12_1].group

		if not arg_12_0.polaroidGroup2Ids[var_1_10007] then
			var_1_10008 = arg_12_0.polaroidGroup2Ids
			var_1_10008[var_1_10007] = {}
		end

		table = var_1_10008

		var_1_10008.insert(arg_12_0.polaroidGroup2Ids[var_1_10007], iter_12_1)
	end

	arg_12_0.unlockPolaroidGroups = {}
	ipairs = var_2

	for iter_12_2, iter_12_3 in var_2(arg_12_0.polaroids) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.child2_polaroid[iter_12_3].group
		table = var_1_10008

		if not var_1_10008.contains(arg_12_0.unlockPolaroidGroups, var_1_10007) then
			table = var_1_10008

			var_1_10008.insert(arg_12_0.unlockPolaroidGroups, var_1_10007)
		end
	end

	return
end

function var_0_0.GetPolaroidGroup2Ids(arg_13_0)
	return arg_13_0.polaroidGroup2Ids
end

function var_0_0.GetAllPolaroidGroups(arg_14_0)
	underscore = var_1_10001

	return var_1_10001.keys(arg_14_0.polaroidGroup2Ids)
end

function var_0_0.GetUnlockPolaroidGroups(arg_15_0)
	return arg_15_0.unlockPolaroidGroups
end

function var_0_0.GetPolaroids(arg_16_0)
	return arg_16_0.polaroids
end

function var_0_0.AddPolaroid(arg_17_0, arg_17_1)
	table = var_1_10002

	var_1_10002.insert(arg_17_0.polaroids, arg_17_1)

	pg = var_2

	local var_17_0 = var_2.child2_polaroid[arg_17_1].group

	table = var_1_10003

	if not var_1_10003.contains(arg_17_0.unlockPolaroidGroups, var_17_0) then
		table = var_3

		var_3.insert(arg_17_0.unlockPolaroidGroups, var_17_0)
		arg_17_0:UpdateSecretaryIDs(true)
	end

	return
end

function var_0_0.GetAllEndingIds(arg_18_0)
	pg = var_1_10001

	return var_1_10001.child2_ending.get_id_list_by_character[arg_18_0.id]
end

function var_0_0.GetFinishedEndings(arg_19_0)
	return arg_19_0.finishedEndings
end

function var_0_0.AddFinishedEnding(arg_20_0, arg_20_1)
	table = var_1_10002

	if var_1_10002.contains(arg_20_0.finishedEndings, arg_20_1) then
		return
	end

	table = var_2

	var_2.insert(arg_20_0.finishedEndings, arg_20_1)

	return
end

function var_0_0.GetActivatedEndings(arg_21_0)
	return arg_21_0.activatedEndings
end

function var_0_0.AddActivatedEndings(arg_22_0, arg_22_1)
	table = var_1_10002
	arg_22_0.activatedEndings = var_1_10002.mergeArray(arg_22_0.activatedEndings, arg_22_1, true)

	arg_22_0:UpdateSecretaryIDs(true)

	return
end

function var_0_0.GetAllBuffIds(arg_23_0)
	pg = var_1_10001

	local var_23_0

	if not var_1_10001.child2_benefit_list.get_id_list_by_character[arg_23_0.id] then
		var_23_0 = {}
	end

	return var_23_0
end

function var_0_0.GetAllTarotIds(arg_24_0)
	underscore = var_1_10001

	return var_1_10001.select(arg_24_0:GetAllBuffIds(), function(arg_25_0)
		pg = var_2_10001

		local var_25_0 = var_2_10001.child2_benefit_list[arg_25_0].type

		NewEducateBuff = var_2_10003

		local var_25_1

		if var_25_0 == var_2_10003.TYPE.TAROT then
			NewEducateBuff = var_25_0
			var_25_1 = var_25_0.IsVisible(arg_25_0)
		else
			var_25_1 = false
		end

		if false then
			var_25_1 = true
		end

		return var_25_1
	end)
end

function var_0_0.GetActivatedTarotIds(arg_26_0)
	underscore = var_1_10001

	return var_1_10001.select(arg_26_0.buffIds, function(arg_27_0)
		pg = var_2_10001

		local var_27_0 = var_2_10001.child2_benefit_list[arg_27_0].type

		NewEducateBuff = var_2_10003

		local var_27_1

		if var_27_0 == var_2_10003.TYPE.TAROT then
			NewEducateBuff = var_27_0
			var_27_1 = var_27_0.IsVisible(arg_27_0)
		else
			var_27_1 = false
		end

		if false then
			var_27_1 = true
		end

		return var_27_1
	end)
end

function var_0_0.GetAllTalentIds(arg_28_0)
	underscore = var_1_10001

	return var_1_10001.select(arg_28_0:GetAllBuffIds(), function(arg_29_0)
		pg = var_2_10001

		local var_29_0 = var_2_10001.child2_benefit_list[arg_29_0].type

		NewEducateBuff = var_2_10003

		local var_29_1

		if var_29_0 == var_2_10003.TYPE.TALENT then
			NewEducateBuff = var_29_0
			var_29_1 = var_29_0.IsVisible(arg_29_0)
		else
			var_29_1 = false
		end

		if false then
			var_29_1 = true
		end

		return var_29_1
	end)
end

function var_0_0.GetActivatedTalentIds(arg_30_0)
	underscore = var_1_10001

	return var_1_10001.select(arg_30_0.buffIds, function(arg_31_0)
		pg = var_2_10001

		local var_31_0 = var_2_10001.child2_benefit_list[arg_31_0].type

		NewEducateBuff = var_2_10003

		local var_31_1

		if var_31_0 == var_2_10003.TYPE.TALENT then
			NewEducateBuff = var_31_0
			var_31_1 = var_31_0.IsVisible(arg_31_0)
		else
			var_31_1 = false
		end

		if false then
			var_31_1 = true
		end

		return var_31_1
	end)
end

function var_0_0.GetAllEntryIds(arg_32_0)
	underscore = var_1_10001

	return var_1_10001.select(arg_32_0:GetAllBuffIds(), function(arg_33_0)
		pg = var_2_10001

		local var_33_0 = var_2_10001.child2_benefit_list[arg_33_0].type

		NewEducateBuff = var_2_10003

		local var_33_1

		if var_33_0 == var_2_10003.TYPE.ENTRY then
			NewEducateBuff = var_33_0
			var_33_1 = var_33_0.IsVisible(arg_33_0)
		else
			var_33_1 = false
		end

		if false then
			var_33_1 = true
		end

		return var_33_1
	end)
end

function var_0_0.InitEntryConfig(arg_34_0)
	arg_34_0.entryGroup2Ids = {}
	ipairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0:GetAllEntryIds()) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.child2_benefit_list[iter_34_1].level_tag

		local var_34_0

		if not arg_34_0.entryGroup2Ids[var_1_10006] then
			var_34_0 = arg_34_0.entryGroup2Ids
			var_34_0[var_1_10006] = {}
		end

		table = var_34_0

		var_34_0.insert(arg_34_0.entryGroup2Ids[var_1_10006], iter_34_1)
	end

	return
end

function var_0_0.GetEntryGroup2Ids(arg_35_0)
	return arg_35_0.entryGroup2Ids
end

function var_0_0.GetAllEntryGroups(arg_36_0)
	underscore = var_1_10001

	return var_1_10001.keys(arg_36_0.entryGroup2Ids)
end

function var_0_0.GetActivatedEntryIds(arg_37_0)
	underscore = var_1_10001

	return var_1_10001.select(arg_37_0.buffIds, function(arg_38_0)
		pg = var_2_10001

		local var_38_0 = var_2_10001.child2_benefit_list[arg_38_0].type

		NewEducateBuff = var_2_10003

		local var_38_1

		if var_38_0 == var_2_10003.TYPE.ENTRY then
			NewEducateBuff = var_38_0
			var_38_1 = var_38_0.IsVisible(arg_38_0)
		else
			var_38_1 = false
		end

		if false then
			var_38_1 = true
		end

		return var_38_1
	end)
end

function var_0_0.GetUnlockEntryGroups(arg_39_0)
	local var_39_0 = {}

	ipairs = var_1_10002

	for iter_39_0, iter_39_1 in var_1_10002(arg_39_0:GetActivatedEntryIds()) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.child2_benefit_list[iter_39_1].level_tag
		table = var_1_10008

		if not var_1_10008.contains(var_39_0, var_1_10007) then
			table = var_1_10008

			var_1_10008.insert(var_39_0, var_1_10007)
		end
	end

	return var_39_0
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
	table = var_1_10002

	if not var_1_10002.contains(arg_44_0.buffIds, arg_44_1) then
		table = var_2

		var_2.insert(arg_44_0.buffIds, arg_44_1)
	end

	return
end

function var_0_0.InitSecretary(arg_45_0)
	arg_45_0.unlcokTipByPolaroidCnt = {}
	ipairs = var_1
	pg = var_1_10003

	for iter_45_0, iter_45_1 in var_1(var_1_10003.secretary_special_ship.all) do
		pg = var_1_10006

		local var_45_0 = var_1_10006.secretary_special_ship[iter_45_1].unlock_type

		EducateConst = var_1_10008

		if var_45_0 == var_1_10008.SECRETARY_UNLCOK_TYPE_POLAROID then
			local var_45_1 = var_1_10006.unlock[1]

			table = var_1_10008

			if not var_1_10008.contains(arg_45_0.unlcokTipByPolaroidCnt, var_45_1) then
				table = var_1_10008

				var_1_10008.insert(arg_45_0.unlcokTipByPolaroidCnt, var_45_1)
			end
		end
	end

	return
end

function var_0_0.CheckSecretaryID(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_2 == "or" then
		ipairs = var_1_10003

		for iter_46_0, iter_46_1 in var_1_10003(arg_46_1) do
			table = var_1_10008

			if var_1_10008.contains(arg_46_0.activatedEndings, iter_46_1[1]) then
				return true
			end
		end

		return false
	elseif arg_46_2 == "and" then
		ipairs = var_1_10003

		for iter_46_2, iter_46_3 in var_1_10003(arg_46_1) do
			table = var_1_10008

			if not var_1_10008.contains(arg_46_0.activatedEndings, iter_46_3) then
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
		Clone = var_1_10003
		NewEducateHelper = var_1_10005
		var_47_0 = var_1_10003(var_1_10005.GetAllUnlockSecretaryIds())
	end

	arg_47_0.unlockSecretaryIds = {}

	local var_47_1 = #arg_47_0.unlockPolaroidGroups

	ipairs = var_1_10004
	pg = var_1_10006

	local var_47_2

	if not var_1_10006.secretary_special_ship.get_id_list_by_tb_id[arg_47_0.id] then
		var_47_2 = {}
	end

	for iter_47_0, iter_47_1 in var_1_10004(var_47_2) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.secretary_special_ship[iter_47_1].unlock_type
		pg = var_1_10010
		var_1_10010 = var_1_10010.secretary_special_ship[iter_47_1].unlock
		switch = var_1_10011

		local var_47_3 = var_1_10009
		local var_47_4 = {}

		EducateConst = var_1_10015
		var_47_4[var_1_10015.SECRETARY_UNLCOK_TYPE_DEFAULT] = function()
			return
		end
		EducateConst = var_1_10015
		var_47_4[var_1_10015.SECRETARY_UNLCOK_TYPE_POLAROID] = function()
			if var_1_10010[1] and var_47_1 >= var_1_10010[1] then
				table = var_0

				var_0.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
			end

			return
		end
		EducateConst = var_1_10015
		var_47_4[var_1_10015.SECRETARY_UNLCOK_TYPE_ENDING] = function()
			if var_1_10010[1] then
				type = var_0

				if var_0(var_1_10010[1]) == "table" then
					local var_50_0 = arg_47_0

					if var_0.CheckSecretaryID(var_50_0, var_1_10010, "or") then
						table = var_0

						var_0.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
					end
				else
					type = var_0

					if var_0(var_1_10010[1]) == "number" then
						local var_50_1 = arg_47_0

						if var_0.CheckSecretaryID(var_50_1, var_1_10010, "and") then
							table = var_0

							var_0.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
						end
					end
				end
			end

			return
		end
		EducateConst = var_1_10015
		var_47_4[var_1_10015.SECRETARY_UNLCOK_TYPE_SHOP] = function()
			if var_1_10010[1] then
				getProxy = var_0
				ShipSkinProxy = var_2_10002

				local var_51_0 = var_0(var_2_10002)

				if var_0.hasSkin(var_51_0, var_1_10010[1]) then
					table = var_0

					var_0.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
				end
			end

			return
		end
		EducateConst = var_1_10015
		var_47_4[var_1_10015.SECRETARY_UNLCOK_TYPE_STORY] = function()
			if var_1_10010[1] then
				pg = var_0

				local var_52_0 = var_0.NewStoryMgr.GetInstance()
				local var_52_1 = var_0.IsPlayed

				pg = var_2_10003

				local var_52_2 = var_2_10003.NewStoryMgr.GetInstance()

				if var_52_1(var_52_0, var_3.StoryId2StoryName(var_52_2, var_1_10010[1])) then
					table = var_0

					var_0.insert(arg_47_0.unlockSecretaryIds, iter_47_1)
				end
			end

			return
		end

		var_1_10011(var_47_3, var_47_4)
	end

	if arg_47_1 then
		getProxy = var_4
		SettingsProxy = var_6

		local var_47_5 = var_4(var_6)

		var_4.UpdateEducateCharTip(var_47_5, var_47_0)
	end

	return
end

function var_0_0.GetUnlockSecretaryIds(arg_53_0)
	return arg_53_0.unlockSecretaryIds
end

return var_0_0
