local SortGameRunningData = class("SortGameRunningData")

function SortGameRunningData:Ctor()
	return
end

function SortGameRunningData:SetChapterData(arg_2_1)
	self._chapter = arg_2_1

	self:initData()

	return
end

function SortGameRunningData:initData()
	self._playerIds = self:GetChapterConfig("player_list")
	self._playerWantedItem = self:GetPlayersItems(self._playerIds)

	return
end

function SortGameRunningData:GetPlayerName(arg_4_1)
	return SortGameConst.player_data[arg_4_1].name
end

function SortGameRunningData:GetPlayerIdByItem(arg_5_1)
	for iter_5_0 = 1, #self._playerIds do
		if table.contains(SortGameConst.player_data[self._playerIds[iter_5_0]].items, arg_5_1) then
			return self._playerIds[iter_5_0]
		end
	end

	return nil
end

function SortGameRunningData:GetChapterConfig(arg_6_1)
	return Clone(self._chapter[arg_6_1])
end

function SortGameRunningData:GetBoundConfig()
	return Clone(SortGameConst.bounds_data[self._chapter.bound])
end

function SortGameRunningData:GetOffsetConfig()
	return Clone(SortGameConst.grid_offset[self._chapter.offset])
end

function SortGameRunningData:GetAllPlayerItems()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(self._playerIds) do
		for iter_9_2 = 1, #SortGameConst.player_data[iter_9_1].items do
			table.insert(var_9_0, SortGameConst.player_data[iter_9_1].items[iter_9_2])
		end
	end

	return var_9_0
end

function SortGameRunningData:GetPlayers()
	return self._playerIds
end

function SortGameRunningData:GetPlayersItems(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_1 = self:GetPlayerItems(iter_11_1)

		for iter_11_2 = 1, #var_11_1 do
			table.insert(var_11_0, var_11_1[iter_11_2])
		end
	end

	return var_11_0
end

function SortGameRunningData:GetPlayerItems(arg_12_1)
	local var_12_0 = {}

	if arg_12_1 then
		for iter_12_0 = 1, #SortGameConst.player_data[arg_12_1].items do
			table.insert(var_12_0, SortGameConst.player_data[arg_12_1].items[iter_12_0])
		end
	end

	return var_12_0
end

function SortGameRunningData:GetComonItems()
	local var_13_0 = {}
	local var_13_1 = self:GetPlayersItems(self._playerIds)

	for iter_13_0 = 1, #SortGameConst.common_item_id do
		if not table.contains(var_13_1, SortGameConst.common_item_id[iter_13_0]) then
			table.insert(var_13_0, SortGameConst.common_item_id[iter_13_0])
		end
	end

	self:shuffleArray(var_13_0)

	return var_13_0
end

function SortGameRunningData:shuffleArray(arg_14_1)
	for iter_14_0 = #arg_14_1, 2, -1 do
		local var_14_0 = math.random(1, iter_14_0)

		arg_14_1[iter_14_0], arg_14_1[var_14_0] = arg_14_1[var_14_0], arg_14_1[iter_14_0]
	end

	return
end

function SortGameRunningData:GetPlayerPrefab(arg_15_1)
	if arg_15_1 == nil then
		arg_15_1 = self._playerIds[math.random(1, #self._playerIds)]
	end

	return Clone(SortGameConst.player_data[arg_15_1].prefab)
end

function SortGameRunningData:GetRandomWantedItem(arg_16_1)
	if #self._playerWantedItem == 0 then
		return nil
	end

	local var_16_0 = self:GetItemCountDic(arg_16_1)

	for iter_16_0 = 1, #self._playerWantedItem do
		if var_16_0[self._playerWantedItem[iter_16_0]] and var_16_0[self._playerWantedItem[iter_16_0]] >= 3 then
			return self._playerWantedItem[iter_16_0]
		end
	end

	return nil
end

function SortGameRunningData:GetItemCountDic(arg_17_1)
	local var_17_0 = {}

	for iter_17_0 = 1, #arg_17_1 do
		var_17_0[arg_17_1[iter_17_0]] = var_17_0[arg_17_1[iter_17_0]] == nil and 1 or var_17_0[arg_17_1[iter_17_0]] + 1
	end

	return var_17_0
end

function SortGameRunningData:GetSpeakData(arg_18_1, arg_18_2)
	local var_18_0 = self:GetChatConfig(arg_18_1, arg_18_2)

	if var_18_0 ~= nil then
		return {
			text = var_18_0.text,
			time = var_18_0.show_time / 1000,
			icon = var_18_0.sculpture
		}
	end

	return nil
end

function SortGameRunningData:GetChatConfig(arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2 or self:GetPlayerName(self._playerIds[math.random(1, #self._playerIds)])

	for iter_19_0 = 1, #pg.activity_event_sortgame_chat.all do
		if pg.activity_event_sortgame_chat[pg.activity_event_sortgame_chat.all[iter_19_0]].sculpture == var_19_0 and pg.activity_event_sortgame_chat[pg.activity_event_sortgame_chat.all[iter_19_0]].type == arg_19_1 then
			return pg.activity_event_sortgame_chat[pg.activity_event_sortgame_chat.all[iter_19_0]]
		end
	end

	return nil
end

function SortGameRunningData:Clear()
	return
end

function SortGameRunningData:Dispose()
	return
end

return SortGameRunningData
