local var_0_0 = class("NoobAdvanceTaskItem", ReduxView)
local var_0_1 = {
	"receive",
	"go",
	"lock",
	"complete"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.btnController_ = arg_1_0.allBtnController_:GetController("all")
	arg_1_0.rewardItems_ = {}
	arg_1_0.itemDataList_ = {}
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.rewardItems_) do
		iter_2_1:Dispose()
	end

	arg_2_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		if arg_3_0.curState_ ~= var_0_1[2] then
			return
		end

		local var_4_0 = AssignmentCfg[arg_3_0.taskID_]

		JumpTools.JumpToPage2(var_4_0.source)
	end)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		if arg_3_0.curState_ ~= var_0_1[1] then
			return
		end

		TaskAction:SubmitTask(arg_3_0.taskID_)
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.taskID_ = arg_6_1
	arg_6_0.maxRewardNum_ = arg_6_2

	arg_6_0:RefreshTitle()
	arg_6_0:RefreshProgress()
	arg_6_0:RefreshState()
	arg_6_0:RefreshReward(arg_6_1)
end

function var_0_0.RefreshTitle(arg_7_0)
	arg_7_0.titleText_.text = GetI18NText(AssignmentCfg[arg_7_0.taskID_].desc)
end

function var_0_0.RefreshProgress(arg_8_0)
	local var_8_0 = AssignmentCfg[arg_8_0.taskID_].need
	local var_8_1 = TaskData2:GetTask(arg_8_0.taskID_).progress or 0

	if var_8_0 < var_8_1 then
		var_8_1 = var_8_0
	end

	arg_8_0.progressText_.text = string.format("%s/%s", var_8_1, var_8_0)
	arg_8_0.progressBar_.value = var_8_1 / var_8_0
end

function var_0_0.RefreshReward(arg_9_0, arg_9_1)
	local var_9_0 = AssignmentCfg[arg_9_1].reward

	for iter_9_0 = 1, 3 do
		local var_9_1 = var_9_0[iter_9_0]

		if not arg_9_0.itemDataList_[iter_9_0] then
			arg_9_0.itemDataList_[iter_9_0] = clone(ItemTemplateData)
			arg_9_0.itemDataList_[iter_9_0].clickFun = function(arg_10_0)
				ShowPopItem(POP_ITEM, {
					arg_10_0.id,
					arg_10_0.number
				})
			end
		end

		local var_9_2 = true

		if var_9_1 then
			arg_9_0.itemDataList_[iter_9_0].id = var_9_1[1]
			arg_9_0.itemDataList_[iter_9_0].number = var_9_1[2]
			arg_9_0.itemDataList_[iter_9_0].grayFlag = arg_9_0.curState_ == var_0_1[4]
			var_9_2 = false
		end

		if arg_9_0.rewardItems_[iter_9_0] == nil then
			arg_9_0.rewardItems_[iter_9_0] = CommonItemView.New(arg_9_0[string.format("awardItem%dObj_", iter_9_0)])
		end

		arg_9_0.rewardItems_[iter_9_0]:Show(true)

		if not var_9_2 then
			arg_9_0.rewardItems_[iter_9_0]:SetData(arg_9_0.itemDataList_[iter_9_0])
		else
			arg_9_0.rewardItems_[iter_9_0]:SetData(nil)
		end
	end

	for iter_9_1 = arg_9_0.maxRewardNum_ + 1, #arg_9_0.rewardItems_ do
		arg_9_0.rewardItems_[iter_9_1]:Show(false)
	end
end

function var_0_0.RefreshState(arg_11_0)
	local var_11_0 = arg_11_0:GetItemState()

	arg_11_0.btnController_:SetSelectedState(var_11_0)
end

function var_0_0.GetItemState(arg_12_0)
	local var_12_0 = AssignmentCfg[arg_12_0.taskID_]
	local var_12_1 = TaskData2:GetTask(arg_12_0.taskID_)
	local var_12_2 = var_12_1.progress or 0

	if var_12_1.complete_flag >= 1 then
		arg_12_0.curState_ = var_0_1[4]
	elseif var_12_2 < var_12_0.need then
		arg_12_0.curState_ = var_0_1[2]
	else
		arg_12_0.curState_ = var_0_1[1]
	end

	return arg_12_0.curState_
end

return var_0_0
