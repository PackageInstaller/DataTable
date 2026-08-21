local var_0_0 = class("UrExchangeTaskPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.uilist = UIItemList.New(arg_1_0._tf:Find("AD/task_list/content"), arg_1_0._tf:Find("AD/task_list/content/tpl"))
	arg_1_0.getBtn = arg_1_0._tf:Find("AD/get_btn")
	arg_1_0.gotBtn = arg_1_0._tf:Find("AD/got_btn")
	arg_1_0.unfinishBtn = arg_1_0._tf:Find("AD/unfinish_btn")

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	if not arg_2_0:GetTaskById(arg_2_0.activity:getConfig("config_data")[1][1]) then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_2_0.activity.id
		})

		return true
	else
		return false
	end

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	local var_3_0 = _.map(arg_3_0.activity:getConfig("config_data")[1], function(arg_4_0)
		return arg_3_0:GetTaskById(arg_4_0)
	end)
	local var_3_1 = table.remove(var_3_0, #var_3_0)

	local function var_3_2(arg_5_0)
		if arg_5_0:isFinish() and not arg_5_0:isReceive() then
			return 0
		elseif arg_5_0:isReceive() then
			return 2
		else
			return 1
		end

		return
	end

	table.sort(var_3_0, function(arg_6_0, arg_6_1)
		return var_3_2(arg_6_0) < var_3_2(arg_6_1)
	end)
	arg_3_0.uilist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateTask(arg_7_2, var_3_0[arg_7_1 + 1])
		end

		return
	end)
	arg_3_0.uilist:align(#var_3_0)

	local var_3_3 = var_3_1:isReceive()
	local var_3_4 = _.all(var_3_0, function(arg_8_0)
		return arg_8_0:isFinish() and arg_8_0:isReceive()
	end)
	local var_3_5 = var_3_1:isFinish() and not var_3_3 and var_3_4

	onButton(arg_3_0, arg_3_0.getBtn, function()
		if var_3_5 then
			arg_3_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_3_1)
		end

		return
	end, SFX_PANEL)
	setActive(arg_3_0.getBtn, var_3_5)
	setActive(arg_3_0.unfinishBtn, not var_3_5 and not var_3_3)
	setActive(arg_3_0.gotBtn, var_3_3)

	return
end

function var_0_0.GetTaskById(arg_10_0, arg_10_1)
	local var_10_0 = getProxy(TaskProxy):getTaskById(arg_10_1)

	var_10_0 = var_10_0 or getProxy(TaskProxy):getFinishTaskById(arg_10_1)

	return var_10_0
end

function var_0_0.UpdateTask(arg_11_0, arg_11_1, arg_11_2)
	assert(arg_11_2)
	setText(arg_11_1:Find("Text"), arg_11_2:getConfig("desc"))

	local var_11_0 = arg_11_2:getConfig("award_display")[1]

	assert(var_11_0, arg_11_2.id)
	assert(var_11_0)

	local var_11_1 = arg_11_1:Find("item")

	updateDrop(var_11_1, {
		type = var_11_0[1],
		id = var_11_0[2],
		count = var_11_0[3]
	})
	onButton(arg_11_0, var_11_1, function()
		arg_11_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_11_2 = arg_11_2:isFinish()
	local var_11_3 = arg_11_2:isReceive()

	setActive(arg_11_1:Find("mark"), var_11_2 and not var_11_3)

	if var_11_2 and not var_11_3 then
		onButton(arg_11_0, arg_11_1, function()
			arg_11_0:emit(ActivityMediator.ON_TASK_SUBMIT, arg_11_2)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_11_1)
	end

	setActive(arg_11_1:Find("progress_finish"), var_11_2 and var_11_3)

	local var_11_4 = arg_11_2:getProgress()
	local var_11_5 = arg_11_2:getConfig("target_num")

	setSlider(arg_11_1:Find("progress"), 0, 1, var_11_4 / var_11_5)
	setText(arg_11_1:Find("progress/Text"), var_11_2 and "" or var_11_4 .. "/" .. var_11_5)

	return
end

return var_0_0
