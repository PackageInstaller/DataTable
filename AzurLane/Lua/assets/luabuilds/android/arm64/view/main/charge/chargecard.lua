local var_0_0 = class("ChargeCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = tf(arg_1_1)
	arg_1_0.icon = arg_1_0.tr:Find("real_tpl/item_icon")
	arg_1_0.iconTF = arg_1_0.icon:GetComponent(typeof(Image))
	arg_1_0.shipIcon = arg_1_0.tr:Find("real_tpl/item_icon/ship")
	arg_1_0.priceTf = arg_1_0.tr:Find("real_tpl/Price/Text")
	arg_1_0.price = arg_1_0.priceTf:GetComponent(typeof(Text))
	arg_1_0.freeTag = arg_1_0.tr:Find("real_tpl/Price/FreeText")
	arg_1_0.tecShipBuyTag = arg_1_0.tr:Find("real_tpl/Price/BuyText")
	arg_1_0.contain = arg_1_0.tr:Find("real_tpl/Price")
	arg_1_0.rmb = arg_1_0.tr:Find("real_tpl/Price/icon_rmb")
	arg_1_0.gem = arg_1_0.tr:Find("real_tpl/Price/icon_gem")
	arg_1_0.name = arg_1_0.tr:Find("real_tpl/item_name_mask/item_name")
	arg_1_0.itemPanel1 = arg_1_0.tr:Find("real_tpl/itemPanel1")
	arg_1_0.firstTipText = arg_1_0.tr:Find("real_tpl/itemPanel1/Tip/Text")
	arg_1_0.secondTipText = arg_1_0.tr:Find("real_tpl/itemPanel1/Tip2/Text")
	arg_1_0.grid = arg_1_0.tr:Find("real_tpl/itemPanel1/grid")
	arg_1_0.grid1 = arg_1_0.tr:Find("real_tpl/itemPanel1/grid1")
	arg_1_0.itemPanel2 = arg_1_0.tr:Find("real_tpl/itemPanel2")
	arg_1_0.firstTipText2 = arg_1_0.tr:Find("real_tpl/itemPanel2/Tip/Text")
	arg_1_0.addImage = arg_1_0.tr:Find("real_tpl/itemPanel2/addImg")
	arg_1_0.grid2 = arg_1_0.tr:Find("real_tpl/itemPanel2/grid")
	arg_1_0.itemPanel3 = arg_1_0.tr:Find("real_tpl/itemPanel3")
	arg_1_0.firstTipText3 = arg_1_0.tr:Find("real_tpl/itemPanel3/Tip/Text")
	arg_1_0.grid3 = arg_1_0.tr:Find("real_tpl/itemPanel3/grid")
	arg_1_0.limitText = arg_1_0.tr:Find("real_tpl/LimitText")
	arg_1_0.viewBtn = arg_1_0.tr:Find("real_tpl/view")
	arg_1_0.numLeftText = arg_1_0.tr:Find("real_tpl/leftTimeText")
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

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.goods = arg_2_1

	if not IsNil(arg_2_0.shipIcon) then
		setActive(arg_2_0.shipIcon, false)
	end

	local var_2_0 = arg_2_1:isChargeType() and arg_2_1:getShowType() ~= ""
	local var_2_1 = arg_2_1:isChargeType() and not var_2_0

	setActive(arg_2_0.rmb, var_2_1)
	setActive(arg_2_0.gem, not arg_2_1:isChargeType() and not arg_2_1:isFree())
	setText(arg_2_0.freeTag, i18n("shop_free_tag"))
	setText(arg_2_0.tecShipBuyTag, i18n("word_buy"))
	setActive(arg_2_0.tecShipBuyTag, var_2_0)
	setActive(arg_2_0.freeTag, arg_2_1:isFree())
	setActive(arg_2_0.priceTf, not arg_2_1:isFree() and not var_2_0)
	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(arg_2_0.focusTip, {
		"Charge_Page_Exposure"
	}, function(arg_3_0)
		setActive(arg_3_0, arg_2_1:isTip())

		return
	end)
	setActive(arg_2_0.icon, arg_2_1:isChargeType())
	setActive(arg_2_0.contain, true)

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

function var_0_0.updateCharge(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	setActive(arg_4_0.tag, true)

	local var_4_0 = not table.contains(arg_4_3, arg_4_1.id) and arg_4_1:firstPayDouble() and 4 or arg_4_1:getConfig("tag")

	setActive(arg_4_0.tag, var_4_0 > 0)

	if var_4_0 > 0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.tags) do
			setActive(iter_4_1, iter_4_0 == var_4_0)
		end
	end

	setActive(arg_4_0.numLeftText, false)

	local var_4_1, var_4_2 = arg_4_1:inTime()
	local var_4_3 = arg_4_1:getConfig("id") == ActivityConst.FREE_PACKAGE_SHOW_TIME_ID

	if var_4_1 and (not arg_4_1:isFree() or var_4_3) and var_4_2 and var_4_2 > 0 then
		setActive(arg_4_0.numLeftText, true)

		local var_4_4, var_4_5, var_4_6 = pg.TimeMgr.GetInstance():parseTimeFrom(var_4_2)

		if var_4_4 > 0 then
			setText(arg_4_0.numLeftText, i18n("shop_goods_left_day", var_4_4))
		elseif var_4_5 > 0 then
			setText(arg_4_0.numLeftText, i18n("shop_goods_left_hour", var_4_5))
		elseif var_4_6 then
			setText(arg_4_0.numLeftText, i18n("shop_goods_left_minute", var_4_6 > 0 and var_4_6 or 1))
		end

		local var_4_7 = 60
		local var_4_8

		if 0 <= var_4_2 then
			var_4_8 = var_4_2 % 0
		elseif 3600 <= var_4_2 then
			var_4_8 = var_4_2 % 3600
		elseif var_4_7 <= var_4_2 then
			var_4_8 = var_4_2 % var_4_7
		end

		if var_4_8 and var_4_8 > 0 then
			if arg_4_0.countDownTimer then
				arg_4_0.countDownTimer:Stop()

				arg_4_0.countDownTimer = nil
			end

			arg_4_0.countDownTimer = Timer.New(function()
				arg_4_0:updateGemItem(arg_4_1, arg_4_2)

				return
			end, var_4_8, 1)

			arg_4_0.countDownTimer:Start()
		end
	end

	setScrollText(arg_4_0.name, arg_4_1:getConfig("name_display"))

	if arg_4_1:isItemBox() or arg_4_1:isGiftBox() or arg_4_1:isPassItem() then
		arg_4_0:updateImport(arg_4_0:GetPayDisplayItemData(arg_4_1))
	end

	local var_4_9 = arg_4_1:getConfig("limit_type")
	local var_4_10 = arg_4_1:getBuyCount()
	local var_4_11 = arg_4_1:getLimitCount()

	if var_4_9 == 2 then
		setText(arg_4_0.limitText, i18n("charge_limit_all", var_4_11 - var_4_10, var_4_11))
	elseif var_4_9 == 4 then
		setText(arg_4_0.limitText, i18n("charge_limit_daily", var_4_11 - var_4_10, var_4_11))
	else
		setText(arg_4_0.limitText, "")
	end

	arg_4_0.price.text = arg_4_1:getConfig("money")

	if PLATFORM_CODE == PLATFORM_CHT and arg_4_1:IsLocalPrice() then
		setActive(arg_4_0.rmb, false)
	end

	arg_4_0.iconTF.sprite = GetSpriteFromAtlas("chargeicon/1", "")

	LoadSpriteAsync("chargeicon/" .. arg_4_1:getConfig("picture"), function(arg_6_0)
		if arg_6_0 and not IsNil(arg_4_0.iconTF) then
			arg_4_0.iconTF.sprite = arg_6_0
		end

		return
	end)

	return
end

function var_0_0.UpdateShipIcon(arg_7_0, arg_7_1)
	if IsNil(arg_7_0.shipIcon) then
		return
	end

	setActive(arg_7_0.shipIcon, true)

	local var_7_0 = arg_7_0.shipIcon:Find("icon"):GetComponent(typeof(Image))
	local var_7_1 = arg_7_1:getConfigTable().usage_arg[1][1]

	assert(var_7_1)
	assert(pg.shop_template[var_7_1].effect_args[1])
	LoadSpriteAsync("qicon/" .. pg.ship_skin_template[pg.shop_template[var_7_1].effect_args[1]].prefab, function(arg_8_0)
		if arg_8_0 and not IsNil(arg_7_0.shipIcon) then
			var_7_0.sprite = arg_8_0
		end

		return
	end)

	return
end

function var_0_0.updateGemItem(arg_9_0, arg_9_1, arg_9_2)
	setText(arg_9_0.limitText, "")

	local var_9_0 = arg_9_1:getLimitCount()

	if var_9_0 > 0 then
		setText(arg_9_0.limitText, i18n("charge_limit_all", var_9_0 - arg_9_1:getBuyCount(), var_9_0))
	end

	local var_9_1 = arg_9_1:getConfig("group_limit")

	if var_9_1 > 0 then
		local var_9_2 = arg_9_1:getConfig("group_type") or 0

		if var_9_2 == 1 then
			setText(arg_9_0.limitText, i18n("charge_limit_daily", var_9_1 - arg_9_1.groupCount, var_9_1))
		elseif var_9_2 == 2 then
			setText(arg_9_0.limitText, i18n("charge_limit_weekly", var_9_1 - arg_9_1.groupCount, var_9_1))
		elseif var_9_2 == 3 then
			setText(arg_9_0.limitText, i18n("charge_limit_monthly", var_9_1 - arg_9_1.groupCount, var_9_1))
		end
	end

	arg_9_0.price.text = arg_9_1:GetPrice()

	setActive(arg_9_0.icon, true)

	local var_9_3 = arg_9_1:getConfig("tag")

	setActive(arg_9_0.tag, var_9_3 > 0)

	if var_9_3 > 0 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.tags) do
			setActive(iter_9_1, iter_9_0 == var_9_3)
		end
	end

	setActive(arg_9_0.numLeftText, false)

	local var_9_4, var_9_5 = arg_9_1:inTime()
	local var_9_6 = arg_9_1:getConfig("id") == ActivityConst.FREE_PACKAGE_SHOW_TIME_ID

	if var_9_4 and (not arg_9_1:isFree() or var_9_6) and var_9_5 and var_9_5 > 0 then
		setActive(arg_9_0.numLeftText, true)

		local var_9_7, var_9_8, var_9_9 = pg.TimeMgr.GetInstance():parseTimeFrom(var_9_5)

		if var_9_7 > 0 then
			setText(arg_9_0.numLeftText, i18n("shop_goods_left_day", var_9_7))
		elseif var_9_8 > 0 then
			setText(arg_9_0.numLeftText, i18n("shop_goods_left_hour", var_9_8))
		elseif var_9_9 then
			setText(arg_9_0.numLeftText, i18n("shop_goods_left_minute", var_9_9 > 0 and var_9_9 or 1))
		end

		local var_9_10 = 60
		local var_9_11

		if 0 <= var_9_5 then
			var_9_11 = var_9_5 % 0
		elseif 3600 <= var_9_5 then
			var_9_11 = var_9_5 % 3600
		elseif var_9_10 <= var_9_5 then
			var_9_11 = var_9_5 % var_9_10
		end

		if var_9_11 and var_9_11 > 0 then
			if arg_9_0.countDownTimer then
				arg_9_0.countDownTimer:Stop()

				arg_9_0.countDownTimer = nil
			end

			arg_9_0.countDownTimer = Timer.New(function()
				arg_9_0:updateGemItem(arg_9_1, arg_9_2)

				return
			end, var_9_11, 1)

			arg_9_0.countDownTimer:Start()
		end
	end

	setActive(arg_9_0.name, true)

	local var_9_12 = arg_9_1:getConfig("effect_args")

	if #var_9_12 > 0 then
		local var_9_13 = Item.getConfigData(var_9_12[1])

		if var_9_13 then
			setScrollText(arg_9_0.name, var_9_13.name)
			arg_9_0:updateImport(arg_9_0:GetShopDisplayItemData(arg_9_1))

			local var_9_14 = arg_9_0:CheckSkinDiscounItem(var_9_13.display_icon)

			if var_9_14 then
				arg_9_0:UpdateShipIcon(var_9_14)
			end
		end

		arg_9_0.iconTF.sprite = GetSpriteFromAtlas("chargeicon/1", "")

		LoadSpriteAsync(var_9_13.icon, function(arg_11_0)
			if arg_11_0 and not IsNil(arg_9_0.iconTF) then
				arg_9_0.iconTF.sprite = arg_11_0
			end

			return
		end)
	end

	return
