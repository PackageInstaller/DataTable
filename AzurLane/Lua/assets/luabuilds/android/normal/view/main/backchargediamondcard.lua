class = var_0_10000

local var_0_0 = var_0_10000("ChargeDiamondCard")

var_0_0.NewTagType = 2
var_0_0.DoubleTagType = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	tf = var_1_10003
	arg_1_0.tr = var_1_10003(arg_1_1)

	local var_1_0 = arg_1_0.tr

	arg_1_0.iconImg = var_3.Find(var_1_0, "IconImg")

	local var_1_1 = arg_1_0.tr

	arg_1_0.diamondCountText = var_3.Find(var_1_1, "Count/Text")

	local var_1_2 = arg_1_0.tr

	arg_1_0.priceText = var_3.Find(var_1_2, "Price/Text")

	local var_1_3 = arg_1_0.tr

	arg_1_0.beginTimeText = var_3.Find(var_1_3, "beginTime/text")

	local var_1_4 = arg_1_0.tr

	arg_1_0.backTimeText = var_3.Find(var_1_4, "backTime/text")

	local var_1_5 = arg_1_0.tr

	arg_1_0.beginTimeDesc = var_3.Find(var_1_5, "beginTime")

	local var_1_6 = arg_1_0.tr

	arg_1_0.backTimeDesc = var_3.Find(var_1_6, "backTime")

	local var_1_7 = arg_1_0.tr

	arg_1_0.leftDesc = var_3.Find(var_1_7, "lastAmount/text")
	arg_1_0.goods = nil
	arg_1_0.parentContext = arg_1_2

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.goods = arg_2_1
	table = var_1_10004

	local var_2_0, var_2_1

	if not var_1_10004.contains(arg_2_3, arg_2_1.id) then
		::label_2_0::

		var_2_0 = arg_2_1
		var_2_1 = arg_2_1.firstPayDouble(var_2_0)
	end

	if var_2_1 then
		var_2_0 = arg_2_1:getConfig("gem")
	elseif arg_2_1:hasExtraGem() then
		var_2_0 = arg_2_1:getConfig("extra_gem")
	end

	setText = var_2_0

	local var_2_2 = arg_2_0.diamondCountText
	local var_2_3 = arg_2_1

	var_2_0(var_2_2, arg_2_1.getConfig(var_2_3, "gem"))

	PLATFORM_CODE = var_2_0
	PLATFORM_US = var_2_2

	if var_2_0 == var_2_2 then
		local var_2_4 = arg_2_1

		var_2_0 = arg_2_1.getConfig(var_2_4, "money")
		setText = var_2_4

		local var_2_5 = arg_2_0.priceText

		math = var_2_3

		local var_2_6 = var_2_3.floor(var_2_0 / 100)
		local var_2_7 = "."

		math = var_1_10011

		var_2_4(var_2_5, var_2_6 .. var_2_7 .. var_2_0 - var_1_10011.floor(var_2_0 / 100) * 100)
	else
		setText = var_2_0

		var_2_0(arg_2_0.priceText, arg_2_1:getConfig("money"))
	end

	LoadSpriteAsync = var_2_0

	var_2_0("chargeicon/" .. arg_2_1:getConfig("picture"), function(arg_3_0)
		if arg_3_0 then
			IsNil = var_2_10001

			if not var_2_10001(arg_2_0.iconImg) then
				setImageSprite = var_1

				var_1(arg_2_0.iconImg, arg_3_0, true)
			end
		end

		return
	end)

	if arg_2_0.goods.buyTime then
		pg = var_6

		local var_2_8 = var_6.TimeMgr.GetInstance()
		local var_2_9 = var_6.STimeDescS(var_2_8, arg_2_0.goods.buyTime, "%Y-%m-%d %H:%M")

		setText = var_2_8

		var_2_8(arg_2_0.beginTimeText, var_2_9)
	end

	local var_2_11

	if arg_2_0.goods.refundTime then
		pg = var_2_11

		local var_2_10 = var_2_11.TimeMgr.GetInstance()

		var_2_11 = var_2_11.STimeDescS(var_2_10, arg_2_0.goods.refundTime, "%Y-%m-%d %H:%M")
		setText = var_2_10

		var_2_10(arg_2_0.backTimeText, var_2_11)
	end

	setText = var_2_11

	local var_2_12 = arg_2_0.beginTimeDesc

	i18n = var_8

	var_2_11(var_2_12, var_8("Supplement_pay6"))

	setText = var_2_11

	local var_2_13 = arg_2_0.backTimeDesc

	i18n = var_8

	var_2_11(var_2_13, var_8("Supplement_pay7"))

	setText = var_2_11

	local var_2_14 = arg_2_0.leftDesc

	i18n = var_8

	var_2_11(var_2_14, var_8("Supplement_pay8", "1/1"))

	return
end

function var_0_0.destoryTimer(arg_4_0)
	if arg_4_0.updateTimer then
		local var_4_0 = arg_4_0.updateTimer

		var_1.Stop(var_4_0)

		arg_4_0.updateTimer = nil
	end

	return
end

return var_0_0
