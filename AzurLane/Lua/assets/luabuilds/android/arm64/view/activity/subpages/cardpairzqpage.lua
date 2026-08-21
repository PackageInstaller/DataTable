local var_0_0 = class("CardPairZQPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.slider = arg_1_0.bg:Find("slider")
	arg_1_0.step = arg_1_0.bg:Find("step")
	arg_1_0.progress = arg_1_0.bg:Find("progress")
	arg_1_0.displayBtn = arg_1_0.bg:Find("display_btn")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("got_btn")
	arg_1_0.gotIcon = arg_1_0.bg:Find("icon_got")
	arg_1_0.maskList = arg_1_0.bg:Find("maskList")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity:getConfig("config_data")[1]

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CARD_PAIRS)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	local var_5_0 = arg_5_0.activity.data2

	for iter_5_0 = 1, 7 do
		local var_5_1 = arg_5_0.maskList:Find("mask" .. iter_5_0)

		setActive(var_5_1, iter_5_0 <= var_5_0)
		setActive(var_5_1:Find("frame"), var_5_0 <= iter_5_0)
	end

	setActive(arg_5_0.gotIcon, var_5_0 >= 7)

	local var_5_3 = arg_5_0.slider
	local var_5_4 = 0
	local var_5_5 = 6

	if var_5_0 - 1 >= 0 then
		local var_5_6 = var_5_0 - 1 or 0

		var_5_2(var_5_3, var_5_4, var_5_5, var_5_6)
		setActive(arg_5_0.battleBtn, true)
		setActive(arg_5_0.getBtn, false)
		setActive(arg_5_0.gotBtn, false)

		return
	end
end

return var_0_0
