local HeroClueEnterView = class("HeroClueEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function HeroClueEnterView:GetUIName()
	return HeroClueTools.GetEnterViewUIName(self.activityID_)
end

function HeroClueEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroClueEnterView:InitUI()
	self:BindCfgUI()

	self.taskUpdateHandler_ = handler(self, self.UpdateData)
	self.taskActivityID_ = HeroClueTools.GetTaskActivityID(self.activityID_)

	self:InitController()
	self:InitTaskList()
	self:InitStaticText()
end

function HeroClueEnterView:InitController()
	self.allReceiveController_ = ControllerUtil.GetController(self.taskPanelTrans_, "clear")
end

function HeroClueEnterView:InitTaskList()
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.scrollView_, HeroClueTools.GetTaskItemClass(self.activityID_))
end

function HeroClueEnterView:InitStaticText()
	if self.titleText_ then
		self.titleText_.text = HeroClueTools.GetActivityTitle(self.activityID_)
	end

	if self.activityDescText_ then
		self.activityDescText_.text = HeroClueTools.GetActivityDesc(self.activityID_)
	end
end

function HeroClueEnterView:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		HeroClueTools.GoToClueMainView(self.activityID_)
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(self.taskDataList_) do
			if iter_9_1.progress < AssignmentCfg[iter_9_1.id].need or iter_9_1.complete_flag >= 1 then
				break
			end

			var_9_0[#var_9_0 + 1] = iter_9_1.id
		end

		TaskAction:SubmitTaskList(var_9_0)
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_HERO_CLUE_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = HeroClueTools.GetGamePlayDesc(self.activityID_)
		})
	end)
end

function HeroClueEnterView:Dispose()
	self.taskUpdateHandler_ = nil

	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	self:StopTimer()
	HeroClueEnterView.super.Dispose(self)
end

function HeroClueEnterView:Show(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)

	if arg_12_1 == true then
		self:RefreshUI()
		manager.redPoint:bindUIandKey(self.playBtn_.transform, string.format("%s_%d", RedPointConst.HERO_CLUE_PLAY, self.activityID_))
		self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(self.playBtn_.transform, string.format("%s_%s", RedPointConst.HERO_CLUE_PLAY, self.activityID_))
		self:RemoveAllEventListener()
	end
end

function HeroClueEnterView:RefreshUI()
	self.taskDataList_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self.scrollHelper_:StartScroll(#self.taskDataList_)
	self:RefreshReceiveBtn()
end

function HeroClueEnterView:RefreshReceiveBtn()
	local var_14_0 = false

	for iter_14_0, iter_14_1 in ipairs(self.taskDataList_) do
		if iter_14_1.progress >= AssignmentCfg[iter_14_1.id].need and iter_14_1.complete_flag < 1 then
			var_14_0 = true

			break
		end
	end

	self.allReceiveController_:SetSelectedState(tostring(var_14_0))
	self.scrollHelper_:StartScroll(#self.taskDataList_)
end

function HeroClueEnterView:IndexItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(self.taskDataList_[arg_15_1].id, self.taskActivityID_)
end

function HeroClueEnterView:UpdateData()
	self:RefreshUI()
	HeroClueAction.UpdateDrawRedPoint(self.activityID_)
end

function HeroClueEnterView:RefreshTimeText()
	if self.timeText_ then
		self.timeText_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(self.stopTime_, true)
	end
end

return HeroClueEnterView
