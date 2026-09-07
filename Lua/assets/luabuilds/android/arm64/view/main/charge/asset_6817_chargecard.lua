local ChargeCard = class("ChargeCard")

function ChargeCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tr = tf(arg_1_1)
	self.icon = self.tr:Find("real_tpl/item_icon")
	self.iconTF = self.icon:GetComponent(typeof(Image))
	self.shipIcon = self.tr:Find("real_tpl/item_icon/ship")
	self.priceTf = self.tr:Find("real_tpl/Price/Text")
	self.price = self.priceTf:GetComponent(typeof(Text))
	self.freeTag = self.tr:Find("real_tpl/Price/FreeText")
	self.tecShipBuyTag = self.tr:Find("real_tpl/Price/BuyText")
	self.contain = self.tr:Find("real_tpl/Price")
	self.rmb = self.tr:Find("real_tpl/Price/icon_rmb")
	self.gem = self.tr:Find("real_tpl/Price/icon_gem")
	self.name = self.tr:Find("real_tpl/item_name_mask/item_name")
	self.itemPanel1 = self.tr:Find("real_tpl/itemPanel1")
	self.firstTipText = self.tr:Find("real_tpl/itemPanel1/Tip/Text")
	self.secondTipText = self.tr:Find("real_tpl/itemPanel1/Tip2/Text")
	self.grid = self.tr:Find("real_tpl/itemPanel1/grid")
	self.grid1 = self.tr:Find("real_tpl/itemPanel1/grid1")
	self.itemPanel2 = self.tr:Find("real_tpl/itemPanel2")
	self.firstTipText2 = self.tr:Find("real_tpl/itemPanel2/Tip/Text")
	self.addImage = self.tr:Find("real_tpl/itemPanel2/addImg")
	self.grid2 = self.tr:Find("real_tpl/itemPanel2/grid")
	self.itemPanel3 = self.tr:Find("real_tpl/itemPanel3")
	self.firstTipText3 = self.tr:Find("real_tpl/itemPanel3/Tip/Text")
	self.grid3 = self.tr:Find("real_tpl/itemPanel3/grid")
	self.limitText = self.tr:Find("real_tpl/LimitText")
	self.viewBtn = self.tr:Find("real_tpl/view")
	self.numLeftText = self.tr:Find("real_tpl/leftTimeText")
	self.focusTip = self.tr:Find("real_tpl/focus_tip")
	self.tag = self.tr:Find("real_tpl/tag")
	self.tags = {}

	table.insert(self.tags, self.tr:Find("real_tpl/tag/hot"))
	table.insert(self.tags, self.tr:Find("real_tpl/tag/new"))
	table.insert(self.tags, self.tr:Find("real_tpl/tag/advice"))
	table.insert(self.tags, self.tr:Find("real_tpl/tag/double"))
	table.insert(self.tags, self.tr:Find("real_tpl/tag/activity"))
	table.insert(self.tags, self.tr:Find("real_tpl/tag/time"))
	table.insert(self.tags, self.tr:Find("real_tpl/tag/discount"))

	self.packageTag = self.tr:Find("real_tpl/package_tag")

	return
end

function ChargeCard:update(arg_2_1, arg_2_2, arg_2_3)
	self.goods = arg_2_1

	if not IsNil(self.shipIcon) then
		setActive(self.shipIcon, false)
	end

	local var_2_0 = arg_2_1:isChargeType() and arg_2_1:getShowType() ~= ""

	setActive(self.rmb, arg_2_1:isChargeType() and not var_2_0)
	setActive(self.gem, not arg_2_1:isChargeType() and not arg_2_1:isFree())
	setText(self.freeTag, i18n("shop_free_tag"))
	setText(self.tecShipBuyTag, i18n("word_buy"))
	setActive(self.tecShipBuyTag, var_2_0)
	setActive(self.freeTag, arg_2_1:isFree())
	setActive(self.priceTf, not arg_2_1:isFree() and not var_2_0)
	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.focusTip, {
		"Charge_Page_Exposure"
	}, function(arg_3_0)
		setActive(arg_3_0, arg_2_1:isTip())

		return
	end)
	setActive(self.icon, arg_2_1:isChargeType())
	setActive(self.contain, true)

	if self.viewBtn then
		setActive(self.viewBtn, arg_2_1:isChargeType() and arg_2_1:CanViewSkinProbability())
	end

	if self.packageTag then
		local var_2_1 = arg_2_1:GetPackageTag()

		setActive(self.packageTag, var_2_1 ~= "")
		setText(self.packageTag:Find("Text"), var_2_1)
	end

	if arg_2_1:isChargeType() then
		self:updateCharge(arg_2_1, arg_2_2, arg_2_3)
	else
		self:updateGemItem(arg_2_1, arg_2_2)
	end

	self:destoryTimer()

	return
