local ActivityShopPage = class("ActivityShopPage", import(".BaseShopPage"))

function ActivityShopPage:Ctor(arg_1_1, arg_1_2)
	ActivityShopPage.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function ActivityShopPage:getBGM()
	return string.format("ActivityShop%s", self.shop.activityId)
end

function ActivityShopPage:GetPaintingName()
	assert(self.shop)

	if pg.activity_template[self.shop.activityId] and pg.activity_template[self.shop.activityId].config_client then
		if pg.activity_template[self.shop.activityId].config_client.use_secretary or getProxy(ActivityProxy):checkHxActivity(self.shop.activityId) then
			local var_3_0 = getProxy(PlayerProxy)
			local var_3_1 = getProxy(SettingsProxy):getCurrentSecretaryIndex()

			self.tempFlagShip = getProxy(BayProxy):getShipById(var_3_0:getData().characters[1])

			return self.tempFlagShip:getPainting(), true, "build"
		elseif pg.activity_template[self.shop.activityId].config_client.painting then
			return pg.activity_template[self.shop.activityId].config_client.painting, true
		end
	end

	return "aijiang_pt"
end

function ActivityShopPage:GetBg(arg_4_1)
	return (arg_4_1:getBgPath())
end

function ActivityShopPage:GetPaintingEnterVoice()
	local var_5_0, var_5_1, var_5_2 = self.shop:GetEnterVoice()

	return var_5_1, var_5_0, var_5_2
end

function ActivityShopPage:GetPaintingCommodityUpdateVoice()
	local var_6_0, var_6_1, var_6_2 = self.shop:GetPurchaseVoice()

	return var_6_1, var_6_0, var_6_2
end

function ActivityShopPage:GetPaintingAllPurchaseVoice()
	local var_7_0, var_7_1, var_7_2 = self.shop:GetPurchaseAllVoice()

	return var_7_1, var_7_0, var_7_2
end

function ActivityShopPage:GetPaintingTouchVoice()
	local var_8_0, var_8_1, var_8_2 = self.shop:GetTouchVoice()

	return var_8_1, var_8_0, var_8_2
end

function ActivityShopPage:init()
	ActivityShopPage.super.init(self)

	self.scrollRectSpecial = self._tf:Find("scrollRectSpecial")
	self.groupList = UIItemList.New(self.scrollRectSpecial:Find("viewport/view"), self.scrollRectSpecial:Find("viewport/view/group"))

	return
end

function ActivityShopPage:OnInit()
	return
end

function ActivityShopPage:OnUpdatePlayer()
	self:RefreshResItemList()

	return
end

function ActivityShopPage:GetResDataList()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs((self.shop:GetResList())) do
		table.insert(var_12_0, {
			type = DROP_TYPE_RESOURCE,
			resID = iter_12_1,
			cnt = self.player:getResource(iter_12_1)
		})
	end

	return var_12_0
end

function ActivityShopPage:OnSetUp()
	self:SetResIcon()
	self:UpdateTip()

	return
end

function ActivityShopPage:OnUpdateAll()
	self:InitCommodities()

	return
end

function ActivityShopPage:OnUpdateCommodity(arg_15_1)
	local var_15_0

	for iter_15_0, iter_15_1 in pairs(self.cards) do
		if iter_15_1.goodsVO.id == arg_15_1.id then
			var_15_0 = iter_15_1

			break
		end
	end

	if var_15_0 then
		local var_15_1, var_15_2, var_15_3 = self.shop:getBgPath()

		var_15_0:update(arg_15_1, nil, var_15_2, var_15_3)
	end

	return
end

function ActivityShopPage:SetResIcon(arg_16_1)
	self:RefreshResItemList()

	return
end

function ActivityShopPage:RefreshUI()
	setActive(self.tipTextGo, true)
	setActive(self.helpBtn, false)
	setActive(self.resolveBtn, false)
	setActive(self.refreshBtn, false)

	return
end

function ActivityShopPage:UpdateTip()
	self.tipText.text = "<size=" .. (#self.shop:GetResList() > 1 and 25 or 27) .. ">" .. i18n("activity_shop_lable", self.shop:getOpenTime()) .. "</size>"

	return
end

function ActivityShopPage:OnInitItem(arg_19_1)
	local var_19_0 = ActivityGoodsCard.New(arg_19_1)

	onButton(self, var_19_0.tf, function()
		self:OnClickCommodity(var_19_0.goodsVO, function(arg_21_0, arg_21_1)
			self:OnPurchase(arg_21_0, arg_21_1)

			return
		end)

		return
	end, SFX_PANEL)

	self.cards[arg_19_1] = var_19_0

	return
end

function ActivityShopPage:OnUpdateItem(arg_22_1, arg_22_2)
	local var_22_0 = self.cards[arg_22_2]

	if not self.cards[arg_22_2] then
		self:OnInitItem(arg_22_2)

		var_22_0 = self.cards[arg_22_2]
	end

	local var_22_1 = self.displays[arg_22_1 + 1]
	local var_22_2, var_22_3, var_22_4 = self.shop:getBgPath()

	var_22_0:update(var_22_1, nil, var_22_3, var_22_4)

	return
end

function ActivityShopPage:TipPurchase(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0, var_23_1 = arg_23_1:GetTranCntWhenFull(arg_23_2)

	if var_23_0 > 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("pt_shop_tran_tip", math.max(arg_23_2 - var_23_0, 0), arg_23_3, var_23_0 * var_23_1.count, var_23_1:getConfig("name")),
			onYes = arg_23_4
		})
	else
		arg_23_4()
	end

	return
end

