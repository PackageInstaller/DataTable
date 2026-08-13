class = var_0_10000

local var_0_0 = "MetaShopPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ActivitySelectableShopPage"))

function var_0_1.ResId2ItemId(arg_1_0, arg_1_1)
	return arg_1_1
end

function var_0_1.SetResIcon(arg_2_0)
	local var_2_0 = var_0_1.super.SetResIcon
	local var_2_1 = arg_2_0

	DROP_TYPE_ITEM = var_1_10003

	var_2_0(var_2_1, var_1_10003)

	return
end

function var_0_1.UpdateTip(arg_3_0)
	local var_3_0 = arg_3_0.tipText

	i18n = var_1_10002
	var_3_0.text = var_1_10002("meta_shop_tip")

	return
end

function var_0_1.SetPurchaseConfirmCb(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.purchaseWindow

	var_2.ExecuteAction(var_4_0, "SetConfirmCb", function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_4_0
		local var_5_1 = var_3.emit

		NewShopMainMediator = var_2_10005

		var_5_1(var_5_0, var_2_10005.ON_META_SHOP, arg_4_0.shop.activityId, 1, arg_5_0, arg_5_2, arg_5_1)

		return
	end)

	local var_4_1 = arg_4_0.purchaseWindow

	var_2.ExecuteAction(var_4_1, "Hide")

	return
end

function var_0_1.OnUpdatePlayer(arg_6_0)
	return
end

function var_0_1.OnUpdateItems(arg_7_0)
	arg_7_0:RefreshResItemList()

	return
end

function var_0_1.GetResDataList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = arg_8_0.shop
	local var_8_2 = var_2.GetResList(var_8_1)

	ipairs = var_8_1

	for iter_8_0, iter_8_1 in var_8_1(var_8_2) do
		local var_8_3

		if not arg_8_0.items[iter_8_1] then
			Item = var_8_3
			var_8_3 = var_8_3.New({
				count = 0,
				id = iter_8_1
			})
		end

		local var_8_4 = var_8_3.count

		table = var_1_10010
		var_1_10010 = var_1_10010.insert

		local var_8_5 = var_8_0
		local var_8_6 = {}

		DROP_TYPE_ITEM = var_1_10013
		var_8_6.type = var_1_10013
		var_8_6.resID = iter_8_1
		var_8_6.cnt = var_8_4

		var_1_10010(var_8_5, var_8_6)
	end

	return var_8_0
end

function var_0_1.RefreshUI(arg_9_0)
	arg_9_0:UpdateTip()

	setActive = var_1

	var_1(arg_9_0.tipTextGo, true)

	setActive = var_1

	var_1(arg_9_0.helpBtn, false)

	setActive = var_1

	var_1(arg_9_0.resolveBtn, false)

	setActive = var_1

	var_1(arg_9_0.refreshBtn, false)

	return
end

function var_0_1.OnPurchase(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.shop.activityId
	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.emit

	NewShopMainMediator = var_1_10006

	var_10_2(var_10_1, var_1_10006.ON_META_SHOP, var_10_0, 1, arg_10_1.id, arg_10_2, {
		{
			key = arg_10_1:getConfig("commodity_id"),
			value = arg_10_2
		}
	})

	return
end

function var_0_1.GetPaintingName(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = var_0_1.super.GetPaintingName(arg_11_0)
	local var_11_3

	type = var_1_10005

	if var_1_10005(var_11_0) == "table" then
		math = var_5
		var_11_3 = var_11_0[var_5.random(1, #var_11_0)]
	else
		var_11_3 = var_11_0
	end

	return var_11_3, var_11_1, var_11_2
end

return var_0_1
