local OldChargeCard = class("OldChargeCard")

function OldChargeCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tr = tf(arg_1_1)
	self.icon = self.tr:Find("real_tpl/item_icon")
	self.iconTF = self.icon:GetComponent(typeof(Image))
	self.shipIcon = self.tr:Find("real_tpl/item_icon/ship")
	self.tipTF = self.tr:Find("real_tpl/tip")
	self.tipText = self.tipTF:GetComponent(typeof(Text))
	self.count = self.tr:Find("real_tpl/count")
	self.resIcon = self.tr:Find("real_tpl/count/icon"):GetComponent(typeof(Image))
	self.resCount = self.tr:Find("real_tpl/count/Text"):GetComponent(typeof(Text))
	self.priceTf = self.tr:Find("real_tpl/prince_bg/contain/Text")
	self.price = self.priceTf:GetComponent(typeof(Text))
	self.freeTag = self.tr:Find("real_tpl/prince_bg/contain/FreeText")
	self.tecShipBuyTag = self.tr:Find("real_tpl/prince_bg/contain/BuyText")
	self.contain = self.tr:Find("real_tpl/prince_bg/contain")
	self.rmb = self.tr:Find("real_tpl/prince_bg/contain/icon_rmb")
	self.gem = self.tr:Find("real_tpl/prince_bg/contain/icon_gem")
	self.mask = self.tr:Find("real_tpl/mask")
	self.maskState = self.mask:Find("state")
	self.name = self.tr:Find("real_tpl/item_name_mask/item_name")
	self.important = self.tr:Find("real_tpl/important")
	self.grid = self.tr:Find("real_tpl/important/grid")
	self.importantTip = self.tr:Find("real_tpl/important/tip")
	self.desc = self.tr:Find("real_tpl/desc")
	self.selfTpl = self.tr:Find("real_tpl/important/item")
	self.limitText = self.tr:Find("real_tpl/LimitText")
	self.countDown = self.tr:Find("real_tpl/countDown")
	self.countDownTm = self.countDown:Find("Text")
	self.viewBtn = self.tr:Find("real_tpl/view")
	self.timeLeftTag = self.tr:Find("real_tpl/time_left")
	self.dayLeftTag = self.tr:Find("real_tpl/time_left/day")
	self.hourLeftTag = self.tr:Find("real_tpl/time_left/hour")
	self.minLeftTag = self.tr:Find("real_tpl/time_left/min")
	self.numLeftText = self.timeLeftTag:Find("Text")
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

	setActive(self.countDown, false)

	return
end

function OldChargeCard:update(arg_2_1, arg_2_2, arg_2_3)
	self.goods = arg_2_1

	if not IsNil(self.shipIcon) then
		setActive(self.shipIcon, false)
	end

	local var_2_0 = arg_2_1:isChargeType() and arg_2_1:getShowType() ~= ""

	setActive(self.desc, true)
	setText(self.desc, "")
	setActive(self.rmb, arg_2_1:isChargeType() and not var_2_0)
	setActive(self.gem, not arg_2_1:isChargeType() and not arg_2_1:isFree())
	setText(self.freeTag, i18n("shop_free_tag"))
	setText(self.tecShipBuyTag, i18n("word_buy"))
	setActive(self.tecShipBuyTag, var_2_0)
	setActive(self.freeTag, arg_2_1:isFree())
	setActive(self.priceTf, not arg_2_1:isFree() and not var_2_0)
	setActive(self.focusTip, arg_2_1:isTip())
	setActive(self.icon, arg_2_1:isChargeType())
	setActive(self.contain, true)
	setActive(self.countDown, false)

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

