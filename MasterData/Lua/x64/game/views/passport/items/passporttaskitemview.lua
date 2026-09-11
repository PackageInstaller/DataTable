local PassportTaskItemView = class("PassportTaskItemView", ReduxView)

function PassportTaskItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PassportTaskItemView:Init()
	self:InitUI()
	self:AddUIListener()
	self:StartTimer()
end

function PassportTaskItemView:StartTimer()
	self.timer_ = self.timer_ or Timer.New(function()
		self:UpdateTimer()
	end, 1, -1)

	self.timer_:Start()
end

function PassportTaskItemView:RemoveTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function PassportTaskItemView:UpdateTimer()
	if self.taskInfo_ == nil then
		self.lastTimeLabel_.text = ""

		self.timeController_:SetSelectedState("false")

		return
	end

	local var_6_0 = self.taskInfo_.expired_timestamp or 0

	if var_6_0 > 0 then
		SetActive(self.timeGo_, true)
		self.timeController_:SetSelectedState("true")

		self.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_6_0)
	else
		SetActive(self.timeGo_, false)
		self.timeController_:SetSelectedState("false")
	end
end

function PassportTaskItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.timeController_ = ControllerUtil.GetController(self.gameObject_.transform, "time")
	self.list_ = LuaList.New(handler(self, self.indexItem), self.listGo_, CommonItemView)
end

function PassportTaskItemView:indexItem(arg_8_1, arg_8_2)
	CommonTools.SetCommonData(arg_8_2, {
		id = self.rewardList_[arg_8_1][1],
		number = self.rewardList_[arg_8_1][2],
		grayFlag = self.taskInfo_.complete_flag == 1,
		clickFun = function(self)
			ShowPopItem(POP_OTHER_ITEM, {
				self.id,
				self.number
			})
		end
	})
end

function PassportTaskItemView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.JumpToPage2(self.taskCfg_.source)
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		local var_12_1 = getData("passport_task", "tip_deadline")

		if (var_12_1 and tonumber(var_12_1) > manager.time:GetServerTime() or nil) and false and (self.taskCfg_.type == 7 or self.taskCfg_.type == 8) and PassportData:GetExpWeekly() >= GameSetting.battlepass_exp_limit_weekly.value[1] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("PASSPORT_WEEKLY_EXP_LIMIT_TIP"),
				toggleText = GetTips("WEEKLY_MUTE_TIP"),
				OkCallback = function()
					TaskAction:SubmitTask(self.taskCfg_.id)
				end,
				ToggleCallback = function(arg_14_0)
					if arg_14_0 then
						saveData("passport_task", "tip_deadline", tostring(_G.gameTimer:GetNextWeekFreshTime()))
					end
				end
			})
		else
			TaskAction:SubmitTask(self.taskCfg_.id)
		end
	end)
end

function PassportTaskItemView:SetData(arg_15_1)
	self.taskCfg_ = AssignmentCfg[arg_15_1]
	self.taskInfo_ = TaskData2:GetTask(arg_15_1)
	self.rewardList_ = self.taskCfg_.reward or {}

	self:UpdateView()
	self:UpdateTimer()
end

function PassportTaskItemView:UpdateView()
	self.list_:StartScroll(#self.rewardList_)

	self.typeLabel_.text = GetI18NText(self.taskCfg_.name)
	self.descLabel_.text = GetI18NText(self.taskCfg_.desc)

	local var_16_0 = TaskData2:GetTaskProgress(self.taskCfg_.id)

	if self.taskCfg_.need < var_16_0 then
		var_16_0 = self.taskCfg_.need
	end

	self.progressLabel_.text = string.format("%d/%d", var_16_0, self.taskCfg_.need)
	self.progressSlider_.value = var_16_0 / self.taskCfg_.need

	if self.taskInfo_.complete_flag == 1 then
		self.statusController_:SetSelectedState("haveGet")
	elseif self.taskCfg_.need <= var_16_0 then
		self.statusController_:SetSelectedState("canGet")
	else
		self.statusController_:SetSelectedState("cannotGet")
	end
end

function PassportTaskItemView:OnEnter()
	return
end

function PassportTaskItemView:OnExit()
	self:RemoveTimer()
end

function PassportTaskItemView:Dispose()
	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	self:RemoveTimer()
	PassportTaskItemView.super.Dispose(self)
end

return PassportTaskItemView
