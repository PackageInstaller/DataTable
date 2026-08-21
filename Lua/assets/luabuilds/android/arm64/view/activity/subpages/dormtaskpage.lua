local var_0_0 = class("DormTaskPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.slider = arg_1_0.bg:Find("slider"):GetComponent(typeof(Slider))
	arg_1_0.step = arg_1_0.bg:Find("step"):GetComponent(typeof(Text))
	arg_1_0.stepMax = arg_1_0.bg:Find("step_max"):GetComponent(typeof(Text))
	arg_1_0.progress = arg_1_0.bg:Find("progress"):GetComponent(typeof(Text))
	arg_1_0.desc = arg_1_0.bg:Find("desc"):GetComponent(typeof(Text))
	arg_1_0.awardTF = arg_1_0.bg:Find("award")
	arg_1_0.awardGot = arg_1_0.bg:Find("award_got")
	arg_1_0.battleBtn = arg_1_0.bg:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.bg:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.bg:Find("got_btn")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = arg_2_0.activity:getConfig("config_client").unlock_task

	return updateActivityTaskStatus(arg_2_0.activity)
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.battleBtn, function()
		arg_3_0:emit(ActivityMediator.ON_TASK_GO, arg_3_0.taskVO)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_3_0.taskVO)

		return
	end, SFX_PANEL)
	setText(arg_3_0.stepMax, "/" .. #arg_3_0.taskGroup)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	arg_6_0.taskIndex = arg_6_0:getTaskIdx(arg_6_0.activity)
	arg_6_0.taskVO = arg_6_0.taskProxy:getTaskById(arg_6_0.taskGroup[arg_6_0.taskIndex][1]) or arg_6_0.taskProxy:getFinishTaskById(arg_6_0.taskGroup[arg_6_0.taskIndex][1])

	local var_6_0 = arg_6_0.taskVO:getConfig("award_display")[1]

	updateDrop(arg_6_0.awardTF, {
		type = var_6_0[1],
		id = var_6_0[2],
		count = var_6_0[3]
	})
	onButton(arg_6_0, arg_6_0.awardTF, function()
		arg_6_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	if arg_6_0.step then
		setText(arg_6_0.step, "DAY" .. arg_6_0.taskIndex)
	end

	local var_6_1 = arg_6_0.taskVO:getProgress()
	local var_6_2 = arg_6_0.taskVO:getConfig("target_num")

	setText(arg_6_0.desc, arg_6_0.taskVO:getConfig("desc"))
	setText(arg_6_0.progress, var_6_1 .. "/" .. var_6_2)
	setSlider(arg_6_0.slider, 0, var_6_2, var_6_1)

	local var_6_3 = arg_6_0.taskVO:getTaskStatus()

	setActive(arg_6_0.battleBtn, var_6_3 == 0)
	setActive(arg_6_0.getBtn, var_6_3 == 1)
	setActive(arg_6_0.gotBtn, var_6_3 == 2)
	setActive(arg_6_0.awardGot, var_6_3 == 2)

	return
end

function var_0_0.getTaskIdx(arg_8_0, arg_8_1)
	local var_8_0 = 1
	local var_8_1 = math.min(arg_8_1:getNDay(), #arg_8_0.taskGroup)

	for iter_8_0 = 1, var_8_1 do
		if not true then
			break
		end

		var_8_0 = iter_8_0

		if iter_8_0 < var_8_1 then
			for iter_8_1, iter_8_2 in ipairs(arg_8_0.taskGroup[iter_8_0]) do
				local var_8_2

				if not arg_8_0:isTaskFinished(iter_8_2) then
					var_8_2 = false

					break
				end
			end
		end
	end

	return math.min(var_8_0, #arg_8_0.taskGroup)
end

function var_0_0.isTaskFinished(arg_9_0, arg_9_1)
	arg_9_0.taskProxy = arg_9_0.taskProxy or getProxy(TaskProxy)

	local var_9_0 = arg_9_0.taskProxy:getTaskById(arg_9_1) or arg_9_0.taskProxy:getFinishTaskById(arg_9_1)

	return var_9_0 and var_9_0:getTaskStatus() == 2
end

return var_0_0
