local var_0_0 = class("BattleBossAdvanceRewardItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.rewardPanel_ = {}
	arg_1_0.rewardList_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.rewardPanel_[iter_1_0] = arg_1_0[string.format("rewardItem%s_", iter_1_0)]
		arg_1_0.rewardList_[iter_1_0] = CommonItemView.New(arg_1_0.rewardPanel_[iter_1_0])
	end

	arg_1_0.controller_ = arg_1_0.transform_:GetComponent("ControllerExCollection"):GetController("status")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.rewardList_) do
		iter_2_1:Dispose()
	end

	arg_2_0.rewardList_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		local var_4_0 = BattleBossChallengeAdvanceData:GetChooseModeID()
		local var_4_1 = BossChallengeAdvanceCfg[var_4_0].reward[arg_3_0.index_]

		if table.keyof(BattleBossChallengeAdvanceData:GetReceiveRewardList(), var_4_1[1]) or var_4_1[1] > BattleBossChallengeAdvanceData:GetTotalPoint() then
			return
		end

		if #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("BOSS_CHALLENGE_REWARD_TIPS"),
				OkCallback = function()
					arg_3_0:ClickItem()
				end
			})
		else
			arg_3_0:ClickItem()
		end
	end)
end

function var_0_0.ClickItem(arg_6_0)
	local var_6_0 = BattleBossChallengeAdvanceData:GetChooseModeID()
	local var_6_1 = BossChallengeAdvanceCfg[var_6_0].reward[arg_6_0.index_]

	BattleBossChallengeAction.RequireBossPointExchange(var_6_1[1], function(arg_7_0)
		if isSuccess(arg_7_0.result) then
			getReward2(arg_7_0.item_list)
			BattleBossChallengeAdvanceData:ModifyReceiveReward(var_6_1[1])
			manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.index_ = arg_8_1

	local var_8_0 = BattleBossChallengeAdvanceData:GetChooseModeID()
	local var_8_1 = BossChallengeAdvanceCfg[var_8_0].reward[arg_8_1]

	arg_8_0.descText_.text = string.format(GetTips("CHALLENGE_MAX_POINT"), var_8_1[1])

	if table.keyof(BattleBossChallengeAdvanceData:GetReceiveRewardList(), var_8_1[1]) then
		arg_8_0.controller_:SetSelectedState("state3")
	elseif var_8_1[1] <= BattleBossChallengeAdvanceData:GetTotalPoint() then
		arg_8_0.controller_:SetSelectedState("state1")
	else
		arg_8_0.controller_:SetSelectedState("state2")
	end

	local var_8_2 = getRewardFromDropCfg(var_8_1[2], true)

	for iter_8_0, iter_8_1 in pairs(var_8_2) do
		local var_8_3

		var_8_3.clickFun, var_8_3 = function(arg_9_0)
			ShowPopItem(POP_ITEM, arg_9_0)
		end, rewardToItemTemplate(iter_8_1)

		CommonTools.SetCommonData(arg_8_0.rewardList_[iter_8_0], var_8_3)
	end

	for iter_8_2 = #var_8_2 + 1, #arg_8_0.rewardList_ do
		arg_8_0.rewardList_[iter_8_2]:SetData()
	end
end

return var_0_0
