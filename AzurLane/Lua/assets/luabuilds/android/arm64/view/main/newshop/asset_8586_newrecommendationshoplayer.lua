class = var_0_10000

local var_0_0 = "NewRecommendationShopLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

pg = var_0_10001

local var_0_2 = var_0_10001.shop_banner_template

function var_0_1.getUIName(arg_1_0)
	return "NewRecommendationShopUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "NewShopMainScene"
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.resources = var_1.Find(var_3_0, "adapt/top/resources")
	arg_3_0.banners = {}

	local var_3_1 = arg_3_0.banners

	BannerScrollRectDorm3dShop = var_1_10002

	local var_3_2 = var_1_10002.New
	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_4.Find(var_3_3, "panel/banner_big/banner/mask/content")
	local var_3_5 = arg_3_0._tf

	var_3_1.banner_big = var_3_2(var_3_4, var_5.Find(var_3_5, "panel/banner_big/banner/dots"))

	local var_3_6 = arg_3_0.banners

	BannerScrollRectDorm3dShop = var_2

	local var_3_7 = var_2.New
	local var_3_8 = arg_3_0._tf
	local var_3_9 = var_4.Find(var_3_8, "panel/banner_middle/banner/mask/content")
	local var_3_10 = arg_3_0._tf

	var_3_6.banner_middle = var_3_7(var_3_9, var_5.Find(var_3_10, "panel/banner_middle/banner/dots"))

	local var_3_11 = arg_3_0.banners

	BannerScrollRectDorm3dShop = var_2

	local var_3_12 = var_2.New
	local var_3_13 = arg_3_0._tf
	local var_3_14 = var_4.Find(var_3_13, "panel/banner_small1/banner/mask/content")
	local var_3_15 = arg_3_0._tf

	var_3_11.banner_small1 = var_3_12(var_3_14, var_5.Find(var_3_15, "panel/banner_small1/banner/dots"))

	local var_3_16 = arg_3_0.banners

	BannerScrollRectDorm3dShop = var_2

	local var_3_17 = var_2.New
	local var_3_18 = arg_3_0._tf
	local var_3_19 = var_4.Find(var_3_18, "panel/banner_small2/banner/mask/content")
	local var_3_20 = arg_3_0._tf

	var_3_16.banner_small2 = var_3_17(var_3_19, var_5.Find(var_3_20, "panel/banner_small2/banner/dots"))

	local var_3_21 = arg_3_0.banners

	BannerScrollRectDorm3dShop = var_2

	local var_3_22 = var_2.New
	local var_3_23 = arg_3_0._tf
	local var_3_24 = var_4.Find(var_3_23, "panel/banner_small3/banner/mask/content")
	local var_3_25 = arg_3_0._tf

	var_3_21.banner_small3 = var_3_22(var_3_24, var_5.Find(var_3_25, "panel/banner_small3/banner/dots"))
	setText = var_3_21

	local var_3_26 = arg_3_0._tf
	local var_3_27 = var_3.Find(var_3_26, "panel/banner_big/banner/mask/content/item/time/remainTime")

	i18n = var_3_24

	var_3_21(var_3_27, var_3_24("shop_new_during_time"))

	setText = var_3_21

	local var_3_28 = arg_3_0._tf
	local var_3_29 = var_3.Find(var_3_28, "panel/banner_small2/banner/mask/content/item/monthCard/day")

	i18n = var_4

	var_3_21(var_3_29, var_4("shop_new_daily"))

	setText = var_3_21

	local var_3_30 = arg_3_0._tf
	local var_3_31 = var_3.Find(var_3_30, "panel/banner_middle/banner/mask/content/item/detail/buy/Text")

	i18n = var_4

	var_3_21(var_3_31, var_4("shop_new_purchase"))

	setText = var_3_21

	local var_3_32 = arg_3_0._tf
	local var_3_33 = var_3.Find(var_3_32, "panel/banner_small1/banner/mask/content/item/detail/buy/Text")

	i18n = var_4

	var_3_21(var_3_33, var_4("shop_new_purchase"))

	setText = var_3_21

	local var_3_34 = arg_3_0._tf
	local var_3_35 = var_3.Find(var_3_34, "panel/banner_small2/banner/mask/content/item/detail/buy/Text")

	i18n = var_4

	var_3_21(var_3_35, var_4("shop_new_purchase"))

	setText = var_3_21

	local var_3_36 = arg_3_0._tf
	local var_3_37 = var_3.Find(var_3_36, "panel/banner_small2/banner/mask/content/item/monthCard/buy/Text")

	i18n = var_4

	var_3_21(var_3_37, var_4("shop_new_purchase"))

	setText = var_3_21

	local var_3_38 = arg_3_0._tf
	local var_3_39 = var_3.Find(var_3_38, "panel/banner_small3/banner/mask/content/item/detail/buy/Text")

	i18n = var_4

	var_3_21(var_3_39, var_4("shop_new_purchase"))

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:InitData()
	arg_4_0:ShowResUI()
	arg_4_0:SetPanel()
	arg_4_0:OverlayPanel(arg_4_0._tf)

	return
