local GuildShopPurchasePanel = class("GuildShopPurchasePanel", import("...base.BaseSubView"))

function GuildShopPurchasePanel:getUIName()
	return "GuildShopPurchaseMsgUI"
end

function GuildShopPurchasePanel:OnLoaded()
	self.list = UIItemList.New(self._tf:Find("got/bottom/scroll/list"), self._tf:Find("got/bottom/scroll/list/tpl"))
	self.confirmBtn = self._tf:Find("confirm")
	self.descTxt = self._tf:Find("got/top/desc"):GetComponent(typeof(Text))
	self.exchagneCnt = self._tf:Find("got/top/exchange/Text"):GetComponent(typeof(Text))
	self.consumeCnt = self._tf:Find("confirm/consume/Text"):GetComponent(typeof(Text))
	self.title = self._tf:Find("got/top/title")

	setText(self._tf:Find("got/top/exchange/label"), i18n("guild_shop_label_2"))
	setText(self._tf:Find("confirm/Text"), i18n("guild_shop_label_3"))
	setText(self._tf:Find("confirm/consume/label"), i18n("guild_shop_label_4"))

	self.resIcon = self._tf:Find("confirm/consume/icon")

	self:Hide()

	return
end

function GuildShopPurchasePanel:OnInit()
	onButton(self, self.confirmBtn, function()
		if #self.selectedList == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_shop_must_select_goods"))

			return
		end

		self:OnConfirm()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function GuildShopPurchasePanel:OnConfirm()
	self:emit(NewShopMainMediator.ON_GUILD_SHOPPING, self.data.id, self.selectedList)

	return
end

function GuildShopPurchasePanel:Show(arg_7_1)
	GuildShopPurchasePanel.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.data = arg_7_1
	self.maxCnt = arg_7_1.count
	self.selectedList = {}

	self:InitList()
	self:UpdateValue()

	if arg_7_1.type == 4 then
		setText(self.title, i18n("guild_shop_label_5"))
	else
		setText(self.title, i18n("guild_shop_label_1"))
	end

	self.descTxt.text = ""

	return
end

function GuildShopPurchasePanel:UpdateValue()
	self.exchagneCnt.text = ((self.maxCnt - #self.selectedList > 0 or nil) and ("<color=#92FC63FF>" .. self.maxCnt - #self.selectedList .. "</color>/" or "<color=#FF5C5CFF>" .. self.maxCnt - #self.selectedList .. "</color>/")) .. self.maxCnt

	setActive(self._tf:Find("got/top/exchange"), self.maxCnt ~= 0)

	self.consumeCnt.text = self.data.price * #self.selectedList

	return
end

function GuildShopPurchasePanel:InitList()
	local var_9_0 = self.data

	self.displays = self.data.displays

	self.list:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			self:UpdateItem(var_9_0, self.displays[arg_10_1 + 1], arg_10_2)
		end

		return
	end)
	self.list:align(#self.displays)

	return
end

function GuildShopPurchasePanel:UpdateItem(arg_11_1, arg_11_2, arg_11_3)
	updateDrop(arg_11_3:Find("item/bg"), {
		type = arg_11_1.type,
		id = arg_11_2,
		count = arg_11_1.num
	})
	arg_11_3:Find("name_bg/Text"):GetComponent("ScrollText"):SetText((Drop.New({
		type = arg_11_1.type,
		id = arg_11_2
	}):getConfig("name")))

	local var_11_0 = arg_11_3:Find("cnt/Text"):GetComponent(typeof(Text))

	local function var_11_1()
		local var_12_0 = 0

		for iter_12_0, iter_12_1 in ipairs(self.selectedList) do
			if iter_12_1 == arg_11_2 then
				var_12_0 = var_12_0 + 1
			end
		end

		var_11_0.text = var_12_0

		return
	end

	onButton(self, arg_11_3, function()
		self:ClickItem(arg_11_3, arg_11_2)

		return
	end, SFX_PANEL)
	pressPersistTrigger(arg_11_3:Find("cnt/minus"), 0.5, function()
		self:PressMinusBtn(arg_11_3, arg_11_2)
		var_11_1()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(arg_11_3:Find("cnt/add"), 0.5, function()
		self:PressAddBtn(arg_11_3, arg_11_2)
		var_11_1()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	setActive(arg_11_3:Find("mask"), false)
	var_11_1()

	return
end

function GuildShopPurchasePanel:ClearZeroItem(arg_16_1)
	self.list:each(function(arg_17_0, arg_17_1)
		if arg_16_1 ~= arg_17_1 and not table.contains(self.selectedList, self.displays[arg_17_0 + 1]) then
			setActive(arg_17_1:Find("cnt"), false)
			setActive(arg_17_1:Find("selected"), false)
		end

		return
	end)

	return
end

function GuildShopPurchasePanel:ClickItem(arg_18_1, arg_18_2)
	self:ClearZeroItem(arg_18_1)
	setActive(arg_18_1:Find("cnt"), true)
	setActive(arg_18_1:Find("selected"), true)

	return
end

function GuildShopPurchasePanel:PressMinusBtn(arg_19_1, arg_19_2)
	if #self.selectedList == 0 then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(self.selectedList) do
		if iter_19_1 == arg_19_2 then
			table.remove(self.selectedList, iter_19_0)

			break
		end
	end

	self:UpdateValue()

	return
end

function GuildShopPurchasePanel:PressAddBtn(arg_20_1, arg_20_2)
	if #self.selectedList == self.maxCnt and self.maxCnt ~= 0 then
		return
	end

	table.insert(self.selectedList, arg_20_2)
	self:UpdateValue()

	return
end

function GuildShopPurchasePanel:Hide()
	if self:isShowing() then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	self.list:each(function(arg_22_0, arg_22_1)
		setActive(arg_22_1:Find("cnt"), false)
		setActive(arg_22_1:Find("selected"), false)

		return
	end)
	GuildShopPurchasePanel.super.Hide(self)

	return
end

function GuildShopPurchasePanel:OnDestroy()
	self:Hide()

	return
end

return GuildShopPurchasePanel
