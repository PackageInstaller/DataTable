local var_0_0 = class("SortGameRunningData")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.SetChapterData(arg_2_0, arg_2_1)
	arg_2_0._chapter = arg_2_1

	arg_2_0:initData()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0._playerIds = arg_3_0:GetChapterConfig("player_list")
	arg_3_0._playerWantedItem = arg_3_0:GetPlayersItems(arg_3_0._playerIds)

	return
end

function var_0_0.GetPlayerName(arg_4_0, arg_4_1)
	return SortGameConst.player_data[arg_4_1].name
end

function var_0_0.GetPlayerIdByItem(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_0._playerIds do
		if table.contains(SortGameConst.player_data[arg_5_0._playerIds[iter_5_0]].items, arg_5_1) then
			return arg_5_0._playerIds[iter_5_0]
		end
	end

	return nil
end

function var_0_0.GetChapterConfig(arg_6_0, arg_6_1)
	return Clone(arg_6_0._chapter[arg_6_1])
end

function var_0_0.GetBoundConfig(arg_7_0)
	return Clone(SortGameConst.bounds_data[arg_7_0._chapter.bound])
end

function var_0_0.GetOffsetConfig(arg_8_0)
	return Clone(SortGameConst.grid_offset[arg_8_0._chapter.offset])
end

function var_0_0.GetAllPlayerItems(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._playerIds) do
		for iter_9_2 = 1, #SortGameConst.player_data[iter_9_1].items do
			table.insert({}, SortGameConst.player_data[iter_9_1].items[iter_9_2])
		end
	end

	return {}
end

function var_0_0.GetPlayers(arg_10_0)
	return arg_10_0._playerIds
end

function var_0_0.GetPlayersItems(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_0 = arg_11_0:GetPlayerItems(iter_11_1)

		for iter_11_2 = 1, #var_11_0 do
			table.insert({}, var_11_0[iter_11_2])
		end
	end

	return {}
end

function var_0_0.GetPlayerItems(arg_12_0, arg_12_1)
	if arg_12_1 then
		for iter_12_0 = 1, #SortGameConst.player_data[arg_12_1].items do
			table.insert({}, SortGameConst.player_data[arg_12_1].items[iter_12_0])
		end
	end

	return {}
end

function var_0_0.GetComonItems(arg_13_0)
	local var_13_0 = arg_13_0:GetPlayersItems(arg_13_0._playerIds)

	for iter_13_0 = 1, #SortGameConst.common_item_id do
		if not table.contains(var_13_0, SortGameConst.common_item_id[iter_13_0]) then
			table.insert({}, SortGameConst.common_item_id[iter_13_0])
		end
	end

	arg_13_0:shuffleArray({})

	return {}
end

function var_0_0.shuffleArray(arg_14_0, arg_14_1)
	for iter_14_0 = #arg_14_1, 2, -1 do
		local var_14_0 = math.random(1, iter_14_0)

		arg_14_1[iter_14_0], arg_14_1[var_14_0] = arg_14_1[var_14_0], arg_14_1[iter_14_0]
	end

	return
end

function var_0_0.GetPlayerPrefab(arg_15_0, arg_15_1)
	if arg_15_1 == nil then
		arg_15_1 = arg_15_0._playerIds[math.random(1, #arg_15_0._playerIds)]
	end

	return Clone(SortGameConst.player_data[arg_15_1].prefab)
end

function var_0_0.GetRandomWantedItem(arg_16_0, arg_16_1)
	if #arg_16_0._playerWantedItem == 0 then
		return nil
	end

	local var_16_0 = arg_16_0:GetItemCountDic(arg_16_1)

	for iter_16_0 = 1, #arg_16_0._playerWantedItem do
		if var_16_0[arg_16_0._playerWantedItem[iter_16_0]] and var_16_0[arg_16_0._playerWantedItem[iter_16_0]] >= 3 then
			return arg_16_0._playerWantedItem[iter_16_0]
		end
	end

	return nil
end

function var_0_0.GetItemCountDic(arg_17_0, arg_17_1)
	for iter_17_0 = 1, #arg_17_1 do
		if ({})[arg_17_1[iter_17_0]] == nil then
			({})[arg_17_1[iter_17_0]] = 1
		else
			({})[arg_17_1[iter_17_0]] = ({})[arg_17_1[iter_17_0]] + 1
		end
	end

	return {}
end

function var_0_0.GetSpeakData(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:GetChatConfig(arg_18_1, arg_18_2)

	if var_18_0 ~= nil then
		return {
			text = var_18_0.text,
			time = var_18_0.show_time / 1000,
			icon = var_18_0.sculpture
		}
	end

	return nil
end

function var_0_0.GetChatConfig(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2 or arg_19_0:GetPlayerName(arg_19_0._playerIds[math.random(1, #arg_19_0._playerIds)])

	for iter_19_0 = 1, #pg.activity_event_sortgame_chat.all do
		if pg.activity_event_sortgame_chat[pg.activity_event_sortgame_chat.all[iter_19_0]].sculpture == var_19_0 and pg.activity_event_sortgame_chat[pg.activity_event_sortgame_chat.all[iter_19_0]].type == arg_19_1 then
			return pg.activity_event_sortgame_chat[pg.activity_event_sortgame_chat.all[iter_19_0]]
		end
	end

	return nil
end

function var_0_0.Clear(arg_20_0)
	return
end

function var_0_0.Dispose(arg_21_0)
	return
end

return var_0_0
