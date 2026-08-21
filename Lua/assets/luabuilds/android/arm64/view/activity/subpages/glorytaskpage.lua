local var_0_0 = class("GloryTaskPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.slider = arg_1_0.bg:Find("slider")
	arg_1_0.step = arg_1_0.bg:Find("step")
	arg_1_0.progress = arg_1_0.bg:Find("progress")
	arg_1_0.displayBtn = arg_1_0.bg:Find("display_btn")
	arg_1_0.awardTF = arg_1_0.bg:Find("award")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	local var_2_0 = getProxy(TaskProxy)

	arg_2_0.taskList = arg_2_0.taskList or arg_2_0.activity:getConfig("config_data")

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.taskList) do
		arg_2_0.taskIndex = iter_2_0
		arg_2_0.taskVO = var_2_0:getTaskVO(iter_2_1)

		if not arg_2_0.taskVO:isReceive() then
			break
		end
	end

	assert(arg_2_0.taskVO, "without any taskVO!!!")

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.displayBtn, function()
		arg_3_0:emit(ActivityMediator.SHOW_AWARD_WINDOW, GloryAwardWindow, {
			taskList = arg_3_0.taskList,
			taskVO = arg_3_0.taskVO
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		arg_3_0:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_3_0.taskVO)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	local var_7_0 = arg_7_0.taskVO:getConfig("award_display")[1]

	updateDrop(arg_7_0.awardTF, {
		type = var_7_0[1],
		id = var_7_0[2],
		count = var_7_0[3]
	})
	onButton(arg_7_0, arg_7_0.awardTF, function()
		arg_7_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	if arg_7_0.step then
		setText(arg_7_0.step, arg_7_0.taskIndex .. "/" .. #arg_7_0.taskList)
	end

	local var_7_1 = arg_7_0.taskVO:getProgress()
	local var_7_2 = arg_7_0.taskVO:getConfig("target_num")

	setText(arg_7_0.progress, var_7_1 .. "/" .. var_7_2)
	setSlider(arg_7_0.slider, 0, var_7_2, var_7_1)

	local var_7_3 = arg_7_0.taskVO:getTaskStatus()

	setActive(arg_7_0.battleBtn, var_7_3 == 0)
	setActive(arg_7_0.getBtn, var_7_3 == 1)

	return
end

function var_0_0.OnDestroy(arg_9_0)
	return
end

return var_0_0
