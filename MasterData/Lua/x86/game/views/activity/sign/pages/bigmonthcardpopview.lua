local BigMonthCardPopView = class("BigMonthCardPopView", ReduxView)

function BigMonthCardPopView:UIName()
	return "Widget/System/ActivitySign/BigMonthCard/BigMonthcardPop"
end

function BigMonthCardPopView:UIParent()
	return manager.ui.uiPop.transform
end

function BigMonthCardPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function BigMonthCardPopView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, BigMonthCardPopItem)
end

function BigMonthCardPopView:IndexItem(arg_5_1, arg_5_2)
	local var_5_0 = BigMonthCardData:GetRecord()
	local var_5_1 = self.list_[arg_5_1]
	local var_5_2 = clone(ItemTemplateData)

	var_5_2.id = self.list_[arg_5_1][1]
	var_5_2.number = self.list_[arg_5_1][2]

	function var_5_2.clickFun()
		ShowPopItem(POP_ITEM, {
			var_5_1[1]
		})
	end

	arg_5_2:RefreshData(var_5_2)
	arg_5_2:SetText(var_5_0[arg_5_1] and self.list_[arg_5_1][3] - var_5_0[arg_5_1] .. "/" .. self.list_[arg_5_1][3] or self.list_[arg_5_1][3] .. "/" .. self.list_[arg_5_1][3])
end

function BigMonthCardPopView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

function BigMonthCardPopView:OnEnter()
	self:RefreshUI()
end

function BigMonthCardPopView:RefreshUI()
	self.list_ = GameSetting.big_monthly_card_reward_daily.value

	self.scrollHelper_:StartScroll(#self.list_)
end

function BigMonthCardPopView:OnExit()
	manager.windowBar:HideBar()
end

function BigMonthCardPopView:Dispose()
	self:RemoveAllListeners()

	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.super.Dispose(self)
end

return BigMonthCardPopView
