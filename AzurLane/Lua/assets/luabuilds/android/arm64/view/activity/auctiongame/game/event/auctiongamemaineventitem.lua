class = var_0_10000

local var_0_0 = "AuctionGameMainEventItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

var_0_1.AUCTION_GAME_SELECTED_EVENT = "AuctionGameMainEventItem::AUCTION_GAME_SELECTED_EVENT"

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
		getProxy = var_2_10000
		AuctionGameProxy = var_2_10002

		local var_3_0 = var_2_10000(var_2_10002)

		if var_0.GetPersonalEventSelectedID(var_3_0) ~= 0 then
			return
		end

		local var_3_1 = arg_2_0

		var_1.emit(var_3_1, var_0_1.AUCTION_GAME_SELECTED_EVENT, arg_2_0.id)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	return
end

function var_0_1.didEnter(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1
	pg = var_1_10002

	local var_4_0 = var_1_10002.auction_event[arg_4_1]

	setText = var_1_10003

	local var_4_1 = arg_4_0.uiNameText

	shortenString = var_1_10006

	var_1_10003(var_4_1, var_1_10006(var_4_0.name, 9))

	setText = var_1_10003

	var_1_10003(arg_4_0.uiDescText, var_4_0.describe)

	LoadSpriteAsync = var_1_10003

	var_1_10003(var_4_0.icon, function(arg_5_0)
		IsNil = var_2_10001

		if var_2_10001(arg_4_0.uiIconImage) then
			return
		end

		arg_4_0.uiIconImage.sprite = arg_5_0

		return
	end)

	return
end

function var_0_1.SetSelected(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0.uiSelectedGo, arg_6_0.id == arg_6_1)

	return
end

function var_0_1.willExit(arg_7_0)
	arg_7_0:detach()

	return
end

return var_0_1
