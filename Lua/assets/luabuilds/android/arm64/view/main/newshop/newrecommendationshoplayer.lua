local var_0_0 = class("NewRecommendationShopLayer", import("...base.BaseUI"))
local var_0_1 = pg.shop_banner_template

function var_0_0.getUIName(arg_1_0)
	return "NewRecommendationShopUI"
end

function var_0_0.getGroupName(arg_2_0)
	return "NewShopMainScene"
end

function var_0_0.init(arg_3_0)
	arg_3_0.resources = arg_3_0._tf:Find("adapt/top/resources")
	arg_3_0.banners = {}
	arg_3_0.banners.banner_big = BannerScrollRectDorm3dShop.New(arg_3_0._tf:Find("panel/banner_big/banner/mask/content"), arg_3_0._tf:Find("panel/banner_big/banner/dots"))
	arg_3_0.banners.banner_middle = BannerScrollRectDorm3dShop.New(arg_3_0._tf:Find("panel/banner_middle/banner/mask/content"), arg_3_0._tf:Find("panel/banner_middle/banner/dots"))
	arg_3_0.banners.banner_small1 = BannerScrollRectDorm3dShop.New(arg_3_0._tf:Find("panel/banner_small1/banner/mask/content"), arg_3_0._tf:Find("panel/banner_small1/banner/dots"))
	arg_3_0.banners.banner_small2 = BannerScrollRectDorm3dShop.New(arg_3_0._tf:Find("panel/banner_small2/banner/mask/content"), arg_3_0._tf:Find("panel/banner_small2/banner/dots"))
	arg_3_0.banners.banner_small3 = BannerScrollRectDorm3dShop.New(arg_3_0._tf:Find("panel/banner_small3/banner/mask/content"), arg_3_0._tf:Find("panel/banner_small3/banner/dots"))

	setText(arg_3_0._tf:Find("panel/banner_big/banner/mask/content/item/time/remainTime"), i18n("shop_new_during_time"))
	setText(arg_3_0._tf:Find("panel/banner_small2/banner/mask/content/item/monthCard/day"), i18n("shop_new_daily"))
	setText(arg_3_0._tf:Find("panel/banner_middle/banner/mask/content/item/detail/buy/Text"), i18n("shop_new_purchase"))
	setText(arg_3_0._tf:Find("panel/banner_small1/banner/mask/content/item/detail/buy/Text"), i18n("shop_new_purchase"))
	setText(arg_3_0._tf:Find("panel/banner_small2/banner/mask/content/item/detail/buy/Text"), i18n("shop_new_purchase"))
	setText(arg_3_0._tf:Find("panel/banner_small2/banner/mask/content/item/monthCard/buy/Text"), i18n("shop_new_purchase"))
	setText(arg_3_0._tf:Find("panel/banner_small3/banner/mask/content/item/detail/buy/Text"), i18n("shop_new_purchase"))

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:InitData()
	arg_4_0:ShowResUI()
	arg_4_0:SetPanel()
	arg_4_0:OverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.InitData(arg_5_0)
	arg_5_0.shopsProxy = getProxy(ShopsProxy)

	local var_5_0 = arg_5_0.shopsProxy:getChargedList()
	local var_5_1 = arg_5_0.shopsProxy:GetNormalList()
	local var_5_2 = arg_5_0.shopsProxy:GetNormalGroupList()

	arg_5_0.commodities = {
		{},
		{},
		{}
	}

	for iter_5_0, iter_5_1 in ipairs(var_0_1.all) do
		local var_5_3 = pg.TimeMgr.GetInstance()

		if var_5_3:inTime(var_0_1[iter_5_1].time) and var_0_1[iter_5_1].relation_param ~= "" then
			local var_5_4 = var_0_1[iter_5_1].relation_param[1]
			local var_5_5 = var_0_1[iter_5_1].relation_param[2]
			local var_5_6

			if var_0_1[iter_5_1].relation_param[1] == 1 then
				var_5_6 = Goods.Create({
					id = var_5_5
				}, Goods.TYPE_CHARGE)

				var_5_6:updateBuyCount((ChargeConst.getBuyCount(var_5_0, var_5_5)))
			elseif var_5_4 == 2 then
				var_5_6 = Goods.Create({
					id = var_5_5
				}, Goods.TYPE_GIFT_PACKAGE)

				var_5_6:updateBuyCount((ChargeConst.getBuyCount(var_5_1, var_5_5)))

				local var_5_7 = var_5_6:getConfig("group") or 0
				local var_5_8 = ChargeConst.getGroupLimit(var_5_2, var_5_7)

				var_5_6:updateGroupCount(var_5_8)
			elseif var_5_4 == 3 then
				var_5_6 = Goods.Create({
					id = var_5_5
				}, Goods.TYPE_SKIN)

				var_5_6:updateBuyCount((ChargeConst.getBuyCount(var_5_1, var_5_5)))

				local var_5_9 = var_5_6:getConfig("group") or 0
				local var_5_10 = ChargeConst.getGroupLimit(var_5_2, var_5_9)

				var_5_6:updateGroupCount(var_5_10)
			end

			arg_5_0.commodities[var_5_4][var_5_5] = var_5_6
		end
	end

	arg_5_0.bnIds = Clone(var_0_1.get_id_list_by_name)

	local var_5_11 = getProxy(PlayerProxy):getRawData()

	arg_5_0.bnIds.banner_big = underscore.filter(arg_5_0.bnIds.banner_big, function(arg_6_0)
		return ShopsProxy.SpecialBannerBlockCheck(var_0_1[arg_6_0], var_5_11)
	end)

	for iter_5_2, iter_5_3 in pairs(arg_5_0.bnIds) do
		table.sort(iter_5_3, CompareFuncs({
			function(arg_7_0)
				return -var_0_1[arg_7_0].order
			end,
			function(arg_8_0)
				return arg_8_0
			end
		}))

		for iter_5_4 = #iter_5_3, 1, -1 do
			local var_5_12 = pg.TimeMgr.GetInstance()

			if not var_5_12:inTime(var_0_1[iter_5_3[iter_5_4]].time) then
				table.remove(iter_5_3, iter_5_4)
			elseif var_0_1[iter_5_3[iter_5_4]].relation_param ~= "" then
				if var_0_1[iter_5_3[iter_5_4]].relation_param[1] == 1 then
					if not arg_5_0.commodities[var_0_1[iter_5_3[iter_5_4]].relation_param[1]][var_0_1[iter_5_3[iter_5_4]].relation_param[2]]:inTime() or not arg_5_0.commodities[var_0_1[iter_5_3[iter_5_4]].relation_param[1]][var_0_1[iter_5_3[iter_5_4]].relation_param[2]]:canPurchase() then
						table.remove(iter_5_3, iter_5_4)
					end
				elseif (var_0_1[iter_5_3[iter_5_4]].relation_param[1] == 2 or var_0_1[iter_5_3[iter_5_4]].relation_param[1] == 3) and (not arg_5_0.commodities[var_0_1[iter_5_3[iter_5_4]].relation_param[1]][var_0_1[iter_5_3[iter_5_4]].relation_param[2]]:inTime() or not arg_5_0.commodities[var_0_1[iter_5_3[iter_5_4]].relation_param[1]][var_0_1[iter_5_3[iter_5_4]].relation_param[2]]:canPurchase() or arg_5_0.commodities[var_0_1[iter_5_3[iter_5_4]].relation_param[1]][var_0_1[iter_5_3[iter_5_4]].relation_param[2]]:IsGroupLimit()) then
					table.remove(iter_5_3, iter_5_4)
				end
			end
		end

		if #iter_5_3 > 1 then
			table.remove(iter_5_3, #iter_5_3)
		end

		if pg.gameset.shop_banner_capacity.key_value < #iter_5_3 then
			for iter_5_5 = #iter_5_3, pg.gameset.shop_banner_capacity.key_value + 1, -1 do
				table.remove(iter_5_3, iter_5_5)
			end
		end
	end

	return
end

function var_0_0.ShowResUI(arg_9_0)
	arg_9_0.goldMax = arg_9_0.resources:Find("gold/max"):GetComponent(typeof(Text))
	arg_9_0.goldValue = arg_9_0.resources:Find("gold/Text"):GetComponent(typeof(Text))
	arg_9_0.oilMax = arg_9_0.resources:Find("oil/max"):GetComponent(typeof(Text))
	arg_9_0.oilValue = arg_9_0.resources:Find("oil/Text"):GetComponent(typeof(Text))
	arg_9_0.gemValue = arg_9_0.resources:Find("gem/Text"):GetComponent(typeof(Text))

	PlayerResUI.StaticFlush(getProxy(PlayerProxy):getRawData(), arg_9_0.goldMax, arg_9_0.goldValue, arg_9_0.oilMax, arg_9_0.oilValue, arg_9_0.gemValue)
	onButton(arg_9_0, arg_9_0.resources:Find("gold"), function()
		pg.playerResUI:ClickGold()

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.resources:Find("oil"), function()
		pg.playerResUI:ClickOil()

		return
	end, SFX_PANEL)
	onButton(arg_9_0, arg_9_0.resources:Find("gem"), function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.SetPanel(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.banners) do
		for iter_13_2, iter_13_3 in ipairs(arg_13_0.bnIds[iter_13_0]) do
			local var_13_0 = var_0_1[iter_13_3]
			local var_13_1 = iter_13_1:AddChild()

			GetImageSpriteFromAtlasAsync(var_0_1[iter_13_3].pic, "", var_13_1:Find("picture"))
			setActive(var_13_1:Find("detail"), var_13_0.relation_param ~= "")
			setActive(var_13_1:Find("time"), var_13_0.time_lable == 1)

			if iter_13_0 == "banner_small2" then
				setActive(var_13_1:Find("monthCard"), false)
				setActive(var_13_1:Find("monthCardhave"), false)
			end

			if var_13_0.relation_param ~= "" then
				local var_13_2 = var_13_0.relation_param[1]

				if iter_13_0 == "banner_small2" and var_13_2 == 1 and var_13_3:isMonthCard() then
					setActive(var_13_1:Find("detail"), false)
					setActive(var_13_1:Find("monthCard"), true)
					setText(var_13_1:Find("monthCard/name"), var_13_3:getConfig("name_display"))
					GetImageSpriteFromAtlasAsync("chargeicon/" .. var_13_3:getConfig("picture"), "", var_13_1:Find("monthCard/icon"))
					setText(var_13_1:Find("monthCard/get"), i18n("shop_new_get_now", var_13_3:GetGemCnt()))

					local var_13_4 = var_13_3:GetDropList()

					while #var_13_4 > 3 do
						table.remove(var_13_4, #var_13_4)
					end

					local var_13_5 = UIItemList.New(var_13_1:Find("monthCard/items"), var_13_1:Find("monthCard/items/item"))

					var_13_5:make(function(arg_14_0, arg_14_1, arg_14_2)
						if arg_14_0 == UIItemList.EventUpdate then
							updateDrop(arg_14_2:Find("mask/item"), var_13_4[arg_14_1 + 1])
						end

						return
					end)
					var_13_5:align(#var_13_4)

					local var_13_6 = var_13_2 == 1 and var_13_3:getShowType() ~= ""
					local var_13_7 = var_13_3:isFree()

					setText(var_13_1:Find("monthCard/consume/icon_rmb"), GetMoneySymbol())
					setActive(var_13_1:Find("monthCard/consume/icon_rmb"), var_13_2 == 1 and not var_13_6)

					if PLATFORM_CODE == PLATFORM_CHT and var_13_3:IsLocalPrice() then
						setActive(var_13_1:Find("monthCard/consume/icon_rmb"), false)
					end

					setActive(var_13_1:Find("monthCard/consume/icon_gem"), var_13_2 ~= 1 and not var_13_7)
					setActive(var_13_1:Find("monthCard/consume/Text"), not var_13_7 and not var_13_6)

					if var_13_2 == 1 then
						setText(var_13_1:Find("monthCard/consume/Text"), var_13_3:getConfig("money"))
					elseif var_13_2 == 2 then
						setText(var_13_1:Find("monthCard/consume/Text"), var_13_3:GetPrice())
					end

					setActive(var_13_1:Find("monthCard/consume/FreeText"), var_13_7)
					setText(var_13_1:Find("monthCard/consume/FreeText"), i18n("shop_free_tag"))

					local var_13_8 = getProxy(PlayerProxy):getRawData():getCardById(VipCard.MONTH)
					local var_13_10

					if var_13_8 then
						local var_13_9

						do
							var_13_9 = var_13_3:getConfig("limit_arg") or 0
						end

						::label_13_0::

						var_13_10 = var_13_8:GetLeftDay() > var_13_9
					end

					setActive(var_13_1:Find("monthCardhave"), var_13_10)

					if var_13_10 then
						setText(var_13_1:Find("monthCardhave/Text"), i18n("shop_new_remaining_time", var_13_8:GetLeftDay()))
					end
				else
					if var_13_2 == 1 then
						setText(var_13_1:Find("detail/name"), var_13_3:getConfig("name_display"))
						GetImageSpriteFromAtlasAsync("chargeicon/" .. var_13_3:getConfig("picture"), "", var_13_1:Find("detail/icon"))
					elseif var_13_2 == 2 then
						setText(var_13_1:Find("detail/name"), var_13_3:GetName())

						local var_13_11 = var_13_3:getDropInfo():getIcon()

						GetImageSpriteFromAtlasAsync(var_13_11, "", var_13_1:Find("detail/icon"))
					end

					local var_13_12 = var_13_3:GetDropList()

					while #var_13_12 > 3 do
						table.remove(var_13_12, #var_13_12)
					end

					local var_13_13 = UIItemList.New(var_13_1:Find("detail/items"), var_13_1:Find("detail/items/item"))

					var_13_13:make(function(arg_15_0, arg_15_1, arg_15_2)
						if arg_15_0 == UIItemList.EventUpdate then
							updateDrop(arg_15_2:Find("mask/item"), var_13_12[arg_15_1 + 1])
						end

						return
					end)
					var_13_13:align(#var_13_12)

					local var_13_14 = var_13_2 == 1 and var_13_3:getShowType() ~= ""
					local var_13_15 = var_13_3:isFree()

					setText(var_13_1:Find("detail/consume/icon_rmb"), GetMoneySymbol())
					setActive(var_13_1:Find("detail/consume/icon_rmb"), var_13_2 == 1 and not var_13_14)

					if PLATFORM_CODE == PLATFORM_CHT and var_13_3:IsLocalPrice() then
						setActive(var_13_1:Find("detail/consume/icon_rmb"), false)
					end

					setActive(var_13_1:Find("detail/consume/icon_gem"), var_13_2 ~= 1 and not var_13_15)
					setActive(var_13_1:Find("detail/consume/Text"), not var_13_15 and not var_13_14)

					if var_13_2 == 1 then
						setText(var_13_1:Find("detail/consume/Text"), var_13_3:getConfig("money"))
					elseif var_13_2 == 2 then
						setText(var_13_1:Find("detail/consume/Text"), var_13_3:GetPrice())
					end

					setActive(var_13_1:Find("detail/consume/FreeText"), var_13_15)
					setText(var_13_1:Find("detail/consume/FreeText"), i18n("shop_free_tag"))
				end
			end

			if var_13_0.time_lable == 1 then
				local var_13_16 = pg.TimeMgr.GetInstance():Table2ServerTime({
					year = var_13_0.time[2][1][1],
					month = var_13_0.time[2][1][2],
					day = var_13_0.time[2][1][3],
					hour = var_13_0.time[2][2][1],
					min = var_13_0.time[2][2][2],
					sec = var_13_0.time[2][2][3]
				})

				arg_13_0:StartTimer(function()
					local var_16_0 = var_13_16 - pg.TimeMgr.GetInstance():GetServerTime()
					local var_16_1 = math.floor(var_16_0 / 0)
					local var_16_2 = math.floor(var_16_0 % 0 / 16)
					local var_16_3 = math.floor(var_16_0 % 0 % 16 / 60)

					if iter_13_0 == "banner_big" then
						setText(var_13_1:Find("time/text"), i18n("shop_countdown", var_16_1, var_16_2, var_16_3))
					elseif var_16_1 > 0 then
						setText(var_13_1:Find("time/text"), i18n("shop_new_during_day", var_16_1))
					elseif var_16_2 > 0 then
						setText(var_13_1:Find("time/text"), i18n("shop_new_during_hour", var_16_2))
					else
						setText(var_13_1:Find("time/text"), i18n("shop_new_during_minite", var_16_3))
					end

					return
				end)
			end

			onButton(arg_13_0, var_13_1, function()
				arg_13_0:emit(NewRecommendationShopMediator.GO_SHOP, var_13_0.param[1], var_13_0.param[2])

				return
			end, SFX_PANEL)
		end

		iter_13_1:SetUp()
		setActive(arg_13_0._tf:Find("panel/" .. iter_13_0 .. "/banner/dots"), #arg_13_0.bnIds[iter_13_0] > 1)
	end

	return
end

function var_0_0.StartTimer(arg_18_0, arg_18_1)
	arg_18_0.timers = arg_18_0.timers or {}

	arg_18_1()

	local var_18_0 = Timer.New(function()
		arg_18_1()

		return
	end, 1, -1)

	var_18_0:Start()
	table.insert(arg_18_0.timers, var_18_0)

	return
end

function var_0_0.RemoveAllTimer(arg_20_0)
	if arg_20_0.timers then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0.timers) do
			iter_20_1:Stop()

			iter_20_1 = nil
		end

		arg_20_0.timers = nil
	end

	return
end

function var_0_0.willExit(arg_21_0)
	arg_21_0:RemoveAllTimer()

	for iter_21_0, iter_21_1 in pairs(arg_21_0.banners) do
		iter_21_1:Dispose()
	end

	arg_21_0.banners = nil

	arg_21_0:UnOverlayPanel(arg_21_0._tf)

	return
end

function var_0_0.onBackPressed(arg_22_0)
	pg.m02:sendNotification(NewShopMainScene.CLOSE_VIEW)

	return
end

return var_0_0
