local var_0_0 = class("NewServerShopPurchasePanel", import(".GuildShopPurchasePanel"))

function var_0_0.Show(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:GetConsume()

	arg_1_0.commodity = arg_1_1

	var_0_0.super.Show(arg_1_0, {
		id = arg_1_1.id,
		count = arg_1_1:GetCanPurchaseCnt(),
		type = arg_1_1:GetDropType(),
		price = var_1_0.count,
		displays = arg_1_1:GetSelectableGoods()
	})

	arg_1_0.limitOnePurchase = arg_1_1:LimitPurchaseSubGoods()

	local var_1_1 = arg_1_0.descTxt

	var_1_1.text = arg_1_0.limitOnePurchase and i18n("new_server_shop_sel_goods_tip") or ""

	GetImageSpriteFromAtlasAsync(var_1_0:getConfig("icon"), "", arg_1_0.resIcon)

	return
end

function var_0_0.UpdateItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.UpdateItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setActive(arg_2_3:Find("mask"), not arg_2_0.commodity:CanPurchaseSubGoods(arg_2_2))

	return
end

function var_0_0.ClickItem(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.limitOnePurchase and not arg_3_0.commodity:CanPurchaseSubGoods(arg_3_2) then
		return
	end

	var_0_0.super.ClickItem(arg_3_0, arg_3_1, arg_3_2)

	return
end

function var_0_0.PressAddBtn(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.limitOnePurchase and table.contains(arg_4_0.selectedList, arg_4_2) then
		return
	end

	var_0_0.super.PressAddBtn(arg_4_0, arg_4_1, arg_4_2)

	return
end

function var_0_0.OnConfirm(arg_5_0)
	pg.m02:sendNotification(GAME.NEW_SERVER_SHOP_SHOPPING, {
		id = arg_5_0.commodity.id,
		selectedList = arg_5_0.selectedList
	})

	return
end

return var_0_0
