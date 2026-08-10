local var_0_0 = class("SummerChessBoardActivityTaskItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.btnController_ = arg_1_0.allBtnController_:GetController("all")
	arg_1_0.timeTipsController_ = arg_1_0.greyController_:GetController("TImeTips")
	arg_1_0.rewardItems_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.rewardItems_[iter_1_0] = CommonItemView.New(arg_1_0[string.format("awardItem%sObj_", iter_1_0)])
	end
end

function var_0_0.OnExit(arg_2_0)
	arg_2_0:StopTimer()
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:StopTimer()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.rewardItems_) do
		iter_3_1:Dispose()
	end

	arg_3_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		local var_5_0 = AssignmentCfg[arg_4_0.taskID_]

		JumpTools.JumpToPage(var_5_0.source)
	end)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.taskID_ = arg_7_1

	local var_7_0 = AssignmentCfg[arg_7_1]
	local var_7_1 = TaskData2:GetTaskProgress(arg_7_1)

	arg_7_0.progressBar_.value = var_7_1 / var_7_0.need
	arg_7_0.titleText_.text = var_7_0.desc
	arg_7_0.progressText_.text = string.format("%s/%s", math.min(var_7_1, var_7_0.need), var_7_0.need)

	for iter_7_0, iter_7_1 in ipairs(var_7_0.reward) do
		local var_7_2 = clone(ItemTemplateData)

		var_7_2.id = iter_7_1[1]
		var_7_2.number = iter_7_1[2]
		var_7_2.grayFlag = TaskData2:GetTaskComplete(arg_7_1)

		function var_7_2.clickFun(arg_8_0)
			ShowPopItem(POP_ITEM, {
				arg_8_0.id,
				arg_8_0.number
			})
		end

		arg_7_0.rewardItems_[iter_7_0]:SetData(var_7_2)
	end

	for iter_7_2 = #var_7_0.reward + 1, 3 do
		arg_7_0.rewardItems_[iter_7_2]:SetData()
	end

	if arg_7_2 then
		arg_7_0.timeTipsController_:SetSelectedState("show")
		arg_7_0:RefreshTimer()
		arg_7_0:AddTimer()
	else
		arg_7_0.timeTipsController_:SetSelectedState("false")
	end

	if TaskData2:GetTaskComplete(arg_7_1) then
		if arg_7_0.greyCon_ then
			arg_7_0.greyCon_:SetSelectedState("true")
		end

		arg_7_0.btnController_:SetSelectedState("complete")
	else
		if arg_7_0.greyCon_ then
			arg_7_0.greyCon_:SetSelectedState("false")
		end

		if var_7_1 >= var_7_0.need then
			arg_7_0.btnController_:SetSelectedState("receive")
		else
			arg_7_0.btnController_:SetSelectedState("go")
		end
	end
end

function var_0_0.RefreshTimer(arg_9_0)
	local var_9_0 = AssignmentCfg[arg_9_0.taskID_].activity_id
	local var_9_1 = ActivityData:GetActivityData(var_9_0)

	if arg_9_0.timeText_ then
		arg_9_0.timeText_.text = manager.time:GetLostTimeStr(var_9_1.stopTime)
	end
end

function var_0_0.AddTimer(arg_10_0)
	arg_10_0:StopTimer()

	arg_10_0.timer_ = Timer.New(function()
		arg_10_0:RefreshTimer()
	end, 1, -1)

	arg_10_0.timer_:Start()
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

return var_0_0
