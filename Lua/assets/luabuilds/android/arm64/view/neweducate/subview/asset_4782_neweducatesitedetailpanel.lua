local NewEducateSiteDetailPanel = class("NewEducateSiteDetailPanel", import("...base.BaseSubView"))

function NewEducateSiteDetailPanel:getUIName()
	return "NewEducateSiteDetailPanel"
end

function NewEducateSiteDetailPanel:OnLoaded()
	self.rootTF = self._tf:Find("root")
	self.shopTF = self.rootTF:Find("shop")

	local var_2_0 = self.shopTF:Find("goods/content")

	self.goodsUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))
	self.shopRefreshTF = self.shopTF:Find("refresh")
	self.normalTF = self.rootTF:Find("normal")
	self.titleTF = self.normalTF:Find("title/Text")
	self.picTF = self.normalTF:Find("content/icon_bg/icon_mask/icon")
	self.nameTF = self.normalTF:Find("content/name")
	self.descTF = self.normalTF:Find("content/desc_view/mask/desc")
	self.enterTF = self.normalTF:Find("options/enter")

	setScrollText(self.normalTF:Find("options/exit/mask/Text"), i18n("child2_site_exit"))

	self.imageColorTFs = {
		self.normalTF:Find("title"),
		self.normalTF:Find("line"),
		self.normalTF:Find("content/azurlane"),
		self.normalTF:Find("content/name/Image")
	}

	return
end

