local var_0_0 = class("OldChargeCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = tf(arg_1_1)
	arg_1_0.icon = arg_1_0.tr:Find("real_tpl/item_icon")
	arg_1_0.iconTF = arg_1_0.icon:GetComponent(typeof(Image))
	arg_1_0.shipIcon = arg_1_0.tr:Find("real_tpl/item_icon/ship")
	arg_1_0.tipTF = arg_1_0.tr:Find("real_tpl/tip")
	arg_1_0.tipText = arg_1_0.tipTF:GetComponent(typeof(Text))
	arg_1_0.count = arg_1_0.tr:Find("real_tpl/count")
	arg_1_0.resIcon = arg_1_0.tr:Find("real_tpl/count/icon"):GetComponent(typeof(Image))
	arg_1_0.resCount = arg_1_0.tr:Find("real_tpl/count/Text"):GetComponent(typeof(Text))
	arg_1_0.priceTf = arg_1_0.tr:Find("real_tpl/prince_bg/contain/Text")
	arg_1_0.price = arg_1_0.priceTf:GetComponent(typeof(Text))
	arg_1_0.freeTag = arg_1_0.tr:Find("real_tpl/prince_bg/contain/FreeText")
	arg_1_0.tecShipBuyTag = arg_1_0.tr:Find("real_tpl/prince_bg/contain/BuyText")
	arg_1_0.contain = arg_1_0.tr:Find("real_tpl/prince_bg/contain")
	arg_1_0.rmb = arg_1_0.tr:Find("real_tpl/prince_bg/contain/icon_rmb")
	arg_1_0.gem = arg_1_0.tr:Find("real_tpl/prince_bg/contain/icon_gem")
	arg_1_0.mask = arg_1_0.tr:Find("real_tpl/mask")
	arg_1_0.maskState = arg_1_0.mask:Find("state")
	arg_1_0.name = arg_1_0.tr:Find("real_tpl/item_name_mask/item_name")
	arg_1_0.important = arg_1_0.tr:Find("real_tpl/important")
	arg_1_0.grid = arg_1_0.tr:Find("real_tpl/important/grid")
	arg_1_0.importantTip = arg_1_0.tr:Find("real_tpl/important/tip")
	arg_1_0.desc = arg_1_0.tr:Find("real_tpl/desc")
	arg_1_0.selfTpl = arg_1_0.tr:Find("real_tpl/important/item")
	arg_1_0.limitText = arg_1_0.tr:Find("real_tpl/LimitText")
	arg_1_0.countDown = arg_1_0.tr:Find("real_tpl/countDown")
	arg_1_0.countDownTm = arg_1_0.countDown:Find("Text")
	arg_1_0.viewBtn = arg_1_0.tr:Find("real_tpl/view")
	arg_1_0.timeLeftTag = arg_1_0.tr:Find("real_tpl/time_left")
	arg_1_0.dayLeftTag = arg_1_0.tr:Find("real_tpl/time_left/day")
	arg_1_0.hourLeftTag = arg_1_0.tr:Find("real_tpl/time_left/hour")
	arg_1_0.minLeftTag = arg_1_0.tr:Find("real_tpl/time_left/min")
	arg_1_0.numLeftText = arg_1_0.timeLeftTag:Find("Text")
	arg_1_0.focusTip = arg_1_0.tr:Find("real_tpl/focus_tip")
	arg_1_0.tag = arg_1_0.tr:Find("real_tpl/tag")
	arg_1_0.tags = {}

	table.insert(arg_1_0.tags, arg_1_0.tr:Find("real_tpl/tag/hot"))
	table.insert(arg_1_0.tags, arg_1_0.tr:Find("real_tpl/tag/new"))
	table.insert(arg_1_0.tags, arg_1_0.tr:Find("real_tpl/tag/advice"))
	table.insert(arg_1_0.tags, arg_1_0.tr:Find("real_tpl/tag/double"))
	table.insert(arg_1_0.tags, arg_1_0.tr:Find("real_tpl/tag/activity"))
	table.insert(arg_1_0.tags, arg_1_0.tr:Find("real_tpl/tag/time"))
	table.insert(arg_1_0.tags, arg_1_0.tr:Find("real_tpl/tag/discount"))

	arg_1_0.packageTag = arg_1_0.tr:Find("real_tpl/package_tag")

	setActive(arg_1_0.countDown, false)

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.goods = arg_2_1

	if not IsNil(arg_2_0.shipIcon) then
		setActive(arg_2_0.shipIcon, false)
	end

	local var_2_0 = arg_2_1:isChargeType() and arg_2_1:getShowType() ~= ""

	setActive(arg_2_0.desc, true)
	setText(arg_2_0.desc, "")

	local var_2_1 = arg_2_1:isChargeType() and not var_2_0

	setActive(arg_2_0.rmb, var_2_1)
	setActive(arg_2_0.gem, not arg_2_1:isChargeType() and not arg_2_1:isFree())
	setText(arg_2_0.freeTag, i18n("shop_free_tag"))
	setText(arg_2_0.tecShipBuyTag, i18n("word_buy"))
	setActive(arg_2_0.tecShipBuyTag, var_2_0)
	setActive(arg_2_0.freeTag, arg_2_1:isFree())
	setActive(arg_2_0.priceTf, not arg_2_1:isFree() and not var_2_0)
	setActive(arg_2_0.focusTip, arg_2_1:isTip())
	setActive(arg_2_0.icon, arg_2_1:isChargeType())
	setActive(arg_2_0.contain, true)
	setActive(arg_2_0.countDown, false)

	if arg_2_0.viewBtn then
		local var_2_2 = arg_2_1:isChargeType() and arg_2_1:CanViewSkinProbability()

		setActive(arg_2_0.viewBtn, var_2_2)
	end

	if arg_2_0.packageTag then
		local var_2_3 = arg_2_1:GetPackageTag()

		setActive(arg_2_0.packageTag, var_2_3 ~= "")
		setText(arg_2_0.packageTag:Find("Text"), var_2_3)
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
	local var_3_9000

	setActive(arg_3_0.tag, true)
	setActive(arg_3_0.mask, false)
	setActive(arg_3_0.maskState, false)

	arg_3_0.tipText.text = ""

	setText(arg_3_0.desc, "")

	local var_3_0 = not table.contains(arg_3_3, arg_3_1.id)
	local var_3_1 = var_3_0 and arg_3_1:firstPayDouble()
	local var_3_2 = var_3_1 and 4 or arg_3_1:getConfig("tag")

	setActive(arg_3_0.timeLeftTag, false)
	setActive(arg_3_0.tag, var_3_2 > 0)

	if var_3_2 > 0 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.tags) do
			setActive(iter_3_1, iter_3_0 == var_3_2)
		end
	end

	setActive(arg_3_0.timeLeftTag, false)

	local var_3_3, var_3_4 = arg_3_1:inTime()

	if var_3_3 and not arg_3_1:isFree() and var_3_4 and var_3_4 > 0 then
		local var_3_5, var_3_6, var_3_7 = pg.TimeMgr.GetInstance():parseTimeFrom(var_3_4)

		if var_3_5 > 0 then
			setActive(arg_3_0.timeLeftTag, true)
			setActive(arg_3_0.dayLeftTag, true)
			setActive(arg_3_0.hourLeftTag, false)
			setActive(arg_3_0.minLeftTag, false)
			setText(arg_3_0.numLeftText, var_3_5)
		elseif var_3_6 > 0 then
			setActive(arg_3_0.timeLeftTag, true)
			setActive(arg_3_0.dayLeftTag, false)
			setActive(arg_3_0.hourLeftTag, true)
			setActive(arg_3_0.minLeftTag, false)
			setText(arg_3_0.numLeftText, var_3_6)
		elseif var_3_7 > 0 then
			setActive(arg_3_0.timeLeftTag, true)
			setActive(arg_3_0.dayLeftTag, false)
			setActive(arg_3_0.hourLeftTag, false)
			setActive(arg_3_0.minLeftTag, true)
			setText(arg_3_0.numLeftText, var_3_7)
		else
			setActive(arg_3_0.timeLeftTag, true)
			setActive(arg_3_0.dayLeftTag, false)
			setActive(arg_3_0.hourLeftTag, false)
			setActive(arg_3_0.minLeftTag, true)
			setText(arg_3_0.numLeftText, 0)
		end

		local var_3_8 = 60
		local var_3_9

		if 0 <= var_3_4 then
			var_3_9 = var_3_4 % 0
		elseif 3600 <= var_3_4 then
			var_3_9 = var_3_4 % 3600
		elseif var_3_8 <= var_3_4 then
			var_3_9 = var_3_4 % var_3_8
		end

		if var_3_9 and var_3_9 > 0 then
			if arg_3_0.countDownTimer then
				arg_3_0.countDownTimer:Stop()

				arg_3_0.countDownTimer = nil
			end

			arg_3_0.countDownTimer = Timer.New(function()
				arg_3_0:updateGemItem(arg_3_1, arg_3_2)

				return
			end, var_3_9, 1)

			arg_3_0.countDownTimer:Start()
		end
	end

	setActive(arg_3_0.resIcon, not arg_3_1:isItemBox())
	setActive(arg_3_0.resCount, not arg_3_1:isItemBox())

	local var_3_10 = arg_3_1:isGem()

	setActive(arg_3_0.name, not var_3_10)
	setScrollText(arg_3_0.name, arg_3_1:getConfig("name_display"))

	local var_3_11 = arg_3_1:isItemBox() or arg_3_1:isGiftBox()

	setActive(arg_3_0.important, var_3_11)
	setActive(arg_3_0.count, var_3_10 or arg_3_1:isMonthCard())

	if arg_3_1:isItemBox() or arg_3_1:isGiftBox() or arg_3_1:isPassItem() then
		arg_3_0:updateImport(arg_3_1:getConfig("display"), arg_3_1:getConfig("descrip"))
	end

	local var_3_12 = arg_3_1:getConfig("limit_type")
	local var_3_13 = arg_3_1.buyCount
	local var_3_14 = arg_3_1:getLimitCount()

	if var_3_12 == 2 then
		setText(arg_3_0.limitText, i18n("charge_limit_all", var_3_14 - var_3_13, var_3_14))
		setActive(arg_3_0.mask, var_3_14 - var_3_13 <= 0)
	elseif var_3_12 == 4 then
		setText(arg_3_0.limitText, i18n("charge_limit_daily", var_3_14 - var_3_13, var_3_14))
		setActive(arg_3_0.mask, var_3_14 - var_3_13 <= 0)
	else
		setText(arg_3_0.limitText, "")
	end

	if arg_3_1:isGem() then
		setActive(arg_3_0.tipTF, true)

		if var_3_1 then
			arg_3_0.tipText.text = i18n("charge_double_gem_tip", arg_3_1:getConfig("gem") * arg_3_1:getConfig("first_pay_double"))
		elseif arg_3_1:hasExtraGem() then
			arg_3_0.tipText.text = i18n("charge_extra_gem_tip", arg_3_1:getConfig("extra_gem"))
		else
			setActive(arg_3_0.tipTF, false)
		end
	elseif arg_3_1:isGiftBox() then
		-- block empty
	elseif arg_3_1:isMonthCard() then
		local var_3_15 = arg_3_2:getCardById(VipCard.MONTH)
		local var_3_19

		if var_3_15 and not var_3_15:isExpire() then
			local var_3_16 = pg.TimeMgr.GetInstance()
			local var_3_17 = math.floor((var_3_15:getLeftDate() - var_3_16.GetServerTime(var_3_9000)) / 0)
			local var_3_18 = arg_3_1:getConfig("limit_arg")

			if not var_3_16 then
				var_3_18 = 0
			end

			setActive(arg_3_0.mask, var_3_18 < var_3_17)
			setText(arg_3_0.limitText, i18n("charge_month_card_lefttime_tip", var_3_17))

			var_3_19 = var_3_0 and arg_3_1:getConfig("gem") or arg_3_1:getConfig("extra_gem")
		end

		setText(arg_3_0.desc, string.gsub(arg_3_1:getConfig("descrip"), "$1", var_3_19))
	elseif arg_3_1:isItemBox() then
		-- block empty
	elseif arg_3_1:isPassItem() then
		-- block empty
	end

	arg_3_0.resCount.text = "x" .. arg_3_1:getConfig("gem")
	arg_3_0.price.text = arg_3_1:getConfig("money")

	if PLATFORM_CODE == PLATFORM_CHT and arg_3_1:IsLocalPrice() then
		setActive(arg_3_0.rmb, false)
	end

	arg_3_0.iconTF.sprite = GetSpriteFromAtlas("chargeicon/1", "")

	LoadSpriteAsync("chargeicon/" .. arg_3_1:getConfig("picture"), function(arg_5_0)
		if arg_5_0 and not IsNil(arg_3_0.iconTF) then
			arg_3_0.iconTF.sprite = arg_5_0

			arg_3_0.iconTF:SetNativeSize()
		end

		return
	end)
	setButtonEnabled(arg_3_0.tr, not isActive(arg_3_0.mask))

	return
