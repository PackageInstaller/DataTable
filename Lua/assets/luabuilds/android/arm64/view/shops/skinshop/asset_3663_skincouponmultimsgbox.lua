local SkinCouponMultiMsgBox = class("SkinCouponMultiMsgBox", import("view.shops.skinShop.SkinCouponMsgBox"))
local var_0_1 = 0
local var_0_2 = 1

function SkinCouponMultiMsgBox:getUIName()
	return "SkinVoucherMsgBoxUI"
end

function SkinCouponMultiMsgBox:OnLoaded()
	self.closeBtn = self._tf:Find("window/top/btnBack")
	self.cancelBtn = self._tf:Find("window/button_container/cancel")
	self.confirmBtn = self._tf:Find("window/button_container/confirm")
	self.label1 = self._tf:Find("window/frame/Text"):GetComponent(typeof(Text))
	self.leftItemTr = self._tf:Find("window/frame/left")
	self.nameTxt = self.leftItemTr:Find("name_bg/Text"):GetComponent(typeof(Text))

	setText(self.cancelBtn:Find("pic"), i18n("msgbox_text_cancel"))
	setText(self.confirmBtn:Find("pic"), i18n("msgbox_text_confirm"))
	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("words_information"))
	setActive(self.confirmBtn, false)

	self.realPriceBtn = self._tf:Find("window/button_container/real_price")
	self.discountPriceBtn = self._tf:Find("window/button_container/discount_price")

	setText(self._tf:Find("window/top/bg/infomation/title"), i18n("title_info"))

	self.nonUseBtn = self._tf:Find("window/frame/option/nonuse")
	self.useBtn = self._tf:Find("window/frame/option/use")
	self.scrollrect = self._tf:Find("window/frame/scrollrect")
	self.optionTr = self._tf:Find("window/frame/option")
	self.switchBtn = self._tf:Find("window/frame/option/use/link")
	self.tipBar = self._tf:Find("window/frame/tipBar")
	self.tipText = self.tipBar:Find("Text")
	self.linkText = self._tf:Find("window/frame/option/use/link/Text"):GetComponent(typeof(Text))

	setText(self._tf:Find("window/frame/option/nonuse/Text"), i18n("skin_shop_nonuse_label"))
	setText(self._tf:Find("window/frame/option/use/Text"), i18n("skin_shop_use_label"))

	return
end

function SkinCouponMultiMsgBox:RegisterBtn(arg_3_1)
	onButton(self, self.discountPriceBtn, function()
		if not self.prevSelected then
			return
		end

		if arg_3_1.onYes then
			arg_3_1.onYes(self.prevSelected)
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.realPriceBtn, function()
		if arg_3_1.onYes then
			arg_3_1.onYes()
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.switchBtn, function()
		self:UpdateStyle(1 - self.style)

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:UpdateStyle(1 - self.style)
		triggerToggle(self.useBtn, true)

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		if self.style == var_0_2 then
			self:UpdateStyle(1 - self.style)
		else
			self:Hide()
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.nonUseBtn, function(arg_9_0)
		if arg_9_0 then
			self.prevSelected = nil

			self:UpdateContent(self.settings)
			self:UpdateStyle(self.style)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.useBtn, function(arg_10_0)
		if arg_10_0 then
			self.prevSelected = self:GetDefaultItem()

			self:UpdateContent(self.settings)
			self:UpdateStyle(self.style)
		end

		return
	end, SFX_PANEL)

	return
end

function SkinCouponMultiMsgBox:GetDefaultItem()
	self.selectedItem = self.selectedItem or self.settings.itemList[1]

	return self.selectedItem
end

function SkinCouponMultiMsgBox:UpdateContent(arg_12_1)
	if self.prevSelected then
		local var_12_0 = math.max(0, arg_12_1.price - self.prevSelected.discount)

		self.label1.text = i18n(var_12_0 > 0 and "skin_purchase_confirm" or "skin_purchase_over_price", self.prevSelected.drop:getName(), var_12_0, arg_12_1.skinName)
	else
		self.label1.text = i18n("charge_scene_buy_confirm", arg_12_1.price, arg_12_1.skinName)
	end

	self:UpdateLink()
	self:SetTipText(arg_12_1.skinId)

	return
