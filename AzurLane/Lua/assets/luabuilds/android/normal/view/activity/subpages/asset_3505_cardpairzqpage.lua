class = var_0_10000

local var_0_0 = "CardPairZQPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.slider = var_1.Find(var_1_1, "slider")

	local var_1_2 = arg_1_0.bg

	arg_1_0.step = var_1.Find(var_1_2, "step")

	local var_1_3 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_3, "progress")

	local var_1_4 = arg_1_0.bg

	arg_1_0.displayBtn = var_1.Find(var_1_4, "display_btn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_5, "battle_btn")

	local var_1_6 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_6, "get_btn")

	local var_1_7 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_7, "got_btn")

	local var_1_8 = arg_1_0.bg

	arg_1_0.gotIcon = var_1.Find(var_1_8, "icon_got")

	local var_1_9 = arg_1_0.bg

	arg_1_0.maskList = var_1.Find(var_1_9, "maskList")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_data")[1]

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.battleBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_4_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.CARD_PAIRS)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	local var_5_0 = arg_5_0.activity.data2

	for iter_5_0 = 1, 7 do
		local var_5_1 = arg_5_0.maskList
		local var_5_2 = var_6.Find(var_5_1, "mask" .. iter_5_0)

		setActive = var_5_1

		var_5_1(var_5_2, iter_5_0 <= var_5_0)

		setActive = var_5_1

		var_5_1(var_5_2:Find("frame"), var_5_0 <= iter_5_0)
	end

	setActive = var_2

	var_2(arg_5_0.gotIcon, var_5_0 >= 7)

	setSlider = var_2

	local var_5_3 = arg_5_0.slider
	local var_5_4 = 0
	local var_5_5 = 6
	local var_5_6

	if not (var_5_0 - 1 >= 0) or not (var_5_0 - 1) then
		var_5_6 = 0
	end

	var_2(var_5_3, var_5_4, var_5_5, var_5_6)

	setActive = var_2

	var_2(arg_5_0.battleBtn, true)

	setActive = var_2

	var_2(arg_5_0.getBtn, false)

	setActive = var_2

	var_2(arg_5_0.gotBtn, false)

	return
end

return var_0_1
