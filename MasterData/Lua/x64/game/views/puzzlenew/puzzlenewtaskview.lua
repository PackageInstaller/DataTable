local PuzzleNewTaskView = class("PuzzleNewTaskView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function PuzzleNewTaskView:GetUIName()
	return PuzzleNewTools.GetTaskUIName(self.activityID_)
end

function PuzzleNewTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PuzzleNewTaskView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, PuzzleNewTaskItem)
	self.taskUpdateHandler_ = handler(self, self.UpdateData)
	self.allReceiveController_ = ControllerUtil.GetController(self.transform_, "allReceive")

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

function PuzzleNewTaskView:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		PuzzleNewData:SetPlayBtnSelected(self.activityID_)
		self:Go("/puzzleNewPlay", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(self.taskDataList_) do
			if iter_6_1.progress < AssignmentCfg[iter_6_1.id].need or iter_6_1.complete_flag >= 1 then
				break
			end

			var_6_0[#var_6_0 + 1] = iter_6_1.id
		end

		TaskAction:SubmitTaskList(var_6_0)
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

function PuzzleNewTaskView:Dispose()
	self.taskUpdateHandler_ = nil

	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	self:StopTimer()
	PuzzleNewTaskView.super.Dispose(self)
end

function PuzzleNewTaskView:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)

	if arg_9_1 == true then
		self:RefreshUI()
		manager.redPoint:bindUIandKey(self.playBtnTrans_, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PLAY, self.activityID_))
		self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(self.playBtnTrans_, string.format("%s_%s", RedPointConst.PUZZLE_NEW_PLAY, self.activityID_))
		self:RemoveAllEventListener()
	end
end

function PuzzleNewTaskView:RefreshUI()
	self.taskDataList_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self.scrollHelper_:StartScroll(#self.taskDataList_)
	self:RefreshReceiveBtn()
end

function PuzzleNewTaskView:RefreshReceiveBtn()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(self.taskDataList_) do
		if iter_11_1.progress >= AssignmentCfg[iter_11_1.id].need and iter_11_1.complete_flag < 1 then
			var_11_0 = 1

			break
		end
	end

	self.allReceiveController_:SetSelectedIndex(var_11_0)
end

function PuzzleNewTaskView:IndexItem(arg_12_1, arg_12_2)
	arg_12_2:SetData(self.taskDataList_[arg_12_1].id, self.taskActivityID_)
end

function PuzzleNewTaskView:UpdateData()
	self:RefreshUI()
	PuzzleNewData:RefreshPieceRedPoint(self.activityID_)
end

function PuzzleNewTaskView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
	end
end

return PuzzleNewTaskView
