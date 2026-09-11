local LimitedCalculationDifficultyView = class("LimitedCalculationDifficultyView", ReduxView)

function LimitedCalculationDifficultyView:UIName()
	return "UI/VersionUI/SummerUI/SummerDifficultySelectionPop"
end

function LimitedCalculationDifficultyView:UIParent()
	return manager.ui.uiPop.transform
end

function LimitedCalculationDifficultyView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function LimitedCalculationDifficultyView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, DifficultySelectItem)
end

function LimitedCalculationDifficultyView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.activityID_, self.list_[arg_5_1])
	arg_5_2:SetSelected(self.curDifficulty_)
	arg_5_2:RegisterClickListener(function(arg_6_0)
		self.curDifficulty_ = arg_6_0

		self:Back()
	end)
end

function LimitedCalculationDifficultyView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function LimitedCalculationDifficultyView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function LimitedCalculationDifficultyView:RefreshUI()
	self.curDifficulty_ = LimitedCalculationData:GetCurDifficulty(self.activityID_)
	self.list_ = LimitedCalculationData:GetDifficultyList(self.activityID_)

	local var_10_0 = table.indexof(self.list_, self.curDifficulty_)

	if var_10_0 == 1 then
		self.scrollHelper_:StartScroll(#self.list_)
	else
		self.scrollHelper_:StartScroll(#self.list_, var_10_0 - 1)
	end
end

function LimitedCalculationDifficultyView:RefreshList()
	for iter_11_0, iter_11_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_11_1:SetSelected(self.curDifficulty_)
	end
end

function LimitedCalculationDifficultyView:OnExit()
	LimitedCalculationData:SetCurDifficulty(self.activityID_, self.curDifficulty_)
end

function LimitedCalculationDifficultyView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	LimitedCalculationDifficultyView.super.Dispose(self)
end

return LimitedCalculationDifficultyView
