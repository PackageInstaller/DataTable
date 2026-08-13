class = var_0_10000

local var_0_0 = "IslandRestaurantSettlePage4Event"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandRestaurantSettlePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandRestaurantSettle4EventUI"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	UIItemList = var_1

	local var_2_0 = var_1.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "window/event/addition")
	local var_2_3 = arg_2_0._tf

	arg_2_0.additionList = var_2_0(var_2_2, var_4.Find(var_2_3, "window/event/addition/tpl"))

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "window/summary/price/info/addition/Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.priceAdd = var_2_6(var_2_5, var_4(var_2_3))
	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "window/event/Image/Text")

	i18n = var_4

	var_1(var_2_8, var_4("island_post_event_label"))

	return
end

function var_0_1.OnShow(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:UpdateAddition(arg_3_1)
	arg_3_0:UpdatePriceAdd(arg_3_1)

	local var_3_0

	if not arg_3_1.itemList then
		var_3_0 = {}
	end

	arg_3_0.itemList = var_3_0

	var_0_1.super.OnShow(arg_3_0, arg_3_1, arg_3_2)

	return
end

function var_0_1.UpdateAddition(arg_4_0, arg_4_1)
	pg = var_1_10002

	local var_4_0 = var_1_10002.island_manage_event[arg_4_1.spEventID]
	local var_4_1 = arg_4_0:WarpAdditionInfo(var_4_0)
	local var_4_2 = arg_4_0.additionList

	var_4.make(var_4_2, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			setText = var_3

			var_3(arg_5_2:Find("Text"), var_4_1[arg_5_1 + 1][1])

			setText = var_3

			var_3(arg_5_2:Find("value"), "+" .. var_4_1[arg_5_1 + 1][2] .. "%")
		end

		return
	end)

	local var_4_3 = arg_4_0.additionList

	var_4.align(var_4_3, #var_4_1)

	return
end

function var_0_1.WarpAdditionInfo(arg_6_0, arg_6_1)
	local var_6_0 = {}

	table = var_1_10003

	local var_6_1 = var_1_10003.insert
	local var_6_2 = var_6_0
	local var_6_3 = {}

	i18n = var_1_10007
	var_6_3[1] = var_1_10007("island_addition_influence")
	var_6_3[2] = arg_6_1.influence_bonus

	var_6_1(var_6_2, var_6_3)

	table = var_6_1

	local var_6_4 = var_6_1.insert
	local var_6_5 = var_6_0
	local var_6_6 = {}

	i18n = var_7
	var_6_6[1] = var_7("island_addition_sale")
	var_6_6[2] = arg_6_1.event_effect[1][1]

	var_6_4(var_6_5, var_6_6)

	return var_6_0
end

function var_0_1.UpdatePriceAdd(arg_7_0, arg_7_1)
	arg_7_0.priceAdd.text = "(+" .. arg_7_1.priceAdd .. ")"

	return
end

function var_0_1.UpdateCommonItem(arg_8_0, arg_8_1, arg_8_2)
	var_0_1.super.UpdateCommonItem(arg_8_0, arg_8_1, arg_8_2)

	setActive = var_3

	local var_8_0 = arg_8_1:Find("event")

	table = var_6

	var_3(var_8_0, var_6.contains(arg_8_0.itemList, arg_8_2.id))

	return
end

return var_0_1
