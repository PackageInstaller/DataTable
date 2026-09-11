local StrongholdOperateRewardItem = class("StrongholdOperateRewardItem", ReduxView)

function StrongholdOperateRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StrongholdOperateRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdOperateRewardItem:InitUI()
	self:BindCfgUI()

	self.rewardItems_ = {}
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function StrongholdOperateRewardItem:AddUIListener()
	self:AddBtnListener(nil, self.m_rewardBtn, function()
		StrongholdAction.QueryReward(self.activity_id, {
			self.reward_id
		})
	end)
end

function StrongholdOperateRewardItem:SetData(arg_6_1, arg_6_2)
	self.activity_id = arg_6_1
	self.reward_id = arg_6_2

	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(ActivityStrongholdLevelCfg.get_id_list_by_type[ActivityStrongholdRewardCfg[self.reward_id].condition]) do
		if ActivityStrongholdLevelCfg[iter_6_1].level == ActivityStrongholdRewardCfg[self.reward_id].params[1] then
			var_6_0 = ActivityStrongholdLevelCfg[iter_6_1]
		end
	end

	self.m_des.text = string.format(GetTips("ACTIVITY_STRONGHOLD_REWARD_TIP"), GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. ActivityStrongholdRewardCfg[self.reward_id].condition), ActivityStrongholdRewardCfg[self.reward_id].params[1], var_6_0.level_des)

	local var_6_1, var_6_2, var_6_3, var_6_4 = StrongholdData:GetStrongholdLevel(ActivityStrongholdRewardCfg[self.reward_id].condition)

	self.m_processLab.text = math.min(var_6_2, ActivityStrongholdRewardCfg[self.reward_id].params[1]) .. "/" .. ActivityStrongholdRewardCfg[self.reward_id].params[1]
	self.m_process.fillAmount = math.min(var_6_2, ActivityStrongholdRewardCfg[self.reward_id].params[1]) / ActivityStrongholdRewardCfg[self.reward_id].params[1]

	for iter_6_2, iter_6_3 in ipairs(ActivityStrongholdRewardCfg[self.reward_id].reward or {}) do
		if self.rewardItems_[iter_6_2] == nil then
			self.rewardItems_[iter_6_2] = RewardItem.New(self.m_rewardItem, self.m_rewardParent)

			self.rewardItems_[iter_6_2]:UpdateCommonItemAni()
			self.rewardItems_[iter_6_2].commonItem_:RegistCallBack(function()
				OperationRecorder.Record("task", "task_item")
			end)
		end

		self.rewardItems_[iter_6_2]:SetData(iter_6_3)
	end

	for iter_6_4 = #ActivityStrongholdRewardCfg[self.reward_id].reward + 1, #self.rewardItems_ do
		self.rewardItems_[iter_6_4]:Show(false)
	end

	self.stateController:SetSelectedIndex((StrongholdData:GetRewardState(arg_6_1, arg_6_2)))
end

function StrongholdOperateRewardItem:Dispose()
	for iter_8_0, iter_8_1 in pairs(self.rewardItems_) do
		iter_8_1:Dispose()
	end

	self.rewardItems_ = {}

	StrongholdOperateRewardItem.super.Dispose(self)
end

return StrongholdOperateRewardItem
