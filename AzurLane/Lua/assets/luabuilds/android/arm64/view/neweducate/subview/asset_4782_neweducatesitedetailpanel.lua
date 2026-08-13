class = var_0_10000

local var_0_0 = "NewEducateSiteDetailPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateSiteDetailPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rootTF = var_1.Find(var_2_0, "root")

	local var_2_1 = arg_2_0.rootTF

	arg_2_0.shopTF = var_1.Find(var_2_1, "shop")

	local var_2_2 = arg_2_0.shopTF
	local var_2_3 = var_1.Find(var_2_2, "goods/content")

	UIItemList = var_1_10002
	arg_2_0.goodsUIList = var_1_10002.New(var_2_3, var_2_3:Find("tpl"))

	local var_2_4 = arg_2_0.shopTF

	arg_2_0.shopRefreshTF = var_2.Find(var_2_4, "refresh")

	local var_2_5 = arg_2_0.rootTF

	arg_2_0.normalTF = var_2.Find(var_2_5, "normal")

	local var_2_6 = arg_2_0.normalTF

	arg_2_0.titleTF = var_2.Find(var_2_6, "title/Text")

	local var_2_7 = arg_2_0.normalTF

	arg_2_0.picTF = var_2.Find(var_2_7, "content/icon_bg/icon_mask/icon")

	local var_2_8 = arg_2_0.normalTF

	arg_2_0.nameTF = var_2.Find(var_2_8, "content/name")

	local var_2_9 = arg_2_0.normalTF

	arg_2_0.descTF = var_2.Find(var_2_9, "content/desc_view/mask/desc")

	local var_2_10 = arg_2_0.normalTF

	arg_2_0.enterTF = var_2.Find(var_2_10, "options/enter")
	setScrollText = var_2

	local var_2_11 = arg_2_0.normalTF
	local var_2_12 = var_4.Find(var_2_11, "options/exit/mask/Text")

	i18n = var_5

	var_2(var_2_12, var_5("child2_site_exit"))

	local var_2_13 = {}
	local var_2_14 = arg_2_0.normalTF

	var_2_13[1] = var_3.Find(var_2_14, "title")

	local var_2_15 = arg_2_0.normalTF

	var_2_13[2] = var_3.Find(var_2_15, "line")

	local var_2_16 = arg_2_0.normalTF

	var_2_13[3] = var_3.Find(var_2_16, "content/azurlane")

	local var_2_17 = arg_2_0.normalTF

	var_2_13[4] = var_3.Find(var_2_17, "content/name/Image")
	arg_2_0.imageColorTFs = var_2_13

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.rootTF
	local var_3_2 = var_4.Find(var_3_1, "bg")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.shopTF
	local var_3_6 = var_4.Find(var_3_5, "close_btn")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0.normalTF
	local var_3_10 = var_4.Find(var_3_9, "close_btn")

	local function var_3_11()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_3_9

	var_1_10001(var_3_8, var_3_10, var_3_11, var_3_9)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.normalTF
	local var_3_14 = var_4.Find(var_3_13, "options/exit")

	local function var_3_15()
		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_3_13

	var_1_10001(var_3_12, var_3_14, var_3_15, var_3_13)

	onButton = var_1_10001

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0.shopRefreshTF

	local function var_3_18()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		NewEducateMapMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.ON_REFRESH_SHOP)

		return
	end

	SFX_PANEL = var_3_13

	var_1_10001(var_3_16, var_3_17, var_3_18, var_3_13)

	local var_3_19 = arg_3_0.goodsUIList

	var_1.make(var_3_19, function(arg_9_0, arg_9_1, arg_9_2)
		UIItemList = var_2_10003

		if arg_9_0 == var_2_10003.EventUpdate then
			local var_9_0 = arg_3_0

			var_3.UpdateGoodsItem(var_9_0, arg_9_1, arg_9_2)
		end

		return
	end)

	pg = var_1
	arg_3_0.shopRefreshCost = var_1.gameset.child2_shop_refresh_price.key_value
	pg = var_1
	arg_3_0.shopRefreshSellCnt = var_1.gameset.child2_shop_refresh_count.key_value

	return
end

function var_0_1.Show(arg_10_0, arg_10_1)
	var_0_1.super.Show(arg_10_0)

	arg_10_0.siteId = arg_10_1

	arg_10_0:Flush()

	return
