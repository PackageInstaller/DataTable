local var_0_0 = class("NewEducateSiteDetailPanel", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateSiteDetailPanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.rootTF = arg_2_0._tf:Find("root")
	arg_2_0.shopTF = arg_2_0.rootTF:Find("shop")

	local var_2_0 = arg_2_0.shopTF:Find("goods/content")

	arg_2_0.goodsUIList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))
	arg_2_0.shopRefreshTF = arg_2_0.shopTF:Find("refresh")
	arg_2_0.normalTF = arg_2_0.rootTF:Find("normal")
	arg_2_0.titleTF = arg_2_0.normalTF:Find("title/Text")
	arg_2_0.picTF = arg_2_0.normalTF:Find("content/icon_bg/icon_mask/icon")
	arg_2_0.nameTF = arg_2_0.normalTF:Find("content/name")
	arg_2_0.descTF = arg_2_0.normalTF:Find("content/desc_view/mask/desc")
	arg_2_0.enterTF = arg_2_0.normalTF:Find("options/enter")

	setScrollText(arg_2_0.normalTF:Find("options/exit/mask/Text"), i18n("child2_site_exit"))

	arg_2_0.imageColorTFs = {
		arg_2_0.normalTF:Find("title"),
		arg_2_0.normalTF:Find("line"),
		arg_2_0.normalTF:Find("content/azurlane"),
		arg_2_0.normalTF:Find("content/name/Image")
	}

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.rootTF:Find("bg"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.shopTF:Find("close_btn"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.normalTF:Find("close_btn"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.normalTF:Find("options/exit"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.shopRefreshTF, function()
		arg_3_0:emit(NewEducateMapMediator.ON_REFRESH_SHOP)

		return
	end, SFX_PANEL)
	arg_3_0.goodsUIList:make(function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateGoodsItem(arg_9_1, arg_9_2)
		end

		return
	end)

	arg_3_0.shopRefreshCost = pg.gameset.child2_shop_refresh_price.key_value
	arg_3_0.shopRefreshSellCnt = pg.gameset.child2_shop_refresh_count.key_value

	return
end

function var_0_0.Show(arg_10_0, arg_10_1)
	var_0_0.super.Show(arg_10_0)

	arg_10_0.siteId = arg_10_1

	arg_10_0:Flush()

	return
end

function var_0_0.Flush(arg_11_0)
	if pg.child2_site_display[arg_11_0.siteId].type == NewEducateConst.SITE_TYPE.SHOP then
		setText(arg_11_0.shopTF:Find("title"), pg.child2_site_display[arg_11_0.siteId].title)
		setText(arg_11_0.shopRefreshTF:Find("cost/Text"), arg_11_0.shopRefreshCost)
		arg_11_0:ShowShop()
	else
		arg_11_0:ShowNormal(pg.child2_site_display[arg_11_0.siteId])
	end

	return
end

function var_0_0.UpdateCost(arg_12_0, arg_12_1, arg_12_2)
	LoadImageSpriteAsync("neweducateicon/" .. NewEducateHelper.GetDropConfig(arg_12_2).icon, arg_12_1:Find("Image"))
	setText(arg_12_1:Find("Text"), "-" .. arg_12_2.number)

	return
end

function var_0_0.ShowNormal(arg_13_0, arg_13_1)
	setActive(arg_13_0.shopTF, false)
	setActive(arg_13_0.normalTF, true)
	setText(arg_13_0.titleTF, arg_13_1.title)
	LoadImageSpriteAsync("neweducateicon/" .. arg_13_1.banner, arg_13_0.picTF, true)
	setText(arg_13_0.nameTF, arg_13_1.title)
	setText(arg_13_0.descTF, arg_13_1.desc)

	local var_13_0, var_13_1 = NewEducateHelper.GetSiteColors(arg_13_1.id)

	setTextColor(arg_13_0.nameTF, var_13_1)
	underscore.each(arg_13_0.imageColorTFs, function(arg_14_0)
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
			local var_16_0 = pg.child2_site_normal[arg_13_0.contextData.char:GetNormalIdByType(NewEducateConst.SITE_NORMAL_TYPE.WORK)]

			var_13_3 = var_16_0.title
			var_13_2 = NewEducateHelper.Config2Drop(var_16_0.cost)

			function var_13_4()
				arg_13_0:emit(NewEducateMapMediator.ON_SITE_NORMAL, var_16_0.id)

				return
			end

			return
		end,
		[NewEducateConst.SITE_TYPE.TRAVEL] = function()
			local var_18_0 = pg.child2_site_normal[arg_13_0.contextData.char:GetNormalIdByType(NewEducateConst.SITE_NORMAL_TYPE.TRAVEL)]

			var_13_3 = var_18_0.title
			var_13_2 = NewEducateHelper.Config2Drop(var_18_0.cost)

			function var_13_4()
				arg_13_0:emit(NewEducateMapMediator.ON_SITE_NORMAL, var_18_0.id)

				return
			end

			return
		end,
		[NewEducateConst.SITE_TYPE.SHIP] = function()
			local var_20_0 = pg.child2_site_character[arg_13_1.param]

			var_13_3 = pg.child2_site_character[arg_13_1.param].option_name
			var_13_2 = NewEducateHelper.Config2Drop(pg.child2_site_character[arg_13_1.param].cost)

			function var_13_4()
				arg_13_0:emit(NewEducateMapMediator.ON_SITE_SHIP, var_20_0.id)

				return
			end

			return
		end,
		[NewEducateConst.SITE_TYPE.EVENT] = function()
			local var_22_0 = pg.child2_site_event_group[arg_13_1.param]

			var_13_3 = pg.child2_site_event_group[arg_13_1.param].option_word
			var_13_2 = NewEducateHelper.Config2Drop(pg.child2_site_event_group[arg_13_1.param].event_cost)

			function var_13_4()
				arg_13_0:emit(NewEducateMapMediator.ON_SITE_EVENT, var_22_0.id)

				return
			end

			return
		end
	})
	setScrollText(arg_13_0.enterTF:Find("mask/Text"), "")
	arg_13_0:UpdateCost(arg_13_0.enterTF:Find("cost"), {})

	;({}).operator = ">="

	local var_13_5 = not arg_13_0.contextData.char:IsMatch({})

	setImageColor(arg_13_0.enterTF, Color.NewHex(var_13_5 and "C8CAD5" or "FFFFFF"))
	setTextColor(arg_13_0.enterTF:Find("mask/Text"), Color.NewHex(var_13_5 and "717171" or "393A3C"))

	if not var_13_5 then
		onButton(arg_13_0, arg_13_0.enterTF, function()
			var_13_4()
			arg_13_0:Hide(true)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_13_0.enterTF)
	end

	return
end

function var_0_0.ShowShop(arg_25_0)
	arg_25_0.discountInfos = arg_25_0.contextData.char:GetGoodsDiscountInfos()

	local var_25_0 = arg_25_0.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.MAP)

	arg_25_0.goods = var_25_0:GetGoodList()

	table.sort(arg_25_0.goods, CompareFuncs({
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
	setActive(arg_25_0.shopTF, true)
	setActive(arg_25_0.normalTF, false)
	arg_25_0.goodsUIList:align(#arg_25_0.goods)
	arg_25_0:UpdateShopRefreshInfos(var_25_0:GetRefreshShopCnt())

	return
end

function var_0_0.UpdateShopRefreshInfos(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.contextData.char:GetResByType(NewEducateChar.RES_TYPE.REFRESH_SHOP)

	setText(arg_29_0.shopRefreshTF:Find("Text"), var_29_0)
	setActive(arg_29_0.shopRefreshTF, var_29_0 > 0 or arg_29_1 < arg_29_0.shopRefreshSellCnt)
	setActive(arg_29_0.shopRefreshTF:Find("Text"), var_29_0 > 0)
	setActive(arg_29_0.shopRefreshTF:Find("cost"), var_29_0 <= 0 and arg_29_1 < arg_29_0.shopRefreshSellCnt)

	return
end

function var_0_0.UpdateGoodsItem(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.goods[arg_30_1 + 1]

	arg_30_2.name = arg_30_0.goods[arg_30_1 + 1].id

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
	local var_30_3 = var_30_0:GetCostWithBenefit(arg_30_0.discountInfos)

	if var_30_3.number ~= var_30_2.number then
		local var_30_4 = "(" .. var_30_3.number .. ")" or ""

		setText(arg_30_2:Find("price"), var_30_2.number .. var_30_4)

		if var_30_1 then
			removeOnButton(arg_30_2)
		else
			onButton(arg_30_0, arg_30_2, function()
				arg_30_0:emit(NewEducateBaseUI.ON_SHOP, {
					shopId = var_30_0.id,
					price = var_30_3.number,
					onBuy = function()
						arg_30_0:OnClickBuy(var_30_0)

						return
					end
				})

				return
			end, SFX_PANEL)
		end

		return
	end
end

function var_0_0.SendBuyProto(arg_33_0, arg_33_1)
	arg_33_0:emit(NewEducateMapMediator.ON_SHOPPING, arg_33_1.id)

	return
end

function var_0_0.OnClickBuy(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:getConfig("goods_type")

	if var_34_0 == NewEducateGoods.TYPE.BENEFIT then
		arg_34_0:ClickBenefitGood(arg_34_1)
	elseif var_34_0 == NewEducateGoods.TYPE.RES then
		arg_34_0:ClickResGood(arg_34_1)
	elseif var_34_0 == NewEducateGoods.TYPE.UP_ENTRY then
		existCall(arg_34_0.contextData.onClickUpEntryGood, arg_34_1)
	else
		arg_34_0:SendBuyProto(arg_34_1)
	end

	return
end

function var_0_0.ClickBenefitGood(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1:getConfig("goods_id")
	local var_35_1 = arg_35_0.contextData.char:GetStatus(arg_35_1:getConfig("goods_id"))

	if var_35_1 and var_35_1:getConfig("is_tip") == 0 then
		local var_35_2 = var_35_1:GetEndRound() - arg_35_0.contextData.char:GetRoundData().round
		local var_35_3 = var_35_1:getConfig("during_time") == -1 and "child2_shop_benefit_sure2" or "child2_shop_benefit_sure"

		table.insert({}, function(arg_36_0)
			arg_35_0:emit(NewEducateBaseUI.ON_BOX, {
				content = i18n(var_35_3, var_35_2),
				onYes = arg_36_0
			})

			return
		end)
	end

	seriesAsync({}, function()
		arg_35_0:SendBuyProto(arg_35_1)

		return
	end)

	return
end

function var_0_0.ClickResGood(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.contextData.char:GetResIdByType(NewEducateChar.RES_TYPE.ACTION)

	if arg_38_1:getConfig("goods_id") == var_38_0 and arg_38_0.contextData.char:GetPoint(var_38_0) + arg_38_1:getConfig("goods_num") > pg.child2_resource[var_38_0].max_value then
		table.insert({}, function(arg_39_0)
			arg_38_0:emit(NewEducateBaseUI.ON_BOX, {
				content = i18n("child2_shop_point_sure"),
				onYes = arg_39_0
			})

			return
		end)
	end

	seriesAsync({}, function()
		arg_38_0:SendBuyProto(arg_38_1)

		return
	end)

	return
end

function var_0_0.FlushShop(arg_41_0)
	arg_41_0:ShowShop()

	return
end

function var_0_0.Hide(arg_42_0, arg_42_1)
	if not arg_42_1 then
		existCall(arg_42_0.contextData.onHide)
	end

	arg_42_0.super.Hide(arg_42_0)

	return
end

function var_0_0.OnDestroy(arg_43_0)
	return
end

return var_0_0
