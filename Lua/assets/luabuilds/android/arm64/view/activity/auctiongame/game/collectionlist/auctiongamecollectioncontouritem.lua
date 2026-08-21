local var_0_0 = class("AuctionGameCollectionContourItem", import("view.base.BasePanel"))

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
		arg_2_0:emit(AuctionGameCollectionListLayer.ON_SWITCH_CONTOUR, arg_2_0.contourData)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.contourData = {
		arg_4_2,
		arg_4_1
	}

	if arg_4_1 == 0 then
		setText(arg_4_0.uiText, i18n("auction_game_rarity_0"))
	else
		setText(arg_4_0.uiText, string.format("%s×%s", arg_4_2, arg_4_1))
	end

	setActive(arg_4_0._go, true)
	arg_4_0:SetSelectedContour({
		0,
		0
	})

	return
end

function var_0_0.SetSelectedContour(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1[1] == arg_5_0.contourData[1] and arg_5_1[2] == arg_5_0.contourData[2]

	setActive(arg_5_0.uiSelectedGo, arg_5_1[1] == arg_5_0.contourData[1] and arg_5_1[2] == arg_5_0.contourData[2])

	local var_5_1 = var_5_0 and Color.NewHex("#FFFFFF") or Color.NewHex("#393a3c")

	setTextColor(arg_5_0.uiText, var_5_1)

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:detach()

	return
end

return var_0_0
