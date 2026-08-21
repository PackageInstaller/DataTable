local var_0_0 = class("ChargeDiamondCard")

var_0_0.NewTagType = 2
var_0_0.DoubleTagType = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = tf(arg_1_1)
	arg_1_0.iconImg = arg_1_0.tr:Find("IconImg")
	arg_1_0.diamondCountText = arg_1_0.tr:Find("Count/Text")
	arg_1_0.priceText = arg_1_0.tr:Find("Price/Text")
	arg_1_0.beginTimeText = arg_1_0.tr:Find("beginTime/text")
	arg_1_0.backTimeText = arg_1_0.tr:Find("backTime/text")
	arg_1_0.beginTimeDesc = arg_1_0.tr:Find("beginTime")
	arg_1_0.backTimeDesc = arg_1_0.tr:Find("backTime")
	arg_1_0.leftDesc = arg_1_0.tr:Find("lastAmount/text")
	arg_1_0.goods = nil
	arg_1_0.parentContext = arg_1_2

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.goods = arg_2_1

	local var_2_0

	var_2_0 = not table.contains(arg_2_3, arg_2_1.id) and arg_2_1:firstPayDouble() and arg_2_1:getConfig("gem") or arg_2_1:hasExtraGem() and arg_2_1:getConfig("extra_gem") or var_2_0

	setText(arg_2_0.diamondCountText, arg_2_1:getConfig("gem"))

	if PLATFORM_CODE == PLATFORM_US then
		local var_2_1 = arg_2_1:getConfig("money")

		setText(arg_2_0.priceText, math.floor(var_2_1 / 100) .. "." .. var_2_1 - math.floor(var_2_1 / 100) * 100)
	else
		setText(arg_2_0.priceText, arg_2_1:getConfig("money"))
	end

	LoadSpriteAsync("chargeicon/" .. arg_2_1:getConfig("picture"), function(arg_3_0)
		if arg_3_0 and not IsNil(arg_2_0.iconImg) then
			setImageSprite(arg_2_0.iconImg, arg_3_0, true)
		end

		return
	end)

	if arg_2_0.goods.buyTime then
		setText(arg_2_0.beginTimeText, (pg.TimeMgr.GetInstance():STimeDescS(arg_2_0.goods.buyTime, "%Y-%m-%d %H:%M")))
	end

	if arg_2_0.goods.refundTime then
		setText(arg_2_0.backTimeText, (pg.TimeMgr.GetInstance():STimeDescS(arg_2_0.goods.refundTime, "%Y-%m-%d %H:%M")))
	end

	setText(arg_2_0.beginTimeDesc, i18n("Supplement_pay6"))
	setText(arg_2_0.backTimeDesc, i18n("Supplement_pay7"))
	setText(arg_2_0.leftDesc, i18n("Supplement_pay8", "1/1"))

	return
end

function var_0_0.destoryTimer(arg_4_0)
	if arg_4_0.updateTimer then
		arg_4_0.updateTimer:Stop()

		arg_4_0.updateTimer = nil
	end

	return
end

return var_0_0
