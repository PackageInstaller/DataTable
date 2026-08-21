local var_0_0 = require("game.views.Sticker.StickerChooseItem")
local var_0_1 = class("SpringPreheatLetterSelectStickerItem", var_0_0)

function var_0_1.RefreshItem(arg_1_0, arg_1_1)
	if arg_1_1 == 0 then
		arg_1_0.lockCon_:SetSelectedState("empty")

		arg_1_0.itemID_ = 0

		return
	end

	var_0_1.super.RefreshItem(arg_1_0, arg_1_1)
end

function var_0_1.TrySelect(arg_2_0)
	if arg_2_0.itemID_ == 0 then
		arg_2_0:SetSelected(true)

		return true
	end

	if PlayerData:GetSticker(arg_2_0.itemID_).lock then
		arg_2_0:SetSelected(false)

		return false
	end

	arg_2_0:SetSelected(true)

	return true
end

function var_0_1.RegisterClickListener(arg_3_0, arg_3_1)
	arg_3_0.clickFunc_ = arg_3_1
end

return var_0_1