function NewEducateSiteDetailPanel:OnInit()
	onButton(self, self.rootTF:Find("bg"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.shopTF:Find("close_btn"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.normalTF:Find("close_btn"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.normalTF:Find("options/exit"), function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.shopRefreshTF, function()
		self:emit(NewEducateMapMediator.ON_REFRESH_SHOP)

		return
	end, SFX_PANEL)
	self.goodsUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			self:UpdateGoodsItem(arg_9_1, arg_9_2)
		end

		return
	end)

	self.shopRefreshCost = pg.gameset.child2_shop_refresh_price.key_value
	self.shopRefreshSellCnt = pg.gameset.child2_shop_refresh_count.key_value

	return
end

function NewEducateSiteDetailPanel:Show(arg_10_1)
	NewEducateSiteDetailPanel.super.Show(self)

	self.siteId = arg_10_1

	self:Flush()

	return
end

function NewEducateSiteDetailPanel:Flush()
	if pg.child2_site_display[self.siteId].type == NewEducateConst.SITE_TYPE.SHOP then
		setText(self.shopTF:Find("title"), pg.child2_site_display[self.siteId].title)
		setText(self.shopRefreshTF:Find("cost/Text"), self.shopRefreshCost)
		self:ShowShop()
	else
		self:ShowNormal(pg.child2_site_display[self.siteId])
	end

	return
end

function NewEducateSiteDetailPanel:UpdateCost(arg_12_1, arg_12_2)
	LoadImageSpriteAsync("neweducateicon/" .. NewEducateHelper.GetDropConfig(arg_12_2).icon, arg_12_1:Find("Image"))
	setText(arg_12_1:Find("Text"), "-" .. arg_12_2.number)

	return
end

function NewEducateSiteDetailPanel:ShowNormal(arg_13_1)
	setActive(self.shopTF, false)
	setActive(self.normalTF, true)
	setText(self.titleTF, arg_13_1.title)
	LoadImageSpriteAsync("neweducateicon/" .. arg_13_1.banner, self.picTF, true)
	setText(self.nameTF, arg_13_1.title)
	setText(self.descTF, arg_13_1.desc)

	local var_13_0, var_13_1 = NewEducateHelper.GetSiteColors(arg_13_1.id)

	setTextColor(self.nameTF, var_13_1)
	underscore.each(self.imageColorTFs, function(arg_14_0)
		setImageColor(arg_14_0, var_13_0)

		return
	end)

	local var_13_2 = {}
	local var_13_3 = ""

	local function var_13_4()
		return
	end

	switch(arg_13_1.type, {
		[NewEducateConst.SITE_TYPE.WORK] = function()
			local var_16_0 = pg.child2_site_normal[self.contextData.char:GetNormalIdByType(NewEducateConst.SITE_NORMAL_TYPE.WORK)]

			var_13_3 = var_16_0.title
			var_13_2 = NewEducateHelper.Config2Drop(var_16_0.cost)

			function var_13_4()
				self:emit(NewEducateMapMediator.ON_SITE_NORMAL, var_16_0.id)

				return
			end

			return
		end,
		[NewEducateConst.SITE_TYPE.TRAVEL] = function()
			local var_18_0 = pg.child2_site_normal[self.contextData.char:GetNormalIdByType(NewEducateConst.SITE_NORMAL_TYPE.TRAVEL)]

			var_13_3 = var_18_0.title
			var_13_2 = NewEducateHelper.Config2Drop(var_18_0.cost)

			function var_13_4()
				self:emit(NewEducateMapMediator.ON_SITE_NORMAL, var_18_0.id)

				return
			end

			return
		end,
		[NewEducateConst.SITE_TYPE.SHIP] = function()
			local var_20_0 = pg.child2_site_character[arg_13_1.param]

			var_13_3 = pg.child2_site_character[arg_13_1.param].option_name
			var_13_2 = NewEducateHelper.Config2Drop(pg.child2_site_character[arg_13_1.param].cost)

			function var_13_4()
				self:emit(NewEducateMapMediator.ON_SITE_SHIP, var_20_0.id)

				return
			end

			return
		end,
		[NewEducateConst.SITE_TYPE.EVENT] = function()
			local var_22_0 = pg.child2_site_event_group[arg_13_1.param]

			var_13_3 = pg.child2_site_event_group[arg_13_1.param].option_word
			var_13_2 = NewEducateHelper.Config2Drop(pg.child2_site_event_group[arg_13_1.param].event_cost)

			function var_13_4()
				self:emit(NewEducateMapMediator.ON_SITE_EVENT, var_22_0.id)

				return
			end

			return
		end
	})
	setScrollText(self.enterTF:Find("mask/Text"), "")
	self:UpdateCost(self.enterTF:Find("cost"), var_13_2)

	var_13_2.operator = ">="

	local var_13_5 = not self.contextData.char:IsMatch(var_13_2)

	setImageColor(self.enterTF, Color.NewHex(var_13_5 and "C8CAD5" or "FFFFFF"))
	setTextColor(self.enterTF:Find("mask/Text"), Color.NewHex(var_13_5 and "717171" or "393A3C"))

	if not var_13_5 then
		onButton(self, self.enterTF, function()
			var_13_4()
			self:Hide(true)

			return
		end, SFX_PANEL)
	else
		removeOnButton(self.enterTF)
	end

	return
end

function NewEducateSiteDetailPanel:ShowShop()
	self.discountInfos = self.contextData.char:GetGoodsDiscountInfos()

	local var_25_0 = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP)

	self.goods = var_25_0:GetGoodList()

	table.sort(self.goods, CompareFuncs({
		function(arg_26_0)
			return arg_26_0:GetRemainCnt() > 0 and 0 or 1
		end,
		function(arg_27_0)
			return arg_27_0:IsLimitCnt() and 0 or 1
		end,
		function(arg_28_0)
			return arg_28_0.id
		end
	}))
	setActive(self.shopTF, true)
	setActive(self.normalTF, false)
	self.goodsUIList:align(#self.goods)
	self:UpdateShopRefreshInfos(var_25_0:GetRefreshShopCnt())

	return
end

function NewEducateSiteDetailPanel:UpdateShopRefreshInfos(arg_29_1)
	local var_29_0 = self.contextData.char:GetResByType(NewEducateChar.RES_TYPE.REFRESH_SHOP)

	setText(self.shopRefreshTF:Find("Text"), var_29_0)
	setActive(self.shopRefreshTF, var_29_0 > 0 or arg_29_1 < self.shopRefreshSellCnt)
	setActive(self.shopRefreshTF:Find("Text"), var_29_0 > 0)
	setActive(self.shopRefreshTF:Find("cost"), var_29_0 <= 0 and arg_29_1 < self.shopRefreshSellCnt)

	return
end

function NewEducateSiteDetailPanel:UpdateGoodsItem(arg_30_1, arg_30_2)
	local var_30_0 = self.goods[arg_30_1 + 1]

	arg_30_2.name = self.goods[arg_30_1 + 1].id

	LoadImageSpriteAsync("neweducateicon/" .. var_30_0:getConfig("icon"), arg_30_2:Find("frame/icon"))
	setText(arg_30_2:Find("name"), var_30_0:getConfig("name"))
	setText(arg_30_2:Find("frame/count_bg/count"), "x" .. var_30_0:getConfig("goods_num"))
	setText(arg_30_2:Find("desc"), var_30_0:getConfig("desc"))
	setActive(arg_30_2:Find("limit_time"), var_30_0:IsLimitTime())
	setActive(arg_30_2:Find("limit_cnt"), var_30_0:IsLimitCnt())

	if var_30_0:IsLimitCnt() then
		setText(arg_30_2:Find("limit_cnt"), i18n("child2_shop_limit_cnt") .. var_30_0:GetRemainCnt() .. "/" .. var_30_0:GetLimitCnt())
	end

	local var_30_1 = var_30_0:GetRemainCnt() <= 0

	setActive(arg_30_2:Find("sold_out"), var_30_1)

	local var_30_2 = var_30_0:GetCostCondition()
	local var_30_3 = var_30_0:GetCostWithBenefit(self.discountInfos)

	setText(arg_30_2:Find("price"), var_30_2.number .. ((var_30_3.number ~= var_30_2.number or nil) and ("(" .. var_30_3.number .. ")" or "")))

	if var_30_1 then
		removeOnButton(arg_30_2)
	else
		onButton(self, arg_30_2, function()
			self:emit(NewEducateBaseUI.ON_SHOP, {
				shopId = var_30_0.id,
				price = var_30_3.number,
				onBuy = function()
					self:OnClickBuy(var_30_0)

					return
				end
			})

			return
		end, SFX_PANEL)
	end

	return
end

function NewEducateSiteDetailPanel:SendBuyProto(arg_33_1)
	self:emit(NewEducateMapMediator.ON_SHOPPING, arg_33_1.id)

	return
end

function NewEducateSiteDetailPanel:OnClickBuy(arg_34_1)
	local var_34_0 = arg_34_1:getConfig("goods_type")

	if var_34_0 == NewEducateGoods.TYPE.BENEFIT then
		self:ClickBenefitGood(arg_34_1)
	elseif var_34_0 == NewEducateGoods.TYPE.RES then
		self:ClickResGood(arg_34_1)
	elseif var_34_0 == NewEducateGoods.TYPE.UP_ENTRY then
		existCall(self.contextData.onClickUpEntryGood, arg_34_1)
	else
		self:SendBuyProto(arg_34_1)
	end

	return
end

function NewEducateSiteDetailPanel:ClickBenefitGood(arg_35_1)
	local var_35_0 = {}
	local var_35_1 = arg_35_1:getConfig("goods_id")
	local var_35_2 = self.contextData.char:GetStatus(arg_35_1:getConfig("goods_id"))

	if var_35_2 and var_35_2:getConfig("is_tip") == 0 then
		local var_35_3 = var_35_2:GetEndRound() - self.contextData.char:GetRoundData().round
		local var_35_4 = var_35_2:getConfig("during_time") == -1 and "child2_shop_benefit_sure2" or "child2_shop_benefit_sure"

		table.insert(var_35_0, function(arg_36_0)
			self:emit(NewEducateBaseUI.ON_BOX, {
				content = i18n(var_35_4, var_35_3),
				onYes = arg_36_0
			})

			return
		end)
	end

	seriesAsync(var_35_0, function()
		self:SendBuyProto(arg_35_1)

		return
	end)

	return
end

function NewEducateSiteDetailPanel:ClickResGood(arg_38_1)
	local var_38_0 = {}
	local var_38_1 = self.contextData.char:GetResIdByType(NewEducateChar.RES_TYPE.ACTION)

	if arg_38_1:getConfig("goods_id") == var_38_1 and self.contextData.char:GetPoint(var_38_1) + arg_38_1:getConfig("goods_num") > pg.child2_resource[var_38_1].max_value then
		table.insert(var_38_0, function(arg_39_0)
			self:emit(NewEducateBaseUI.ON_BOX, {
				content = i18n("child2_shop_point_sure"),
				onYes = arg_39_0
			})

			return
		end)
	end

	seriesAsync(var_38_0, function()
		self:SendBuyProto(arg_38_1)

		return
	end)

	return
end

function NewEducateSiteDetailPanel:FlushShop()
	self:ShowShop()

	return
end

function NewEducateSiteDetailPanel:Hide(arg_42_1)
	if not arg_42_1 then
		existCall(self.contextData.onHide)
	end

	self.super.Hide(self)

	return
end

function NewEducateSiteDetailPanel:OnDestroy()
	return
end

return NewEducateSiteDetailPanel
