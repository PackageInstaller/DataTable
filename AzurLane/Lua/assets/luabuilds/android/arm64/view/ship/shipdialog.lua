local var_0_0 = class("ShipDialog")
local var_0_1 = 0.3
local var_0_2 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.dialog = arg_1_1
	arg_1_0.label = arg_1_0.dialog.gameObject:GetComponentInChildren(typeof(Text))
	arg_1_0.content = arg_1_2
	arg_1_0.started = false

	return
end

function var_0_0.loop(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.timer = Timer.New(function()
		arg_2_0:display()

		return
	end, arg_2_2 + arg_2_3 * math.random(), arg_2_1)

	return
end

function var_0_0.display(arg_4_0)
	if arg_4_0.chatOn then
		return
	end

	arg_4_0.chatOn = true
	rtf(arg_4_0.dialog).localScale = Vector3.New(0, 0, 1)
	arg_4_0.label.text = arg_4_0.content

	local var_4_0 = arg_4_0.label

	if #arg_4_0.content > CHAT_POP_STR_LEN then
		var_4_0.alignment = TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

		LeanTween.scale(rtf(arg_4_0.dialog), Vector3.New(1, 1, 1), var_0_1):setEase(LeanTweenType.easeOutBack)
		LeanTween.scale(rtf(arg_4_0.dialog), Vector3.New(0, 0, 1), var_0_1):setOnComplete(System.Action(function()
			arg_4_0.chatOn = false

			return
		end)):setDelay(var_0_1 + var_0_2):setEase(LeanTweenType.easeInBack)

		return
	end
end

function var_0_0.play(arg_6_0)
	if not arg_6_0.started then
		arg_6_0.started = true

		arg_6_0.timer:Start()
	else
		arg_6_0.timer:Resume()
	end

	return
end

function var_0_0.pause(arg_7_0)
	if arg_7_0.started then
		arg_7_0.timer:Pause()
	end

	return
end

function var_0_0.stop(arg_8_0)
	arg_8_0.timer:Stop()

	arg_8_0.started = false

	return
end

return var_0_0
