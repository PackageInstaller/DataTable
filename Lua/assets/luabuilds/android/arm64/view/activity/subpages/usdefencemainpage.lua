local var_0_0 = class("USDefenceMainPage", import(".TemplatePage.PreviewTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)
	arg_1_0:initUI()

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	arg_2_0:initData()
	arg_2_0:submitFinishedTask()

	return
end

function var_0_0.OnDataSetting(arg_3_0)
	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	arg_4_0:updateAwardBtn()

	return
end

function var_0_0.OnDestroy(arg_5_0)
	return
end

function var_0_0.initData(arg_6_0)
	arg_6_0.finalTaskID = arg_6_0.activity:getConfig("config_client")[1]
	arg_6_0.taskIDList = Clone(pg.task_data_template[arg_6_0.finalTaskID].target_id)
	arg_6_0.taskProxy = getProxy(TaskProxy)
	arg_6_0.taskListView = USDefTaskWindowView.New(arg_6_0.subViewContainer, arg_6_0.event, arg_6_0.activity)

	return
end

function var_0_0.initUI(arg_7_0)
	arg_7_0.awardTF = arg_7_0.bg:Find("Item")
	arg_7_0.activeTF = arg_7_0.awardTF:Find("Active")
	arg_7_0.finishedTF = arg_7_0.awardTF:Find("Finished")
	arg_7_0.achievedTF = arg_7_0.awardTF:Find("Achieved")

	setActive(arg_7_0.activeTF, false)
	setActive(arg_7_0.finishedTF, false)
	setActive(arg_7_0.achievedTF, false)

	arg_7_0.achievementBtn = arg_7_0.bg:Find("AchieveMentBtn")
	arg_7_0.subViewContainer = arg_7_0._tf:Find("SubViewContainer")

	return
end

function var_0_0.updateAwardBtn(arg_8_0)
	local var_8_0 = arg_8_0:getFinalTaskStatus()

	if var_8_0 == 0 then
		setActive(arg_8_0.activeTF, true)
		setActive(arg_8_0.finishedTF, false)
		setActive(arg_8_0.achievedTF, false)
		onButton(arg_8_0, arg_8_0.awardTF, function()
			arg_8_0.taskListView:Load()

			return
		end, SFX_PANEL)
		onButton(arg_8_0, arg_8_0.achievementBtn, function()
			arg_8_0.taskListView:Load()

			return
		end, SFX_PANEL)
	elseif var_8_0 == 1 then
		setActive(arg_8_0.activeTF, false)
		setActive(arg_8_0.finishedTF, true)
		setActive(arg_8_0.achievedTF, false)
		onButton(arg_8_0, arg_8_0.awardTF, function()
			arg_8_0:emit(ActivityMediator.ON_TASK_SUBMIT, (arg_8_0.taskProxy:getTaskVO(arg_8_0.finalTaskID)))

			return
		end, SFX_PANEL)
		onButton(arg_8_0, arg_8_0.achievementBtn, function()
			arg_8_0:emit(ActivityMediator.ON_TASK_SUBMIT, (arg_8_0.taskProxy:getTaskVO(arg_8_0.finalTaskID)))

			return
		end, SFX_PANEL)
	elseif var_8_0 == 2 then
		setActive(arg_8_0.activeTF, false)
		setActive(arg_8_0.finishedTF, false)
		setActive(arg_8_0.achievedTF, true)
		setButtonEnabled(arg_8_0.awardTF, false)
		setButtonEnabled(arg_8_0.achievementBtn, false)
	end

	return
end

function var_0_0.submitFinishedTask(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.taskIDList) do
		local var_13_0 = arg_13_0.taskProxy:getTaskById(iter_13_1)

		if var_13_0 and var_13_0:isFinish() then
			arg_13_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_13_0)
		end
	end

	return
end

function var_0_0.getFinalTaskStatus(arg_14_0)
	return arg_14_0.taskProxy:getTaskVO(arg_14_0.finalTaskID):getTaskStatus()
end

return var_0_0
