class = var_0_10000

local var_0_0 = var_0_10000("ShipDialog")
local var_0_1 = 0.3
local var_0_2 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.dialog = arg_1_1

	local var_1_0 = arg_1_0.dialog.gameObject
	local var_1_1 = var_3.GetComponentInChildren

	typeof = var_1_10005
	Text = var_1_10006
	arg_1_0.label = var_1_1(var_1_0, var_1_10005(var_1_10006))
	arg_1_0.content = arg_1_2
	arg_1_0.started = false

	return
end

function var_0_0.loop(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	Timer = var_1_10004

	local var_2_0 = var_1_10004.New

	local function var_2_1()
		local var_3_0 = arg_2_0

		var_0.display(var_3_0)

		return
	end

	math = var_1_10006
	arg_2_0.timer = var_2_0(var_2_1, arg_2_2 + arg_2_3 * var_1_10006.random(), arg_2_1)

	return
end

function var_0_0.display(arg_4_0)
	if arg_4_0.chatOn then
		return
	end

	arg_4_0.chatOn = true
	rtf = var_1

	local var_4_0 = var_1(arg_4_0.dialog)

	Vector3 = var_2
	var_4_0.localScale = var_2.New(0, 0, 1)
	arg_4_0.label.text = arg_4_0.content

	local var_4_1 = arg_4_0.label
	local var_4_2 = #arg_4_0.content

	CHAT_POP_STR_LEN = var_3

	if var_3 < var_4_2 then
		TextAnchor = var_4_2

		if not var_4_2.MiddleLeft then
			TextAnchor = var_4_2
			var_4_2 = var_4_2.MiddleCenter
		end

		var_4_1.alignment = var_4_2
		LeanTween = var_4_1

		local var_4_3 = var_4_1.scale

		rtf = var_4_2

		local var_4_4 = var_4_2(arg_4_0.dialog)

		Vector3 = var_3

		local var_4_5 = var_4_3(var_4_4, var_3.New(1, 1, 1), var_0_1)
		local var_4_6 = var_1.setEase

		LeanTweenType = var_3

		var_4_6(var_4_5, var_3.easeOutBack)

		LeanTween = var_4_6

		local var_4_7 = var_4_6.scale

		rtf = var_4_5

		local var_4_8 = var_4_5(arg_4_0.dialog)

		Vector3 = var_3

		local var_4_9 = var_4_7(var_4_8, var_3.New(0, 0, 1), var_0_1)
		local var_4_10 = var_1.setOnComplete

		System = var_3

		local var_4_11 = var_4_10(var_4_9, var_3.Action(function()
			arg_4_0.chatOn = false

			return
		end))
		local var_4_12 = var_1.setDelay(var_4_11, var_0_1 + var_0_2)
		local var_4_13 = var_1.setEase

		LeanTweenType = var_3

		var_4_13(var_4_12, var_3.easeInBack)

		return
	end
end

function var_0_0.play(arg_6_0)
	if not arg_6_0.started then
		arg_6_0.started = true

		local var_6_0 = arg_6_0.timer

		var_1.Start(var_6_0)
	else
		local var_6_1 = arg_6_0.timer

		var_1.Resume(var_6_1)
	end

	return
end

function var_0_0.pause(arg_7_0)
	if arg_7_0.started then
		local var_7_0 = arg_7_0.timer

		var_1.Pause(var_7_0)
	end

	return
end

function var_0_0.stop(arg_8_0)
	local var_8_0 = arg_8_0.timer

	var_1.Stop(var_8_0)

	arg_8_0.started = false

	return
end

return var_0_0
