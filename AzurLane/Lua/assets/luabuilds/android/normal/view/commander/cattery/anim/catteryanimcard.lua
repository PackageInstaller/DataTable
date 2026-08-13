class = var_0_10000

local var_0_0 = "CatteryAnimCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..CatterySettlementCard"))
local var_0_2 = 1

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	findTF = var_1_10002
	arg_1_0.emptyTF = var_1_10002(arg_1_0._tf, "empty")
	findTF = var_2
	arg_1_0.commanderTF = var_2(arg_1_0._tf, "commander")

	local var_1_0 = arg_1_0.commanderTF

	arg_1_0.char = var_2.Find(var_1_0, "mask/char")

	local var_1_1 = arg_1_0.commanderTF
	local var_1_2 = var_2.Find(var_1_1, "slider")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Slider = var_1_10005
	arg_1_0.slider = var_1_3(var_1_2, var_4(var_1_10005))

	local var_1_4 = arg_1_0.commanderTF
	local var_1_5 = var_2.Find(var_1_4, "name/Text")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_6(var_1_5, var_4(var_1_10005))

	local var_1_7 = arg_1_0.commanderTF
	local var_1_8 = var_2.Find(var_1_7, "name/level")
	local var_1_9 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTxt = var_1_9(var_1_8, var_4(var_1_10005))

	local var_1_10 = arg_1_0.commanderTF
	local var_1_11 = var_2.Find(var_1_10, "exp")
	local var_1_12 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.expTxt = var_1_12(var_1_11, var_4(var_1_10005))

	local var_1_13 = arg_1_0.commanderTF

	arg_1_0.addition = var_2.Find(var_1_13, "addition")

	local var_1_14 = arg_1_0.addition
	local var_1_15 = var_2.Find(var_1_14, "Text")
	local var_1_16 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.additionTxt = var_1_16(var_1_15, var_4(var_1_10005))
	arg_1_0.additionY = arg_1_0.addition.localPosition.y

	return
end

function var_0_1.UpdateCommander(arg_2_0)
	var_0_1.super.UpdateCommander(arg_2_0)

	arg_2_0.additionTxt.text = arg_2_0.exp .. "<size=40>EXP</size>"

	return
end

function var_0_1.Action(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.addition, false)

	if not arg_3_0.commander or arg_3_0.exp <= 0 then
		arg_3_1()

		return
	end

	local var_3_0 = {}

	arg_3_0:InitAnim(var_3_0)

	table = var_3

	var_3.insert(var_3_0, function(arg_4_0)
		local var_4_0 = arg_3_0

		var_1.AdditionAnim(var_4_0, var_0_2, arg_4_0)

		return
	end)

	parallelAsync = var_3

	var_3(var_3_0, arg_3_1)

	return
end

function var_0_1.Clear(arg_5_0)
	var_0_1.super.Clear(arg_5_0)

	LeanTween = var_1

	local var_5_0 = var_1.isTweening

	go = var_2

	if var_5_0(var_2(arg_5_0.addition)) then
		LeanTween = var_1

		local var_5_1 = var_1.cancel

		go = var_2

		var_5_1(var_2(arg_5_0.addition))
	end

	return
end

function var_0_1.LoadCommander(arg_6_0, arg_6_1)
	arg_6_0:ReturnCommander()

	arg_6_0.painting = arg_6_1:getPainting()
	setCommanderPaintingPrefab = var_2

	var_2(arg_6_0.char, arg_6_0.painting, "result1")

	return
end

function var_0_1.AdditionAnim(arg_7_0, arg_7_1, arg_7_2)
	setActive = var_1_10003

	var_1_10003(arg_7_0.addition, true)

	local var_7_0 = arg_7_0.additionY

	LeanTween = var_4

	local var_7_1 = var_4.value

	go = var_5

	local var_7_2 = var_7_1(var_5(arg_7_0.addition), var_7_0, var_7_0 + 25, arg_7_1)
	local var_7_3 = var_4.setOnUpdate

	System = var_6

	local var_7_4 = var_7_3(var_7_2, var_6.Action_float(function(arg_8_0)
		local var_8_0 = arg_7_0.addition

		Vector3 = var_2_10002
		var_8_0.localPosition = var_2_10002(arg_7_0.addition.localPosition.x, arg_8_0, 0)

		return
	end))
	local var_7_5 = var_4.setOnComplete

	System = var_6

	var_7_5(var_7_4, var_6.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_7_0.addition, false)
		arg_7_2()

		local var_9_0 = arg_7_0.addition

		Vector3 = var_1
		var_9_0.localPosition = var_1(arg_7_0.addition.localPosition.x, var_7_0, 0)

		return
	end))

	return
end

function var_0_1.GetColor(arg_10_0)
	return "#ffffff"
end

return var_0_1
