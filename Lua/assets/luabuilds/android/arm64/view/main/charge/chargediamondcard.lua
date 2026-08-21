local var_0_0 = class("ChargeDiamondCard")

var_0_0.NewTagType = 2
var_0_0.DoubleTagType = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = tf(arg_1_1)
	arg_1_0.firstTag = arg_1_0.tr:Find("FirstTag")
	arg_1_0.iconImg = arg_1_0.tr:Find("IconImg")
	arg_1_0.diamondCountText = arg_1_0.tr:Find("Count/Text")
	arg_1_0.tipTF = arg_1_0.tr:Find("Tip")
	arg_1_0.firstTipTag = arg_1_0.tr:Find("Tip/Text/FirstTag")
	arg_1_0.exTipTag = arg_1_0.tr:Find("Tip/Text")
	arg_1_0.firstEXTip = arg_1_0.tr:Find("Tip/Text")
	arg_1_0.priceText = arg_1_0.tr:Find("Price/Text")
	arg_1_0.priceIcon = arg_1_0.tr:Find("Price/Icon")
	arg_1_0.monthTF = arg_1_2
	arg_1_0.goods = nil
	arg_1_0.parentContext = arg_1_3

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.goods = arg_2_1

	if arg_2_1:isMonthCard() then
		setActive(arg_2_0.tr, false)
		arg_2_0:updateForMonthTF(arg_2_1, arg_2_2)

		return
	end

	local var_2_0 = not table.contains(arg_2_3, arg_2_1.id) and arg_2_1:firstPayDouble()

	if var_2_0 then
		local var_2_1 = var_0_0.DoubleTagType or arg_2_1:getConfig("tag")

		setActive(arg_2_0.firstTag, var_2_1 == var_0_0.DoubleTagType)

		if var_2_0 then
			setScrollText(arg_2_0.firstEXTip, i18n("charge_double_gem_tip", (arg_2_1:getConfig("gem"))))
			setActive(arg_2_0.exTipTag, false)
			setActive(arg_2_0.firstEXTip, true)
			setActive(arg_2_0.tipTF, true)
		elseif arg_2_1:hasExtraGem() then
			setScrollText(arg_2_0.firstEXTip, i18n("charge_extra_gem_tip", (arg_2_1:getConfig("extra_gem"))))
			setActive(arg_2_0.exTipTag, true)
			setActive(arg_2_0.firstEXTip, true)
			setActive(arg_2_0.tipTF, true)
		else
			setActive(arg_2_0.tipTF, false)
		end

		setText(arg_2_0.diamondCountText, arg_2_1:getConfig("gem"))
		setText(arg_2_0.priceText, arg_2_1:getConfig("money"))

		if PLATFORM_CODE == PLATFORM_CHT then
			setActive(arg_2_0.priceIcon, not arg_2_1:IsLocalPrice())
		end

		LoadSpriteAsync("chargeicon/" .. arg_2_1:getConfig("picture"), function(arg_3_0)
			if arg_3_0 and not IsNil(arg_2_0.iconImg) then
				setImageSprite(arg_2_0.iconImg, arg_3_0, true)
			end

			return
		end)

		return
	end
end

function var_0_0.updateForMonthTF(arg_4_0, arg_4_1, arg_4_2)
	local var_4_9000
	local var_4_0 = arg_4_0.monthTF:Find("IconImg")
	local var_4_1 = arg_4_0.monthTF:Find("Mask")
	local var_4_2 = arg_4_0.monthTF:Find("leftTimeText")

	setScrollText(arg_4_0.monthTF:Find("Tip/Text"), arg_4_1:getConfig("first_text"))
	setScrollText(arg_4_0.monthTF:Find("Tip2/Text"), arg_4_1:getConfig("second_text"))
	setScrollText(arg_4_0.monthTF:Find("title/Text"), arg_4_1:getConfig("name_display"))
	setText(arg_4_0.monthTF:Find("ResCountText"), arg_4_1:getConfig("gem") + arg_4_1:getConfig("extra_gem"))
	setText(arg_4_0.monthTF:Find("Price/Text"), arg_4_1:getConfig("money"))

	if PLATFORM_CODE == PLATFORM_CHT then
		setActive(arg_4_0.monthTF:Find("Price/Icon"), not arg_4_1:IsLocalPrice())
	end

	local var_4_3 = arg_4_1:GetDropList()

	if #var_4_3 > 0 then
		local var_4_4 = UIItemList.New(arg_4_0.monthTF:Find("ItemIconList"), (arg_4_0.monthTF:Find("ItemIconTpl")))

		var_4_4:make(function(arg_5_0, arg_5_1, arg_5_2)
			if arg_5_0 == UIItemList.EventUpdate then
				updateDrop(arg_5_2:Find("itemBg/item"), var_4_3[arg_5_1 + 1])
			end

			return
		end)
		var_4_4:align(#var_4_3)
	end

	local var_4_5 = arg_4_2:getCardById(VipCard.MONTH)

	if var_4_5 and not var_4_5:isExpire() then
		local var_4_6 = pg.TimeMgr.GetInstance()
		local var_4_7 = math.floor((var_4_5:getLeftDate() - var_4_6.GetServerTime(var_4_9000)) / 0)
		local var_4_8 = arg_4_1:getConfig("limit_arg")

		if not var_4_6 then
			var_4_8 = 0
		end

		setScrollText(var_4_2, i18n("charge_month_card_lefttime_tip", var_4_7))
		setScrollText(arg_4_0.monthTF:Find("Mask/leftTimeGo/Text"), i18n("charge_month_card_lefttime_tip", var_4_7))
		setActive(var_4_2, true)
		setActive(var_4_1, var_4_8 < var_4_7)
		setActive(arg_4_0.monthTF:Find("NewTag"), false)
		setButtonEnabled(arg_4_0.monthTF, var_4_7 <= var_4_8)
	else
		setActive(var_4_2, false)
		setActive(var_4_1, false)
		setActive(arg_4_0.monthTF:Find("NewTag"), true)
		setButtonEnabled(arg_4_0.monthTF, true)
	end

	onButton(arg_4_0.parentContext, arg_4_0.monthTF, function()
		triggerButton(arg_4_0.tr)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.destoryTimer(arg_7_0)
	return
end

return var_0_0