function OldChargeCard:updateCharge(arg_3_1, arg_3_2, arg_3_3)
	setActive(self.tag, true)
	setActive(self.mask, false)
	setActive(self.maskState, false)

	self.tipText.text = ""

	setText(self.desc, "")

	local var_3_0 = not table.contains(arg_3_3, arg_3_1.id)
	local var_3_1 = var_3_0 and arg_3_1:firstPayDouble()
	local var_3_2 = var_3_1 and 4 or arg_3_1:getConfig("tag")

	setActive(self.timeLeftTag, false)
	setActive(self.tag, var_3_2 > 0)

	if var_3_2 > 0 then
		for iter_3_0, iter_3_1 in ipairs(self.tags) do
			setActive(iter_3_1, iter_3_0 == var_3_2)
		end
	end

	setActive(self.timeLeftTag, false)

	local var_3_3, var_3_4 = arg_3_1:inTime()

	if var_3_3 and not arg_3_1:isFree() and var_3_4 and var_3_4 > 0 then
		local var_3_5, var_3_6, var_3_7 = pg.TimeMgr.GetInstance():parseTimeFrom(var_3_4)

		if var_3_5 > 0 then
			setActive(self.timeLeftTag, true)
			setActive(self.dayLeftTag, true)
			setActive(self.hourLeftTag, false)
			setActive(self.minLeftTag, false)
			setText(self.numLeftText, var_3_5)
		elseif var_3_6 > 0 then
			setActive(self.timeLeftTag, true)
			setActive(self.dayLeftTag, false)
			setActive(self.hourLeftTag, true)
			setActive(self.minLeftTag, false)
			setText(self.numLeftText, var_3_6)
		elseif var_3_7 > 0 then
			setActive(self.timeLeftTag, true)
			setActive(self.dayLeftTag, false)
			setActive(self.hourLeftTag, false)
			setActive(self.minLeftTag, true)
			setText(self.numLeftText, var_3_7)
		else
			setActive(self.timeLeftTag, true)
			setActive(self.dayLeftTag, false)
			setActive(self.hourLeftTag, false)
			setActive(self.minLeftTag, true)
			setText(self.numLeftText, 0)
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
			if self.countDownTimer then
				self.countDownTimer:Stop()

				self.countDownTimer = nil
			end

			self.countDownTimer = Timer.New(function()
				self:updateGemItem(arg_3_1, arg_3_2)

				return
			end, var_3_9, 1)

			self.countDownTimer:Start()
		end
	end

	setActive(self.resIcon, not arg_3_1:isItemBox())
	setActive(self.resCount, not arg_3_1:isItemBox())

	local var_3_10 = arg_3_1:isGem()

	setActive(self.name, not var_3_10)
	setScrollText(self.name, arg_3_1:getConfig("name_display"))
	setActive(self.important, arg_3_1:isItemBox() or arg_3_1:isGiftBox())
	setActive(self.count, var_3_10 or arg_3_1:isMonthCard())

	if arg_3_1:isItemBox() or arg_3_1:isGiftBox() or arg_3_1:isPassItem() then
		self:updateImport(arg_3_1:getConfig("display"), arg_3_1:getConfig("descrip"))
	end

	local var_3_11 = arg_3_1:getConfig("limit_type")
	local var_3_12 = arg_3_1.buyCount
	local var_3_13 = arg_3_1:getLimitCount()

	if var_3_11 == 2 then
		setText(self.limitText, i18n("charge_limit_all", var_3_13 - var_3_12, var_3_13))
		setActive(self.mask, var_3_13 - var_3_12 <= 0)
	elseif var_3_11 == 4 then
		setText(self.limitText, i18n("charge_limit_daily", var_3_13 - var_3_12, var_3_13))
		setActive(self.mask, var_3_13 - var_3_12 <= 0)
	else
		setText(self.limitText, "")
	end

	if arg_3_1:isGem() then
		setActive(self.tipTF, true)

		if var_3_1 then
			self.tipText.text = i18n("charge_double_gem_tip", arg_3_1:getConfig("gem") * arg_3_1:getConfig("first_pay_double"))
		elseif arg_3_1:hasExtraGem() then
			self.tipText.text = i18n("charge_extra_gem_tip", arg_3_1:getConfig("extra_gem"))
		else
			setActive(self.tipTF, false)
		end
	elseif arg_3_1:isGiftBox() then
		-- block empty
	elseif arg_3_1:isMonthCard() then
		local var_3_14 = arg_3_2:getCardById(VipCard.MONTH)
		local var_3_18

		if var_3_14 and not var_3_14:isExpire() then
			local var_3_15 = pg.TimeMgr.GetInstance()
			local var_3_16 = math.floor((var_3_14:getLeftDate() - var_3_15:GetServerTime()) / 0)
			local var_3_17 = arg_3_1:getConfig("limit_arg")

			setActive(self.mask, ((not var_3_15 or nil) and 0) < var_3_16)
			setText(self.limitText, i18n("charge_month_card_lefttime_tip", var_3_16))

			var_3_18 = var_3_0 and arg_3_1:getConfig("gem") or arg_3_1:getConfig("extra_gem")
		end

		setText(self.desc, string.gsub(arg_3_1:getConfig("descrip"), "$1", var_3_18))
	elseif arg_3_1:isItemBox() then
		-- block empty
	elseif arg_3_1:isPassItem() then
		-- block empty
	end

	self.resCount.text = "x" .. arg_3_1:getConfig("gem")
	self.price.text = arg_3_1:getConfig("money")

	if PLATFORM_CODE == PLATFORM_CHT and arg_3_1:IsLocalPrice() then
		setActive(self.rmb, false)
	end

	self.iconTF.sprite = GetSpriteFromAtlas("chargeicon/1", "")

	LoadSpriteAsync("chargeicon/" .. arg_3_1:getConfig("picture"), function(arg_5_0)
		if arg_5_0 and not IsNil(self.iconTF) then
			self.iconTF.sprite = arg_5_0

			self.iconTF:SetNativeSize()
		end

		return
	end)
	setButtonEnabled(self.tr, not isActive(self.mask))

	return
