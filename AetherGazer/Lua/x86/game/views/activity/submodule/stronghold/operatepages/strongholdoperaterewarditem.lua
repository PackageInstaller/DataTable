local var_0_0 = class("StrongholdOperateRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItems_ = {}
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_rewardBtn, function()
		StrongholdAction.QueryReward(arg_4_0.activity_id, {
			arg_4_0.reward_id
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.activity_id = arg_6_1
	arg_6_0.reward_id = arg_6_2

	local var_6_0 = ActivityStrongholdRewardCfg[arg_6_0.reward_id]
	local var_6_1 = var_6_0.condition
	local var_6_2 = var_6_0.params[1]
	local var_6_3
	local var_6_4 = ActivityStrongholdLevelCfg.get_id_list_by_type[var_6_1]

	for iter_6_0, iter_6_1 in ipairs(var_6_4) do
		if ActivityStrongholdLevelCfg[iter_6_1].level == var_6_2 then
			var_6_3 = ActivityStrongholdLevelCfg[iter_6_1]
		end
	end

	local var_6_5 = GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. var_6_1)

	arg_6_0.m_des.text = string.format(GetTips("ACTIVITY_STRONGHOLD_REWARD_TIP"), var_6_5, var_6_2, var_6_3.level_des)

	local var_6_6, var_6_7, var_6_8, var_6_9 = StrongholdData:GetStrongholdLevel(var_6_1)

	arg_6_0.m_processLab.text = math.min(var_6_7, var_6_2) .. "/" .. var_6_2
	arg_6_0.m_process.fillAmount = math.min(var_6_7, var_6_2) / var_6_2

	local var_6_10 = var_6_0.reward or {}

	for iter_6_2, iter_6_3 in ipairs(var_6_10) do
		if arg_6_0.rewardItems_[iter_6_2] == nil then
			arg_6_0.rewardItems_[iter_6_2] = RewardItem.New(arg_6_0.m_rewardItem, arg_6_0.m_rewardParent)

			arg_6_0.rewardItems_[iter_6_2]:UpdateCommonItemAni()
			arg_6_0.rewardItems_[iter_6_2].commonItem_:RegistCallBack(function()
				OperationRecorder.Record("task", "task_item")
			end)
		end

		arg_6_0.rewardItems_[iter_6_2]:SetData(iter_6_3)
	end

	for iter_6_4 = #var_6_0.reward + 1, #arg_6_0.rewardItems_ do
		arg_6_0.rewardItems_[iter_6_4]:Show(false)
	end

	local var_6_11 = StrongholdData:GetRewardState(arg_6_1, arg_6_2)

	arg_6_0.stateController:SetSelectedIndex(var_6_11)
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.rewardItems_) do
		iter_8_1:Dispose()
	end

	arg_8_0.rewardItems_ = {}

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
