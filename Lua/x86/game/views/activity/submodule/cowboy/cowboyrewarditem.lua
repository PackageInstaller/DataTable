local var_0_0 = class("CowboyRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardBtn_ = {}
	arg_3_0.rewardCon_ = {}
	arg_3_0.rewardBoxs_ = {}
	arg_3_0.rewardNeed_ = {}
	arg_3_0.rewardPanel_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.rewardBtn_[iter_3_0] = arg_3_0["rewardBtn_" .. iter_3_0]
		arg_3_0.rewardCon_[iter_3_0] = ControllerUtil.GetController(arg_3_0.transform_, "reward_" .. iter_3_0)
		arg_3_0.rewardBoxs_[iter_3_0] = {}
		arg_3_0.rewardNeed_[iter_3_0] = arg_3_0["need_" .. iter_3_0]
		arg_3_0.rewardPanel_[iter_3_0] = arg_3_0["rewardPanel_" .. iter_3_0]
	end
end

function var_0_0.AddUIListeners(arg_4_0)
	for iter_4_0 = 1, 3 do
		arg_4_0:AddBtnListener(arg_4_0.rewardBtn_[iter_4_0], nil, function()
			CowboyAction:GetReward(arg_4_0.activityID_, arg_4_0.infos_[iter_4_0].point_id)
		end)
	end
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.mainActivityID_ = arg_7_1
	arg_7_0.activityID_ = arg_7_2

	arg_7_0:RefreshData()
	arg_7_0:RefreshReward()
	arg_7_0:RefreshState()
end

function var_0_0.RefreshData(arg_8_0)
	arg_8_0.data_ = CowboyData:GetData(arg_8_0.activityID_)
	arg_8_0.infos_ = arg_8_0.data_.reward

	local var_8_0 = ActivityCfg[arg_8_0.mainActivityID_].sub_activity_list
	local var_8_1 = table.indexof(var_8_0, arg_8_0.activityID_)

	arg_8_0.titleText_.text = string.format(GetTips("ACTIVITY_COWBOY_ROUND"), var_8_1)
end

function var_0_0.RefreshReward(arg_9_0)
	arg_9_0.rewardInfo_ = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_9_0.activityID_]

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.rewardInfo_) do
		local var_9_0 = ActivityPointRewardCfg[iter_9_1]
		local var_9_1 = var_9_0.reward_item_list

		arg_9_0.rewardNeed_[iter_9_0].text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_REACHED"), var_9_0.need)

		for iter_9_2, iter_9_3 in ipairs(var_9_1) do
			if not arg_9_0.rewardBoxs_[iter_9_0][iter_9_2] then
				arg_9_0.rewardBoxs_[iter_9_0][iter_9_2] = RewardItem.New(arg_9_0.rewardItem_, arg_9_0.rewardPanel_[iter_9_0], true)

				arg_9_0.rewardBoxs_[iter_9_0][iter_9_2]:UpdateCommonItemAni()
			end

			arg_9_0.rewardBoxs_[iter_9_0][iter_9_2]:SetData(iter_9_3)
		end

		for iter_9_4 = #var_9_1 + 1, #arg_9_0.rewardBoxs_[iter_9_0] do
			arg_9_0.rewardBoxs_[iter_9_0][iter_9_4]:Show(false)
		end
	end
end

function var_0_0.RefreshState(arg_10_0)
	local var_10_0 = arg_10_0.data_.score

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.infos_) do
		if iter_10_1.point_reward_state == 2 then
			arg_10_0.rewardCon_[iter_10_0]:SetSelectedState("rewarded")
		elseif var_10_0 >= ActivityPointRewardCfg[iter_10_1.point_id].need then
			arg_10_0.rewardCon_[iter_10_0]:SetSelectedState("success")
		else
			arg_10_0.rewardCon_[iter_10_0]:SetSelectedState("unfinished")
		end
	end
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.rewardBoxs_) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			iter_12_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
