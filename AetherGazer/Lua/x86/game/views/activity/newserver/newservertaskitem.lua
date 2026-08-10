local var_0_0 = class("NewServerTaskItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.rewardItemList_ = {}
	arg_1_0.itemDataList_ = {}
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.isShow_ = true

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.taskID_ = arg_2_1
	arg_2_0.maxRewardNum_ = arg_2_2
	arg_2_0.taskProgress_ = TaskData2:GetTaskProgress(arg_2_1)
	arg_2_0.taskComplete_ = TaskData2:GetTaskComplete(arg_2_1)

	arg_2_0:RefreshUI()
	arg_2_0:RefreshProgress()

	arg_2_0.isShow_ = true
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0.isShow_ = false

	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.Dispose(arg_4_0)
	arg_4_0.itemDataList_ = nil

	for iter_4_0, iter_4_1 in pairs(arg_4_0.rewardItemList_) do
		iter_4_1:Dispose()
	end

	arg_4_0.rewardItemList_ = nil

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.stateController_ = arg_5_0.allBtnController_:GetController("all")

	for iter_5_0 = 1, 3 do
		arg_5_0.rewardItemList_[iter_5_0] = CommonItemView.New(arg_5_0[string.format("awardItem%dObj_", iter_5_0)])
	end
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		local var_7_0 = AssignmentCfg[arg_6_0.taskID_]

		JumpTools.JumpToPage2(var_7_0.source)
	end)
	arg_6_0:AddBtnListener(arg_6_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_6_0.taskID_)
	end)
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = AssignmentCfg[arg_9_0.taskID_]

	arg_9_0.titleText_.text = GetI18NText(var_9_0.desc)

	arg_9_0:RefreshReward()
end

function var_0_0.RefreshReward(arg_10_0)
	local var_10_0 = AssignmentCfg[arg_10_0.taskID_].reward or {}

	for iter_10_0 = 1, 3 do
		local var_10_1 = var_10_0[iter_10_0]

		if not arg_10_0.itemDataList_[iter_10_0] then
			arg_10_0.itemDataList_[iter_10_0] = clone(ItemTemplateData)
			arg_10_0.itemDataList_[iter_10_0].clickFun = function(arg_11_0)
				ShowPopItem(POP_ITEM, {
					arg_11_0.id,
					arg_11_0.number
				})
			end
		end

		local var_10_2 = true

		if var_10_1 then
			arg_10_0.itemDataList_[iter_10_0].id = var_10_1[1]
			arg_10_0.itemDataList_[iter_10_0].number = var_10_1[2]
			var_10_2 = false
		end

		arg_10_0.rewardItemList_[iter_10_0]:Show(true)

		if not var_10_2 then
			arg_10_0.rewardItemList_[iter_10_0]:SetData(arg_10_0.itemDataList_[iter_10_0])
		else
			arg_10_0.rewardItemList_[iter_10_0]:SetData(nil)
		end
	end

	for iter_10_1 = arg_10_0.maxRewardNum_ + 1, #arg_10_0.rewardItemList_ do
		arg_10_0.rewardItemList_[iter_10_1]:Show(false)
	end
end

function var_0_0.RefreshProgress(arg_12_0)
	local var_12_0 = AssignmentCfg[arg_12_0.taskID_]
	local var_12_1 = arg_12_0.taskProgress_

	if arg_12_0.taskProgress_ > var_12_0.need then
		var_12_1 = var_12_0.need
	end

	arg_12_0.progressBar_.value = var_12_1 / var_12_0.need
	arg_12_0.progressText_.text = string.format("%s/%s", var_12_1, var_12_0.need)

	local var_12_2 = arg_12_0.taskProgress_ >= var_12_0.need

	if arg_12_0.taskComplete_ then
		arg_12_0.stateController_:SetSelectedState("complete")
	elseif var_12_2 then
		arg_12_0.stateController_:SetSelectedState("receive")
	else
		arg_12_0.stateController_:SetSelectedState("go")
	end
end

return var_0_0
