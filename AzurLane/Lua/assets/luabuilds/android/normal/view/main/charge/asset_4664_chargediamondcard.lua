class = var_0_10000

local var_0_0 = var_0_10000("ChargeDiamondCard")

var_0_0.NewTagType = 2
var_0_0.DoubleTagType = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.go = arg_1_1
	tf = var_1_10004
	arg_1_0.tr = var_1_10004(arg_1_1)

	local var_1_0 = arg_1_0.tr

	arg_1_0.firstTag = var_4.Find(var_1_0, "FirstTag")

	local var_1_1 = arg_1_0.tr

	arg_1_0.iconImg = var_4.Find(var_1_1, "IconImg")

	local var_1_2 = arg_1_0.tr

	arg_1_0.diamondCountText = var_4.Find(var_1_2, "Count/Text")

	local var_1_3 = arg_1_0.tr

	arg_1_0.tipTF = var_4.Find(var_1_3, "Tip")

	local var_1_4 = arg_1_0.tr

	arg_1_0.firstTipTag = var_4.Find(var_1_4, "Tip/Text/FirstTag")

	local var_1_5 = arg_1_0.tr

	arg_1_0.exTipTag = var_4.Find(var_1_5, "Tip/Text")

	local var_1_6 = arg_1_0.tr

	arg_1_0.firstEXTip = var_4.Find(var_1_6, "Tip/Text")

	local var_1_7 = arg_1_0.tr

	arg_1_0.priceText = var_4.Find(var_1_7, "Price/Text")

	local var_1_8 = arg_1_0.tr

	arg_1_0.priceIcon = var_4.Find(var_1_8, "Price/Icon")
	arg_1_0.monthTF = arg_1_2
	arg_1_0.goods = nil
	arg_1_0.parentContext = arg_1_3

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.goods = arg_2_1

	if arg_2_1:isMonthCard() then
		setActive = var_4

		var_4(arg_2_0.tr, false)
		arg_2_0:updateForMonthTF(arg_2_1, arg_2_2)

		return
	end

	table = var_4

	local var_2_0

	if not (not var_4.contains(arg_2_3, arg_2_1.id) and arg_2_1:firstPayDouble()) or not var_0_0.DoubleTagType then
		var_1_10007 = arg_2_1
		var_2_0 = arg_2_1.getConfig(var_1_10007, "tag")
	end

	setActive = var_1_10007

	var_1_10007(arg_2_0.firstTag, var_2_0 == var_0_0.DoubleTagType)

	if var_5 then
		local var_2_1 = arg_2_1

		var_1_10007 = arg_2_1.getConfig(var_2_1, "gem")
		setScrollText = var_2_1

		local var_2_2 = arg_2_0.firstEXTip

		i18n = var_1_10010

		var_2_1(var_2_2, var_1_10010("charge_double_gem_tip", var_1_10007))

		setActive = var_2_1

		var_2_1(arg_2_0.exTipTag, false)

		setActive = var_2_1

		var_2_1(arg_2_0.firstEXTip, true)

		setActive = var_2_1

		var_2_1(arg_2_0.tipTF, true)
	elseif arg_2_1:hasExtraGem() then
		local var_2_3 = arg_2_1

		var_1_10007 = arg_2_1.getConfig(var_2_3, "extra_gem")
		setScrollText = var_2_3

		local var_2_4 = arg_2_0.firstEXTip

		i18n = var_1_10010

		var_2_3(var_2_4, var_1_10010("charge_extra_gem_tip", var_1_10007))

		setActive = var_2_3

		var_2_3(arg_2_0.exTipTag, true)

		setActive = var_2_3

		var_2_3(arg_2_0.firstEXTip, true)

		setActive = var_2_3

		var_2_3(arg_2_0.tipTF, true)
	else
		setActive = var_1_10007

		var_1_10007(arg_2_0.tipTF, false)
	end

	setText = var_1_10007

	var_1_10007(arg_2_0.diamondCountText, arg_2_1:getConfig("gem"))

	setText = var_1_10007

	var_1_10007(arg_2_0.priceText, arg_2_1:getConfig("money"))

	PLATFORM_CODE = var_1_10007
	PLATFORM_CHT = var_8

	if var_1_10007 == var_8 then
		setActive = var_1_10007

		var_1_10007(arg_2_0.priceIcon, not arg_2_1:IsLocalPrice())
	end

	LoadSpriteAsync = var_1_10007

	var_1_10007("chargeicon/" .. arg_2_1:getConfig("picture"), function(arg_3_0)
		if arg_3_0 then
			IsNil = var_2_10001

			if not var_2_10001(arg_2_0.iconImg) then
				setImageSprite = var_1

				var_1(arg_2_0.iconImg, arg_3_0, true)
			end
		end

		return
	end)

	return
end

