class = var_0_10000

local var_0_0 = "MainTagsView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.MainBaseView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	findTF = var_3
	arg_1_0.monthCardTag = var_3(arg_1_0._tf, "monthcard")
	findTF = var_3
	arg_1_0.sellTag = var_3(arg_1_0._tf, "sell")
	findTF = var_3
	arg_1_0.skinTag = var_3(arg_1_0._tf, "skin")
	findTF = var_3
	arg_1_0.buildTag = var_3(arg_1_0._tf, "build")
	findTF = var_3
	arg_1_0.tecShipGiftTag = var_3(arg_1_0._tf, "tecshipgift")
	findTF = var_3
	arg_1_0.mallTip = var_3(arg_1_0._tf, "tip")

	return
end

function var_0_1.Init(arg_2_0)
	local var_2_0 = {}

	table = var_1_10002

	var_1_10002.insert(var_2_0, function(arg_3_0)
		TagTipHelper = var_2_10001

		var_2_10001.TecShipGiftTip(arg_2_0.tecShipGiftTag)

		onNextTick = var_1

		var_1(arg_3_0)

		return
	end)

	table = var_2

	var_2.insert(var_2_0, function(arg_4_0)
		TagTipHelper = var_2_10001

		var_2_10001.MonthCardTagTip(arg_2_0.monthCardTag)

		onNextTick = var_1

		var_1(arg_4_0)

		return
	end)

	table = var_2

	var_2.insert(var_2_0, function(arg_5_0)
		TagTipHelper = var_2_10001

		var_2_10001.SkinTagTip(arg_2_0.skinTag)

		onNextTick = var_1

		var_1(arg_5_0)

		return
	end)

	table = var_2

	var_2.insert(var_2_0, function(arg_6_0)
		TagTipHelper = var_2_10001

		var_2_10001.FuDaiTagTip(arg_2_0.sellTag)

		onNextTick = var_1

		var_1(arg_6_0)

		return
	end)

	table = var_2

	var_2.insert(var_2_0, function(arg_7_0)
		TagTipHelper = var_2_10001

		var_2_10001.GiftPackagesTag({
			arg_2_0.mallTip
		})

		onNextTick = var_1

		var_1(arg_7_0)

		return
	end)

	table = var_2

	var_2.insert(var_2_0, function(arg_8_0)
		TagTipHelper = var_2_10001

		var_2_10001.FreeBuildTicketTip(arg_2_0.buildTag)

		onNextTick = var_1

		var_1(arg_8_0)

		return
	end)

	seriesAsync = var_2

	var_2(var_2_0)

	return
end

function var_0_1.Refresh(arg_9_0)
	arg_9_0:Init()

	return
end

return var_0_1
