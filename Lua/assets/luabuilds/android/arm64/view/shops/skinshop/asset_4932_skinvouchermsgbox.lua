local SkinVoucherMsgBox = class("SkinVoucherMsgBox", import(".SkinCouponMsgBox"))
local var_0_1 = 0
local var_0_2 = 1

function SkinVoucherMsgBox:getUIName()
	return "SkinVoucherMsgBoxUI"
end

function SkinVoucherMsgBox:OnLoaded()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

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

function SkinVoucherMsgBox:RegisterBtn(arg_3_1)
	onButton(self, self.discountPriceBtn, function()
		if not self.prevSelId then
			return
		end

		if arg_3_1.onYes then
			arg_3_1.onYes(self.prevSelId)
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
			self.prevSelId = nil

			self:UpdateContent(self.settings)
			self:UpdateStyle(self.style)
		end

		return
	end, SFX_PANEL)
	onToggle(self, self.useBtn, function(arg_10_0)
		if arg_10_0 then
			self.prevSelId = self:GetDefaultItem()

			self:UpdateContent(self.settings)
			self:UpdateStyle(self.style)
		end

		return
	end, SFX_PANEL)

	return
end

function SkinVoucherMsgBox:GetDefaultItem()
	self.selectedItemId = self.selectedItemId or (function()
		local var_12_0 = _.map(self.settings.itemList, function(arg_13_0)
			local var_13_0 = pg.item_data_statistics[arg_13_0].usage_arg[2] or 0

			return {
				gem = var_13_0,
				id = arg_13_0,
				time = pg.item_data_statistics[arg_13_0].time_limit
			}
		end)

		if #var_12_0 == 0 then
			return nil
		end

		table.sort(var_12_0, function(arg_14_0, arg_14_1)
			if arg_14_0.time ~= arg_14_1.time then
				return arg_14_0.time > arg_14_1.time
			else
				return arg_14_0.gem > arg_14_1.gem
			end

			return
		end)

		return var_12_0[1].id
	end)()

	return self.selectedItemId
end

function SkinVoucherMsgBox:UpdateContent(arg_15_1)
	if self.prevSelId then
		local var_15_0 = math.max(0, arg_15_1.price - pg.item_data_statistics[self.prevSelId].usage_arg[2])

		self.label1.text = i18n(var_15_0 > 0 and "skin_purchase_confirm" or "skin_purchase_over_price", pg.item_data_statistics[self.prevSelId].name, var_15_0, arg_15_1.skinName)
	else
		self.label1.text = i18n("charge_scene_buy_confirm", arg_15_1.price, arg_15_1.skinName)
	end

	self:UpdateLink()
	self:SetTipText(arg_15_1.skinId)

	return
end

function SkinVoucherMsgBox:UpdateLink()
	self.linkText.text = i18n("skin_shop_discount_item_link", pg.item_data_statistics[self:GetDefaultItem()].usage_arg[2] or 0)

	return
end

function SkinVoucherMsgBox:UpdateItem(arg_17_1)
	self.itemTrs = {}

	local var_17_0 = arg_17_1.itemList

	UIItemList.StaticAlign(self._tf:Find("window/frame/scrollrect/list"), self._tf:Find("window/frame/left"), #arg_17_1.itemList, function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			self:FlushItem(var_17_0[arg_18_1 + 1], arg_18_2)
		end

		return
	end)

	return
end

function SkinVoucherMsgBox:FlushItem(arg_19_1, arg_19_2)
	updateDrop(arg_19_2, {
		count = 1,
		type = DROP_TYPE_ITEM,
		id = arg_19_1
	})
	setText(arg_19_2:Find("name_bg/Text"), pg.item_data_statistics[arg_19_1].name)
	onToggle(self, arg_19_2, function(arg_20_0)
		if arg_20_0 then
			self.selectedItemId = arg_19_1
		end

		return
	end, SFX_PANEL)

	self.itemTrs[arg_19_1] = arg_19_2

	return
end

function SkinVoucherMsgBox:ClearPrevSel()
	self.prevSelId = nil

	return
end

function SkinVoucherMsgBox:Show(arg_22_1)
	setActive(self._tf, true)

	self.settings = arg_22_1

	self:UpdateItem(arg_22_1)
	self:RegisterBtn(arg_22_1)
	self:UpdateContent(arg_22_1)
	self:UpdateStyle(var_0_1)
	triggerToggle(self.useBtn, true)

	return
end

function SkinVoucherMsgBox:UpdateStyle(arg_23_1)
	setActive(self.label1, arg_23_1 == var_0_1)
	setActive(self.optionTr, arg_23_1 == var_0_1)
	setActive(self.realPriceBtn, arg_23_1 == var_0_1 and not self.prevSelId)
	setActive(self.discountPriceBtn, arg_23_1 == var_0_1 and self.prevSelId)
	setActive(self.confirmBtn, arg_23_1 == var_0_2)
	setActive(self.scrollrect, arg_23_1 == var_0_2)
	triggerToggle(self.itemTrs[self:GetDefaultItem()], true)

	self.style = arg_23_1

	return
end

function SkinVoucherMsgBox:Hide()
	self.settings = nil
	self.selectedItemId = nil

	setActive(self._tf, false)
	self:ClearPrevSel()

	for iter_24_0, iter_24_1 in pairs(self.itemTrs) do
		removeOnToggle(iter_24_1)
		triggerToggle(iter_24_1, false)
	end

	return
end

function SkinVoucherMsgBox:SetTipText(arg_25_1)
	local var_25_0
	local var_25_1

	for iter_25_0, iter_25_1 in ipairs(pg.gameset.no_share_skin_tip.description) do
		for iter_25_2, iter_25_3 in ipairs(iter_25_1) do
			if pg.ship_skin_template[arg_25_1].ship_group == iter_25_3[1] then
				var_25_0 = iter_25_1
				var_25_1 = iter_25_2

				break
			end
		end
	end

	setActive(self.tipBar, var_25_1)

	if var_25_1 then
		local var_25_2 = ""

		for iter_25_4, iter_25_5 in ipairs(var_25_0) do
			if iter_25_4 ~= var_25_1 then
				var_25_2 = var_25_2 == "" and i18n(iter_25_5[2]) or var_25_2 .. "、" .. i18n(iter_25_5[2])
			end
		end

		setText(self.tipText, i18n("no_share_skin_gametip", i18n(var_25_0[var_25_1][2]), var_25_2))
	end

	return
end

function SkinVoucherMsgBox:OnDestroy()
	self.super:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return SkinVoucherMsgBox
