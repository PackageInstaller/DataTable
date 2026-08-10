local var_0_0 = class("TaskPlotPhaseView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.rewardItems_ = {}
	arg_1_0.goRewardParent_ = {
		CommonItemView.New(arg_1_0.goItem1_),
		CommonItemView.New(arg_1_0.goItem2_),
		CommonItemView.New(arg_1_0.goItem3_)
	}
	arg_1_0.goItemTemplate_ = {
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	arg_1_0.btnController = arg_1_0.phaseController_:GetController("default0")

	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.awardBtn_, nil, function()
		TaskAction:SubmitTask(arg_2_0.taskID_)
	end)
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.taskID_ = TaskTools:GetPlotPhaseID()

	if arg_4_0.taskID_ == nil then
		return
	end

	local var_4_0 = TaskData2:GetTask(arg_4_0.taskID_)
	local var_4_1 = AssignmentCfg[arg_4_0.taskID_]
	local var_4_2 = var_4_0.progress

	if var_4_0.complete_flag >= 1 then
		SetActive(arg_4_0.awardBtn_.gameObject, false)
		SetActive(arg_4_0.activeAnimator_, false)

		var_4_2 = var_4_1.need

		arg_4_0.btnController:SetSelectedState("1")
	elseif var_4_2 < var_4_1.need then
		SetActive(arg_4_0.awardBtn_.gameObject, false)
		SetActive(arg_4_0.activeAnimator_, false)
		arg_4_0.btnController:SetSelectedState("1")
	else
		SetActive(arg_4_0.awardBtn_.gameObject, true)
		SetActive(arg_4_0.activeAnimator_, true)

		var_4_2 = var_4_1.need

		arg_4_0.btnController:SetSelectedState("2")
	end

	arg_4_0.imageProgress_.value = var_4_2 / var_4_1.need
	arg_4_0.textNum_.text = string.format("<color=#FFA456><size=56>%s</size></color>/%s", var_4_2, var_4_1.need)
	arg_4_0.textTitle_.text = GetI18NText(var_4_1.name)
	arg_4_0.textContent_.text = GetI18NText(var_4_1.desc)

	arg_4_0:RefreshReward(var_4_1.reward)
end

function var_0_0.RefreshReward(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		local var_5_0 = formatReward(iter_5_1)
		local var_5_1 = arg_5_0.goItemTemplate_[iter_5_0]

		var_5_1.id = var_5_0.id
		var_5_1.number = var_5_0.number
		var_5_1.timeValid = iter_5_1.timeValid or 0
		var_5_1.completedFlag = TaskData2:GetTaskComplete(arg_5_0.taskID_)
		var_5_1.clickFun = handler(arg_5_0, arg_5_0.OnClickCommonItem)

		arg_5_0.goRewardParent_[iter_5_0]:SetData(var_5_1)
	end

	for iter_5_2 = #arg_5_1 + 1, 3 do
		arg_5_0.goRewardParent_[iter_5_2]:SetData(nil)
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.goRewardParent_) do
		iter_6_1:Dispose()
	end

	arg_6_0.goRewardParent_ = nil
end

function var_0_0.OnClickCommonItem(arg_7_0, arg_7_1)
	ShowPopItem(POP_ITEM, {
		arg_7_1.id,
		arg_7_1.number
	})
end

return var_0_0
