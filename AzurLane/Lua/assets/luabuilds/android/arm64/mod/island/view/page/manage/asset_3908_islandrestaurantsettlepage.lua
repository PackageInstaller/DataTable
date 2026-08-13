class = var_0_10000

local var_0_0 = "IslandRestaurantSettlePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandRestaurantSettleUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.titleTF = var_1.Find(var_2_0, "title/name/Text")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "window/sale")

	setText = var_1_10002

	local var_2_3 = var_2_2:Find("title")

	i18n = var_1_10005

	var_1_10002(var_2_3, var_1_10005("island_manage_sale_daily"))

	arg_2_0.switchToggle = var_2_2:Find("switch")
	setText = var_2

	local var_2_4 = arg_2_0.switchToggle
	local var_2_5 = var_4.Find(var_2_4, "on/Text")

	i18n = var_5

	var_2(var_2_5, var_5("island_manage_fake_price"))

	setText = var_2

	local var_2_6 = arg_2_0.switchToggle
	local var_2_7 = var_4.Find(var_2_6, "off/Text")

	i18n = var_5

	var_2(var_2_7, var_5("island_manage_real_price"))

	UIItemList = var_2

	local var_2_8 = var_2.New
	local var_2_9 = var_2_2

	arg_2_0.saleUIList = var_2_8(var_2_2.Find(var_2_9, "content"), var_2_2:Find("content/tpl"))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "window/remain")

	setText = var_2_1

	local var_2_12 = var_2_11:Find("title")

	i18n = var_2_9

	var_2_1(var_2_12, var_2_9("island_manage_result_1"))

	UIItemList = var_2_1

	local var_2_13 = var_2_1.New
	local var_2_14 = var_2_11

	arg_2_0.remainUIList = var_2_13(var_2_11.Find(var_2_14, "content"), var_2_11:Find("content/tpl"))

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_3.Find(var_2_15, "window/summary")

	setText = var_2_10

	local var_2_17 = var_2_16:Find("title/Text")

	i18n = var_2_14

	var_2_10(var_2_17, var_2_14("island_manage_result_3"))

	arg_2_0.countTF = var_2_16:Find("count/info/value")
	setText = var_4

	local var_2_18 = var_2_16:Find("count/info/name")

	i18n = var_7

	var_4(var_2_18, var_7("island_manage_word_cnt"))

	arg_2_0.priceTF = var_2_16:Find("price/info/value")
	setText = var_4

	local var_2_19 = var_2_16:Find("price/info/name")

	i18n = var_7

	var_4(var_2_19, var_7("island_manage_saleroom"))

	arg_2_0.expSliderTF = var_2_16:Find("exp/info/slider")
	arg_2_0.expProgressTF = var_2_16:Find("exp/info/slider/progress")
	setText = var_4

	local var_2_20 = var_2_16:Find("exp/info/name")

	i18n = var_7

	var_4(var_2_20, var_7("island_manage_shop_exp"))

	setText = var_4

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_6.Find(var_2_21, "tip")

	i18n = var_7

	var_4(var_2_22, var_7("child_close_tip"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "mask")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onToggle = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.switchToggle

	local function var_3_6(arg_5_0)
		local var_5_0 = arg_3_0.saleUIList

		var_1.eachActive(var_5_0, function(arg_6_0, arg_6_1)
			setActive = var_3_10002

			var_3_10002(arg_6_1:Find("price"), arg_5_0)

			return
		end)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_4, var_3_5, var_3_6, var_3_1)

	local var_3_7 = arg_3_0.saleUIList

	var_1.make(var_3_7, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_3_0.saleList[arg_7_1 + 1]
			local var_7_1 = arg_3_0

			var_4.UpdateCommonItem(var_7_1, arg_7_2, var_7_0)

			setText = var_4

			var_4(arg_7_2:Find("price/Text"), var_7_0.price)
		end

		return
	end)

	local var_3_8 = arg_3_0.remainUIList

	var_1.make(var_3_8, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventUpdate then
			local var_8_0 = arg_3_0.remainList[arg_8_1 + 1]
			local var_8_1 = arg_3_0

			var_4.UpdateCommonItem(var_8_1, arg_8_2, var_8_0)
		end

		return
	end)

	pg = var_1
	arg_3_0.maxAttrEffect = var_1.island_chara_att[1].manage_effect / 16

	return
end

