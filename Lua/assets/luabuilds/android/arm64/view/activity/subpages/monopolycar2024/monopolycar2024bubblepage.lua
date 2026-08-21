local var_0_0 = class("MonopolyCar2024BubblePage")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.event = arg_1_2
	arg_1_0._tf = arg_1_1
	arg_1_0.head = findTF(arg_1_1, "head"):GetComponent(typeof(Image))
	arg_1_0.content = findTF(arg_1_1, "chat/Text"):GetComponent(typeof(Text))
	arg_1_0.anim = arg_1_0._tf:GetComponent(typeof(Animation))
	arg_1_0.animEvent = arg_1_0.anim:GetComponent(typeof(DftAniEvent))

	arg_1_0.animEvent:SetEndEvent(function()
		setActive(arg_1_0._tf, false)

		return
	end)

	arg_1_0.showTime = pg.gameset.monopoly2024_bubble_time.key_value

	setActive(arg_1_0._tf, false)

	return
end

function var_0_0.GetUiAtlas(arg_3_0)
	return "ui/MonopolyCar2024_atlas"
end

function var_0_0.emit(arg_4_0, ...)
	arg_4_0.event:emit(...)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	setActive(arg_5_0._tf, true)
	arg_5_0.anim:Play("anim_monopolycar_bubble_show")

	arg_5_0.head.sprite = GetSpriteFromAtlas(arg_5_0:GetUiAtlas(), arg_5_2)

	arg_5_0.head:SetNativeSize()

	arg_5_0.content.text = pg.activity_event_monopoly_dialogue[arg_5_3].dialogue

	arg_5_0:AddTimer()
	arg_5_0:emit(MonopolyCar2024Mediator.ON_DIALOGUE, arg_5_1, arg_5_3)

	return
end

function var_0_0.AddTimer(arg_6_0)
	arg_6_0:RemoveTimer()

	arg_6_0.timer = Timer.New(function()
		arg_6_0:RemoveTimer()
		arg_6_0:Hide()

		return
	end, arg_6_0.showTime, 1)

	arg_6_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_8_0)
	if arg_8_0.timer then
		arg_8_0.timer:Stop()

		arg_8_0.timer = nil
	end

	return
end

function var_0_0.Hide(arg_9_0)
	arg_9_0.anim:Play("anim_monopolycar_bubble_hide")

	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveTimer()

	return
end

return var_0_0
