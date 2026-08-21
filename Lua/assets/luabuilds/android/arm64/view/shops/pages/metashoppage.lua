local var_0_0 = class("MetaShopPage", import(".ActivitySelectableShopPage"))

function var_0_0.ResId2ItemId(arg_1_0, arg_1_1)
	return arg_1_1
end

function var_0_0.SetResIcon(arg_2_0)
	var_0_0.super.SetResIcon(arg_2_0, DROP_TYPE_ITEM)

	return
end

function var_0_0.UpdateTip(arg_3_0)
	arg_3_0.tipText.text = i18n("meta_shop_tip")

	return
end

function var_0_0.SetPurchaseConfirmCb(arg_4_0, arg_4_1)
	arg_4_0.purchaseWindow:ExecuteAction("SetConfirmCb", function(arg_5_0, arg_5_1, arg_5_2)
		arg_4_0:emit(NewShopMainMediator.ON_META_SHOP, arg_4_0.shop.activityId, 1, arg_5_0, arg_5_2, arg_5_1)

		return
	end)
	arg_4_0.purchaseWindow:ExecuteAction("Hide")

	return
end

function var_0_0.OnUpdatePlayer(arg_6_0)
	return
end

function var_0_0.OnUpdateItems(arg_7_0)
	arg_7_0:RefreshResItemList()

	return
end

function var_0_0.GetResDataList(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs((arg_8_0.shop:GetResList())) do
		local var_8_0 = arg_8_0.items[iter_8_1]
		local var_8_1

		if not arg_8_0.items[iter_8_1] then
			var_8_0 = Item.New({
				count = 0,
				id = iter_8_1
			})
			var_8_1 = {}
		end

		;({
			type = DROP_TYPE_ITEM,
			resID = iter_8_1
		}).cnt = var_8_0.count

		table.insert({}, {
			type = DROP_TYPE_ITEM,
			resID = iter_8_1
		})
	end

	return {}
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:UpdateTip()
	setActive(arg_9_0.tipTextGo, true)
	setActive(arg_9_0.helpBtn, false)
	setActive(arg_9_0.resolveBtn, false)
	setActive(arg_9_0.refreshBtn, false)

	return
end

function var_0_0.OnPurchase(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:emit(NewShopMainMediator.ON_META_SHOP, arg_10_0.shop.activityId, 1, arg_10_1.id, arg_10_2, {
		{
			key = arg_10_1:getConfig("commodity_id"),
			value = arg_10_2
		}
	})

	return
end

function var_0_0.GetPaintingName(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = var_0_0.super.GetPaintingName(arg_11_0)
	local var_11_3 = type(var_11_0) == "table" and var_11_0[math.random(1, #var_11_0)] or var_11_0

	return var_11_3, var_11_1, var_11_2
end

return var_0_0
