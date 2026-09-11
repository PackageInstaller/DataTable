local ActivityAttributeArenaView = class("ActivityAttributeArenaView", ReduxView)

function ActivityAttributeArenaView:UIName()
	return AttributeArenaTools.GetMainUIName(self.params_.activityID)
end

function ActivityAttributeArenaView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityAttributeArenaView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityAttributeArenaView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, ActivityAttributeArenaItem)
end

function ActivityAttributeArenaView:AddUIListener()
	self:AddBtnListener(nil, self.m_rewardBtn, function()
		JumpTools.OpenPageByJump("activityAttributeArenaReward", {
			task_activity_id = self.task_activity_id
		})
	end)
	self:AddBtnListener(nil, self.m_desBtn, function()
		local var_7_0 = {
			content = GetTips("ACTIVITY_ATTRIBUTE_GAME_TIP")
		}

		var_7_0.key = "ACTIVITY_ATTRIBUTE_GAME_TIP"

		JumpTools.OpenPageByJump("gameHelp", var_7_0)
	end)
	self:AddBtnListener(nil, self.m_roundBtn, function()
		JumpTools.OpenPageByJump("activityAttributeArenaRound", {
			activityID = self.activity_id
		})
	end)
end

function ActivityAttributeArenaView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityAttributeArenaView:OnEnter()
	self.activity_id = self.params_.activityID

	ActivityAttributeArenaAction.SetRead(self.activity_id)

	self.task_activity_id = AttributeArenaTools.GetTaskActivityID(self.activity_id)
	self.rank_activity_id = AttributeArenaTools.GetRankActivityID(self.activity_id)

	self:RefreshUI()
	self:RefreshTime()

	self.timer = Timer.New(function()
		self:RefreshTime()
	end, 1, -1)

	self.timer:Start()
	self:QueryRankData(1)
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, self.activity_id)))
end

function ActivityAttributeArenaView:QueryRankData(arg_12_1)
	if self.rank_activity_id == 0 then
		return
	end

	if arg_12_1 > 3 then
		return
	end

	RankAction.QueryActivityRank(self.rank_activity_id, arg_12_1, function()
		self:QueryRankData(arg_12_1 + 1)
	end, 1)
end

function ActivityAttributeArenaView:RefreshUI()
	self.arena_list_data = ActivityAttributeArenaData:GetArenaList(self.activity_id)

	self.list:StartScroll(#self.arena_list_data)
end

function ActivityAttributeArenaView:RefreshTime()
	self.m_timeLab.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(ActivityData:GetActivityData(self.activity_id).stopTime, nil, true)
	self.m_refreshTimeLab.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityRefreshTime(self.activity_id), nil, true)
end

function ActivityAttributeArenaView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, (string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, self.activity_id)))
end

function ActivityAttributeArenaView:Dispose()
	self.list:Dispose()
	ActivityAttributeArenaView.super.Dispose(self)
end

function ActivityAttributeArenaView:IndexItem(arg_18_1, arg_18_2)
	arg_18_2:SetData(self.arena_list_data[arg_18_1], self.activity_id, self.rank_activity_id)
end

function ActivityAttributeArenaView:OnActivityAttributeArenaUpdate()
	self:RefreshUI()
	self:QueryRankData(1)
end

function ActivityAttributeArenaView:OnActivityAttributeArenaReset()
	self:RefreshUI()
end

function ActivityAttributeArenaView:OnRankUpdate()
	self.list:Refresh()
end

return ActivityAttributeArenaView
