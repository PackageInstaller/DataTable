local var_0_0 = {}

function var_0_0.FilterChatStickerList(arg_1_0)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0) do
		if not var_0_0.GetIsHide(iter_1_1) then
			table.insert(var_1_0, iter_1_1)
		end
	end

	return var_1_0
end

function var_0_0.SortChatSticker(arg_2_0)
	local var_2_0 = var_0_0.FilterChatStickerList(ChatStickerCfg.get_id_list_by_category[arg_2_0])

	return var_0_0.SortFunction(var_2_0)
end

function var_0_0.SortAllChatSticker()
	local var_3_0 = var_0_0.FilterChatStickerList(ChatStickerCfg.all)

	return var_0_0.SortFunction(var_3_0)
end

function var_0_0.SortFunction(arg_4_0)
	if arg_4_0 == nil then
		return {}
	end

	table.sort(arg_4_0, function(arg_5_0, arg_5_1)
		local var_5_0 = ChatStickerCfg[arg_5_0]
		local var_5_1 = ChatStickerCfg[arg_5_1]
		local var_5_2 = var_5_0.free == 0 and ChatStickerData:IsLockSticker(arg_5_0)
		local var_5_3 = var_5_1.free == 0 and ChatStickerData:IsLockSticker(arg_5_1)

		if var_5_2 == var_5_3 then
			return arg_5_0 < arg_5_1
		end

		return var_5_3 and true or false
	end)

	return arg_4_0
end

function var_0_0.GetIsHide(arg_6_0)
	if ChatStickerCfg[arg_6_0].display_type == 1 then
		return ChatStickerData:IsLockSticker(arg_6_0)
	end

	return arg_6_0 == 0
end

function var_0_0.GetStickerCntInCategory(arg_7_0)
	local var_7_0 = ChatStickerCfg.get_id_list_by_category[arg_7_0]
	local var_7_1 = 0

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if not var_0_0.GetIsHide(iter_7_1) then
				var_7_1 = var_7_1 + 1
			end
		end
	end

	return var_7_1
end

return var_0_0
