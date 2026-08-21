local var_0_0 = class("FrameReTemplatePage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("got_btn")
	arg_1_0.bar = arg_1_0.bg:Find("frame/bar")
	arg_1_0.step = arg_1_0.bg:Find("frame/step")
	arg_1_0.progress = arg_1_0.bg:Find("frame/progress")
	arg_1_0.frameGot = arg_1_0.bg:Find("frame/got")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.avatarConfig = pg.activity_event_avatarframe[arg_2_0.activity:getConfig("config_id")]

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.activity.id
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.activity.data1
	local var_6_1 = arg_6_0.avatarConfig.target

	var_6_0 = arg_6_0.avatarConfig.target < arg_6_0.activity.data1 and var_6_1 or var_6_0

	local var_6_2 = var_6_0 / var_6_1
	local var_6_3 = var_6_0 / var_6_1 >= 1 and setColorStr(var_6_0, COLOR_GREEN) or var_6_0

	setText(arg_6_0.step, var_6_3)
	setText(arg_6_0.progress, "/" .. var_6_1)
	setFillAmount(arg_6_0.bar, var_6_2)

	local var_6_4 = var_6_1 <= var_6_0
	local var_6_5 = arg_6_0.activity.data2 >= 1

	setActive(arg_6_0.battleBtn, not (var_6_1 <= var_6_0))
	setActive(arg_6_0.getBtn, not var_6_5 and var_6_4)
	setActive(arg_6_0.gotBtn, var_6_5)
	setActive(arg_6_0.frameGot, var_6_5)

	return
end

return var_0_0
