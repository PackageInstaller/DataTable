local var_0_0 = class("CardPairFXPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.startBtn = arg_1_0.bg:Find("StartBtn")
	arg_1_0.slider = arg_1_0.bg:Find("Slider")
	arg_1_0.heartImg = arg_1_0.slider:Find("Fill/Heart")
	arg_1_0.gotImg = arg_1_0.bg:Find("GotImg")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.startBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CARD_PAIRS)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	local var_5_0 = arg_5_0.activity.data1

	setActive(arg_5_0.gotImg, arg_5_0.activity.data1 == 1)
	setActive(arg_5_0.heartImg, var_5_0 ~= 1)

	if arg_5_0.activity.data2 >= 7 then
		setActive(arg_5_0.heartImg, false)
	end

	setSlider(arg_5_0.slider, 0, 7, arg_5_0.activity.data2)

	return
end

return var_0_0
