local MultHeartDemonRewardView = class("MultHeartDemonRewardView", ReduxView)

function MultHeartDemonRewardView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_RewardUI"
end

function MultHeartDemonRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function MultHeartDemonRewardView:Init()
	self:InitUI()
	self:AddUIListener()

	self.OnSwitchLeftBtnTypeHandler_ = handler(self, self.OnSwitchLeftBtnType)
end

function MultHeartDemonRewardView:InitUI()
	self:BindCfgUI()

	self.normalList = LuaList.New(handler(self, self.SetRewardItem), self.list1_, MultHeartDemonRewardItem)
	self.rankList = LuaList.New(handler(self, self.SetRewardItem), self.list2_, MultHeartDemonRewardItem)
	self.controller = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.leftBtnList_ = {}

	for iter_4_0 = 1, 2 do
		self.leftBtnList_[iter_4_0] = StoreBtnView.New(self[string.format("leftBtnGo%s_", iter_4_0)], CommonBtnTypeConst.DEMON, iter_4_0)
	end
end

function MultHeartDemonRewardView:SetRewardItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(((self.selectIndex == 1 or nil) and (self.normalTaskList or self.rankTaskList))[arg_5_1], arg_5_1, self.selectIndex)
end

function MultHeartDemonRewardView:AddUIListener()
	self:AddBtnListener(self.allBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(self.normalTaskList) do
			table.insert(var_7_0, iter_7_1.id)
		end

		TaskTools:GetAllCanReciveTask(var_7_0)
	end)
end

function MultHeartDemonRewardView:UpdateView()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	self.normalTaskList = TaskData2:GetTypedTaskSortListCommonFilter(TaskConst.TASK_TYPE.MULT_HEART_NORMAL_TASK)

	if self.normalTaskList == nil or self.normalTaskList == {} then
		self.normalTaskList = TaskData2:GetActivityTaskSortList(self.activityId)
	end

	self.rankTaskList = MultHeartDemonData:GetDataByPara("rankTaskList")

	self:UpdateList()

	self.updateTimer_ = Timer.New(function()
		if not ActivityData:GetActivityIsOpen(self.activityId) then
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")
			self:Back()
			JumpTools.GoToSystem("/multHeartDemonMain", {
				activityId = self.activityId
			})
		end
	end, 1, -1, 1)

	self.updateTimer_:Start()
	SetActive(self.rankSelectGo_, self.selectIndex == 2)
	SetActive(self.normalSelectGo_, self.selectIndex == 1)
	self.controller:SetSelectedState(self:GetControllerState())
	self:RefreshLeftBtn()
end

function MultHeartDemonRewardView:GetControllerState()
	if self.selectIndex == 2 then
		return "message"
	else
		return self:IsShowAllReceiveBtn() and "receive" or "noReceive"
	end
end

function MultHeartDemonRewardView:GetDisplayList(arg_11_1)
	if arg_11_1 == 1 then
		return self.normalList, self.normalTaskList
	else
		return self.rankList, self.rankTaskList
	end
end

function MultHeartDemonRewardView:UpdateList()
	SetActive(self.list1_, self.selectIndex == 1)
	SetActive(self.list2_, self.selectIndex == 2)

	local var_12_0, var_12_1 = self:GetDisplayList(self.selectIndex)

	var_12_0:StartScroll(#var_12_1)
end

function MultHeartDemonRewardView:IsShowAllReceiveBtn()
	for iter_13_0, iter_13_1 in pairs((TaskData2:GetTypedTaskSortListCommonFilter(TaskConst.TASK_TYPE.MULT_HEART_NORMAL_TASK))) do
		if TaskData2:GetTaskProgress(iter_13_1.id) >= AssignmentCfg[iter_13_1.id].need and not TaskData2:GetTaskComplete(iter_13_1.id) then
			return true
		end
	end

	return false
end

function MultHeartDemonRewardView:OnMultDemonHeartRewardUpdate(arg_14_1)
	self.controller:SetSelectedState(self:GetControllerState())
	self:UpdateList()
end

function MultHeartDemonRewardView:OnEnter()
	self.selectIndex = self.params_.selectIndex or 1
	self.activityId = self.params_.activityId

	self:UpdateView()
	self:BindRedPoint()
	self:RegistEventListener(OSIRIS_TASK_UPDATE, function()
		self:UpdateView()
		MultHeartDemonAction.UpdateRewardRedPoint()
	end)
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchLeftBtnTypeHandler_)
end

function MultHeartDemonRewardView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.leftBtnGo1_.transform, RedPointConst.MULT_HEART_DEMON_REWARD)
end

function MultHeartDemonRewardView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.leftBtnGo1_.transform, RedPointConst.MULT_HEART_DEMON_REWARD)
end

function MultHeartDemonRewardView:OnExit()
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, self.OnSwitchLeftBtnTypeHandler_)
	self:RemoveAllEventListener()
	self:UnbindRedPoint()
	manager.windowBar:HideBar()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function MultHeartDemonRewardView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function MultHeartDemonRewardView:RefreshLeftBtn()
	for iter_21_0, iter_21_1 in pairs(self.leftBtnList_) do
		iter_21_1:RefreshUI(self.selectIndex)
	end
end

function MultHeartDemonRewardView:OnSwitchLeftBtnType(arg_22_1, arg_22_2)
	if arg_22_1 ~= CommonBtnTypeConst.DEMON or self.selectIndex == arg_22_2 then
		return
	end

	self.selectIndex = arg_22_2

	self:UpdateView()
end

function MultHeartDemonRewardView:Dispose()
	self.OnSwitchLeftBtnTypeHandler_ = nil

	for iter_23_0, iter_23_1 in pairs(self.leftBtnList_) do
		iter_23_1:Dispose()
	end

	self.leftBtnList_ = nil

	if self.normalList then
		self.normalList:Dispose()

		self.normalList = nil
	end

	if self.rankList then
		self.rankList:Dispose()

		self.rankList = nil
	end

	MultHeartDemonRewardView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return MultHeartDemonRewardView
