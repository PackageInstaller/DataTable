local ValentineGameRewardView = class("ValentineGameRewardView", ReduxView)

function ValentineGameRewardView:UIName()
	return ValentineGameTools.GetRewardUIName(self.params_.activityID)
end

function ValentineGameRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function ValentineGameRewardView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ValentineGameRewardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ValentineGameRewardItem)
end

function ValentineGameRewardView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.list_[arg_5_1])
end

function ValentineGameRewardView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function ValentineGameRewardView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function ValentineGameRewardView:RefreshUI()
	self.list_ = {}

	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs(ActivityCfg[self.activityID_].sub_activity_list) do
		local var_9_3 = ValentineGameData:GetData(iter_9_1)

		if var_9_3 then
			if var_9_3.isReward then
				table.insert(var_9_2, iter_9_1)
			elseif var_9_3.isClear then
				table.insert(var_9_0, iter_9_1)
			else
				table.insert(var_9_1, iter_9_1)
			end
		else
			table.insert(var_9_1, iter_9_1)
		end
	end

	table.insertto(self.list_, var_9_0)
	table.insertto(self.list_, var_9_1)
	table.insertto(self.list_, var_9_2)
	self.scrollHelper_:StartScroll(#self.list_)
end

function ValentineGameRewardView:OnValentineGameReward()
	self:RefreshUI()
end

function ValentineGameRewardView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ValentineGameRewardView:OnExit()
	manager.windowBar:HideBar()
end

function ValentineGameRewardView:Dispose()
	self:RemoveAllListeners()

	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.super.Dispose(self)
end

return ValentineGameRewardView
