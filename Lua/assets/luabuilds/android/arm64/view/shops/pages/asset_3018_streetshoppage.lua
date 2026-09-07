local StreetShopPage = class("StreetShopPage", import(".BaseShopPage"))

function StreetShopPage:GenTip(arg_1_1)
	local var_1_0 = ""

	if #arg_1_1 == 1 then
		var_1_0 = i18n("shop_street_activity_tip", arg_1_1[1]:GetShopTime())
	elseif #arg_1_1 > 1 then
		var_1_0 = self:GenTipForMultiAct(arg_1_1)
	end

	return var_1_0
end

function StreetShopPage:GenTipForMultiAct(arg_2_1)
	local var_2_0 = arg_2_1[1]:getStartTime()
	local var_2_1 = arg_2_1[1].stopTime
	local var_2_2 = _.all(arg_2_1, function(arg_4_0)
		return arg_4_0.stopTime == var_2_1
	end)
	local var_2_3 = arg_2_1[1]

	if not var_2_2 then
		table.sort(arg_2_1, function(arg_5_0, arg_5_1)
			return arg_5_0.stopTime < arg_5_1.stopTime
		end)

		var_2_3 = arg_2_1[1]
	elseif not _.all(arg_2_1, function(arg_3_0)
		return arg_3_0:getStartTime() == var_2_0
	end) and var_2_2 then
		table.sort(arg_2_1, function(arg_6_0, arg_6_1)
			return arg_6_0:getStartTime() < arg_6_1:getStartTime()
		end)

		var_2_3 = arg_2_1[1]
	end

	return i18n("shop_street_activity_tip", var_2_3:GetShopTime())
end

function StreetShopPage:GenHelpContent(arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs((arg_7_2:getConfig("config_data"))) do
		table.insert(arg_7_1, i18n("shop_street_Equipment_skin_box_help", Item.getConfigData(pg.shop_template[iter_7_1[1]].effect_args[1]).name, (arg_7_2:GetShopTime())))
	end

	return
end

function StreetShopPage:OnUpdatePlayer()
	self:RefreshResItemList()

	return
end

function StreetShopPage:GetResDataList()
	local var_9_0 = {}

	table.insert(var_9_0, {
		type = DROP_TYPE_RESOURCE,
		resID = PlayerConst.ResGold,
		cnt = self.player:getResource(PlayerConst.ResGold)
	})

	return var_9_0
end

function StreetShopPage:OnSetUp()
	self:RemoveTimer()
	self:AddTimer()

	return
end

function StreetShopPage:Hide()
	StreetShopPage.super.Hide(self)
	self:RemoveTimer()

	return
end

function StreetShopPage:OnUpdateAll()
	self:InitCommodities()
	self:OnSetUp()

	return
end

function StreetShopPage:OnUpdateCommodity(arg_13_1)
	local var_13_0

	for iter_13_0, iter_13_1 in pairs(self.cards) do
		if iter_13_1.goodsVO.id == arg_13_1.id then
			var_13_0 = iter_13_1
		end
	end

	if var_13_0 then
		var_13_0:update(arg_13_1)
	end

	return
end

function StreetShopPage:RefreshUI()
	local var_14_0 = _.select(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP_STREET), function(arg_15_0)
		return arg_15_0 and not arg_15_0:isEnd()
	end)

	setActive(self.tipTextGo, #var_14_0 > 0)

	self.tipText.text = self:GenTip(var_14_0)

	setActive(self.helpBtn, #var_14_0 > 1)

	self.activitys = var_14_0

	setActive(self.helpBtn, false)
	setActive(self.resolveBtn, false)
	setActive(self.refreshBtn, true)
	onButton(self, self.helpBtn, function()
		local var_16_0 = {}

		table.sort(self.activitys, function(arg_17_0, arg_17_1)
			return arg_17_0:getStartTime() < arg_17_1:getStartTime()
		end)
		_.each(self.activitys, function(arg_18_0)
			self:GenHelpContent(var_16_0, arg_18_0)

			return
		end)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = table.concat(var_16_0, "\n\n")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.refreshBtn, function()
		local var_19_0 = ShoppingStreet.getRiseShopId(ShopArgs.ShoppingStreetUpgrade, self.shop.flashCount)
		local var_19_1

		if not var_19_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("shopStreet_refresh_max_count"))

			do return end

			var_19_1 = {
				yesText = "text_confirm",
				hideNo = false,
				noText = "text_cancel"
			}
		end

		var_19_1.content = i18n("refresh_shopStreet_question", i18n("word_" .. id2res(pg.shop_template[var_19_0].resource_type) .. "_icon"), pg.shop_template[var_19_0].resource_num, self.shop.flashCount)

		function var_19_1.onYes()
			self:emit(NewShopMainMediator.REFRESH_STREET_SHOP, var_19_0)

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox(var_19_1)

		return
	end, SFX_PANEL)
	setButtonEnabled(self.refreshBtn, true)

	return
end

function StreetShopPage:OnInitItem(arg_21_1)
	local var_21_0 = GoodsCard.New(arg_21_1)

	onButton(self, var_21_0.go, function()
		local var_22_0 = var_21_0.goodsVO

		if not var_21_0.goodsVO:canPurchase() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_exchange",
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = {
				id = var_21_0.goodsVO:getConfig("effect_args")[1],
				type = var_21_0.goodsVO:getConfig("type"),
				count = var_21_0.goodsVO:getConfig("num")
			},
			onYes = function()
				self:Purchase(var_22_0)

				return
			end
		})

		return
	end, SFX_PANEL)

	self.cards[arg_21_1] = var_21_0

	return
end

function StreetShopPage:OnUpdateItem(arg_24_1, arg_24_2)
	if not self.cards[arg_24_2] then
		self:OnInitItem(arg_24_2)
	end

	self.cards[arg_24_2]:update(self.displays[arg_24_1 + 1])

	return
end

function StreetShopPage:Purchase(arg_25_1)
	local var_25_0 = arg_25_1:getConfig("resource_type")

	if var_25_0 == 4 or var_25_0 == 14 then
		local var_25_1 = self.player:getResById(var_25_0)

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("charge_scene_buy_confirm", arg_25_1:getConfig("resource_num") * (arg_25_1.discount / 100), Item.New({
				id = arg_25_1:getConfig("effect_args")[1]
			}):getConfig("name")),
			onYes = function()
				self:emit(NewShopMainMediator.BUY_ITEM, arg_25_1.id, 1)

				return
			end
		})
	else
		self:emit(NewShopMainMediator.BUY_ITEM, arg_25_1.id, 1)
	end

	return
end

function StreetShopPage:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function StreetShopPage:AddTimer()
	local var_28_0 = self.shop

	self.timer = Timer.New(function()
		if var_28_0:isUpdateGoods() then
			self:RemoveTimer()
			self:emit(NewShopMainMediator.REFRESH_STREET_SHOP)
		else
			self.timerText.text = i18n("shop_refresh_time", pg.TimeMgr.GetInstance():DescCDTime(var_28_0.nextFlashTime - pg.TimeMgr.GetInstance():GetServerTime()))
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function StreetShopPage:OnDestroy()
	self:RemoveTimer()
	StreetShopPage.super.OnDestroy(self)

	return
end

return StreetShopPage
