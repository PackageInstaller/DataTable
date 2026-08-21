local var_0_0 = class("AnniversaryNineInvitationPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.rtMarks = arg_1_0._tf:Find("AD/progress/items")
	arg_1_0.rtFinish = arg_1_0._tf:Find("AD/award/got")
	arg_1_0.rtBtns = arg_1_0._tf:Find("AD/btn_list")
	arg_1_0.goBtn = arg_1_0.rtBtns:Find("go")
	arg_1_0.getBtn = arg_1_0.rtBtns:Find("get")
	arg_1_0.gotBtn = arg_1_0.rtBtns:Find("got")
	arg_1_0.red = arg_1_0.rtBtns:Find("red")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.curDay = 0
	arg_2_0.taskProxy = getProxy(TaskProxy)
	arg_2_0.taskGroup = underscore.flatten(arg_2_0.activity:getConfig("config_data"))
	arg_2_0.lastTaskId = table.remove(arg_2_0.taskGroup)

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.goBtn, function()
		local var_4_0 = arg_3_0.coreActivityUI:GetActivityIdByPageClass("AnniversaryNineGamePage")

		if var_4_0 then
			arg_3_0.coreActivityUI:verifyTabs(var_4_0)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.getBtn, function()
		if arg_3_0.finalTaskVO and arg_3_0.finalTaskVO:getTaskStatus() == 1 then
			arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_3_0.finalTaskVO)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	for iter_6_0 = 1, #arg_6_0.taskGroup do
		local var_6_0 = arg_6_0.taskProxy:getTaskVO(arg_6_0.taskGroup[iter_6_0])

		if var_6_0 and var_6_0:getTaskStatus() == 1 then
			arg_6_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_6_0)

			return
		end
	end

	arg_6_0:RefreshTaskState()
	arg_6_0:RefreshProgress()
	arg_6_0:RefreshButtons()

	return
end

function var_0_0.RefreshTaskState(arg_7_0)
	arg_7_0.finalTaskVO = arg_7_0.taskProxy:getTaskVO(arg_7_0.lastTaskId)
	arg_7_0.finishCount = math.max(arg_7_0.activity.data3, 1) - (underscore.all(arg_7_0.taskGroup, function(arg_8_0)
		local var_8_0 = arg_7_0.taskProxy:getTaskVO(arg_8_0)

		return not var_8_0 or var_8_0:isReceive()
	end) and 0 or 1)

	return
end

function var_0_0.RefreshProgress(arg_9_0)
	local var_9_0 = math.min(arg_9_0.finishCount, arg_9_0.rtMarks.childCount)

	for iter_9_0 = 1, arg_9_0.rtMarks.childCount do
		local var_9_1 = arg_9_0.rtMarks:GetChild(iter_9_0 - 1)

		setActive(var_9_1:Find("mark"), iter_9_0 <= var_9_0)
	end

	return
end

function var_0_0.RefreshButtons(arg_10_0)
	local var_10_0 = arg_10_0.finalTaskVO and arg_10_0.finalTaskVO:getTaskStatus() or 0
	local var_10_1 = var_10_0 == 1
	local var_10_2 = var_10_0 == 2

	setActive(arg_10_0.goBtn, var_10_0 == 0)

	if var_10_1 then
		onButton(arg_10_0, arg_10_0.getBtn, function()
			if arg_10_0.finalTaskVO and arg_10_0.finalTaskVO:getTaskStatus() == 1 then
				arg_10_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_10_0.finalTaskVO)
			end

			return
		end, SFX_PANEL)
	end

	setActive(arg_10_0.getBtn, var_10_1)
	setActive(arg_10_0.red, var_10_1)
	setActive(arg_10_0.gotBtn, var_10_2)
	setActive(arg_10_0.rtFinish, var_10_2)

	return
end

return var_0_0
