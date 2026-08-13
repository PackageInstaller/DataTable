class = var_0_10000

local var_0_0 = var_0_10000("SortGameRunningData")

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
	SortGameConst = var_1_10002

	return var_1_10002.player_data[arg_4_1].name
end

function var_0_0.GetPlayerIdByItem(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_0._playerIds do
		local var_5_0 = arg_5_0._playerIds[iter_5_0]

		table = var_1_10007
		var_1_10007 = var_1_10007.contains
		SortGameConst = var_1_10009

		if var_1_10007(var_1_10009.player_data[var_5_0].items, arg_5_1) then
			return var_5_0
		end
	end

	return nil
end

function var_0_0.GetChapterConfig(arg_6_0, arg_6_1)
	Clone = var_1_10002

	return var_1_10002(arg_6_0._chapter[arg_6_1])
end

function var_0_0.GetBoundConfig(arg_7_0)
	Clone = var_1_10001
	SortGameConst = var_1_10003

	return var_1_10001(var_1_10003.bounds_data[arg_7_0._chapter.bound])
end

function var_0_0.GetOffsetConfig(arg_8_0)
	Clone = var_1_10001
	SortGameConst = var_1_10003

	return var_1_10001(var_1_10003.grid_offset[arg_8_0._chapter.offset])
end

function var_0_0.GetAllPlayerItems(arg_9_0)
	local var_9_0 = {}

	pairs = var_1_10002

	for iter_9_0, iter_9_1 in var_1_10002(arg_9_0._playerIds) do
		local var_9_1 = 1

		SortGameConst = var_1_10008

		for iter_9_2 = var_9_1, #var_1_10008.player_data[iter_9_1].items do
			SortGameConst = var_1_10011
			var_1_10011 = var_1_10011.player_data[iter_9_1].items[iter_9_2]
			table = var_1_10012

			var_1_10012.insert(var_9_0, var_1_10011)
		end
	end

	return var_9_0
end

function var_0_0.GetPlayers(arg_10_0)
	return arg_10_0._playerIds
end

function var_0_0.GetPlayersItems(arg_11_0, arg_11_1)
	local var_11_0 = {}

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_1) do
		local var_11_1 = arg_11_0:GetPlayerItems(iter_11_1)

		for iter_11_2 = 1, #var_11_1 do
			table = var_1_10013

			var_1_10013.insert(var_11_0, var_11_1[iter_11_2])
		end
	end

	return var_11_0
end

function var_0_0.GetPlayerItems(arg_12_0, arg_12_1)
	local var_12_0 = {}

	if arg_12_1 then
		local var_12_1 = 1

		SortGameConst = var_1_10004

		for iter_12_0 = var_12_1, #var_1_10004.player_data[arg_12_1].items do
			SortGameConst = var_1_10007
			var_1_10007 = var_1_10007.player_data[arg_12_1].items[iter_12_0]
			table = var_1_10008

			var_1_10008.insert(var_12_0, var_1_10007)
		end
	end

	return var_12_0
end

function var_0_0.GetComonItems(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = arg_13_0
	local var_13_2 = arg_13_0.GetPlayersItems(var_13_1, arg_13_0._playerIds)
	local var_13_3 = 1

	SortGameConst = var_13_1

	for iter_13_0 = var_13_3, #var_13_1.common_item_id do
		SortGameConst = var_1_10007
		var_1_10007 = var_1_10007.common_item_id[iter_13_0]
		table = var_1_10008

		if not var_1_10008.contains(var_13_2, var_1_10007) then
			table = var_1_10008

			var_1_10008.insert(var_13_0, var_1_10007)
		end
	end

	arg_13_0:shuffleArray(var_13_0)

	return var_13_0
end

function var_0_0.shuffleArray(arg_14_0, arg_14_1)
	for iter_14_0 = #arg_14_1, 2, -1 do
		math = var_1_10006
		arg_14_1[iter_14_0], arg_14_1[var_1_10006] = arg_14_1[var_1_10006.random(1, iter_14_0)], arg_14_1[iter_14_0]
	end

	return
end

function var_0_0.GetPlayerPrefab(arg_15_0, arg_15_1)
	if arg_15_1 == nil then
		var_1_10002 = arg_15_0._playerIds
		math = var_1_10003
		arg_15_1 = var_1_10002[var_1_10003.random(1, #arg_15_0._playerIds)]
	end

	Clone = var_1_10002
	SortGameConst = var_1_10004

	return var_1_10002(var_1_10004.player_data[arg_15_1].prefab)
end

function var_0_0.GetRandomWantedItem(arg_16_0, arg_16_1)
	if #arg_16_0._playerWantedItem == 0 then
		return nil
	end

	local var_16_0 = arg_16_0:GetItemCountDic(arg_16_1)

	for iter_16_0 = 1, #arg_16_0._playerWantedItem do
		if var_16_0[arg_16_0._playerWantedItem[iter_16_0]] and var_16_0[var_7] >= 3 then
			return var_7
		end
	end

	return nil
end

function var_0_0.GetItemCountDic(arg_17_0, arg_17_1)
	local var_17_0 = {}

	for iter_17_0 = 1, #arg_17_1 do
		if var_17_0[arg_17_1[iter_17_0]] == nil then
			var_17_0[var_7] = 1
		else
			var_17_0[var_7] = var_17_0[var_7] + 1
		end
	end

	return var_17_0
end

function var_0_0.GetSpeakData(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0:GetChatConfig(arg_18_1, arg_18_2) ~= nil then
		return {
			text = var_3.text,
			time = var_3.show_time / 1000,
			icon = var_3.sculpture
		}
	end

	return nil
end

function var_0_0.GetChatConfig(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0

	if not arg_19_2 then
		::label_19_0::

		var_1_10005 = arg_19_0
		var_19_0 = arg_19_0.GetPlayerName

		local var_19_1 = arg_19_0._playerIds

		math = var_1_10007
		var_19_0 = var_19_0(var_1_10005, var_19_1[var_1_10007.random(1, #arg_19_0._playerIds)])
	end

	local var_19_2 = 1

	pg = var_1_10005

	for iter_19_0 = var_19_2, #var_1_10005.activity_event_sortgame_chat.all do
		pg = var_1_10008
		var_1_10008 = var_1_10008.activity_event_sortgame_chat.all[iter_19_0]
		pg = var_1_10009

		if var_1_10009.activity_event_sortgame_chat[var_1_10008].sculpture == var_19_0 and var_1_10009.type == arg_19_1 then
			return var_1_10009
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