end

function OldChargeCard:UpdateShipIcon(arg_6_1)
	if IsNil(self.shipIcon) then
		return
	end

	setActive(self.shipIcon, true)

	local var_6_0 = self.shipIcon:Find("icon"):GetComponent(typeof(Image))
	local var_6_1 = arg_6_1:getConfigTable().usage_arg[1][1]

	assert(var_6_1)
	assert(pg.shop_template[var_6_1].effect_args[1])
	LoadSpriteAsync("qicon/" .. pg.ship_skin_template[pg.shop_template[var_6_1].effect_args[1]].prefab, function(arg_7_0)
		if arg_7_0 and not IsNil(self.shipIcon) then
			var_6_0.sprite = arg_7_0
		end

		return
	end)

	return
end

function OldChargeCard:updateGemItem(arg_8_1, arg_8_2)
	setActive(self.mask, false)
	setActive(self.maskState, false)
	setText(self.limitText, "")

	self.tipText.text = ""

	local var_8_0 = arg_8_1:getLimitCount()
	local var_8_1 = arg_8_1.buyCount or 0

	if var_8_0 > 0 then
		setText(self.limitText, i18n("charge_limit_all", var_8_0 - var_8_1, var_8_0))
		setActive(self.mask, var_8_0 <= var_8_1)
	end

	local var_8_2 = arg_8_1:getConfig("group_limit")

	if var_8_2 > 0 then
		local var_8_3 = arg_8_1:getConfig("group_type") or 0

		if var_8_3 == 1 then
			setText(self.limitText, i18n("charge_limit_daily", var_8_2 - arg_8_1.groupCount, var_8_2))
		elseif var_8_3 == 2 then
			setText(self.limitText, i18n("charge_limit_weekly", var_8_2 - arg_8_1.groupCount, var_8_2))
		elseif var_8_3 == 3 then
			setText(self.limitText, i18n("charge_limit_monthly", var_8_2 - arg_8_1.groupCount, var_8_2))
		end
	end

	self.price.text = arg_8_1:getConfig("resource_num")
	self.tipText.text = ""

	setActive(self.count, false)
	setActive(self.icon, true)
	setText(self.desc, "")

	local var_8_4 = arg_8_1:getConfig("tag")

	setActive(self.tag, var_8_4 > 0)

	if var_8_4 > 0 then
		for iter_8_0, iter_8_1 in ipairs(self.tags) do
			setActive(iter_8_1, iter_8_0 == var_8_4)
		end
	end

	setActive(self.timeLeftTag, false)

	local var_8_5, var_8_6 = arg_8_1:inTime()

	if var_8_5 and not arg_8_1:isFree() and var_8_6 and var_8_6 > 0 then
		local var_8_7, var_8_8, var_8_9 = pg.TimeMgr.GetInstance():parseTimeFrom(var_8_6)

		if var_8_7 > 0 then
			setActive(self.timeLeftTag, true)
			setActive(self.dayLeftTag, true)
			setActive(self.hourLeftTag, false)
			setActive(self.minLeftTag, false)
			setText(self.numLeftText, var_8_7)
		elseif var_8_8 > 0 then
			setActive(self.timeLeftTag, true)
			setActive(self.dayLeftTag, false)
			setActive(self.hourLeftTag, true)
			setActive(self.minLeftTag, false)
			setText(self.numLeftText, var_8_8)
		elseif var_8_9 > 0 then
			setActive(self.timeLeftTag, true)
			setActive(self.dayLeftTag, false)
			setActive(self.hourLeftTag, false)
			setActive(self.minLeftTag, true)
			setText(self.numLeftText, var_8_9)
		else
			setActive(self.timeLeftTag, true)
			setActive(self.dayLeftTag, false)
			setActive(self.hourLeftTag, false)
			setActive(self.minLeftTag, true)
			setText(self.numLeftText, 0)
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
			if self.countDownTimer then
				self.countDownTimer:Stop()

				self.countDownTimer = nil
			end

			self.countDownTimer = Timer.New(function()
				self:updateGemItem(arg_8_1, arg_8_2)

				return
			end, var_8_11, 1)

			self.countDownTimer:Start()
		end
	end

	setActive(self.name, true)

	local var_8_12 = arg_8_1:getConfig("effect_args")

	if #var_8_12 > 0 then
		local var_8_13 = Item.getConfigData(var_8_12[1])

		if var_8_13 then
			setScrollText(self.name, var_8_13.name)
			self:updateImport(var_8_13.display_icon, var_8_13.display)

			local var_8_14 = self:CheckSkinDiscounItem(var_8_13.display_icon)

			if var_8_14 then
				self:UpdateShipIcon(var_8_14)
			end
		end

		self.iconTF.sprite = GetSpriteFromAtlas("chargeicon/1", "")

		LoadSpriteAsync(var_8_13.icon, function(arg_10_0)
			if arg_10_0 and not IsNil(self.iconTF) then
				self.iconTF.sprite = arg_10_0

				self.iconTF:SetNativeSize()
			end

			return
		end)
	end

	setButtonEnabled(self.tr, not isActive(self.mask))

	return
