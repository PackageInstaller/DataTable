local var_0_0 = class("SnowballQuestItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.typeController = ControllerUtil.GetController(arg_2_0.transform_, "type")
	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "state")

	arg_2_0:AddBtnListenerScale(arg_2_0.btn_, nil, handler(arg_2_0, arg_2_0.SubmitQuest))

	if arg_2_0:UseUIListForRewards() then
		arg_2_0.rewardItems = LuaList.New(handler(arg_2_0, arg_2_0.RenderRewardListItem), arg_2_0.rewardListGo_, CommonItem)
	else
		arg_2_0.rewardItems = {}
	end
end

function var_0_0.UseUIListForRewards(arg_3_0)
	return arg_3_0.rewardListGo_ ~= nil
end

function var_0_0.SubmitQuest(arg_4_0)
	local var_4_0 = arg_4_0.taskID

	TaskAction:SubmitTask(var_4_0)
end

function var_0_0.RenderRewardListItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.cfg.reward[arg_5_1]

	arg_5_2:RefreshData(formatReward(var_5_0))
	arg_5_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_5_0)
		OperationRecorder.Record(RewardItem.__cname, "open_pop_item")
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.taskID = arg_7_1
	arg_7_0.taskActivityID = arg_7_2
	arg_7_0.info = TaskData2:GetTask(arg_7_1)
	arg_7_0.cfg = AssignmentCfg[arg_7_1]

	arg_7_0:RefreshReward()
	arg_7_0:RefreshTask()

	if arg_7_0.typeController then
		arg_7_0.typeController:SetSelectedState(arg_7_0.cfg.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY and "normal" or "challenge")
	end
end

function var_0_0.RefreshReward(arg_8_0)
	local var_8_0 = arg_8_0.cfg.reward

	if arg_8_0:UseUIListForRewards() then
		arg_8_0.rewardItems:StartScroll(#var_8_0)
	else
		local var_8_1 = #var_8_0

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if not arg_8_0.rewardItems[iter_8_0] then
				arg_8_0.rewardItems[iter_8_0] = RewardItem.New(arg_8_0.rewardItem_, arg_8_0.rewardParent_)

				arg_8_0.rewardItems[iter_8_0]:UpdateCommonItemAni()
			end

			arg_8_0.rewardItems[iter_8_0]:SetData(iter_8_1)
		end

		for iter_8_2 = var_8_1 + 1, #arg_8_0.rewardItems do
			arg_8_0.rewardItems[iter_8_2]:Show(false)
		end
	end
end

function var_0_0.RefreshTask(arg_9_0)
	arg_9_0.desc_.text = arg_9_0.cfg.desc

	local var_9_0 = 0

	if arg_9_0.info.progress >= arg_9_0.cfg.need then
		var_9_0 = arg_9_0.cfg.need
	else
		var_9_0 = arg_9_0.info.progress
	end

	arg_9_0.progress_.text = var_9_0 .. "/" .. arg_9_0.cfg.need
	arg_9_0.slider_.value = var_9_0 / arg_9_0.cfg.need

	if arg_9_0.info.complete_flag >= 1 then
		arg_9_0.stateController:SetSelectedState("received")
	elseif var_9_0 >= arg_9_0.cfg.need then
		arg_9_0.stateController:SetSelectedState("complete")
	else
		arg_9_0.stateController:SetSelectedState("unfinish")
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()

	if arg_10_0:UseUIListForRewards() then
		arg_10_0.rewardItems:Dispose()
	else
		for iter_10_0 = 1, #arg_10_0.rewardItems do
			arg_10_0.rewardItems[iter_10_0]:Dispose()
		end
	end

	arg_10_0.rewardItems = nil

	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
