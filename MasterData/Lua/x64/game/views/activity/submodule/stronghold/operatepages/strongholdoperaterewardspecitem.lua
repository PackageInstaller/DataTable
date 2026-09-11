local StrongholdOperateSpecRewardItem = class("StrongholdOperateSpecRewardItem", ReduxView)

function StrongholdOperateSpecRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StrongholdOperateSpecRewardItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdOperateSpecRewardItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function StrongholdOperateSpecRewardItem:AddUIListener()
	self:AddBtnListener(nil, self.m_rewardBtn, function()
		local var_5_0 = StrongholdData:GetRewardState(self.activity_id, self.reward_id)

		if var_5_0 == 0 then
			StrongholdAction.QueryReward(self.activity_id, {
				self.reward_id
			})
		elseif var_5_0 == 1 then
			ShowTips("ACTIVITY_STRONGHOLD_REWARD_FAIL")
		end
	end)
	self:AddBtnListener(nil, self.m_iconBtn, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.item_id,
			1
		})
	end)
end

function StrongholdOperateSpecRewardItem:SetData(arg_7_1, arg_7_2)
	self.activity_id = arg_7_1
	self.reward_id = arg_7_2

	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(ActivityStrongholdLevelCfg.get_id_list_by_type[ActivityStrongholdRewardCfg[self.reward_id].condition]) do
		if ActivityStrongholdLevelCfg[iter_7_1].level == ActivityStrongholdRewardCfg[self.reward_id].params[1] then
			var_7_0 = ActivityStrongholdLevelCfg[iter_7_1]
		end
	end

	self.m_des.text = string.format(GetTips("ACTIVITY_STRONGHOLD_REWARD_TIP"), GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. ActivityStrongholdRewardCfg[self.reward_id].condition), ActivityStrongholdRewardCfg[self.reward_id].params[1], var_7_0.level_des)

	self.stateController:SetSelectedIndex((StrongholdData:GetRewardState(arg_7_1, arg_7_2)))

	self.item_id = ActivityStrongholdRewardCfg[self.reward_id].reward[1][1]

	if ItemCfg[ActivityStrongholdRewardCfg[self.reward_id].reward[1][1]] then
		self.m_icon.sprite = ItemTools.getItemSprite(ActivityStrongholdRewardCfg[self.reward_id].reward[1][1])
		self.m_title.text = ItemTools.getItemName(ActivityStrongholdRewardCfg[self.reward_id].reward[1][1])
	end
end

return StrongholdOperateSpecRewardItem