end

function OldChargeCard:CheckSkinDiscounItem(arg_11_1)
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

function OldChargeCard:updateImport(arg_13_1, arg_13_2)
	setActive(self.important, true)

	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		table.insert(var_13_0, Drop.Create(iter_13_1))
	end

	for iter_13_2 = 1, self.grid.childCount do
		local var_13_1 = self.grid:GetChild(iter_13_2 - 1)

		if iter_13_2 <= #var_13_0 then
			setActive(var_13_1, var_0_1(var_13_0[iter_13_2]))
			updateDrop(var_13_1, var_13_0[iter_13_2])
		else
			setActive(var_13_1, false)
		end
	end

	setText(self.importantTip, string.gsub(arg_13_2, "$1", #var_13_0))

	return
end

function OldChargeCard:updateCountdown(arg_14_1)
	local var_14_0 = false

	if arg_14_1 then
		local var_14_1 = pg.TimeMgr.GetInstance()

		var_14_0 = var_14_1:DiffDay(var_14_1:GetServerTime(), pg.TimeMgr.GetInstance():Table2ServerTime(arg_14_1)) < 365
	end

	setActive(self.countDown, var_14_0)

	local var_14_2 = pg.TimeMgr.GetInstance()

	local function var_14_3()
		if self.updateTimer then
			self.updateTimer:Stop()

			self.updateTimer = nil
		end

		return
	end

	var_14_3()

	local var_14_4 = var_14_2:Table2ServerTime(arg_14_1)

	self.updateTimer = Timer.New(function()
		local var_16_0 = var_14_2:GetServerTime()

		if var_16_0 > var_14_4 then
			var_14_3()
		end

		local var_16_1 = var_14_4 - var_16_0

		var_16_1 = var_14_4 - var_16_0 < 0 and 0 or var_16_1

		local var_16_2 = math.floor(var_16_1 / 0)

		if var_16_2 > 0 then
			setText(self.countDownTm, i18n("skin_remain_time") .. var_16_2 .. i18n("word_date"))
		else
			local var_16_3 = math.floor(var_16_1 / 16)

			if var_16_3 > 0 then
				setText(self.countDownTm, i18n("skin_remain_time") .. var_16_3 .. i18n("word_hour"))
			else
				local var_16_4 = math.floor(var_16_1 / 60)

				if var_16_4 > 0 then
					setText(self.countDownTm, i18n("skin_remain_time") .. var_16_4 .. i18n("word_minute"))
				else
					setText(self.countDownTm, i18n("skin_remain_time") .. var_16_1 .. i18n("word_second"))
				end
			end
		end

		return
	end, 1, -1)

	self.updateTimer:Start()
	self.updateTimer.func()

	return
end

function OldChargeCard:destoryTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	if self.countDownTimer then
		self.countDownTimer:Stop()

		self.countDownTimer = nil
	end

	return
end

return OldChargeCard
