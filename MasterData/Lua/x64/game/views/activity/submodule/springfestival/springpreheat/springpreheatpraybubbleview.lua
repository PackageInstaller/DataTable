local SpringPreheatPrayBubbleView = class("SpringPreheatPrayBubbleView", ReduxView)

function SpringPreheatPrayBubbleView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SpringPreheatPrayBubbleView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "locked")
	self.itemUiList_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, SpringPreheatPrayRewardItem)
end

function SpringPreheatPrayBubbleView:OnEnter()
	self:RefreshUI()
end

function SpringPreheatPrayBubbleView:OnExit()
	return
end

function SpringPreheatPrayBubbleView:Dispose()
	self.itemUiList_:Dispose()
	SpringPreheatPrayBubbleView.super.Dispose(self)
end

function SpringPreheatPrayBubbleView:AddListeners()
	if self.bgBtn_ then
		self:AddBtnListener(self.bgBtn_, nil, function()
			self:OnClick(true, self.day_)
		end)
	end
end

function SpringPreheatPrayBubbleView:RefreshUI()
	self.itemUiList_:StartScroll(#self.itemIdList_)
	self:SwitchController(self:GetDayState())
	self:RefreshDayText()
end

function SpringPreheatPrayBubbleView:RefreshDayText(arg_9_1)
	self.dayText_.text = arg_9_1 or GetTips(string.format("SPRING_PREHEAT_DAY_%d", self.day_))
end

function SpringPreheatPrayBubbleView:IndexItem(arg_10_1, arg_10_2)
	local var_10_0 = self.itemIdList_[arg_10_1]

	arg_10_2:SetClickHandler(function(arg_11_0)
		self:OnClick(false, self.day_, arg_11_0, var_10_0)
	end)
	arg_10_2:SwitchToGoSelect()
	arg_10_2:SetData(self.itemIdList_[arg_10_1])
end

function SpringPreheatPrayBubbleView:OnClick(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if self.onClickHandler_ then
		self.onClickHandler_(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	end
end

function SpringPreheatPrayBubbleView:SetClickHandler(arg_13_1)
	if arg_13_1 then
		self.onClickHandler_ = arg_13_1
	end
end

function SpringPreheatPrayBubbleView:RefreshItemUiList()
	self.itemUiList_:Refresh()
end

function SpringPreheatPrayBubbleView:UpdateItemIdList(arg_15_1)
	self.itemIdList_ = arg_15_1 and arg_15_1 or self:GetPraySelectionList()
end

function SpringPreheatPrayBubbleView:SwitchController(arg_16_1)
	if not self.selectController_ or not self.lockController_ then
		return
	end

	if arg_16_1 == 1 then
		self.selectController_:SetSelectedState("notready")
		self.lockController_:SetSelectedState("true")
	elseif arg_16_1 == 2 then
		self.selectController_:SetSelectedState("notready")
		self.lockController_:SetSelectedState("false")
	elseif arg_16_1 == 3 then
		self.selectController_:SetSelectedState("selecting")
	elseif arg_16_1 == 4 then
		self.selectController_:SetSelectedState("selected")
	end
end

function SpringPreheatPrayBubbleView:SetData(arg_17_1)
	self.day_ = arg_17_1

	self:UpdateItemIdList()
end

function SpringPreheatPrayBubbleView:GetDayText()
	return self.dayText_.text
end

function SpringPreheatPrayBubbleView:GetDayState()
	return (SpringPreheatData:GetDayState(self.day_))
end

function SpringPreheatPrayBubbleView:GetPraySelectionList()
	return SpringPreheatData:GetPraySelectionList(self.day_)
end

return SpringPreheatPrayBubbleView
