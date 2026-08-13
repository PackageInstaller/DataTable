class = var_0_10000

local var_0_0 = "NewServerShopPurchasePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".GuildShopPurchasePanel"))

function var_0_1.Show(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:GetConsume()
	local var_1_1 = {
		id = arg_1_1.id,
		count = arg_1_1:GetCanPurchaseCnt(),
		type = arg_1_1:GetDropType(),
		price = var_1_0.count,
		displays = arg_1_1:GetSelectableGoods()
	}

	arg_1_0.commodity = arg_1_1

	var_0_1.super.Show(arg_1_0, var_1_1)

	arg_1_0.limitOnePurchase = arg_1_1:LimitPurchaseSubGoods()

	local var_1_2 = arg_1_0.descTxt

	if arg_1_0.limitOnePurchase then
		i18n = var_5

		local var_1_3

		if not var_5("new_server_shop_sel_goods_tip") then
			var_1_3 = ""
		end

		var_1_2.text = var_1_3
		GetImageSpriteFromAtlasAsync = var_1_2

		var_1_2(var_1_0:getConfig("icon"), "", arg_1_0.resIcon)

		return
	end
end

function var_0_1.UpdateItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.UpdateItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	local var_2_0 = arg_2_3
	local var_2_1

	var_2_1, setActive = arg_2_3.Find(var_2_0, "mask"), var_2_0

	local var_2_2 = arg_2_0.commodity

	var_2_0(var_2_1, not var_7.CanPurchaseSubGoods(var_2_2, arg_2_2))

	return
end

function var_0_1.ClickItem(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.limitOnePurchase then
		local var_3_0 = arg_3_0.commodity

		if not var_3.CanPurchaseSubGoods(var_3_0, arg_3_2) then
			return
		end
	end

	var_0_1.super.ClickItem(arg_3_0, arg_3_1, arg_3_2)

	return
end

function var_0_1.PressAddBtn(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.limitOnePurchase then
		table = var_3

		if var_3.contains(arg_4_0.selectedList, arg_4_2) then
			return
		end
	end

	var_0_1.super.PressAddBtn(arg_4_0, arg_4_1, arg_4_2)

	return
end

function var_0_1.OnConfirm(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.m02
	local var_5_1 = var_1.sendNotification

	GAME = var_1_10003

	var_5_1(var_5_0, var_1_10003.NEW_SERVER_SHOP_SHOPPING, {
		id = arg_5_0.commodity.id,
		selectedList = arg_5_0.selectedList
	})

	return
end

return var_0_1