end

function ChargeCard:updateCharge(arg_4_1, arg_4_2, arg_4_3)
	setActive(self.tag, true)

	local var_4_0 = not table.contains(arg_4_3, arg_4_1.id) and arg_4_1:firstPayDouble() and 4 or arg_4_1:getConfig("tag")

	setActive(self.tag, var_4_0 > 0)

	if var_4_0 > 0 then
		for iter_4_0, iter_4_1 in ipairs(self.tags) do
			setActive(iter_4_1, iter_4_0 == var_4_0)
		end
	end

	setActive(self.numLeftText, false)

	local var_4_1, var_4_2 = arg_4_1:inTime()

	if var_4_1 and (not arg_4_1:isFree() or arg_4_1:getConfig("id") == ActivityConst.FREE_PACKAGE_SHOW_TIME_ID) and var_4_2 and var_4_2 > 0 then
		setActive(self.numLeftText, true)

		local var_4_3, var_4_4, var_4_5 = pg.TimeMgr.GetInstance():parseTimeFrom(var_4_2)

		if var_4_3 > 0 then
			setText(self.numLeftText, i18n("shop_goods_left_day", var_4_3))
		elseif var_4_4 > 0 then
			setText(self.numLeftText, i18n("shop_goods_left_hour", var_4_4))
		elseif var_4_5 then
			setText(self.numLeftText, i18n("shop_goods_left_minute", var_4_5 > 0 and var_4_5 or 1))
		end

		local var_4_6 = 60
		local var_4_7

		if 0 <= var_4_2 then
			var_4_7 = var_4_2 % 0
		elseif 3600 <= var_4_2 then
			var_4_7 = var_4_2 % 3600
		elseif var_4_6 <= var_4_2 then
			var_4_7 = var_4_2 % var_4_6
		end

		if var_4_7 and var_4_7 > 0 then
			if self.countDownTimer then
				self.countDownTimer:Stop()

				self.countDownTimer = nil
			end

			self.countDownTimer = Timer.New(function()
				self:updateGemItem(arg_4_1, arg_4_2)

				return
			end, var_4_7, 1)

			self.countDownTimer:Start()
		end
	end

	setScrollText(self.name, arg_4_1:getConfig("name_display"))

	if arg_4_1:isItemBox() or arg_4_1:isGiftBox() or arg_4_1:isPassItem() then
		self:updateImport(self:GetPayDisplayItemData(arg_4_1))
	end

	local var_4_8 = arg_4_1:getConfig("limit_type")
	local var_4_9 = arg_4_1:getBuyCount()
	local var_4_10 = arg_4_1:getLimitCount()

	if var_4_8 == 2 then
		setText(self.limitText, i18n("charge_limit_all", var_4_10 - var_4_9, var_4_10))
	elseif var_4_8 == 4 then
		setText(self.limitText, i18n("charge_limit_daily", var_4_10 - var_4_9, var_4_10))
	else
		setText(self.limitText, "")
	end

	self.price.text = arg_4_1:getConfig("money")

	if PLATFORM_CODE == PLATFORM_CHT and arg_4_1:IsLocalPrice() then
		setActive(self.rmb, false)
	end

	self.iconTF.sprite = GetSpriteFromAtlas("chargeicon/1", "")

	LoadSpriteAsync("chargeicon/" .. arg_4_1:getConfig("picture"), function(arg_6_0)
		if arg_6_0 and not IsNil(self.iconTF) then
			self.iconTF.sprite = arg_6_0
		end

		return
	end)

	return
end

function ChargeCard:UpdateShipIcon(arg_7_1)
	if IsNil(self.shipIcon) then
		return
	end

	setActive(self.shipIcon, true)

	local var_7_0 = self.shipIcon:Find("icon"):GetComponent(typeof(Image))
	local var_7_1 = arg_7_1:getConfigTable().usage_arg[1][1]

	assert(var_7_1)
	assert(pg.shop_template[var_7_1].effect_args[1])
	LoadSpriteAsync("qicon/" .. pg.ship_skin_template[pg.shop_template[var_7_1].effect_args[1]].prefab, function(arg_8_0)
		if arg_8_0 and not IsNil(self.shipIcon) then
			var_7_0.sprite = arg_8_0
		end

		return
	end)

	return
