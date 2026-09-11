local BattleBossAdvanceRewardItem = class("BattleBossAdvanceRewardItem", ReduxView)

function BattleBossAdvanceRewardItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.rewardPanel_ = {}
	self.rewardList_ = {}

	for iter_1_0 = 1, 3 do
		self.rewardPanel_[iter_1_0] = self[string.format("rewardItem%s_", iter_1_0)]
		self.rewardList_[iter_1_0] = CommonItemView.New(self.rewardPanel_[iter_1_0])
	end

	self.controller_ = self.transform_:GetComponent("ControllerExCollection"):GetController("status")
end

function BattleBossAdvanceRewardItem:Dispose()
	BattleBossAdvanceRewardItem.super.Dispose(self)

	for iter_2_0, iter_2_1 in pairs(self.rewardList_) do
		iter_2_1:Dispose()
	end

	self.rewardList_ = nil
end

function BattleBossAdvanceRewardItem:AddListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		local var_4_0 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward[self.index_]

		if table.keyof(BattleBossChallengeAdvanceData:GetReceiveRewardList(), var_4_0[1]) or var_4_0[1] > BattleBossChallengeAdvanceData:GetTotalPoint() then
			return
		end

		if #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("BOSS_CHALLENGE_REWARD_TIPS"),
				OkCallback = function()
					self:ClickItem()
				end
			})
		else
			self:ClickItem()
		end
	end)
end

function BattleBossAdvanceRewardItem:ClickItem()
	local var_6_0 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward[self.index_]

	BattleBossChallengeAction.RequireBossPointExchange(var_6_0[1], function(arg_7_0)
		if isSuccess(arg_7_0.result) then
			getReward2(arg_7_0.item_list)
			BattleBossChallengeAdvanceData:ModifyReceiveReward(var_6_0[1])
			manager.notify:Invoke(BOSS_CHALLENGE_RECEIVE_STAR_REWARD)
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function BattleBossAdvanceRewardItem:SetData(arg_8_1)
	self.index_ = arg_8_1

	local var_8_0 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].reward[arg_8_1]

	self.descText_.text = string.format(GetTips("CHALLENGE_MAX_POINT"), var_8_0[1])

	if table.keyof(BattleBossChallengeAdvanceData:GetReceiveRewardList(), var_8_0[1]) then
		self.controller_:SetSelectedState("state3")
	elseif var_8_0[1] <= BattleBossChallengeAdvanceData:GetTotalPoint() then
		self.controller_:SetSelectedState("state1")
	else
		self.controller_:SetSelectedState("state2")
	end

	local var_8_1 = getRewardFromDropCfg(var_8_0[2], true)

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		local var_8_2 = rewardToItemTemplate(iter_8_1)

		function var_8_2.clickFun(arg_9_0)
			ShowPopItem(POP_ITEM, arg_9_0)
		end

		CommonTools.SetCommonData(self.rewardList_[iter_8_0], var_8_2)
	end

	for iter_8_2 = #var_8_1 + 1, #self.rewardList_ do
		self.rewardList_[iter_8_2]:SetData()
	end
end

return BattleBossAdvanceRewardItem
