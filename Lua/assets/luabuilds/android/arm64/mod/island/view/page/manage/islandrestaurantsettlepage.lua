local var_0_0 = class("IslandRestaurantSettlePage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandRestaurantSettleUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.titleTF = arg_2_0._tf:Find("title/name/Text")

	local var_2_0 = arg_2_0._tf:Find("window/sale")

	setText(var_2_0:Find("title"), i18n("island_manage_sale_daily"))

	arg_2_0.switchToggle = var_2_0:Find("switch")

	setText(arg_2_0.switchToggle:Find("on/Text"), i18n("island_manage_fake_price"))
	setText(arg_2_0.switchToggle:Find("off/Text"), i18n("island_manage_real_price"))

	arg_2_0.saleUIList = UIItemList.New(var_2_0:Find("content"), var_2_0:Find("content/tpl"))

	local var_2_1 = arg_2_0._tf:Find("window/remain")

	setText(var_2_1:Find("title"), i18n("island_manage_result_1"))

	arg_2_0.remainUIList = UIItemList.New(var_2_1:Find("content"), var_2_1:Find("content/tpl"))

	local var_2_2 = arg_2_0._tf:Find("window/summary")

	setText(var_2_2:Find("title/Text"), i18n("island_manage_result_3"))

	arg_2_0.countTF = var_2_2:Find("count/info/value")

	setText(var_2_2:Find("count/info/name"), i18n("island_manage_word_cnt"))

	arg_2_0.priceTF = var_2_2:Find("price/info/value")

	setText(var_2_2:Find("price/info/name"), i18n("island_manage_saleroom"))

	arg_2_0.expSliderTF = var_2_2:Find("exp/info/slider")
	arg_2_0.expProgressTF = var_2_2:Find("exp/info/slider/progress")

	setText(var_2_2:Find("exp/info/name"), i18n("island_manage_shop_exp"))
	setText(arg_2_0._tf:Find("tip"), i18n("child_close_tip"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("mask"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onToggle(arg_3_0, arg_3_0.switchToggle, function(arg_5_0)
		arg_3_0.saleUIList:eachActive(function(arg_6_0, arg_6_1)
			setActive(arg_6_1:Find("price"), arg_5_0)

			return
		end)

		return
	end, SFX_PANEL)
	arg_3_0.saleUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateCommonItem(arg_7_2, arg_3_0.saleList[arg_7_1 + 1])
			setText(arg_7_2:Find("price/Text"), arg_3_0.saleList[arg_7_1 + 1].price)
		end

		return
	end)
	arg_3_0.remainUIList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateCommonItem(arg_8_2, arg_3_0.remainList[arg_8_1 + 1])
		end

		return
	end)

	arg_3_0.maxAttrEffect = pg.island_chara_att[1].manage_effect / 16

	return
end

function var_0_0.OnShow(arg_9_0, arg_9_1, arg_9_2)
	local var_9_9000

	arg_9_0:BlurPanel()

	arg_9_0.callback = arg_9_2
	arg_9_0.restId = arg_9_1.restId
	arg_9_0.shipCnt = arg_9_1.oldShipCnt
	arg_9_0.ships = {}

	local var_9_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.shipIds) do
		table.insert(arg_9_0.ships, var_9_0:GetShipById(iter_9_1))
	end

	setText(arg_9_0.titleTF, pg.island_manage_restaurant[arg_9_0.restId].name)

	arg_9_0.saleList = arg_9_1.saleList

	arg_9_0.saleUIList:align(#arg_9_0.saleList)

	arg_9_0.remainList = arg_9_1.remainList

	arg_9_0.remainUIList:align(#arg_9_0.remainList)

	arg_9_0.totalCnt, arg_9_0.totalPrice = 0, 0

	for iter_9_2, iter_9_3 in ipairs(arg_9_0.saleList) do
		arg_9_0.totalCnt = arg_9_0.totalCnt + iter_9_3.num
		arg_9_0.totalPrice = arg_9_0.totalPrice + iter_9_3.price
	end

	setText(arg_9_0.countTF, arg_9_0.totalCnt)
	setText(arg_9_0.priceTF, arg_9_0.totalPrice)

	local var_9_1 = getProxy(IslandProxy):GetIsland():GetManageAgency()
	local var_9_2 = var_9_1.GetRestaurant(var_9_9000, arg_9_0.restId)
	local var_9_3 = var_9_2:GetSales()
	local var_9_4 = var_9_2:GetCanUpgradeExp()

	setSlider(arg_9_0.expSliderTF, 0, 1, var_9_1 == 0 and 0 or var_9_3 / var_9_4)
	setText(arg_9_0.expProgressTF, var_9_3 .. "/" .. var_9_4)
	triggerToggle(arg_9_0.switchToggle, false)

	return
end

function var_0_0.UpdateCommonItem(arg_10_0, arg_10_1, arg_10_2)
	LoadImageSpriteAsync("island/" .. pg.island_item_data_template[arg_10_2.id].icon, arg_10_1:Find("bg/icon"))
	setText(arg_10_1:Find("count/Text"), arg_10_2.num)
	setFillAmount(arg_10_1:Find("bg/silder/bar"), (arg_10_0:GetAttrsFactorsRatio(arg_10_2.id)))

	return
end

function var_0_0.OnHide(arg_11_0)
	arg_11_0:UnBlurPanel()
	existCall(arg_11_0.callback)

	arg_11_0.callback = nil

	return
end

function var_0_0.GetAttrsFactorsRatio(arg_12_0, arg_12_1)
	local var_12_0 = IslandRestaurantPage.CaclShipAttrFactors(arg_12_0.ships, IslandShipAttr.MANAGE_KEY) + IslandRestaurantPage.CaclShipAttrFactors(arg_12_0.ships, pg.island_item_data_template[arg_12_1].sub_attribute[1]) * (pg.island_item_data_template[arg_12_1].sub_attribute[2] / 100)
	local var_12_1 = arg_12_0.shipCnt * (arg_12_0.maxAttrEffect + arg_12_0.maxAttrEffect * (pg.island_item_data_template[arg_12_1].sub_attribute[2] / 100))

	return arg_12_0.shipCnt * (arg_12_0.maxAttrEffect + arg_12_0.maxAttrEffect * (pg.island_item_data_template[arg_12_1].sub_attribute[2] / 100)) == 0 and 0 or var_12_0 / var_12_1
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0:UnBlurPanel()

	return
end

return var_0_0
