local ChargeTipWindow = class("ChargeTipWindow", import("view.base.BaseSubView"))

ChargeTipWindow.TYPE_MONTH_CARD = "MonthCard"
ChargeTipWindow.TYPE_GIFTPACKAGE = "GiftPackage"
ChargeTipWindow.TYPE_CURSING = "Crusing"

function ChargeTipWindow:getUIName()
	return "ChargeTipUI"
end

function ChargeTipWindow:OnLoaded()
	self.container = self._tf:Find("frame/window")
	self.closeBtn = self._tf:Find("frame/top/btnBack")
	self.confirmBtn = self._tf:Find("frame/confirm")

	setText(self._tf:Find("frame/top/title"), i18n("words_information"))
	setText(self.confirmBtn:Find("Text"), i18n("msgbox_text_confirm"))

	return
end

function ChargeTipWindow:OnInit()
	self.window = {}

	return
end

local function var_0_1(arg_4_0)
	local var_4_0 = arg_4_0:getConfig("extra_service")

	if var_4_0 == Goods.MONTH_CARD then
		return ChargeTipWindow.TYPE_MONTH_CARD
	elseif var_4_0 == Goods.ITEM_BOX then
		return ChargeTipWindow.TYPE_GIFTPACKAGE
	elseif var_4_0 == Goods.PASS_ITEM then
		return ChargeTipWindow.TYPE_CURSING
	end

	return
end

function ChargeTipWindow:Show(arg_5_1)
	assert(arg_5_1:isChargeType())
	ChargeTipWindow.super.Show(self)

	self.chargeCommodity = arg_5_1

	local var_5_0 = var_0_1(arg_5_1)

	if not var_5_0 then
		self:Hide()

		return
	end

	seriesAsync({
		function(arg_6_0)
			self:LoadWindow(var_5_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			self:UpdateWindow(var_5_0, arg_7_0)

			return
		end
	}, function()
		self:RegisterEvent()

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ChargeTipWindow:LoadWindow(arg_9_1, arg_9_2)
	if self.window[arg_9_1] then
		arg_9_2()

		return
	end

	ResourceMgr.Inst:getAssetAsync("ui/" .. arg_9_1 .. "TipWindow", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
		self.window[arg_9_1] = Object.Instantiate(arg_10_0, self.container).transform

		arg_9_2()

		return
	end), true, true)

	return
end

function ChargeTipWindow:UpdateWindow(arg_11_1, arg_11_2)
	setActive(self.window[arg_11_1], true)

	if self["Update" .. arg_11_1] then
		self["Update" .. arg_11_1](self, self.window[arg_11_1])
	end

	arg_11_2()

	return
end

local function var_0_2(arg_12_0, arg_12_1)
	local var_12_0 = UIItemList.New(arg_12_0:Find("awards"), arg_12_0:Find("awards/award"))

	var_12_0:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			updateDrop(arg_13_2, {
				type = arg_12_1[arg_13_1 + 1][1],
				id = arg_12_1[arg_13_1 + 1][2],
				count = arg_12_1[arg_13_1 + 1][3]
			})
		end

		return
	end)
	var_12_0:align(#arg_12_1)

	return
end

function ChargeTipWindow:UpdateMonthCard(arg_14_1)
	setText(arg_14_1:Find("title/label/txt"), i18n("chargetip_monthcard_1"))
	setText(arg_14_1:Find("title/Text"), "X" .. self.chargeCommodity:getConfig("gem") + self.chargeCommodity:getConfig("extra_gem"))
	setText(arg_14_1:Find("sub_title"), i18n("chargetip_monthcard_2"))
	var_0_2(arg_14_1, (self.chargeCommodity:getConfig("display")))
	setAnchoredPosition(self.confirmBtn, {
		y = -540
	})

	return
end

function ChargeTipWindow:UpdateGiftPackage(arg_15_1)
	setText(arg_15_1:Find("title"), i18n("chargetip_giftpackage"))

	local var_15_0 = self.chargeCommodity:GetDropItem()
	local var_15_1 = UIItemList.New(arg_15_1:Find("list/content"), arg_15_1:Find("list/content/award"))

	var_15_1:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			updateDrop(arg_16_2, {
				type = var_15_0[arg_16_1 + 1][1],
				id = var_15_0[arg_16_1 + 1][2],
				count = var_15_0[arg_16_1 + 1][3]
			})
		end

		return
	end)
	var_15_1:align(#var_15_0)
	setActive(arg_15_1:Find("icon"), false)
	setAnchoredPosition(self.confirmBtn, {
		y = -550
	})

	return
end

function ChargeTipWindow:UpdateCrusing(arg_17_1)
	setText(arg_17_1:Find("title"), i18n("chargetip_crusing"))
	setText(arg_17_1:Find("sub_title"), i18n("charge_tip_crusing_label"))
	var_0_2(arg_17_1, (self.chargeCommodity:getConfig("display")))
	setAnchoredPosition(self.confirmBtn, {
		y = -550
	})

	return
end

function ChargeTipWindow:RegisterEvent()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function ChargeTipWindow:Hide()
	ChargeTipWindow.super.Hide(self)
	removeOnButton(self._tf)
	removeOnButton(self.closeBtn)
	removeOnButton(self.confirmBtn)

	for iter_22_0, iter_22_1 in pairs(self.window) do
		if not IsNil(iter_22_1) then
			setActive(iter_22_1, false)
		end
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function ChargeTipWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	for iter_23_0, iter_23_1 in pairs(self.window) do
		if not IsNil(iter_23_1) then
			Object.Destroy(iter_23_1.gameObject)
		end
	end

	self.window = {}

	return
end

return ChargeTipWindow