end

function ChargeCard:updateGemItem(arg_9_1, arg_9_2)
	setText(self.limitText, "")

	local var_9_0 = arg_9_1:getLimitCount()

	if var_9_0 > 0 then
		setText(self.limitText, i18n("charge_limit_all", var_9_0 - arg_9_1:getBuyCount(), var_9_0))
	end

	local var_9_1 = arg_9_1:getConfig("group_limit")

	if var_9_1 > 0 then
		local var_9_2 = arg_9_1:getConfig("group_type") or 0

		if var_9_2 == 1 then
			setText(self.limitText, i18n("charge_limit_daily", var_9_1 - arg_9_1.groupCount, var_9_1))
		elseif var_9_2 == 2 then
			setText(self.limitText, i18n("charge_limit_weekly", var_9_1 - arg_9_1.groupCount, var_9_1))
		elseif var_9_2 == 3 then
			setText(self.limitText, i18n("charge_limit_monthly", var_9_1 - arg_9_1.groupCount, var_9_1))
		end
	end

	self.price.text = arg_9_1:GetPrice()

	setActive(self.icon, true)

	local var_9_3 = arg_9_1:getConfig("tag")

	setActive(self.tag, var_9_3 > 0)

	if var_9_3 > 0 then
		for iter_9_0, iter_9_1 in ipairs(self.tags) do
			setActive(iter_9_1, iter_9_0 == var_9_3)
		end
	end

	setActive(self.numLeftText, false)

	local var_9_4, var_9_5 = arg_9_1:inTime()

	if var_9_4 and (not arg_9_1:isFree() or arg_9_1:getConfig("id") == ActivityConst.FREE_PACKAGE_SHOW_TIME_ID) and var_9_5 and var_9_5 > 0 then
		setActive(self.numLeftText, true)

		local var_9_6, var_9_7, var_9_8 = pg.TimeMgr.GetInstance():parseTimeFrom(var_9_5)

		if var_9_6 > 0 then
			setText(self.numLeftText, i18n("shop_goods_left_day", var_9_6))
		elseif var_9_7 > 0 then
			setText(self.numLeftText, i18n("shop_goods_left_hour", var_9_7))
		elseif var_9_8 then
			setText(self.numLeftText, i18n("shop_goods_left_minute", var_9_8 > 0 and var_9_8 or 1))
		end

		local var_9_9 = 60
		local var_9_10

		if 0 <= var_9_5 then
			var_9_10 = var_9_5 % 0
		elseif 3600 <= var_9_5 then
			var_9_10 = var_9_5 % 3600
		elseif var_9_9 <= var_9_5 then
			var_9_10 = var_9_5 % var_9_9
		end

		if var_9_10 and var_9_10 > 0 then
			if self.countDownTimer then
				self.countDownTimer:Stop()

				self.countDownTimer = nil
			end

			self.countDownTimer = Timer.New(function()
				self:updateGemItem(arg_9_1, arg_9_2)

				return
			end, var_9_10, 1)

			self.countDownTimer:Start()
		end
	end

	setActive(self.name, true)

	local var_9_11 = arg_9_1:getConfig("effect_args")

	if #var_9_11 > 0 then
		local var_9_12 = Item.getConfigData(var_9_11[1])

		if var_9_12 then
			setScrollText(self.name, var_9_12.name)
			self:updateImport(self:GetShopDisplayItemData(arg_9_1))

			local var_9_13 = self:CheckSkinDiscounItem(var_9_12.display_icon)

			if var_9_13 then
				self:UpdateShipIcon(var_9_13)
			end
		end

		self.iconTF.sprite = GetSpriteFromAtlas("chargeicon/1", "")

		LoadSpriteAsync(var_9_12.icon, function(arg_11_0)
			if arg_11_0 and not IsNil(self.iconTF) then
				self.iconTF.sprite = arg_11_0
			end

			return
		end)
	end

	return
end

function ChargeCard:CheckSkinDiscounItem(arg_12_1)
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

