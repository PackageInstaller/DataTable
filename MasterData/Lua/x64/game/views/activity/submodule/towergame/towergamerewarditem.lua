local TowerGameRewardBlock = class("TowerGameRewardBlock", ReduxView)

function TowerGameRewardBlock:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function TowerGameRewardBlock:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TowerGameRewardBlock:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.listgo_, FactorySoloChallengeRewardCommonItem)
	self.controller_ = ControllerUtil.GetController(self.transform_, "statu")
end

function TowerGameRewardBlock:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.rewradCfg_[arg_4_1], POP_ITEM)
end

function TowerGameRewardBlock:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		TowerGameACtion:GetReward(self.rewardpointid_)
	end)
end

function TowerGameRewardBlock:RefreshItem(arg_7_1, arg_7_2)
	self.index_ = arg_7_1
	self.levelid_ = arg_7_2
	self.rewardpointid_ = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_7_2][arg_7_1]
	self.cfg_ = ActivityPointRewardCfg[self.rewardpointid_]
	self.text_.text = string.format(GetTips("ACTIVITY_TOWER_DEFENSE_REWARD"), self.cfg_.need)

	self.controller_:SetSelectedState(TowerGameData:GetRewardStatuByLevelIDAndPointId(arg_7_2, self.rewardpointid_))

	self.rewradCfg_ = self.cfg_.reward_item_list

	self.list_:StartScroll(#self.rewradCfg_)
end

function TowerGameRewardBlock:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	TowerGameRewardBlock.super.Dispose(self)
end

return TowerGameRewardBlock
