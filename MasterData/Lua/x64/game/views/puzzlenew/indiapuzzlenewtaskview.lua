local IndiaPuzzleNewTaskView = class("IndiaPuzzleNewTaskView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function IndiaPuzzleNewTaskView:GetUIName()
	return PuzzleNewTools.GetTaskUIName(self.activityID_)
end

function IndiaPuzzleNewTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IndiaPuzzleNewTaskView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, PuzzleNewTools.GetTaskItemClass(self.activityID_))
	self.taskUpdateHandler_ = handler(self, self.UpdateData)

	self:InitController()

	for iter_3_0, iter_3_1 in ipairs(ActivityCfg[self.activityID_].sub_activity_list) do
		if ActivityCfg[iter_3_1].activity_template == ActivityTemplateConst.TASK then
			self.taskActivityID_ = iter_3_1

			break
		end
	end

	if self.taskActivityID_ == nil then
		self.taskActivityID_ = 170045
	end
end

function IndiaPuzzleNewTaskView:InitController()
	self.allReceiveController_ = ControllerUtil.GetController(self.listPanelTrans_, "clear")
end

function IndiaPuzzleNewTaskView:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		PuzzleNewData:SetPlayBtnSelected(self.activityID_)
		self:Go("/puzzleNewPlay", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		local var_7_0, var_7_1 = self:CheckAdvanceOpenTime()

		if var_7_0 then
			ShowTips(var_7_1)
		end
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(self.taskDataList_) do
			if iter_8_1.progress < AssignmentCfg[iter_8_1.id].need or iter_8_1.complete_flag >= 1 then
				break
			end

			var_8_0[#var_8_0 + 1] = iter_8_1.id
		end

		TaskAction:SubmitTaskList(var_8_0)
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_XUHENG_PUZZLE_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_XUHENG_PUZZLE_DESCRIBE")
		})
	end)
end

function IndiaPuzzleNewTaskView:Dispose()
	self.taskUpdateHandler_ = nil

	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	self:StopTimer()
	IndiaPuzzleNewTaskView.super.Dispose(self)
end

function IndiaPuzzleNewTaskView:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)

	if arg_11_1 == true then
		self:RefreshUI()
		manager.redPoint:bindUIandKey(self.playBtnTrans_, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PLAY, self.activityID_))
		self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(self.playBtnTrans_, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PLAY, self.activityID_))
		self:RemoveAllEventListener()
	end
end

function IndiaPuzzleNewTaskView:RefreshUI()
	self.taskDataList_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self:RefreshReceiveBtn()
	self.scrollHelper_:StartScroll(#self.taskDataList_)
end

function IndiaPuzzleNewTaskView:RefreshReceiveBtn()
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(self.taskDataList_) do
		if iter_13_1.progress >= AssignmentCfg[iter_13_1.id].need and iter_13_1.complete_flag < 1 then
			var_13_0 = 1

			break
		end
	end

	self.allReceiveController_:SetSelectedState(var_13_0 == 1 and "true" or "false")
end

function IndiaPuzzleNewTaskView:IndexItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(self.taskDataList_[arg_14_1].id, self.taskActivityID_)
end

function IndiaPuzzleNewTaskView:UpdateData()
	self:RefreshUI()
	PuzzleNewData:RefreshPieceRedPoint(self.activityID_)
end

return IndiaPuzzleNewTaskView
