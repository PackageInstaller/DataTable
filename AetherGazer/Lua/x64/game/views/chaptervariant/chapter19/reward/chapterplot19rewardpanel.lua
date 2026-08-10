local var_0_0 = class("", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.btnController_ = arg_1_0.controllerEx_:GetController("default0")
	arg_1_0.rewardItemList_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.rewardItemList_[iter_1_0] = CommonItemView.New(arg_1_0[string.format("rewardItem%s_", iter_1_0)])
	end
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.rewardItemList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.rewardItemList_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_3_0.taskID_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.rewardIndex_ = arg_5_1
	arg_5_0.taskID_ = arg_5_2

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = AssignmentCfg[arg_6_0.taskID_]

	arg_6_0.indexText_.text = string.format("%02d", arg_6_0.rewardIndex_)
	arg_6_0.indexText2_.text = string.format("%02d", arg_6_0.rewardIndex_)
	arg_6_0.progressCntText_.text = GetI18NText(var_6_0.desc)

	local var_6_1 = TaskData2:GetTaskProgress(arg_6_0.taskID_)
	local var_6_2 = var_6_0.need

	arg_6_0.progressText_.text = string.format("%s/%s", var_6_1, var_6_2)
	arg_6_0.progressBar_.value = var_6_1 / var_6_2

	local var_6_3 = TaskData2:GetTaskComplete(arg_6_0.taskID_)

	if var_6_3 then
		arg_6_0.btnController_:SetSelectedState("received")
	elseif var_6_2 <= var_6_1 then
		arg_6_0.btnController_:SetSelectedState("clear")
	else
		arg_6_0.btnController_:SetSelectedState("notclear")
	end

	arg_6_0:RefreshItem(var_6_3)
end

function var_0_0.RefreshItem(arg_7_0, arg_7_1)
	local var_7_0 = AssignmentCfg[arg_7_0.taskID_]

	for iter_7_0, iter_7_1 in pairs(var_7_0.reward) do
		local var_7_1 = clone(ItemTemplateData)

		var_7_1.id = iter_7_1[1]
		var_7_1.number = iter_7_1[2]
		var_7_1.grayFlag = arg_7_1 == true

		function var_7_1.clickFun(arg_8_0)
			ShowPopItem(POP_ITEM, {
				arg_8_0.id,
				arg_8_0.number
			})
		end

		arg_7_0.rewardItemList_[iter_7_0]:SetData(var_7_1)
	end

	for iter_7_2 = #var_7_0.reward + 1, #arg_7_0.rewardItemList_ do
		arg_7_0.rewardItemList_[iter_7_2]:SetData(nil)
	end
end

return var_0_0
