class = var_0_10000

local var_0_0 = var_0_10000("OldChargeCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	tf = var_1_10002
	arg_1_0.tr = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0.tr

	arg_1_0.icon = var_2.Find(var_1_0, "real_tpl/item_icon")

	local var_1_1 = arg_1_0.icon
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.iconTF = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0.tr

	arg_1_0.shipIcon = var_2.Find(var_1_3, "real_tpl/item_icon/ship")

	local var_1_4 = arg_1_0.tr

	arg_1_0.tipTF = var_2.Find(var_1_4, "real_tpl/tip")

	local var_1_5 = arg_1_0.tipTF
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.tipText = var_1_6(var_1_5, var_4(var_1_10005))

	local var_1_7 = arg_1_0.tr

	arg_1_0.count = var_2.Find(var_1_7, "real_tpl/count")

	local var_1_8 = arg_1_0.tr
	local var_1_9 = var_2.Find(var_1_8, "real_tpl/count/icon")
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.resIcon = var_1_10(var_1_9, var_4(var_1_10005))

	local var_1_11 = arg_1_0.tr
	local var_1_12 = var_2.Find(var_1_11, "real_tpl/count/Text")
	local var_1_13 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.resCount = var_1_13(var_1_12, var_4(var_1_10005))

	local var_1_14 = arg_1_0.tr

	arg_1_0.priceTf = var_2.Find(var_1_14, "real_tpl/prince_bg/contain/Text")

	local var_1_15 = arg_1_0.priceTf
	local var_1_16 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.price = var_1_16(var_1_15, var_4(var_1_10005))

	local var_1_17 = arg_1_0.tr

	arg_1_0.freeTag = var_2.Find(var_1_17, "real_tpl/prince_bg/contain/FreeText")

	local var_1_18 = arg_1_0.tr

	arg_1_0.tecShipBuyTag = var_2.Find(var_1_18, "real_tpl/prince_bg/contain/BuyText")

	local var_1_19 = arg_1_0.tr

	arg_1_0.contain = var_2.Find(var_1_19, "real_tpl/prince_bg/contain")

	local var_1_20 = arg_1_0.tr

	arg_1_0.rmb = var_2.Find(var_1_20, "real_tpl/prince_bg/contain/icon_rmb")

	local var_1_21 = arg_1_0.tr

	arg_1_0.gem = var_2.Find(var_1_21, "real_tpl/prince_bg/contain/icon_gem")

	local var_1_22 = arg_1_0.tr

	arg_1_0.mask = var_2.Find(var_1_22, "real_tpl/mask")

	local var_1_23 = arg_1_0.mask

	arg_1_0.maskState = var_2.Find(var_1_23, "state")

	local var_1_24 = arg_1_0.tr

	arg_1_0.name = var_2.Find(var_1_24, "real_tpl/item_name_mask/item_name")

	local var_1_25 = arg_1_0.tr

	arg_1_0.important = var_2.Find(var_1_25, "real_tpl/important")

	local var_1_26 = arg_1_0.tr

	arg_1_0.grid = var_2.Find(var_1_26, "real_tpl/important/grid")

	local var_1_27 = arg_1_0.tr

	arg_1_0.importantTip = var_2.Find(var_1_27, "real_tpl/important/tip")

	local var_1_28 = arg_1_0.tr

	arg_1_0.desc = var_2.Find(var_1_28, "real_tpl/desc")

	local var_1_29 = arg_1_0.tr

	arg_1_0.selfTpl = var_2.Find(var_1_29, "real_tpl/important/item")

	local var_1_30 = arg_1_0.tr

	arg_1_0.limitText = var_2.Find(var_1_30, "real_tpl/LimitText")

	local var_1_31 = arg_1_0.tr

	arg_1_0.countDown = var_2.Find(var_1_31, "real_tpl/countDown")

	local var_1_32 = arg_1_0.countDown

	arg_1_0.countDownTm = var_2.Find(var_1_32, "Text")

	local var_1_33 = arg_1_0.tr

	arg_1_0.viewBtn = var_2.Find(var_1_33, "real_tpl/view")

	local var_1_34 = arg_1_0.tr

	arg_1_0.timeLeftTag = var_2.Find(var_1_34, "real_tpl/time_left")

	local var_1_35 = arg_1_0.tr

	arg_1_0.dayLeftTag = var_2.Find(var_1_35, "real_tpl/time_left/day")

	local var_1_36 = arg_1_0.tr

	arg_1_0.hourLeftTag = var_2.Find(var_1_36, "real_tpl/time_left/hour")

	local var_1_37 = arg_1_0.tr

	arg_1_0.minLeftTag = var_2.Find(var_1_37, "real_tpl/time_left/min")

	local var_1_38 = arg_1_0.timeLeftTag

	arg_1_0.numLeftText = var_2.Find(var_1_38, "Text")

	local var_1_39 = arg_1_0.tr

	arg_1_0.focusTip = var_2.Find(var_1_39, "real_tpl/focus_tip")

	local var_1_40 = arg_1_0.tr

	arg_1_0.tag = var_2.Find(var_1_40, "real_tpl/tag")
	arg_1_0.tags = {}
	table = var_2

	local var_1_41 = var_2.insert
	local var_1_42 = arg_1_0.tags
	local var_1_43 = arg_1_0.tr

	var_1_41(var_1_42, var_4.Find(var_1_43, "real_tpl/tag/hot"))

	table = var_1_41

	local var_1_44 = var_1_41.insert
	local var_1_45 = arg_1_0.tags
	local var_1_46 = arg_1_0.tr

	var_1_44(var_1_45, var_4.Find(var_1_46, "real_tpl/tag/new"))

	table = var_1_44

	local var_1_47 = var_1_44.insert
	local var_1_48 = arg_1_0.tags
	local var_1_49 = arg_1_0.tr

	var_1_47(var_1_48, var_4.Find(var_1_49, "real_tpl/tag/advice"))

	table = var_1_47

	local var_1_50 = var_1_47.insert
	local var_1_51 = arg_1_0.tags
	local var_1_52 = arg_1_0.tr

	var_1_50(var_1_51, var_4.Find(var_1_52, "real_tpl/tag/double"))

	table = var_1_50

	local var_1_53 = var_1_50.insert
	local var_1_54 = arg_1_0.tags
	local var_1_55 = arg_1_0.tr

	var_1_53(var_1_54, var_4.Find(var_1_55, "real_tpl/tag/activity"))

	table = var_1_53

	local var_1_56 = var_1_53.insert
	local var_1_57 = arg_1_0.tags
	local var_1_58 = arg_1_0.tr

	var_1_56(var_1_57, var_4.Find(var_1_58, "real_tpl/tag/time"))

	table = var_1_56

	local var_1_59 = var_1_56.insert
	local var_1_60 = arg_1_0.tags
	local var_1_61 = arg_1_0.tr

	var_1_59(var_1_60, var_4.Find(var_1_61, "real_tpl/tag/discount"))

	local var_1_62 = arg_1_0.tr

	arg_1_0.packageTag = var_2.Find(var_1_62, "real_tpl/package_tag")
	setActive = var_2

	var_2(arg_1_0.countDown, false)

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

	setActive = var_2_0

	var_2_0(arg_2_0.desc, true)

	setText = var_2_0

	var_2_0(arg_2_0.desc, "")

	setActive = var_2_0

	local var_2_2 = arg_2_0.rmb
	local var_2_3

	if arg_2_1:isChargeType() then
		var_2_3 = not var_2_1
	end

	var_2_0(var_2_2, var_2_3)

	setActive = var_2_0

	var_2_0(arg_2_0.gem, not arg_2_1:isChargeType() and not arg_2_1:isFree())

	setText = var_2_0

	local var_2_4 = arg_2_0.freeTag

	i18n = var_7

	var_2_0(var_2_4, var_7("shop_free_tag"))

	setText = var_2_0

	local var_2_5 = arg_2_0.tecShipBuyTag

	i18n = var_7

	var_2_0(var_2_5, var_7("word_buy"))

	setActive = var_2_0

	var_2_0(arg_2_0.tecShipBuyTag, var_2_1)

	setActive = var_2_0

	var_2_0(arg_2_0.freeTag, arg_2_1:isFree())

	setActive = var_2_0

	var_2_0(arg_2_0.priceTf, not arg_2_1:isFree() and not var_2_1)

	setActive = var_2_0

	var_2_0(arg_2_0.focusTip, arg_2_1:isTip())

	setActive = var_2_0

	var_2_0(arg_2_0.icon, arg_2_1:isChargeType())

	setActive = var_2_0

	var_2_0(arg_2_0.contain, true)

	setActive = var_2_0

	var_2_0(arg_2_0.countDown, false)

	if arg_2_0.viewBtn then
		setActive = var_5

		local var_2_6 = arg_2_0.viewBtn
		local var_2_7

		if arg_2_1:isChargeType() then
			var_2_7 = arg_2_1:CanViewSkinProbability()
		end

		var_5(var_2_6, var_2_7)
	end

	if arg_2_0.packageTag then
		local var_2_8 = arg_2_1
		local var_2_9 = arg_2_1.GetPackageTag(var_2_8)

		setActive = var_2_8

		var_2_8(arg_2_0.packageTag, var_2_9 ~= "")

		setText = var_2_8

		local var_2_10 = arg_2_0.packageTag

		var_2_8(var_7.Find(var_2_10, "Text"), var_2_9)
	end

	if arg_2_1:isChargeType() then
		arg_2_0:updateCharge(arg_2_1, arg_2_2, arg_2_3)
	else
		arg_2_0:updateGemItem(arg_2_1, arg_2_2)
	end

	arg_2_0:destoryTimer()

	return
end

function var_0_0.updateCharge(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	setActive = var_1_10004

	var_1_10004(arg_3_0.tag, true)

	setActive = var_1_10004

	var_1_10004(arg_3_0.mask, false)

	setActive = var_1_10004

	var_1_10004(arg_3_0.maskState, false)

	local var_3_0 = arg_3_0.tipText

	var_3_0.text = ""
	setText = var_3_0

	var_3_0(arg_3_0.desc, "")

	table = var_3_0

	local var_3_1

	if not var_3_0.contains(arg_3_3, arg_3_1.id) and arg_3_1:firstPayDouble() then
		var_3_1 = 4
	else
		var_1_10007 = arg_3_1
		var_3_1 = arg_3_1.getConfig(var_1_10007, "tag")
	end

	setActive = var_1_10007

	var_1_10007(arg_3_0.timeLeftTag, false)

	setActive = var_1_10007

	var_1_10007(arg_3_0.tag, var_3_1 > 0)

	if 0 < var_3_1 then
		ipairs = var_7

		for iter_3_0, iter_3_1 in var_7(arg_3_0.tags) do
			setActive = var_1_10012

			var_1_10012(iter_3_1, iter_3_0 == var_3_1)
		end
	end

	setActive = var_7

	var_7(arg_3_0.timeLeftTag, false)

	local var_3_2, var_3_3 = arg_3_1:inTime()
	local var_3_5

	if var_3_2 and not arg_3_1:isFree() and var_3_3 and 0 < var_3_3 then
		pg = var_3_5

		local var_3_4 = var_3_5.TimeMgr.GetInstance()
		local var_3_6, var_3_7

		var_3_5, var_3_6, var_3_7 = var_3_5.parseTimeFrom(var_3_4, var_3_3)

		if 0 < var_3_5 then
			setActive = var_12

			var_12(arg_3_0.timeLeftTag, true)

			setActive = var_12

			var_12(arg_3_0.dayLeftTag, true)

			setActive = var_12

			var_12(arg_3_0.hourLeftTag, false)

			setActive = var_12

			var_12(arg_3_0.minLeftTag, false)

			setText = var_12

			var_12(arg_3_0.numLeftText, var_3_5)
		elseif 0 < var_3_6 then
			setActive = var_12

			var_12(arg_3_0.timeLeftTag, true)

			setActive = var_12

			var_12(arg_3_0.dayLeftTag, false)

			setActive = var_12

			var_12(arg_3_0.hourLeftTag, true)

			setActive = var_12

			var_12(arg_3_0.minLeftTag, false)

			setText = var_12

			var_12(arg_3_0.numLeftText, var_3_6)
		elseif 0 < var_3_7 then
			setActive = var_12

			var_12(arg_3_0.timeLeftTag, true)

			setActive = var_12

			var_12(arg_3_0.dayLeftTag, false)

			setActive = var_12

			var_12(arg_3_0.hourLeftTag, false)

			setActive = var_12

			var_12(arg_3_0.minLeftTag, true)

			setText = var_12

			var_12(arg_3_0.numLeftText, var_3_7)
		else
			setActive = var_12

			var_12(arg_3_0.timeLeftTag, true)

			setActive = var_12

			var_12(arg_3_0.dayLeftTag, false)

			setActive = var_12

			var_12(arg_3_0.hourLeftTag, false)

			setActive = var_12

			var_12(arg_3_0.minLeftTag, true)

			setText = var_12

			var_12(arg_3_0.numLeftText, 0)
		end

		local var_3_8 = 60
		local var_3_9 = 3600
		local var_3_10 = 0

		var_1_10015 = nil

		if var_3_10 <= var_3_3 then
			var_1_10015 = var_3_3 % var_3_10
		elseif var_3_9 <= var_3_3 then
			var_1_10015 = var_3_3 % var_3_9
		elseif var_3_8 <= var_3_3 then
			var_1_10015 = var_3_3 % var_3_8
		end

		if var_1_10015 and 0 < var_1_10015 then
			if arg_3_0.countDownTimer then
				local var_3_11 = arg_3_0.countDownTimer

				var_1_10016.Stop(var_3_11)

				arg_3_0.countDownTimer = nil
			end

			Timer = var_1_10016
			arg_3_0.countDownTimer = var_1_10016.New(function()
				local var_4_0 = arg_3_0

				var_0.updateGemItem(var_4_0, arg_3_1, arg_3_2)

				return
			end, var_1_10015, 1)

			local var_3_12 = arg_3_0.countDownTimer

			var_1_10016.Start(var_3_12)
		end
	end

	setActive = var_3_5

	var_3_5(arg_3_0.resIcon, not arg_3_1:isItemBox())

	setActive = var_3_5

	var_3_5(arg_3_0.resCount, not arg_3_1:isItemBox())

	local var_3_13 = arg_3_1
	local var_3_14 = arg_3_1.isGem(var_3_13)

	setActive = var_3_13

	var_3_13(arg_3_0.name, not var_3_14)

	setScrollText = var_3_13

	var_3_13(arg_3_0.name, arg_3_1:getConfig("name_display"))

	setActive = var_3_13

	local var_3_15 = arg_3_0.important
	local var_3_16

	if not arg_3_1:isItemBox() then
		var_3_16 = arg_3_1:isGiftBox()
	end

	var_3_13(var_3_15, var_3_16)

	setActive = var_3_13

	var_3_13(arg_3_0.count, var_3_14 or arg_3_1:isMonthCard())

	if arg_3_1:isItemBox() or arg_3_1:isGiftBox() or arg_3_1:isPassItem() then
		arg_3_0:updateImport(arg_3_1:getConfig("display"), arg_3_1:getConfig("descrip"))
	end

	local var_3_17 = arg_3_1:getConfig("limit_type")
	local var_3_18 = arg_3_1.buyCount
	local var_3_19 = arg_3_1
	local var_3_20 = arg_3_1.getLimitCount(var_3_19)

	if var_3_17 == 2 then
		setText = var_3_19

		local var_3_21 = arg_3_0.limitText

		i18n = var_1_10015

		var_3_19(var_3_21, var_1_10015("charge_limit_all", var_3_20 - var_3_18, var_3_20))

		setActive = var_3_19

		local var_3_22 = arg_3_0.mask

		var_1_10015 = var_3_20 - var_3_18 <= 0

		var_3_19(var_3_22, var_1_10015)
	elseif var_3_17 == 4 then
		setText = var_3_19

		local var_3_23 = arg_3_0.limitText

		i18n = var_1_10015

		var_3_19(var_3_23, var_1_10015("charge_limit_daily", var_3_20 - var_3_18, var_3_20))

		setActive = var_3_19

		local var_3_24 = arg_3_0.mask

		var_1_10015 = var_3_20 - var_3_18 <= 0

		var_3_19(var_3_24, var_1_10015)
	else
		setText = var_3_19

		var_3_19(arg_3_0.limitText, "")
	end

	if arg_3_1:isGem() then
		setActive = var_13

		var_13(arg_3_0.tipTF, true)

		if var_5 then
			local var_3_25 = arg_3_1:getConfig("gem")

			var_1_10015 = arg_3_1

			local var_3_26 = var_3_25 * arg_3_1.getConfig(var_1_10015, "first_pay_double")
			local var_3_27 = arg_3_0.tipText

			i18n = var_1_10015
			var_3_27.text = var_1_10015("charge_double_gem_tip", var_3_26)
		else
			local var_3_28 = arg_3_1
			local var_3_29

			if arg_3_1.hasExtraGem(var_3_28) then
				var_3_29 = arg_3_0.tipText
				i18n = var_3_28
				var_3_29.text = var_3_28("charge_extra_gem_tip", arg_3_1:getConfig("extra_gem"))
			else
				setActive = var_3_29

				var_3_29(arg_3_0.tipTF, false)
			end
		end
	elseif arg_3_1:isGiftBox() then
		-- block empty
	elseif arg_3_1:isMonthCard() then
		local var_3_30 = arg_3_2
		local var_3_31 = arg_3_2.getCardById

		VipCard = var_1_10015

		if var_3_31(var_3_30, var_1_10015.MONTH) and not var_13:isExpire() then
			local var_3_32 = var_13

			var_3_30 = var_13.getLeftDate(var_3_32)
			pg = var_3_32
			var_1_10016 = var_3_32.TimeMgr.GetInstance()

			local var_3_33 = var_15.GetServerTime(var_1_10016)

			math = var_1_10016
			var_1_10016 = var_1_10016.floor((var_3_30 - var_3_33) / 0)

			local var_3_34 = arg_3_1
			local var_3_35

			if not arg_3_1.getConfig(var_3_34, "limit_arg") then
				var_3_35 = 0
			end

			setActive = var_3_34

			var_3_34(arg_3_0.mask, var_3_35 < var_1_10016)

			setText = var_3_34

			local var_3_36 = arg_3_0.limitText

			i18n = var_20

			var_3_34(var_3_36, var_20("charge_month_card_lefttime_tip", var_1_10016))
		end

		setText = var_3_30

		local var_3_37 = arg_3_0.desc

		string = var_1_10016

		local var_3_38 = var_1_10016.gsub
		local var_3_39 = arg_3_1:getConfig("descrip")
		local var_3_40 = "$1"
		local var_3_41

		if not var_4 or not arg_3_1:getConfig("gem") then
			var_3_41 = arg_3_1:getConfig("extra_gem")
		end

		var_3_30(var_3_37, var_3_38(var_3_39, var_3_40, var_3_41))
	elseif arg_3_1:isItemBox() then
		-- block empty
	elseif arg_3_1:isPassItem() then
		-- block empty
	end

	arg_3_0.resCount.text = "x" .. arg_3_1:getConfig("gem")

	local var_3_42 = arg_3_0.price

	var_3_42.text = arg_3_1:getConfig("money")
	PLATFORM_CODE = var_3_42
	PLATFORM_CHT = var_3_43

	local var_3_43

	if var_3_42 == var_3_43 then
		var_3_43 = arg_3_1

		if arg_3_1.IsLocalPrice(var_3_43) then
			setActive = var_13

			var_13(arg_3_0.rmb, false)
		end
	end

	local var_3_44 = arg_3_0.iconTF

	GetSpriteFromAtlas = var_3_43
	var_3_44.sprite = var_3_43("chargeicon/1", "")
	LoadSpriteAsync = var_3_44

	var_3_44("chargeicon/" .. arg_3_1:getConfig("picture"), function(arg_5_0)
		if arg_5_0 then
			IsNil = var_2_10001

			if not var_2_10001(arg_3_0.iconTF) then
				arg_3_0.iconTF.sprite = arg_5_0

				local var_5_0 = arg_3_0.iconTF

				var_1.SetNativeSize(var_5_0)
			end
		end

		return
	end)

	setButtonEnabled = var_3_44

	local var_3_45 = arg_3_0.tr

	isActive = var_15

	var_3_44(var_3_45, not var_15(arg_3_0.mask))

	return
end

function var_0_0.UpdateShipIcon(arg_6_0, arg_6_1)
	IsNil = var_1_10002

	if var_1_10002(arg_6_0.shipIcon) then
		return
	end

	setActive = var_2

	var_2(arg_6_0.shipIcon, true)

	local var_6_0 = arg_6_0.shipIcon
	local var_6_1 = var_2.Find(var_6_0, "icon")
	local var_6_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005

	local var_6_3 = var_6_2(var_6_1, var_4(var_1_10005))
	local var_6_4 = arg_6_1
	local var_6_5 = arg_6_1.getConfigTable(var_6_4).usage_arg[1][1]

	assert = var_6_4

	var_6_4(var_6_5)

	pg = var_6_4

	local var_6_6 = var_6_4.shop_template[var_6_5].effect_args[1]

	assert = var_1_10006

	var_1_10006(var_6_6)

	pg = var_1_10006

	local var_6_7 = var_1_10006.ship_skin_template[var_6_6]

	LoadSpriteAsync = var_7

	var_7("qicon/" .. var_6_7.prefab, function(arg_7_0)
		if arg_7_0 then
			IsNil = var_2_10001

			if not var_2_10001(arg_6_0.shipIcon) then
				var_6_3.sprite = arg_7_0
			end
		end

		return
	end)

	return
end

function var_0_0.updateGemItem(arg_8_0, arg_8_1, arg_8_2)
	setActive = var_1_10003

	var_1_10003(arg_8_0.mask, false)

	setActive = var_1_10003

	var_1_10003(arg_8_0.maskState, false)

	setText = var_1_10003

	var_1_10003(arg_8_0.limitText, "")

	arg_8_0.tipText.text = ""

	local var_8_0 = arg_8_1:getLimitCount()
	local var_8_1

	if not arg_8_1.buyCount then
		var_8_1 = 0
	end

	if 0 < var_8_0 then
		setText = var_5

		local var_8_2 = arg_8_0.limitText

		i18n = var_1_10007

		var_5(var_8_2, var_1_10007("charge_limit_all", var_8_0 - var_8_1, var_8_0))

		setActive = var_5

		var_5(arg_8_0.mask, var_8_0 <= var_8_1)
	end

	if arg_8_1:getConfig("group_limit") > 0 then
		local var_8_3 = arg_8_1
		local var_8_4

		if not arg_8_1.getConfig(var_8_3, "group_type") then
			var_8_4 = 0
		end

		if var_8_4 == 1 then
			setText = var_8_3

			local var_8_5 = arg_8_0.limitText

			i18n = var_1_10009

			var_8_3(var_8_5, var_1_10009("charge_limit_daily", var_5 - arg_8_1.groupCount, var_5))
		elseif var_8_4 == 2 then
			setText = var_8_3

			local var_8_6 = arg_8_0.limitText

			i18n = var_1_10009

			var_8_3(var_8_6, var_1_10009("charge_limit_weekly", var_5 - arg_8_1.groupCount, var_5))
		elseif var_8_4 == 3 then
			setText = var_8_3

			local var_8_7 = arg_8_0.limitText

			i18n = var_1_10009

			var_8_3(var_8_7, var_1_10009("charge_limit_monthly", var_5 - arg_8_1.groupCount, var_5))
		end
	end

	arg_8_0.price.text = arg_8_1:getConfig("resource_num")

	local var_8_8 = arg_8_0.tipText

	var_8_8.text = ""
	setActive = var_8_8

	var_8_8(arg_8_0.count, false)

	setActive = var_8_8

	var_8_8(arg_8_0.icon, true)

	setText = var_8_8

	var_8_8(arg_8_0.desc, "")

	local var_8_9 = arg_8_1
	local var_8_10 = arg_8_1.getConfig(var_8_9, "tag")

	setActive = var_8_9

	var_8_9(arg_8_0.tag, var_8_10 > 0)

	if 0 < var_8_10 then
		ipairs = var_7

		for iter_8_0, iter_8_1 in var_7(arg_8_0.tags) do
			setActive = var_1_10012

			var_1_10012(iter_8_1, iter_8_0 == var_8_10)
		end
	end

	setActive = var_7

	var_7(arg_8_0.timeLeftTag, false)

	local var_8_11, var_8_12 = arg_8_1:inTime()
	local var_8_14

	if var_8_11 and not arg_8_1:isFree() and var_8_12 and 0 < var_8_12 then
		pg = var_8_14

		local var_8_13 = var_8_14.TimeMgr.GetInstance()
		local var_8_15, var_8_16

		var_8_14, var_8_15, var_8_16 = var_8_14.parseTimeFrom(var_8_13, var_8_12)

		if 0 < var_8_14 then
			setActive = var_1_10012

			var_1_10012(arg_8_0.timeLeftTag, true)

			setActive = var_1_10012

			var_1_10012(arg_8_0.dayLeftTag, true)

			setActive = var_1_10012

			var_1_10012(arg_8_0.hourLeftTag, false)

			setActive = var_1_10012

			var_1_10012(arg_8_0.minLeftTag, false)

			setText = var_1_10012

			var_1_10012(arg_8_0.numLeftText, var_8_14)
		elseif 0 < var_8_15 then
			setActive = var_1_10012

			var_1_10012(arg_8_0.timeLeftTag, true)

			setActive = var_1_10012

			var_1_10012(arg_8_0.dayLeftTag, false)

			setActive = var_1_10012

			var_1_10012(arg_8_0.hourLeftTag, true)

			setActive = var_1_10012

			var_1_10012(arg_8_0.minLeftTag, false)

			setText = var_1_10012

			var_1_10012(arg_8_0.numLeftText, var_8_15)
		elseif 0 < var_8_16 then
			setActive = var_1_10012

			var_1_10012(arg_8_0.timeLeftTag, true)

			setActive = var_1_10012

			var_1_10012(arg_8_0.dayLeftTag, false)

			setActive = var_1_10012

			var_1_10012(arg_8_0.hourLeftTag, false)

			setActive = var_1_10012

			var_1_10012(arg_8_0.minLeftTag, true)

			setText = var_1_10012

			var_1_10012(arg_8_0.numLeftText, var_8_16)
		else
			setActive = var_1_10012

			var_1_10012(arg_8_0.timeLeftTag, true)

			setActive = var_1_10012

			var_1_10012(arg_8_0.dayLeftTag, false)

			setActive = var_1_10012

			var_1_10012(arg_8_0.hourLeftTag, false)

			setActive = var_1_10012

			var_1_10012(arg_8_0.minLeftTag, true)

			setText = var_1_10012

			var_1_10012(arg_8_0.numLeftText, 0)
		end

		var_1_10012 = 60

		local var_8_17 = 3600
		local var_8_18 = 0
		local var_8_19

		if var_8_18 <= var_8_12 then
			var_8_19 = var_8_12 % var_8_18
		elseif var_8_17 <= var_8_12 then
			var_8_19 = var_8_12 % var_8_17
		elseif var_1_10012 <= var_8_12 then
			var_8_19 = var_8_12 % var_1_10012
		end

		if var_8_19 and var_8_19 > 0 then
			if arg_8_0.countDownTimer then
				local var_8_20 = arg_8_0.countDownTimer

				var_16.Stop(var_8_20)

				arg_8_0.countDownTimer = nil
			end

			Timer = var_16
			arg_8_0.countDownTimer = var_16.New(function()
				local var_9_0 = arg_8_0

				var_0.updateGemItem(var_9_0, arg_8_1, arg_8_2)

				return
			end, var_8_19, 1)

			local var_8_21 = arg_8_0.countDownTimer

			var_16.Start(var_8_21)
		end
	end

	setActive = var_8_14

	var_8_14(arg_8_0.name, true)

	if #arg_8_1:getConfig("effect_args") > 0 then
		Item = var_10

		if var_10.getConfigData(var_9[1]) then
			setScrollText = var_11

			var_11(arg_8_0.name, var_10.name)

			var_1_10012 = arg_8_0

			arg_8_0.updateImport(var_1_10012, var_10.display_icon, var_10.display)

			var_1_10012 = arg_8_0

			if arg_8_0.CheckSkinDiscounItem(var_1_10012, var_10.display_icon) then
				arg_8_0:UpdateShipIcon(var_11)
			end
		end

		local var_8_22 = arg_8_0.iconTF

		GetSpriteFromAtlas = var_1_10012
		var_8_22.sprite = var_1_10012("chargeicon/1", "")
		LoadSpriteAsync = var_8_22

		var_8_22(var_10.icon, function(arg_10_0)
			if arg_10_0 then
				IsNil = var_2_10001

				if not var_2_10001(arg_8_0.iconTF) then
					arg_8_0.iconTF.sprite = arg_10_0

					local var_10_0 = arg_8_0.iconTF

					var_1.SetNativeSize(var_10_0)
				end
			end

			return
		end)
	end

	setButtonEnabled = var_10

	local var_8_23 = arg_8_0.tr

	isActive = var_1_10012

	var_10(var_8_23, not var_1_10012(arg_8_0.mask))

	return
end

function var_0_0.CheckSkinDiscounItem(arg_11_0, arg_11_1)
	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_1) do
		Drop = var_1_10007

		local var_11_0 = var_1_10007.Create(iter_11_1)

		if var_1_10007.getConfigTable(var_11_0).usage then
			local var_11_1 = var_8.usage

			ItemUsage = var_1_10010

			if var_11_1 == var_1_10010.USAGE_SHOP_DISCOUNT then
				return var_1_10007
			end
		end
	end

	return nil
end

local function var_0_1(arg_12_0)
	if arg_12_0:getConfigTable().usage then
		local var_12_0 = var_1.usage

		ItemUsage = var_1_10003

		if var_12_0 == var_1_10003.USAGE_SKIN_EXP then
			return false
		end
	end

	return true
end

function var_0_0.updateImport(arg_13_0, arg_13_1, arg_13_2)
	setActive = var_1_10003

	var_1_10003(arg_13_0.important, true)

	local var_13_0 = {}

	ipairs = var_4

	for iter_13_0, iter_13_1 in var_4(arg_13_1) do
		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		local var_13_1 = var_13_0

		Drop = var_1_10011

		var_1_10009(var_13_1, var_1_10011.Create(iter_13_1))
	end

	for iter_13_2 = 1, arg_13_0.grid.childCount do
		local var_13_2 = arg_13_0.grid
		local var_13_3 = var_8.GetChild(var_13_2, iter_13_2 - 1)

		if iter_13_2 <= #var_13_0 then
			setActive = var_9

			var_9(var_13_3, var_0_1(var_13_0[iter_13_2]))

			updateDrop = var_9

			var_9(var_13_3, var_13_0[iter_13_2])
		else
			setActive = var_9

			var_9(var_13_3, false)
		end
	end

	setText = var_4

	local var_13_4 = arg_13_0.importantTip

	string = var_6

	var_4(var_13_4, var_6.gsub(arg_13_2, "$1", #var_13_0))

	return
end

function var_0_0.updateCountdown(arg_14_0, arg_14_1)
	local var_14_0 = false

	if arg_14_1 then
		pg = var_1_10003

		local var_14_1 = var_1_10003.TimeMgr.GetInstance()
		local var_14_2 = var_1_10003.DiffDay
		local var_14_3 = var_1_10003
		local var_14_4 = var_1_10003.GetServerTime(var_14_3)

		pg = var_14_3

		local var_14_5 = var_14_3.TimeMgr.GetInstance()

		var_14_0 = var_14_2(var_14_1, var_14_4, var_7.Table2ServerTime(var_14_5, arg_14_1)) < 365
	end

	setActive = var_1_10003

	var_1_10003(arg_14_0.countDown, var_14_0)

	pg = var_1_10003

	local var_14_6 = var_1_10003.TimeMgr.GetInstance()

	;(function()
		if arg_14_0.updateTimer then
			local var_15_0 = arg_14_0.updateTimer

			var_0.Stop(var_15_0)

			arg_14_0.updateTimer = nil
		end

		return
	end)()

	local var_14_7 = var_14_6
	local var_14_8 = var_14_6.Table2ServerTime(var_14_7, arg_14_1)

	Timer = var_14_7
	arg_14_0.updateTimer = var_14_7.New(function()
		local var_16_0 = var_14_6

		if var_0.GetServerTime(var_16_0) > var_14_8 then
			var_0()
		end

		local var_16_1 = var_14_8 - var_0 < 0 and 0 or var_16_1

		math = var_2

		local var_16_2 = var_2.floor(var_16_1 / 0)

		if 0 < var_16_2 then
			setText = var_3

			local var_16_3 = arg_14_0.countDownTm

			i18n = var_2_10005

			local var_16_4 = var_2_10005("skin_remain_time")

			var_2_10006 = var_16_2
			i18n = var_2_10007

			var_3(var_16_3, var_16_4 .. var_2_10006 .. var_2_10007("word_date"))
		else
			math = var_3

			local var_16_5 = var_3.floor(var_16_1 / 16)

			if 0 < var_16_5 then
				setText = var_4

				local var_16_6 = arg_14_0.countDownTm

				i18n = var_2_10006

				local var_16_7 = var_2_10006("skin_remain_time")

				var_2_10007 = var_16_5
				i18n = var_2_10008

				var_4(var_16_6, var_16_7 .. var_2_10007 .. var_2_10008("word_hour"))
			else
				math = var_4

				local var_16_8 = var_4.floor(var_16_1 / 60)

				if 0 < var_16_8 then
					setText = var_5

					local var_16_9 = arg_14_0.countDownTm

					i18n = var_2_10007
					var_2_10007 = var_2_10007("skin_remain_time")

					local var_16_10 = var_16_8

					i18n = var_2_10009

					var_5(var_16_9, var_2_10007 .. var_16_10 .. var_2_10009("word_minute"))
				else
					setText = var_5

					local var_16_11 = arg_14_0.countDownTm

					i18n = var_2_10007

					local var_16_12 = var_2_10007("skin_remain_time")
					local var_16_13 = var_16_1

					i18n = var_2_10009

					var_5(var_16_11, var_16_12 .. var_16_13 .. var_2_10009("word_second"))
				end
			end
		end

		return
	end, 1, -1)

	local var_14_9 = arg_14_0.updateTimer

	var_6.Start(var_14_9)
	arg_14_0.updateTimer.func()

	return
end

function var_0_0.destoryTimer(arg_17_0)
	if arg_17_0.updateTimer then
		local var_17_0 = arg_17_0.updateTimer

		var_1.Stop(var_17_0)

		arg_17_0.updateTimer = nil
	end

	if arg_17_0.countDownTimer then
		local var_17_1 = arg_17_0.countDownTimer

		var_1.Stop(var_17_1)

		arg_17_0.countDownTimer = nil
	end

	return
end

return var_0_0
