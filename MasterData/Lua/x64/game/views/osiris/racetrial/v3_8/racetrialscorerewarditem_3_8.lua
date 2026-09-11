local RaceTrialScoreRewardItem_3_8 = class("RaceTrialScoreRewardItem_3_8", RaceTrialScoreRewardItem)

function RaceTrialScoreRewardItem_3_8:InitUI()
	self:BindCfgUI()

	self.rewardList = {}

	for iter_1_0 = 1, 3 do
		self.rewardList[iter_1_0] = CommonItemView.New(self[string.format("rewardItem%d_", iter_1_0)])
	end

	self.controllers_ = self.transform_:GetComponent("ControllerExCollection")
	self.stateController = self.controllers_:GetController("status")
	self.itemCntController = self.controllers_:GetController("Reward")

	self:AddUIListeners()
end

function RaceTrialScoreRewardItem_3_8:DisposeRewardItems()
	for iter_2_0, iter_2_1 in pairs(self.rewardList) do
		iter_2_1:Dispose()
	end

	self.rewardList = nil
end

function RaceTrialScoreRewardItem_3_8:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveScoreReward(self.id)
	end)
end

function RaceTrialScoreRewardItem_3_8:RefreshUI(arg_5_1, arg_5_2, arg_5_3)
	self.id = arg_5_1
	self.activityID = arg_5_3

	for iter_5_0 = 1, 3 do
		if ActivityPointRewardCfg[arg_5_1].reward_item_list[iter_5_0] then
			self.rewardList[iter_5_0]:SetData((rewardToItemTemplate(formatReward(ActivityPointRewardCfg[arg_5_1].reward_item_list[iter_5_0]), nil, true)))
		else
			self.rewardList[iter_5_0]:SetData(nil)
		end
	end

	self.itemCntController:SetSelectedState(tostring((math.max(1, math.min(3, #ActivityPointRewardCfg[arg_5_1].reward_item_list)))))

	self.descText_.text = GetTips("ACCUMULATED_POINTS_REACHED") .. ActivityPointRewardCfg[arg_5_1].need

	if RaceTrialData:GetScoreRewardByID(arg_5_1).receive_flag then
		self.stateController:SetSelectedState("state3")
	elseif arg_5_2 >= ActivityPointRewardCfg[arg_5_1].need then
		self.stateController:SetSelectedState("state1")
	else
		self.stateController:SetSelectedState("state2")
	end
end

return RaceTrialScoreRewardItem_3_8
