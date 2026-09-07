local IslandRestaurantSettlePage = class("IslandRestaurantSettlePage", import("...base.IslandBasePage"))

function IslandRestaurantSettlePage:getUIName()
	return "IslandRestaurantSettleUI"
end

function IslandRestaurantSettlePage:OnLoaded()
	self.titleTF = self._tf:Find("title/name/Text")

	local var_2_0 = self._tf:Find("window/sale")

	setText(var_2_0:Find("title"), i18n("island_manage_sale_daily"))

	self.switchToggle = var_2_0:Find("switch")

	setText(self.switchToggle:Find("on/Text"), i18n("island_manage_fake_price"))
	setText(self.switchToggle:Find("off/Text"), i18n("island_manage_real_price"))

	self.saleUIList = UIItemList.New(var_2_0:Find("content"), var_2_0:Find("content/tpl"))

	local var_2_1 = self._tf:Find("window/remain")

	setText(var_2_1:Find("title"), i18n("island_manage_result_1"))

	self.remainUIList = UIItemList.New(var_2_1:Find("content"), var_2_1:Find("content/tpl"))

	local var_2_2 = self._tf:Find("window/summary")

	setText(var_2_2:Find("title/Text"), i18n("island_manage_result_3"))

	self.countTF = var_2_2:Find("count/info/value")

	setText(var_2_2:Find("count/info/name"), i18n("island_manage_word_cnt"))

	self.priceTF = var_2_2:Find("price/info/value")

	setText(var_2_2:Find("price/info/name"), i18n("island_manage_saleroom"))

	self.expSliderTF = var_2_2:Find("exp/info/slider")
	self.expProgressTF = var_2_2:Find("exp/info/slider/progress")

	setText(var_2_2:Find("exp/info/name"), i18n("island_manage_shop_exp"))
	setText(self._tf:Find("tip"), i18n("child_close_tip"))

	return
end

function IslandRestaurantSettlePage:OnInit()
	onButton(self, self._tf:Find("mask"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onToggle(self, self.switchToggle, function(arg_5_0)
		self.saleUIList:eachActive(function(arg_6_0, arg_6_1)
			setActive(arg_6_1:Find("price"), arg_5_0)

			return
		end)

		return
	end, SFX_PANEL)
	self.saleUIList:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			self:UpdateCommonItem(arg_7_2, self.saleList[arg_7_1 + 1])
			setText(arg_7_2:Find("price/Text"), self.saleList[arg_7_1 + 1].price)
		end

		return
	end)
	self.remainUIList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			self:UpdateCommonItem(arg_8_2, self.remainList[arg_8_1 + 1])
		end

		return
	end)

	self.maxAttrEffect = pg.island_chara_att[1].manage_effect / 16

	return
end

function IslandRestaurantSettlePage:OnShow(arg_9_1, arg_9_2)
	self:BlurPanel()

	self.callback = arg_9_2
	self.restId = arg_9_1.restId
	self.shipCnt = arg_9_1.oldShipCnt
	self.ships = {}

	local var_9_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.shipIds) do
		table.insert(self.ships, var_9_0:GetShipById(iter_9_1))
	end

	setText(self.titleTF, pg.island_manage_restaurant[self.restId].name)

	self.saleList = arg_9_1.saleList

	self.saleUIList:align(#self.saleList)

	self.remainList = arg_9_1.remainList

	self.remainUIList:align(#self.remainList)

	self.totalCnt, self.totalPrice = 0, 0

	for iter_9_2, iter_9_3 in ipairs(self.saleList) do
		self.totalCnt = self.totalCnt + iter_9_3.num
		self.totalPrice = self.totalPrice + iter_9_3.price
	end

	setText(self.countTF, self.totalCnt)
	setText(self.priceTF, self.totalPrice)

	local var_9_1 = getProxy(IslandProxy):GetIsland():GetManageAgency()
	local var_9_2 = var_9_1:GetRestaurant(self.restId)
	local var_9_3 = var_9_2:GetSales()
	local var_9_4 = var_9_2:GetCanUpgradeExp()

	setSlider(self.expSliderTF, 0, 1, var_9_1 == 0 and 0 or var_9_3 / var_9_4)
	setText(self.expProgressTF, var_9_3 .. "/" .. var_9_4)
	triggerToggle(self.switchToggle, false)

	return
end

function IslandRestaurantSettlePage:UpdateCommonItem(arg_10_1, arg_10_2)
	LoadImageSpriteAsync("island/" .. pg.island_item_data_template[arg_10_2.id].icon, arg_10_1:Find("bg/icon"))
	setText(arg_10_1:Find("count/Text"), arg_10_2.num)
	setFillAmount(arg_10_1:Find("bg/silder/bar"), (self:GetAttrsFactorsRatio(arg_10_2.id)))

	return
end

function IslandRestaurantSettlePage:OnHide()
	self:UnBlurPanel()
	existCall(self.callback)

	self.callback = nil

	return
end

function IslandRestaurantSettlePage:GetAttrsFactorsRatio(arg_12_1)
	return self.shipCnt * (self.maxAttrEffect + self.maxAttrEffect * (pg.island_item_data_template[arg_12_1].sub_attribute[2] / 100)) == 0 and 0 or (IslandRestaurantPage.CaclShipAttrFactors(self.ships, IslandShipAttr.MANAGE_KEY) + IslandRestaurantPage.CaclShipAttrFactors(self.ships, pg.island_item_data_template[arg_12_1].sub_attribute[1]) * (pg.island_item_data_template[arg_12_1].sub_attribute[2] / 100)) / (self.shipCnt * (self.maxAttrEffect + self.maxAttrEffect * (pg.island_item_data_template[arg_12_1].sub_attribute[2] / 100)))
end

function IslandRestaurantSettlePage:OnDestroy()
	self:UnBlurPanel()

	return
end

return IslandRestaurantSettlePage