end

function var_0_1.InitData(arg_5_0)
	getProxy = var_1_10001
	ShopsProxy = var_1_10003
	arg_5_0.shopsProxy = var_1_10001(var_1_10003)

	local var_5_0 = arg_5_0.shopsProxy
	local var_5_1 = var_1.getChargedList(var_5_0)
	local var_5_2 = arg_5_0.shopsProxy
	local var_5_3 = var_2.GetNormalList(var_5_2)
	local var_5_4 = arg_5_0.shopsProxy
	local var_5_5 = var_3.GetNormalGroupList(var_5_4)

	arg_5_0.commodities = {
		{},
		{},
		{}
	}
	ipairs = var_4

	for iter_5_0, iter_5_1 in var_4(var_0_2.all) do
		local var_5_6 = var_0_2[iter_5_1]

		pg = var_1_10010

		local var_5_7 = var_1_10010.TimeMgr.GetInstance()

		if var_1_10010.inTime(var_5_7, var_5_6.time) and var_5_6.relation_param ~= "" then
			var_1_10010 = var_5_6.relation_param[1]
			var_1_10011 = var_5_6.relation_param[2]

			local var_5_8
			local var_5_9

			if var_1_10010 == 1 then
				Goods = var_5_9
				var_5_9 = var_5_9.Create
				var_1_10015 = {
					id = var_1_10011
				}
				Goods = var_1_10016
				var_5_8 = var_5_9(var_1_10015, var_1_10016.TYPE_CHARGE)
				ChargeConst = var_5_9
				var_5_9 = var_5_9.getBuyCount(var_5_1, var_1_10011)
				var_1_10016 = var_5_8

				var_5_8.updateBuyCount(var_1_10016, var_5_9)
			elseif var_1_10010 == 2 then
				Goods = var_5_9
				var_5_9 = var_5_9.Create
				var_1_10015 = {
					id = var_1_10011
				}
				Goods = var_1_10016
				var_5_8 = var_5_9(var_1_10015, var_1_10016.TYPE_GIFT_PACKAGE)
				ChargeConst = var_5_9
				var_5_9 = var_5_9.getBuyCount(var_5_3, var_1_10011)
				var_1_10016 = var_5_8

				var_5_8.updateBuyCount(var_1_10016, var_5_9)

				ChargeConst = iter_5_5
				iter_5_5 = iter_5_5.getGroupLimit
				var_1_10016 = var_5_5

				local var_5_10

				if not var_5_8:getConfig("group") then
					var_5_10 = 0
				end

				iter_5_5 = iter_5_5(var_1_10016, var_5_10)

				var_5_8:updateGroupCount(iter_5_5)
			elseif var_1_10010 == 3 then
				Goods = var_5_9

				local var_5_11 = var_5_9.Create

				var_1_10015 = {
					id = var_1_10011
				}
				Goods = var_1_10016
				var_5_8 = var_5_11(var_1_10015, var_1_10016.TYPE_SKIN)
				ChargeConst = var_13

				local var_5_12 = var_13.getBuyCount(var_5_3, var_1_10011)

				var_1_10016 = var_5_8

				var_5_8.updateBuyCount(var_1_10016, var_5_12)

				ChargeConst = iter_5_5
				iter_5_5 = iter_5_5.getGroupLimit
				var_1_10016 = var_5_5

				local var_5_13

				if not var_5_8:getConfig("group") then
					var_5_13 = 0
				end

				iter_5_5 = iter_5_5(var_1_10016, var_5_13)

				var_5_8:updateGroupCount(iter_5_5)
			end

			arg_5_0.commodities[var_1_10010][var_1_10011] = var_5_8
		end
	end

	pg = var_4

	local var_5_14 = var_4.gameset.shop_banner_capacity.key_value

	Clone = var_5
	arg_5_0.bnIds = var_5(var_0_2.get_id_list_by_name)
	getProxy = var_5
	PlayerProxy = var_7

	local var_5_15 = var_5(var_7)
	local var_5_16 = var_5.getRawData(var_5_15)
	local var_5_17 = arg_5_0.bnIds

	underscore = var_5_15
	var_5_17.banner_big = var_5_15.filter(arg_5_0.bnIds.banner_big, function(arg_6_0)
		ShopsProxy = var_2_10001

		return var_2_10001.SpecialBannerBlockCheck(var_0_2[arg_6_0], var_5_16)
	end)
	pairs = var_5_17

	for iter_5_2, iter_5_3 in var_5_17(arg_5_0.bnIds) do
		table = var_1_10011
		var_1_10011 = var_1_10011.sort

		local var_5_18 = iter_5_3

		CompareFuncs = iter_5_5

		var_1_10011(var_5_18, iter_5_5({
			function(arg_7_0)
				return -var_0_2[arg_7_0].order
			end,
			function(arg_8_0)
				return arg_8_0
			end
		}))

		for iter_5_5 = #iter_5_3, 1, -1 do
			var_1_10015 = var_0_2[iter_5_3[iter_5_5]]
			pg = var_16

			local var_5_19 = var_16.TimeMgr.GetInstance()

			if not var_16.inTime(var_5_19, var_1_10015.time) then
				table = var_16

				var_16.remove(iter_5_3, iter_5_5)
			elseif var_1_10015.relation_param ~= "" then
				local var_5_20 = var_1_10015.relation_param[1]
				local var_5_21 = var_1_10015.relation_param[2]
				local var_5_22 = arg_5_0.commodities[var_5_20][var_5_21]

				if var_5_20 == 1 then
					if not var_5_22:inTime() or not var_5_22:canPurchase() then
						table = var_19

						var_19.remove(iter_5_3, iter_5_5)
					end
				elseif (var_5_20 == 2 or var_5_20 == 3) and (not var_5_22:inTime() or not var_5_22:canPurchase() or var_5_22:IsGroupLimit()) then
					table = var_19

					var_19.remove(iter_5_3, iter_5_5)
				end
			end
		end

		if #iter_5_3 > 1 then
			table = var_1_10011

			var_1_10011.remove(iter_5_3, #iter_5_3)
		end

		if var_5_14 < #iter_5_3 then
			for iter_5_5 = #iter_5_3, var_5_14 + 1, -1 do
				table = var_1_10015

				var_1_10015.remove(iter_5_3, iter_5_5)
			end
		end
	end

	return
end

function var_0_1.ShowResUI(arg_9_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.getRawData(var_9_0)
	local var_9_2 = arg_9_0.resources
	local var_9_3 = var_2.Find(var_9_2, "gold/max")
	local var_9_4 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_9_0.goldMax = var_9_4(var_9_3, var_5(var_1_10007))

	local var_9_5 = arg_9_0.resources
	local var_9_6 = var_2.Find(var_9_5, "gold/Text")
	local var_9_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_9_0.goldValue = var_9_7(var_9_6, var_5(var_1_10007))

	local var_9_8 = arg_9_0.resources
	local var_9_9 = var_2.Find(var_9_8, "oil/max")
	local var_9_10 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_9_0.oilMax = var_9_10(var_9_9, var_5(var_1_10007))

	local var_9_11 = arg_9_0.resources
	local var_9_12 = var_2.Find(var_9_11, "oil/Text")
	local var_9_13 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_9_0.oilValue = var_9_13(var_9_12, var_5(var_1_10007))

	local var_9_14 = arg_9_0.resources
	local var_9_15 = var_2.Find(var_9_14, "gem/Text")
	local var_9_16 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_9_0.gemValue = var_9_16(var_9_15, var_5(var_1_10007))
	PlayerResUI = var_2

	var_2.StaticFlush(var_9_1, arg_9_0.goldMax, arg_9_0.goldValue, arg_9_0.oilMax, arg_9_0.oilValue, arg_9_0.gemValue)

	onButton = var_2

	local var_9_17 = arg_9_0
	local var_9_18 = arg_9_0.resources
	local var_9_19 = var_5.Find(var_9_18, "gold")

	local function var_9_20()
		pg = var_2_10000

		local var_10_0 = var_2_10000.playerResUI

		var_0.ClickGold(var_10_0)

		return
	end

	SFX_PANEL = var_9_18

	var_2(var_9_17, var_9_19, var_9_20, var_9_18)

	onButton = var_2

	local var_9_21 = arg_9_0
	local var_9_22 = arg_9_0.resources
	local var_9_23 = var_5.Find(var_9_22, "oil")

	local function var_9_24()
		pg = var_2_10000

		local var_11_0 = var_2_10000.playerResUI

		var_0.ClickOil(var_11_0)

		return
	end

	SFX_PANEL = var_9_22

	var_2(var_9_21, var_9_23, var_9_24, var_9_22)

	onButton = var_2

	local var_9_25 = arg_9_0
	local var_9_26 = arg_9_0.resources
	local var_9_27 = var_5.Find(var_9_26, "gem")

	local function var_9_28()
		pg = var_2_10000

		local var_12_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_12_0)

		return
	end

	SFX_PANEL = var_9_26

	var_2(var_9_25, var_9_27, var_9_28, var_9_26)

	return
end

function var_0_1.SetPanel(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.banners) do
		ipairs = var_1_10006

		for iter_13_2, iter_13_3 in var_1_10006(arg_13_0.bnIds[iter_13_0]) do
			local var_13_0 = var_0_2[iter_13_3]
			local var_13_1 = iter_13_1
			local var_13_2 = iter_13_1.AddChild(var_13_1)

			GetImageSpriteFromAtlasAsync = var_1_10013

			var_1_10013(var_13_0.pic, "", var_13_2:Find("picture"))

			setActive = var_1_10013

			var_1_10013(var_13_2:Find("detail"), var_13_0.relation_param ~= "")

			setActive = var_1_10013

			var_1_10013(var_13_2:Find("time"), var_13_0.time_lable == 1)

			if iter_13_0 == "banner_small2" then
				setActive = var_1_10013

				var_1_10013(var_13_2:Find("monthCard"), false)

				setActive = var_1_10013

				var_1_10013(var_13_2:Find("monthCardhave"), false)
			end

			if var_13_0.relation_param ~= "" then
				var_1_10013 = var_13_0.relation_param[1]
				var_13_1 = var_13_0.relation_param[2]

				local var_13_3 = arg_13_0.commodities[var_1_10013][var_13_1]

				if iter_13_0 == "banner_small2" and var_1_10013 == 1 then
					local var_13_4 = var_13_3

					if var_13_3.isMonthCard(var_13_4) then
						setActive = var_13_5

						var_13_5(var_13_2:Find("detail"), false)

						setActive = var_13_5

						var_13_5(var_13_2:Find("monthCard"), true)

						setText = var_13_5

						var_13_5(var_13_2:Find("monthCard/name"), var_13_3:getConfig("name_display"))

						GetImageSpriteFromAtlasAsync = var_13_5

						var_13_5("chargeicon/" .. var_13_3:getConfig("picture"), "", var_13_2:Find("monthCard/icon"))

						setText = var_13_5
						var_13_4 = var_13_2:Find("monthCard/get")
						i18n = var_19

						var_13_5(var_13_4, var_19("shop_new_get_now", var_13_3:GetGemCnt()))

						var_13_4 = var_13_3

						local var_13_5 = var_13_3.GetDropList(var_13_4)

						::label_13_0::

						local var_13_6 = #var_13_5

						if 3 < var_13_6 then
							repeat
								table = var_13_6

								var_13_6.remove(var_13_5, #var_13_5)

								goto label_13_0
							until true
						end

						UIItemList = var_13_6

						local var_13_7 = var_13_6.New(var_13_2:Find("monthCard/items"), var_13_2:Find("monthCard/items/item"))

						var_17.make(var_13_7, function(arg_14_0, arg_14_1, arg_14_2)
							UIItemList = var_2_10003

							if arg_14_0 == var_2_10003.EventUpdate then
								local var_14_0 = var_13_5[arg_14_1 + 1]

								updateDrop = var_4

								var_4(arg_14_2:Find("mask/item"), var_14_0)
							end

							return
						end)

						local var_13_8 = var_17

						var_17.align(var_13_8, #var_13_5)

						if var_1_10013 == 1 then
							var_13_8 = var_13_3

							if var_13_3.getShowType(var_13_8) == "" then
								var_13_4 = false
							else
								var_13_4 = true
							end

							local var_13_9 = var_13_3
							local var_13_10 = var_13_3.isFree(var_13_9)

							setText = var_13_8

							local var_13_11 = var_13_2:Find("monthCard/consume/icon_rmb")

							GetMoneySymbol = var_23

							var_13_8(var_13_11, var_23())

							setActive = var_13_8

							var_13_8(var_13_2:Find("monthCard/consume/icon_rmb"), var_1_10013 == 1 and not var_13_4)

							PLATFORM_CODE = var_13_8
							PLATFORM_CHT = var_13_9

							if var_13_8 == var_13_9 and var_13_3:IsLocalPrice() then
								setActive = var_13_8

								var_13_8(var_13_2:Find("monthCard/consume/icon_rmb"), false)
							end

							setActive = var_13_8

							var_13_8(var_13_2:Find("monthCard/consume/icon_gem"), var_1_10013 ~= 1 and not var_13_10)

							setActive = var_13_8

							var_13_8(var_13_2:Find("monthCard/consume/Text"), not var_13_10 and not var_13_4)

							if var_1_10013 == 1 then
								setText = var_13_8

								var_13_8(var_13_2:Find("monthCard/consume/Text"), var_13_3:getConfig("money"))
							elseif var_1_10013 == 2 then
								setText = var_13_8

								var_13_8(var_13_2:Find("monthCard/consume/Text"), var_13_3:GetPrice())
							end

							setActive = var_13_8

							var_13_8(var_13_2:Find("monthCard/consume/FreeText"), var_13_10)

							setText = var_13_8

							local var_13_12 = var_13_2
							local var_13_13 = var_13_2.Find(var_13_12, "monthCard/consume/FreeText")

							i18n = var_23

							var_13_8(var_13_13, var_23("shop_free_tag"))

							getProxy = var_13_8
							PlayerProxy = var_13_13

							local var_13_14 = var_13_8(var_13_13)
							local var_13_15 = var_20.getRawData(var_13_14)
							local var_13_16 = var_20.getCardById

							VipCard = var_13_12

							local var_13_18

							if var_13_16(var_13_15, var_13_12.MONTH) then
								::label_13_1::

								local var_13_17 = var_21:GetLeftDay()

								if not var_13_3:getConfig("limit_arg") then
									var_13_15 = 0
								end

								var_13_18 = var_13_15 < var_13_17
							end

							setActive = var_13_15

							var_13_15(var_13_2:Find("monthCardhave"), var_13_18)

							if var_13_18 then
								setText = var_13_15

								local var_13_19 = var_13_2:Find("monthCardhave/Text")

								i18n = var_26

								var_13_15(var_13_19, var_26("shop_new_remaining_time", var_21:GetLeftDay()))
							end

							goto label_13_3

							if var_1_10013 == 1 then
								setText = var_13_5

								var_13_5(var_13_2:Find("detail/name"), var_13_3:getConfig("name_display"))

								GetImageSpriteFromAtlasAsync = var_13_5

								var_13_5("chargeicon/" .. var_13_3:getConfig("picture"), "", var_13_2:Find("detail/icon"))
							elseif var_1_10013 == 2 then
								setText = var_13_5

								var_13_5(var_13_2:Find("detail/name"), var_13_3:GetName())

								GetImageSpriteFromAtlasAsync = var_13_5

								local var_13_20 = var_13_3:getDropInfo()

								var_13_5(var_13_4.getIcon(var_13_20), "", var_13_2:Find("detail/icon"))
							end

							var_13_4 = var_13_3

							local var_13_21 = var_13_3.GetDropList(var_13_4)

							::label_13_2::

							local var_13_22 = #var_13_21

							if 3 < var_13_22 then
								repeat
									table = var_13_22

									var_13_22.remove(var_13_21, #var_13_21)

									goto label_13_2
								until true
							end

							UIItemList = var_13_22

							local var_13_23 = var_13_22.New(var_13_2:Find("detail/items"), var_13_2:Find("detail/items/item"))

							var_17.make(var_13_23, function(arg_15_0, arg_15_1, arg_15_2)
								UIItemList = var_2_10003

								if arg_15_0 == var_2_10003.EventUpdate then
									local var_15_0 = var_13_21[arg_15_1 + 1]

									updateDrop = var_4

									var_4(arg_15_2:Find("mask/item"), var_15_0)
								end

								return
							end)

							local var_13_24 = var_17

							var_17.align(var_13_24, #var_13_21)

							if var_1_10013 == 1 then
								var_13_24 = var_13_3

								if var_13_3.getShowType(var_13_24) == "" then
									var_13_4 = false
								else
									var_13_4 = true
								end

								do
									local var_13_25 = var_13_3
									local var_13_26 = var_13_3.isFree(var_13_25)

									setText = var_13_24

									local var_13_27 = var_13_2:Find("detail/consume/icon_rmb")

									GetMoneySymbol = var_23

									var_13_24(var_13_27, var_23())

									setActive = var_13_24

									var_13_24(var_13_2:Find("detail/consume/icon_rmb"), var_1_10013 == 1 and not var_13_4)

									PLATFORM_CODE = var_13_24
									PLATFORM_CHT = var_13_25

									if var_13_24 == var_13_25 and var_13_3:IsLocalPrice() then
										setActive = var_13_24

										var_13_24(var_13_2:Find("detail/consume/icon_rmb"), false)
									end

									setActive = var_13_24

									var_13_24(var_13_2:Find("detail/consume/icon_gem"), var_1_10013 ~= 1 and not var_13_26)

									setActive = var_13_24

									var_13_24(var_13_2:Find("detail/consume/Text"), not var_13_26 and not var_13_4)

									if var_1_10013 == 1 then
										setText = var_13_24

										var_13_24(var_13_2:Find("detail/consume/Text"), var_13_3:getConfig("money"))
									elseif var_1_10013 == 2 then
										setText = var_13_24

										var_13_24(var_13_2:Find("detail/consume/Text"), var_13_3:GetPrice())
									end

									setActive = var_13_24

									var_13_24(var_13_2:Find("detail/consume/FreeText"), var_13_26)

									setText = var_13_24

									local var_13_28 = var_13_2:Find("detail/consume/FreeText")

									i18n = var_23

									var_13_24(var_13_28, var_23("shop_free_tag"))
								end

								::label_13_3::

								if var_13_0.time_lable == 1 then
									var_1_10013 = var_13_0.time[2]
									pg = var_13_1

									local var_13_29 = var_13_1.TimeMgr.GetInstance()
									local var_13_30 = var_14.Table2ServerTime(var_13_29, {
										year = var_1_10013[1][1],
										month = var_1_10013[1][2],
										day = var_1_10013[1][3],
										hour = var_1_10013[2][1],
										min = var_1_10013[2][2],
										sec = var_1_10013[2][3]
									})

									arg_13_0:StartTimer(function()
										pg = var_2_10000

										local var_16_0 = var_2_10000.TimeMgr.GetInstance()
										local var_16_1 = var_0.GetServerTime(var_16_0)
										local var_16_2 = var_13_30 - var_16_1

										math = var_16_0

										local var_16_3 = var_16_0.floor(var_16_2 / 0)

										math = var_2_10003

										local var_16_4 = var_2_10003.floor(var_16_2 % 0 / 16)

										math = var_4

										local var_16_5 = var_4.floor(var_16_2 % 0 % 16 / 60)

										if iter_13_0 == "banner_big" then
											setText = var_5

											local var_16_6 = var_13_2
											local var_16_7 = var_7.Find(var_16_6, "time/text")

											i18n = var_2_10008

											var_5(var_16_7, var_2_10008("shop_countdown", var_16_3, var_16_4, var_16_5))
										elseif 0 < var_16_3 then
											setText = var_5

											local var_16_8 = var_13_2
											local var_16_9 = var_7.Find(var_16_8, "time/text")

											i18n = var_2_10008

											var_5(var_16_9, var_2_10008("shop_new_during_day", var_16_3))
										elseif 0 < var_16_4 then
											setText = var_5

											local var_16_10 = var_13_2
											local var_16_11 = var_7.Find(var_16_10, "time/text")

											i18n = var_2_10008

											var_5(var_16_11, var_2_10008("shop_new_during_hour", var_16_4))
										else
											setText = var_5

											local var_16_12 = var_13_2
											local var_16_13 = var_7.Find(var_16_12, "time/text")

											i18n = var_2_10008

											var_5(var_16_13, var_2_10008("shop_new_during_minite", var_16_5))
										end

										return
									end)
								end

								onButton = var_1_10013

								local var_13_31 = arg_13_0
								local var_13_32 = var_13_2

								local function var_13_33()
									local var_17_0 = arg_13_0
									local var_17_1 = var_0.emit

									NewRecommendationShopMediator = var_2_10003

									var_17_1(var_17_0, var_2_10003.GO_SHOP, var_13_0.param[1], var_13_0.param[2])

									return
								end

								SFX_PANEL = var_13_4

								var_1_10013(var_13_31, var_13_32, var_13_33, var_13_4)
							end
						end
					end
				end
			end
		end

		iter_13_1:SetUp()

		setActive = var_1_10006

		local var_13_34 = arg_13_0._tf

		var_1_10006(var_8.Find(var_13_34, "panel/" .. iter_13_0 .. "/banner/dots"), #arg_13_0.bnIds[iter_13_0] > 1)
	end

	return
end

function var_0_1.StartTimer(arg_18_0, arg_18_1)
	if not arg_18_0.timers then
		arg_18_0.timers = {}
	end

	arg_18_1()

	Timer = var_2

	local var_18_0 = var_2.New(function()
		arg_18_1()

		return
	end, 1, -1)

	var_2.Start(var_18_0)

	table = var_3

	var_3.insert(arg_18_0.timers, var_2)

	return
end

function var_0_1.RemoveAllTimer(arg_20_0)
	if arg_20_0.timers then
		ipairs = var_1

		for iter_20_0, iter_20_1 in var_1(arg_20_0.timers) do
			iter_20_1:Stop()

			iter_20_1 = nil
		end

		arg_20_0.timers = nil
	end

	return
end

function var_0_1.willExit(arg_21_0)
	arg_21_0:RemoveAllTimer()

	pairs = var_1

	for iter_21_0, iter_21_1 in var_1(arg_21_0.banners) do
		iter_21_1:Dispose()
	end

	arg_21_0.banners = nil

	arg_21_0:UnOverlayPanel(arg_21_0._tf)

	return
end

function var_0_1.onBackPressed(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.m02
	local var_22_1 = var_1.sendNotification

	NewShopMainScene = var_1_10004

	var_22_1(var_22_0, var_1_10004.CLOSE_VIEW)

	return
end

return var_0_1