end

function SkinCouponMultiMsgBox:UpdateLink()
	self.linkText.text = i18n("skin_shop_discount_item_link", self:GetDefaultItem().discount)

	return
end

function SkinCouponMultiMsgBox:UpdateItem(arg_14_1)
	self.itemTrs = {}

	local var_14_0 = arg_14_1.itemList

	UIItemList.StaticAlign(self._tf:Find("window/frame/scrollrect/list"), self._tf:Find("window/frame/left"), #arg_14_1.itemList, function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			self:FlushItem(var_14_0[arg_15_1 + 1], arg_15_2)
		end

		return
	end)

	return
end

function SkinCouponMultiMsgBox:FlushItem(arg_16_1, arg_16_2)
	updateDrop(arg_16_2, arg_16_1.drop)
	setText(arg_16_2:Find("name_bg/Text"), arg_16_1.drop:getName())
	onToggle(self, arg_16_2, function(arg_17_0)
		if arg_17_0 then
			self.selectedItem = arg_16_1
		end

		return
	end, SFX_PANEL)

	self.itemTrs[arg_16_1] = arg_16_2

	return
end

function SkinCouponMultiMsgBox:ClearPrevSel()
	self.prevSelected = nil

	return
end

function SkinCouponMultiMsgBox:Show(arg_19_1)
	setActive(self._tf, true)

	self.settings = arg_19_1

	self:UpdateItem(arg_19_1)
	self:RegisterBtn(arg_19_1)
	self:UpdateContent(arg_19_1)
	self:UpdateStyle(var_0_1)
	setActive(self.nonUseBtn, false)
	triggerToggle(self.useBtn, true)

	return
end

function SkinCouponMultiMsgBox:UpdateStyle(arg_20_1)
	setActive(self.label1, arg_20_1 == var_0_1)
	setActive(self.optionTr, arg_20_1 == var_0_1)
	setActive(self.realPriceBtn, arg_20_1 == var_0_1 and not self.prevSelected)
	setActive(self.discountPriceBtn, arg_20_1 == var_0_1 and self.prevSelected)
	setActive(self.confirmBtn, arg_20_1 == var_0_2)
	setActive(self.scrollrect, arg_20_1 == var_0_2)
	triggerToggle(self.itemTrs[self:GetDefaultItem()], true)

	self.style = arg_20_1

	return
end

function SkinCouponMultiMsgBox:Hide()
	self.settings = nil
	self.selectedItem = nil

	setActive(self._tf, false)
	self:ClearPrevSel()

	for iter_21_0, iter_21_1 in pairs(self.itemTrs) do
		removeOnToggle(iter_21_1)
		triggerToggle(iter_21_1, false)
	end

	return
end

function SkinCouponMultiMsgBox:SetTipText(arg_22_1)
	local var_22_0
	local var_22_1

	for iter_22_0, iter_22_1 in ipairs(pg.gameset.no_share_skin_tip.description) do
		for iter_22_2, iter_22_3 in ipairs(iter_22_1) do
			if pg.ship_skin_template[arg_22_1].ship_group == iter_22_3[1] then
				var_22_0 = iter_22_1
				var_22_1 = iter_22_2

				break
			end
		end
	end

	setActive(self.tipBar, var_22_1)

	if var_22_1 then
		local var_22_2 = ""

		for iter_22_4, iter_22_5 in ipairs(var_22_0) do
			if iter_22_4 ~= var_22_1 then
				var_22_2 = var_22_2 == "" and i18n(iter_22_5[2]) or var_22_2 .. "、" .. i18n(iter_22_5[2])
			end
		end

		setText(self.tipText, i18n("no_share_skin_gametip", i18n(var_22_0[var_22_1][2]), var_22_2))
	end

	return
end

return SkinCouponMultiMsgBox
