local var_0_0 = singletonClass("ChatStickerData")

function var_0_0.Init(arg_1_0)
	arg_1_0.customStickerList_ = {}
	arg_1_0.customStickerUIList_ = {}
	arg_1_0.unlockStickerList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.customStickerList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.emoticon_id_list) do
		table.insert(arg_2_0.customStickerList_, iter_2_1)
	end

	arg_2_0.unlockStickerList_ = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.unlocked_emoji_list or {}) do
		table.insert(arg_2_0.unlockStickerList_, iter_2_3)
	end
end

function var_0_0.GetCustomStickerList(arg_3_0)
	return arg_3_0.customStickerList_
end

function var_0_0.SetCustomStickerList(arg_4_0, arg_4_1)
	arg_4_0.customStickerList_ = arg_4_1
end

function var_0_0.GetCustomStickerUIList(arg_5_0)
	return arg_5_0.customStickerUIList_
end

function var_0_0.InitStickerUIList(arg_6_0)
	arg_6_0.customStickerUIList_ = clone(arg_6_0.customStickerList_)
end

function var_0_0.ChangeCustomStickerUIList(arg_7_0, arg_7_1)
	local var_7_0 = table.keyof(arg_7_0.customStickerUIList_, arg_7_1)

	if var_7_0 then
		table.remove(arg_7_0.customStickerUIList_, var_7_0)
	else
		table.insert(arg_7_0.customStickerUIList_, arg_7_1)
	end
end

function var_0_0.SaveData(arg_8_0)
	arg_8_0.customStickerList_ = clone(arg_8_0.customStickerUIList_)
end

function var_0_0.IsLockSticker(arg_9_0, arg_9_1)
	return not table.keyof(arg_9_0.unlockStickerList_, arg_9_1)
end

function var_0_0.UnlockSticker(arg_10_0, arg_10_1)
	table.insert(arg_10_0.unlockStickerList_, arg_10_1)
end

return var_0_0
