local TangramPuzzleTaskView = class("TangramPuzzleTaskView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function TangramPuzzleTaskView:GetUIName()
	return TangramPuzzleTools.GetTaskUIName(self.activityID_)
end

function TangramPuzzleTaskView:Init()
	self:InitUI()
	self:AddUIListener()
end

function TangramPuzzleTaskView:InitUI()
	self:BindCfgUI()
	self:InitTaskActivityID()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, PuzzleNewTaskItem_Resident)
	self.taskUpdateHandler_ = handler(self, self.UpdateData)
	self.allReceiveController_ = self.allReceiveControllerEx:GetController("clear")
	self.playBtnText_.text = GetTips("TANGRAM_PUZZLE_PLAY_BTN")
end

function TangramPuzzleTaskView:InitTaskActivityID()
	for iter_4_0, iter_4_1 in ipairs(ActivityCfg[self.activityID_].sub_activity_list) do
		if ActivityCfg[iter_4_1].activity_template == ActivityTemplateConst.TASK then
			self.taskActivityID_ = iter_4_1

			break
		end
	end
end

function TangramPuzzleTaskView:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		self:Go("/tangramPuzzlePlay", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(self.taskDataList_) do
			if iter_7_1.progress < AssignmentCfg[iter_7_1.id].need or iter_7_1.complete_flag >= 1 then
				break
			end

			var_7_0[#var_7_0 + 1] = iter_7_1.id
		end

		TaskAction:SubmitTaskList(var_7_0)
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		local var_8_0 = GetTips("ACTIVITY_PUZZLE_III_EXPLAIN")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_PUZZLE_III_EXPLAIN",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = (TangramPuzzleCfg[self.activityID_] and TangramPuzzleCfg[self.activityID_].coin_id[1] and TangramPuzzleCfg[self.activityID_].coin_id[1][1] or nil) and string.format(GetTips("ACTIVITY_PUZZLE_III_EXPLAIN"), ItemTools.getItemName(TangramPuzzleCfg[self.activityID_].coin_id[1][1]))
		})
	end)

	if self.webBtn_ then
		self:AddBtnListener(self.webBtn_, nil, function()
			OperationRecorder.RecordButtonTouch(string.format("activity_%s_web_jump", self.webActivityID_))
			ActivityWebTools.OpenUrl(self.webID_)
		end)
	end

	if self.webRewardBtn_ then
		self:AddBtnListener(self.webRewardBtn_, nil, function()
			OperationRecorder.RecordButtonTouch(string.format("activity_%s_web_jump", self.webActivityID_))
			ActivityWebTools.OpenUrl(self.webID_)
		end)
	end
end

function TangramPuzzleTaskView:Dispose()
	self.taskUpdateHandler_ = nil

	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	self:StopTimer()
	TangramPuzzleTaskView.super.Dispose(self)
end

function TangramPuzzleTaskView:Show(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)

	if arg_12_1 == true then
		self:RefreshUI()
		self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	else
		self:RemoveAllEventListener()
	end
end

function TangramPuzzleTaskView:RefreshUI()
	self.taskDataList_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self:RefreshReceiveBtn()
	self.scrollHelper_:StartScroll(#self.taskDataList_)
	self:RefreshBg()
	self:RefreshTitle()
	self:RefreshWebActivity()
end

function TangramPuzzleTaskView:RefreshReceiveBtn()
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(self.taskDataList_) do
		if iter_14_1.progress >= AssignmentCfg[iter_14_1.id].need and iter_14_1.complete_flag < 1 then
			var_14_0 = 1

			break
		end
	end

	self.allReceiveController_:SetSelectedState(var_14_0 == 1 and "true" or "false")
end

function TangramPuzzleTaskView:RefreshBg()
	if TangramPuzzleCfg[self.activityID_].task_bg_path and TangramPuzzleCfg[self.activityID_].task_bg_path ~= "" then
		self.bgImg_.sprite = pureGetSpriteWithoutAtlas(TangramPuzzleCfg[self.activityID_].task_bg_path)
	end
end

function TangramPuzzleTaskView:RefreshTitle()
	self.titleText_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].name
	self.descText_.text = ActivityToggleCfg[ActivityToggleCfg.get_id_list_by_activity_id[self.activityID_][1]].desc
end

function TangramPuzzleTaskView:RefreshWebActivity()
	for iter_17_0, iter_17_1 in ipairs(ActivityCfg[self.activityID_].sub_activity_list) do
		if ActivityCfg[iter_17_1].activity_template == ActivityTemplateConst.ACTIVITY_WEB then
			self.webActivityID_ = iter_17_1
			self.webID_ = ActivityWebCfg.get_id_list_by_activity_id[self.webActivityID_][1]
		end
	end

	if not self.webActivityID_ then
		return
	end

	local var_17_0 = ActivityWebCfg[self.webID_].reward_list

	self.rewardIcon_1.sprite = ItemTools.getItemSprite(ActivityWebCfg[self.webID_].reward_list[1][1])
	self.rewardIcon_2.sprite = ItemTools.getItemSprite(var_17_0[2][1])
	self.rewardName_1.text = ItemTools.getItemName(var_17_0[1][1])
	self.rewardName_2.text = ItemTools.getItemName(var_17_0[2][1])
end

function TangramPuzzleTaskView:IndexItem(arg_18_1, arg_18_2)
	arg_18_2:SetData(self.taskDataList_[arg_18_1].id, self.taskActivityID_)
end

function TangramPuzzleTaskView:UpdateData()
	self:RefreshUI()
end

function TangramPuzzleTaskView:OnEnter()
	TangramPuzzleTaskView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.playBtnTrans_, (string.format("%s_%d", RedPointConst.TANGRAM_PUZZLE_CLUE, self.activityID_)))
end

function TangramPuzzleTaskView:OnExit()
	TangramPuzzleTaskView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.playBtnTrans_, (string.format("%s_%s", RedPointConst.TANGRAM_PUZZLE_CLUE, self.activityID_)))
end

return TangramPuzzleTaskView