end

function var_0_0.CheckSkinDiscounItem(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		local var_12_0 = Drop.Create(iter_12_1)
		local var_12_1 = var_12_0:getConfigTable()

		if var_12_1.usage and var_12_1.usage == ItemUsage.USAGE_SHOP_DISCOUNT then
			return var_12_0
		end
	end

	return nil
end

local function var_0_1(arg_13_0)
	local var_13_0 = arg_13_0:getConfigTable()

	if var_13_0.usage and var_13_0.usage == ItemUsage.USAGE_SKIN_EXP then
		return false
	end

	return true
end

function var_0_0.updateImport(arg_14_0, arg_14_1)
	local var_14_0 = #arg_14_1 >= 2

	setActive(arg_14_0.itemPanel1, #arg_14_1 >= 2)

	if var_14_0 then
		setActive(arg_14_0.itemPanel2, false)
		setActive(arg_14_0.itemPanel3, false)
		setScrollText(arg_14_0.firstTipText, arg_14_1[1].text)
		setScrollText(arg_14_0.secondTipText, arg_14_1[2].text)

		for iter_14_0, iter_14_1 in ipairs(arg_14_1[1].list) do
			table.insert({}, Drop.Create(iter_14_1))
		end

		for iter_14_2 = 1, arg_14_0.grid1.childCount do
			local var_14_1 = arg_14_0.grid:GetChild(iter_14_2 - 1)

			if iter_14_2 <= #{} then
				setActive(var_14_1, var_0_1(({})[iter_14_2]))
				updateDrop(var_14_1:Find("itemBg/item"), ({})[iter_14_2])
			else
				setActive(var_14_1, false)
			end
		end

		for iter_14_3, iter_14_4 in ipairs(arg_14_1[2].list) do
			table.insert({}, Drop.Create(iter_14_4))
		end

		for iter_14_5 = 1, arg_14_0.grid1.childCount do
			local var_14_2 = arg_14_0.grid1:GetChild(iter_14_5 - 1)

			if iter_14_5 <= #{} then
				setActive(var_14_2, var_0_1(({})[iter_14_5]))
				updateDrop(var_14_2:Find("itemBg/item"), ({})[iter_14_5])
			else
				setActive(var_14_2, false)
			end
		end
	else
		local var_14_3 = arg_14_1[1].text
		local var_14_4 = arg_14_1[1].text == ""

		setActive(arg_14_0.itemPanel2, not (arg_14_1[1].text == ""))
		setActive(arg_14_0.itemPanel3, var_14_4)

		if var_14_4 then
			setScrollText(arg_14_0.firstTipText3, i18n("shop_item_unlock"))

			for iter_14_6, iter_14_7 in ipairs(arg_14_1[1].list) do
				table.insert({}, Drop.Create(iter_14_7))
			end

			for iter_14_8 = 1, arg_14_0.grid3.childCount do
				local var_14_5 = arg_14_0.grid3:GetChild(iter_14_8 - 1)

				if iter_14_8 <= #{} then
					setActive(var_14_5, var_0_1(({})[iter_14_8]))
					updateDrop(var_14_5:Find("itemBg/item"), ({})[iter_14_8])
				else
					setActive(var_14_5, false)
				end
			end
		else
			setScrollText(arg_14_0.firstTipText2, var_14_3)

			for iter_14_9, iter_14_10 in ipairs(arg_14_1[1].list) do
				table.insert({}, Drop.Create(iter_14_10))
			end

			for iter_14_11 = 1, arg_14_0.grid2.childCount do
				local var_14_6 = arg_14_0.grid2:GetChild(iter_14_11 - 1)

				if iter_14_11 <= #{} then
					setActive(var_14_6, var_0_1(({})[iter_14_11]))
					updateDrop(var_14_6:Find("itemBg/item"), ({})[iter_14_11])
				else
					setActive(var_14_6, false)
				end
			end
		end
	end

	return
end

function var_0_0.GetPayDisplayItemData(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:getConfig("first_text")

	if var_15_0 ~= "" then
		table.insert({}, {
			text = var_15_0,
			list = arg_15_1:getConfig("first_icon")
		})
	end

	;({}).text = arg_15_1:getConfig("second_text")
	;({}).list = arg_15_1:getConfig("display")

	table.insert({}, {})

	return {}
end

function var_0_0.GetShopDisplayItemData(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getConfig("first_text")

	if var_16_0 ~= "" then
		table.insert({}, {
			text = var_16_0,
			list = arg_16_1:getConfig("first_icon")
		})
	end

	;({}).text = arg_16_1:getConfig("second_text")
	;({}).list = Item.getConfigData(arg_16_1:getConfig("effect_args")[1]).display_icon

	table.insert({}, {})

	return {}
end

function var_0_0.destoryTimer(arg_17_0)
	if arg_17_0.countDownTimer then
		arg_17_0.countDownTimer:Stop()

		arg_17_0.countDownTimer = nil
	end

	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:destoryTimer()
	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(arg_18_0.focusTip)

	return
end

return var_0_0
