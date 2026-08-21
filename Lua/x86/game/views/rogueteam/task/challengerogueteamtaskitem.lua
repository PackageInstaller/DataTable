local var_0_0 = class("ChallengeRogueTeamTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
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
		}, nil, arg_4_0.callBack_)
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

function var_0_0.UnBindRedPoint(arg_7_0)
	manager.redPoint:unbindUIandKey(arg_7_0.receiveBtn_.transform, arg_7_0.taskRedPointStr_)
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.taskID_ = arg_8_1
	arg_8_0.activityID_ = AssignmentCfg[arg_8_0.taskID_].activity_id
	arg_8_0.taskRedPointStr_ = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_8_0.taskID_)

	manager.redPoint:bindUIandKey(arg_8_0.receiveBtn_.transform, arg_8_0.taskRedPointStr_)
	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshDesc()
	arg_9_0:RefreshItem()
	arg_9_0:RefreshState()
	arg_9_0:Show(true)
end

function var_0_0.RefreshDesc(arg_10_0)
	local var_10_0 = AssignmentCfg[arg_10_0.taskID_]

	arg_10_0.titleText_.text = GetI18NText(var_10_0.desc)

	local var_10_1 = var_10_0.need
	local var_10_2 = TaskData2:GetTask(arg_10_0.taskID_)
	local var_10_3 = var_10_1

	if var_10_2 and var_10_2.progress and var_10_1 > var_10_2.progress then
		var_10_3 = var_10_2.progress
	end

	var_10_3 = var_10_1 < var_10_3 and var_10_1 or var_10_3
	arg_10_0.progressBar_.value = var_10_3 / var_10_1
	arg_10_0.progressText_.text = string.format("%s/%s", var_10_3, var_10_1)
end

function var_0_0.RefreshItem(arg_11_0)
	arg_11_0.rewardCfg_ = AssignmentCfg[arg_11_0.taskID_].reward

	for iter_11_0 = 1, 3 do
		SetActive(arg_11_0[string.format("awardItem%sObj_", iter_11_0)], false)
	end

	for iter_11_1 = 1, #arg_11_0.rewardCfg_ do
		local var_11_0 = arg_11_0.rewardCfg_[iter_11_1]

		if not arg_11_0.rewardItemList_[iter_11_1] then
			arg_11_0.rewardItemList_[iter_11_1] = CommonItemView.New(arg_11_0[string.format("awardItem%sObj_", iter_11_1)])
		end

		arg_11_0.rewardItemList_[iter_11_1]:Show(true)

		if not arg_11_0.itemDataList_[iter_11_1] then
			arg_11_0.itemDataList_[iter_11_1] = clone(ItemTemplateData)
			arg_11_0.itemDataList_[iter_11_1].clickFun = function(arg_12_0)
				ShowPopItem(POP_ITEM, {
					arg_12_0.id,
					arg_12_0.number
				})
			end
		end

		local var_11_1 = true

		if var_11_0 then
			arg_11_0.itemDataList_[iter_11_1].id = var_11_0[1]
			arg_11_0.itemDataList_[iter_11_1].number = var_11_0[2]
			var_11_1 = false
		end

		if not var_11_1 then
			arg_11_0.rewardItemList_[iter_11_1]:SetData(arg_11_0.itemDataList_[iter_11_1])
		else
			arg_11_0.rewardItemList_[iter_11_1]:SetData(nil)
		end
	end
end

function var_0_0.RefreshState(arg_13_0)
	local var_13_0 = AssignmentCfg[arg_13_0.taskID_].need
	local var_13_1 = TaskData2:GetTask(arg_13_0.taskID_)
	local var_13_2 = var_13_0

	if var_13_1 and var_13_1.progress then
		var_13_2 = var_13_1.progress
	end

	local var_13_3 = var_13_0 <= var_13_2
	local var_13_4 = TaskData2:GetTaskComplete(arg_13_0.taskID_)

	if not var_13_3 then
		arg_13_0.rewardState_:SetSelectedState("lock")
	elseif not var_13_4 then
		arg_13_0.rewardState_:SetSelectedState("receive")
	else
		arg_13_0.rewardState_:SetSelectedState("complete")
	end

	for iter_13_0 = 1, #arg_13_0.rewardCfg_ do
		arg_13_0.rewardItemList_[iter_13_0]:RefreshGray(var_13_4)
	end
end

function var_0_0.SetReveivedHandler(arg_14_0, arg_14_1)
	arg_14_0.callBack_ = arg_14_1
end

function var_0_0.Show(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

return var_0_0
