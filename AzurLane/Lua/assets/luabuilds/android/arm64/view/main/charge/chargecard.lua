class = var_0_10000

local var_0_0 = var_0_10000("ChargeCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	tf = var_1_10002
	arg_1_0.tr = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0.tr

	arg_1_0.icon = var_2.Find(var_1_0, "real_tpl/item_icon")

	local var_1_1 = arg_1_0.icon
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.iconTF = var_1_2(var_1_1, var_5(var_1_10007))

	local var_1_3 = arg_1_0.tr

	arg_1_0.shipIcon = var_2.Find(var_1_3, "real_tpl/item_icon/ship")

	local var_1_4 = arg_1_0.tr

	arg_1_0.priceTf = var_2.Find(var_1_4, "real_tpl/Price/Text")

	local var_1_5 = arg_1_0.priceTf
	local var_1_6 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.price = var_1_6(var_1_5, var_5(var_1_10007))

	local var_1_7 = arg_1_0.tr

	arg_1_0.freeTag = var_2.Find(var_1_7, "real_tpl/Price/FreeText")

	local var_1_8 = arg_1_0.tr

	arg_1_0.tecShipBuyTag = var_2.Find(var_1_8, "real_tpl/Price/BuyText")

	local var_1_9 = arg_1_0.tr

	arg_1_0.contain = var_2.Find(var_1_9, "real_tpl/Price")

	local var_1_10 = arg_1_0.tr

	arg_1_0.rmb = var_2.Find(var_1_10, "real_tpl/Price/icon_rmb")

	local var_1_11 = arg_1_0.tr

	arg_1_0.gem = var_2.Find(var_1_11, "real_tpl/Price/icon_gem")

	local var_1_12 = arg_1_0.tr

	arg_1_0.name = var_2.Find(var_1_12, "real_tpl/item_name_mask/item_name")

	local var_1_13 = arg_1_0.tr

	arg_1_0.itemPanel1 = var_2.Find(var_1_13, "real_tpl/itemPanel1")

	local var_1_14 = arg_1_0.tr

	arg_1_0.firstTipText = var_2.Find(var_1_14, "real_tpl/itemPanel1/Tip/Text")

	local var_1_15 = arg_1_0.tr

	arg_1_0.secondTipText = var_2.Find(var_1_15, "real_tpl/itemPanel1/Tip2/Text")

	local var_1_16 = arg_1_0.tr

	arg_1_0.grid = var_2.Find(var_1_16, "real_tpl/itemPanel1/grid")

	local var_1_17 = arg_1_0.tr

	arg_1_0.grid1 = var_2.Find(var_1_17, "real_tpl/itemPanel1/grid1")

	local var_1_18 = arg_1_0.tr

	arg_1_0.itemPanel2 = var_2.Find(var_1_18, "real_tpl/itemPanel2")

	local var_1_19 = arg_1_0.tr

	arg_1_0.firstTipText2 = var_2.Find(var_1_19, "real_tpl/itemPanel2/Tip/Text")

	local var_1_20 = arg_1_0.tr

	arg_1_0.addImage = var_2.Find(var_1_20, "real_tpl/itemPanel2/addImg")

	local var_1_21 = arg_1_0.tr

	arg_1_0.grid2 = var_2.Find(var_1_21, "real_tpl/itemPanel2/grid")

	local var_1_22 = arg_1_0.tr

	arg_1_0.itemPanel3 = var_2.Find(var_1_22, "real_tpl/itemPanel3")

	local var_1_23 = arg_1_0.tr

	arg_1_0.firstTipText3 = var_2.Find(var_1_23, "real_tpl/itemPanel3/Tip/Text")

	local var_1_24 = arg_1_0.tr

	arg_1_0.grid3 = var_2.Find(var_1_24, "real_tpl/itemPanel3/grid")

	local var_1_25 = arg_1_0.tr

	arg_1_0.limitText = var_2.Find(var_1_25, "real_tpl/LimitText")

	local var_1_26 = arg_1_0.tr

	arg_1_0.viewBtn = var_2.Find(var_1_26, "real_tpl/view")

	local var_1_27 = arg_1_0.tr

	arg_1_0.numLeftText = var_2.Find(var_1_27, "real_tpl/leftTimeText")

	local var_1_28 = arg_1_0.tr

	arg_1_0.focusTip = var_2.Find(var_1_28, "real_tpl/focus_tip")

	local var_1_29 = arg_1_0.tr

	arg_1_0.tag = var_2.Find(var_1_29, "real_tpl/tag")
	arg_1_0.tags = {}
	table = var_2

	local var_1_30 = var_2.insert
	local var_1_31 = arg_1_0.tags
	local var_1_32 = arg_1_0.tr

	var_1_30(var_1_31, var_5.Find(var_1_32, "real_tpl/tag/hot"))

	table = var_1_30

	local var_1_33 = var_1_30.insert
	local var_1_34 = arg_1_0.tags
	local var_1_35 = arg_1_0.tr

	var_1_33(var_1_34, var_5.Find(var_1_35, "real_tpl/tag/new"))

	table = var_1_33

	local var_1_36 = var_1_33.insert
	local var_1_37 = arg_1_0.tags
	local var_1_38 = arg_1_0.tr

	var_1_36(var_1_37, var_5.Find(var_1_38, "real_tpl/tag/advice"))

	table = var_1_36

	local var_1_39 = var_1_36.insert
	local var_1_40 = arg_1_0.tags
	local var_1_41 = arg_1_0.tr

	var_1_39(var_1_40, var_5.Find(var_1_41, "real_tpl/tag/double"))

	table = var_1_39

	local var_1_42 = var_1_39.insert
	local var_1_43 = arg_1_0.tags
	local var_1_44 = arg_1_0.tr

	var_1_42(var_1_43, var_5.Find(var_1_44, "real_tpl/tag/activity"))

	table = var_1_42

	local var_1_45 = var_1_42.insert
	local var_1_46 = arg_1_0.tags
	local var_1_47 = arg_1_0.tr

	var_1_45(var_1_46, var_5.Find(var_1_47, "real_tpl/tag/time"))

	table = var_1_45

	local var_1_48 = var_1_45.insert
	local var_1_49 = arg_1_0.tags
	local var_1_50 = arg_1_0.tr

	var_1_48(var_1_49, var_5.Find(var_1_50, "real_tpl/tag/discount"))

	local var_1_51 = arg_1_0.tr

	arg_1_0.packageTag = var_2.Find(var_1_51, "real_tpl/package_tag")

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.goods = arg_2_1
	IsNil = var_1_10004

	if not var_1_10004(arg_2_0.shipIcon) then
		setActive = var_4

		var_4(arg_2_0.shipIcon, false)
	end

	local var_2_0 = arg_2_1
	local var_2_1

	if arg_2_1.isChargeType(var_2_0) then
		var_2_0 = arg_2_1
		var_2_1 = arg_2_1.getShowType(var_2_0) ~= ""
	end

	setActive = var_1_10005

	local var_2_2 = arg_2_0.rmb
	local var_2_3

	if arg_2_1:isChargeType() then
		var_2_3 = not var_2_1
	end

	var_1_10005(var_2_2, var_2_3)

	setActive = var_1_10005

	var_1_10005(arg_2_0.gem, not arg_2_1:isChargeType() and not arg_2_1:isFree())

	setText = var_1_10005

	local var_2_4 = arg_2_0.freeTag

	i18n = var_8

	var_1_10005(var_2_4, var_8("shop_free_tag"))

	setText = var_1_10005

	local var_2_5 = arg_2_0.tecShipBuyTag

	i18n = var_8

	var_1_10005(var_2_5, var_8("word_buy"))

	setActive = var_1_10005

	var_1_10005(arg_2_0.tecShipBuyTag, var_2_1)

	setActive = var_1_10005

	var_1_10005(arg_2_0.freeTag, arg_2_1:isFree())

	setActive = var_1_10005

	var_1_10005(arg_2_0.priceTf, not arg_2_1:isFree() and not var_2_1)

	pg = var_1_10005

	local var_2_6 = var_1_10005.EasyRedDotMgr.GetInstance()

	var_5.RegisterRedDot(var_2_6, arg_2_0.focusTip, {
		"Charge_Page_Exposure"
	}, function(arg_3_0)
		setActive = var_2_10001

		local var_3_0 = arg_3_0
		local var_3_1 = arg_2_1

		var_2_10001(var_3_0, var_4.isTip(var_3_1))

		return
	end)

	setActive = var_5

	var_5(arg_2_0.icon, arg_2_1:isChargeType())

	setActive = var_5

	var_5(arg_2_0.contain, true)

	if arg_2_0.viewBtn then
		setActive = var_5

		local var_2_7 = arg_2_0.viewBtn
		local var_2_8

		if arg_2_1:isChargeType() then
			var_2_8 = arg_2_1:CanViewSkinProbability()
		end

		var_5(var_2_7, var_2_8)
	end

	if arg_2_0.packageTag then
		local var_2_9 = arg_2_1:GetPackageTag()

		setActive = var_2_0

		var_2_0(arg_2_0.packageTag, var_2_9 ~= "")

		setText = var_2_0

		local var_2_10 = arg_2_0.packageTag

		var_2_0(var_8.Find(var_2_10, "Text"), var_2_9)
	end

	if arg_2_1:isChargeType() then
		arg_2_0:updateCharge(arg_2_1, arg_2_2, arg_2_3)
	else
		arg_2_0:updateGemItem(arg_2_1, arg_2_2)
	end

	arg_2_0:destoryTimer()

	return
end

function var_0_0.updateCharge(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	setActive = var_1_10004

	var_1_10004(arg_4_0.tag, true)

	table = var_1_10004

	local var_4_0, var_4_1

	if not var_1_10004.contains(arg_4_3, arg_4_1.id) then
		::label_4_0::

		var_4_0 = arg_4_1
		var_4_1 = arg_4_1.firstPayDouble(var_4_0)
	end

	local var_4_2 = var_4_1 and 4 or arg_4_1:getConfig("tag")

	setActive = var_4_0

	var_4_0(arg_4_0.tag, var_4_2 > 0)

	if 0 < var_4_2 then
		ipairs = var_7

		for iter_4_0, iter_4_1 in var_7(arg_4_0.tags) do
			setActive = var_1_10012

			var_1_10012(iter_4_1, iter_4_0 == var_4_2)
		end
	end

	setActive = var_7

	var_7(arg_4_0.numLeftText, false)

	local var_4_3, var_4_4 = arg_4_1:inTime()
	local var_4_5 = arg_4_1:getConfig("id")

	ActivityConst = var_10

	local var_4_6 = var_4_5 == var_10.FREE_PACKAGE_SHOW_TIME_ID
	local var_4_8

	if var_4_3 and (not arg_4_1:isFree() or var_4_6) and var_4_4 and 0 < var_4_4 then
		setActive = var_4_8

		var_4_8(arg_4_0.numLeftText, true)

		pg = var_4_8

		local var_4_7 = var_4_8.TimeMgr.GetInstance()
		local var_4_9, var_4_10

		var_4_8, var_4_9, var_4_10 = var_4_8.parseTimeFrom(var_4_7, var_4_4)

		if 0 < var_4_8 then
			setText = var_13

			local var_4_11 = arg_4_0.numLeftText

			i18n = var_1_10016

			var_13(var_4_11, var_1_10016("shop_goods_left_day", var_4_8))
		elseif 0 < var_4_9 then
			setText = var_13

			local var_4_12 = arg_4_0.numLeftText

			i18n = var_1_10016

			var_13(var_4_12, var_1_10016("shop_goods_left_hour", var_4_9))
		elseif var_4_10 then
			setText = var_13

			local var_4_13 = arg_4_0.numLeftText

			i18n = var_1_10016

			var_13(var_4_13, var_1_10016("shop_goods_left_minute", var_4_10 > 0 and var_4_10 or 1))
		end

		local var_4_14 = 60
		local var_4_15 = 3600
		local var_4_16 = 0
		local var_4_17

		if var_4_16 <= var_4_4 then
			var_4_17 = var_4_4 % var_4_16
		elseif var_4_15 <= var_4_4 then
			var_4_17 = var_4_4 % var_4_15
		elseif var_4_14 <= var_4_4 then
			var_4_17 = var_4_4 % var_4_14
		end

		if var_4_17 and var_4_17 > 0 then
			if arg_4_0.countDownTimer then
				local var_4_18 = arg_4_0.countDownTimer

				var_17.Stop(var_4_18)

				arg_4_0.countDownTimer = nil
			end

			Timer = var_17
			arg_4_0.countDownTimer = var_17.New(function()
				local var_5_0 = arg_4_0

				var_0.updateGemItem(var_5_0, arg_4_1, arg_4_2)

				return
			end, var_4_17, 1)

			local var_4_19 = arg_4_0.countDownTimer

			var_17.Start(var_4_19)
		end
	end

	setScrollText = var_4_8

	var_4_8(arg_4_0.name, arg_4_1:getConfig("name_display"))

	if arg_4_1:isItemBox() or arg_4_1:isGiftBox() or arg_4_1:isPassItem() then
		arg_4_0:updateImport(arg_4_0:GetPayDisplayItemData(arg_4_1))
	end

	local var_4_20 = arg_4_1:getConfig("limit_type")
	local var_4_21 = arg_4_1
	local var_4_22 = arg_4_1.getBuyCount(var_4_21)
	local var_4_23 = arg_4_1:getLimitCount()

	if var_4_20 == 2 then
		setText = var_4_21

		local var_4_24 = arg_4_0.limitText

		i18n = var_16

		var_4_21(var_4_24, var_16("charge_limit_all", var_4_23 - var_4_22, var_4_23))
	elseif var_4_20 == 4 then
		setText = var_4_21

		local var_4_25 = arg_4_0.limitText

		i18n = var_16

		var_4_21(var_4_25, var_16("charge_limit_daily", var_4_23 - var_4_22, var_4_23))
	else
		setText = var_4_21

		var_4_21(arg_4_0.limitText, "")
	end

	local var_4_26 = arg_4_0.price

	var_4_26.text = arg_4_1:getConfig("money")
	PLATFORM_CODE = var_4_26
	PLATFORM_CHT = var_14

	if var_4_26 == var_14 and arg_4_1:IsLocalPrice() then
		setActive = var_13

		var_13(arg_4_0.rmb, false)
	end

	local var_4_27 = arg_4_0.iconTF

	GetSpriteFromAtlas = var_14
	var_4_27.sprite = var_14("chargeicon/1", "")
	LoadSpriteAsync = var_4_27

	var_4_27("chargeicon/" .. arg_4_1:getConfig("picture"), function(arg_6_0)
		if arg_6_0 then
			IsNil = var_2_10001

			if not var_2_10001(arg_4_0.iconTF) then
				arg_4_0.iconTF.sprite = arg_6_0
			end
		end

		return
	end)

	return
end

function var_0_0.UpdateShipIcon(arg_7_0, arg_7_1)
	IsNil = var_1_10002

	if var_1_10002(arg_7_0.shipIcon) then
		return
	end

	setActive = var_2

	var_2(arg_7_0.shipIcon, true)

	local var_7_0 = arg_7_0.shipIcon
	local var_7_1 = var_2.Find(var_7_0, "icon")
	local var_7_2 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007

	local var_7_3 = var_7_2(var_7_1, var_5(var_1_10007))
	local var_7_4 = arg_7_1:getConfigTable().usage_arg[1][1]

	assert = var_7_1

	var_7_1(var_7_4)

	pg = var_7_1

	local var_7_5 = var_7_1.shop_template[var_7_4].effect_args[1]

	assert = var_6

	var_6(var_7_5)

	pg = var_6

	local var_7_6 = var_6.ship_skin_template[var_7_5]

	LoadSpriteAsync = var_1_10007

	var_1_10007("qicon/" .. var_7_6.prefab, function(arg_8_0)
		if arg_8_0 then
			IsNil = var_2_10001

			if not var_2_10001(arg_7_0.shipIcon) then
				var_7_3.sprite = arg_8_0
			end
		end

		return
	end)

	return
end

function var_0_0.updateGemItem(arg_9_0, arg_9_1, arg_9_2)
	setText = var_1_10003

	var_1_10003(arg_9_0.limitText, "")

	local var_9_0 = arg_9_1:getLimitCount()
	local var_9_1 = arg_9_1:getBuyCount()

	if 0 < var_9_0 then
		setText = var_5

		local var_9_2 = arg_9_0.limitText

		i18n = var_1_10008

		var_5(var_9_2, var_1_10008("charge_limit_all", var_9_0 - var_9_1, var_9_0))
	end

	local var_9_3 = arg_9_1

	if arg_9_1.getConfig(var_9_3, "group_limit") > 0 then
		local var_9_4

		if not arg_9_1:getConfig("group_type") then
			var_9_4 = 0
		end

		if var_9_4 == 1 then
			setText = var_9_3

			local var_9_5 = arg_9_0.limitText

			i18n = var_1_10010

			var_9_3(var_9_5, var_1_10010("charge_limit_daily", var_5 - arg_9_1.groupCount, var_5))
		elseif var_9_4 == 2 then
			setText = var_9_3

			local var_9_6 = arg_9_0.limitText

			i18n = var_1_10010

			var_9_3(var_9_6, var_1_10010("charge_limit_weekly", var_5 - arg_9_1.groupCount, var_5))
		elseif var_9_4 == 3 then
			setText = var_9_3

			local var_9_7 = arg_9_0.limitText

			i18n = var_1_10010

			var_9_3(var_9_7, var_1_10010("charge_limit_monthly", var_5 - arg_9_1.groupCount, var_5))
		end
	end

	local var_9_8 = arg_9_0.price

	var_9_8.text = arg_9_1:GetPrice()
	setActive = var_9_8

	var_9_8(arg_9_0.icon, true)

	local var_9_9 = arg_9_1:getConfig("tag")

	setActive = var_7

	var_7(arg_9_0.tag, var_9_9 > 0)

	if 0 < var_9_9 then
		ipairs = var_7

		for iter_9_0, iter_9_1 in var_7(arg_9_0.tags) do
			setActive = var_1_10012

			var_1_10012(iter_9_1, iter_9_0 == var_9_9)
		end
	end

	setActive = var_7

	var_7(arg_9_0.numLeftText, false)

	local var_9_10, var_9_11 = arg_9_1:inTime()
	local var_9_12 = arg_9_1:getConfig("id")

	ActivityConst = var_10

	local var_9_13 = var_9_12 == var_10.FREE_PACKAGE_SHOW_TIME_ID
	local var_9_15

	if var_9_10 and (not arg_9_1:isFree() or var_9_13) and var_9_11 and 0 < var_9_11 then
		setActive = var_9_15

		var_9_15(arg_9_0.numLeftText, true)

		pg = var_9_15

		local var_9_14 = var_9_15.TimeMgr.GetInstance()
		local var_9_16, var_9_17

		var_9_15, var_9_16, var_9_17 = var_9_15.parseTimeFrom(var_9_14, var_9_11)

		if 0 < var_9_15 then
			setText = var_13

			local var_9_18 = arg_9_0.numLeftText

			i18n = var_1_10016

			var_13(var_9_18, var_1_10016("shop_goods_left_day", var_9_15))
		elseif 0 < var_9_16 then
			setText = var_13

			local var_9_19 = arg_9_0.numLeftText

			i18n = var_1_10016

			var_13(var_9_19, var_1_10016("shop_goods_left_hour", var_9_16))
		elseif var_9_17 then
			setText = var_13

			local var_9_20 = arg_9_0.numLeftText

			i18n = var_1_10016

			var_13(var_9_20, var_1_10016("shop_goods_left_minute", var_9_17 > 0 and var_9_17 or 1))
		end

		local var_9_21 = 60
		local var_9_22 = 3600
		local var_9_23 = 0
		local var_9_24

		if var_9_23 <= var_9_11 then
			var_9_24 = var_9_11 % var_9_23
		elseif var_9_22 <= var_9_11 then
			var_9_24 = var_9_11 % var_9_22
		elseif var_9_21 <= var_9_11 then
			var_9_24 = var_9_11 % var_9_21
		end

		if var_9_24 and var_9_24 > 0 then
			if arg_9_0.countDownTimer then
				local var_9_25 = arg_9_0.countDownTimer

				var_17.Stop(var_9_25)

				arg_9_0.countDownTimer = nil
			end

			Timer = var_17
			arg_9_0.countDownTimer = var_17.New(function()
				local var_10_0 = arg_9_0

				var_0.updateGemItem(var_10_0, arg_9_1, arg_9_2)

				return
			end, var_9_24, 1)

			local var_9_26 = arg_9_0.countDownTimer

			var_17.Start(var_9_26)
		end
	end

	setActive = var_9_15

	var_9_15(arg_9_0.name, true)

	local var_9_27 = #arg_9_1:getConfig("effect_args")

	if 0 < var_9_27 then
		Item = var_9_27

		if var_9_27.getConfigData(var_10[1]) then
			setScrollText = var_12

			var_12(arg_9_0.name, var_11.name)
			arg_9_0:updateImport(arg_9_0:GetShopDisplayItemData(arg_9_1))

			if arg_9_0:CheckSkinDiscounItem(var_11.display_icon) then
				arg_9_0:UpdateShipIcon(var_12)
			end
		end

		local var_9_28 = arg_9_0.iconTF

		GetSpriteFromAtlas = var_13
		var_9_28.sprite = var_13("chargeicon/1", "")
		LoadSpriteAsync = var_9_28

		var_9_28(var_11.icon, function(arg_11_0)
			if arg_11_0 then
				IsNil = var_2_10001

				if not var_2_10001(arg_9_0.iconTF) then
					arg_9_0.iconTF.sprite = arg_11_0
				end
			end

			return
		end)
	end

	return
end

function var_0_0.CheckSkinDiscounItem(arg_12_0, arg_12_1)
	pairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_1) do
		Drop = var_1_10007

		local var_12_0 = var_1_10007.Create(iter_12_1)

		if var_1_10007.getConfigTable(var_12_0).usage then
			local var_12_1 = var_8.usage

			ItemUsage = var_12_0

			if var_12_1 == var_12_0.USAGE_SHOP_DISCOUNT then
				return var_1_10007
			end
		end
	end

	return nil
end

local function var_0_1(arg_13_0)
	local var_13_0 = arg_13_0

	if arg_13_0.getConfigTable(var_13_0).usage then
		local var_13_1 = var_1.usage

		ItemUsage = var_13_0

		if var_13_1 == var_13_0.USAGE_SKIN_EXP then
			return false
		end
	end

	return true
end

function var_0_0.updateImport(arg_14_0, arg_14_1)
	local var_14_0 = #arg_14_1
	local var_14_1 = 2 <= var_14_0

	setActive = var_3

	var_3(arg_14_0.itemPanel1, var_14_1)

	if var_14_1 then
		setActive = var_3

		var_3(arg_14_0.itemPanel2, false)

		setActive = var_3

		var_3(arg_14_0.itemPanel3, false)

		setScrollText = var_3

		var_3(arg_14_0.firstTipText, arg_14_1[1].text)

		setScrollText = var_3

		var_3(arg_14_0.secondTipText, arg_14_1[2].text)

		local var_14_2 = {}

		ipairs = var_1_10004

		for iter_14_0, iter_14_1 in var_1_10004(arg_14_1[1].list) do
			table = var_1_10009
			var_1_10009 = var_1_10009.insert
			var_1_10011 = var_14_2
			Drop = var_1_10012

			var_1_10009(var_1_10011, var_1_10012.Create(iter_14_1))
		end

		for iter_14_2 = 1, arg_14_0.grid1.childCount do
			var_1_10010 = arg_14_0.grid

			local var_14_3 = var_8.GetChild(var_1_10010, iter_14_2 - 1)

			if iter_14_2 <= #var_14_2 then
				setActive = var_9

				var_9(var_14_3, var_0_1(var_14_2[iter_14_2]))

				updateDrop = var_9
				var_1_10013 = var_14_3

				var_9(var_14_3.Find(var_1_10013, "itemBg/item"), var_14_2[iter_14_2])
			else
				setActive = var_9

				var_9(var_14_3, false)
			end
		end

		local var_14_4 = {}

		ipairs = var_14_9

		for iter_14_3, iter_14_4 in var_14_9(arg_14_1[2].list) do
			table = var_1_10010
			var_1_10010 = var_1_10010.insert

			local var_14_5 = var_14_4

			Drop = var_1_10013

			var_1_10010(var_14_5, var_1_10013.Create(iter_14_4))
		end

		for iter_14_5 = 1, arg_14_0.grid1.childCount do
			var_1_10011 = arg_14_0.grid1

			local var_14_6 = var_9.GetChild(var_1_10011, iter_14_5 - 1)

			if iter_14_5 <= #var_14_4 then
				setActive = var_10

				var_10(var_14_6, var_0_1(var_14_4[iter_14_5]))

				updateDrop = var_10
				var_1_10014 = var_14_6

				var_10(var_14_6.Find(var_1_10014, "itemBg/item"), var_14_4[iter_14_5])
			else
				setActive = var_10

				var_10(var_14_6, false)
			end
		end
	else
		local var_14_7 = arg_14_1[1].text == ""

		setActive = var_14_9

		var_14_9(arg_14_0.itemPanel2, not var_14_7)

		setActive = var_14_9

		var_14_9(arg_14_0.itemPanel3, var_14_7)

		local var_14_9

		if var_14_7 then
			setScrollText = var_14_9

			local var_14_8 = arg_14_0.firstTipText3

			i18n = var_8

			var_14_9(var_14_8, var_8("shop_item_unlock"))

			var_14_9 = {}
			ipairs = var_6

			for iter_14_6, iter_14_7 in var_6(arg_14_1[1].list) do
				table = var_1_10011
				var_1_10011 = var_1_10011.insert

				local var_14_10 = var_14_9

				Drop = var_1_10014

				var_1_10011(var_14_10, var_1_10014.Create(iter_14_7))
			end

			for iter_14_8 = 1, arg_14_0.grid3.childCount do
				local var_14_11 = arg_14_0.grid3
				local var_14_12 = var_10.GetChild(var_14_11, iter_14_8 - 1)

				if iter_14_8 <= #var_14_9 then
					setActive = var_1_10011

					var_1_10011(var_14_12, var_0_1(var_14_9[iter_14_8]))

					updateDrop = var_1_10011

					var_1_10011(var_14_12:Find("itemBg/item"), var_14_9[iter_14_8])
				else
					setActive = var_1_10011

					var_1_10011(var_14_12, false)
				end
			end
		else
			setScrollText = var_14_9

			var_14_9(arg_14_0.firstTipText2, var_3)

			local var_14_13 = {}

			ipairs = var_6

			for iter_14_9, iter_14_10 in var_6(arg_14_1[1].list) do
				table = var_1_10011
				var_1_10011 = var_1_10011.insert

				local var_14_14 = var_14_13

				Drop = var_1_10014

				var_1_10011(var_14_14, var_1_10014.Create(iter_14_10))
			end

			for iter_14_11 = 1, arg_14_0.grid2.childCount do
				local var_14_15 = arg_14_0.grid2
				local var_14_16 = var_10.GetChild(var_14_15, iter_14_11 - 1)

				if iter_14_11 <= #var_14_13 then
					setActive = var_11

					var_11(var_14_16, var_0_1(var_14_13[iter_14_11]))

					updateDrop = var_11

					var_11(var_14_16:Find("itemBg/item"), var_14_13[iter_14_11])
				else
					setActive = var_11

					var_11(var_14_16, false)
				end
			end
		end
	end

	return
end

function var_0_0.GetPayDisplayItemData(arg_15_0, arg_15_1)
	local var_15_0 = {}
	local var_15_1 = arg_15_1

	if arg_15_1.getConfig(var_15_1, "first_text") ~= "" then
		table = var_1_10004

		var_1_10004.insert(var_15_0, {
			text = var_3,
			list = arg_15_1:getConfig("first_icon")
		})
	end

	local var_15_2 = arg_15_1:getConfig("second_text")

	table = var_15_1

	var_15_1.insert(var_15_0, {
		text = var_15_2,
		list = arg_15_1:getConfig("display")
	})

	return var_15_0
end

function var_0_0.GetShopDisplayItemData(arg_16_0, arg_16_1)
	local var_16_0 = {}

	if arg_16_1:getConfig("first_text") ~= "" then
		table = var_1_10004

		var_1_10004.insert(var_16_0, {
			text = var_3,
			list = arg_16_1:getConfig("first_icon")
		})
	end

	local var_16_1 = arg_16_1
	local var_16_2 = arg_16_1.getConfig(var_16_1, "second_text")
	local var_16_3 = arg_16_1
	local var_16_4 = arg_16_1.getConfig(var_16_3, "effect_args")

	Item = var_16_1

	local var_16_5 = var_16_1.getConfigData(var_16_4[1])

	table = var_16_3

	var_16_3.insert(var_16_0, {
		text = var_16_2,
		list = var_16_5.display_icon
	})

	return var_16_0
end

function var_0_0.destoryTimer(arg_17_0)
	if arg_17_0.countDownTimer then
		local var_17_0 = arg_17_0.countDownTimer

		var_1.Stop(var_17_0)

		arg_17_0.countDownTimer = nil
	end

	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:destoryTimer()

	pg = var_1

	local var_18_0 = var_1.EasyRedDotMgr.GetInstance()

	var_1.UnRegisterRedDot(var_18_0, arg_18_0.focusTip)

	return
end

return var_0_0