end

function var_0_0.UpdateShipIcon(arg_6_0, arg_6_1)
	if IsNil(arg_6_0.shipIcon) then
		return
	end

	setActive(arg_6_0.shipIcon, true)

	local var_6_0 = arg_6_0.shipIcon:Find("icon"):GetComponent(typeof(Image))
	local var_6_1 = arg_6_1:getConfigTable().usage_arg[1][1]

	assert(var_6_1)
	assert(pg.shop_template[var_6_1].effect_args[1])
	LoadSpriteAsync("qicon/" .. pg.ship_skin_template[pg.shop_template[var_6_1].effect_args[1]].prefab, function(arg_7_0)
		if arg_7_0 and not IsNil(arg_6_0.shipIcon) then
			var_6_0.sprite = arg_7_0
		end

		return
	end)

	return
end

function var_0_0.updateGemItem(arg_8_0, arg_8_1, arg_8_2)
	setActive(arg_8_0.mask, false)
	setActive(arg_8_0.maskState, false)
	setText(arg_8_0.limitText, "")

	arg_8_0.tipText.text = ""

	local var_8_0 = arg_8_1:getLimitCount()
	local var_8_1 = arg_8_1.buyCount or 0

	if var_8_0 > 0 then
		setText(arg_8_0.limitText, i18n("charge_limit_all", var_8_0 - var_8_1, var_8_0))
		setActive(arg_8_0.mask, var_8_0 <= var_8_1)
	end

	local var_8_2 = arg_8_1:getConfig("group_limit")

	if var_8_2 > 0 then
		local var_8_3 = arg_8_1:getConfig("group_type") or 0

		if var_8_3 == 1 then
			setText(arg_8_0.limitText, i18n("charge_limit_daily", var_8_2 - arg_8_1.groupCount, var_8_2))
		elseif var_8_3 == 2 then
			setText(arg_8_0.limitText, i18n("charge_limit_weekly", var_8_2 - arg_8_1.groupCount, var_8_2))
		elseif var_8_3 == 3 then
			setText(arg_8_0.limitText, i18n("charge_limit_monthly", var_8_2 - arg_8_1.groupCount, var_8_2))
		end
	end

	arg_8_0.price.text = arg_8_1:getConfig("resource_num")
	arg_8_0.tipText.text = ""

	setActive(arg_8_0.count, false)
	setActive(arg_8_0.icon, true)
	setText(arg_8_0.desc, "")

	local var_8_4 = arg_8_1:getConfig("tag")

	setActive(arg_8_0.tag, var_8_4 > 0)

	if var_8_4 > 0 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0.tags) do
			setActive(iter_8_1, iter_8_0 == var_8_4)
		end
	end

	setActive(arg_8_0.timeLeftTag, false)

	local var_8_5, var_8_6 = arg_8_1:inTime()

	if var_8_5 and not arg_8_1:isFree() and var_8_6 and var_8_6 > 0 then
		local var_8_7, var_8_8, var_8_9 = pg.TimeMgr.GetInstance():parseTimeFrom(var_8_6)

		if var_8_7 > 0 then
			setActive(arg_8_0.timeLeftTag, true)
			setActive(arg_8_0.dayLeftTag, true)
			setActive(arg_8_0.hourLeftTag, false)
			setActive(arg_8_0.minLeftTag, false)
			setText(arg_8_0.numLeftText, var_8_7)
		elseif var_8_8 > 0 then
			setActive(arg_8_0.timeLeftTag, true)
			setActive(arg_8_0.dayLeftTag, false)
			setActive(arg_8_0.hourLeftTag, true)
			setActive(arg_8_0.minLeftTag, false)
			setText(arg_8_0.numLeftText, var_8_8)
		elseif var_8_9 > 0 then
			setActive(arg_8_0.timeLeftTag, true)
			setActive(arg_8_0.dayLeftTag, false)
			setActive(arg_8_0.hourLeftTag, false)
			setActive(arg_8_0.minLeftTag, true)
			setText(arg_8_0.numLeftText, var_8_9)
		else
			setActive(arg_8_0.timeLeftTag, true)
			setActive(arg_8_0.dayLeftTag, false)
			setActive(arg_8_0.hourLeftTag, false)
			setActive(arg_8_0.minLeftTag, true)
			setText(arg_8_0.numLeftText, 0)
		end

		local var_8_10 = 60
		local var_8_11

		if 0 <= var_8_6 then
			var_8_11 = var_8_6 % 0
		elseif 3600 <= var_8_6 then
			var_8_11 = var_8_6 % 3600
		elseif var_8_10 <= var_8_6 then
			var_8_11 = var_8_6 % var_8_10
		end

		if var_8_11 and var_8_11 > 0 then
			if arg_8_0.countDownTimer then
				arg_8_0.countDownTimer:Stop()

				arg_8_0.countDownTimer = nil
			end

			arg_8_0.countDownTimer = Timer.New(function()
				arg_8_0:updateGemItem(arg_8_1, arg_8_2)

				return
			end, var_8_11, 1)

			arg_8_0.countDownTimer:Start()
		end
	end

	setActive(arg_8_0.name, true)

	local var_8_12 = arg_8_1:getConfig("effect_args")

	if #var_8_12 > 0 then
		local var_8_13 = Item.getConfigData(var_8_12[1])

		if var_8_13 then
			setScrollText(arg_8_0.name, var_8_13.name)
			arg_8_0:updateImport(var_8_13.display_icon, var_8_13.display)

			local var_8_14 = arg_8_0:CheckSkinDiscounItem(var_8_13.display_icon)

			if var_8_14 then
				arg_8_0:UpdateShipIcon(var_8_14)
			end
		end

		arg_8_0.iconTF.sprite = GetSpriteFromAtlas("chargeicon/1", "")

		LoadSpriteAsync(var_8_13.icon, function(arg_10_0)
			if arg_10_0 and not IsNil(arg_8_0.iconTF) then
				arg_8_0.iconTF.sprite = arg_10_0

				arg_8_0.iconTF:SetNativeSize()
			end

			return
		end)
	end

	setButtonEnabled(arg_8_0.tr, not isActive(arg_8_0.mask))

	return
