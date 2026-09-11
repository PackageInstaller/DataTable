local ActivityHeroLetterMainView = class("ActivityHeroLetterMainView", ReduxView)

function ActivityHeroLetterMainView:UIName()
	return ActivityHeroLetterTools.GetMainUIName(self.params_.activityID)
end

function ActivityHeroLetterMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityHeroLetterMainView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityHeroLetterMainView:InitUI()
	self:BindCfgUI()

	self.rewardCon_ = self.conCollecter_:GetController("reward")
	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityHeroLetterItem)
end

function ActivityHeroLetterMainView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:Refresh(self.list_[arg_5_1])
	self:RefreshRewardType()
	self:RefreshItemTime()
end

function ActivityHeroLetterMainView:AddUIListeners()
	self:AddBtnListener(self.playBackBtn_, nil, function()
		self:GotoView()
	end)
end

function ActivityHeroLetterMainView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:BindRedPointUI()
	self:CheckEnter()
	self:RefreshUI()
end

function ActivityHeroLetterMainView:CheckEnter()
	if ActivityHeroLetterData:GetActivityUrl() == ActivityConst.ACTIVITY_2_10_HERO_LETTER_H5_WEB then
		local var_9_2 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_10_HERO_LETTER_H5_WEB).stopTime
		local var_9_3 = ActivityHeroLetterData:GetSign(ActivityConst.ACTIVITY_2_10_HERO_LETTER_H5_WEB)

		SetActive(self.playBackBtn_.gameObject, ActivityData:GetActivityData(ActivityConst.ACTIVITY_2_10_HERO_LETTER_H5_WEB).stopTime > manager.time:GetServerTime())

		if var_9_2 > manager.time:GetServerTime() and var_9_3 == 0 then
			self:GotoView()
			ActivityHeroLetterAction.SetSign(ActivityConst.ACTIVITY_2_10_HERO_LETTER_H5_WEB)
		end
	else
		local var_9_4 = getData("activityHeroLetter", "enter_" .. self.activityID_)

		if not var_9_4 or var_9_4 == 0 then
			self:GotoView()
			saveData("activityHeroLetter", "enter_" .. self.activityID_, 1)
		end
	end
end

function ActivityHeroLetterMainView:RefreshUI()
	self:RefreshData()
	self:RefreshTime()
	self:RefreshList()
end

function ActivityHeroLetterMainView:RefreshData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ActivityHeroLetterMainView:RefreshTime()
	self:StopTimer()

	self.timeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_)
	self.timer_ = Timer.New(function()
		self.timeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityHeroLetterMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityHeroLetterMainView:RefreshList()
	self.list_ = ActivityHeroTaskCfg.get_id_list_by_main_activity_id[self.activityID_]

	if self.params_.isEnter then
		self.scrollHelper_:StartScroll(#self.list_)

		self.params_.isEnter = false
	else
		self.scrollHelper_:Refresh()
	end

	self:StopItemTimer()
	self:RefreshItemTime()

	self.itemTimer_ = Timer.New(function()
		self:RefreshItemTime()
	end, 1, -1)

	self.itemTimer_:Start()
end

function ActivityHeroLetterMainView:StopItemTimer()
	if self.itemTimer_ then
		self.itemTimer_:Stop()

		self.itemTimer_ = nil
	end
end

function ActivityHeroLetterMainView:RefreshItemTime()
	local var_18_0 = manager.time:GetServerTime()

	for iter_18_0, iter_18_1 in pairs(self.scrollHelper_:GetItemList()) do
		iter_18_1:RefreshTime(var_18_0)
	end
end

function ActivityHeroLetterMainView:GotoView()
	JumpTools.OpenPageByJump("activityHeroLetterPlayBack", {
		activityID = self.activityID_
	})
end

function ActivityHeroLetterMainView:RefreshRewardType()
	local var_20_0 = self.scrollHelper_:GetItemList() or {}

	if not var_20_0[#var_20_0] then
		return
	end

	for iter_20_0 = table.indexof(self.list_, var_20_0[#var_20_0].id_) + 1, #self.list_ do
		local var_20_1 = TaskData2:GetTask(ActivityHeroTaskCfg[self.list_[iter_20_0]].task_id)

		if ActivityData:GetActivityData(ActivityHeroTaskCfg[self.list_[iter_20_0]].activity_id):IsActivitying() and var_20_1 and var_20_1.complete_flag == 0 and AssignmentCfg[ActivityHeroTaskCfg[self.list_[iter_20_0]].task_id].need <= var_20_1.progress then
			self.rewardCon_:SetSelectedState("on")

			return
		end
	end

	self.rewardCon_:SetSelectedState("off")
end

function ActivityHeroLetterMainView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.playBackBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. self.activityID_)
end

function ActivityHeroLetterMainView:UnbindRedPointUI()
	manager.redPoint:unbindUIandKey(self.playBackBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. self.activityID_)
end

function ActivityHeroLetterMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityHeroLetterMainView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:StopItemTimer()
	self:UnbindRedPointUI()
	self:RemoveAllEventListener()
end

function ActivityHeroLetterMainView:Dispose()
	self:RemoveAllListeners()

	for iter_25_0, iter_25_1 in ipairs(self.scrollHelper_:GetItemList()) do
		iter_25_1:Dispose()
	end

	self.scrollHelper_:Dispose()
	self.super.Dispose(self)
end

return ActivityHeroLetterMainView