function var_0_1.OnShow(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0

	arg_9_0.BlurPanel(var_9_0)

	arg_9_0.callback = arg_9_2
	arg_9_0.restId = arg_9_1.restId
	arg_9_0.shipCnt = arg_9_1.oldShipCnt
	arg_9_0.ships = {}
	getProxy = var_3
	IslandProxy = var_9_0

	local var_9_1 = var_3(var_9_0)
	local var_9_2 = var_3.GetIsland(var_9_1)
	local var_9_3 = var_3.GetCharacterAgency(var_9_2)

	ipairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(arg_9_1.shipIds) do
		table = var_1_10009

		var_1_10009.insert(arg_9_0.ships, var_9_3:GetShipById(iter_9_1))
	end

	setText = var_4

	local var_9_4 = arg_9_0.titleTF

	pg = iter_9_0

	var_4(var_9_4, iter_9_0.island_manage_restaurant[arg_9_0.restId].name)

	arg_9_0.saleList = arg_9_1.saleList

	local var_9_5 = arg_9_0.saleUIList

	var_4.align(var_9_5, #arg_9_0.saleList)

	arg_9_0.remainList = arg_9_1.remainList

	local var_9_6 = arg_9_0.remainUIList

	var_4.align(var_9_6, #arg_9_0.remainList)

	local var_9_7 = 0

	arg_9_0.totalPrice = 0
	arg_9_0.totalCnt = var_9_7
	ipairs = var_9_7

	for iter_9_2, iter_9_3 in var_9_7(arg_9_0.saleList) do
		arg_9_0.totalCnt = arg_9_0.totalCnt + iter_9_3.num
		arg_9_0.totalPrice = arg_9_0.totalPrice + iter_9_3.price
	end

	setText = var_4

	var_4(arg_9_0.countTF, arg_9_0.totalCnt)

	setText = var_4

	var_4(arg_9_0.priceTF, arg_9_0.totalPrice)

	getProxy = var_4
	IslandProxy = var_6

	local var_9_8 = var_4(var_6)
	local var_9_9 = var_4.GetIsland(var_9_8)
	local var_9_10 = var_4.GetManageAgency(var_9_9)
	local var_9_11 = var_4.GetRestaurant(var_9_10, arg_9_0.restId)
	local var_9_12 = var_4.GetSales(var_9_11)
	local var_9_13 = var_4:GetCanUpgradeExp()

	setSlider = var_9_11

	var_9_11(arg_9_0.expSliderTF, 0, 1, var_9_13 == 0 and 0 or var_9_12 / var_9_13)

	setText = var_9_11

	var_9_11(arg_9_0.expProgressTF, var_9_12 .. "/" .. var_9_13)

	triggerToggle = var_9_11

	var_9_11(arg_9_0.switchToggle, false)

	return
end

function var_0_1.UpdateCommonItem(arg_10_0, arg_10_1, arg_10_2)
	pg = var_1_10003

	local var_10_0 = var_1_10003.island_item_data_template[arg_10_2.id].icon

	LoadImageSpriteAsync = var_4

	var_4("island/" .. var_10_0, arg_10_1:Find("bg/icon"))

	setText = var_4

	var_4(arg_10_1:Find("count/Text"), arg_10_2.num)

	local var_10_1 = arg_10_0:GetAttrsFactorsRatio(arg_10_2.id)

	setFillAmount = var_1_10005

	var_1_10005(arg_10_1:Find("bg/silder/bar"), var_10_1)

	return
end

function var_0_1.OnHide(arg_11_0)
	arg_11_0:UnBlurPanel()

	existCall = var_1

	var_1(arg_11_0.callback)

	arg_11_0.callback = nil

	return
end

function var_0_1.GetAttrsFactorsRatio(arg_12_0, arg_12_1)
	pg = var_1_10002

	local var_12_0 = var_1_10002.island_item_data_template[arg_12_1].sub_attribute[2] / 100

	IslandRestaurantPage = var_1_10004

	local var_12_1 = var_1_10004.CaclShipAttrFactors
	local var_12_2 = arg_12_0.ships

	IslandShipAttr = var_1_10007

	local var_12_3 = var_12_1(var_12_2, var_1_10007.MANAGE_KEY)

	IslandRestaurantPage = var_1_10005

	local var_12_4 = var_12_3 + var_1_10005.CaclShipAttrFactors(arg_12_0.ships, var_2[1]) * var_12_0

	return arg_12_0.shipCnt * (arg_12_0.maxAttrEffect + arg_12_0.maxAttrEffect * var_12_0) == 0 and 0 or var_12_4 / var_7
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0:UnBlurPanel()

	return
end

return var_0_1
