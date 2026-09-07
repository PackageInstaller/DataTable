local ChargeDiamondCard = class("ChargeDiamondCard")

ChargeDiamondCard.NewTagType = 2
ChargeDiamondCard.DoubleTagType = 4

function ChargeDiamondCard:Ctor(arg_1_1, arg_1_2)
	self.go = arg_1_1
	self.tr = tf(arg_1_1)
	self.iconImg = self.tr:Find("IconImg")
	self.diamondCountText = self.tr:Find("Count/Text")
	self.priceText = self.tr:Find("Price/Text")
	self.beginTimeText = self.tr:Find("beginTime/text")
	self.backTimeText = self.tr:Find("backTime/text")
	self.beginTimeDesc = self.tr:Find("beginTime")
	self.backTimeDesc = self.tr:Find("backTime")
	self.leftDesc = self.tr:Find("lastAmount/text")
	self.goods = nil
	self.parentContext = arg_1_2

	return
end

function ChargeDiamondCard:update(arg_2_1, arg_2_2, arg_2_3)
	self.goods = arg_2_1

	local var_2_0

	var_2_0 = not table.contains(arg_2_3, arg_2_1.id) and arg_2_1:firstPayDouble() and arg_2_1:getConfig("gem") or arg_2_1:hasExtraGem() and arg_2_1:getConfig("extra_gem") or var_2_0

	setText(self.diamondCountText, arg_2_1:getConfig("gem"))

	if PLATFORM_CODE == PLATFORM_US then
		local var_2_1 = arg_2_1:getConfig("money")

		setText(self.priceText, math.floor(var_2_1 / 100) .. "." .. var_2_1 - math.floor(var_2_1 / 100) * 100)
	else
		setText(self.priceText, arg_2_1:getConfig("money"))
	end

	LoadSpriteAsync("chargeicon/" .. arg_2_1:getConfig("picture"), function(arg_3_0)
		if arg_3_0 and not IsNil(self.iconImg) then
			setImageSprite(self.iconImg, arg_3_0, true)
		end

		return
	end)

	if self.goods.buyTime then
		setText(self.beginTimeText, (pg.TimeMgr.GetInstance():STimeDescS(self.goods.buyTime, "%Y-%m-%d %H:%M")))
	end

	if self.goods.refundTime then
		setText(self.backTimeText, (pg.TimeMgr.GetInstance():STimeDescS(self.goods.refundTime, "%Y-%m-%d %H:%M")))
	end

	setText(self.beginTimeDesc, i18n("Supplement_pay6"))
	setText(self.backTimeDesc, i18n("Supplement_pay7"))
	setText(self.leftDesc, i18n("Supplement_pay8", "1/1"))

	return
end

function ChargeDiamondCard:destoryTimer()
	if self.updateTimer then
		self.updateTimer:Stop()

		self.updateTimer = nil
	end

	return
end

return ChargeDiamondCard
