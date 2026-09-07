local EducateShopLayer = class("EducateShopLayer", import("..base.EducateBaseUI"))

function EducateShopLayer:getUIName()
	return "EducateShopUI"
end

function EducateShopLayer:init()
	self:initData()
	self:findUI()
	self:addListener()

	return
end

function EducateShopLayer:initData()
	assert(self.contextData.shopId, "打开商店layer需要传入shopId")

	self.shopId = self.contextData.shopId

	return
end

function EducateShopLayer:findUI()
	self.anim = self._tf:Find("anim_root"):GetComponent(typeof(Animation))
	self.animEvent = self._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	self.animEvent:SetEndEvent(function()
		self:emit(EducateShopLayer.ON_CLOSE)

		return
	end)

	self.windowTF = self._tf:Find("anim_root/window")
	self.titleTF = self.windowTF:Find("title")

	setText(self.titleTF:Find("Text"), i18n("word_shop"))

	self.closeBtn = self.titleTF:Find("close_btn")
	self.discountTF = self.titleTF:Find("Text/discount")
	self.discountValueTF = self.discountTF:Find("Text")
	self.goodContent = self.windowTF:Find("view/content")
	self.goodUIList = UIItemList.New(self.goodContent, self.goodContent:Find("tpl"))

	setText(self.goodContent:Find("tpl/sellout/Text"), i18n("word_sell_out"))

	self.tipTF = self.windowTF:Find("tip")
	self.detailPanelTF = self.windowTF:Find("detail/content")
	self.detailEmptyTF = self.windowTF:Find("detail/empty")

	setText(self.detailEmptyTF:Find("Text"), i18n("child_shop_empty_tip"))

	self.detailName = self.detailPanelTF:Find("title/Text")
	self.detailDesc = self.detailPanelTF:Find("desc")
	self.detailIcon = self.detailPanelTF:Find("icon")
	self.detailAttrsTF = self.detailPanelTF:Find("attrs")

	setActive(self.detailPanelTF:Find("count"), false)

	self.countValueTF = self.detailPanelTF:Find("count/bg/Text")
	self.addCountBtn = self.detailPanelTF:Find("count/add")
	self.reduceCountBtn = self.detailPanelTF:Find("count/reduce")
	self.maxCountBtn = self.detailPanelTF:Find("count/max")
	self.priceValue = self.detailPanelTF:Find("price/value/Text")

	setText(self.detailPanelTF:Find("price/title"), i18n("child_shop_price_title"))

	self.purchaseBtn = self.detailPanelTF:Find("purchase_btn")

	setText(self.purchaseBtn:Find("Text"), i18n("word_buy"))

	return
end

function EducateShopLayer:addListener()
	onButton(self, self._tf:Find("anim_root/bg"), function()
		self:_close()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:_close()

		return
	end, SFX_PANEL)
	onButton(self, self.addCountBtn, function()
		if self.countValue >= self:GetMaxCount() then
			return
		end

		self.countValue = self.countValue + 1

		self:updateDetailPrice()

		return
	end, SFX_PANEL)
	onButton(self, self.reduceCountBtn, function()
		if self.countValue <= 1 then
			return
		end

		self.countValue = self.countValue - 1

		self:updateDetailPrice()

		return
	end, SFX_PANEL)
	onButton(self, self.maxCountBtn, function()
		local var_11_0 = self:GetMaxCount()

		if self.countValue == var_11_0 then
			return
		end

		self.countValue = var_11_0

		self:updateDetailPrice()

		return
	end, SFX_PANEL)
	onButton(self, self.purchaseBtn, function()
		if self:GetMaxCount() == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

			return
		end

		self:emit(EducateShopMediator.ON_SHOPPING, {
			shopId = self.shopId,
			goods = {
				{
					id = self.goods[self.selectedIndex].id,
					num = self.countValue
				}
			}
		})

		return
	end, SFX_PANEL)
	self.goodUIList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			self:updateGoodItem(arg_13_1, arg_13_2)
		end

		return
	end)

	return
end

function EducateShopLayer:didEnter()
	self:OverlayPanel(self._tf, {
		groupDelta = 2
	})

	self.selectedIndex = 1
	self.countValue = 1

	self:refreshShops()

	return
end

