local MiniGameShopMultiWindow = class("MiniGameShopMultiWindow", import("...base.BaseSubView"))

function MiniGameShopMultiWindow:getUIName()
	return "ShopsUIMsgbox"
end

function MiniGameShopMultiWindow:OnLoaded()
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

function MiniGameShopMultiWindow:OnInit()
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function MiniGameShopMultiWindow:Show(arg_6_1, arg_6_2)
	self:InitWindow(arg_6_1, arg_6_2)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	MiniGameShopMultiWindow.super.Show(self)

	return
end

function MiniGameShopMultiWindow:Hide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	MiniGameShopMultiWindow.super.Hide(self)

	return
end

function MiniGameShopMultiWindow:InitWindow(arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1:GetDropInfo()
	local var_8_1 = math.max(math.floor(getProxy(GameRoomProxy):getTicket() / arg_8_1:getConfig("price")), 1)

	if arg_8_1:GetMaxCnt() ~= 0 then
		var_8_1 = math.min(var_8_1, arg_8_1:GetMaxCnt())
	end

	local function var_8_2(arg_9_0)
		arg_9_0 = math.max(arg_9_0, 1)
		arg_9_0 = math.min(arg_9_0, var_8_1)
		self.countTF.text = arg_9_0
		self.curCount = arg_9_0
		self.itemCountTF.text = arg_9_0 * arg_8_1:getConfig("num")

		return
	end

	var_8_2(1)
	updateDrop(self.topItem:Find("left/IconTpl"), var_8_0)
	UpdateOwnDisplay(self.ownerTF, var_8_0)
	RegisterDetailButton(self, self.detailTF, var_8_0)

	self.nameTF.text = var_8_0:getConfig("name")
	self.descTF.text = var_8_0.desc or var_8_0:getConfig("desc")

	updateDrop(self.bottomItem, var_8_0)
	onButton(self, self.confirmBtn, function()
		if arg_8_2 then
			arg_8_2(self.curCount)
		end

		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.leftBtn, function()
		var_8_2(self.curCount - 1)

		return
	end)
	onButton(self, self.rightBtn, function()
		var_8_2(self.curCount + 1)

		return
	end)
	onButton(self, self.maxBtn, function()
		var_8_2(var_8_1)

		return
	end)

	return
end

function MiniGameShopMultiWindow:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return MiniGameShopMultiWindow
