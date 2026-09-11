local InfinityTaskBaseView = class("InfinityTaskBaseView", ReduxView)

function InfinityTaskBaseView:UIName()
	return "UI/OsirisUI/OsirisUITaskUI"
end

function InfinityTaskBaseView:GetTaskViewClass()
	return ActivityTaskBaseView
end

function InfinityTaskBaseView:GetInfinityPoolViewClass()
	return ActivityInfinityBaseView
end

function InfinityTaskBaseView:GetInfinityPoolItemID()
	return CurrencyConst.CURRENCY_TYPE_OSIRIS_INFINITY_COIN
end

function InfinityTaskBaseView:GetHelpTips()
	return "ACTIVITY_OSIRIS_INFINITY_POOL_DESCRIPE"
end

function InfinityTaskBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function InfinityTaskBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.viewList_ = {}
	self.controller_ = {}

	for iter_7_0 = 1, 5 do
		self.controller_[iter_7_0] = ControllerUtil.GetController(self[string.format("transformTreeItem%s_", iter_7_0)], "lock")
	end

	self.refreshTreeItemHandler_ = handler(self, self.RefreshInfinityBtn)
	self.toggleUpdateHandler_ = handler(self, self.OnToggleUpdate)
	self.toggleListView_ = ToggleListView.New(self.goToggleList_, {
		0,
		5
	})
end

function InfinityTaskBaseView:OnEnter()
	manager.notify:RegistListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, self.refreshTreeItemHandler_)
	manager.notify:RegistListener(TOGGLE_LIST_UPDATE, self.toggleUpdateHandler_)

	for iter_8_0, iter_8_1 in pairs(self.viewList_) do
		iter_8_1:OnEnter()
	end

	self.toggleListView_:OnEnter()

	if self.params_.activityType == OsirisConst.ACTIVITY_TYPE.TASK then
		self.toggleListView_:SetSelectOn(1)
	else
		self.toggleListView_:SetSelectOn(2, OsirisInfinityPoolData:GetClickPhaseValue(self.params_.activityInfinityID))
		self:ChangeSelect(2)
	end

	manager.redPoint:bindUIandKey(self.transformTask_, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.params_.activityTaskID), {
		x = 0,
		y = 0
	})
	self:RefreshInfinityBtn()
end

function InfinityTaskBaseView:OnTop()
	if self.curActivityType ~= self.params_.activityType then
		if self.params_.activityType == OsirisConst.ACTIVITY_TYPE.TASK then
			self.toggleListView_:SetSelectOn(1)
		else
			self.toggleListView_:SetSelectOn(2, OsirisInfinityPoolData:GetClickPhaseValue(self.params_.activityInfinityID))
			self:ChangeSelect(2)
		end
	end
end

function InfinityTaskBaseView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, self.refreshTreeItemHandler_)
	manager.notify:RemoveListener(TOGGLE_LIST_UPDATE, self.toggleUpdateHandler_)
	manager.redPoint:unbindUIandKey(self.transformTask_, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, self.params_.activityTaskID), {
		x = 0,
		y = 0
	})

	for iter_10_0, iter_10_1 in pairs(self.viewList_) do
		iter_10_1:OnExit()
	end

	self.toggleListView_:OnExit()
end

function InfinityTaskBaseView:Dispose()
	InfinityTaskBaseView.super.Dispose(self)
	self.toggleListView_:Dispose()

	self.toggleListView_ = nil
	self.refreshTreeItemHandler_ = nil
	self.toggleUpdateHandler_ = nil

	for iter_11_0, iter_11_1 in pairs(self.viewList_) do
		iter_11_1:Dispose()
	end

	self.viewList_ = nil
end

function InfinityTaskBaseView:AddListeners()
	return
end

function InfinityTaskBaseView:RefreshInfinityBtn()
	local var_13_0 = OsirisInfinityPoolData:GetOpenPhase(self.params_.activityInfinityID)

	for iter_13_0 = 1, 5 do
		self.controller_[iter_13_0]:SetSelectedState(iter_13_0 <= var_13_0 and "false" or "true")
	end
end

function InfinityTaskBaseView:OnToggleUpdate(arg_14_1, arg_14_2)
	self:ChangeSelect(arg_14_1)

	if arg_14_1 == 2 and arg_14_2 == nil then
		self.toggleListView_:SetSelectOn(2, OsirisInfinityPoolData:GetClickPhaseValue(self.params_.activityInfinityID))

		return
	end

	if self.viewList_[arg_14_1] == nil then
		self.viewList_[arg_14_1] = arg_14_1 == 1 and self:GetTaskViewClass().New(self.goContent_, self.params_.activityTaskID) or self:GetInfinityPoolViewClass().New(self.goContent_, self.params_.activityInfinityID)
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		self:GetInfinityPoolItemID()
	})
	manager.windowBar:SetBarCanAdd(self:GetInfinityPoolItemID(), true)
	manager.windowBar:SetGameHelpKey(self:GetHelpTips())

	for iter_14_0, iter_14_1 in pairs(self.viewList_) do
		iter_14_1:Show(iter_14_0 == arg_14_1)
	end

	if arg_14_2 then
		local var_14_0 = OsirisInfinityPoolData:GetOpenPhase(self.params_.activityInfinityID)

		if var_14_0 < arg_14_2 then
			local var_14_1 = OsirisInfinityPoolData:GetClickPhaseValue(self.params_.activityInfinityID)

			self.toggleListView_:SetSelectOn(2, var_14_0 < var_14_1 and var_14_0 or var_14_1)
			ShowTips("INFINITY_LOCK")

			return
		end

		OsirisInfinityPoolData:SetClickPhaseValue(self.params_.activityInfinityID, arg_14_2)
		self.viewList_[2]:SetPhase(arg_14_2)
	end
end

function InfinityTaskBaseView:ChangeSelect(arg_15_1)
	self.curActivityType = arg_15_1
	self.params_.activityType = arg_15_1
end

return InfinityTaskBaseView
