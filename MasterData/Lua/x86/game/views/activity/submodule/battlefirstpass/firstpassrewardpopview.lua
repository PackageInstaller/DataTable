local FirstPassRewardPopView = class("FirstPassRewardPopView", ReduxView)

function FirstPassRewardPopView:UIName()
	return "UI/VersionUI/HellaUI/Pop/HellaQuestEewardsPop"
end

function FirstPassRewardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function FirstPassRewardPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function FirstPassRewardPopView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, FirstPassRewardItem)
end

function FirstPassRewardPopView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.activityID_, self.list_[arg_5_1])
end

function FirstPassRewardPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function FirstPassRewardPopView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshList()
end

function FirstPassRewardPopView:RefreshList()
	local var_9_0 = BattleFirstPassData:GetBattleFirstPassActivityData(self.activityID_).battleInfo

	if var_9_0 == nil then
		return
	end

	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = {}
	local var_9_4 = {}

	for iter_9_0, iter_9_1 in ipairs((BattleFirstPassData:GetBattleList(self.activityID_))) do
		if var_9_0[iter_9_1].battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED then
			table.insert(var_9_2, var_9_0[iter_9_1])
		elseif var_9_0[iter_9_1].battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.SUCCESS then
			table.insert(var_9_3, var_9_0[iter_9_1])
		elseif var_9_0[iter_9_1].battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.REWARDED then
			table.insert(var_9_4, var_9_0[iter_9_1])
		end
	end

	table.sort(var_9_2, function(arg_10_0, arg_10_1)
		return arg_10_0.battleID < arg_10_1.battleID
	end)
	table.sort(var_9_3, function(arg_11_0, arg_11_1)
		return arg_11_0.battleID < arg_11_1.battleID
	end)
	table.sort(var_9_4, function(arg_12_0, arg_12_1)
		return arg_12_0.battleID < arg_12_1.battleID
	end)
	table.insertto(var_9_1, var_9_3)
	table.insertto(var_9_1, var_9_2)
	table.insertto(var_9_1, var_9_4)

	self.list_ = var_9_1

	self.scrollHelper_:StartScroll(#self.list_)
end

function FirstPassRewardPopView:OnFirstReward()
	self:RefreshList()
end

function FirstPassRewardPopView:OnExit()
	return
end

function FirstPassRewardPopView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	FirstPassRewardPopView.super.Dispose(self)
end

return FirstPassRewardPopView
