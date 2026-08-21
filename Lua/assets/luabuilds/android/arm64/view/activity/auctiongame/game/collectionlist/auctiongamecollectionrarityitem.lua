local var_0_0 = class("AuctionGameCollectionRarityItem", import("view.base.BasePanel"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiBtn, function()
		arg_2_0:emit(AuctionGameCollectionListLayer.ON_SWITCH_RARITY, arg_2_0.rarity)

		return
	end, SFX_PANE)

	return
end

function var_0_0.didEnter(arg_4_0, arg_4_1)
	setText(arg_4_0.uiText, i18n("auction_game_rarity_" .. arg_4_1))

	arg_4_0.rarity = arg_4_1

	setActive(arg_4_0._go, true)
	arg_4_0:SetSelectedRarity(0)

	return
end

function var_0_0.SetSelectedRarity(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.rarity == arg_5_1

	setActive(arg_5_0.uiSelectedGo, arg_5_0.rarity == arg_5_1)

	local var_5_1 = var_5_0 and Color.NewHex("#FFFFFF") or Color.NewHex("#393a3c")

	setTextColor(arg_5_0.uiText, var_5_1)

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_0
