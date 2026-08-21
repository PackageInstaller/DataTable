local var_0_0 = class("BattleBossAdvanceRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Boss/BossIntegralRewardPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.rewardUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, BattleBossAdvanceRewardItem)
	arg_3_0.refreshHandler_ = handler(arg_3_0, arg_3_0.RefreshScroll)
	arg_3_0.stateCon_ = arg_3_0.transform_:GetComponent("ControllerExCollection"):GetController("default0")
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = BattleBossChallengeAdvanceData:GetChooseModeID()

	arg_4_0.rewardUIList_:StartScroll(#BossChallengeAdvanceCfg[var_4_0].reward, 1)

	local var_4_1 = BattleBossChallengeAdvanceData:GetTotalPoint()

	arg_4_0.pointText_.text = GetTips("CURRENT_TOTAL_SCORE") .. var_4_1

	arg_4_0:RefreshAllReceiveBtn()
	manager.notify:RegistListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, arg_4_0.refreshHandler_)
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, arg_5_0.refreshHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.refreshHandler_ = nil

	if arg_6_0.rewardUIList_ then
		arg_6_0.rewardUIList_:Dispose()

		arg_6_0.rewardUIList_ = nil
	end
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.maskBtn_, nil, function()
		arg_7_0:Back()
	end)
	arg_7_0:AddBtnListener(arg_7_0.receiveBtn_, nil, function()
		if #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("BOSS_CHALLENGE_REWARD_TIPS"),
				OkCallback = function()
					arg_7_0:ClickReceiveBtn()
				end
			})
		else
			arg_7_0:ClickReceiveBtn()
		end
	end)
end

function var_0_0.RefreshScroll(arg_11_0)
	arg_11_0.rewardUIList_:Refresh()
	arg_11_0:RefreshAllReceiveBtn()
end

function var_0_0.RefreshItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = BattleBossChallengeAdvanceData:GetSortRewardList()

	arg_12_2:SetData(var_12_0[arg_12_1])
end

function var_0_0.RefreshAllReceiveBtn(arg_13_0)
	local var_13_0 = BattleBossChallengeAdvanceData:GetChooseModeID()
	local var_13_1 = BossChallengeAdvanceCfg[var_13_0]
	local var_13_2 = BattleBossChallengeAdvanceData:GetTotalPoint()
	local var_13_3 = BattleBossChallengeAdvanceData:GetReceiveRewardList()

	for iter_13_0, iter_13_1 in ipairs(var_13_1.reward) do
		if var_13_2 >= iter_13_1[1] and not table.keyof(var_13_3, iter_13_1[1]) then
			arg_13_0.stateCon_:SetSelectedState("state0")

			return
		end
	end

	arg_13_0.stateCon_:SetSelectedState("state1")
end

function var_0_0.ClickReceiveBtn(arg_14_0)
	BattleBossChallengeAction.RequireAllBossPointExchange(function(arg_15_0)
		if isSuccess(arg_15_0.result) then
			local var_15_0 = BattleBossChallengeAdvanceData:GetChooseModeID()
			local var_15_1 = BossChallengeAdvanceCfg[var_15_0]
			local var_15_2 = BattleBossChallengeAdvanceData:GetTotalPoint()
			local var_15_3 = BattleBossChallengeAdvanceData:GetReceiveRewardList()
			local var_15_4 = mergeReward(arg_15_0.item_list)

			getReward(var_15_4)
			BattleBossChallengeAdvanceData:ModifyAllReceiveReward()
			manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
		else
			ShowTips(arg_15_0.result)
		end
	end)
end

return var_0_0