function EducateShopLayer:updateGoodItem(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1 + 1
	local var_15_1 = self.goods[arg_15_1 + 1]

	setActive(arg_15_2:Find("discount"), self.isDiscount)
	setText(arg_15_2:Find("discount/Text"), "-" .. self.discountValue)

	local var_15_2 = var_15_1:GetPrice()
	local var_15_3 = self.isDiscount and var_15_1:GetPrice(self.discountRatio) or var_15_2

	setActive(arg_15_2:Find("bottom/price/price_original"), self.isDiscount)
	setText(arg_15_2:Find("bottom/price/price_original"), var_15_2)
	setText(arg_15_2:Find("bottom/price/price_final"), var_15_3)
	EducateHelper.UpdateDropShow(arg_15_2:Find("item"), (var_15_1:GetShowInfo()))
	setActive(arg_15_2:Find("sellout"), not var_15_1:CanBuy())
	setActive(arg_15_2:Find("selected"), arg_15_1 + 1 == self.selectedIndex)
	onButton(self, arg_15_2, function()
		if var_15_0 == self.selectedIndex then
			return
		end

		self.selectedIndex = var_15_0

		for iter_16_0 = 0, self.goodContent.childCount - 1 do
			setActive(self.goodContent:GetChild(iter_16_0):Find("selected"), iter_16_0 + 1 == self.selectedIndex)
		end

		self:updateDetail()

		return
	end, SFX_PANEL)

	return
end

function EducateShopLayer:refreshShops()
	self.shopProxy = getProxy(EducateProxy):GetShopProxy()
	self.shop = self.shopProxy:GetShopWithId(self.shopId)
	self.goods = self.shop:GetGoods((getProxy(EducateProxy):GetCurTime()))
	self.char = getProxy(EducateProxy):GetCharData()
	self.isDiscount = self.shopProxy:IsDiscountById(self.shopId)
	self.discountRatio = self.shopProxy:GetDiscountById(self.shopId)

	if self.isDiscount then
		self.discountValue = self.discountRatio / 100 .. "%" or ""
	end

	setActive(self.discountTF, self.isDiscount)
	setText(self.discountValueTF, self.discountValue)
	setText(self.tipTF, self.shop:GetShopTip())
	self.goodUIList:align(#self.goods)

	local var_17_0 = underscore.detect(self.goods, function(arg_18_0)
		return arg_18_0:GetRemainCnt() > 0
	end)

	setActive(self.detailEmptyTF, not var_17_0)
	setActive(self.detailPanelTF, var_17_0)

	if var_17_0 then
		self:updateDetail()
	end

	return
end

function EducateShopLayer:updateDetail()
	self.countValue = 1

	local var_19_0 = self.goods[self.selectedIndex]:GetShowInfo()

	setText(self.detailName, pg.child_item[var_19_0.id].name)
	setText(self.detailDesc, pg.child_item[var_19_0.id].desc)
	setText(self.countValueTF, self.countValue)
	LoadImageSpriteAsync("educateprops/" .. pg.child_item[var_19_0.id].icon, self.detailIcon)
	self:updateDetailAttrs((EducateHelper.GetItemAddDrops(var_19_0)))
	self:updateDetailPrice()

	return
end

function EducateShopLayer:updateDetailAttrs(arg_20_1)
	for iter_20_0 = 1, self.detailAttrsTF.childCount do
		local var_20_1 = self.detailAttrsTF:GetChild(iter_20_0 - 1)

		if arg_20_1[iter_20_0] then
			setActive(var_20_1, true)
			EducateHelper.UpdateDropShowForAttr(var_20_1, arg_20_1[iter_20_0])
		else
			setActive(var_20_1, false)
		end
	end

	return
end

function EducateShopLayer:updateDetailPrice()
	setText(self.countValueTF, self.countValue)
	setText(self.priceValue, self.goods[self.selectedIndex]:GetCost(self.discountRatio).num * self.countValue)
	setGray(self.purchaseBtn, self:GetMaxCount() == 0, true)

	return
end

function EducateShopLayer:GetMaxCount()
	local var_22_0 = self.goods[self.selectedIndex]:GetCost(self.discountRatio)

	return math.min(self.goods[self.selectedIndex]:GetRemainCnt(), (math.floor(self.char:GetResById(var_22_0.id) / var_22_0.num)))
end

function EducateShopLayer:_close()
	self.anim:Play("anim_educate_shop_out")

	return
end

function EducateShopLayer:onBackPressed()
	self:_close()

	return
end

function EducateShopLayer:willExit()
	self.animEvent:SetEndEvent(nil)
	self:UnOverlayPanel(self._tf)

	return
end

return EducateShopLayer
