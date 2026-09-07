local NewProbabilitySkinShopScene = class("NewProbabilitySkinShopScene", import(".NewSkinShopScene"))

function NewProbabilitySkinShopScene:ResUISettings()
	return false
end

function NewProbabilitySkinShopScene:init()
	NewProbabilitySkinShopScene.super.init(self)

	self.contextData.mode = NewSkinShopScene.MODE_OVERVIEW
	self.commodity = self:GetCommodity(self.contextData.commodityId)
	self.itemView = NewProbabilitySkinShopView.New(self._tf:Find("overlay"), self.event)
	self.chargeTipWindow = ChargeTipWindow.New(self._tf, self.event)

	return
end

function NewProbabilitySkinShopScene:GetCommodity(arg_3_1)
	local var_3_0 = Goods.Create({
		shop_id = arg_3_1
	}, Goods.TYPE_CHARGE)
	local var_3_1 = getProxy(ShopsProxy):getChargedList()

	var_3_1 = var_3_1 or {}

	var_3_0:updateBuyCount((ChargeConst.getBuyCount(var_3_1, var_3_0.id)))

	return var_3_0
end

function NewProbabilitySkinShopScene:OnChargeSuccess(arg_4_1)
	local var_4_0 = self:GetCommodity(arg_4_1)

	self.commodity = var_4_0

	self.chargeTipWindow:ExecuteAction("Show", var_4_0)

	if self.itemView and self.itemView:GetLoaded() then
		self.itemView:Flush(var_4_0)
	end

	return
end

function NewProbabilitySkinShopScene:didEnter()
	NewProbabilitySkinShopScene.super.didEnter(self)
	setActive(self.atlasBtn, false)
	setActive(self._tf:Find("overlay/left/mask"), false)

	local var_5_0 = self._tf:Find("overlay/bottom")
	local var_5_1 = rtf(self.scrollrect.gameObject)

	var_5_1.sizeDelta = Vector2(var_5_0.sizeDelta.x - 160, var_5_0.sizeDelta.y)

	setAnchoredPosition(var_5_1, {
		x = 0
	})
	setAnchoredPosition(self.prevBtn, {
		x = 32
	})
	setActive(self._tf:Find("overlay/right/price"), false)
	setActive(self.live2dFilter, false)
	setActive(self.changeBtn, false)

	return
end

function NewProbabilitySkinShopScene:UpdateCouponBtn()
	self.couponTr.localScale = Vector3(0, 0, 0)

	return
end

function NewProbabilitySkinShopScene:UpdateVoucherBtn()
	self.voucherTr.localScale = Vector3(0, 0, 0)

	return
end

function NewProbabilitySkinShopScene:UpdateTitle(arg_8_1)
	self.title.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", "probabilityshop")

	self.title:SetNativeSize()
	setAnchoredPosition(self.title.gameObject, {
		x = 363
	})
	setActive(self.titleEn.gameObject, false)

	return
end

function NewProbabilitySkinShopScene:GetAllCommodity()
	return getProxy(ShipSkinProxy):GetProbabilitySkins((self.commodity:GetSkinProbability()))
end

function NewProbabilitySkinShopScene:GetSkinProbability()
	return getProxy(ShipSkinProxy):GetSkinProbabilitys((self.commodity:GetSkinProbability()))
end

function NewProbabilitySkinShopScene:GetSkinClassify(arg_11_1, arg_11_2)
	return {
		NewSkinShopScene.PAGE_ALL
	}
end

function NewProbabilitySkinShopScene:IsType(arg_12_1, arg_12_2)
	return true
end

function NewProbabilitySkinShopScene:UpdateCommodities(arg_13_1, arg_13_2, arg_13_3)
	self.skinProbabilityList = self:GetSkinProbability()

	seriesAsync({
		function(arg_14_0)
			NewProbabilitySkinShopScene.super.UpdateCommodities(self, arg_13_1, arg_13_2, arg_14_0)

			return
		end,
		function(arg_15_0)
			self:FlushItemView(arg_15_0)

			return
		end
	}, arg_13_3)

	return
end

function NewProbabilitySkinShopScene:FlushItemView(arg_16_1)
	self.itemView:ExecuteAction("Show", self.commodity)
	arg_16_1()

	return
end

function NewProbabilitySkinShopScene:OnUpdateItem(arg_17_1, arg_17_2)
	NewProbabilitySkinShopScene.super.OnUpdateItem(self, arg_17_1, arg_17_2)

	local var_17_0 = self.cards[arg_17_2]
	local var_17_1 = self.cards[arg_17_2].commodity.buyCount == 0

	setActive(self.cards[arg_17_2].tagImg, not (self.cards[arg_17_2].commodity.buyCount == 0))
	setActive(var_17_0.tagEnImg, false)
	setActive(var_17_0.discountTag, false)
	setActive(var_17_0.timelimitTag, false)

	if not var_17_1 then
		var_17_0.tagImg.sprite = GetSpriteFromAtlas("ui/SkinShopUI_atlas", "tag_yigoumai")
	end

	var_17_0.txt.text = " " .. string.format("%0.1f", (self.skinProbabilityList[var_17_0.commodity:getSkinId()] or 0) / 100) .. "%"

	return
end

function NewProbabilitySkinShopScene:willExit()
	if self.itemView then
		self.itemView:Destroy()

		self.itemView = nil
	end

	if self.mainView then
		self.mainView:Dispose()

		self.mainView = nil
	end

	if self.chargeTipWindow then
		self.chargeTipWindow:Destroy()

		self.chargeTipWindow = nil
	end

	Input.multiTouchEnabled = true

	return
end

return NewProbabilitySkinShopScene
