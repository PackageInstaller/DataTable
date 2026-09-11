local PassportBuyLevelItemView = class("PassportBuyLevelItemView", ReduxView)

function PassportBuyLevelItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PassportBuyLevelItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PassportBuyLevelItemView:InitUI()
	self:BindCfgUI()

	self.list_ = LuaList.New(handler(self, self.indexItem), self.listGo_, CommonItem)
end

function PassportBuyLevelItemView:indexItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshData({
		id = self.rewards_[arg_4_1].id,
		number = self.rewards_[arg_4_1].num
	})
end

function PassportBuyLevelItemView:AddUIListener()
	return
end

function PassportBuyLevelItemView:OnEnter()
	return
end

function PassportBuyLevelItemView:OnExit()
	return
end

function PassportBuyLevelItemView:SetIndex(arg_8_1)
	self.index_ = arg_8_1

	self:UpdateView()
end

function PassportBuyLevelItemView:UpdateView()
	local var_9_0 = PassportData:GetLevel() + self.index_

	self.levelLabel_.text = string.format(GetTips("BATTLEPASS_LEVEL_UNLOCK_REWARD"), var_9_0)
	self.rewards_ = {}

	local var_9_1 = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type][var_9_0]

	for iter_9_0, iter_9_1 in ipairs(BattlePassCfg[var_9_1].reward_free) do
		table.insert(self.rewards_, iter_9_1)
	end

	if PassportData:GetPayLevel() > 0 then
		for iter_9_2, iter_9_3 in ipairs(BattlePassCfg[var_9_1].reward_pay) do
			table.insert(self.rewards_, iter_9_3)
		end
	end

	self.rewards_ = mergeReward((formatRewardCfgList(self.rewards_)))

	self.list_:StartScroll(#self.rewards_)
end

function PassportBuyLevelItemView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	PassportBuyLevelItemView.super.Dispose(self)
end

return PassportBuyLevelItemView
