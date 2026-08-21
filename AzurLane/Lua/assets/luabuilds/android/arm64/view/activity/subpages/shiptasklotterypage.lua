local var_0_0 = class("ShipTaskLotteryPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.stepText = findTF(arg_1_0._tf, "ad/step")
	arg_1_0.progressSlider = findTF(arg_1_0._tf, "ad/progressSlider")
	arg_1_0.iconTf = findTF(arg_1_0._tf, "ad/IconTpl")
	arg_1_0.btnGet = findTF(arg_1_0._tf, "ad/btnGet")
	arg_1_0.btnGot = findTF(arg_1_0._tf, "ad/btnGot")
	arg_1_0.btnGo = findTF(arg_1_0._tf, "ad/btnGo")
	arg_1_0.taskDesc = findTF(arg_1_0._tf, "ad/taskDesc")
	arg_1_0.titleDesc = findTF(arg_1_0._tf, "ad/titleDesc")
	arg_1_0.progressDesc = findTF(arg_1_0._tf, "ad/progressDesc")

	onButton(arg_1_0, arg_1_0.btnGet, function()
		if arg_1_0.currentTask then
			arg_1_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_1_0.currentTask)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0, arg_1_0.btnGo, function()
		if arg_1_0.currentTask then
			arg_1_0:emit(ActivityMediator.ON_TASK_GO, arg_1_0.currentTask)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_1_0, arg_1_0.iconTf, function()
		arg_1_0:emit(BaseUI.ON_DROP, arg_1_0.drop)

		return
	end, SFX_PANEL)
	setText(arg_1_0.titleDesc, i18n("ship_task_lottery_title"))

	return
end

function var_0_0.OnFirstFlush(arg_5_0)
	arg_5_0.taskIds = arg_5_0.activity:getConfig("config_data")

	arg_5_0:updateUI()

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	arg_6_0:updateUI()

	return
end

function var_0_0.updateUI(arg_7_0)
	local var_7_0

	for iter_7_0 = 1, #arg_7_0.taskIds do
		if not var_7_0 then
			var_7_0 = getProxy(TaskProxy):getTaskById(arg_7_0.taskIds[iter_7_0])

			if var_7_0 then
				break
			end
		end
	end

	if not var_7_0 then
		for iter_7_1 = #arg_7_0.taskIds, 1, -1 do
			var_7_0 = getProxy(TaskProxy):getFinishTaskById(arg_7_0.taskIds[iter_7_1])

			if var_7_0 then
				break
			end
		end
	end

	if var_7_0 then
		arg_7_0.currentTask = var_7_0

		arg_7_0:showTaskUI()
	end

	return
end

function var_0_0.showTaskUI(arg_8_0)
	local var_8_0 = arg_8_0.currentTask:getConfig("award_display")

	arg_8_0.drop = {
		type = var_8_0[1][1],
		id = var_8_0[1][2],
		count = var_8_0[1][3]
	}

	updateDrop(arg_8_0.iconTf, arg_8_0.drop)
	setText(arg_8_0.taskDesc, arg_8_0.currentTask:getConfig("desc"))
	setText(arg_8_0.progressDesc, arg_8_0.currentTask:getProgress() .. "/" .. arg_8_0.currentTask:getConfig("target_num"))
	setSlider(arg_8_0.progressSlider, 0, arg_8_0.currentTask:getConfig("target_num"), arg_8_0.currentTask:getProgress())
	setActive(arg_8_0.btnGet, arg_8_0.currentTask:getTaskStatus() == 1)
	setActive(arg_8_0.btnGo, arg_8_0.currentTask:getTaskStatus() == 0)
	setActive(arg_8_0.btnGot, arg_8_0.currentTask:getTaskStatus() == 2)

	return
end

function var_0_0.OnDestroy(arg_9_0)
	return
end

return var_0_0
