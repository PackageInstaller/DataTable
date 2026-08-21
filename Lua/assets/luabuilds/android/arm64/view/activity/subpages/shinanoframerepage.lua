local var_0_0 = class("ShinanoframeRePage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.goBtn = arg_1_0.bg:Find("GoBtn")
	arg_1_0.getBtn = arg_1_0.bg:Find("GetBtn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("GotBtn")
	arg_1_0.gotTag = arg_1_0.bg:Find("got")
	arg_1_0.cur = arg_1_0.bg:Find("cur")
	arg_1_0.max = arg_1_0.bg:Find("max")
	arg_1_0.progressBar = arg_1_0.bg:Find("progress")

	setActive(arg_1_0.goBtn, false)
	setActive(arg_1_0.getBtn, false)
	setActive(arg_1_0.gotBtn, false)
	setActive(arg_1_0.gotTag, false)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.activity.id
		})

		return
	end, SFX_PANEL)
	setParent(LoadAndInstantiateSync("IconFrame", pg.activity_event_avatarframe[arg_3_0.activity:getConfig("config_id")].icon_frame), findTF(arg_3_0.bg, "icon"), false)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.activity.data1
	local var_6_1 = pg.activity_event_avatarframe[arg_6_0.activity:getConfig("config_id")].target

	if var_6_1 < arg_6_0.activity.data1 then
		var_6_0 = var_6_1
	end

	local var_6_2 = var_6_0 / var_6_1

	setText(arg_6_0.cur, var_6_0)
	setText(arg_6_0.max, "/" .. var_6_1)
	setSlider(arg_6_0.progressBar, 0, 1, var_6_2)
	setActive(arg_6_0.progressBar, true)

	local var_6_3 = var_6_1 <= var_6_0
	local var_6_4 = arg_6_0.activity.data2 >= 1

	setActive(arg_6_0.goBtn, not (var_6_1 <= var_6_0))
	setActive(arg_6_0.getBtn, not var_6_4 and var_6_3)
	setActive(arg_6_0.gotBtn, var_6_4)
	setActive(arg_6_0.gotTag, var_6_4)

	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

return var_0_0
