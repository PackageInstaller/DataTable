local var_0_0 = class("YamaShiroSwimwearPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.goBtn = arg_1_0._tf:Find("GoBtn")
	arg_1_0.gotBtn = arg_1_0._tf:Find("GotBtn")
	arg_1_0.stepText = arg_1_0._tf:Find("Step")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.taskIDList = _.flatten((arg_2_0.activity:getConfig("config_data")))

	return updateActivityTaskStatus(arg_2_0.activity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
			page = "activity"
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	local var_5_0, var_5_1 = getActivityTask(arg_5_0.activity)

	setText(arg_5_0.stepText, (table.indexof(arg_5_0.taskIDList, var_5_0, 1)))

	local var_5_2 = var_5_1:getTaskStatus()

	setActive(arg_5_0.goBtn, var_5_2 == 0 or var_5_2 == 1)
	setActive(arg_5_0.gotBtn, var_5_2 == 2)

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

return var_0_0
