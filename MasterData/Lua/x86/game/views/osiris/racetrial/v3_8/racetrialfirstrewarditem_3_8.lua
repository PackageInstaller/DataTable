local RaceTrialFirstRewardItem_3_8 = class("RaceTrialFirstRewardItem_3_8", RaceTrialFirstRewardItem)

function RaceTrialFirstRewardItem_3_8:InitUI()
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

function RaceTrialFirstRewardItem_3_8:DisposeRewardItems()
	for iter_2_0, iter_2_1 in pairs(self.rewardList) do
		iter_2_1:Dispose()
	end

	self.rewardList = nil
end

function RaceTrialFirstRewardItem_3_8:AddUIListeners()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.id) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:ReceiveFirstReward(self.mainActivityID, self.id)
	end)
end

function RaceTrialFirstRewardItem_3_8:RefreshUI(arg_5_1, arg_5_2)
	self.id = arg_5_1
	self.mainActivityID = arg_5_2

	local var_5_0 = RaceTrialData:GetBattleData(arg_5_1)

	for iter_5_0 = 1, 3 do
		if ActivityRaceTrialCfg[arg_5_1].reward_item_list[iter_5_0] then
			self.rewardList[iter_5_0]:SetData((rewardToItemTemplate(formatReward(ActivityRaceTrialCfg[arg_5_1].reward_item_list[iter_5_0]), nil, true)))
		else
			self.rewardList[iter_5_0]:SetData(nil)
		end
	end

	self.itemCntController:SetSelectedState(tostring((math.max(1, math.min(3, #ActivityRaceTrialCfg[arg_5_1].reward_item_list)))))

	self.descText_.text = GetI18NText(ActivityRaceTrialCfg[arg_5_1].reward_desc)

	if var_5_0.state == 1 then
		self.stateController:SetSelectedState("state2")
	elseif var_5_0.state == 2 then
		self.stateController:SetSelectedState("state1")
	elseif var_5_0.state == 3 then
		self.stateController:SetSelectedState("state3")
	end
end

return RaceTrialFirstRewardItem_3_8
