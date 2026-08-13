class = var_0_10000

local var_0_0 = "AuctionGameCollectionRarityItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiBtn

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		AuctionGameCollectionListLayer = var_2_10003

		var_3_1(var_3_0, var_2_10003.ON_SWITCH_RARITY, arg_2_0.rarity)

		return
	end

	SFX_PANE = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	return
end

function var_0_1.didEnter(arg_4_0, arg_4_1)
	setText = var_1_10002

	local var_4_0 = arg_4_0.uiText

	i18n = var_1_10005

	var_1_10002(var_4_0, var_1_10005("auction_game_rarity_" .. arg_4_1))

	arg_4_0.rarity = arg_4_1
	setActive = var_1_10002

	var_1_10002(arg_4_0._go, true)
	arg_4_0:SetSelectedRarity(0)

	return
end

function var_0_1.SetSelectedRarity(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.rarity == arg_5_1

	setActive = var_1_10003

	var_1_10003(arg_5_0.uiSelectedGo, var_5_0)

	setTextColor = var_1_10003

	local var_5_1 = arg_5_0.uiText

	if var_5_0 then
		Color = var_5_2

		local var_5_2

		if not var_5_2.NewHex("#FFFFFF") then
			Color = var_5_2
			var_5_2 = var_5_2.NewHex("#393a3c")
		end

		var_1_10003(var_5_1, var_5_2)

		return
	end
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_1
