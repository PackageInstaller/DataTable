local var_0_0 = class("HeroClueTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitRewardItem()

	arg_2_0.statusController_ = arg_2_0.controllerEx_:GetController("state")
end

function var_0_0.InitRewardItem(arg_3_0)
	arg_3_0.rewardItemList_ = {}
	arg_3_0.itemDataList_ = {}

	local var_3_0 = arg_3_0.rewardPanelTrans_.childCount

	for iter_3_0 = 1, var_3_0 do
		local var_3_1 = arg_3_0.rewardPanelTrans_:GetChild(iter_3_0 - 1)

		arg_3_0.rewardItemList_[iter_3_0] = CommonItemView.New(var_3_1.gameObject)
		arg_3_0.itemDataList_[iter_3_0] = clone(ItemTemplateData)
		arg_3_0.itemDataList_[iter_3_0].clickFun = function(arg_4_0)
			ShowPopItem(POP_ITEM, {
				arg_4_0.id,
				arg_4_0.number
			})
		end
	end
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			arg_5_0.taskID_
		})
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.taskID_ = arg_7_1
	arg_7_0.activityID_ = arg_7_2
	arg_7_0.index_ = arg_7_3
	arg_7_0.taskProgress_ = TaskData2:GetTask(arg_7_1).progress
	arg_7_0.taskComplete_ = TaskData2:GetTaskComplete(arg_7_1)

	arg_7_0:RefreshUI()
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.rewardItemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.rewardItemList_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshReward()
	arg_9_0:RefreshProgress()
	arg_9_0:RefreshState()
	arg_9_0:RefreshDesc()
	arg_9_0:RefreshIndex()
end

function var_0_0.RefreshReward(arg_10_0)
	local var_10_0 = AssignmentCfg[arg_10_0.taskID_].reward or {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		arg_10_0.itemDataList_[iter_10_0].id = iter_10_1[1]
		arg_10_0.itemDataList_[iter_10_0].number = iter_10_1[2]

		arg_10_0.rewardItemList_[iter_10_0]:SetData(arg_10_0.itemDataList_[iter_10_0])
	end
end

function var_0_0.RefreshProgress(arg_11_0)
	local var_11_0 = AssignmentCfg[arg_11_0.taskID_]
	local var_11_1 = arg_11_0.taskProgress_

	if arg_11_0.taskProgress_ > var_11_0.need then
		local var_11_2 = var_11_0.need
	end
end

function var_0_0.RefreshState(arg_12_0)
	local var_12_0 = AssignmentCfg[arg_12_0.taskID_]
	local var_12_1 = arg_12_0.taskProgress_ >= var_12_0.need

	if arg_12_0.taskComplete_ == true then
		arg_12_0.statusController_:SetSelectedState("received")
	elseif var_12_1 then
		arg_12_0.statusController_:SetSelectedState("complete")
	else
		arg_12_0.statusController_:SetSelectedState("unfinish")
	end
end

function var_0_0.RefreshDesc(arg_13_0)
	local var_13_0 = AssignmentCfg[arg_13_0.taskID_]

	arg_13_0.descText_.text = var_13_0.desc
end

function var_0_0.RefreshIndex(arg_14_0)
	local var_14_0 = tostring(arg_14_0.index_)

	if arg_14_0.index_ < 10 then
		var_14_0 = "0" .. var_14_0
	end

	arg_14_0.indexText_.text = var_14_0
end

return var_0_0
