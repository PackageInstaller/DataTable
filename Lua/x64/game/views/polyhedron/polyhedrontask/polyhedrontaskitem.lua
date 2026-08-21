local var_0_0 = class("PolyhedronTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_2, arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.rewardItemList_ = {}
	arg_2_0.itemDataList_ = {}
	arg_2_0.rewardState_ = arg_2_0.allBtnController_:GetController("all")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			arg_4_0.taskID_
		})
	end)
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.rewardItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.rewardItemList_ = nil
	arg_6_0.itemDataList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.taskID_ = arg_7_1
	arg_7_0.maxRewardNum_ = arg_7_2
	arg_7_0.activityID_ = AssignmentCfg[arg_7_0.taskID_].activity_id

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:RefreshDesc()
	arg_8_0:RefreshItem()
	arg_8_0:RefreshState()
	arg_8_0:Show(true)
end

function var_0_0.RefreshDesc(arg_9_0)
	local var_9_0 = AssignmentCfg[arg_9_0.taskID_]

	arg_9_0.titleText_.text = GetI18NText(var_9_0.desc)

	local var_9_1 = var_9_0.need
	local var_9_2 = TaskData2:GetTask(arg_9_0.taskID_)
	local var_9_3 = var_9_1

	if var_9_2 and var_9_2.progress and var_9_1 > var_9_2.progress then
		var_9_3 = var_9_2.progress
	end

	var_9_3 = var_9_1 < var_9_3 and var_9_1 or var_9_3
	arg_9_0.progressBar_.value = var_9_3 / var_9_1
	arg_9_0.progressText_.text = string.format("%s/%s", var_9_3, var_9_1)
end

function var_0_0.RefreshItem(arg_10_0)
	arg_10_0.rewardCfg_ = AssignmentCfg[arg_10_0.taskID_].reward

	for iter_10_0 = 1, arg_10_0.maxRewardNum_ do
		local var_10_0 = arg_10_0.rewardCfg_[iter_10_0]

		if not arg_10_0.rewardItemList_[iter_10_0] then
			arg_10_0.rewardItemList_[iter_10_0] = CommonItemView.New(arg_10_0[string.format("awardItem%sObj_", iter_10_0)])
		end

		arg_10_0.rewardItemList_[iter_10_0]:Show(true)

		if not arg_10_0.itemDataList_[iter_10_0] then
			arg_10_0.itemDataList_[iter_10_0] = clone(ItemTemplateData)
			arg_10_0.itemDataList_[iter_10_0].clickFun = function(arg_11_0)
				ShowPopItem(POP_ITEM, {
					arg_11_0.id,
					arg_11_0.number
				})
			end
		end

		local var_10_1 = true

		if var_10_0 then
			arg_10_0.itemDataList_[iter_10_0].id = var_10_0[1]
			arg_10_0.itemDataList_[iter_10_0].number = var_10_0[2]
			var_10_1 = false
		end

		if not var_10_1 then
			arg_10_0.rewardItemList_[iter_10_0]:SetData(arg_10_0.itemDataList_[iter_10_0])
		else
			arg_10_0.rewardItemList_[iter_10_0]:SetData(nil)
		end
	end

	for iter_10_1 = arg_10_0.maxRewardNum_ + 1, #arg_10_0.rewardItemList_ do
		arg_10_0.rewardItemList_[iter_10_1]:Show(false)
	end
end

function var_0_0.RefreshState(arg_12_0)
	local var_12_0 = AssignmentCfg[arg_12_0.taskID_].need
	local var_12_1 = TaskData2:GetTask(arg_12_0.taskID_)
	local var_12_2 = var_12_0

	if var_12_1 and var_12_1.progress then
		var_12_2 = var_12_1.progress
	end

	local var_12_3 = var_12_0 <= var_12_2
	local var_12_4 = TaskData2:GetTaskComplete(arg_12_0.taskID_)

	if not var_12_3 then
		arg_12_0.rewardState_:SetSelectedState("go")
	elseif not var_12_4 then
		arg_12_0.rewardState_:SetSelectedState("receive")
	else
		arg_12_0.rewardState_:SetSelectedState("complete")
	end
end

function var_0_0.Show(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

return var_0_0