function ChargeCard:updateImport(arg_14_1)
	local var_14_0 = #arg_14_1 >= 2

	setActive(self.itemPanel1, #arg_14_1 >= 2)

	if var_14_0 then
		setActive(self.itemPanel2, false)
		setActive(self.itemPanel3, false)
		setScrollText(self.firstTipText, arg_14_1[1].text)
		setScrollText(self.secondTipText, arg_14_1[2].text)

		local var_14_1 = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_1[1].list) do
			table.insert(var_14_1, Drop.Create(iter_14_1))
		end

		for iter_14_2 = 1, self.grid1.childCount do
			local var_14_2 = self.grid:GetChild(iter_14_2 - 1)

			if iter_14_2 <= #var_14_1 then
				setActive(var_14_2, var_0_1(var_14_1[iter_14_2]))
				updateDrop(var_14_2:Find("itemBg/item"), var_14_1[iter_14_2])
			else
				setActive(var_14_2, false)
			end
		end

		local var_14_3 = {}

		for iter_14_3, iter_14_4 in ipairs(arg_14_1[2].list) do
			table.insert(var_14_3, Drop.Create(iter_14_4))
		end

		for iter_14_5 = 1, self.grid1.childCount do
			local var_14_4 = self.grid1:GetChild(iter_14_5 - 1)

			if iter_14_5 <= #var_14_3 then
				setActive(var_14_4, var_0_1(var_14_3[iter_14_5]))
				updateDrop(var_14_4:Find("itemBg/item"), var_14_3[iter_14_5])
			else
				setActive(var_14_4, false)
			end
		end
	else
		local var_14_5 = arg_14_1[1].text
		local var_14_6 = arg_14_1[1].text == ""

		setActive(self.itemPanel2, not (arg_14_1[1].text == ""))
		setActive(self.itemPanel3, var_14_6)

		if var_14_6 then
			setScrollText(self.firstTipText3, i18n("shop_item_unlock"))

			local var_14_7 = {}

			for iter_14_6, iter_14_7 in ipairs(arg_14_1[1].list) do
				table.insert(var_14_7, Drop.Create(iter_14_7))
			end

			for iter_14_8 = 1, self.grid3.childCount do
				local var_14_8 = self.grid3:GetChild(iter_14_8 - 1)

				if iter_14_8 <= #var_14_7 then
					setActive(var_14_8, var_0_1(var_14_7[iter_14_8]))
					updateDrop(var_14_8:Find("itemBg/item"), var_14_7[iter_14_8])
				else
					setActive(var_14_8, false)
				end
			end
		else
			setScrollText(self.firstTipText2, var_14_5)

			local var_14_9 = {}

			for iter_14_9, iter_14_10 in ipairs(arg_14_1[1].list) do
				table.insert(var_14_9, Drop.Create(iter_14_10))
			end

			for iter_14_11 = 1, self.grid2.childCount do
				local var_14_10 = self.grid2:GetChild(iter_14_11 - 1)

				if iter_14_11 <= #var_14_9 then
					setActive(var_14_10, var_0_1(var_14_9[iter_14_11]))
					updateDrop(var_14_10:Find("itemBg/item"), var_14_9[iter_14_11])
				else
					setActive(var_14_10, false)
				end
			end
		end
	end

	return
end

function ChargeCard:GetPayDisplayItemData(arg_15_1)
	local var_15_0 = {}
	local var_15_1 = arg_15_1:getConfig("first_text")
	local var_15_2

	if var_15_1 ~= "" then
		table.insert(var_15_0, {
			text = var_15_1,
			list = arg_15_1:getConfig("first_icon")
		})

		var_15_2 = {}
	end

	var_15_2.text = arg_15_1:getConfig("second_text")
	var_15_2.list = arg_15_1:getConfig("display")

	table.insert(var_15_0, var_15_2)

	return var_15_0
end

function ChargeCard:GetShopDisplayItemData(arg_16_1)
	local var_16_0 = {}
	local var_16_1 = arg_16_1:getConfig("first_text")
	local var_16_2

	if var_16_1 ~= "" then
		table.insert(var_16_0, {
			text = var_16_1,
			list = arg_16_1:getConfig("first_icon")
		})

		var_16_2 = {}
	end

	var_16_2.text = arg_16_1:getConfig("second_text")
	var_16_2.list = Item.getConfigData(arg_16_1:getConfig("effect_args")[1]).display_icon

	table.insert(var_16_0, var_16_2)

	return var_16_0
end

function ChargeCard:destoryTimer()
	if self.countDownTimer then
		self.countDownTimer:Stop()

		self.countDownTimer = nil
	end

	return
end

function ChargeCard:Dispose()
	self:destoryTimer()
	pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.focusTip)

	return
end

return ChargeCard