end

function var_0_1.Flush(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.child2_site_display[arg_11_0.siteId].type

	NewEducateConst = var_1_10003

	if var_11_0 == var_1_10003.SITE_TYPE.SHOP then
		setText = var_11_0

		local var_11_1 = arg_11_0.shopTF

		var_11_0(var_4.Find(var_11_1, "title"), var_1.title)

		setText = var_11_0

		local var_11_2 = arg_11_0.shopRefreshTF

		var_11_0(var_4.Find(var_11_2, "cost/Text"), arg_11_0.shopRefreshCost)
		arg_11_0:ShowShop()
	else
		arg_11_0:ShowNormal(var_1)
	end

	return
end

function var_0_1.UpdateCost(arg_12_0, arg_12_1, arg_12_2)
	NewEducateHelper = var_1_10003

	local var_12_0 = var_1_10003.GetDropConfig(arg_12_2).icon

	LoadImageSpriteAsync = var_1_10004

	var_1_10004("neweducateicon/" .. var_12_0, arg_12_1:Find("Image"))

	setText = var_1_10004

	var_1_10004(arg_12_1:Find("Text"), "-" .. arg_12_2.number)

	return
end

function var_0_1.ShowNormal(arg_13_0, arg_13_1)
	setActive = var_1_10002

	var_1_10002(arg_13_0.shopTF, false)

	setActive = var_1_10002

	var_1_10002(arg_13_0.normalTF, true)

	setText = var_1_10002

	var_1_10002(arg_13_0.titleTF, arg_13_1.title)

	LoadImageSpriteAsync = var_1_10002

	var_1_10002("neweducateicon/" .. arg_13_1.banner, arg_13_0.picTF, true)

	setText = var_1_10002

	var_1_10002(arg_13_0.nameTF, arg_13_1.title)

	setText = var_1_10002

	var_1_10002(arg_13_0.descTF, arg_13_1.desc)

	NewEducateHelper = var_1_10002

	local var_13_0, var_13_1 = var_1_10002.GetSiteColors(arg_13_1.id)

	setTextColor = var_4

	var_4(arg_13_0.nameTF, var_13_1)

	underscore = var_4

	var_4.each(arg_13_0.imageColorTFs, function(arg_14_0)
		setImageColor = var_2_10001

		var_2_10001(arg_14_0, var_13_0)

		return
	end)

	local var_13_2 = {}
	local var_13_3 = ""

	local function var_13_4()
		return
	end

	switch = var_7

	local var_13_5 = arg_13_1.type
	local var_13_6 = {}

	NewEducateConst = var_1_10011
	var_13_6[var_1_10011.SITE_TYPE.WORK] = function()
		local var_16_0 = arg_13_0.contextData.char
		local var_16_1 = var_0.GetNormalIdByType

		NewEducateConst = var_2_10003

		local var_16_2 = var_16_1(var_16_0, var_2_10003.SITE_NORMAL_TYPE.WORK)

		pg = var_2_10001
		var_13_3 = var_2_10001.child2_site_normal[var_16_2].title
		NewEducateHelper = var_2
		var_13_2 = var_2.Config2Drop(var_1.cost)

		function var_13_4()
			local var_17_0 = arg_13_0
			local var_17_1 = var_0.emit

			NewEducateMapMediator = var_3_10003

			var_17_1(var_17_0, var_3_10003.ON_SITE_NORMAL, var_0.id)

			return
		end

		return
	end
	NewEducateConst = var_11
	var_13_6[var_11.SITE_TYPE.TRAVEL] = function()
		local var_18_0 = arg_13_0.contextData.char
		local var_18_1 = var_0.GetNormalIdByType

		NewEducateConst = var_2_10003

		local var_18_2 = var_18_1(var_18_0, var_2_10003.SITE_NORMAL_TYPE.TRAVEL)

		pg = var_2_10001
		var_13_3 = var_2_10001.child2_site_normal[var_18_2].title
		NewEducateHelper = var_2
		var_13_2 = var_2.Config2Drop(var_1.cost)

		function var_13_4()
			local var_19_0 = arg_13_0
			local var_19_1 = var_0.emit

			NewEducateMapMediator = var_3_10003

			var_19_1(var_19_0, var_3_10003.ON_SITE_NORMAL, var_0.id)

			return
		end

		return
	end
	NewEducateConst = var_11
	var_13_6[var_11.SITE_TYPE.SHIP] = function()
		pg = var_2_10000
		var_13_3 = var_2_10000.child2_site_character[arg_13_1.param].option_name
		NewEducateHelper = var_1
		var_13_2 = var_1.Config2Drop(var_0.cost)

		function var_13_4()
			local var_21_0 = arg_13_0
			local var_21_1 = var_0.emit

			NewEducateMapMediator = var_3_10003

			var_21_1(var_21_0, var_3_10003.ON_SITE_SHIP, var_0.id)

			return
		end

		return
	end
	NewEducateConst = var_11
	var_13_6[var_11.SITE_TYPE.EVENT] = function()
		pg = var_2_10000
		var_13_3 = var_2_10000.child2_site_event_group[arg_13_1.param].option_word
		NewEducateHelper = var_1
		var_13_2 = var_1.Config2Drop(var_0.event_cost)

		function var_13_4()
			local var_23_0 = arg_13_0
			local var_23_1 = var_0.emit

			NewEducateMapMediator = var_3_10003

			var_23_1(var_23_0, var_3_10003.ON_SITE_EVENT, var_0.id)

			return
		end

		return
	end

	var_7(var_13_5, var_13_6)

	setScrollText = var_7

	local var_13_7 = arg_13_0.enterTF

	var_7(var_9.Find(var_13_7, "mask/Text"), var_13_3)

	local var_13_8 = arg_13_0
	local var_13_9 = arg_13_0.UpdateCost
	local var_13_10 = arg_13_0.enterTF

	var_13_9(var_13_8, var_10.Find(var_13_10, "cost"), var_13_2)

	var_13_2.operator = ">="

	local var_13_11 = arg_13_0.contextData.char
	local var_13_12 = not var_7.IsMatch(var_13_11, var_13_2)

	setImageColor = var_1_10008

	local var_13_13 = arg_13_0.enterTF

	Color = var_11

	var_1_10008(var_13_13, var_11.NewHex(var_13_12 and "C8CAD5" or "FFFFFF"))

	setTextColor = var_1_10008

	local var_13_14 = arg_13_0.enterTF
	local var_13_15 = var_10.Find(var_13_14, "mask/Text")

	Color = var_11

	var_1_10008(var_13_15, var_11.NewHex(var_13_12 and "717171" or "393A3C"))

	if not var_13_12 then
		onButton = var_1_10008

		local var_13_16 = arg_13_0
		local var_13_17 = arg_13_0.enterTF

		local function var_13_18()
			var_13_4()

			local var_24_0 = arg_13_0

			var_0.Hide(var_24_0, true)

			return
		end

		SFX_PANEL = var_13

		var_1_10008(var_13_16, var_13_17, var_13_18, var_13)
	else
		removeOnButton = var_1_10008

		var_1_10008(arg_13_0.enterTF)
	end

	return
end

function var_0_1.ShowShop(arg_25_0)
	local var_25_0 = arg_25_0.contextData.char

	arg_25_0.discountInfos = var_1.GetGoodsDiscountInfos(var_25_0)

	local var_25_1 = arg_25_0.contextData.char
	local var_25_2 = var_1.GetFSM(var_25_1)
	local var_25_3 = var_1.GetState

	NewEducateFSM = var_1_10004

	local var_25_4 = var_25_3(var_25_2, var_1_10004.SYSTEM.MAP)

	arg_25_0.goods = var_1.GetGoodList(var_25_4)
	table = var_2

	local var_25_5 = var_2.sort
	local var_25_6 = arg_25_0.goods

	CompareFuncs = var_1_10005

	var_25_5(var_25_6, var_1_10005({
		function(arg_26_0)
			pg = var_2_10001

			local var_26_0 = var_2_10001.child2_shop[arg_26_0.id].limit_num

			return arg_26_0:GetRemainCnt() > 0 and 0 or 1
		end,
		function(arg_27_0)
			return arg_27_0:IsLimitCnt() and 0 or 1
		end,
		function(arg_28_0)
			return arg_28_0.id
		end
	}))

	setActive = var_25_5

	var_25_5(arg_25_0.shopTF, true)

	setActive = var_25_5

	var_25_5(arg_25_0.normalTF, false)

	local var_25_7 = arg_25_0.goodsUIList

	var_2.align(var_25_7, #arg_25_0.goods)
	arg_25_0:UpdateShopRefreshInfos(var_1:GetRefreshShopCnt())

	return
end

function var_0_1.UpdateShopRefreshInfos(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.contextData.char
	local var_29_1 = var_2.GetResByType

	NewEducateChar = var_1_10005

	local var_29_2 = var_29_1(var_29_0, var_1_10005.RES_TYPE.REFRESH_SHOP)

	setText = var_1_10003

	local var_29_3 = arg_29_0.shopRefreshTF

	var_1_10003(var_5.Find(var_29_3, "Text"), var_29_2)

	setActive = var_1_10003

	var_1_10003(arg_29_0.shopRefreshTF, var_29_2 > 0 or arg_29_1 < arg_29_0.shopRefreshSellCnt)

	setActive = var_1_10003

	local var_29_4 = arg_29_0.shopRefreshTF

	var_1_10003(var_5.Find(var_29_4, "Text"), var_29_2 > 0)

	setActive = var_1_10003

	local var_29_5 = arg_29_0.shopRefreshTF

	var_1_10003(var_5.Find(var_29_5, "cost"), var_29_2 <= 0 and arg_29_1 < arg_29_0.shopRefreshSellCnt)

	return
end

function var_0_1.UpdateGoodsItem(arg_30_0, arg_30_1, arg_30_2)
	arg_30_2.name = arg_30_0.goods[arg_30_1 + 1].id
	LoadImageSpriteAsync = var_4

	var_4("neweducateicon/" .. var_3:getConfig("icon"), arg_30_2:Find("frame/icon"))

	setText = var_4

	var_4(arg_30_2:Find("name"), var_3:getConfig("name"))

	setText = var_4

	var_4(arg_30_2:Find("frame/count_bg/count"), "x" .. var_3:getConfig("goods_num"))

	setText = var_4

	var_4(arg_30_2:Find("desc"), var_3:getConfig("desc"))

	setActive = var_4

	var_4(arg_30_2:Find("limit_time"), var_3:IsLimitTime())

	setActive = var_4

	var_4(arg_30_2:Find("limit_cnt"), var_3:IsLimitCnt())

	if var_3:IsLimitCnt() then
		setText = var_4

		local var_30_0 = arg_30_2:Find("limit_cnt")

		i18n = var_7

		var_4(var_30_0, var_7("child2_shop_limit_cnt") .. var_3:GetRemainCnt() .. "/" .. var_3:GetLimitCnt())
	end

	local var_30_1 = var_3:GetRemainCnt() <= 0

	setActive = var_5

	var_5(arg_30_2:Find("sold_out"), var_30_1)

	local var_30_2 = var_3:GetCostCondition()
	local var_30_3

	if var_3:GetCostWithBenefit(arg_30_0.discountInfos).number == var_30_2.number or not ("(" .. var_6.number .. ")") then
		var_30_3 = ""
	end

	setText = var_8

	var_8(arg_30_2:Find("price"), var_30_2.number .. var_30_3)

	if var_30_1 then
		removeOnButton = var_8

		var_8(arg_30_2)
	else
		onButton = var_8

		local var_30_4 = arg_30_0
		local var_30_5 = arg_30_2

		local function var_30_6()
			local var_31_0 = arg_30_0
			local var_31_1 = var_0.emit

			NewEducateBaseUI = var_2_10003

			var_31_1(var_31_0, var_2_10003.ON_SHOP, {
				shopId = var_0.id,
				price = var_0.number,
				onBuy = function()
					local var_32_0 = arg_30_0

					var_0.OnClickBuy(var_32_0, var_0)

					return
				end
			})

			return
		end

		SFX_PANEL = var_13

		var_8(var_30_4, var_30_5, var_30_6, var_13)
	end

	return
end

function var_0_1.SendBuyProto(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0
	local var_33_1 = arg_33_0.emit

	NewEducateMapMediator = var_1_10005

	var_33_1(var_33_0, var_1_10005.ON_SHOPPING, arg_33_1.id)

	return
end

function var_0_1.OnClickBuy(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1:getConfig("goods_type")

	NewEducateGoods = var_1_10003

	if var_34_0 == var_1_10003.TYPE.BENEFIT then
		arg_34_0:ClickBenefitGood(arg_34_1)
	else
		NewEducateGoods = var_3

		if var_34_0 == var_3.TYPE.RES then
			arg_34_0:ClickResGood(arg_34_1)
		else
			NewEducateGoods = var_3

			if var_34_0 == var_3.TYPE.UP_ENTRY then
				existCall = var_3

				var_3(arg_34_0.contextData.onClickUpEntryGood, arg_34_1)
			else
				arg_34_0:SendBuyProto(arg_34_1)
			end
		end
	end

	return
end

function var_0_1.ClickBenefitGood(arg_35_0, arg_35_1)
	local var_35_0 = {}
	local var_35_1 = arg_35_1
	local var_35_2 = arg_35_1.getConfig(var_35_1, "goods_id")
	local var_35_3 = arg_35_0.contextData.char

	if var_4.GetStatus(var_35_3, arg_35_1:getConfig("goods_id")) and var_4:getConfig("is_tip") == 0 then
		local var_35_4 = var_4

		var_35_1 = var_4.GetEndRound(var_35_4)

		local var_35_5 = arg_35_0.contextData.char

		var_35_1 = var_35_1 - var_6.GetRoundData(var_35_5).round

		local var_35_6 = var_4:getConfig("during_time") == -1 and "child2_shop_benefit_sure2" or "child2_shop_benefit_sure"

		table = var_35_4

		var_35_4.insert(var_35_0, function(arg_36_0)
			local var_36_0 = arg_35_0
			local var_36_1 = var_1.emit

			NewEducateBaseUI = var_2_10004

			local var_36_2 = var_2_10004.ON_BOX
			local var_36_3 = {}

			i18n = var_2_10006
			var_36_3.content = var_2_10006(var_35_6, var_35_1)
			var_36_3.onYes = arg_36_0

			var_36_1(var_36_0, var_36_2, var_36_3)

			return
		end)
	end

	seriesAsync = var_35_1

	var_35_1(var_35_0, function()
		local var_37_0 = arg_35_0

		var_0.SendBuyProto(var_37_0, arg_35_1)

		return
	end)

	return
end

function var_0_1.ClickResGood(arg_38_0, arg_38_1)
	local var_38_0 = {}
	local var_38_1 = arg_38_0.contextData.char
	local var_38_2 = var_3.GetResIdByType

	NewEducateChar = var_1_10006

	local var_38_3 = var_38_2(var_38_1, var_1_10006.RES_TYPE.ACTION)

	if arg_38_1:getConfig("goods_id") == var_38_3 then
		local var_38_4 = arg_38_0.contextData.char
		local var_38_5 = var_4.GetPoint(var_38_4, var_38_3) + arg_38_1:getConfig("goods_num")

		pg = var_38_4

		if var_38_5 > var_38_4.child2_resource[var_38_3].max_value then
			table = var_38_5

			var_38_5.insert(var_38_0, function(arg_39_0)
				local var_39_0 = arg_38_0
				local var_39_1 = var_1.emit

				NewEducateBaseUI = var_2_10004

				local var_39_2 = var_2_10004.ON_BOX
				local var_39_3 = {}

				i18n = var_2_10006
				var_39_3.content = var_2_10006("child2_shop_point_sure")
				var_39_3.onYes = arg_39_0

				var_39_1(var_39_0, var_39_2, var_39_3)

				return
			end)
		end
	end

	seriesAsync = var_4

	var_4(var_38_0, function()
		local var_40_0 = arg_38_0

		var_0.SendBuyProto(var_40_0, arg_38_1)

		return
	end)

	return
end

function var_0_1.FlushShop(arg_41_0)
	arg_41_0:ShowShop()

	return
end

function var_0_1.Hide(arg_42_0, arg_42_1)
	if not arg_42_1 then
		existCall = var_1_10002

		var_1_10002(arg_42_0.contextData.onHide)
	end

	arg_42_0.super.Hide(arg_42_0)

	return
end

function var_0_1.OnDestroy(arg_43_0)
	return
end

return var_0_1
