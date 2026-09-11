local BattleBossAdvanceRewardView = class("BattleBossAdvanceRewardView", ReduxView)

function BattleBossAdvanceRewardView:UIName()
	return "Widget/System/Challenge_Boss/BossIntegralRewardPop"
end

function BattleBossAdvanceRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function BattleBossAdvanceRewardView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.rewardUIList_ = LuaList.New(handler(self, self.RefreshItem), self.uiList_, BattleBossAdvanceRewardItem)
	self.refreshHandler_ = handler(self, self.RefreshScroll)
	self.stateCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("default0")
end

function BattleBossAdvanceRewardView:OnEnter()
	self.rewardUIList_:StartScroll(#BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward, 1)

	self.pointText_.text = GetTips("CURRENT_TOTAL_SCORE") .. BattleBossChallengeAdvanceData:GetTotalPoint()

	self:RefreshAllReceiveBtn()
	manager.notify:RegistListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, self.refreshHandler_)
end

function BattleBossAdvanceRewardView:OnExit()
	manager.notify:RemoveListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, self.refreshHandler_)
end

function BattleBossAdvanceRewardView:Dispose()
	BattleBossAdvanceRewardView.super.Dispose(self)

	self.refreshHandler_ = nil

	if self.rewardUIList_ then
		self.rewardUIList_:Dispose()

		self.rewardUIList_ = nil
	end
end

function BattleBossAdvanceRewardView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("BOSS_CHALLENGE_REWARD_TIPS"),
				OkCallback = function()
					self:ClickReceiveBtn()
				end
			})
		else
			self:ClickReceiveBtn()
		end
	end)
end

function BattleBossAdvanceRewardView:RefreshScroll()
	self.rewardUIList_:Refresh()
	self:RefreshAllReceiveBtn()
end

function BattleBossAdvanceRewardView:RefreshItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(BattleBossChallengeAdvanceData:GetSortRewardList()[arg_12_1])
end

function BattleBossAdvanceRewardView:RefreshAllReceiveBtn()
	local var_13_0 = BattleBossChallengeAdvanceData:GetTotalPoint()
	local var_13_1 = BattleBossChallengeAdvanceData:GetReceiveRewardList()

	for iter_13_0, iter_13_1 in ipairs(BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward) do
		if var_13_0 >= iter_13_1[1] and not table.keyof(var_13_1, iter_13_1[1]) then
			self.stateCon_:SetSelectedState("state0")

			return
		end
	end

	self.stateCon_:SetSelectedState("state1")
end

function BattleBossAdvanceRewardView:ClickReceiveBtn()
	BattleBossChallengeAction.RequireAllBossPointExchange(function(arg_15_0)
		if isSuccess(arg_15_0.result) then
			local var_15_0 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()]
			local var_15_1 = BattleBossChallengeAdvanceData:GetTotalPoint()
			local var_15_2 = BattleBossChallengeAdvanceData:GetReceiveRewardList()

			getReward((mergeReward(arg_15_0.item_list)))
			BattleBossChallengeAdvanceData:ModifyAllReceiveReward()
			manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
		else
			ShowTips(arg_15_0.result)
		end
	end)
end

return BattleBossAdvanceRewardView
