ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local PaChinKoEntranceView = class("PaChinKoEntranceView", ActivityMainBasePanel)

function PaChinKoEntranceView:GetUIName()
	return PaChinKoTools.GetEntranceUIName(self.activityID_)
end

function PaChinKoEntranceView:Init()
	PaChinKoEntranceView.super.Init(self)

	self.clearCon_ = self.taskPanelControllerEx_:GetController("clear")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, PaChinKoEntranceItem)

	self:BindHelpBtn(PaChinKoTools.GetDesc(self.activityID_), self.descBtn_)

	self.refreshTaskHandler_ = handler(self, self.RefreshTask)
end

function PaChinKoEntranceView:OnEnter()
	PaChinKoEntranceView.super.OnEnter(self)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.refreshTaskHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.refreshTaskHandler_)
	self:RefreshTask()
	manager.redPoint:bindUIandKey(self.playBtn_.transform, RedPointConst.ACTIVITY_PACHINKO .. "_" .. self.activityID_)
end

function PaChinKoEntranceView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.refreshTaskHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.refreshTaskHandler_)
	PaChinKoEntranceView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.playBtn_.transform, RedPointConst.ACTIVITY_PACHINKO .. "_" .. self.activityID_)
end

function PaChinKoEntranceView:Dispose()
	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil
	self.refreshTaskHandler_ = nil

	PaChinKoEntranceView.super.Dispose(self)
end

function PaChinKoEntranceView:AddListeners()
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(self.list_) do
			if iter_7_1 ~= 0 then
				local var_7_1 = TaskData2:GetTask(iter_7_1)

				if var_7_1.complete_flag < 1 and var_7_1.progress >= AssignmentCfg[iter_7_1].need then
					table.insert(var_7_0, iter_7_1)
				end
			end
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
	self:AddBtnListener(self.playBtn_, nil, function()
		JumpTools.OpenPageByJump("/paChinKoMain", {
			mainActivityID = self.activityID_
		})
	end)
end

function PaChinKoEntranceView:Show(arg_9_1)
	PaChinKoEntranceView.super.Show(self, arg_9_1)

	if arg_9_1 then
		self:RefreshTask()
	end
end

function PaChinKoEntranceView:UpdateBar()
	local var_10_0 = PaChinKoTools.GetCurrencyID(self.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_10_0
	})
	manager.windowBar:SetBarCanClick(var_10_0, true)
end

function PaChinKoEntranceView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:Refresh(self.list_[arg_11_1], self.activityID_)
end

function PaChinKoEntranceView:RefreshTask()
	local var_12_0 = PaChinKoTools.GetTaskActivityID(self.activityID_)

	self.list_ = {}

	local function var_12_1(arg_13_0, arg_13_1)
		if AssignmentCfg[arg_13_0].type ~= AssignmentCfg[arg_13_1].type then
			return AssignmentCfg[arg_13_0].type < AssignmentCfg[arg_13_1].type
		end

		return arg_13_0 < arg_13_1
	end

	local var_12_2 = {}
	local var_12_3 = {}
	local var_12_4 = {}

	for iter_12_0, iter_12_1 in pairs(TaskTools:GetActivityTaskList(var_12_0) or {}) do
		if AssignmentCfg[iter_12_1.id].activity_id == var_12_0 then
			if iter_12_1.complete_flag >= 1 then
				table.insert(var_12_4, iter_12_1.id)
			elseif iter_12_1.progress >= AssignmentCfg[iter_12_1.id].need then
				table.insert(var_12_2, iter_12_1.id)
			else
				table.insert(var_12_3, iter_12_1.id)
			end
		end
	end

	table.sort(var_12_2, var_12_1)
	table.sort(var_12_3, var_12_1)
	table.sort(var_12_4, var_12_1)
	table.insertto(self.list_, var_12_2)
	table.insertto(self.list_, var_12_3)
	table.insertto(self.list_, var_12_4)

	if #var_12_2 > 0 then
		self.clearCon_:SetSelectedState("true")
	else
		self.clearCon_:SetSelectedState("false")
	end

	self.scrollHelper_:StartScroll(#self.list_)
end

return PaChinKoEntranceView
