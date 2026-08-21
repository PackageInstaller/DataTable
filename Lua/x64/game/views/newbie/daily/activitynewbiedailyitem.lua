local var_0_0 = class("ActivityNewbieDailyItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = arg_1_0.controllerExCollection_:GetController("state")
	arg_1_0.lockTroller_ = ControllerUtil.GetController(arg_1_0.transform_, "conName")
	arg_1_0.countDownController_ = ControllerUtil.GetController(arg_1_0.transform_, "countDown")
	arg_1_0.parentWidth_ = arg_1_0.transformParent_.rect.width / 2
	arg_1_0.itemWidth_ = arg_1_0.transform_.rect.width / 2
end

function var_0_0.Dispose(arg_2_0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, arg_2_0.onSubmitTaskResponseHandle_)
	var_0_0.super.Dispose(arg_2_0)

	arg_2_0.itemData_ = nil

	if arg_2_0.rewardItem_ then
		arg_2_0.rewardItem_:Dispose()

		arg_2_0.rewardItem_ = nil
	end

	if arg_2_0.timer_ then
		arg_2_0.timer_:Stop()

		arg_2_0.timer_ = nil
	end
end

function var_0_0.RegistListener(arg_3_0, arg_3_1)
	arg_3_0.func_ = arg_3_1
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buttonReceive_, nil, function()
		local var_5_0 = TaskData2:GetTask(arg_4_0.taskID_)
		local var_5_1 = AssignmentCfg[arg_4_0.taskID_]

		if var_5_0 then
			if var_5_0.complete_flag >= 1 then
				return
			elseif var_5_0.progress < var_5_1.need then
				JumpTools.JumpToPage2(var_5_1.source)
			else
				TaskAction:SubmitTask(arg_4_0.taskID_)
			end
		end
	end)

	arg_4_0.onSubmitTaskResponseHandle_ = handler(arg_4_0, arg_4_0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, arg_4_0.onSubmitTaskResponseHandle_)
end

function var_0_0.onSubmitTaskResponse(arg_6_0)
	arg_6_0.controller_:SetSelectedState("2")

	if arg_6_0.func_ then
		arg_6_0.func_()
	end
end

function var_0_0.RefreshCountDown(arg_7_0)
	if arg_7_0.timer_ then
		arg_7_0.timer_:Stop()

		arg_7_0.timer_ = nil
	end

	local var_7_0 = TaskData2:GetTask(arg_7_0.taskID_)
	local var_7_1 = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER][arg_7_0.index_ - 1]
	local var_7_2 = TaskData2:GetTask(var_7_1)

	if not var_7_0 and var_7_2 and var_7_2.complete_flag == 1 then
		local var_7_3 = manager.time:GetNextFreshTime() - manager.time:GetServerTime()

		arg_7_0.countdownText_.text = tostring(manager.time:DescCDTime(var_7_3))

		arg_7_0.countDownController_:SetSelectedState("true")

		arg_7_0.timer_ = Timer.New(function()
			local var_8_0 = manager.time:GetNextFreshTime() - manager.time:GetServerTime()

			arg_7_0.countdownText_.text = tostring(manager.time:DescCDTime(var_8_0))

			if var_8_0 <= 0 then
				arg_7_0:RefreshUI(arg_7_0.index_)
				arg_7_0.timer_:Stop()

				arg_7_0.timer_ = nil
			end
		end, 1, -1)

		arg_7_0.timer_:Start()
	else
		arg_7_0.countDownController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1)
	arg_9_0.index_ = arg_9_1

	if arg_9_1 < 10 then
		arg_9_0.textDay_.text = string.format("0<color=#3D3D3D>%s</color>", arg_9_1)
	else
		arg_9_0.textDay_.text = string.format("<color=#3D3D3D>%s</color>", arg_9_1)
	end

	local var_9_0 = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER][arg_9_1]

	if not arg_9_0.itemData_ then
		arg_9_0.itemData_ = clone(ItemTemplateData)

		function arg_9_0.itemData_.clickFun(arg_10_0)
			ShowPopItem(POP_ITEM, {
				arg_10_0.id,
				arg_10_0.number
			})
		end
	end

	local var_9_1 = AssignmentCfg[var_9_0]
	local var_9_2 = var_9_1.reward[1]

	arg_9_0.itemData_.id = var_9_2[1]
	arg_9_0.itemData_.number = var_9_2[2]

	if arg_9_0.rewardItem_ == nil then
		arg_9_0.rewardItem_ = CommonItemPool.New(arg_9_0.itemParent_, arg_9_0.itemData_)
	else
		arg_9_0.rewardItem_:SetData(arg_9_0.itemData_)
	end

	arg_9_0.taskID_ = var_9_0

	local var_9_3 = var_9_1.desc
	local var_9_4
	local var_9_5 = 0
	local var_9_6 = TaskData2:GetTask(var_9_0)

	if var_9_6 then
		local var_9_7 = var_9_6.progress

		if var_9_7 > var_9_1.need then
			var_9_7 = var_9_1.need
		end

		if var_9_6.complete_flag == 0 then
			if var_9_7 >= var_9_1.need then
				arg_9_0.controller_:SetSelectedState("receive")
			else
				arg_9_0.controller_:SetSelectedState("go")
			end
		else
			arg_9_0.controller_:SetSelectedState("complete")

			var_9_7 = var_9_1.need
		end

		var_9_4 = string.format("%s/%s", var_9_7, var_9_1.need)

		arg_9_0.lockTroller_:SetSelectedState("0")
	else
		arg_9_0.controller_:SetSelectedState("0")
		arg_9_0.lockTroller_:SetSelectedState("1")

		var_9_3 = ""
		var_9_4 = ""
	end

	arg_9_0.textDesc_.text = var_9_3
	arg_9_0.textProgress_.text = var_9_4

	arg_9_0:RefreshCountDown()
end

function var_0_0.RefreshAlpha(arg_11_0)
	local var_11_0 = arg_11_0.transformParent_:InverseTransformPoint(arg_11_0.transform_:TransformPoint(Vector3.zero))
	local var_11_1 = math.abs(arg_11_0.parentWidth_ - var_11_0.x - arg_11_0.itemWidth_)

	arg_11_0.canvasGroup_.alpha = 1 - var_11_1 / arg_11_0.parentWidth_ * 0.5
end

return var_0_0
