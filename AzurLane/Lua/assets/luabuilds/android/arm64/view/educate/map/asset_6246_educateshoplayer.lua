class = var_0_10000

local var_0_0 = "EducateShopLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateShopUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	assert = var_1_10001

	var_1_10001(arg_3_0.contextData.shopId, "打开商店layer需要传入shopId")

	arg_3_0.shopId = arg_3_0.contextData.shopId

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "anim_root")
	local var_4_2 = var_1.GetComponent

	typeof = var_4
	Animation = var_1_10006
	arg_4_0.anim = var_4_2(var_4_1, var_4(var_1_10006))

	local var_4_3 = arg_4_0._tf
	local var_4_4 = var_1.Find(var_4_3, "anim_root")
	local var_4_5 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_1_10006
	arg_4_0.animEvent = var_4_5(var_4_4, var_4(var_1_10006))

	local var_4_6 = arg_4_0.animEvent

	var_1.SetEndEvent(var_4_6, function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_4_7 = arg_4_0._tf

	arg_4_0.windowTF = var_1.Find(var_4_7, "anim_root/window")

	local var_4_8 = arg_4_0.windowTF

	arg_4_0.titleTF = var_1.Find(var_4_8, "title")
	setText = var_1

	local var_4_9 = arg_4_0.titleTF
	local var_4_10 = var_3.Find(var_4_9, "Text")

	i18n = var_4

	var_1(var_4_10, var_4("word_shop"))

	local var_4_11 = arg_4_0.titleTF

	arg_4_0.closeBtn = var_1.Find(var_4_11, "close_btn")

	local var_4_12 = arg_4_0.titleTF

	arg_4_0.discountTF = var_1.Find(var_4_12, "Text/discount")

	local var_4_13 = arg_4_0.discountTF

	arg_4_0.discountValueTF = var_1.Find(var_4_13, "Text")

	local var_4_14 = arg_4_0.windowTF

	arg_4_0.goodContent = var_1.Find(var_4_14, "view/content")
	UIItemList = var_1

	local var_4_15 = var_1.New
	local var_4_16 = arg_4_0.goodContent
	local var_4_17 = arg_4_0.goodContent

	arg_4_0.goodUIList = var_4_15(var_4_16, var_4.Find(var_4_17, "tpl"))
	setText = var_1

	local var_4_18 = arg_4_0.goodContent
	local var_4_19 = var_3.Find(var_4_18, "tpl/sellout/Text")

	i18n = var_4

	var_1(var_4_19, var_4("word_sell_out"))

	local var_4_20 = arg_4_0.windowTF

	arg_4_0.tipTF = var_1.Find(var_4_20, "tip")

	local var_4_21 = arg_4_0.windowTF

	arg_4_0.detailPanelTF = var_1.Find(var_4_21, "detail/content")

	local var_4_22 = arg_4_0.windowTF

	arg_4_0.detailEmptyTF = var_1.Find(var_4_22, "detail/empty")
	setText = var_1

	local var_4_23 = arg_4_0.detailEmptyTF
	local var_4_24 = var_3.Find(var_4_23, "Text")

	i18n = var_4

	var_1(var_4_24, var_4("child_shop_empty_tip"))

	local var_4_25 = arg_4_0.detailPanelTF

	arg_4_0.detailName = var_1.Find(var_4_25, "title/Text")

	local var_4_26 = arg_4_0.detailPanelTF

	arg_4_0.detailDesc = var_1.Find(var_4_26, "desc")

	local var_4_27 = arg_4_0.detailPanelTF

	arg_4_0.detailIcon = var_1.Find(var_4_27, "icon")

	local var_4_28 = arg_4_0.detailPanelTF

	arg_4_0.detailAttrsTF = var_1.Find(var_4_28, "attrs")
	setActive = var_1

	local var_4_29 = arg_4_0.detailPanelTF

	var_1(var_3.Find(var_4_29, "count"), false)

	local var_4_30 = arg_4_0.detailPanelTF

	arg_4_0.countValueTF = var_1.Find(var_4_30, "count/bg/Text")

	local var_4_31 = arg_4_0.detailPanelTF

	arg_4_0.addCountBtn = var_1.Find(var_4_31, "count/add")

	local var_4_32 = arg_4_0.detailPanelTF

	arg_4_0.reduceCountBtn = var_1.Find(var_4_32, "count/reduce")

	local var_4_33 = arg_4_0.detailPanelTF

	arg_4_0.maxCountBtn = var_1.Find(var_4_33, "count/max")

	local var_4_34 = arg_4_0.detailPanelTF

	arg_4_0.priceValue = var_1.Find(var_4_34, "price/value/Text")
	setText = var_1

	local var_4_35 = arg_4_0.detailPanelTF
	local var_4_36 = var_3.Find(var_4_35, "price/title")

	i18n = var_4

	var_1(var_4_36, var_4("child_shop_price_title"))

	local var_4_37 = arg_4_0.detailPanelTF

	arg_4_0.purchaseBtn = var_1.Find(var_4_37, "purchase_btn")
	setText = var_1

	local var_4_38 = arg_4_0.purchaseBtn
	local var_4_39 = var_3.Find(var_4_38, "Text")

	i18n = var_4

	var_1(var_4_39, var_4("word_buy"))

	return
end

function var_0_1.addListener(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_4.Find(var_6_1, "anim_root/bg")

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0._close(var_7_0)

		return
	end

	SFX_PANEL = var_6_1

	var_1_10001(var_6_0, var_6_2, var_6_3, var_6_1)

	onButton = var_1_10001

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.closeBtn

	local function var_6_6()
		local var_8_0 = arg_6_0

		var_0._close(var_8_0)

		return
	end

	SFX_PANEL = var_6_1

	var_1_10001(var_6_4, var_6_5, var_6_6, var_6_1)

	onButton = var_1_10001

	local var_6_7 = arg_6_0
	local var_6_8 = arg_6_0.addCountBtn

	local function var_6_9()
		local var_9_0 = arg_6_0.countValue
		local var_9_1 = arg_6_0

		if var_9_0 >= var_1.GetMaxCount(var_9_1) then
			return
		end

		arg_6_0.countValue = arg_6_0.countValue + 1

		local var_9_2 = arg_6_0

		var_0.updateDetailPrice(var_9_2)

		return
	end

	SFX_PANEL = var_6_1

	var_1_10001(var_6_7, var_6_8, var_6_9, var_6_1)

	onButton = var_1_10001

	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0.reduceCountBtn

	local function var_6_12()
		if arg_6_0.countValue <= 1 then
			return
		end

		arg_6_0.countValue = arg_6_0.countValue - 1

		local var_10_0 = arg_6_0

		var_0.updateDetailPrice(var_10_0)

		return
	end

	SFX_PANEL = var_6_1

	var_1_10001(var_6_10, var_6_11, var_6_12, var_6_1)

	onButton = var_1_10001

	local var_6_13 = arg_6_0
	local var_6_14 = arg_6_0.maxCountBtn

	local function var_6_15()
		local var_11_0 = arg_6_0
		local var_11_1 = var_0.GetMaxCount(var_11_0)

		if arg_6_0.countValue == var_11_1 then
			return
		end

		arg_6_0.countValue = var_11_1

		local var_11_2 = arg_6_0

		var_1.updateDetailPrice(var_11_2)

		return
	end

	SFX_PANEL = var_6_1

	var_1_10001(var_6_13, var_6_14, var_6_15, var_6_1)

	onButton = var_1_10001

	local var_6_16 = arg_6_0
	local var_6_17 = arg_6_0.purchaseBtn

	local function var_6_18()
		local var_12_0 = arg_6_0

		if var_0.GetMaxCount(var_12_0) == 0 then
			pg = var_0

			local var_12_1 = var_0.TipsMgr.GetInstance()
			local var_12_2 = var_0.ShowTips

			i18n = var_2_10003

			var_12_2(var_12_1, var_2_10003("common_no_resource"))

			return
		end

		local var_12_3 = arg_6_0
		local var_12_4 = var_0.emit

		EducateShopMediator = var_2_10003

		var_12_4(var_12_3, var_2_10003.ON_SHOPPING, {
			shopId = arg_6_0.shopId,
			goods = {
				{
					id = arg_6_0.goods[arg_6_0.selectedIndex].id,
					num = arg_6_0.countValue
				}
			}
		})

		return
	end

	SFX_PANEL = var_6_1

	var_1_10001(var_6_16, var_6_17, var_6_18, var_6_1)

	local var_6_19 = arg_6_0.goodUIList

	var_1.make(var_6_19, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = arg_6_0

			var_3.updateGoodItem(var_13_0, arg_13_1, arg_13_2)
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_14_0)
	arg_14_0:OverlayPanel(arg_14_0._tf, {
		groupDelta = 2
	})

	arg_14_0.selectedIndex = 1
	arg_14_0.countValue = 1

	arg_14_0:refreshShops()

	return
end

function var_0_1.updateGoodItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1 + 1
	local var_15_1 = arg_15_0.goods[var_15_0]

	setActive = var_1_10005

	var_1_10005(arg_15_2:Find("discount"), arg_15_0.isDiscount)

	setText = var_1_10005

	var_1_10005(arg_15_2:Find("discount/Text"), "-" .. arg_15_0.discountValue)

	local var_15_2 = var_15_1
	local var_15_3 = var_15_1.GetPrice(var_15_2)

	if arg_15_0.isDiscount then
		local var_15_4 = var_15_1
		local var_15_5

		if not var_15_1.GetPrice(var_15_4, arg_15_0.discountRatio) then
			var_15_5 = var_15_3
		end

		setActive = var_15_2

		var_15_2(arg_15_2:Find("bottom/price/price_original"), arg_15_0.isDiscount)

		setText = var_15_2

		var_15_2(arg_15_2:Find("bottom/price/price_original"), var_15_3)

		setText = var_15_2

		var_15_2(arg_15_2:Find("bottom/price/price_final"), var_15_5)

		local var_15_6 = var_15_1:GetShowInfo()

		EducateHelper = var_15_4

		var_15_4.UpdateDropShow(arg_15_2:Find("item"), var_15_6)

		setActive = var_8

		var_8(arg_15_2:Find("sellout"), not var_15_1:CanBuy())

		setActive = var_8

		var_8(arg_15_2:Find("selected"), var_15_0 == arg_15_0.selectedIndex)

		onButton = var_8

		local var_15_7 = arg_15_0
		local var_15_8 = arg_15_2

		local function var_15_9()
			if var_15_0 == arg_15_0.selectedIndex then
				return
			end

			arg_15_0.selectedIndex = var_15_0

			for iter_16_0 = 0, arg_15_0.goodContent.childCount - 1 do
				local var_16_0 = arg_15_0.goodContent
				local var_16_1 = var_4.GetChild(var_16_0, iter_16_0)

				setActive = var_2_10005

				var_2_10005(var_16_1:Find("selected"), iter_16_0 + 1 == arg_15_0.selectedIndex)
			end

			local var_16_2 = arg_15_0

			var_0.updateDetail(var_16_2)

			return
		end

		SFX_PANEL = var_13

		var_8(var_15_7, var_15_8, var_15_9, var_13)

		return
	end
end

function var_0_1.refreshShops(arg_17_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_17_0 = var_1_10001(var_1_10003)
	local var_17_1 = var_1.GetCurTime(var_17_0)

	getProxy = var_1_10002
	EducateProxy = var_1_10004

	local var_17_2 = var_1_10002(var_1_10004)

	arg_17_0.shopProxy = var_2.GetShopProxy(var_17_2)

	local var_17_3 = arg_17_0.shopProxy

	arg_17_0.shop = var_2.GetShopWithId(var_17_3, arg_17_0.shopId)

	local var_17_4 = arg_17_0.shop

	arg_17_0.goods = var_2.GetGoods(var_17_4, var_17_1)
	getProxy = var_2
	EducateProxy = var_17_4

	local var_17_5 = var_2(var_17_4)

	arg_17_0.char = var_2.GetCharData(var_17_5)

	local var_17_6 = arg_17_0.shopProxy

	arg_17_0.isDiscount = var_2.IsDiscountById(var_17_6, arg_17_0.shopId)

	local var_17_7 = arg_17_0.shopProxy

	arg_17_0.discountRatio = var_2.GetDiscountById(var_17_7, arg_17_0.shopId)

	local var_17_8

	if not arg_17_0.isDiscount or not (arg_17_0.discountRatio / 100 .. "%") then
		var_17_8 = ""
	end

	arg_17_0.discountValue = var_17_8
	setActive = var_17_8

	var_17_8(arg_17_0.discountTF, arg_17_0.isDiscount)

	setText = var_17_8

	var_17_8(arg_17_0.discountValueTF, arg_17_0.discountValue)

	setText = var_17_8

	local var_17_9 = arg_17_0.tipTF
	local var_17_10 = arg_17_0.shop

	var_17_8(var_17_9, var_5.GetShopTip(var_17_10))

	local var_17_11 = arg_17_0.goodUIList

	var_2.align(var_17_11, #arg_17_0.goods)

	underscore = var_2

	local var_17_12 = var_2.detect(arg_17_0.goods, function(arg_18_0)
		return arg_18_0:GetRemainCnt() > 0
	end)

	setActive = var_17_0

	var_17_0(arg_17_0.detailEmptyTF, not var_17_12)

	setActive = var_17_0

	var_17_0(arg_17_0.detailPanelTF, var_17_12)

	if var_17_12 then
		arg_17_0:updateDetail()
	end

	return
end

function var_0_1.updateDetail(arg_19_0)
	arg_19_0.countValue = 1

	local var_19_0 = arg_19_0.goods[arg_19_0.selectedIndex]
	local var_19_1 = var_1.GetShowInfo(var_19_0)

	pg = var_1_10003

	local var_19_2 = var_1_10003.child_item[var_19_1.id]

	setText = var_4

	var_4(arg_19_0.detailName, var_19_2.name)

	setText = var_4

	var_4(arg_19_0.detailDesc, var_19_2.desc)

	setText = var_4

	var_4(arg_19_0.countValueTF, arg_19_0.countValue)

	LoadImageSpriteAsync = var_4

	var_4("educateprops/" .. var_19_2.icon, arg_19_0.detailIcon)

	EducateHelper = var_4

	local var_19_3 = var_4.GetItemAddDrops(var_19_1)

	arg_19_0:updateDetailAttrs(var_19_3)
	arg_19_0:updateDetailPrice()

	return
end

function var_0_1.updateDetailAttrs(arg_20_0, arg_20_1)
	local var_20_0

	var_20_0 = #arg_20_1 > 2 and 2 or #arg_20_1

	for iter_20_0 = 1, arg_20_0.detailAttrsTF.childCount do
		local var_20_1 = arg_20_1[iter_20_0]
		local var_20_2 = arg_20_0.detailAttrsTF
		local var_20_3 = var_8.GetChild(var_20_2, iter_20_0 - 1)

		if var_20_1 then
			setActive = var_1_10009

			var_1_10009(var_20_3, true)

			EducateHelper = var_1_10009

			var_1_10009.UpdateDropShowForAttr(var_20_3, var_20_1)
		else
			setActive = var_1_10009

			var_1_10009(var_20_3, false)
		end
	end

	return
end

function var_0_1.updateDetailPrice(arg_21_0)
	setText = var_1_10001

	var_1_10001(arg_21_0.countValueTF, arg_21_0.countValue)

	local var_21_0 = arg_21_0.goods[arg_21_0.selectedIndex]
	local var_21_1 = var_1.GetCost(var_21_0, arg_21_0.discountRatio)

	setText = var_2

	var_2(arg_21_0.priceValue, var_21_1.num * arg_21_0.countValue)

	setGray = var_2

	var_2(arg_21_0.purchaseBtn, arg_21_0:GetMaxCount() == 0, true)

	return
end

function var_0_1.GetMaxCount(arg_22_0)
	local var_22_0 = arg_22_0.goods[arg_22_0.selectedIndex]
	local var_22_1 = var_1.GetRemainCnt(var_22_0)
	local var_22_2 = var_1
	local var_22_3 = var_1.GetCost(var_22_2, arg_22_0.discountRatio)

	math = var_22_0

	local var_22_4 = var_22_0.floor
	local var_22_5 = arg_22_0.char
	local var_22_6 = var_22_4(var_6.GetResById(var_22_5, var_22_3.id) / var_22_3.num)

	math = var_22_2

	return var_22_2.min(var_22_1, var_22_6)
end

function var_0_1._close(arg_23_0)
	local var_23_0 = arg_23_0.anim

	var_1.Play(var_23_0, "anim_educate_shop_out")

	return
end

function var_0_1.onBackPressed(arg_24_0)
	arg_24_0:_close()

	return
end

function var_0_1.willExit(arg_25_0)
	local var_25_0 = arg_25_0.animEvent

	var_1.SetEndEvent(var_25_0, nil)
	arg_25_0:UnOverlayPanel(arg_25_0._tf)

	return
end

return var_0_1
