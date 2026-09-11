ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local IChiBanEnterView = class("IChiBanEnterView", ActivityMainBasePanel)

function IChiBanEnterView:GetUIName()
	return IchiBanTools.GetEntraceUIName(self.activityID_)
end

function IChiBanEnterView:Init()
	IChiBanEnterView.super.Init(self)

	self.clearCon_ = self.stateCon_:GetController("clear")
	self.lockCon_ = self.stateCon_:GetController("lock")
	self.unlockCon_ = self.stateCon_:GetController("unlock")
	self.closeCon_ = self.stateCon_:GetController("close")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, IchiBanEnterItem)

	self:BindHelpBtn(IchiBanTools.GetDesc(self.activityID_))

	self.refreshTaskHandler_ = handler(self, self.RefreshTask)
end

function IChiBanEnterView:OnEnter()
	IChiBanEnterView.super.OnEnter(self)
	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.refreshTaskHandler_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.refreshTaskHandler_)
	self:RefreshTask()
	self:RefreshPaint()
	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_ICHIBAN .. "_" .. self.activityID_)
end

function IChiBanEnterView:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, self.refreshTaskHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.refreshTaskHandler_)
	IChiBanEnterView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_ICHIBAN .. "_" .. self.activityID_)
end

function IChiBanEnterView:Dispose()
	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	IChiBanEnterView.super.Dispose(self)
end

function IChiBanEnterView:AddListeners()
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
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/iChiBanMain", {
			mainActivityID = self.activityID_
		})
	end)
end

function IChiBanEnterView:Show(arg_9_1)
	IChiBanEnterView.super.Show(self, arg_9_1)

	if arg_9_1 then
		self:RefreshTask()
	end
end

function IChiBanEnterView:UpdateBar()
	local var_10_0 = IchiBanTools.GetCurrencyID(self.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		var_10_0
	})
	manager.windowBar:SetBarCanClick(var_10_0, true)
end

function IChiBanEnterView:IndexItem(arg_11_1, arg_11_2)
	arg_11_2:Refresh(self.list_[arg_11_1], self.activityID_)
end

function IChiBanEnterView:RefreshTask()
	local var_12_0 = IchiBanTools.GetTaskActivityID(self.activityID_)

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

function IChiBanEnterView:RefreshPaint()
	local var_14_0 = IchiBanTools.GetCfg(self.activityID_)

	self.uiCharacterImage_.sprite = IchiBanTools.GetUnRaffleCnt(self.activityID_) == 0 and pureGetSpriteWithoutAtlas(var_14_0.character_icon_entrance) or pureGetSpriteWithoutAtlas(var_14_0.character_shadow_icon_entrance)
end

return IChiBanEnterView
