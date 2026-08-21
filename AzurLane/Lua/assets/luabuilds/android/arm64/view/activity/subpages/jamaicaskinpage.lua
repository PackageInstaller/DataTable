local var_0_0 = class("JamaicaSkinPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.slider = arg_1_0.bg:Find("slider")
	arg_1_0.step = arg_1_0.bg:Find("step")
	arg_1_0.progress = arg_1_0.bg:Find("progress")
	arg_1_0.awardTF = arg_1_0.bg:Find("award")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("got_btn")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.taskIDList = _.flatten((arg_2_0.activity:getConfig("config_data")))
	arg_2_0.dropList = {}
	arg_2_0.descs = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.taskIDList) do
		table.insert(arg_2_0.dropList, Clone(pg.task_data_template[iter_2_1].award_display[1]))
		table.insert(arg_2_0.descs, pg.task_data_template[iter_2_1].desc)
	end

	return updateActivityTaskStatus(arg_2_0.activity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		arg_3_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_3_0.curTaskVO)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	local var_6_0, var_6_1 = getActivityTask(arg_6_0.activity)

	arg_6_0.curTaskVO = var_6_1

	local var_6_2 = var_6_1:getConfig("award_display")[1]

	updateDrop(arg_6_0.awardTF, {
		type = var_6_2[1],
		id = var_6_2[2],
		count = var_6_2[3]
	})
	onButton(arg_6_0, arg_6_0.awardTF, function()
		arg_6_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_6_3 = var_6_1:getProgress()
	local var_6_4 = var_6_1:getConfig("target_num")
	local var_6_5 = var_6_4 <= var_6_3 and setColorStr(var_6_3, COLOR_GREEN) or var_6_3

	setText(arg_6_0.progress, var_6_5 .. "/" .. var_6_4)
	setSlider(arg_6_0.slider, 0, var_6_4, var_6_3)

	local var_6_6 = table.indexof(arg_6_0.taskIDList, var_6_0, 1)

	setText(arg_6_0.step, var_6_6 .. "/" .. #arg_6_0.taskIDList)

	local var_6_7 = var_6_1:getTaskStatus()

	setActive(arg_6_0.battleBtn, var_6_7 == 0)
	setActive(arg_6_0.getBtn, var_6_7 == 1)
	setActive(arg_6_0.gotBtn, var_6_7 == 2)

	arg_6_0.finishedIndex = var_6_7 == 2 and var_6_6 or var_6_6 - 1

	return
end

function var_0_0.OnDestroy(arg_8_0)
	return
end

return var_0_0
