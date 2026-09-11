ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityHellaPinballGamePage = class("ActivityHellaPinballGamePage", ActivityMainBasePanel)

function ActivityHellaPinballGamePage:GetUIName()
	return "Widget/System/Activity_Hel/Activity_Hel_Main/Activity_Hel_MainUI"
end

function ActivityHellaPinballGamePage:Init()
	self.super.Init(self)

	self.preRewardList_ = LuaList.New(handler(self, self.IndexPreviewItem), self.preRewardListGo_, CommonItemView)
end

function ActivityHellaPinballGamePage:OnEnter()
	ActivityHellaPinballGamePage.super.OnEnter(self)

	self.rewardActivityID_ = PinballData:GetRewardActivityID()

	self:OnUpdateView()

	self.limitTaskGroup = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityCfg[PinballData:GetActivityID()].sub_activity_list[2])

	manager.redPoint:bindUIandKey(self.goBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
	manager.redPoint:bindUIandKey(self.limitRewardBtn_.transform, self.limitTaskGroup)
end

function ActivityHellaPinballGamePage:OnExit()
	ActivityHellaPinballGamePage.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
	manager.redPoint:unbindUIandKey(self.limitRewardBtn_.transform, self.limitTaskGroup)
end

function ActivityHellaPinballGamePage:OnTop()
	return
end

function ActivityHellaPinballGamePage:OnUpdateView()
	if ActivityCfg[self.activityID_] and ActivityCfg[self.activityID_].reward_show and ActivityCfg[self.activityID_].reward_show ~= "" then
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityCfg[self.activityID_].reward_show) do
			table.insert(var_6_0, rewardToItemTemplate({
				id = iter_6_1
			}, nil, true))
		end

		self.preRewards_ = ItemTools.SortRewardItemList(var_6_0)

		self.preRewardList_:StartScroll(#self.preRewards_)
	end
end

function ActivityHellaPinballGamePage:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)

	if arg_7_1 then
		self:UpdatePreview()
	end

	self:RefreshTimeText()
end

function ActivityHellaPinballGamePage:IndexPreviewItem(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.preRewards_[arg_8_1])
end

function ActivityHellaPinballGamePage:AddTimer()
	self:StopTimer()
	self:RefreshTimeText()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function ActivityHellaPinballGamePage:RefreshTimeText()
	local var_11_0 = ActivityData:GetActivityData(self.rewardActivityID_)

	self.rewardStartTime_ = var_11_0.startTime
	self.rewardStopTime_ = var_11_0.stopTime
	self.limitTimeTxt_.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStr2(self.rewardStopTime_))
end

function ActivityHellaPinballGamePage:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		manager.story:CheckBattleStory(5300101, manager.story.BEFORE, function()
			PinballAction.EnterPinballGameScene()
			manager.story:RemovePlayer()
			saveData("PinballGame", "firstEnter", true)
			PinballAction.UpdateStageRedPoint()
		end)
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "GOD_EATER_GAME_TIPS_1",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("PINBALLGAME_GAME_ENTRANCE_TITLE")
		})
	end)
	self:AddBtnListener(self.limitRewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/hellaPinballLimitTask", {
			activityID = self.rewardActivityID_
		})
	end)
end

function ActivityHellaPinballGamePage:Dispose()
	if self.preRewardList_ then
		self.preRewardList_:Dispose()

		self.preRewardList_ = nil
	end

	ActivityHellaPinballGamePage.super.Dispose(self)
end

return ActivityHellaPinballGamePage
