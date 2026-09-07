local ChargeDiamondCard = class("ChargeDiamondCard")

ChargeDiamondCard.NewTagType = 2
ChargeDiamondCard.DoubleTagType = 4

function ChargeDiamondCard:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.go = arg_1_1
	self.tr = tf(arg_1_1)
	self.firstTag = self.tr:Find("FirstTag")
	self.iconImg = self.tr:Find("IconImg")
	self.diamondCountText = self.tr:Find("Count/Text")
	self.tipTF = self.tr:Find("Tip")
	self.firstTipTag = self.tr:Find("Tip/Text/FirstTag")
	self.exTipTag = self.tr:Find("Tip/Text")
	self.firstEXTip = self.tr:Find("Tip/Text")
	self.priceText = self.tr:Find("Price/Text")
	self.priceIcon = self.tr:Find("Price/Icon")
	self.monthTF = arg_1_2
	self.goods = nil
	self.parentContext = arg_1_3

	return
end

function ChargeDiamondCard:update(arg_2_1, arg_2_2, arg_2_3)
	self.goods = arg_2_1

	if arg_2_1:isMonthCard() then
		setActive(self.tr, false)
		self:updateForMonthTF(arg_2_1, arg_2_2)

		return
	end

	local var_2_0 = not table.contains(arg_2_3, arg_2_1.id) and arg_2_1:firstPayDouble()

	setActive(self.firstTag, ((var_2_0 or nil) and (ChargeDiamondCard.DoubleTagType or arg_2_1:getConfig("tag"))) == ChargeDiamondCard.DoubleTagType)

	if var_2_0 then
		setScrollText(self.firstEXTip, i18n("charge_double_gem_tip", (arg_2_1:getConfig("gem"))))
		setActive(self.exTipTag, false)
		setActive(self.firstEXTip, true)
		setActive(self.tipTF, true)
	elseif arg_2_1:hasExtraGem() then
		setScrollText(self.firstEXTip, i18n("charge_extra_gem_tip", (arg_2_1:getConfig("extra_gem"))))
		setActive(self.exTipTag, true)
		setActive(self.firstEXTip, true)
		setActive(self.tipTF, true)
	else
		setActive(self.tipTF, false)
	end

	setText(self.diamondCountText, arg_2_1:getConfig("gem"))
	setText(self.priceText, arg_2_1:getConfig("money"))

	if PLATFORM_CODE == PLATFORM_CHT then
		setActive(self.priceIcon, not arg_2_1:IsLocalPrice())
	end

	LoadSpriteAsync("chargeicon/" .. arg_2_1:getConfig("picture"), function(arg_3_0)
		if arg_3_0 and not IsNil(self.iconImg) then
			setImageSprite(self.iconImg, arg_3_0, true)
		end

		return
	end)

	return
end

function ChargeDiamondCard:updateForMonthTF(arg_4_1, arg_4_2)
	local var_4_0 = self.monthTF:Find("IconImg")
	local var_4_1 = self.monthTF:Find("Mask")
	local var_4_2 = self.monthTF:Find("leftTimeText")

	setScrollText(self.monthTF:Find("Tip/Text"), arg_4_1:getConfig("first_text"))
	setScrollText(self.monthTF:Find("Tip2/Text"), arg_4_1:getConfig("second_text"))
	setScrollText(self.monthTF:Find("title/Text"), arg_4_1:getConfig("name_display"))
	setText(self.monthTF:Find("ResCountText"), arg_4_1:getConfig("gem") + arg_4_1:getConfig("extra_gem"))
	setText(self.monthTF:Find("Price/Text"), arg_4_1:getConfig("money"))

	if PLATFORM_CODE == PLATFORM_CHT then
		setActive(self.monthTF:Find("Price/Icon"), not arg_4_1:IsLocalPrice())
	end

	local var_4_3 = arg_4_1:GetDropList()

	if #var_4_3 > 0 then
		local var_4_4 = UIItemList.New(self.monthTF:Find("ItemIconList"), (self.monthTF:Find("ItemIconTpl")))

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
		local var_4_7 = math.floor((var_4_5:getLeftDate() - var_4_6:GetServerTime()) / 0)
		local var_4_8 = arg_4_1:getConfig("limit_arg")

		if not var_4_6 then
			var_4_8 = 0
		end

		setScrollText(var_4_2, i18n("charge_month_card_lefttime_tip", var_4_7))
		setScrollText(self.monthTF:Find("Mask/leftTimeGo/Text"), i18n("charge_month_card_lefttime_tip", var_4_7))
		setActive(var_4_2, true)
		setActive(var_4_1, var_4_8 < var_4_7)
		setActive(self.monthTF:Find("NewTag"), false)
		setButtonEnabled(self.monthTF, var_4_7 <= var_4_8)
	else
		setActive(var_4_2, false)
		setActive(var_4_1, false)
		setActive(self.monthTF:Find("NewTag"), true)
		setButtonEnabled(self.monthTF, true)
	end

	onButton(self.parentContext, self.monthTF, function()
		triggerButton(self.tr)

		return
	end, SFX_PANEL)

	return
end

function ChargeDiamondCard:destoryTimer()
	return
end

return ChargeDiamondCard