function ActivityShopPage:OnPurchase(arg_24_1, arg_24_2)
	if arg_24_1:getConfig("commodity_type") == DROP_TYPE_ITEM then
		local var_24_0 = getProxy(BagProxy):RawGetItemById((arg_24_1:getConfig("commodity_id")))

		if var_24_0 and var_24_0:IsShipExpType() and var_24_0:IsMaxCnt() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("item_is_max_cnt"))

			return
		end
	end

	self:emit(NewShopMainMediator.ON_ACT_SHOPPING, self.shop.activityId, 1, arg_24_1.id, arg_24_2)

	return
end

function ActivityShopPage:OnClickCommodity(arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1:CheckCntLimit()

	if not var_25_0 then
		return
	end

	if var_25_0 and not arg_25_1:CheckArgLimit() then
		local var_25_1, var_25_2, var_25_3, var_25_4 = arg_25_1:CheckArgLimit()

		if var_25_2 == ShopArgs.LIMIT_ARGS_META_SHIP_EXISTENCE then
			pg.TipsMgr.GetInstance():ShowTips(i18n("meta_shop_exchange_limit_tip", (ShipGroup.getDefaultShipConfig(var_25_4) or {}).name or ""))
		elseif var_25_2 == ShopArgs.LIMIT_ARGS_SALE_START_TIME then
			local var_25_6 = {
				year = var_25_4[1][1],
				month = var_25_4[1][2],
				day = var_25_4[1][3],
				hour = var_25_4[2][1],
				min = var_25_4[2][2],
				sec = var_25_4[2][3]
			}

			pg.TipsMgr.GetInstance():ShowTips(i18n("meta_shop_exchange_limit_2_tip", var_25_6.year, var_25_6.month, var_25_6.day, var_25_6.hour, var_25_6.min, var_25_6.sec))
		end

		return
	end

	ActivityShopPage.super.OnClickCommodity(self, arg_25_1, arg_25_2)

	return
end

function ActivityShopPage:Show()
	if pg.activity_template[self.shop.activityId] and pg.activity_template[self.shop.activityId].config_client and pg.activity_template[self.shop.activityId].config_client.category then
		setActive(go(self.lScrollrect), false)
		setActive(self.scrollRectSpecial, true)
		self.groupList:make(function(arg_27_0, arg_27_1, arg_27_2)
			if arg_27_0 == UIItemList.EventUpdate then
				local var_27_0 = self.splitCommodities[arg_27_1 + 1]

				setText(arg_27_2:Find("title/name"), i18n(self.spiltNameCodes[arg_27_1 + 1]))

				local var_27_1 = UIItemList.New(arg_27_2:Find("items"), arg_27_2:Find("items/ActivityShopNewTpl"))

				var_27_1:make(function(arg_28_0, arg_28_1, arg_28_2)
					if arg_28_0 == UIItemList.EventUpdate then
						local var_28_0 = ActivityGoodsCard.New(arg_28_2)

						self.cards[arg_28_2] = var_28_0

						onButton(self, var_28_0.tf, function()
							self:OnClickCommodity(var_28_0.goodsVO, function(arg_30_0, arg_30_1)
								self:OnPurchase(arg_30_0, arg_30_1)

								return
							end)

							return
						end, SFX_PANEL)

						local var_28_1, var_28_2, var_28_3 = self.shop:getBgPath()

						var_28_0:update(var_27_0[arg_28_1 + 1], nil, var_28_2, var_28_3)
					end

					return
				end)
				var_27_1:align(#self.splitCommodities[arg_27_1 + 1])
			end

			return
		end)
		self.groupList:align(#self.splitCommodities)

		self.canvasGroup.alpha = 1
		self.canvasGroup.blocksRaycasts = true
	else
		setActive(go(self.lScrollrect), true)

		if self.scrollRectSpecial then
			setActive(self.scrollRectSpecial, false)
		end

		ActivityShopPage.super.Show(self)
	end

	if self.shop:GetBGM() ~= "" then
		pg.BgmMgr.GetInstance():Push(self.__cname, self.shop:GetBGM())
	end

	return
end

function ActivityShopPage:Hide()
	if pg.activity_template[self.shop.activityId] and pg.activity_template[self.shop.activityId].config_client and pg.activity_template[self.shop.activityId].config_client.category then
		for iter_31_0, iter_31_1 in pairs(self.cards) do
			iter_31_1:Dispose()
		end

		self.splitCommodities = {}
		self.spiltNameCodes = {}
		self.cards = {}
		self.canvasGroup.alpha = 0
		self.canvasGroup.blocksRaycasts = false
	else
		ActivityShopPage.super.Hide(self)
	end

	setActive(go(self.lScrollrect), true)

	if self.scrollRectSpecial then
		setActive(self.scrollRectSpecial, false)
	end

	if self.shop:GetBGM() ~= "" then
		pg.BgmMgr.GetInstance():Pop(self.__cname)
	end

	return
end

function ActivityShopPage:SetUp(arg_32_1, arg_32_2, arg_32_3)
	self:SetShop(arg_32_1)
	self:InitCommodities()

	self.cards = {}

	self:Show()
	self:SetPlayer(arg_32_2)
	self:SetItems(arg_32_3)
	self:InitCommodities()
	self:OnSetUp()
	self:SetPainting()
	self:RefreshUI()

	return
end

function ActivityShopPage:InitCommodities()
	if pg.activity_template[self.shop.activityId] and pg.activity_template[self.shop.activityId].config_client and pg.activity_template[self.shop.activityId].config_client.category then
		self.splitCommodities = self.shop:GetSplitCommodities()
		self.spiltNameCodes = self.shop:GetSplitNameCodes()

		self.groupList:align(#self.splitCommodities)
	else
		ActivityShopPage.super.InitCommodities(self)
	end

	return
end

return ActivityShopPage
