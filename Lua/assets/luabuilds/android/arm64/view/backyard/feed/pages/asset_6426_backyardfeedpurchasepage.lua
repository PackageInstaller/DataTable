local BackyardFeedPurchasePage = class("BackyardFeedPurchasePage", import("....base.BaseSubView"))

function BackyardFeedPurchasePage:getUIName()
	return "BackYardFeedShopPanel"
end

function BackyardFeedPurchasePage:OnLoaded()
	self.foodItem = self._tf:Find("frame")
	self.icon = self.foodItem:Find("icon_bg/icon")
	self.foodName = self._tf:Find("frame/name"):GetComponent(typeof(Text))
	self.foodDesc = self._tf:Find("frame/desc"):GetComponent(typeof(Text))
	self.calPanel = self._tf:Find("frame/cal_panel")
	self.cancelBtn = self._tf:Find("frame/cancel_btn")
	self.countValue = self.calPanel:Find("value/Text"):GetComponent(typeof(Text))
	self.total = self.calPanel:Find("total/Text"):GetComponent(typeof(Text))
	self.totalIcon = self.calPanel:Find("total/icon"):GetComponent(typeof(Image))
	self.minusBtn = self.calPanel:Find("minus_btn")
	self.addBtn = self.calPanel:Find("add_btn")
	self.tenBtn = self.calPanel:Find("ten_btn")
	self.confirmBtn = self._tf:Find("frame/ok_btn")
	self.cancelBtn = self._tf:Find("frame/cancel_btn")
	self.closetBtn = self._tf:Find("frame/close")
	self._parentTF = self._tf.parent

	setText(self.cancelBtn:Find("text"), i18n("word_cancel"))
	setText(self.confirmBtn:Find("text"), i18n("word_ok"))
	setText(self._tf:Find("frame/title"), i18n("words_information"))

	return
end

function BackyardFeedPurchasePage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.closetBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function BackyardFeedPurchasePage:Show(arg_7_1)
	BackyardFeedPurchasePage.super.Show(self)
	self:UpdateFood(arg_7_1)

	local var_7_0 = underscore.detect(getGameset("food_shop_id")[2], function(arg_8_0)
		return arg_8_0[1] == arg_7_1
	end)[2]
	local var_7_1 = pg.shop_template[var_7_0].resource_type
	local var_7_2 = pg.shop_template[var_7_0].resource_num
	local var_7_3 = 1

	self.total.text = pg.shop_template[var_7_0].resource_num * 1

	LoadSpriteAtlasAsync("props/" .. id2res(pg.shop_template[var_7_0].resource_type), "", function(arg_9_0)
		self.totalIcon.sprite = arg_9_0
		tf(self.totalIcon.gameObject).sizeDelta = Vector2(50, 50)

		return
	end)

	self.countValue.text = 1

	onButton(self, self.minusBtn, function()
		if var_7_3 <= 1 then
			return
		end

		var_7_3 = var_7_3 - 1
		self.countValue.text = var_7_3
		self.total.text = var_7_2 * var_7_3

		return
	end, SFX_PANEL)
	onButton(self, self.addBtn, function()
		if var_7_3 == 999 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_buyCountLimit", var_7_3))

			return
		end

		var_7_3 = var_7_3 > 999 and 999 or var_7_3 + 1
		self.countValue.text = var_7_3
		self.total.text = var_7_2 * var_7_3

		return
	end, SFX_PANEL)
	onButton(self, self.tenBtn, function()
		if var_7_3 == 999 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_buyCountLimit", var_7_3))

			return
		end

		var_7_3 = var_7_3 + 10 >= 999 and 999 or var_7_3 + 10
		self.countValue.text = var_7_3
		self.total.text = var_7_2 * var_7_3

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		self:Purchase({
			count = var_7_3,
			resourceType = var_7_1,
			resourceNum = var_7_2,
			shopId = var_7_0
		})

		return
	end, SFX_CONFIRM)

	return
end

function BackyardFeedPurchasePage:Purchase(arg_14_1)
	if getProxy(PlayerProxy):getRawData()[id2res(arg_14_1.resourceType)] < arg_14_1.resourceNum * arg_14_1.count then
		if arg_14_1.resourceType == 4 then
			GoShoppingMsgBox(i18n("switch_to_shop_tip_3", i18n("word_gem")), ChargeScene.TYPE_DIAMOND)
		elseif arg_14_1.resourceType == 2 and ItemTipPanel.ShowOilBuyTip(arg_14_1.resourceNum * arg_14_1.count) then
			-- block empty
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardGranaryLayer_error_noResource", (Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = arg_14_1.resourceType
			}):getName())))
		end

		self:Hide()

		return
	end

	self:emit(BackyardFeedMediator.BUY_FOOD, arg_14_1.shopId, arg_14_1.count)
	self:Hide()

	return
end

function BackyardFeedPurchasePage:UpdateFood(arg_15_1)
	local var_15_0 = Item.getConfigData(arg_15_1)
	local var_15_1 = {
		id = arg_15_1
	}

	var_15_1.cnt = getProxy(BagProxy):getItemCountById(arg_15_1)

	updateItem(self.foodItem, Item.New(var_15_1))

	self.foodName.text = var_15_0.name
	self.foodDesc.text = var_15_0.display

	return
end

function BackyardFeedPurchasePage:Hide()
	BackyardFeedPurchasePage.super.Hide(self)

	return
end

function BackyardFeedPurchasePage:OnDestroy()
	self:Hide()

	return
end

return BackyardFeedPurchasePage
