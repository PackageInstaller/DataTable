class = var_0_10000

local var_0_0 = var_0_10000("PipePassTest")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	PipeGameVo = var_1_10004
	var_0_1 = var_1_10004
	arg_1_0._tf = arg_1_1
	arg_1_0._leftId = 1
	arg_1_0._rightId = 1
	arg_1_0._leftIndex = 1
	arg_1_0._rightIndex = 2
	arg_1_0._leftDirect = {
		0,
		0
	}
	arg_1_0._rightDirect = {
		0,
		0
	}
	GetOrAddComponent = var_4
	findTF = var_1_10005

	local var_1_0 = var_1_10005(arg_1_0._tf, "left/ok")

	typeof = var_6
	EventTriggerListener = var_7
	arg_1_0._leftTrigger = var_4(var_1_0, var_6(var_7))

	local var_1_1 = arg_1_0._leftTrigger

	var_4.AddPointClickFunc(var_1_1, function()
		local var_2_0 = arg_1_0

		tonumber = var_2_10001
		GetComponent = var_2_10002
		findTF = var_2_10003

		local var_2_1 = var_2_10003(arg_1_0._tf, "left/inputId")

		typeof = var_4
		Text = var_5
		var_2_0._leftId = var_2_10001(var_2_10002(var_2_1, var_4(var_5)).text)

		local var_2_2 = arg_1_0

		tonumber = var_1
		GetComponent = var_2
		findTF = var_2_1

		local var_2_3 = var_2_1(arg_1_0._tf, "left/inputIndex")

		typeof = var_4
		Text = var_5
		var_2_2._leftIndex = var_1(var_2(var_2_3, var_4(var_5)).text)
		PipeGameConst = var_2_2

		local var_2_4 = var_2_2.map_item_data[arg_1_0._leftId]
		local var_2_5 = arg_1_0

		var_2_5._leftDirect = var_2_4.direct
		setImageSprite = var_2_5
		findTF = var_2

		var_2_5(var_2(arg_1_0._tf, "left/icon"), var_0_1.GetSprite(var_2_4.img), false)

		return
	end)

	GetOrAddComponent = var_4
	findTF = var_1_1

	local var_1_2 = var_1_1(arg_1_0._tf, "right/ok")

	typeof = var_6
	EventTriggerListener = var_7
	arg_1_0._rightTrigger = var_4(var_1_2, var_6(var_7))

	local var_1_3 = arg_1_0._rightTrigger

	var_4.AddPointClickFunc(var_1_3, function()
		local var_3_0 = arg_1_0

		tonumber = var_2_10001
		GetComponent = var_2_10002
		findTF = var_2_10003

		local var_3_1 = var_2_10003(arg_1_0._tf, "right/inputId")

		typeof = var_4
		Text = var_5
		var_3_0._rightId = var_2_10001(var_2_10002(var_3_1, var_4(var_5)).text)

		local var_3_2 = arg_1_0

		tonumber = var_1
		GetComponent = var_2
		findTF = var_3_1

		local var_3_3 = var_3_1(arg_1_0._tf, "right/inputIndex")

		typeof = var_4
		Text = var_5
		var_3_2._rightIndex = var_1(var_2(var_3_3, var_4(var_5)).text)
		PipeGameConst = var_3_2

		local var_3_4 = var_3_2.map_item_data[arg_1_0._rightId]
		local var_3_5 = arg_1_0

		var_3_5._rightDirect = var_3_4.direct
		setImageSprite = var_3_5
		findTF = var_2

		local var_3_6 = var_2(arg_1_0._tf, "right/icon")
		local var_3_7 = var_0_1.GetSprite

		PipeGameConst = var_4

		var_3_5(var_3_6, var_3_7(var_4.map_item_data[arg_1_0._rightId].img), false)

		return
	end)

	GetOrAddComponent = var_4
	findTF = var_1_3

	local var_1_4 = var_1_3(arg_1_0._tf, "btnPass")

	typeof = var_6
	EventTriggerListener = var_7
	arg_1_0._passTrigger = var_4(var_1_4, var_6(var_7))

	local var_1_5 = arg_1_0._passTrigger

	var_4.AddPointClickFunc(var_1_5, function()
		callback = var_2_10000

		if var_2_10000 then
			callback = var_2_10000

			var_2_10000(arg_1_0._leftIndex, arg_1_0._rightIndex, arg_1_0._leftDirect, arg_1_0._rightDirect)
		end

		return
	end)

	return
end

function var_0_0.setPassDesc(arg_5_0, arg_5_1)
	if arg_5_1 then
		setText = var_1_10002
		findTF = var_1_10003

		var_1_10002(var_1_10003(arg_5_0._tf, "passDesc"), "检测通过")
	else
		setText = var_1_10002
		findTF = var_1_10003

		var_1_10002(var_1_10003(arg_5_0._tf, "passDesc"), "检测失败")
	end

	return
end

function var_0_0.setVisible(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0._tf, arg_6_1)

	return
end

function var_0_0.dispose(arg_7_0)
	ClearEventTrigger = var_1_10001

	var_1_10001(arg_7_0._leftTrigger)

	ClearEventTrigger = var_1_10001

	var_1_10001(arg_7_0._rightTrigger)

	return
end

return var_0_0
