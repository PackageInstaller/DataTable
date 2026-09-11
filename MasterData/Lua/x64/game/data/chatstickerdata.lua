local var_0_0 = singletonClass("ChatStickerData")

function var_0_0.Init(arg_1_0)
	arg_1_0.customStickerList_ = {}
	arg_1_0.customStickerUIList_ = {}
	arg_1_0.unlockStickerList_ = {}
end

function var_0_0:InitData(arg_2_1)
	self.customStickerList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.emoticon_id_list) do
		table.insert(self.customStickerList_, iter_2_1)
	end

	self.unlockStickerList_ = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.unlocked_emoji_list or {}) do
		table.insert(self.unlockStickerList_, iter_2_3)
	end
end

function var_0_0:GetCustomStickerList()
	return self.customStickerList_
end

function var_0_0.SetCustomStickerList(arg_4_0, arg_4_1)
	arg_4_0.customStickerList_ = arg_4_1
end

function var_0_0:GetCustomStickerUIList()
	return self.customStickerUIList_
end

function var_0_0:InitStickerUIList()
	self.customStickerUIList_ = clone(self.customStickerList_)
end

function var_0_0:ChangeCustomStickerUIList(arg_7_1)
	local var_7_0 = table.keyof(self.customStickerUIList_, arg_7_1)

	if var_7_0 then
		table.remove(self.customStickerUIList_, var_7_0)
	else
		table.insert(self.customStickerUIList_, arg_7_1)
	end
end

function var_0_0:SaveData()
	self.customStickerList_ = clone(self.customStickerUIList_)
end

function var_0_0:IsLockSticker(arg_9_1)
	return not table.keyof(self.unlockStickerList_, arg_9_1)
end

function var_0_0:UnlockSticker(arg_10_1)
	table.insert(self.unlockStickerList_, arg_10_1)
end

return var_0_0
