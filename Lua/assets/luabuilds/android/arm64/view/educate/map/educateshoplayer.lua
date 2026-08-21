local var_0_0 = class("EducateShopLayer", import("..base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateShopUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	assert(arg_3_0.contextData.shopId, "打开商店layer需要传入shopId")

	arg_3_0.shopId = arg_3_0.contextData.shopId

	return
end

function var_0_0.findUI(arg_4_0)
	arg_4_0.anim = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_4_0.animEvent = arg_4_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_4_0.animEvent:SetEndEvent(function()
		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end)

	arg_4_0.windowTF = arg_4_0._tf:Find("anim_root/window")
	arg_4_0.titleTF = arg_4_0.windowTF:Find("title")

	setText(arg_4_0.titleTF:Find("Text"), i18n("word_shop"))

	arg_4_0.closeBtn = arg_4_0.titleTF:Find("close_btn")
	arg_4_0.discountTF = arg_4_0.titleTF:Find("Text/discount")
	arg_4_0.discountValueTF = arg_4_0.discountTF:Find("Text")
	arg_4_0.goodContent = arg_4_0.windowTF:Find("view/content")
	arg_4_0.goodUIList = UIItemList.New(arg_4_0.goodContent, arg_4_0.goodContent:Find("tpl"))

	setText(arg_4_0.goodContent:Find("tpl/sellout/Text"), i18n("word_sell_out"))

	arg_4_0.tipTF = arg_4_0.windowTF:Find("tip")
	arg_4_0.detailPanelTF = arg_4_0.windowTF:Find("detail/content")
	arg_4_0.detailEmptyTF = arg_4_0.windowTF:Find("detail/empty")

	setText(arg_4_0.detailEmptyTF:Find("Text"), i18n("child_shop_empty_tip"))

	arg_4_0.detailName = arg_4_0.detailPanelTF:Find("title/Text")
	arg_4_0.detailDesc = arg_4_0.detailPanelTF:Find("desc")
	arg_4_0.detailIcon = arg_4_0.detailPanelTF:Find("icon")
	arg_4_0.detailAttrsTF = arg_4_0.detailPanelTF:Find("attrs")

	setActive(arg_4_0.detailPanelTF:Find("count"), false)

	arg_4_0.countValueTF = arg_4_0.detailPanelTF:Find("count/bg/Text")
	arg_4_0.addCountBtn = arg_4_0.detailPanelTF:Find("count/add")
	arg_4_0.reduceCountBtn = arg_4_0.detailPanelTF:Find("count/reduce")
	arg_4_0.maxCountBtn = arg_4_0.detailPanelTF:Find("count/max")
	arg_4_0.priceValue = arg_4_0.detailPanelTF:Find("price/value/Text")

	setText(arg_4_0.detailPanelTF:Find("price/title"), i18n("child_shop_price_title"))

	arg_4_0.purchaseBtn = arg_4_0.detailPanelTF:Find("purchase_btn")

	setText(arg_4_0.purchaseBtn:Find("Text"), i18n("word_buy"))

	return
end

function var_0_0.addListener(arg_6_0)
	onButton(arg_6_0, arg_6_0._tf:Find("anim_root/bg"), function()
		arg_6_0:_close()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.closeBtn, function()
		arg_6_0:_close()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.addCountBtn, function()
		if arg_6_0.countValue >= arg_6_0:GetMaxCount() then
			return
		end

		arg_6_0.countValue = arg_6_0.countValue + 1

		arg_6_0:updateDetailPrice()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.reduceCountBtn, function()
		if arg_6_0.countValue <= 1 then
			return
		end

		arg_6_0.countValue = arg_6_0.countValue - 1

		arg_6_0:updateDetailPrice()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.maxCountBtn, function()
		local var_11_0 = arg_6_0:GetMaxCount()

		if arg_6_0.countValue == var_11_0 then
			return
		end

		arg_6_0.countValue = var_11_0

		arg_6_0:updateDetailPrice()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.purchaseBtn, function()
		if arg_6_0:GetMaxCount() == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

			return
		end

		arg_6_0:emit(EducateShopMediator.ON_SHOPPING, {
			shopId = arg_6_0.shopId,
			goods = {
				{
					id = arg_6_0.goods[arg_6_0.selectedIndex].id,
					num = arg_6_0.countValue
				}
			}
		})

		return
	end, SFX_PANEL)
	arg_6_0.goodUIList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			arg_6_0:updateGoodItem(arg_13_1, arg_13_2)
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_14_0)
	arg_14_0:OverlayPanel(arg_14_0._tf, {
		groupDelta = 2
	})

	arg_14_0.selectedIndex = 1
	arg_14_0.countValue = 1

	arg_14_0:refreshShops()

	return
end

function var_0_0.updateGoodItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1 + 1

	setActive(arg_15_2:Find("discount"), arg_15_0.isDiscount)
	setText(arg_15_2:Find("discount/Text"), "-" .. arg_15_0.discountValue)

	local var_15_2 = var_15_1:GetPrice()
	local var_15_3 = arg_15_0.isDiscount and var_15_1:GetPrice(arg_15_0.discountRatio) or var_15_2

	setActive(arg_15_2:Find("bottom/price/price_original"), arg_15_0.isDiscount)
	setText(arg_15_2:Find("bottom/price/price_original"), var_15_2)
	setText(arg_15_2:Find("bottom/price/price_final"), var_15_3)
	EducateHelper.UpdateDropShow(arg_15_2:Find("item"), (var_15_1:GetShowInfo()))
	setActive(arg_15_2:Find("sellout"), not var_15_1:CanBuy())
	setActive(arg_15_2:Find("selected"), arg_15_1 + 1 == arg_15_0.selectedIndex)
	onButton(arg_15_0, arg_15_2, function()
		if var_15_0 == arg_15_0.selectedIndex then
			return
		end

		arg_15_0.selectedIndex = var_15_0

		for iter_16_0 = 0, arg_15_0.goodContent.childCount - 1 do
			local var_16_0 = arg_15_0.goodContent:GetChild(iter_16_0)

			setActive(var_16_0:Find("selected"), iter_16_0 + 1 == arg_15_0.selectedIndex)
		end

		arg_15_0:updateDetail()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.refreshShops(arg_17_0)
	arg_17_0.shopProxy = getProxy(EducateProxy):GetShopProxy()
	arg_17_0.shop = arg_17_0.shopProxy:GetShopWithId(arg_17_0.shopId)
	arg_17_0.goods = arg_17_0.shop:GetGoods((getProxy(EducateProxy):GetCurTime()))
	arg_17_0.char = getProxy(EducateProxy):GetCharData()
	arg_17_0.isDiscount = arg_17_0.shopProxy:IsDiscountById(arg_17_0.shopId)
	arg_17_0.discountRatio = arg_17_0.shopProxy:GetDiscountById(arg_17_0.shopId)

	if arg_17_0.isDiscount then
		arg_17_0.discountValue = arg_17_0.discountRatio / 100 .. "%" or ""

		setActive(arg_17_0.discountTF, arg_17_0.isDiscount)
		setText(arg_17_0.discountValueTF, arg_17_0.discountValue)
		setText(arg_17_0.tipTF, arg_17_0.shop:GetShopTip())
		arg_17_0.goodUIList:align(#arg_17_0.goods)

		local var_17_0 = underscore.detect(arg_17_0.goods, function(arg_18_0)
			return arg_18_0:GetRemainCnt() > 0
		end)

		setActive(arg_17_0.detailEmptyTF, not var_17_0)
		setActive(arg_17_0.detailPanelTF, var_17_0)

		if var_17_0 then
			arg_17_0:updateDetail()
		end

		return
	end
end

function var_0_0.updateDetail(arg_19_0)
	arg_19_0.countValue = 1

	local var_19_0 = arg_19_0.goods[arg_19_0.selectedIndex]:GetShowInfo()

	setText(arg_19_0.detailName, pg.child_item[var_19_0.id].name)
	setText(arg_19_0.detailDesc, pg.child_item[var_19_0.id].desc)
	setText(arg_19_0.countValueTF, arg_19_0.countValue)
	LoadImageSpriteAsync("educateprops/" .. pg.child_item[var_19_0.id].icon, arg_19_0.detailIcon)
	arg_19_0:updateDetailAttrs((EducateHelper.GetItemAddDrops(var_19_0)))
	arg_19_0:updateDetailPrice()

	return
end

function var_0_0.updateDetailAttrs(arg_20_0, arg_20_1)
	for iter_20_0 = 1, arg_20_0.detailAttrsTF.childCount do
		local var_20_1 = arg_20_0.detailAttrsTF:GetChild(iter_20_0 - 1)

		if arg_20_1[iter_20_0] then
			setActive(var_20_1, true)
			EducateHelper.UpdateDropShowForAttr(var_20_1, arg_20_1[iter_20_0])
		else
			setActive(var_20_1, false)
		end
	end

	return
end

function var_0_0.updateDetailPrice(arg_21_0)
	setText(arg_21_0.countValueTF, arg_21_0.countValue)
	setText(arg_21_0.priceValue, arg_21_0.goods[arg_21_0.selectedIndex]:GetCost(arg_21_0.discountRatio).num * arg_21_0.countValue)
	setGray(arg_21_0.purchaseBtn, arg_21_0:GetMaxCount() == 0, true)

	return
end

function var_0_0.GetMaxCount(arg_22_0)
	local var_22_0 = arg_22_0.goods[arg_22_0.selectedIndex]:GetCost(arg_22_0.discountRatio)

	return math.min(arg_22_0.goods[arg_22_0.selectedIndex]:GetRemainCnt(), (math.floor(arg_22_0.char:GetResById(var_22_0.id) / var_22_0.num)))
end

function var_0_0._close(arg_23_0)
	arg_23_0.anim:Play("anim_educate_shop_out")

	return
end

function var_0_0.onBackPressed(arg_24_0)
	arg_24_0:_close()

	return
end

function var_0_0.willExit(arg_25_0)
	arg_25_0.animEvent:SetEndEvent(nil)
	arg_25_0:UnOverlayPanel(arg_25_0._tf)

	return
end

return var_0_0