function var_0_0.updateForMonthTF(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.monthTF
	local var_4_1 = var_3.Find(var_4_0, "IconImg")
	local var_4_2 = arg_4_0.monthTF
	local var_4_3 = var_4.Find(var_4_2, "ResCountText")
	local var_4_4 = arg_4_0.monthTF
	local var_4_5 = var_5.Find(var_4_4, "Price/Text")
	local var_4_6 = arg_4_0.monthTF
	local var_4_7 = var_6.Find(var_4_6, "ItemIconTpl")
	local var_4_8 = arg_4_0.monthTF
	local var_4_9 = var_7.Find(var_4_8, "ItemIconList")
	local var_4_10 = arg_4_0.monthTF
	local var_4_11 = var_8.Find(var_4_10, "Mask")
	local var_4_12 = arg_4_0.monthTF
	local var_4_13 = var_9.Find(var_4_12, "Price/Icon")
	local var_4_14 = arg_4_0.monthTF
	local var_4_15 = var_10.Find(var_4_14, "leftTimeText")

	setScrollText = var_4_14

	local var_4_16 = arg_4_0.monthTF

	var_4_14(var_12.Find(var_4_16, "Tip/Text"), arg_4_1:getConfig("first_text"))

	setScrollText = var_4_14

	local var_4_17 = arg_4_0.monthTF

	var_4_14(var_12.Find(var_4_17, "Tip2/Text"), arg_4_1:getConfig("second_text"))

	setScrollText = var_4_14

	local var_4_18 = arg_4_0.monthTF

	var_4_14(var_12.Find(var_4_18, "title/Text"), arg_4_1:getConfig("name_display"))

	local var_4_19 = arg_4_1:getConfig("gem") + arg_4_1:getConfig("extra_gem")

	setText = var_12

	var_12(var_4_3, var_4_19)

	setText = var_12

	local var_4_20 = var_4_5
	local var_4_21 = arg_4_1

	var_12(var_4_20, arg_4_1.getConfig(var_4_21, "money"))

	PLATFORM_CODE = var_12
	PLATFORM_CHT = var_4_20

	if var_12 == var_4_20 then
		setActive = var_12

		local var_4_22 = var_4_13

		var_4_21 = arg_4_1

		var_12(var_4_22, not arg_4_1.IsLocalPrice(var_4_21))
	end

	if #arg_4_1:GetDropList() > 0 then
		UIItemList = var_13
		var_4_21 = var_13.New(var_4_9, var_4_7)

		var_13.make(var_4_21, function(arg_5_0, arg_5_1, arg_5_2)
			UIItemList = var_2_10003

			if arg_5_0 == var_2_10003.EventUpdate then
				updateDrop = var_3

				var_3(arg_5_2:Find("itemBg/item"), var_0[arg_5_1 + 1])
			end

			return
		end)

		var_4_21 = var_13

		var_13.align(var_4_21, #var_12)
	end

	local var_4_23 = arg_4_2
	local var_4_24 = arg_4_2.getCardById

	VipCard = var_4_21

	if var_4_24(var_4_23, var_4_21.MONTH) and not var_13:isExpire() then
		local var_4_25 = var_13

		var_4_23 = var_13.getLeftDate(var_4_25)
		pg = var_4_25

		local var_4_26 = var_4_25.TimeMgr.GetInstance()
		local var_4_27 = var_15.GetServerTime(var_4_26)

		math = var_4_26

		local var_4_28 = var_4_26.floor((var_4_23 - var_4_27) / 0)

		var_1_10018 = arg_4_1

		local var_4_29

		if not arg_4_1.getConfig(var_1_10018, "limit_arg") then
			var_4_29 = 0
		end

		setScrollText = var_1_10018

		local var_4_30 = var_4_15

		i18n = var_1_10020

		var_1_10018(var_4_30, var_1_10020("charge_month_card_lefttime_tip", var_4_28))

		setScrollText = var_1_10018

		local var_4_31 = arg_4_0.monthTF
		local var_4_32 = var_19.Find(var_4_31, "Mask/leftTimeGo/Text")

		i18n = var_4_31

		var_1_10018(var_4_32, var_4_31("charge_month_card_lefttime_tip", var_4_28))

		setActive = var_1_10018

		var_1_10018(var_4_15, true)

		setActive = var_1_10018

		var_1_10018(var_4_11, var_4_29 < var_4_28)

		setActive = var_1_10018

		local var_4_33 = arg_4_0.monthTF

		var_1_10018(var_19.Find(var_4_33, "NewTag"), false)

		setButtonEnabled = var_1_10018

		var_1_10018(arg_4_0.monthTF, var_4_28 <= var_4_29)
	else
		setActive = var_4_23

		var_4_23(var_4_15, false)

		setActive = var_4_23

		var_4_23(var_4_11, false)

		setActive = var_4_23

		local var_4_34 = arg_4_0.monthTF

		var_4_23(var_15.Find(var_4_34, "NewTag"), true)

		setButtonEnabled = var_4_23

		var_4_23(arg_4_0.monthTF, true)
	end

	onButton = var_4_23

	local var_4_35 = arg_4_0.parentContext
	local var_4_36 = arg_4_0.monthTF

	local function var_4_37()
		triggerButton = var_2_10000

		var_2_10000(arg_4_0.tr)

		return
	end

	SFX_PANEL = var_1_10018

	var_4_23(var_4_35, var_4_36, var_4_37, var_1_10018)

	return
end

function var_0_0.destoryTimer(arg_7_0)
	return
end

return var_0_0
