local var_0_0 = class("MonthCardSetLayer", import("..base.BaseUI"))

var_0_0.PIECES = 100

function var_0_0.getUIName(arg_1_0)
	return "MonthCardSetUI"
end

function var_0_0.setPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_0.setRatio(arg_3_0, arg_3_1)
	arg_3_0.ratio = math.clamp(arg_3_1, 0, var_0_0.PIECES)

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.name = arg_4_0._tf:Find("window/bg/name")
	arg_4_0.desc = arg_4_0._tf:Find("window/bg/desc")
	arg_4_0.oil = arg_4_0._tf:Find("window/black/oil/icon_bg/count")
	arg_4_0.gold = arg_4_0._tf:Find("window/black/gold/icon_bg/count")
	arg_4_0.slider = arg_4_0._tf:Find("window/black/slider")
	arg_4_0.rate = arg_4_0._tf:Find("window/black/misc/rate")
	arg_4_0.confirm = arg_4_0._tf:Find("window/confirm")
	arg_4_0.cancel = arg_4_0._tf:Find("window/cancel")

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf, function()
		arg_5_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0.cancel, function()
		arg_5_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0.confirm, function()
		arg_5_0:emit(MonthCardSetMediator.ON_SET_RATIO, arg_5_0.ratio)

		return
	end, SFX_CANCEL)
	onSlider(arg_5_0, arg_5_0.slider, function(arg_9_0)
		arg_5_0:setRatio(arg_9_0)
		arg_5_0:updateRatioView()

		return
	end)
	arg_5_0:updateView()
	arg_5_0:updateRatioView()
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	return
end

function var_0_0.updateView(arg_10_0)
	setText(arg_10_0.name, string.format("贸易许可证（剩余%s天）", (math.floor((arg_10_0.player:getCardById(VipCard.MONTH):getLeftDate() - pg.TimeMgr.GetInstance():GetServerTime()) / 0))))
	setText(arg_10_0.rate, "1 : 5")

	return
end

function var_0_0.updateRatioView(arg_11_0)
	setSlider(arg_11_0.slider, 0, var_0_0.PIECES, arg_11_0.ratio)
	setText(arg_11_0.oil, 16 * arg_11_0.ratio / var_0_0.PIECES)
	setText(arg_11_0.gold, 2000 * (var_0_0.PIECES - arg_11_0.ratio) / var_0_0.PIECES)

	return
end

function var_0_0.willExit(arg_12_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_12_0._tf)

	return
end

return var_0_0
