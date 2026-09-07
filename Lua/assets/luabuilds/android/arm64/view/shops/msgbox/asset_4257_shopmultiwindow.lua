local ShopMultiWindow = class("ShopMultiWindow", import("...base.BaseSubView"))

function ShopMultiWindow:getUIName()
	return "ShopsUIMsgbox"
end

function ShopMultiWindow:OnLoaded()
	self.topItem = self._tf:Find("item/panel_bg")
	self.ownerTF = self.topItem:Find("left/own")
	self.detailTF = self.topItem:Find("left/detail")
	self.nameTF = self.topItem:Find("display_panel/name_container/name/Text"):GetComponent(typeof(Text))
	self.descTF = self.topItem:Find("display_panel/desc/Text"):GetComponent(typeof(Text))
	self.timeLimitTF = self.topItem:Find("time_limit")
	self.bottomItem = self._tf:Find("got/panel_bg/list/item")
	self.itemCountTF = self.bottomItem:Find("icon_bg/count"):GetComponent(typeof(Text))
	self.maxBtn = self._tf:Find("count/max")
	self.leftBtn = self._tf:Find("count/number_panel/left")
	self.rightBtn = self._tf:Find("count/number_panel/right")
	self.countTF = self._tf:Find("count/number_panel/value"):GetComponent(typeof(Text))
	self.cancelBtn = self._tf:Find("actions/cancel_button")
	self.confirmBtn = self._tf:Find("actions/confirm_button")

	setText(self._tf:Find("got/panel_bg/got_text"), i18n("shops_msgbox_output"))
	setText(self._tf:Find("count/image_text"), i18n("shops_msgbox_exchange_count"))
	setText(self._tf:Find("actions/cancel_button/label"), i18n("shop_word_cancel"))
	setText(self._tf:Find("actions/confirm_button/label"), i18n("shop_word_exchange"))

	return
end

function ShopMultiWindow:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		self:Close()

		return
	end, SFX_PANEL)

	return
end

function ShopMultiWindow:Open(arg_6_1, arg_6_2)
	self.opening = true

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:InitWindow(arg_6_1, arg_6_2)
	self:Show()

	return
end

function ShopMultiWindow:InitWindow(arg_7_1, arg_7_2)
	local var_7_0 = {
		id = arg_7_1:getConfig("commodity_id"),
		type = arg_7_1:getConfig("commodity_type"),
		count = arg_7_1:getConfig("num")
	}

	if isa(arg_7_1, ActivityCommodity) then
		local var_7_1, var_7_2, var_7_3 = arg_7_1:CheckTimeLimit()

		setActive(self.timeLimitTF, var_7_1)

		if var_7_1 and var_7_2 then
			local var_7_4 = getProxy(ActivityProxy):getActivityById(Item.getConfigData(var_7_0.id).link_id)

			setText(self.timeLimitTF:Find("Text"), i18n(var_7_4:IsMaintenanceFinish() and "eventshop_time_hint" or "eventshop_time_hint2", pg.TimeMgr.GetInstance():STimeDescS(var_7_4.stopTime, "%m.%d")))
		end
	end

	local var_7_5 = math.max(math.floor(Drop.New({
		type = arg_7_1:getConfig("resource_category"),
		id = arg_7_1:getConfig("resource_type")
	}):getOwnedCount() / arg_7_1:getConfig("resource_num")), 1)

	if arg_7_1:getConfig("num_limit") == 0 then
		if isa(arg_7_1, QuotaCommodity) then
			var_7_5 = math.min(var_7_5, math.max(0, (arg_7_1:GetPurchasableCnt())))
		end
	end

	local function var_7_6(arg_8_0)
		arg_8_0 = math.max(arg_8_0, 1)
		arg_8_0 = math.min(arg_8_0, var_7_5)
		self.countTF.text = arg_8_0
		self.curCount = arg_8_0
		self.itemCountTF.text = arg_8_0 * arg_7_1:getConfig("num")

		return
	end

	var_7_6(1)
	updateDrop(self.topItem:Find("left/IconTpl"), var_7_0)
	UpdateOwnDisplay(self.ownerTF, var_7_0)
	RegisterDetailButton(self, self.detailTF, var_7_0)

	self.nameTF.text = var_7_0:getConfig("name")
	self.descTF.text = HXSet.hxLan(var_7_0.desc or var_7_0:getConfig("desc"))

	updateDrop(self.bottomItem, var_7_0)
	onButton(self, self.confirmBtn, function()
		if arg_7_2 then
			arg_7_2(arg_7_1, self.curCount, var_7_0:getConfig("name"))
		end

		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, self.leftBtn, function()
		var_7_6(self.curCount - 1)

		return
	end)
	onButton(self, self.rightBtn, function()
		var_7_6(self.curCount + 1)

		return
	end)
	onButton(self, self.maxBtn, function()
		var_7_6(var_7_5)

		return
	end)

	return
end

function ShopMultiWindow:Close()
	if self.opening then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
		self:Hide()

		self.opening = false
	end

	return
end

function ShopMultiWindow:OnDestroy()
	if self.opening then
		self:Close()
	end

	return
end

return ShopMultiWindow