end

function var_0_0.CheckSkinDiscounItem(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		local var_11_0 = Drop.Create(iter_11_1)
		local var_11_1 = var_11_0:getConfigTable()

		if var_11_1.usage and var_11_1.usage == ItemUsage.USAGE_SHOP_DISCOUNT then
			return var_11_0
		end
	end

	return nil
end

local function var_0_1(arg_12_0)
	local var_12_0 = arg_12_0:getConfigTable()

	if var_12_0.usage and var_12_0.usage == ItemUsage.USAGE_SKIN_EXP then
		return false
	end

	return true
end

function var_0_0.updateImport(arg_13_0, arg_13_1, arg_13_2)
	setActive(arg_13_0.important, true)

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		table.insert({}, Drop.Create(iter_13_1))
	end

	for iter_13_2 = 1, arg_13_0.grid.childCount do
		local var_13_0 = arg_13_0.grid:GetChild(iter_13_2 - 1)

		if iter_13_2 <= #{} then
			setActive(var_13_0, var_0_1(({})[iter_13_2]))
			updateDrop(var_13_0, ({})[iter_13_2])
		else
			setActive(var_13_0, false)
		end
	end

	setText(arg_13_0.importantTip, string.gsub(arg_13_2, "$1", #{}))

	return
end

function var_0_0.updateCountdown(arg_14_0, arg_14_1)
	local var_14_0 = false

	if arg_14_1 then
		local var_14_1 = pg.TimeMgr.GetInstance()

		var_14_0 = var_14_1:DiffDay(var_14_1:GetServerTime(), pg.TimeMgr.GetInstance():Table2ServerTime(arg_14_1)) < 365
	end

	setActive(arg_14_0.countDown, var_14_0)

	local var_14_2 = pg.TimeMgr.GetInstance()

	;(function()
		if arg_14_0.updateTimer then
			arg_14_0.updateTimer:Stop()

			arg_14_0.updateTimer = nil
		end

		return
	end)()

	local var_14_3 = pg.TimeMgr.GetInstance():Table2ServerTime(arg_14_1)

	arg_14_0.updateTimer = Timer.New(function()
		local var_16_0 = var_14_2:GetServerTime()

		if var_16_0 > var_14_3 then
			var_0()
		end

		local var_16_1 = var_14_3 - var_16_0

		var_16_1 = var_14_3 - var_16_0 < 0 and 0 or var_16_1

		local var_16_2 = math.floor(var_16_1 / 0)

		if var_16_2 > 0 then
			setText(arg_14_0.countDownTm, i18n("skin_remain_time") .. var_16_2 .. i18n("word_date"))
		else
			local var_16_3 = math.floor(var_16_1 / 16)

			if var_16_3 > 0 then
				setText(arg_14_0.countDownTm, i18n("skin_remain_time") .. var_16_3 .. i18n("word_hour"))
			else
				local var_16_4 = math.floor(var_16_1 / 60)

				if var_16_4 > 0 then
					setText(arg_14_0.countDownTm, i18n("skin_remain_time") .. var_16_4 .. i18n("word_minute"))
				else
					setText(arg_14_0.countDownTm, i18n("skin_remain_time") .. var_16_1 .. i18n("word_second"))
				end
			end
		end

		return
	end, 1, -1)

	arg_14_0.updateTimer:Start()
	arg_14_0.updateTimer.func()

	return
end

function var_0_0.destoryTimer(arg_17_0)
	if arg_17_0.updateTimer then
		arg_17_0.updateTimer:Stop()

		arg_17_0.updateTimer = nil
	end

	if arg_17_0.countDownTimer then
		arg_17_0.countDownTimer:Stop()

		arg_17_0.countDownTimer = nil
	end

	return
end

return var_0_0
