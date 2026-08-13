class = var_0_10000

local var_0_0 = "CardPairFXPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.startBtn = var_1.Find(var_1_1, "StartBtn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.slider = var_1.Find(var_1_2, "Slider")

	local var_1_3 = arg_1_0.slider

	arg_1_0.heartImg = var_1.Find(var_1_3, "Fill/Heart")

	local var_1_4 = arg_1_0.bg

	arg_1_0.gotImg = var_1.Find(var_1_4, "GotImg")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.startBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.CARD_PAIRS)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	local var_5_0 = arg_5_0.activity.data1

	setActive = var_1_10002

	var_1_10002(arg_5_0.gotImg, var_5_0 == 1)

	setActive = var_1_10002

	var_1_10002(arg_5_0.heartImg, var_5_0 ~= 1)

	local var_5_1 = arg_5_0.activity.data2

	if 7 <= var_5_1 then
		setActive = var_3

		var_3(arg_5_0.heartImg, false)
	end

	setSlider = var_3

	var_3(arg_5_0.slider, 0, 7, var_5_1)

	return
end

return var_0_1
