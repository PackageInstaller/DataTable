local var_0_0 = class("SummerChessBoardChessTaskItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.btnController_ = arg_1_0.allBtnController_:GetController("all")
	arg_1_0.timeTipsController_ = arg_1_0.greyController_:GetController("TImeTips")
	arg_1_0.rewardItems_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.rewardItems_[iter_1_0] = CommonItemView.New(arg_1_0[string.format("awardItem%sObj_", iter_1_0)])
	end
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.rewardItems_) do
		iter_2_1:Dispose()
	end

	arg_2_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		local var_4_0 = AssignmentCfg[arg_3_0.taskID_]

		JumpTools.JumpToPage(var_4_0.source)
	end)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_3_0.taskID_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.taskID_ = arg_6_1

	local var_6_0 = AssignmentCfg[arg_6_1]
	local var_6_1 = TaskData2:GetTaskProgress(arg_6_1)

	arg_6_0.progressBar_.value = var_6_1 / var_6_0.need
	arg_6_0.titleText_.text = var_6_0.desc
	arg_6_0.progressText_.text = string.format("%s/%s", var_6_1, var_6_0.need)

	for iter_6_0, iter_6_1 in ipairs(var_6_0.reward) do
		local var_6_2 = clone(ItemTemplateData)

		var_6_2.id = iter_6_1[1]
		var_6_2.number = iter_6_1[2]
		var_6_2.grayFlag = TaskData2:GetTaskComplete(arg_6_1)

		function var_6_2.clickFun(arg_7_0)
			ShowPopItem(POP_ITEM, {
				arg_7_0.id,
				arg_7_0.number
			})
		end

		arg_6_0.rewardItems_[iter_6_0]:SetData(var_6_2)
	end

	for iter_6_2 = #var_6_0.reward + 1, 3 do
		arg_6_0.rewardItems_[iter_6_2]:SetData()
	end

	arg_6_0.timeTipsController_:SetSelectedState("false")

	if TaskData2:GetTaskComplete(arg_6_1) then
		arg_6_0.btnController_:SetSelectedState("complete")
	elseif var_6_1 >= var_6_0.need then
		arg_6_0.btnController_:SetSelectedState("receive")
	else
		arg_6_0.btnController_:SetSelectedState("go")
	end
end

return var_0_0
