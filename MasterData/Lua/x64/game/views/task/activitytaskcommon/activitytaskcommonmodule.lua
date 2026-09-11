local ActivityTaskCommonModule = class("ActivityTaskCommonModule", ReduxView)

function ActivityTaskCommonModule:GetLevelIDList()
	return AssignmentCfg.get_id_list_by_activity_id[self.activityPointRewardActivityID_]
end

function ActivityTaskCommonModule:GetLevelInfo()
	local var_2_0 = self:GetLevelIDList()

	return TaskTools:GetFinishTaskNum(var_2_0), #var_2_0
end

function ActivityTaskCommonModule:UIName()
	return "Widget/Common/Com_Prefab/Com_Activity_RewardTrustUI"
end

function ActivityTaskCommonModule:SetActivityID()
	self.activityPointRewardActivityID_ = 1
end

function ActivityTaskCommonModule:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityTaskCommonModule:Init()
	self:InitUI()
	self:AddUIListener()
	self:SetActivityID()

	self.idList_ = self:GetLevelIDList()
	self.receiveList_ = {}
	self.showIdList_ = {}
	self.curLv_ = 0
	self.maxLv_ = 0
	self.levelLuaList_ = LuaList.New(handler(self, self.IndexItem), self.levelUilist_, ActivityTaskCommonItem)
	self.taskChangedHandler_ = handler(self, self.OnReceivePointReward)
	self.onekeyController_ = self.mainControllerEx_:GetController("onekey")
end

function ActivityTaskCommonModule:InitUI()
	self:BindCfgUI()
end

function ActivityTaskCommonModule:AddUIListener()
	self:AddBtnListener(self.receiveBtn_, nil, function()
		TaskAction:SubmitTaskList(self.receiveList_)
	end)
end

function ActivityTaskCommonModule:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.showIdList_[arg_10_1].id, self.showIdList_[arg_10_1].ind, self.showIdList_[arg_10_1].state)
end

function ActivityTaskCommonModule:BindRedPoint()
	return
end

function ActivityTaskCommonModule:OnEnter()
	manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, self.taskChangedHandler_)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:UpdateView()
	self:BindRedPoint()
end

function ActivityTaskCommonModule:UnbindRedPoint()
	return
end

function ActivityTaskCommonModule:OnExit()
	self:UnbindRedPoint()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(TASK_LIST_CHANGE_NOTIFY, self.taskChangedHandler_)
end

function ActivityTaskCommonModule:OnReceivePointReward()
	self:UpdateView()
end

function ActivityTaskCommonModule:SetLevelText()
	self.curLv_, self.maxLv_ = self:GetLevelInfo()
	self.levelText_.text = "<size=90><color=\"#F4D179\">" .. self.curLv_ .. "</color></size><color=\"#93847D\">/" .. self.maxLv_ .. "</color>"
end

function ActivityTaskCommonModule:UpdateView()
	self:SetLevelText()

	self.receiveList_ = {}
	self.showIdList_ = {}

	local var_17_0 = 1
	local var_17_1 = true

	for iter_17_0, iter_17_1 in ipairs(self.idList_) do
		local var_17_2 = TaskData2:GetTask(iter_17_1)
		local var_17_3 = "lock"

		if var_17_2.progress >= AssignmentCfg[iter_17_1].need then
			if var_17_2.complete_flag < 1 then
				table.insert(self.receiveList_, iter_17_1)

				var_17_3 = "receive"
				var_17_1 = false
			else
				var_17_3 = "complete"

				if var_17_1 then
					var_17_0 = iter_17_0 + 1
				end
			end
		end

		table.insert(self.showIdList_, {
			id = iter_17_1,
			ind = iter_17_0,
			state = var_17_3
		})
	end

	self.levelLuaList_:StartScroll(#self.showIdList_, var_17_0)
	self.onekeyController_:SetSelectedState(#self.receiveList_ > 0 and "true" or "false")
end

function ActivityTaskCommonModule:Dispose()
	ActivityTaskCommonModule.super.Dispose(self)

	if self.levelLuaList_ then
		self.levelLuaList_:Dispose()

		self.levelLuaList_ = nil
	end
end

return ActivityTaskCommonModule
