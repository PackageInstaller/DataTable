class = var_0_10000

local var_0_0 = "AuctionGameCollectionContourItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BasePanel"))

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

		AuctionGameCollectionListLayer = var_2_10002

		var_3_1(var_3_0, var_2_10002.ON_SWITCH_CONTOUR, arg_2_0.contourData)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	return
end

function var_0_1.didEnter(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.contourData = {
		arg_4_2,
		arg_4_1
	}

	if arg_4_1 == 0 then
		setText = var_3

		local var_4_0 = arg_4_0.uiText

		i18n = var_1_10005

		var_3(var_4_0, var_1_10005("auction_game_rarity_0"))
	else
		setText = var_3

		local var_4_1 = arg_4_0.uiText

		string = var_1_10005

		var_3(var_4_1, var_1_10005.format("%s×%s", arg_4_2, arg_4_1))
	end

	setActive = var_3

	var_3(arg_4_0._go, true)
	arg_4_0:SetSelectedContour({
		0,
		0
	})

	return
end

function var_0_1.SetSelectedContour(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1[1] == arg_5_0.contourData[1] and arg_5_1[2] == arg_5_0.contourData[2]

	setActive = var_3

	var_3(arg_5_0.uiSelectedGo, var_5_0)

	setTextColor = var_3

	local var_5_1 = arg_5_0.uiText

	if var_5_0 then
		Color = var_5_2

		local var_5_2

		if not var_5_2.NewHex("#FFFFFF") then
			Color = var_5_2
			var_5_2 = var_5_2.NewHex("#393a3c")
		end

		var_3(var_5_1, var_5_2)

		return
	end
end

function var_0_1.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_1
