class = var_0_10000

local var_0_0 = var_0_10000("MonopolyCar2024BubblePage")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.event = arg_1_2
	arg_1_0._tf = arg_1_1
	findTF = var_1_10003

	local var_1_0 = var_1_10003(arg_1_1, "head")
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0.head = var_1_1(var_1_0, var_6(var_1_10008))
	findTF = var_3

	local var_1_2 = var_3(arg_1_1, "chat/Text")
	local var_1_3 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.content = var_1_3(var_1_2, var_6(var_1_10008))

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_3.GetComponent

	typeof = var_6
	Animation = var_1_10008
	arg_1_0.anim = var_1_5(var_1_4, var_6(var_1_10008))

	local var_1_6 = arg_1_0.anim
	local var_1_7 = var_3.GetComponent

	typeof = var_6
	DftAniEvent = var_1_10008
	arg_1_0.animEvent = var_1_7(var_1_6, var_6(var_1_10008))

	local var_1_8 = arg_1_0.animEvent

	var_3.SetEndEvent(var_1_8, function()
		setActive = var_2_10000

		var_2_10000(arg_1_0._tf, false)

		return
	end)

	pg = var_3
	arg_1_0.showTime = var_3.gameset.monopoly2024_bubble_time.key_value
	setActive = var_3

	var_3(arg_1_0._tf, false)

	return
end

function var_0_0.GetUiAtlas(arg_3_0)
	return "ui/MonopolyCar2024_atlas"
end

function var_0_0.emit(arg_4_0, ...)
	local var_4_0 = arg_4_0.event

	var_1.emit(var_4_0, ...)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	setActive = var_1_10004

	var_1_10004(arg_5_0._tf, true)

	local var_5_0 = arg_5_0.anim

	var_4.Play(var_5_0, "anim_monopolycar_bubble_show")

	GetSpriteFromAtlas = var_4

	local var_5_1 = var_4(arg_5_0:GetUiAtlas(), arg_5_2)

	arg_5_0.head.sprite = var_5_1

	local var_5_2 = arg_5_0.head

	var_5.SetNativeSize(var_5_2)

	pg = var_5

	local var_5_3 = var_5.activity_event_monopoly_dialogue[arg_5_3].dialogue

	arg_5_0.content.text = var_5_3

	arg_5_0:AddTimer()

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.emit

	MonopolyCar2024Mediator = var_1_10009

	var_5_5(var_5_4, var_1_10009.ON_DIALOGUE, arg_5_1, arg_5_3)

	return
end

function var_0_0.AddTimer(arg_6_0)
	arg_6_0:RemoveTimer()

	Timer = var_1
	arg_6_0.timer = var_1.New(function()
		local var_7_0 = arg_6_0

		var_0.RemoveTimer(var_7_0)

		local var_7_1 = arg_6_0

		var_0.Hide(var_7_1)

		return
	end, arg_6_0.showTime, 1)

	local var_6_0 = arg_6_0.timer

	var_1.Start(var_6_0)

	return
end

function var_0_0.RemoveTimer(arg_8_0)
	if arg_8_0.timer then
		local var_8_0 = arg_8_0.timer

		var_1.Stop(var_8_0)

		arg_8_0.timer = nil
	end

	return
end

function var_0_0.Hide(arg_9_0)
	local var_9_0 = arg_9_0.anim

	var_1.Play(var_9_0, "anim_monopolycar_bubble_hide")

	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveTimer()

	return
end

return var_0_0
