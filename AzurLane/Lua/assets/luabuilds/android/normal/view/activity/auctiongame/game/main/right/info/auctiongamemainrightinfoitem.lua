class = var_0_10000

local var_0_0 = "AuctionGameMainRightInfoItem"

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
	return
end

function var_0_1.didEnter(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	pg = var_1_10004

	local var_3_0 = var_1_10004.auction_round[arg_3_1.round].name
	local var_3_1 = arg_3_1.type

	AuctionGameConst = var_1_10006

	if var_3_1 == var_1_10006.EVENT_TYPE_GROUP.COMMON then
		var_3_1 = var_3_0
		i18n = var_6
		var_3_0 = var_3_1 .. var_6("auction_main_public_event")
		setActive = var_3_1

		var_3_1(arg_3_0._go, arg_3_3)
	else
		var_3_1 = var_3_0
		i18n = var_6
		var_3_0 = var_3_1 .. var_6("auction_main_personal_event")
		setActive = var_3_1

		var_3_1(arg_3_0._go, arg_3_2)
	end

	setText = var_3_1

	var_3_1(arg_3_0.uiTitleText, var_3_0)

	getProxy = var_3_1
	AuctionGameProxy = var_6

	local var_3_2 = var_3_1(var_6)
	local var_3_3 = var_5.GetRound(var_3_2) == arg_3_1.round

	pg = var_7

	local var_3_4 = var_7.auction_event[arg_3_1.eventData.eventID]
	local var_3_5 = var_3_3 and "#324bca" or "#676c7d"

	if var_3_4.information_bar == 1 then
		setText = var_9

		local var_3_6 = arg_3_0.uiResultText

		string = var_1_10011

		var_9(var_3_6, var_1_10011.format("<color=%s>%s</color>", var_3_5, var_3_4.describe))
	else
		local var_3_7 = arg_3_1.eventData.value
		local var_3_8 = var_3_4.type

		AuctionGameConst = var_1_10011

		if var_3_8 == var_1_10011.EVENT_TYPE.MAX_RARITY then
			i18n = var_3_8
			var_3_7 = var_3_8("auction_game_rarity_" .. var_3_7)
		else
			var_3_8 = var_3_4.type
			AuctionGameConst = var_11

			if var_3_8 == var_11.EVENT_TYPE.RARITY_ITEMS_CELL_COUNT then
				var_3_7 = var_3_7 / 100
			else
				StringHelper = var_3_8
				var_3_7 = var_3_8.ForamtNumber(var_3_7)
			end
		end

		setText = var_3_8

		local var_3_9 = arg_3_0.uiResultText

		string = var_1_10012

		var_3_8(var_3_9, var_1_10012.format("<color=%s>%s</color>", var_3_5, var_3_4.describe .. "   " .. var_3_7))
	end

	local var_3_10 = arg_3_0.uiResultBg.color

	var_3_10.a = var_3_3 and 0.3 or 0.1
	arg_3_0.uiResultBg.color = var_3_10

	return
end

function var_0_1.willExit(arg_4_0)
	arg_4_0:detach()

	Object = var_1

	var_1.Destroy(arg_4_0._go)

	return
end

return var_0_1
