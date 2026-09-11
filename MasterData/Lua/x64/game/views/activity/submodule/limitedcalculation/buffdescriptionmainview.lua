local BuffDescriptionMainView = class("BuffDescriptionMainView", ReduxView)

function BuffDescriptionMainView:UIName()
	return "UI/VersionUI/SummerUI/SummerPlayerAffixesPop"
end

function BuffDescriptionMainView:UIParent()
	return manager.ui.uiPop.transform
end

function BuffDescriptionMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BuffDescriptionMainView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, BuffDescriptionView)
end

function BuffDescriptionMainView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.list_[arg_5_1], self.params_.type)
end

function BuffDescriptionMainView:AddUIListeners()
	self.scrollHelper_:SetPageChangeHandler(handler(self, self.OnPageChange))
	self:AddBtnListener(self.leftBtn_, nil, function()
		if self.pageIndex_ > 1 then
			self.pageIndex_ = self.pageIndex_ - 1

			self.scrollHelper_:SwitchToPage(self.pageIndex_)
		end
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		if self.pageIndex_ < self.maxLv_ then
			self.pageIndex_ = self.pageIndex_ + 1

			self.scrollHelper_:SwitchToPage(self.pageIndex_)
		end
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function BuffDescriptionMainView:OnPageChange(arg_10_1)
	self.pageIndex_ = arg_10_1

	self:RefreshBtn()
end

function BuffDescriptionMainView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.curdifficulty_ = LimitedCalculationData:GetCurDifficulty(self.activityID_)

	if self.params_.type == "buff" then
		self.list_ = LimitedCalculationTools.GetBuffList(self.activityID_)
	elseif self.params_.type == "debuff" then
		self.list_ = LimitedCalculationTools.GetDebuffList(self.activityID_)
	end

	local var_11_0 = table.indexof(self.list_, self.curdifficulty_)

	self.pageIndex_ = var_11_0 and var_11_0 or 1
	self.maxLv_ = #self.list_

	self:RefreshUI()
end

function BuffDescriptionMainView:RefreshUI()
	self.scrollHelper_:StartScroll(#self.list_, self.pageIndex_, true, false)
	self.scrollHelper_:SwitchToPage(self.pageIndex_)
	self:RefreshBtn()
end

function BuffDescriptionMainView:RefreshBtn()
	SetActive(self.leftBtn_.gameObject, self.pageIndex_ > 1)
	SetActive(self.rightBtn_.gameObject, self.pageIndex_ < self.maxLv_)
end

function BuffDescriptionMainView:OnTop()
	manager.windowBar:HideBar()
end

function BuffDescriptionMainView:OnExit()
	return
end

function BuffDescriptionMainView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	BuffDescriptionMainView.super.Dispose(self)
end

return BuffDescriptionMainView
