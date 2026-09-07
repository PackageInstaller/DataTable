local OriginShopMultiWindow = class("OriginShopMultiWindow", import("...base.BaseSubView"))

function OriginShopMultiWindow:getUIName()
	return "ShopsUIMsgbox"
end

function OriginShopMultiWindow:OnLoaded()
	self.topItem = self._tf:Find("item/panel_bg")
	self.ownerTF = self.topItem:Find("left/own")
	self.detailTF = self.topItem:Find("left/detail")
	self.nameTF = self.topItem:Find("display_panel/name_container/name/Text"):GetComponent(typeof(Text))
	self.descTF = self.topItem:Find("display_panel/desc/Text"):GetComponent(typeof(Text))
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

function OriginShopMultiWindow:OnInit()
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

function OriginShopMultiWindow:Open(arg_6_1, arg_6_2)
	self.opening = true

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:InitWindow(arg_6_1, arg_6_2)
	self:Show()

	return
end

function OriginShopMultiWindow:InitWindow(arg_7_1, arg_7_2)
	local var_7_0
	local var_7_1
	local var_7_2

	if isa(arg_7_1, WorldNShopCommodity) then
		var_7_0 = arg_7_1:GetDropInfo()
		var_7_1 = arg_7_1:GetPriceInfo()
		var_7_2 = arg_7_1:GetLimitGoodCount()
	else
		var_7_0 = arg_7_1:getDropInfo()
		var_7_1 = Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = arg_7_1:getConfig("resource_type"),
			count = arg_7_1:getConfig("resource_num")
		})
		var_7_2 = arg_7_1:getLimitCount()
	end

	local var_7_3 = math.max(math.floor(var_7_1:getOwnedCount() / var_7_1.count), 1)

	if var_7_2 ~= 0 then
		var_7_3 = math.min(var_7_3, var_7_2 - arg_7_1.buyCount)
	end

	local function var_7_4(arg_8_0)
		arg_8_0 = math.max(arg_8_0, 1)
		arg_8_0 = math.min(arg_8_0, var_7_3)
		self.countTF.text = arg_8_0
		self.curCount = arg_8_0
		self.itemCountTF.text = arg_8_0 * var_7_0.count

		return
	end

	var_7_4(1)
	updateDrop(self.topItem:Find("left/IconTpl"), var_7_0)
	UpdateOwnDisplay(self.ownerTF, var_7_0)
	RegisterDetailButton(self, self.detailTF, var_7_0)

	self.nameTF.text = var_7_0:getConfig("name")
	self.descTF.text = var_7_0.desc or var_7_0:getConfig("desc")

	updateDrop(self.bottomItem, var_7_0)
	onButton(self, self.confirmBtn, function()
		existCall(arg_7_2, arg_7_1, self.curCount)
		self:Close()

		return
	end, SFX_PANEL)
	onButton(self, self.leftBtn, function()
		var_7_4(self.curCount - 1)

		return
	end)
	onButton(self, self.rightBtn, function()
		var_7_4(self.curCount + 1)

		return
	end)
	onButton(self, self.maxBtn, function()
		var_7_4(var_7_3)

		return
	end)

	return
end

function OriginShopMultiWindow:Close()
	if self.opening then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
		self:Hide()

		self.opening = false
	end

	return
end

function OriginShopMultiWindow:OnDestroy()
	if self.opening then
		self:Close()
	end

	return
end

return OriginShopMultiWindow
