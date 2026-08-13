class = var_0_10000

local var_0_0 = "IslandTradeProductListPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandTradeProductListUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "shopView/Viewport/Content")
	local var_2_3 = arg_2_0._tf

	arg_2_0.uiitemList = var_2_0(var_2_2, var_4.Find(var_2_3, "shopView/Viewport/Content/tpl"))

	return
end

function var_0_1.Show(arg_3_0, arg_3_1)
	var_0_1.super.Show(arg_3_0)

	arg_3_0.island = arg_3_1

	arg_3_0:UpdateProductList()

	return
end

function var_0_1.GetDisplays(arg_4_0)
	local var_4_0 = {}

	IslandItem = var_1_10002

	local var_4_1 = var_1_10002.New
	local var_4_2 = {
		num = 1
	}

	IslandItem = var_1_10005
	var_4_2.id = var_1_10005.PEARL_ID
	var_4_0[1] = var_4_1(var_4_2)

	return var_4_0
end

function var_0_1.UpdateProductList(arg_5_0)
	local var_5_0 = arg_5_0:GetDisplays()
	local var_5_1 = arg_5_0.uiitemList

	var_2.make(var_5_1, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = var_5_0[arg_6_1 + 1]
			local var_6_1 = arg_5_0

			var_4.UpdateItem(var_6_1, arg_6_2, var_6_0)
		end

		return
	end)

	local var_5_2 = arg_5_0.uiitemList

	var_2.align(var_5_2, #var_5_0)

	return
end

function var_0_1.GetPrice(arg_7_0)
	local var_7_0 = arg_7_0.island
	local var_7_1 = var_1.GetTradeAgency(var_7_0)

	return (var_1.GetTodayPrice(var_7_1))
end

function var_0_1.UpdateItem(arg_8_0, arg_8_1, arg_8_2)
	setText = var_1_10003

	var_1_10003(arg_8_1:Find("name"), arg_8_2:getConfig("name"))

	updateCustomDrop = var_1_10003

	local var_8_0 = arg_8_1:Find("item")

	Drop = var_6

	local var_8_1 = var_6.New
	local var_8_2 = {
		count = 0
	}

	DROP_TYPE_ISLAND_ITEM = var_9
	var_8_2.type = var_9
	var_8_2.id = arg_8_2.id

	var_1_10003(var_8_0, var_8_1(var_8_2))

	setText = var_1_10003

	var_1_10003(arg_8_1:Find("name"), arg_8_2:getConfig("name"))

	setText = var_1_10003

	local var_8_3 = arg_8_1:Find("cost/num")
	local var_8_4 = arg_8_0

	var_1_10003(var_8_3, arg_8_0.GetPrice(var_8_4))

	onButton = var_1_10003

	local var_8_5 = arg_8_0
	local var_8_6 = arg_8_1

	local function var_8_7()
		local var_9_0 = arg_8_0

		var_0.OnClick(var_9_0)

		return
	end

	SFX_PANEL = var_8_4

	var_1_10003(var_8_5, var_8_6, var_8_7, var_8_4)

	return
end

function var_0_1.OnClick(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.emit

	IslandTradePage = var_1_10004

	local var_10_2 = var_1_10004.OPEN_CONFIRM_PAGE

	IslandConst = var_1_10005

	var_10_1(var_10_0, var_10_2, var_1_10005.TRADE_PURCHASE)

	return
end

return var_0_1
