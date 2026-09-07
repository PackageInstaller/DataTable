local NewSkinShopPurchaseView = class("NewSkinShopPurchaseView", import("view.base.BaseSubView"))

function NewSkinShopPurchaseView:getUIName()
	return "NewSkinShopPurchaseUI"
end

function NewSkinShopPurchaseView:OnLoaded()
	self.cancelBtn = self._tf:Find("frame/cancel")
	self.confirmBtn = self._tf:Find("frame/confirm")
	self.toggle = self._tf:Find("frame")
	self.title = self._tf:Find("frame/title")
	self.text = self._tf:Find("frame/bg/Text"):GetComponent(typeof(Text))
	self.tipText = self._tf:Find("frame/bg/tipText")
	self.textWithGift = self._tf:Find("frame/gift_bg/Text"):GetComponent(typeof(Text))
	self.dropsList = UIItemList.New(self._tf:Find("frame/gift_bg/gift/drops"), self._tf:Find("frame/gift_bg/gift/drops/item"))

	return
end

function NewSkinShopPurchaseView:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self.commodity then
			self:emit(NewSkinShopMainView.EVT_ON_PURCHASE, self.commodity)
		end

		return
	end, SFX_PANEL)

	return
end

function NewSkinShopPurchaseView:Show(arg_7_1)
	NewSkinShopPurchaseView.super.Show(self)

	self.commodity = arg_7_1

	self:Flush(arg_7_1)
	self:emit(NewSkinShopMainView.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, true)

	return
end

function NewSkinShopPurchaseView:GetText(arg_8_1)
	return (arg_8_1 or nil) and (self.textWithGift or self.text)
end

function NewSkinShopPurchaseView:Flush(arg_9_1)
	local var_9_0 = arg_9_1:GetGiftList()
	local var_9_1 = #var_9_0 > 0

	triggerToggle(self.toggle, #var_9_0 > 0)

	local var_9_2 = self:GetText(var_9_1)

	setAnchoredPosition(self.title, {
		y = var_9_1 and 460 or 401
	})

	local var_9_3 = arg_9_1:GetPrice()

	var_9_2.text = i18n("skin_shop_buy_confirm", (var_9_3 <= getProxy(PlayerProxy):getRawData():getChargeGem() or nil) and (COLOR_GREEN or COLOR_RED), var_9_3, pg.ship_skin_template[arg_9_1:getSkinId()].name)

	self:SetTipText(arg_9_1:getSkinId())
	self:FlushGift(var_9_0)

	return
end

function NewSkinShopPurchaseView:FlushGift(arg_10_1)
	self.dropsList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = {
				type = arg_10_1[arg_11_1 + 1].type,
				id = arg_10_1[arg_11_1 + 1].id,
				count = arg_10_1[arg_11_1 + 1].count
			}

			updateDrop(arg_11_2, var_11_0)
			onButton(self, arg_11_2, function()
				self:emit(BaseUI.ON_DROP, var_11_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.dropsList:align(#arg_10_1)

	return
end

function NewSkinShopPurchaseView:SetTipText(arg_13_1)
	local var_13_0
	local var_13_1

	for iter_13_0, iter_13_1 in ipairs(pg.gameset.no_share_skin_tip.description) do
		for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
			if pg.ship_skin_template[arg_13_1].ship_group == iter_13_3[1] then
				var_13_0 = iter_13_1
				var_13_1 = iter_13_2

				break
			end
		end
	end

	setActive(self.tipText, var_13_1)

	if var_13_1 then
		local var_13_2 = ""

		for iter_13_4, iter_13_5 in ipairs(var_13_0) do
			if iter_13_4 ~= var_13_1 then
				var_13_2 = var_13_2 == "" and i18n(iter_13_5[2]) or var_13_2 .. "、" .. i18n(iter_13_5[2])
			end
		end

		setText(self.tipText, i18n("no_share_skin_gametip", i18n(var_13_0[var_13_1][2]), var_13_2))
	end

	return
end

function NewSkinShopPurchaseView:Hide()
	NewSkinShopPurchaseView.super.Hide(self)
	self:emit(NewSkinShopMainView.EVT_SHOW_OR_HIDE_PURCHASE_VIEW, false)

	self.commodity = nil

	return
end

function NewSkinShopPurchaseView:OnDestroy()
	return
end

return NewSkinShopPurchaseView
