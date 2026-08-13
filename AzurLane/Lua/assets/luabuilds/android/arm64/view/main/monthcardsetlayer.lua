class = var_0_10000

local var_0_0 = "MonthCardSetLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.PIECES = 100

function var_0_1.getUIName(arg_1_0)
	return "MonthCardSetUI"
end

function var_0_1.setPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_1.setRatio(arg_3_0, arg_3_1)
	math = var_1_10002
	arg_3_0.ratio = var_1_10002.clamp(arg_3_1, 0, var_0_1.PIECES)

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.name = var_1.Find(var_4_0, "window/bg/name")

	local var_4_1 = arg_4_0._tf

	arg_4_0.desc = var_1.Find(var_4_1, "window/bg/desc")

	local var_4_2 = arg_4_0._tf

	arg_4_0.oil = var_1.Find(var_4_2, "window/black/oil/icon_bg/count")

	local var_4_3 = arg_4_0._tf

	arg_4_0.gold = var_1.Find(var_4_3, "window/black/gold/icon_bg/count")

	local var_4_4 = arg_4_0._tf

	arg_4_0.slider = var_1.Find(var_4_4, "window/black/slider")

	local var_4_5 = arg_4_0._tf

	arg_4_0.rate = var_1.Find(var_4_5, "window/black/misc/rate")

	local var_4_6 = arg_4_0._tf

	arg_4_0.confirm = var_1.Find(var_4_6, "window/confirm")

	local var_4_7 = arg_4_0._tf

	arg_4_0.cancel = var_1.Find(var_4_7, "window/cancel")

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.cancel

	local function var_5_5()
		local var_7_0 = arg_5_0

		var_0.emit(var_7_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.confirm

	local function var_5_8()
		local var_8_0 = arg_5_0
		local var_8_1 = var_0.emit

		MonthCardSetMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.ON_SET_RATIO, arg_5_0.ratio)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10006)

	onSlider = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.slider, function(arg_9_0)
		local var_9_0 = arg_5_0

		var_1.setRatio(var_9_0, arg_9_0)

		local var_9_1 = arg_5_0

		var_1.updateRatioView(var_9_1)

		return
	end)
	arg_5_0:updateView()
	arg_5_0:updateRatioView()

	pg = var_1

	local var_5_9 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_5_9, arg_5_0._tf)

	return
end

function var_0_1.updateView(arg_10_0)
	local var_10_0 = arg_10_0.player
	local var_10_1 = var_1.getCardById

	VipCard = var_1_10004

	local var_10_2 = var_10_1(var_10_0, var_1_10004.MONTH)

	math = var_1_10002

	local var_10_3 = var_1_10002.floor
	local var_10_4 = var_10_2
	local var_10_5 = var_10_2.getLeftDate(var_10_4)

	pg = var_1_10005

	local var_10_6 = var_1_10005.TimeMgr.GetInstance()
	local var_10_7 = var_10_3((var_10_5 - var_5.GetServerTime(var_10_6)) / 0)

	setText = var_10_0

	local var_10_8 = arg_10_0.name

	string = var_10_4

	var_10_0(var_10_8, var_10_4.format("贸易许可证（剩余%s天）", var_10_7))

	setText = var_10_0

	var_10_0(arg_10_0.rate, "1 : 5")

	return
end

function var_0_1.updateRatioView(arg_11_0)
	setSlider = var_1_10001

	var_1_10001(arg_11_0.slider, 0, var_0_1.PIECES, arg_11_0.ratio)

	setText = var_1_10001

	var_1_10001(arg_11_0.oil, 16 * arg_11_0.ratio / var_0_1.PIECES)

	setText = var_1_10001

	var_1_10001(arg_11_0.gold, 2000 * (var_0_1.PIECES - arg_11_0.ratio) / var_0_1.PIECES)

	return
end

function var_0_1.willExit(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_12_0, arg_12_0._tf)

	return
end

return var_0_1
