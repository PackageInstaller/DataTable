local LimitedCalculationRewardView = class("LimitedCalculationRewardView", ReduxView)

function LimitedCalculationRewardView:UIName()
	return "UI/VersionUI/SummerUI/SummerIntegralRewardPop"
end

function LimitedCalculationRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function LimitedCalculationRewardView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function LimitedCalculationRewardView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, LimitedCalculationRewardItem)
end

function LimitedCalculationRewardView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.list_[arg_5_1], self.activityID_)
end

function LimitedCalculationRewardView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.getAllBtn_, nil, function()
		LimitedCalculationAction:GetAllRewardAction(self.activityID_)
	end)
end

function LimitedCalculationRewardView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function LimitedCalculationRewardView:RefreshUI()
	self:RefreshScore()
	self:RefreshList()
end

function LimitedCalculationRewardView:RefreshScore()
	self.score_ = LimitedCalculationData:GetScore(self.activityID_)
	self.title_.text = self.score_
end

function LimitedCalculationRewardView:RefreshList()
	self.list_ = {}

	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs((LimitedCalculationData:GetRewardList(self.activityID_))) do
		if iter_12_1.complete_flag <= 0 then
			if ActivityPointRewardCfg[iter_12_1.id].need <= self.score_ then
				table.insert(var_12_0, iter_12_1)
			else
				table.insert(var_12_1, iter_12_1)
			end
		else
			table.insert(var_12_2, iter_12_1)
		end
	end

	local function var_12_4(arg_13_0, arg_13_1)
		return arg_13_0.id < arg_13_1.id
	end

	table.sort(var_12_0, var_12_4)
	table.sort(var_12_1, var_12_4)
	table.sort(var_12_2, var_12_4)

	if var_12_0[1] == nil then
		SetActive(self.getAllBtn_.gameObject, false)
	else
		SetActive(self.getAllBtn_.gameObject, true)
	end

	table.insertto(self.list_, var_12_0)
	table.insertto(self.list_, var_12_1)
	table.insertto(self.list_, var_12_2)
	self.scrollHelper_:StartScroll(#self.list_)
end

function LimitedCalculationRewardView:OnReceivePointReward()
	self:RefreshList()
end

function LimitedCalculationRewardView:OnExit()
	for iter_15_0, iter_15_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_15_1:OnExit()
	end
end

function LimitedCalculationRewardView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	LimitedCalculationRewardView.super.Dispose(self)
end

return LimitedCalculationRewardView
