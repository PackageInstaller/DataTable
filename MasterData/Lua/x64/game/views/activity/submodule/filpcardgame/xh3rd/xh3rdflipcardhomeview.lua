ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local XH3rdFlipCardHomeView = class("XH3rdFlipCardHomeView", ActivityMainBasePanel)

function XH3rdFlipCardHomeView:GetUIName()
	return XH3rdFlipCardTool:GetHomeUI()
end

function XH3rdFlipCardHomeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function XH3rdFlipCardHomeView:InitUI()
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
end

function XH3rdFlipCardHomeView:AddUIListener()
	self:AddBtnListener(self.playBtn_, nil, function()
		if not self:IsActivityTime() then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/xH3rdFlipCardGame", {
			activityId = self.activityID_
		})

		XH3rdFlipCardAction.hasEnterGame = true

		XH3rdFlipCardAction.UpdateTokenRedPoint()
	end)
	self:AddBtnListener(self.allReceiveBtn_, nil, function()
		if not self:IsActivityTime() then
			ShowTips("TIME_OVER")

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
			key = "ACTIVITY_FLIP_CARD_EXPLAIN",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = XH3rdFlipCardTool:GetHelpTips()
		})
	end)
end

function XH3rdFlipCardHomeView:Dispose()
	self.taskUpdateHandler_ = nil

	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	XH3rdFlipCardHomeView.super.Dispose(self)
end

function XH3rdFlipCardHomeView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		FlipCardCfg[self.activityID_].cost_id
	})
	manager.windowBar:SetBarCanAdd(FlipCardCfg[self.activityID_].cost_id, true)
end

function XH3rdFlipCardHomeView:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	if arg_10_1 == true then
		self:RefreshUI()
		manager.redPoint:bindUIandKey(self.playBtnTrans_, string.format("%s_%s_challenge", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityID_))
		self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(self.playBtnTrans_, string.format("%s_%s_challenge", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityID_))
		self:RemoveAllEventListener()
	end
end

function XH3rdFlipCardHomeView:RefreshUI()
	self.taskDataList_ = TaskData2:GetActivityTaskSortList(self.taskActivityID_)

	self.scrollHelper_:StartScroll(#self.taskDataList_)
	self:RefreshReceiveBtn()
end

function XH3rdFlipCardHomeView:RefreshReceiveBtn()
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(self.taskDataList_) do
		if iter_12_1.progress >= AssignmentCfg[iter_12_1.id].need and iter_12_1.complete_flag < 1 then
			var_12_0 = 1

			break
		end
	end

	self.allReceiveController_:SetSelectedIndex(var_12_0)
end

function XH3rdFlipCardHomeView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(self.taskDataList_[arg_13_1].id, self.taskActivityID_)
end

function XH3rdFlipCardHomeView:OnExit()
	self:StopTimer()
end

function XH3rdFlipCardHomeView:UpdateData()
	self:RefreshUI()
end

return XH3rdFlipCardHomeView
