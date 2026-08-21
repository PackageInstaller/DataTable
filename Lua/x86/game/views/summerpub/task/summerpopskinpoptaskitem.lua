local var_0_0 = class("SummerPopSkinPopTaskView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.taskid_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
	arg_2_0:InitReward()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = arg_3_0.exController_:GetController("all")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		arg_4_0:GetTaskReward(arg_4_0.taskid_)
	end)
end

function var_0_0.InitReward(arg_6_0)
	arg_6_0.rewardItemList_ = {}
	arg_6_0.itemDataList_ = {}

	local var_6_0 = AssignmentCfg[arg_6_0.taskid_]

	for iter_6_0, iter_6_1 in ipairs(var_6_0.reward) do
		arg_6_0.rewardItemList_[iter_6_0] = CommonItemView.New(arg_6_0.rewardPanelTrans_:GetChild(iter_6_0 - 1).transform:GetChild(0).gameObject, true)

		local var_6_1 = clone(ItemTemplateData)

		var_6_1.id = iter_6_1[1]
		var_6_1.number = iter_6_1[2]

		function var_6_1.clickFun(arg_7_0)
			ShowPopItem(POP_ITEM, {
				arg_7_0.id,
				arg_7_0.number
			})
		end

		var_6_1.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL
		arg_6_0.itemDataList_[iter_6_0] = var_6_1

		arg_6_0.rewardItemList_[iter_6_0]:SetData(var_6_1)
	end
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = AssignmentCfg[arg_8_0.taskid_]

	arg_8_0.taskTitle_.text = GetI18NText(var_8_0.desc)

	local var_8_1 = TaskData2:GetTaskComplete(arg_8_0.taskid_)
	local var_8_2 = TaskData2:GetTaskProgress(arg_8_0.taskid_)

	if var_8_1 then
		for iter_8_0 = 1, #arg_8_0.rewardItemList_ do
			local var_8_3 = arg_8_0.itemDataList_[iter_8_0]

			arg_8_0.rewardItemList_[iter_8_0]:SetData(var_8_3)

			arg_8_0.itemDataList_[iter_8_0] = var_8_3
		end

		arg_8_0.stateController_:SetSelectedState("complete")
	elseif var_8_2 >= var_8_0.need then
		arg_8_0.stateController_:SetSelectedState("receive")
	else
		arg_8_0.stateController_:SetSelectedState("lock")
	end
end

function var_0_0.GetTaskReward(arg_9_0, arg_9_1)
	local var_9_0 = false
	local var_9_1 = AssignmentCfg[arg_9_1]

	for iter_9_0, iter_9_1 in ipairs(var_9_1.reward) do
		local var_9_2 = iter_9_1[1]

		if ItemCfg[var_9_2].type == ItemConst.ITEM_TYPE.SCENE then
			TaskAction:SubmitTask(arg_9_1, function()
				arg_9_0:RefreshUI()
				ActivityAction.UpdateRedPointDLC_5_2(ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC)
				manager.notify:Invoke(SUMMER_RACE_SKIN_UPDATE_5_2)
			end)

			var_9_0 = true

			break
		end
	end

	if not var_9_0 then
		TaskAction:SubmitTask(arg_9_1, function()
			arg_9_0:RefreshUI()
			ActivityAction.UpdateRedPointDLC_5_2(ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC)
			manager.notify:Invoke(SUMMER_RACE_SKIN_UPDATE_5_2)
		end)
	end
end

function var_0_0.Dispose(arg_12_0)
	for iter_12_0 = 1, #arg_12_0.rewardItemList_ do
		arg_12_0.rewardItemList_[iter_12_0]:Dispose()
	end

	arg_12_0.rewardItemList_ = nil
	arg_12_0.itemDataList_ = nil

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
